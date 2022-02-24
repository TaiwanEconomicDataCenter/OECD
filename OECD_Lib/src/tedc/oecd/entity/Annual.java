package tedc.oecd.entity;

import java.time.DateTimeException;
import java.time.Year;
import java.time.format.DateTimeParseException;

public class Annual extends TimeRange {
	private Year startTime;
	private Year endTime;
	
	public Annual() {
		super();
		this.setFreq(Frequency.A);
	}

	public Year getStartTime() {
		return startTime;
	}

	public Year getEndTime() {
		return endTime;
	}

	public void setStartTime(Year startTime) {
		this.startTime = startTime;
	}
	public void setStartTime(String startTime) {
		if(checkYear(startTime)) {
			this.startTime = Year.parse(startTime);
		}else {
			throw new RuntimeException("年資料格式不正確!");
		}
	}
	public void setStartTime(int startTime) {
		if(checkYear(startTime)) {
			this.startTime = Year.of(startTime);
		}else {
			throw new RuntimeException("年資料格式不正確!");
		}
	}
	
	public void setEndTime(Year endTime) {
		this.endTime = endTime;
	}
	public void setEndTime(String endTime) {
		if(checkYear(endTime)) {
			this.endTime = Year.parse(endTime);
		}else {
			throw new RuntimeException("年資料格式不正確!");
		}
	}
	public void setEndTime(int endTime) {
		if(checkYear(endTime)) {
			this.endTime = Year.of(endTime);
		}else {
			throw new RuntimeException("年資料格式不正確!");
		}
	}
	
	public boolean checkYear(String time) {
		try {
			Year.parse(time);
		}catch(DateTimeParseException e) {
			return false;
		}
		
		return true;
	}
	public boolean checkYear(int time) {
		try {
			Year.of(time);
		}catch(DateTimeException e) {
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
