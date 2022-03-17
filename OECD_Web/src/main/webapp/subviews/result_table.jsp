<%@page import="java.util.HashSet"%>
<%@page import="tedc.oecd.entity.Cart"%>
<%@page import="tedc.oecd.entity.Category"%>
<%@page import="tedc.oecd.entity.Frequency"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="tedc.oecd.service.IndexService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="tedc.oecd.entity.Index"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
	Map<Category, List<String>> categoryMap = (Map<Category, List<String>>)session.getAttribute("categoryMap");
	Cart cart = (Cart)session.getAttribute("cart");
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
		Set<Index> indexSet = new HashSet<>(list);
		session.setAttribute("indexSet", indexSet);
	}
	Map<String, String> orderMap = new HashMap<>();
	orderMap.put("name", "依檢索代號排序");
	orderMap.put("book", "依國家排序");
	orderMap.put("form_e", "依主題排序");
	orderMap.put("desc_e", "依資料敘述排序");
	orderMap.put("freq", "依資料頻率排序");
	orderMap.put("start", "依起始時間排序");
	orderMap.put("last", "依最新時間排序");
	Map<String, String> orderEnMap = new HashMap<>();
	orderEnMap.put("name", "Sort by name");
	orderEnMap.put("book", "Sort by country");
	orderEnMap.put("form_e", "Sort by topic");
	orderEnMap.put("desc_e", "Sort by description");
	orderEnMap.put("freq", "Sort by frequency");
	orderEnMap.put("start", "Sort by start time");
	orderEnMap.put("last", "Sort by last time");
%>
<!-- result_table.jsp start -->
<section class="result">
<%if(list==null || list.size()<=0){ %>
	<p class="error">查無資料(No items found)</p>
<%}else{%>
	<jsp:include page="/subviews/page_list.jsp" >
		<jsp:param name="bank" value="${param.bank }" />
		<jsp:param name="page" value="${param.page }" />
		<jsp:param name="display" value="${param.display }" />
		<jsp:param name="count" value="<%=count %>" />
	</jsp:include>
	<form id="table" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/add_to_cart.do" onsubmit="return submitCart(this)">
	<input type="hidden" name="bank" value="${param.bank }">
	<input type="hidden" name="keyword" value="${param.keyword }">
	<div class="selection">
		<section class="selection">
			<input class='selection items' type='button' name='selectAll' value='全選 ( Check ALL boxes )' onclick='submitCart(this)'>
			<input class='selection items' type='button' name='cancelAll' value='全部清除 ( Clear ALL checked )' onclick='submitCart(this)'>
		</section>
		<div class="modify">
			<section class="modify">
				<p>排序基準</p>
				<select class="modify" onchange="location=this.value;">
					<%for(String ord:orderMap.keySet()){%>
					<option title="<%=orderMap.get(ord) %>" value="<%= request.getRequestURI()+"?"+queryString.replace("orderBy="+orderBy, "orderBy="+ord).replace("page="+pageNum, "page=1")%>" <%=(ord.equals(orderBy))?"selected":"" %>>
					<%=orderEnMap.get(ord) %></option>
					<%} %>
			  	</select>
			</section>
			<section class="modify">
				<p>順序/倒序</p>
			  	<select class="modify" onchange="location=this.value;">
					<option title="順序排列" value="<%= request.getRequestURI()+"?"+queryString.replace("&desc="+desc, "")%>" <%=(desc)?"":"selected" %>>Ascending</option>
					<option title="倒序排列" value="<%= request.getRequestURI()+"?"+queryString.replace("desc="+desc, "desc=true")%>" <%=(desc)?"selected":"" %>>Descending</option>
			  	</select>
			</section>
			<section class="modify">  
				<p>顯示數量</p>
				<select class="modify" onchange="location=this.value;">
					<%int[] displayList = {5,10,20,50,100};
					for(int d:displayList){%>
					<option title="顯示<%=d %>個項目" value="<%= request.getRequestURI()+"?"+queryString.replace("display="+display, "display="+d).replace("page="+pageNum, "page=1")%>" <%=(d==display)?"selected":"" %>>
					display by <%=d %></option>
					<%} %>
			  	</select>
			 </section>
		</div>
	</div>
	<table class="result">
		<thead><tr><td>請勾選</td><td>檢索代號<br>(name)</td><td>資料頻率</td><td>資料敘述<br>(Description)</td></tr></thead>
		<tbody>
			<%for(Index index:list){ %>
			<tr>
				<td class="slim checkbox"><input type="checkbox" name="<%=index.getName()%>" onchange='submitCart(this)'></td>
				<td><%=index.getName() %></td>
				<%if(index.getTimeRange().getFreq().equals(Frequency.Q)){ %>
				<td class="slim quarterly"><%=index.getTimeRange().getFreq().getDescription()+"("+index.getTimeRange().getFreq().name()+")" %></td>
				<%}else if(index.getTimeRange().getFreq().equals(Frequency.M)){ %>
				<td class="slim monthly"><%=index.getTimeRange().getFreq().getDescription()+"("+index.getTimeRange().getFreq().name()+")" %></td>
				<%}else{ %>
				<td class="slim"><%=index.getTimeRange().getFreq().getDescription()+"("+index.getTimeRange().getFreq().name()+")" %></td>
				<%} %>
				<td class="desc">
					<p><%=index.getDescription() %></p>
					<p>國家(Country): <%=index.getCountry() %></p>
					<p>主題(Subject): <%=index.getSubject() %></p>
					<p>時間範圍(Time range): <%=index.getTimeRange().getStartTimeString() %>~<%=index.getTimeRange().getEndTimeString() %></p>
					<p>單位(Unit): <%=index.getUnit() %></p>
					<%=(index.getReference()!=null)?"<p>基準時間(Reference): "+index.getReference()+"</p>":"" %>
				</td>
			</tr>
			<%} %>
		</tbody>
	</table>
	<div id="gotoCart"><p class="cart">已放入<span class="cart"><%=(cart!=null)?cart.getTotalSize():0 %></span>筆資料<br>(<span class="cart"><%=(cart!=null)?cart.getTotalSize():0 %></span> items included)</p>
	<a href="<%= request.getContextPath() %>/cart/retrieving_list"><span class="zh">前往索取清單</span><span>(Go to retrieving list)</span></a></div>
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