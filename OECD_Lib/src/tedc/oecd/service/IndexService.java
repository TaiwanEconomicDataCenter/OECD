package tedc.oecd.service;

import java.util.List;

import tedc.oecd.entity.Index;
import tedc.oecd.exception.TEDCException;

public class IndexService {
	
	public List<Index> getIndexByPage(String bank, int page, int limit) throws TEDCException{
		return IndexDAO.selectIndexByPage(bank, page, limit);
	}
	public int getTotalCounts(String bank) throws TEDCException{
		return IndexDAO.selectIndexCount(bank);
	}

}
