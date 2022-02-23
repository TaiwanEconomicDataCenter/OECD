package tedc.oecd.entity;

import org.threeten.extra.YearQuarter;

public class Quarterly extends TimeRange {
	private YearQuarter startTime;
	private YearQuarter endTime;

	public void setStartTime(YearQuarter startTime) {
		this.startTime = startTime;
	}
	public void setStartTime(YearQuarter startTime) {
		this.startTime = startTime;
	}

	public void setEndTime(YearQuarter endTime) {
		this.endTime = endTime;
	}

	@Override
	public String getStartTime() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getEndTime() {
		// TODO Auto-generated method stub
		return null;
	}

}
