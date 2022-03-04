package tedc.oecd.entity;

public enum Category {
	country("name_ord"), subject("form_e"), frequency("freq"), name("name"), description("desc_e");
	
	private String relativeColumnName;
	private Category(String relativeColumnName) {
		this.relativeColumnName = relativeColumnName;
	}
	
	public String getRelativeColumnName() {
		return relativeColumnName;
	}


	public void setRelativeColumnName(String relativeColumnName) {
		this.relativeColumnName = relativeColumnName;
	}


	public static boolean checkCategory(String category) {
		try {
			Category.valueOf(category);
		}catch(NullPointerException e) {
			return false;
		}catch(IllegalArgumentException e) {
			return false;
		}
		
		return true;
	}
}
