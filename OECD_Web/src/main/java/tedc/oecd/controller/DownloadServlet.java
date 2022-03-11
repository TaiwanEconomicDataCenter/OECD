package tedc.oecd.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tedc.oecd.entity.Annual;
import tedc.oecd.entity.Cart;
import tedc.oecd.entity.Frequency;
import tedc.oecd.entity.Index;
import tedc.oecd.entity.IndexData;
import tedc.oecd.entity.Monthly;
import tedc.oecd.entity.Quarterly;
import tedc.oecd.entity.TimeRange;
import tedc.oecd.exception.TEDCException;
import tedc.oecd.service.ExcelDownloadService;

/**
 * Servlet implementation class DownloadServlet
 */
@WebServlet("/download_xls.do")
public class DownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Cart cart = (Cart)session.getAttribute("cart");
		
		//1.取得Form Data
		String frequency = request.getParameter("frequency");
		Frequency freq = null;
		if(frequency==null||!Frequency.checkFrequency(frequency)) {
			System.err.println("頻率不正確: "+frequency);
			response.sendRedirect(request.getContextPath()+"/cart/cart.jsp");
			return;
		}else freq = Frequency.valueOf(frequency);
		if(cart==null||cart.getSetSizeByFrequency(freq)<=0) {
			System.err.println("查無"+freq.getDescription()+"!");
			response.sendRedirect(request.getContextPath()+"/cart/cart.jsp");
			return;
		}
		
		//2.呼叫商業邏輯
		try {
			ExcelDownloadService eService = new ExcelDownloadService();
			Set<IndexData> dataSet = new HashSet<>();
			TimeRange selected = null;
			String startYear = request.getParameter("startYear");
			String endYear = request.getParameter("endYear");
			if(startYear==null||endYear==null) {
				System.err.println("年份不正確: startYear="+startYear+", endYear="+endYear);
				response.sendRedirect(request.getContextPath()+"/cart/cart.jsp");
				return;
			}
			if(freq.equals(Frequency.A)) {
				selected = new Annual();
				((Annual)selected).setStartTime(startYear);
				((Annual)selected).setEndTime(endYear);
			}else if(freq.equals(Frequency.Q)) {
				String startQuarter = request.getParameter("startQuarter");
				String endQuarter = request.getParameter("endQuarter");
				if(startQuarter==null||endQuarter==null) {
					System.err.println("季度不正確: startQuarter="+startQuarter+", endQuarter="+endQuarter);
					response.sendRedirect(request.getContextPath()+"/cart/cart.jsp");
					return;
				}
				selected = new Quarterly();
				String start = startYear+"-Q"+startQuarter;
				String end = endYear+"-Q"+endQuarter;
				((Quarterly)selected).setStartTime(start);
				((Quarterly)selected).setEndTime(end);
			}else if(freq.equals(Frequency.M)) {
				String startMonth = request.getParameter("startMonth");
				String endMonth = request.getParameter("endMonth");
				if(startMonth==null||endMonth==null) {
					System.err.println("月份不正確: startMonth="+startMonth+", endMonth="+endMonth);
					response.sendRedirect(request.getContextPath()+"/cart/cart.jsp");
					return;
				}
				selected = new Monthly();
				String start = startYear+"-"+(startMonth.length()<2?"0"+startMonth:startMonth);
				String end = endYear+"-"+(endMonth.length()<2?"0"+endMonth:endMonth);
				((Monthly)selected).setStartTime(start);
				((Monthly)selected).setEndTime(end);
			}
			
			for(Index index:cart.getSetByFrequency(freq)) {
				IndexData indexData = eService.getDataByTimeRange(index, selected);
				dataSet.add(indexData);
			}
			
			//2.1生成Excel並匯出
			String fileName = "oecd"+LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE)+freq.name()+".xls";
			OutputStream out = response.getOutputStream();
			response.setContentType("octets/stream");
            response.setContentType("APPLICATION/OCTET-STREAM");
            
            eService.export(out, dataSet, fileName);
			
            out.flush();    
            out.close();
		} catch (TEDCException e) {
			this.log("下載資料表格失敗", e);
		} catch (Exception e) {
			this.log("下載資料表格，發生非預期錯誤", e);
		}
		
	}

}
