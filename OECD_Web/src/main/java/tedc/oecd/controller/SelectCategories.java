package tedc.oecd.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tedc.oecd.entity.Category;
import tedc.oecd.entity.Index;
import tedc.oecd.exception.TEDCException;
import tedc.oecd.service.IndexService;

/**
 * Servlet implementation class SelectCategories
 */
@WebServlet("/categories.do")
public class SelectCategories extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectCategories() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Map<Category, List<String>> categoryMap = (Map<Category, List<String>>)session.getAttribute("categoryMap");
		IndexService iService = new IndexService();
		String bank = (String)request.getParameter("bank");
		if(bank==null || bank.length()<=0) {
			System.err.println("找不到名稱為"+bank+"的bank!");
			response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank);
			return;
		}
		
		try {
			List<String> countryList = null;
			if(categoryMap!=null && categoryMap.get(Category.country)!=null && !categoryMap.get(Category.country).isEmpty()) {
				countryList = categoryMap.get(Category.country);
			}else countryList = new ArrayList<String>();
			
			Map<String, String> countryMap = iService.getCountries(bank);
			for(String countryCode:countryMap.keySet()) {
				String checked = request.getParameter(countryCode);
				if(checked!=null && !countryList.contains(countryCode)) {
					countryList.add(countryCode);
				}
			}
			categoryMap.put(Category.country, countryList);
			session.setAttribute("categoryMap", categoryMap);
			
			List<Index> indexList = iService.getIndexByPage(bank, categoryMap, 1, Index.defaultPageLimit, Index.defaultOrder, false);
			request.setAttribute("categoryIndexList", indexList);
			
			response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank);
			return;
		} catch (TEDCException e) {
			this.log("依分類查詢失敗", e);
		} catch (Exception e) {
			this.log("依分類查詢失敗，發生非預期錯誤", e);
		}
		
		response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank);
	}

}
