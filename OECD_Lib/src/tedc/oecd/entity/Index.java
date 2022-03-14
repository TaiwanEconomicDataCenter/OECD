package tedc.oecd.entity;

public class Index {
	private String bank;
	private String name;
	private String tableName;
	private String tableCode;
	private String description;
	private String originalName;
	private TimeRange timeRange;
	private String unit;
	private String country;
	private String countryCode;
	private String subject;
	private String reference;
	public static final String defaultOrder = "name";
	public static final int defaultPageLimit = 20;
	
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableCode() {
		return tableCode;
	}
	public void setTableCode(String tableCode) {
		this.tableCode = tableCode;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public TimeRange getTimeRange() {
		return timeRange;
	}
	public void setTimeRange(TimeRange timeRange) {
		this.timeRange = timeRange;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getReference() {
		return reference;
	}
	public void setReference(String reference) {
		this.reference = reference;
	}
	
	public String getCategory(String category) {
		switch(category.trim()) {
		case "name": return this.getName();
		case "description": return this.getDescription();
		case "bank": return this.getBank();
		case "country": return this.getCountry();
		case "subject": return this.getSubject();
		case "unit": return this.getUnit();
		}
		throw new IllegalArgumentException("未知的category: "+category);
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Index other = (Index) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Index [\nbank=" + bank + ", \nname=" + name + ", \ntableName=" + tableName + ", \ntableCode=" + tableCode
				+ ", \ndescription=" + description + ", \noriginalName=" + originalName + ", \ntimeRange=" + timeRange
				+ ", \nunit=" + unit + ", \ncountry=" + country + ", \ncountryCode=" + countryCode + ", \nsubject=" + subject
				+ ", \nreference=" + reference + "\n]";
	}
	
}

