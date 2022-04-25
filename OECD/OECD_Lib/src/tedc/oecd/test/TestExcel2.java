package tedc.oecd.test;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.Year;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.threeten.extra.YearQuarter;

import tedc.oecd.entity.Annual;
import tedc.oecd.entity.Index;
import tedc.oecd.entity.IndexData;
import tedc.oecd.entity.Monthly;
import tedc.oecd.entity.Quarterly;
import tedc.oecd.entity.TimeRange;
import tedc.oecd.exception.TEDCException;
import tedc.oecd.service.ExcelDownloadService;
import tedc.oecd.service.IndexService;

public class TestExcel2 {
	
	public static void main(String[] args) {
		ExcelDownloadService eService = new ExcelDownloadService();
		IndexService iService = new IndexService();
		List<IndexData> dataList = new ArrayList<>();
		List<Index> list = null;
		TimeRange selected = new Annual();
		((Annual)selected).setStartTime(2000);
		((Annual)selected).setEndTime(Year.now());
//		TimeRange selected = new Monthly();
//		((Monthly)selected).setStartTime("2000-01");
//		((Monthly)selected).setEndTime(YearMonth.now());
//		TimeRange selected = new Quarterly();
//		((Quarterly)selected).setStartTime("2000-Q1");
//		((Quarterly)selected).setEndTime(YearQuarter.now());
		try {
			list = iService.getIndexByPage("mei", "France,CPI", null, 1, Index.defaultPageLimit, "name", false);
			for(Index index:list) {
				System.out.println(index.getName());
				IndexData indexData = eService.getDataByTimeRange(index, selected);
				dataList.add(indexData);
			}
			
			FileOutputStream out = new FileOutputStream(new File("oecd"+LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE)+selected.getFreq().name()+".xls"));
			eService.export(out, dataList, selected);
			out.close();
			
		} catch (TEDCException e) {
			e.printStackTrace();
		}	catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("程式結束");
	}
}
