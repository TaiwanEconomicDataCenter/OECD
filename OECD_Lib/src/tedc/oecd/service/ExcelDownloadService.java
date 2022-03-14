package tedc.oecd.service;

import java.io.IOException;
import java.io.OutputStream;
import java.time.Year;
import java.time.YearMonth;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.threeten.extra.YearQuarter;

import tedc.oecd.entity.Annual;
import tedc.oecd.entity.Index;
import tedc.oecd.entity.IndexData;
import tedc.oecd.entity.Monthly;
import tedc.oecd.entity.Quarterly;
import tedc.oecd.entity.TimeRange;
import tedc.oecd.exception.TEDCException;

public class ExcelDownloadService {
	
	public IndexData getDataByTimeRange(Index index, TimeRange selected) throws TEDCException {
		if(index==null) throw new IllegalArgumentException("索引不得為null!");
		if(selected==null) throw new IllegalArgumentException("期間範圍不得為null!");
		
		return DataBaseDAO.selectDataByTimeRange(index, selected);
	}
	
	public void export(OutputStream out, List<IndexData> dataList, TimeRange selected) {
		if(out==null||dataList==null||selected==null) {
			throw new IllegalArgumentException("參數不得為null!");
		}
		
		try(
			HSSFWorkbook workbook = new HSSFWorkbook();
		){
			HSSFSheet sheet = workbook.createSheet("AREMOS");
			
			int columnNum = dataList.size();
			//1.name
			sheet = createRow(sheet, columnNum, 0, "name", dataList, "檢索代號");
			sheet.setColumnWidth(0, 3000);
			for(int i=1; i<=columnNum; i++) {
				sheet.autoSizeColumn(i);
			}
			//2.description
			sheet = createRow(sheet, columnNum, 1, "description", dataList, "資料敘述");
			//3.country
			sheet = createRow(sheet, columnNum, 2, "country", dataList, "國家");
			//4.subject
			sheet = createRow(sheet, columnNum, 3, "subject", dataList, "主題");
			//5.unit
			sheet = createRow(sheet, columnNum, 4, "DATE/unit", dataList, "單位");
			//6.data
			int rowId = 5;
			if(selected instanceof Annual) {
				Annual range = (Annual)selected;
				if(range.getStartTime()!=null&&range.getEndTime()!=null) {
					for(Year y=range.getStartTime(); !y.isAfter(range.getEndTime()); y=y.plusYears(1)) {
						sheet = fillInData(sheet, columnNum, rowId, y, dataList);
						rowId++;
					}
				}else throw new IllegalArgumentException("起始結束時間不得為null: start="+range.getStartTime()+", end="+range.getEndTime());
				
			}else if(selected instanceof Quarterly) {
				Quarterly range = (Quarterly)selected;
				if(range.getStartTime()!=null&&range.getEndTime()!=null) {
					for(YearQuarter yq=range.getStartTime(); !yq.isAfter(range.getEndTime()); yq=yq.plusQuarters(1)) {
						sheet = fillInData(sheet, columnNum, rowId, yq, dataList);
						rowId++;
					}
				}else throw new IllegalArgumentException("起始結束時間不得為null: start="+range.getStartTime()+", end="+range.getEndTime());
				
			}else if(selected instanceof Monthly) {
				Monthly range = (Monthly)selected;
				if(range.getStartTime()!=null&&range.getEndTime()!=null) {
					for(YearMonth ym=range.getStartTime(); !ym.isAfter(range.getEndTime()); ym=ym.plusMonths(1)) {
						sheet = fillInData(sheet, columnNum, rowId, ym, dataList);
						rowId++;
					}
				}else throw new IllegalArgumentException("起始結束時間不得為null: start="+range.getStartTime()+", end="+range.getEndTime());
				
			}else throw new IllegalArgumentException("未知的TimeRange!");
		
			System.out.println("準備好進行下載\n");
			workbook.write(out);
	
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public HSSFSheet createRow(HSSFSheet sheet, int columnNum, int rowId, String headName, List<IndexData> dataList, String category) {
		HSSFRow row = sheet.createRow(rowId);
		HSSFCell head = row.createCell(0);
		head.setCellValue(headName);
		for(int i=0; i<columnNum; i++) {
			Index index = dataList.get(i).getIndex();
			headName = headName.replaceAll("\\w*/", "");
			if(index==null||index.getCategory(headName)==null) {
				throw new IllegalArgumentException(category+"不得為null!");
			}
			HSSFCell cat = row.createCell(i+1);
			cat.setCellValue(index.getCategory(headName));
		}
		
		return sheet;
	}
	public HSSFSheet fillInData(HSSFSheet sheet, int columnNum, int rowId, Object headName, List<IndexData> dataList) {
		HSSFRow row = sheet.createRow(rowId);
		HSSFCell head = row.createCell(0);
		head.setCellValue(headName.toString());
		for(int i=0; i<columnNum; i++) {
			Double data = dataList.get(i).getData(headName.toString());
			HSSFCell indexData = row.createCell(i+1);
			if(data!=null) {
				indexData.setCellValue(data);
			}else {
				indexData.setCellValue("NA");
			}
		}
		
		return sheet;
	}
}
