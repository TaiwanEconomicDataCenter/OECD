package tedc.oecd.entity;

import java.util.Map;

public class Key {
	Map<Integer, String> keywordMap;
	int input;
	String whereClause;
	
	public Map<Integer, String> getKeywordMap() {
		return keywordMap;
	}
	public void setKeywordMap(Map<Integer, String> keywordMap) {
		this.keywordMap = keywordMap;
	}
	public int getInput() {
		return input;
	}
	public void setInput(int input) {
		this.input = input;
	}
	public String getWhereClause() {
		return whereClause;
	}
	public void setWhereClause(String whereClause) {
		this.whereClause = whereClause;
	}
	
}
