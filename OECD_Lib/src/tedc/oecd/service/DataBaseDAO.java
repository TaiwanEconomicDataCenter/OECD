package tedc.oecd.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import tedc.oecd.entity.Index;
import tedc.oecd.entity.IndexData;
import tedc.oecd.entity.TimeRange;
import tedc.oecd.exception.TEDCException;

public class DataBaseDAO {
	private static final String SELECT_QNIA_TABLE_AND_CODE_BY_NAME=
			"SELECT table.index, code FROM qnia.table WHERE table.index>=? AND table.index<=?";
	private static final String SELECT_MEI_TABLE_AND_CODE_BY_NAME=
			"SELECT table.index, code FROM mei.table WHERE table.index>=? AND table.index<=?";
	static IndexData selectDataByTimeRange(Index index, TimeRange selected) throws TEDCException{
		if(index==null) throw new IllegalArgumentException("索引不得為null!");
		if(selected==null) throw new IllegalArgumentException("期間範圍不得為null!");
		IndexData indexData = new IndexData();
		indexData.setIndex(index);
		String SELECT_INDEX = null;
		String bank = index.getBank();
		if(bank!=null && bank.trim().toLowerCase().equals("qnia")) {
			SELECT_INDEX = SELECT_QNIA_TABLE_AND_CODE_BY_NAME;
		}else if(bank!=null && bank.trim().toLowerCase().equals("mei")) {
			SELECT_INDEX = SELECT_MEI_TABLE_AND_CODE_BY_NAME;
		}else throw new IllegalArgumentException("找不到名稱為"+bank+"的bank!");
		
		String tableName = index.getTableName();
		String tableCode = index.getTableCode();
		if(tableName!=null && tableCode!=null) {
			SELECT_INDEX = SELECT_INDEX.replace("table", tableName.trim().toLowerCase()).replace("code", tableCode.trim().toLowerCase());
		}else throw new IllegalArgumentException("tableName或tableCode不正確: tableName="+tableName+", tableCode="+tableCode);
		String start = selected.getStartTimeString();
		String end = selected.getEndTimeString();
		if(start==null||end==null) throw new IllegalArgumentException("起始時間與結尾時間不得為null!");
		
		try(
				Connection connection = RDBConnection.getConnection(bank); //1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_INDEX); //3.準備指令
				
		){
			//3.1 傳入?的值
			pstmt.setString(1, start);
			pstmt.setString(2, end);
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令	
			){
				//5.處理rs
				while(rs.next()) {
					indexData.inputData(rs.getString("index"), rs.getDouble(tableCode));
				}
			}
			
		}catch (SQLException e) {
			throw new TEDCException("[以檢索代號查詢資料表與欄位]失敗", e);
		}
		
		return indexData;
	}
	
}
