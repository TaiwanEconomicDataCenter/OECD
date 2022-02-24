package tedc.oecd.entity;

import java.time.YearMonth;
import java.time.format.DateTimeParseException;

public class Monthly extends TimeRange {
	private YearMonth startTime;
	private YearMonth endTime;

	public Monthly() {
		super();
		this.setFreq(Frequency.M);
	}

	public YearMonth getStartTime() {
		return startTime;
	}

	public YearMonth getEndTime() {
		return endTime;
	}

	public void setStartTime(YearMonth startTime) {
		this.startTime = startTime;
	}
	public void setStartTime(String startTime) {
		if(checkMonth(startTime)) {
			this.startTime = YearMonth.parse(startTime);
		}else {
			throw new RuntimeException("月資料格式不正確!");
		}
	}

	public void setEndTime(YearMonth endTime) {
		this.endTime = endTime;
	}
	public void setEndTime(String endTime) {
		if(checkMonth(endTime)) {
			this.endTime = YearMonth.parse(endTime);
		}else {
			throw new RuntimeException("月資料格式不正確!");
		}
	}
	
	public boolean checkMonth(String time) {
		try {
			YearMonth.parse(time);
		}catch(DateTimeParseException e) {
			return false;
		}
		
		return true;
	}

	@Override
	public String getStartTimeString() {
		return this.startTime.toString();
	}

	@Override
	public String getEndTimeString() {
		return this.endTime.toString();
	}

}
