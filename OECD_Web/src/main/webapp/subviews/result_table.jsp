<%@page import="tedc.oecd.entity.Category"%>
<%@page import="tedc.oecd.entity.Frequency"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="tedc.oecd.service.IndexService"%>
<%@page import="java.util.List"%>
<%@page import="tedc.oecd.entity.Index"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
	Map<Category, List<String>> categoryMap = (Map<Category, List<String>>)session.getAttribute("categoryMap");
	String keyword = request.getParameter("keyword");
	String pageStr = request.getParameter("page");
	String displayStr = request.getParameter("display");
	String orderBy = request.getParameter("orderBy");
	String descend = request.getParameter("desc");
	String countStr = request.getParameter("count");
	String queryString = request.getQueryString();
	if(queryString==null) queryString = "bank="+bank;
	int pageNum = 1;
	if(pageStr!=null && pageStr.matches("\\d+")){
		pageNum = Integer.parseInt(pageStr);
	}else{
		queryString += ("&page="+pageNum);
	}
	int display = Index.defaultPageLimit;
	if(displayStr!=null && displayStr.matches("\\d+")){
		display = Integer.parseInt(displayStr);
	}else{
		queryString += ("&display="+display);
	}
	if(orderBy==null || orderBy.length()<=0) {
		orderBy = Index.defaultOrder;
		queryString += ("&orderBy="+orderBy);
	}
	boolean desc = false;
	if(descend!=null){
		desc = Boolean.valueOf(descend);
	}else{
		queryString += ("&desc="+desc);
	}
	int count = 0;
	if(countStr!=null && countStr.matches("\\d+")){
		count = Integer.parseInt(countStr);
	}
	List<Index> list = null;
	IndexService iService = new IndexService();
	if(bank!=null && bank.length()>0){
		bank = bank.trim();
		list = iService.getIndexByPage(bank, keyword, categoryMap, pageNum, display, orderBy, desc);
	}
	Map<String, String> orderMap = new HashMap<>();
	orderMap.put("name", "檢索代號");
	orderMap.put("book", "國家");
	orderMap.put("form_e", "主題");
	orderMap.put("desc_e", "資料敘述");
	orderMap.put("freq", "資料頻率");
	orderMap.put("start", "起始時間");
	orderMap.put("last", "最新時間");
%>
<!-- result_table.jsp start -->
<section class="result">
<%if(list==null || list.size()<=0){ %>
	<p class="error">查無資料</p>
<%}else{%>
	<jsp:include page="/subviews/page_list.jsp" >
		<jsp:param name="bank" value="${param.bank }" />
		<jsp:param name="page" value="${param.page }" />
		<jsp:param name="display" value="${param.display }" />
		<jsp:param name="count" value="<%=count %>" />
	</jsp:include>
	<div class="modify">
		<select class="modify" onchange="location=this.value;">
			<%for(String ord:orderMap.keySet()){%>
			<option value="<%= request.getRequestURI()+"?"+queryString.replace("orderBy="+orderBy, "orderBy="+ord).replace("page="+pageNum, "page=1")%>" <%=(ord.equals(orderBy))?"selected":"" %>>依<%=orderMap.get(ord) %>排序</option>
			<%} %>
	  	</select>
	  	<select class="modify" onchange="location=this.value;">
			<option value="<%= request.getRequestURI()+"?"+queryString.replace("&desc="+desc, "")%>" <%=(desc)?"":"selected" %>>順序排列</option>
			<option value="<%= request.getRequestURI()+"?"+queryString.replace("desc="+desc, "desc=true")%>" <%=(desc)?"selected":"" %>>倒序排列</option>
	  	</select>
		<select class="modify" onchange="location=this.value;">
			<%int[] displayList = {5,10,20,50,100};
			for(int d:displayList){%>
			<option value="<%= request.getRequestURI()+"?"+queryString.replace("display="+display, "display="+d).replace("page="+pageNum, "page=1")%>" <%=(d==display)?"selected":"" %>>顯示<%=d %>個項目</option>
			<%} %>
	  	</select>
	</div>
	<form autocomplete="off" method="POST" action="">
	<table class="result">
		<thead><tr><td>請勾選</td><td>檢索代號</td><td>資料頻率</td><td>資料敘述</td></tr></thead>
		<tbody>
			<%for(Index index:list){ %>
			<tr>
				<td class="slim checkbox"><input type="checkbox" name="<%=index.getName()%>"></td>
				<td><%=index.getName() %></td>
				<%if(index.getTimeRange().getFreq().equals(Frequency.Q)){ %>
				<td class="slim quarterly"><%=index.getTimeRange().getFreq().getDescription() %></td>
				<%}else if(index.getTimeRange().getFreq().equals(Frequency.M)){ %>
				<td class="slim monthly"><%=index.getTimeRange().getFreq().getDescription() %></td>
				<%}else{ %>
				<td class="slim"><%=index.getTimeRange().getFreq().getDescription() %></td>
				<%} %>
				<td class="desc">
					<p><%=index.getDescription() %></p>
					<p>國家: <%=index.getCountry() %></p>
					<p>主題: <%=index.getSubject() %></p>
					<p>時間範圍: <%=index.getTimeRange().getStartTimeString() %>~<%=index.getTimeRange().getEndTimeString() %></p>
					<p>單位: <%=index.getUnit() %></p>
					<%=(index.getReference()!=null)?"<p>基準時間: "+index.getReference()+"</p>":"" %>
				</td>
			</tr>
			<%} %>
		</tbody>
	</table>
	</form>
	<jsp:include page="/subviews/page_list.jsp" >
		<jsp:param name="bank" value="${param.bank }" />
		<jsp:param name="page" value="${param.page }" />
		<jsp:param name="display" value="${param.display }" />
		<jsp:param name="count" value="<%=count %>" />
	</jsp:include>
<%} %>
</section>
<!-- result_table.jsp end -->