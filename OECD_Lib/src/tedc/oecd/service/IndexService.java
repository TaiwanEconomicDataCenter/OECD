package tedc.oecd.service;

import java.util.List;
import java.util.Map;

import tedc.oecd.entity.Category;
import tedc.oecd.entity.Frequency;
import tedc.oecd.entity.Index;
import tedc.oecd.exception.TEDCException;

public class IndexService {
	
	public List<Index> getIndexByPage(String bank, String keyword, int page, int limit, String order, boolean desc) throws TEDCException{
		return IndexDAO.selectIndexByPage(bank, keyword, page, limit, order, desc);
	}
	public int getTotalCounts(String bank, String keyword) throws TEDCException{
		return IndexDAO.selectIndexCount(bank, keyword);
	}
	public List<Index> getIndexByPage(String bank, Map<Category, List<String>> categoryMap, int page, int limit, String order, boolean desc) throws TEDCException{
		return IndexDAO.selectIndexByPage(bank, categoryMap, page, limit, order, desc);
	}
	public int getTotalCounts(String bank, Map<Category, List<String>> categoryMap) throws TEDCException{
		return IndexDAO.selectIndexCount(bank, categoryMap);
	}
	
	public Map<String, String> getCountries(String bank) throws TEDCException{
		return IndexDAO.selectCountries(bank);
	}
	public List<String> getSubjects(String bank) throws TEDCException{
		return IndexDAO.selectSubjects(bank);
	}
	public List<Frequency> getFrequencies(String bank) throws TEDCException{
		return IndexDAO.selectFrequencies(bank);
	}
}
