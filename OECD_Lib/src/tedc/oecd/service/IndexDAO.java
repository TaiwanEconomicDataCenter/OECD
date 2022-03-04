package tedc.oecd.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import tedc.oecd.entity.Annual;
import tedc.oecd.entity.Frequency;
import tedc.oecd.entity.Index;
import tedc.oecd.entity.Key;
import tedc.oecd.entity.Monthly;
import tedc.oecd.entity.Quarterly;
import tedc.oecd.entity.TimeRange;
import tedc.oecd.exception.TEDCException;

class IndexDAO {
	private static final String SELECT_QNIA_INDEX_BY_PAGE=
			"SELECT * FROM qnia_info "
			+ " ORDER BY name ASC LIMIT ?,?";
	private static final String SELECT_MEI_INDEX_BY_PAGE=
			"SELECT * FROM mei_info "
			+ " ORDER BY name ASC LIMIT ?,?";
	static List<Index> selectIndexByPage(String bank, String keyword, int page, int limit, String order, boolean desc) throws TEDCException{
		List<Index> list = new ArrayList<>();
		String SELECT_INDEX = null;
		if(bank!=null && bank.trim().toLowerCase().equals("qnia")) {
			SELECT_INDEX = SELECT_QNIA_INDEX_BY_PAGE;
		}else if(bank!=null && bank.trim().toLowerCase().equals("mei")) {
			SELECT_INDEX = SELECT_MEI_INDEX_BY_PAGE;
		}else throw new IllegalArgumentException("找不到名稱為"+bank+"的bank!");
		
		Map<Integer, String> keywordMap = new TreeMap<>();
		int input = 0;
		if(keyword!=null && (keyword=keyword.trim()).length()>0) {
			Key key = getKey(keyword, keywordMap, input);
			keywordMap = key.getKeywordMap();
			input = key.getInput();
			String whereClause = key.getWhereClause();

			SELECT_INDEX = SELECT_INDEX.replace("ORDER BY", whereClause+"ORDER BY");
		}
		
		SELECT_INDEX = SELECT_INDEX.replace("ORDER BY name ASC", "ORDER BY "+order+" "+(desc?"DESC":"ASC"));
		try(
				Connection connection = RDBConnection.getConnection(bank); //1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_INDEX); //3.準備指令
				
		){
			//3.1 傳入?的值
			for(Integer p:keywordMap.keySet()) {
				pstmt.setString(p, "%"+keywordMap.get(p)+"%");
			}
			pstmt.setInt(input+1, (page-1)*limit);
			pstmt.setInt(input+2, limit);
			
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令	
			){
				//5.處理rs
				while(rs.next()) {
					Index index = new Index();
					
					index.setBank(rs.getString("databank"));
					index.setName(rs.getString("name"));
					index.setTableName(rs.getString("db_table"));
					index.setTableCode(rs.getString("db_code"));
					index.setDescription(rs.getString("desc_e"));
					index.setOriginalName(rs.getString("desc_c"));
					TimeRange range = null;
					Frequency freq = Frequency.valueOf(rs.getString("freq"));
					if(freq!=null && freq.name().equals("A")) {
						range = new Annual();
						((Annual)range).setStartTime(rs.getInt("start"));
						((Annual)range).setEndTime(rs.getInt("last"));
					}else if(freq!=null && freq.name().equals("Q")) {
						range = new Quarterly();
						((Quarterly)range).setStartTime(rs.getString("start"));
						((Quarterly)range).setEndTime(rs.getString("last"));
					}else if(freq!=null && freq.name().equals("M")) {
						range = new Monthly();
						((Monthly)range).setStartTime(rs.getString("start"));
						((Monthly)range).setEndTime(rs.getString("last"));
					}
					index.setTimeRange(range);
					index.setUnit(rs.getString("unit"));
					index.setCountry(rs.getString("book"));
					index.setCountryCode(rs.getString("name_ord"));
					index.setSubject(rs.getString("form_e"));
					index.setReference(rs.getString("form_c"));
					list.add(index);
					
				}
			}
			
		}catch (SQLException e) {
			throw new TEDCException("[以頁數查詢索引]失敗", e);
		}
		
		return list;
	}
	private static final String SELECT_QNIA_INDEX_COUNT=
			"SELECT count(*) AS size FROM qnia_info ";
	private static final String SELECT_MEI_INDEX_COUNT=
			"SELECT count(*) AS size FROM mei_info ";
	static int selectIndexCount(String bank, String keyword) throws TEDCException{
		int result=0;
		String SELECT_INDEX = null;
		if(bank!=null && bank.trim().toLowerCase().equals("qnia")) {
			SELECT_INDEX = SELECT_QNIA_INDEX_COUNT;
		}else if(bank!=null && bank.trim().toLowerCase().equals("mei")) {
			SELECT_INDEX = SELECT_MEI_INDEX_COUNT;
		}else throw new IllegalArgumentException("找不到名稱為"+bank+"的bank!");
		
		Map<Integer, String> keywordMap = new TreeMap<>();
		int input = 0;
		if(keyword!=null && (keyword=keyword.trim()).length()>0) {
			Key key = getKey(keyword, keywordMap, input);
			keywordMap = key.getKeywordMap();
			input = key.getInput();
			String whereClause = key.getWhereClause();

			SELECT_INDEX = SELECT_INDEX += whereClause;
		}
		
		try(
				Connection connection = RDBConnection.getConnection(bank); //1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_INDEX); //3.準備指令
		){
			//3.1 傳入?的值
			for(Integer p:keywordMap.keySet()) {
				pstmt.setString(p, "%"+keywordMap.get(p)+"%");
			}
			
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令	
			){
				while(rs.next()) {
					result = rs.getInt("size");
				}
			}
		}catch (SQLException e) {
			throw new TEDCException("[查詢總筆數]失敗", e);
		}
		
		return result;
	}
	
	static Key getKey(String keyword, Map<Integer, String> keywordMap, int input) throws TEDCException{
		Key key = new Key();
		
		String[] columns = new String[] {"name","desc_e","name_ord","book","form_e"};
		String whereClause = "WHERE ";
		String[] keywordOrList = keyword.split("\\*");
		for(int h=0; h<columns.length; h++) {
			whereClause += (h>0?"OR ":"");
			for(int i=0; i<keywordOrList.length; i++) {
				whereClause += (i>0?"OR ":"");
				String[] keywordAndList = keywordOrList[i].split(",");
				for(int j=0; j<keywordAndList.length; j++) {
					keywordMap.put(++input, keywordAndList[j]);
					whereClause += (j>0?"AND ":"")+columns[h]+" LIKE ? ";
				}
			}
		}
		
		key.setKeywordMap(keywordMap);
		key.setInput(input);
		key.setWhereClause(whereClause);
		
		return key;
	}
}
