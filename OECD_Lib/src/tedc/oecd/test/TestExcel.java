package tedc.oecd.test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class TestExcel {

	public static void main(String[] args) {
		File currDir = new File(".");
		String path = currDir.getAbsolutePath();
		String fileLocation = path.substring(0, path.length() - 1) + "temp.xls";
		System.out.println(fileLocation);
		
		HSSFWorkbook workbook = new HSSFWorkbook();
//		HSSFFont wbFont = workbook.createFont();
//		wbFont.setCharSet(HSSFFont.ANSI_CHARSET);
		HSSFSheet sheet = workbook.createSheet();
		HSSFRow rowRowName = sheet.createRow(0);
		HSSFCell  cellRowName = rowRowName.createCell(0); 
		cellRowName.setCellType(CellType.STRING);
		HSSFRichTextString text = new HSSFRichTextString("123");
		cellRowName.setCellValue(text);
		System.out.println(cellRowName);
		cellRowName.setCellValue("序號");
		sheet.setColumnWidth(0, 5000);
		System.out.println(cellRowName.toString());
		System.out.println(sheet.getColumnWidth(0));

		try {
			FileOutputStream out = new FileOutputStream(new File(fileLocation));
			workbook.write(out);
			workbook.close();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		fileLocation = path.substring(0, path.length() - 1) + "temp.xlsx";
		System.out.println(fileLocation);
		XSSFWorkbook workbook2 = new XSSFWorkbook();
		XSSFSheet sheet2 = workbook2.createSheet();
		XSSFRow rowRowName2 = sheet2.createRow(0);
		XSSFCell  cellRowName2 = rowRowName2.createCell(0); 
		cellRowName2.setCellType(CellType.STRING);
		XSSFRichTextString text2 = new XSSFRichTextString("123");
		cellRowName2.setCellValue(text2);
		System.out.println(cellRowName2);
		cellRowName2.setCellValue("序號");
		sheet2.setColumnWidth(0, 5000);
		System.out.println(cellRowName2.toString());
		System.out.println(sheet2.getColumnWidth(0));
		
		try {
			FileOutputStream out = new FileOutputStream(new File(fileLocation));
			workbook2.write(out);
			workbook2.close();
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
