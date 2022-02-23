package tedc.oecd.entity;

public enum Frequency {
	A("年資料"), Q("季資料"), M("月資料");
	
	private String description;
	private Frequency(String description) {
		this.description = description;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	
}
