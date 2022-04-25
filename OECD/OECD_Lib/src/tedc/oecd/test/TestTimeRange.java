package tedc.oecd.test;

import java.time.LocalDate;
import java.time.Year;
import java.time.YearMonth;

import org.threeten.extra.YearQuarter;

import tedc.oecd.entity.Annual;
import tedc.oecd.entity.Monthly;
import tedc.oecd.entity.Quarterly;
import tedc.oecd.entity.TimeRange;

public class TestTimeRange {

	public static void main(String[] args) {
		//System.out.println((int)Math.ceil(48.1/2));
		String annual = "2022";
		int annualI = 2022;
		String quarter = "2022-Q1";
		String qError = "2022-Q5";
		String month = "2022-02";
		String mError = "2022-13";
		
		TimeRange range = null;
		
		range = new Annual();
		((Annual)range).setEndTime(annual);
		System.out.println(range.getFreq());
		System.out.println(range.getEndTimeString());
		((Annual)range).setEndTime(annualI);
		System.out.println(range.getFreq());
		System.out.println(range.getEndTimeString());
		Annual a = new Annual();
		a.setStartTime(2000);
		a.setEndTime(Year.now());
		for(Year y=a.getStartTime(); !y.isAfter(a.getEndTime()); y=y.plusYears(1)) {
			System.out.println(y);
		}
		
		range = new Quarterly();
		((Quarterly)range).setEndTime(quarter);
		System.out.println(range.getFreq());
		System.out.println(range.getEndTimeString());
		Quarterly q = new Quarterly();
		q.setStartTime("2000-Q1");
		q.setEndTime(YearQuarter.now());
		for(YearQuarter yq=q.getStartTime(); !yq.isAfter(q.getEndTime()); yq=yq.plusQuarters(1)) {
			System.out.println(yq);
		}
		
		range = new Monthly();
		((Monthly)range).setEndTime(month);
		System.out.println(range.getFreq());
		System.out.println(range.getEndTimeString());
		Monthly m = new Monthly();
		m.setStartTime("2000-01");
		m.setEndTime(YearMonth.now());
		for(YearMonth ym=m.getStartTime(); !ym.isAfter(m.getEndTime()); ym=ym.plusMonths(1)) {
			System.out.println(ym);
		}
		String headName = "DATE/unit";
		System.out.println(headName.replaceAll("\\w*/", ""));
	}

}
