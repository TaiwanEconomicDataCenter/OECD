package tedc.oecd.service;

import java.util.List;

import tedc.oecd.entity.Index;
import tedc.oecd.exception.TEDCException;

public class IndexService {
	
	public List<Index> getIndexByPage(String bank, String keyword, int page, int limit, String order, boolean desc) throws TEDCException{
		order="name";
		System.out.println(order);
		return IndexDAO.selectIndexByPage(bank, keyword, page, limit, order, desc);
	}
	public int getTotalCounts(String bank, String keyword) throws TEDCException{
		return IndexDAO.selectIndexCount(bank, keyword);
	}

}
