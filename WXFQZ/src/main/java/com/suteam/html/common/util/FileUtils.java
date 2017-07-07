package com.suteam.html.common.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringWriter;
import java.security.MessageDigest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.jdom.Document;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.context.support.XmlWebApplicationContext;

import com.suteam.html.system.service.SystemConfigMgr;

public class FileUtils {
	private static Logger logger = LoggerFactory.getLogger(FileUtils.class);
	private static SystemConfigMgr systemConfigMgr;

	public static void write(String path, String content) throws IOException {
		String s = new String();
		String s1 = new String();
		File f = new File(path);
		if (!f.exists()) {
			if (f.createNewFile()) {
				logger.info("文件创建成功！");
			} else {
				logger.info("文件创建失败！");
			}
		}
		BufferedReader input = new BufferedReader(new FileReader(f));

		while ((s = input.readLine()) != null) {
			s1 += s + "\n";
		}
		input.close();
		s1 += content;

		BufferedWriter output = new BufferedWriter(new FileWriter(f));
		output.write(s1);
		output.close();
	}



	/**
	 * 缓存区大小默认20480
	 */
	private final static int FILE_BUFFER_SIZE = 20480;

	/**
	 * 将指定目录的ZIP压缩文件解压到指定的目录
	 * 
	 * @param zipFilePath
	 *            ZIP压缩文件的路径
	 * @param zipFileName
	 *            ZIP压缩文件名字
	 * @param targetFileDir
	 *            ZIP压缩文件要解压到的目录
	 * @return flag 布尔返回值
	 */
	public static boolean unzip(String zipFilePath, String zipFileName,
			String targetFileDir) {
		boolean flag = false;
		// 1.判断压缩文件是否存在，以及里面的内容是否为空
		File file = null; // 压缩文件(带路径)
		ZipFile zipFile = null;
		file = new File(zipFilePath + "/" + zipFileName);
		System.out.println(">>>>>>解压文件【" + zipFilePath + "/" + zipFileName
				+ "】到【" + targetFileDir + "】目录下<<<<<<");
		if (false == file.exists()) {
			System.out.println(">>>>>>压缩文件【" + zipFilePath + "/" + zipFileName
					+ "】不存在<<<<<<");
			return false;
		} else if (0 == file.length()) {
			System.out.println(">>>>>>压缩文件【" + zipFilePath + "/" + zipFileName
					+ "】大小为0不需要解压<<<<<<");
			return false;
		} else {
			// 2.开始解压ZIP压缩文件的处理
			byte[] buf = new byte[FILE_BUFFER_SIZE];
			int readSize = -1;
			ZipInputStream zis = null;
			FileOutputStream fos = null;
			try {
				// 检查是否是zip文件
				zipFile = new ZipFile(file);
				zipFile.close();
				// 判断目标目录是否存在，不存在则创建
				File newdir = new File(targetFileDir);
				if (false == newdir.exists()) {
					newdir.mkdirs();
					newdir = null;
				}
				zis = new ZipInputStream(new FileInputStream(file));
				ZipEntry zipEntry = zis.getNextEntry();
				// 开始对压缩包内文件进行处理
				while (null != zipEntry) {
					String zipEntryName = zipEntry.getName().replace('\\', '/');
					// 判断zipEntry是否为目录，如果是，则创建
					if (zipEntry.isDirectory()) {
						int indexNumber = zipEntryName.lastIndexOf('/');
						File entryDirs = new File(targetFileDir + "/"
								+ zipEntryName.substring(0, indexNumber));
						entryDirs.mkdirs();
						entryDirs = null;
					} else {
						try {
							fos = new FileOutputStream(targetFileDir + "/"
									+ zipEntryName);
							while ((readSize = zis.read(buf, 0,
									FILE_BUFFER_SIZE)) != -1) {
								fos.write(buf, 0, readSize);
							}
						} catch (Exception e) {
							e.printStackTrace();
							throw new RuntimeException(e.getCause());
						} finally {
							try {
								if (null != fos) {
									fos.close();
								}
							} catch (IOException e) {
								e.printStackTrace();
								throw new RuntimeException(e.getCause());
							}
						}
					}
					zipEntry = zis.getNextEntry();
				}
				flag = true;
			} catch (ZipException e) {
				e.printStackTrace();
				throw new RuntimeException(e.getCause());
			} catch (IOException e) {
				e.printStackTrace();
				throw new RuntimeException(e.getCause());
			} finally {
				try {
					if (null != zis) {
						zis.close();
					}
					if (null != fos) {
						fos.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
					throw new RuntimeException(e.getCause());
				}
			}
		}
		return flag;
	}
	/**
	 * 将指定目录的ZIP压缩文件解压到指定的目录
	 * 
	 * @param zipFilePath
	 *            ZIP压缩文件的路径
	 * @param zipFileName
	 *            ZIP压缩文件名字
	 * @param targetFileDir
	 *            ZIP压缩文件要解压到的目录
	 * @return String 
	 */
	public static String unzipFile(String zipFilePath, String zipFileName,
			String targetFileDir) {
		String zipEntryName = null;
		boolean flag = false;
		// 1.判断压缩文件是否存在，以及里面的内容是否为空
		File file = null; // 压缩文件(带路径)
		ZipFile zipFile = null;
		file = new File(zipFilePath + "/" + zipFileName);
		System.out.println(">>>>>>解压文件【" + zipFilePath + "/" + zipFileName
				+ "】到【" + targetFileDir + "】目录下<<<<<<");
		if (false == file.exists()) {
			System.out.println(">>>>>>压缩文件【" + zipFilePath + "/" + zipFileName
					+ "】不存在<<<<<<");
			flag=false;
		} else if (0 == file.length()) {
			System.out.println(">>>>>>压缩文件【" + zipFilePath + "/" + zipFileName
					+ "】大小为0不需要解压<<<<<<");
			flag=false;
		} else {
			// 2.开始解压ZIP压缩文件的处理
			byte[] buf = new byte[FILE_BUFFER_SIZE];
			int readSize = -1;
			ZipInputStream zis = null;
			FileOutputStream fos = null;
			try {
				// 检查是否是zip文件
				zipFile = new ZipFile(file);
				zipFile.close();
				// 判断目标目录是否存在，不存在则创建
				File newdir = new File(targetFileDir);
				if (false == newdir.exists()) {
					newdir.mkdirs();
					newdir = null;
				}
				zis = new ZipInputStream(new FileInputStream(file));
				ZipEntry zipEntry = zis.getNextEntry();
				// 开始对压缩包内文件进行处理
				while (null != zipEntry) {
					zipEntryName = zipEntry.getName().replace('\\', '/');
					// 判断zipEntry是否为目录，如果是，则创建
					if (zipEntry.isDirectory()) {
						int indexNumber = zipEntryName.lastIndexOf('/');
						File entryDirs = new File(targetFileDir + "/"
								+ zipEntryName.substring(0, indexNumber));
						entryDirs.mkdirs();
						entryDirs = null;
					} else {
						try {
							fos = new FileOutputStream(targetFileDir + "/"
									+ zipEntryName);
							while ((readSize = zis.read(buf, 0,
									FILE_BUFFER_SIZE)) != -1) {
								fos.write(buf, 0, readSize);
							}
						} catch (Exception e) {
							e.printStackTrace();
							throw new RuntimeException(e.getCause());
						} finally {
							try {
								if (null != fos) {
									fos.close();
								}
							} catch (IOException e) {
								e.printStackTrace();
								throw new RuntimeException(e.getCause());
							}
						}
					}
					zipEntry = zis.getNextEntry();
				}
				flag = true;
			} catch (ZipException e) {
				e.printStackTrace();
				throw new RuntimeException(e.getCause());
			} catch (IOException e) {
				e.printStackTrace();
				throw new RuntimeException(e.getCause());
			} finally {
				try {
					if (null != zis) {
						zis.close();
					}
					if (null != fos) {
						fos.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
					throw new RuntimeException(e.getCause());
				}
			}
		}
		return targetFileDir+"#"+zipEntryName;
	}

	/**
	 * 根据路径将xml文件转换成字符串
	 * 
	 * @param path
	 * @return
	 */
	public static String xmlToString(String path) {
		SAXBuilder reader = new SAXBuilder();
		Document document = null;
		StringWriter out = null; // 输出对象
		String sReturn = ""; // 输出字符串
		try {
			document = reader.build(new File(path));
			Format format = Format.getPrettyFormat();
			format.setEncoding("UTF-8");// 设置编码格式
			XMLOutputter outputter = new XMLOutputter();
			out = new StringWriter();
			outputter.output(document, out);
			sReturn = out.toString();
		} catch (Exception e) {
			// xml转换字符串失败
			return "000025";
		}
		return sReturn;
	}

	/**
	 * 根据绝对路径删除文件
	 * 
	 * @param path
	 * @return
	 */
	public static boolean deleteFile(String path) {
		File file = new File(path);
		boolean b = false;
		try {
			if (file.exists()) {
				b = file.delete();
			}
		} catch (Exception e) {
			return b;
		}
		return b;
	}

	/**
	 * 读取excel返回数据集合
	 * 
	 * @param path
	 * @return
	 */
//	public static List<String[]> readInExcel(String path) {
//		String[] strings = path.split(">");
//		if (strings.length == 1) {
//			path = strings[0];
//		} else {
//			path = strings[1];
//		}
//		Workbook rwb = null;
//		List<String[]> lists = null;
//		try {
//			// 构建Workbook对象只读Workbook对象
//			// 直接从本地文件创建Workbook
//			// 从输入流创建Workbook
//			InputStream is = new FileInputStream(path);
//			rwb = Workbook.getWorkbook(is);
//			// Sheet(术语：工作表)就是Excel表格左下角的Sheet1,Sheet2,Sheet3但在程序中
//			// Sheet的下标是从0开始的
//			// 获取第一张Sheet表
//			Sheet rs = rwb.getSheet(0);
//			// 获取Sheet表中所包含的总列数
//			int rsColumns = rs.getColumns();
//			// 获取Sheet表中所包含的总行数
//			int rsRows = rs.getRows();
//			lists = new ArrayList<String[]>();
//			// 获取指这下单元格的对象引用
//			for (int i = 0; i < rsRows; i++) {
//				String[] strs = new String[rsColumns];
//				for (int j = 0; j < rsColumns; j++) {
//					Cell cell = rs.getCell(j, i);
//					CellType iString = cell.getType();
//					if ("Date".equals(iString.toString())) {
//						Date date = DateUtils.parseDate("M/d/yy H:mm", cell
//								.getContents());
//						if (date == null) {
//							strs[j] = cell.getContents();
//						} else {
//							strs[j] = DateUtils.formatDatetime(date);
//						}
//					} else {
//						strs[j] = cell.getContents();
//					}
//				}
//				lists.add(strs);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			// 操作完成时，关闭对象，翻译占用的内存空间
//			rwb.close();
//		}
//		return lists;
//	}
	/**
	 * 支持多文件上传
	 *用流的形式上传文件   
	 *@author yhx 
	 *@return map ("result") 等于 "true" 上传文件成功
	 * 
	 */
	public static Map<String, String> uploadFile(HttpServletRequest request,String path){
		Map<String, String> map = new HashMap<String, String>();
		String resultStr = null;
		try {
			DiskFileItemFactory df = new DiskFileItemFactory();
			ServletFileUpload sfu = new ServletFileUpload(df);
			List<FileItem> list=sfu.parseRequest(request);
			if(null!=list&&list.size()>0){
				for(int i=0;i<list.size();i++){
					if(list.get(i).isFormField()){//普通表单项
						map.put(list.get(i).getFieldName(), list.get(i).getString());
					}else{
						if(null!=list.get(i)&&list.get(i).getSize()>0){
							resultStr = "false";
							InputStream is = list.get(i).getInputStream();
							File file = new File(path,list.get(i).getName());
							OutputStream os = new FileOutputStream(file);
							byte[] buffer = new byte[1024];
							int len=0;
							while((len=is.read(buffer))!=-1){
								os.write(buffer, 0, len);
							}
							os.close();
							is.close();
							list.get(i).write(new File(path,list.get(i).getName()));
							resultStr = "true";
						}
					}
				}
				map.put("result", resultStr);
				return map;
			}
			return null;
		}catch (Exception e) {
			//e.printStackTrace();
			map.put("result", "false");
			return null;
		}
	}
	
	/**
	 * 文件上传(改文件名为时间戳)
	 * 页面返回值接取(map.get("key"); key="页面name")
	 * 返回上传文件名接取(map.get("key"); key=file + num; eg:file1)
	 * 
	 * @author yhx (原创)
	 * @author zyz (改写)
	 * @param request
	 * @param path				: 给定路径
	 * @param Object...objects	: 可变路径
	 * @return	: 新生成时间戳文件名
	 */
	public static Map<String, String> uploadTimeNameFile(HttpServletRequest request,String path, String userName, Object...objects){
		Map<String, String> map = new HashMap<String, String>();
		String resultStr = null;
		int count = 0;
		try {
			DiskFileItemFactory df = new DiskFileItemFactory();
			ServletFileUpload sfu = new ServletFileUpload(df);
			List<FileItem> list=sfu.parseRequest(request);
			//List<String> keyList = new ArrayList<String>();
			String variablePath = "";
			
			
			if(null!=list&&list.size()>0){
				
				for(int i=0;i<list.size();i++){
					
					if(list.get(i).isFormField()){//普通表单项
						// 解决乱码
						String str = new String(list.get(i).getString().getBytes("iso8859-1"), "UTF-8");
						map.put(list.get(i).getFieldName(), str);
					}else{
						
						if(null!=list.get(i)&&list.get(i).getSize()>0){
							for (int j = 0; j < objects.length; j++) {
								String key = objects[j].toString();
								if (null != key && !("").equals(key)) {
									variablePath = map.get(key) + "\\";
									path = path + variablePath;
								}
							}
							// 添加当前登录人邮箱的文件夹
							path = path + userName + "\\";
							
							count ++;
							resultStr = "false";
							InputStream is = list.get(i).getInputStream();
							
							// 文件重命名
							String oldName = list.get(i).getName();
							String[] strs = oldName.split("\\."); // 获取文件后缀
							String newName = new Date().getTime() + "." + strs[strs.length - 1];
							
							// 判断路径为根路径末位是否有"/"。
							int x = path.length() - 1;
							String str = "/";
							String strp = path.charAt(x) + "";
							if (!(str.equals(strp))) {
								path += "\\";
							}
							
							// 判断路径(无,则创建)
							File filePath = new File(path);
							if (!filePath.exists() && !filePath.isDirectory()) {// 如果文件夹不存在则创建
								filePath.mkdirs();
							}
							
							// 输出文件
							File file = new File(path,newName);
							OutputStream os = new FileOutputStream(file);
							byte[] buffer = new byte[1024];
							int len=0;
							while((len=is.read(buffer))!=-1){
								os.write(buffer, 0, len);
							}
							os.close();
							is.close();
							list.get(i).write(new File(path,newName));
							resultStr = "true";
							
							// 返回新文件名
							map.put("file" + count, newName);
						}
					}
				}
				map.put("result", resultStr);
				return map;
			}
			return null;
		}catch (Exception e) {
			e.printStackTrace();
			map.put("result", "false");
			return null;
		}
	}
	/**
	 * 文件路径生成工具(无项目名称)
	 * 
	 * @author zyz
	 * @param req
	 * @param filePath	: 文件存放所需的文件夹
	 * @return	: 文件存放路径
	 */
	public static String filePath(HttpServletRequest req, String[] filePath){
		String requsetPath = req.getSession().getServletContext().getRealPath("/");
		System.out.println(requsetPath);
		String projectName = req.getContextPath();
		String realPath = requsetPath;
		if (null != projectName && !(("").equals(projectName))) {
			projectName = projectName.replace("\\", "");
			projectName = projectName.replace("/", "");
			realPath = requsetPath.replace(projectName, "");
		}
		if (realPath.contains("ROOT")) {
			realPath = realPath.substring(0, realPath.indexOf("ROOT"));
		}
		for (int i = 0; i < filePath.length; i++) {
			realPath += "\\" + filePath[i];
		}
		// 生成所需文件夹
		File file = new File(realPath);
		if (!file.exists() && !file.isDirectory()) {// 如果文件夹不存在则创建
			file.mkdirs();
		}
		realPath += "\\";
		return realPath;
	}

	/**
	 * 调用远程服务器 给文件做hash
	 * 
	 * @param path
	 * @return hash
	 */
	public static String getURLConFileHash(String rootPath, String path) {
		try {
			path = path.replace("\\", "/");
			String cmd = ("md5sum " + rootPath + path);
			Process ps = Runtime.getRuntime().exec(cmd);
			BufferedReader br = new BufferedReader(new InputStreamReader(ps.getInputStream()));
			StringBuffer sb = new StringBuffer();
			String line;
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			br.close();
			String hash = sb.toString();
			System.out.println("文件hash：" + hash);
			return hash;

		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	public static byte[] createChecksum(String filename) throws Exception {
		InputStream fis = new FileInputStream(filename);// 20px;">将流类型字符串转换为String类型字符串</span>

		byte[] buffer = new byte[1024];
		MessageDigest complete = MessageDigest.getInstance("MD5"); // 如果想使用SHA-1或SHA-256，则传入SHA-1,SHA-256
		int numRead;

		do {
			numRead = fis.read(buffer); // 从文件读到buffer，最多装满buffer
			if (numRead > 0) {
				complete.update(buffer, 0, numRead); // 用读到的字节进行MD5的计算，第二个参数是偏移量
			}
		} while (numRead != -1);

		fis.close();
		return complete.digest();
	}

	public static String getMD5Checksum(String filename) throws Exception {
		try {
			byte[] b = createChecksum(filename);
			String result = "";

			for (int i = 0; i < b.length; i++) {
				result += Integer.toString((b[i] & 0xff) + 0x100, 16).substring(1);// 加0x100是因为有的b[i]的十六进制只有1位
			}
			return result;
		} catch (Exception e) {
			return "";
		}
	}
}
