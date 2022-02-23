package tedc.oecd.entity;

import java.time.Year;
import java.time.format.DateTimeParseException;

import org.threeten.extra.YearQuarter;

public class Quarterly extends TimeRange {
	private YearQuarter startTime;
	private YearQuarter endTime;

	public void setStartTime(YearQuarter startTime) {
		this.startTime = startTime;
	}
	public void setStartTime(String startTime) {
		if(checkQuarter(startTime)) {
			this.startTime = YearQuarter.parse(startTime);
		}else {
			throw new RuntimeException("季資料格式不正確!");
		}
	}

	public void setEndTime(YearQuarter endTime) {
		this.endTime = endTime;
	}
	public void setEndTime(String endTime) {
		if(checkQuarter(endTime)) {
			this.endTime = YearQuarter.parse(endTime);
		}else {
			throw new RuntimeException("季資料格式不正確!");
		}
	}
	
	public boolean checkQuarter(String time) {
		try {
			YearQuarter yq = YearQuarter.parse(time);
		}catch(DateTimeParseException e) {
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
