package com.suteam.html.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

/*******************************************************************************
 * 解析Excel
 * 
 * @author Administrator
 * 
 */
public class Analysis {
	public static List<String[]> readInExcel(String path) {
		String[] strings= path.split(">");
		if(strings.length==1){
			path=strings[0];
		}else{
			path=strings[1];
		}
		Workbook rwb = null;
		List<String[]> lists = null;
		try {
			// 构建Workbook对象只读Workbook对象
			// 直接从本地文件创建Workbook
			// 从输入流创建Workbook
			InputStream is = new FileInputStream(path);
			rwb = Workbook.getWorkbook(is);
			// Sheet(术语：工作表)就是Excel表格左下角的Sheet1,Sheet2,Sheet3但在程序中
			// Sheet的下标是从0开始的
			// 获取第一张Sheet表
			Sheet rs = rwb.getSheet(0);
			// 获取Sheet表中所包含的总列数
			int rsColumns = rs.getColumns();
			// 获取Sheet表中所包含的总行数
			int rsRows = rs.getRows();
			lists = new ArrayList<String[]>();
			// 获取指这下单元格的对象引用
			for (int i = 0; i < rsRows; i++) {
				String[] strs = new String[rsColumns];
				for (int j = 0; j < rsColumns; j++) {
					Cell cell = rs.getCell(j, i);
					strs[j] = cell.getContents();
				}
				lists.add(strs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 操作完成时，关闭对象，翻译占用的内存空间
			rwb.close();
		}
		return lists;
	}

	public static void outputExcel(List<String[]> lists, String name) {
		try {
			// 创建一个新的excel
			WritableWorkbook wwb = Workbook.createWorkbook(new File(name));
			// 读取第一张工作表
			WritableSheet ws = wwb.createSheet("sheet0", 0);
			for (int i = 0; i < lists.size(); i++) {
				String[] strs = lists.get(i);
				for (int j = 0; j < strs.length; j++) {
					// 获取单元格对象
					Label label = new Label(j, i+1, strs[j]);
					ws.addCell(label);
				}
			}
			// 写入Excel对象
			wwb.write();
			wwb.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		List<String[]> s=readInExcel("C:\\Users\\zsyun_Fangqingzhu\\Desktop\\1.xls");
		System.out.println(s.size());
		for(int i=3;i<s.size();i++){
			String[] str=s.get(i);
			System.out.println("分公司："+str[0]+";商店代码："+str[1]+";商店简称："+str[2]+";省："+str[3]+";市："+str[4]);
		}
	}
}
