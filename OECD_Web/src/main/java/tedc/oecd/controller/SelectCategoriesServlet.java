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
import tedc.oecd.entity.Frequency;
import tedc.oecd.exception.TEDCException;
import tedc.oecd.service.IndexService;

/**
 * Servlet implementation class SelectCategories
 */
@WebServlet("/categories.do")
public class SelectCategoriesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectCategoriesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String keyword = (String)session.getAttribute("keyword");
		if(keyword==null) keyword = "";
		Map<Category, List<String>> categoryMap = (Map<Category, List<String>>)session.getAttribute("categoryMap");
		IndexService iService = new IndexService();
		String bank = (String)request.getParameter("bank");
		String delete = (String)request.getParameter("catDel");
		String category = (String)request.getParameter("category");
		if(bank==null || bank.length()<=0) {
			System.err.println("找不到名稱為"+bank+"的bank!");
			response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank+(keyword.length()>0?"&keyword="+keyword:""));
			return;
		}
		if(delete!=null) {
			if(categoryMap==null) {
				System.err.println("不存在categoryMap!");
				response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank+(keyword.length()>0?"&keyword="+keyword:""));
				return;
			}else if(!Category.checkCategory(delete)) {
				System.err.println("找不到名稱為"+delete+"的category!");
				response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank+(keyword.length()>0?"&keyword="+keyword:""));
				return;
			}
			categoryMap.remove(Category.valueOf(delete));
			response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank+(keyword.length()>0?"&keyword="+keyword:""));
			return;
		}
		if(category==null || !Category.checkCategory(category)) {
			System.err.println("找不到名稱為"+category+"的category!");
			response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank+(keyword.length()>0?"&keyword="+keyword:""));
			return;
		}
		
		try {
			if(categoryMap==null) {
				categoryMap = new TreeMap<>();
			}
			
			if(category.equals(Category.country.name())) {
				List<String> countryList = new ArrayList<String>();
				
				Map<String, String> countryMap = iService.getCountries(bank);
				for(String countryCode:countryMap.keySet()) {
					String checked = request.getParameter(countryCode);
					if(checked!=null) {
						countryList.add(countryCode);
					}
				}
				categoryMap.put(Category.country, countryList);
			}else if(category.equals(Category.subject.name())) {
				List<String> subjectList = new ArrayList<String>();
				
				List<String> subjectIndex = iService.getSubjects(bank);
				for(String subject:subjectIndex) {
					String checked = request.getParameter(subject);
					if(checked!=null) {
						subjectList.add(subject);
					}
				}
				categoryMap.put(Category.subject, subjectList);
			}else if(category.equals(Category.frequency.name())) {
				List<String> frequencyList = new ArrayList<String>();
				
				List<Frequency> frequencyIndex = iService.getFrequencies(bank);
				for(Frequency freq:frequencyIndex) {
					String checked = request.getParameter(freq.name());
					if(checked!=null) {
						frequencyList.add(freq.name());
					}
				}
				categoryMap.put(Category.frequency, frequencyList);
			}else if(category.equals(Category.name.name())) {
				String nameStr = request.getParameter("name");
				if(nameStr==null) nameStr = "";
				List<String> nameList = new ArrayList<String>();
				
				String[] nameOrList = nameStr.split("\\*");
				for(int i=0; i<nameOrList.length; i++) {
					nameList.add(nameOrList[i]);
				}
				categoryMap.put(Category.name, nameList);
			}else if(category.equals(Category.description.name())) {
				String descriptionStr = request.getParameter("description");
				if(descriptionStr==null) descriptionStr = "";
				List<String> descriptionList = new ArrayList<String>();
				
				String[] descriptionOrList = descriptionStr.split("\\*");
				for(int i=0; i<descriptionOrList.length; i++) {
					descriptionList.add(descriptionOrList[i]);
				}
				categoryMap.put(Category.description, descriptionList);
			}
			
			session.setAttribute("categoryMap", categoryMap);
			//System.out.println(categoryMap);
			response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank+(keyword.length()>0?"&keyword="+keyword:""));
			return;
		} catch (TEDCException e) {
			this.log("依分類查詢失敗", e);
		} catch (Exception e) {
			this.log("依分類查詢失敗，發生非預期錯誤", e);
		}
		
		response.sendRedirect(request.getContextPath()+"/list/index_list.jsp?bank="+bank+(keyword.length()>0?"&keyword="+keyword:""));
	}

}
