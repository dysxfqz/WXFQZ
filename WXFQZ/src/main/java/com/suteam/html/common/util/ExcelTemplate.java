package com.suteam.html.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.RichTextString;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * Excel操纵类，可以根据Excel模板来生成Excel报表
 * 
 * @company suteam
 * @author liubin
 * @since Oct 12, 2009
 * @version 1.0
 */
public class ExcelTemplate {

	private static Log logger = LogFactory.getLog(ExcelTemplate.class);

	public static final String STYLE_1 = "STYLE_1";
	public static final String STYLE_2 = "STYLE_2";

	private Workbook workbook;
	private List<ExcelSheetHolder> sheetHolders = new ArrayList<ExcelSheetHolder>();
	private ExcelSheetHolder currentSheet;
	private int currentSheetIndex;

	/**
	 * 指定模板创建ExcelTemplate对象
	 * 
	 * @param templates
	 *            模板名称
	 */
	public ExcelTemplate(String templates) {
		InputStream inputstream = null;
		try {

			inputstream = new FileInputStream(new File(templates));
			workbook = new XSSFWorkbook(inputstream);
			System.out.println(workbook.getNumberOfSheets());
			for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
				ExcelSheetHolder sheetHolder = new ExcelSheetHolder(workbook.getSheetAt(i));
				sheetHolder.init();
				sheetHolders.add(sheetHolder);
			}

			if (!sheetHolders.isEmpty()) {
				currentSheet = sheetHolders.get(0);
			}
		} catch (Exception e) {
			logger.error("创建Excel对象出现异常", e);
			throw new RuntimeException("创建Excel对象出现异常");
		}
	}

	/**
	 * 设置特定的单元格样式，此样式可以通过在模板文件中定义"#STYLE_XX"来得到，如： #STYLE_1，传入的参数就是"STYLE_1"
	 * 
	 * @param style
	 */
	public ExcelTemplate setCellStyle(String style) {
		this.currentSheet.setCellStyle(style);
		return this;
	}

	/**
	 * 取消特定的单元格格式，恢复默认的配置值，即DATAS所在行的值
	 */
	public ExcelTemplate setCellDefaultStyle() {
		this.currentSheet.setCellDefaultStyle();
		return this;
	}

	/**
	 * 创建新行
	 * 
	 * @param index
	 *            从0开始计数
	 */
	public ExcelTemplate createRow(int index) {
		this.currentSheet.createRow(index);
		return this;
	}

	/**
	 * 根据传入的日期值，在当前行上创建新列 在这种情况下（传入日期），你可以在模板中定义对应列 的日期格式，这样可以灵活通过模板来控制输出的日期格式
	 * 
	 * @param value
	 *            日期
	 */
	public ExcelTemplate createCell(Date value, String format) {
		this.currentSheet.createCell(value, format);
		return this;
	}

	public ExcelTemplate createCell(Date value) {
		this.currentSheet.createCell(value);
		return this;
	}

	/**
	 * 根据传入的字符串值，在当前行上创建新列
	 * 
	 * @param value
	 *            列的值（字符串）
	 */
	public ExcelTemplate createCell(String value) {
		this.currentSheet.createCell(value);
		return this;
	}

	public ExcelTemplate createCell(boolean value) {
		this.currentSheet.createCell(value);
		return this;
	}

	public ExcelTemplate createCell(RichTextString value) {
		this.currentSheet.createCell(value);
		return this;
	}

	public ExcelTemplate createCell(double value) {
		this.currentSheet.createCell(value);
		return this;
	}

	/**
	 * 创建序号列
	 */
	public ExcelTemplate createSerialCell() {
		this.currentSheet.createSerialCell();
		return this;
	}

	/**
	 * 得到当前cell
	 * 
	 * @return
	 */
	public Cell getCurrentCell() {
		return this.currentSheet.getCurrentCell();
	}

	/**
	 * 得到当前Row
	 * 
	 * @return
	 */
	public Row getCurrentRow() {
		return this.currentSheet.getCurrentRow();
	}

	/**
	 * 得到当前sheet
	 * 
	 * @return
	 */
	public Sheet getCurrentSheet() {
		return this.currentSheet.getSheet();
	}

	/**
	 * 获取当前Workbook的实例
	 * 
	 * @return
	 */
	public Workbook getWorkbook() {
		return workbook;
	}

	/**
	 * 获取模板中定义的单元格样式，如果没有定义，则返回空
	 * 
	 * @param style
	 *            模板定义的样式名称
	 * @return 模板定义的单元格的样式，如果没有定义则返回空
	 */
	public CellStyle getTemplateStyle(String style) {
		return currentSheet.getTemplateStyle(style);
	}

	/**
	 * 替换模板中的文本参数 参数以“#”开始
	 * 
	 * @param props
	 */
	public ExcelTemplate replaceParameters(Properties props) {
		for (int i = 0; i < sheetHolders.size(); i++) {
			currentSheet = sheetHolders.get(i);
			currentSheet.replaceParameters(props);
		}

		return this;
	}

	/**
	 * 根据路径写到磁盘
	 * 
	 * @param fileName
	 * @throws IOException
	 */
	public boolean writeToDisk(String subPath, String fileName) throws IOException {
		boolean flag = false;
		if (fileName == null || "".equals(fileName.trim()))
			return flag;
		// 创建目录
		File filePath = new File(subPath);
		if (!filePath.exists()) {
			System.out.println("存放目录不存在,自动为您创建存放目录.");
			filePath.mkdirs();
		}
		if (!filePath.isDirectory()) {
			System.out.println("无效文件目录");
			return flag;
		}
		fileName = subPath + fileName;

		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(fileName);
			workbook.write(fos);
			flag = true;
			return flag;
		} finally {
			if (fos != null) {
				fos.close();
			}
		}
	}

	/**
	 * 提供下载
	 * 
	 * @param response
	 * @param fileName
	 * @throws IOException
	 */
	public void writeToDownload(HttpServletResponse response, String fileName) throws IOException {
		response.reset();
		response.setContentType("application/x-download;charset=UTF-8");
		response.setHeader("Content-Disposition",
				new StringBuilder("attachment;filename=").append(new String(fileName.getBytes("GB2312"), "ISO8859-1"))
						.append("_").append(System.currentTimeMillis()).append(".xls").toString());
		workbook.write(response.getOutputStream());
	}

	/**
	 * 激活下一张工作表成为当前工作表
	 */
	public ExcelTemplate shiftSheet() {
		if (currentSheetIndex >= this.sheetHolders.size() - 1) {
			currentSheetIndex = 0;
		} else {
			currentSheetIndex++;
		}
		currentSheet = sheetHolders.get(currentSheetIndex);
		return this;
	}

	/**
	 * 激活指定index的工作表
	 * 
	 * @param index
	 *            从0开始
	 */
	public ExcelTemplate shiftSheet(int index) {
		if (index > this.sheetHolders.size() - 1) {
			index = this.sheetHolders.size() - 1;
		} else if (index < 0) {
			index = 0;
		}
		currentSheet = sheetHolders.get(index);
		return this;
	}

	/**
	 * 合并单元格
	 * 
	 * @param addRow
	 *            从现在单元格的行数开始计算,合并多少行
	 * @param addCol
	 *            从现在单元格的列数开始计算,合并多少列
	 * @return
	 */
	public ExcelTemplate mergeCell(int addRow, int addCol) {
		this.currentSheet.mergeCell(addRow, addCol);
		return this;
	}

	/**
	 * 移动当前工作行 需要注意的地方: 1.如果template中尚未创建一行就开始移动,则无效.
	 * 2.如果移动到的行在template中还未创建,则默认会创建该行,并且当前列会回到初始位置.
	 * 
	 * @param num
	 * @return
	 */
	public ExcelTemplate alterCurrentRow(int num) {
		this.currentSheet.alterCurrentRow(num);
		return this;
	}

	/**
	 * 移动当前工作列
	 * 
	 * @param i
	 * @return
	 */
	public ExcelTemplate alterCurrentCol(int num) {
		this.currentSheet.alterCurrentCol(num);
		return this;
	}

	/**
	 * Excel工作表操纵类
	 */
	class ExcelSheetHolder {
		private static final String DATAS = "datas";
		private static final String DATE_FORMAT = "yyyy.mm.dd";

		private Sheet sheet;
		private Row currentRow;
		private Map<Integer, CellStyle> styles = new HashMap<Integer, CellStyle>(); // 数据行的默认样式配置
		private Map<String, CellStyle> confStyles = new HashMap<String, CellStyle>(); // 通过设置"#STYLE_XXX"来标识的样式配置
		private int initrow; // 数据输出起始行
		private int initcol; // 数据输出起始列
		private int currentcol; // 当前列
		private int rowheight = 22; // 行高
		private int lastLowNum = 0;
		private String cellStyle = null;

		public ExcelSheetHolder(Sheet sheet) {
			this.sheet = sheet;
		}

		/**
		 * 移动当前工作行
		 * 
		 * @param num
		 */
		public void alterCurrentRow(int num) {
			if (currentRow == null) {
				return;
			}
			currentRow = sheet.getRow(currentRow.getRowNum() + num);
			if (currentRow == null) {
				createRow(currentRow.getRowNum() + num - initrow);
			}
		}

		/**
		 * 移动当前工作列
		 * 
		 * @param i
		 * @return
		 */
		public void alterCurrentCol(int num) {
			currentcol = currentcol + num;
			if (currentcol < 0) {
				currentcol = 0;
			}
		}

		/**
		 * 合并单元格
		 * 
		 * @param addRow
		 *            合并多少行
		 * @param addCol
		 *            合并多少列
		 * @return
		 */
		public void mergeCell(int addRow, int addCol) {
			if (currentRow == null) {
				return;
			}
			int currentRowNum = currentRow.getRowNum();
			int currentCellNum = getCurrentCell().getColumnIndex();
			sheet.addMergedRegion(new CellRangeAddress(currentRowNum, currentRowNum + addRow, currentCellNum,
					currentCellNum + addCol));
		}

		/**
		 * 创建序号单元格
		 */
		public void createSerialCell() {
			if (currentRow == null) {
				return;
			}
			int serialNum = currentRow.getRowNum() - initrow > 0 ? currentRow.getRowNum() - initrow + 1 : 1;
			this.createCell(serialNum);
		}

		/**
		 * 设置特定的单元格样式，此样式可以通过在模板文件中定义"#STYLE_XX"来得到，如： #STYLE_1，传入的参数就是"STYLE_1"
		 * 
		 * @param style
		 */
		public void setCellStyle(String style) {
			cellStyle = style;
		}

		/**
		 * 取消特定的单元格格式，恢复默认的配置值，即DATAS所在行的值
		 */
		public void setCellDefaultStyle() {
			cellStyle = null;
		}

		/**
		 * 创建新行
		 * 
		 * @param index
		 *            从0开始计数
		 */
		public void createRow(int index) {
			// 如果在当前插入数据的区域有后续行，则将其后面的行往后移动
			if (lastLowNum > initrow && index > 0) {
				sheet.shiftRows(index + initrow, lastLowNum + index, 1, true, true);
			}
			currentRow = sheet.createRow(index + initrow);
			currentRow.setHeight((short) rowheight);
			currentcol = initcol;
		}

		/**
		 * 根据传入的日期值，在当前行上创建新列 在这种情况下（传入日期），你可以在模板中定义对应列
		 * 的日期格式，这样可以灵活通过模板来控制输出的日期格式
		 * 
		 * @param value
		 *            日期
		 */
		public void createCell(Date value, String format) {
			if (value == null) {
				createCell("");
				return;
			}
			Cell cell = createCell();
			CellStyle style = cell.getCellStyle();
			if (style == null) {
				style = workbook.createCellStyle();
			}
			CreationHelper createHelper = workbook.getCreationHelper();
			style.setDataFormat(createHelper.createDataFormat().getFormat(format));
			cell.setCellStyle(style);
			cell.setCellValue(value);
		}

		public void createCell(Date value) {
			if (value != null) {
				createCell(value, DATE_FORMAT);
			} else {
				createCell("");
			}
		}

		/**
		 * 根据传入的字符串值，在当前行上创建新列
		 * 
		 * @param value
		 *            列的值（字符串）
		 */
		public void createCell(String value) {
			createCell().setCellValue(value);
		}

		public void createCell(boolean value) {
			createCell().setCellValue(value);
		}

		public void createCell(RichTextString value) {
			createCell().setCellValue(value);
		}

		public void createCell(double value) {
			createCell().setCellValue(value);
		}

		/**
		 * 得到当前cell
		 * 
		 * @return
		 */
		public Cell getCurrentCell() {
			if (currentcol == 0) {
				return currentRow.getCell(currentcol);
			}
			return this.currentRow.getCell(currentcol - 1);
		}

		/**
		 * 得到当前Row
		 * 
		 * @return
		 */
		public Row getCurrentRow() {
			return this.currentRow;
		}

		protected Cell createCell() {
			Cell cell = currentRow.createCell(currentcol++);
			CellStyle style = styles.get(cell.getColumnIndex());
			if (style != null) {
				cell.setCellStyle(style);
			}

			// 设置了特定格式
			if (cellStyle != null) {
				CellStyle ts = confStyles.get(cellStyle);
				if (ts != null) {
					cell.setCellStyle(ts);
				}
			}
			return cell;
		}

		/**
		 * 获取当前Sheet的实例
		 * 
		 * @return
		 */
		public Sheet getSheet() {
			return sheet;
		}

		/**
		 * 获取模板中定义的单元格样式，如果没有定义，则返回空
		 * 
		 * @param style
		 *            模板定义的样式名称
		 * @return 模板定义的单元格的样式，如果没有定义则返回空
		 */
		public CellStyle getTemplateStyle(String style) {
			return confStyles.get(style);
		}

		/**
		 * 替换模板中的文本参数 参数以“#”开始
		 * 
		 * @param props
		 */
		public void replaceParameters(Properties props) {
			if (props == null || props.size() == 0) {
				return;
			}
			Set<Map.Entry<Object, Object>> propsets = props.entrySet();
			System.out.println("*************");
			for (Iterator<Row> rowit = sheet.rowIterator(); rowit.hasNext();) {
				Row row = rowit.next();
				for (Iterator<Cell> cellIt = row.cellIterator(); cellIt.hasNext();) {
					Cell cell = cellIt.next();
					if (cell.getCellType() != Cell.CELL_TYPE_STRING) {
						continue;
					}
					String value = cell.getStringCellValue();
				
					int index = value.indexOf("#");
					if (value != null && index != -1) {
						
						for (Iterator<Map.Entry<Object, Object>> iter = propsets.iterator(); iter.hasNext();) {
							Map.Entry<Object, Object> entry = iter.next();
							String key = String.valueOf(entry.getKey());
							if (value.contains("#" + key + "#")) {
								if (value.substring(value.indexOf(key), value.indexOf(key) + key.length())
										.equals(key)) {
									Object aValue = entry.getValue();
									if ("R".equals(aValue)||"□".equals(aValue)) {
										value = value.replaceFirst("#" + key + "#",""+aValue);
										XSSFRichTextString richString = new XSSFRichTextString( value);  	
										// 生成一个字体
										XSSFFont font = (XSSFFont) workbook.createFont();
										font.setFontName("Wingdings 2"); // 设置字体
										font.setFontHeightInPoints((short)16);
										XSSFFont font2 = (XSSFFont) workbook.createFont();
										font2.setFontName("宋体"); // 设置字体
										font2.setFontHeightInPoints((short)16);
										for (int i = 0; i < value.length(); i++) {
											if ("R".charAt(0) == value.charAt(i)) {
												richString.applyFont(i, i+1, font);
												if (i+1 < value.length()) {
													richString.applyFont(i+1, value.length(), font2);
												}
											}
										}
										cell.setCellValue(richString);
									} else {
										if ("null".equals(aValue)) {
											aValue = "    ";
										}
										if (cell.getStringCellValue().contains("_")) {
											XSSFFont font = (XSSFFont) workbook.createFont();
											font.setUnderline(Font.U_SINGLE); //下划线
											value = value.replaceFirst("#" + key + "#", aValue + "");
											if (!value.contains("#")) {
												List<Integer> aa =new ArrayList<>();
												for (int i = 0; i < value.length(); i++) {
													if ("_".charAt(0) == value.charAt(i)) {
														aa.add(i);
													}
												}
												Collections.sort(aa);
												XSSFRichTextString richStringX = new XSSFRichTextString( value.replace("_", " "));  
												for (int i = 0; i < aa.size(); i++) {
													richStringX.applyFont(aa.get(i), aa.get(i+1), font);
													i++;
												}
												cell.setCellValue(richStringX);
											}
										}else{
											value = value.replaceFirst("#" + key + "#", aValue + "");
											cell.setCellValue(value);
										}
									}

								}
							}
						}
					}
				}
			}
		}

		/**
		 * 初始化Excel配置
		 */
		private void initConfig() {
			lastLowNum = sheet.getLastRowNum();
			for (Iterator<Row> rowit = sheet.rowIterator(); rowit.hasNext();) {
				boolean configFinish = false;
				if (configFinish) {
					break;
				}
				Row row = rowit.next();
				for (Iterator<Cell> cellit = row.cellIterator(); cellit.hasNext();) {
					Cell cell = cellit.next();
					if (cell.getCellType() != Cell.CELL_TYPE_STRING && !configFinish) {
						continue;
					}
					String config = cell.getStringCellValue();
					if (DATAS.equalsIgnoreCase(config)) {
						// 本行是数据开始行和样式配置行，需要读取相应的配置信息
						initrow = row.getRowNum();
						rowheight = row.getHeight();
						initcol = cell.getColumnIndex();
						configFinish = true;
					}
					if (configFinish) {
						readCellStyle(cell);
					}
				}
			}
		}

		/**
		 * 读取cell的样式
		 * 
		 * @param cell
		 */
		private void readCellStyle(Cell cell) {
			CellStyle style = cell.getCellStyle();
			if (style == null)
				return;
			styles.put(cell.getColumnIndex(), style);
		}

		/**
		 * 读取模板中其它单元格的样式配置
		 */
		private void readCellStyles() {
			for (Iterator<Row> rowit = sheet.rowIterator(); rowit.hasNext();) {
				Row row = rowit.next();
				for (Iterator<Cell> cellit = row.cellIterator(); cellit.hasNext();) {
					Cell cell = cellit.next();
					if (cell.getCellType() != Cell.CELL_TYPE_STRING) {
						continue;
					}
					String value = cell.getStringCellValue();
					if (value != null && value.indexOf("#STYLE_") != -1) {
						CellStyle style = cell.getCellStyle();
						if (style == null)
							continue;
						confStyles.put(value.substring(1), style);
						// remove it
						row.removeCell(cell);
					}
				}
			}
		}

		public void init() {
			this.initConfig();
			this.readCellStyles();
			Row configRow = this.sheet.getRow(this.initrow);
			if (configRow != null) {
				this.sheet.removeRow(configRow);
			}
		}
	}

	

}