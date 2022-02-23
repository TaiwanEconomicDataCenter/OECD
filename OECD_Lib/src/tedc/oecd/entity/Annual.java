package tedc.oecd.entity;

import java.time.Year;

public class Annual extends TimeRange {
	private Year startTime;
	private Year endTime;
	
	public Annual() {
		super();
		this.setFreq(Frequency.A);
	}

	public void setStartTime(Year startTime) {
		this.startTime = startTime;
	}
	public void setStartTime(String startTime) {
		if(checkYear(startTime)) {
			this.startTime = Year.of(Integer.valueOf(startTime));
		}else {
			throw new RuntimeException("年資料格式不正確!");
		}
	}
	
	public void setEndTime(Year endTime) {
		this.endTime = endTime;
	}
	public void setEndTime(String endTime) {
		if(checkYear(endTime)) {
			this.endTime = Year.of(Integer.valueOf(endTime));
		}else {
			throw new RuntimeException("年資料格式不正確!");
		}
	}
	
	public boolean checkYear(String time) {
		try {
			Integer year = Integer.valueOf(time);
		}catch(NumberFormatException e) {
			return false;
		}
		
		return true;
	}

	@Override
	public String getStartTime() {
		return this.startTime.toString();
	}

	@Override
	public String getEndTime() {
		return this.endTime.toString();
	}

}
