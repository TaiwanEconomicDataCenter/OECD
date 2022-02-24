package tedc.oecd.entity;

public abstract class TimeRange {
	private Frequency freq;

	public Frequency getFreq() {
		return freq;
	}

	public void setFreq(Frequency freq) {
		this.freq = freq;
	}
	
	public abstract String getStartTimeString();
	public abstract String getEndTimeString();
}
