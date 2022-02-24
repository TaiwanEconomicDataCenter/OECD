package tedc.oecd.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import tedc.oecd.entity.Annual;
import tedc.oecd.entity.Frequency;
import tedc.oecd.entity.Index;
import tedc.oecd.entity.Monthly;
import tedc.oecd.entity.Quarterly;
import tedc.oecd.entity.TimeRange;
import tedc.oecd.exception.TEDCException;

class IndexDAO {
	private static final String SELECT_INDEX_BY_PAGE=
			"SELECT databank, name, db_table, db_code, desc_e, desc_c, freq, start, last, unit, name_ord, snl, book, form_e, form_c "
			+ " FROM ?_key "
			+ " LIMIT ?,?";
	static List<Index> selectIndexByPage(String bank, int page, int limit) throws TEDCException{
		List<Index> list = new ArrayList<>();
		
		try(
				Connection connection = RDBConnection.getConnection(bank); //1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_INDEX_BY_PAGE); //3.準備指令
		){
			//3.1 傳入?的值
			pstmt.setString(1, bank);
			pstmt.setInt(2, (page-1)*limit);
			pstmt.setInt(3, limit);
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
}
