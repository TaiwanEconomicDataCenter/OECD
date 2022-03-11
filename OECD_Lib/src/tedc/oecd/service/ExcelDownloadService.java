package tedc.oecd.service;

import java.util.Set;

import tedc.oecd.entity.Index;
import tedc.oecd.entity.IndexData;
import tedc.oecd.entity.TimeRange;
import tedc.oecd.exception.TEDCException;

public class ExcelDownloadService {
	
	public IndexData getDataByTimeRange(Index index, TimeRange selected) throws TEDCException {
		if(index==null) throw new IllegalArgumentException("索引不得為null!");
		if(selected==null) throw new IllegalArgumentException("期間範圍不得為null!");
		
		return DataBaseDAO.selectDataByTimeRange(index, selected);
	}
	
	public void export(Set<IndexData> dataSet, String fileName) {
		
	}
}
