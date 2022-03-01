package tedc.oecd.test;

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
		
		range = new Quarterly();
		((Quarterly)range).setEndTime(quarter);
		System.out.println(range.getFreq());
		System.out.println(range.getEndTimeString());
		
		range = new Monthly();
		((Monthly)range).setEndTime(month);
		System.out.println(range.getFreq());
		System.out.println(range.getEndTimeString());

	}

}
