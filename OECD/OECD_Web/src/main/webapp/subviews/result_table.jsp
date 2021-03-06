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
	orderMap.put("name", "?????????????????????");
	orderMap.put("book", "???????????????");
	orderMap.put("form_e", "???????????????");
	orderMap.put("desc_e", "?????????????????????");
	orderMap.put("freq", "?????????????????????");
	orderMap.put("start", "?????????????????????");
	orderMap.put("last", "?????????????????????");
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
	<p class="error">????????????(No items found)</p>
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
			<input class='selection items' type='button' name='selectAll' value='?????? ( Check ALL boxes )' onclick='submitCart(this)'>
			<input class='selection items' type='button' name='cancelAll' value='???????????? ( Clear ALL checked )' onclick='submitCart(this)'>
		</section>
		<div class="modify">
			<section class="modify">
				<p>????????????</p>
				<select class="modify" onchange="location=this.value;">
					<%for(String ord:orderMap.keySet()){%>
					<option title="<%=orderMap.get(ord) %>" value="<%= request.getRequestURI()+"?"+queryString.replace("orderBy="+orderBy, "orderBy="+ord).replace("page="+pageNum, "page=1")%>" <%=(ord.equals(orderBy))?"selected":"" %>>
					<%=orderEnMap.get(ord) %></option>
					<%} %>
			  	</select>
			</section>
			<section class="modify">
				<p>??????/??????</p>
			  	<select class="modify" onchange="location=this.value;">
					<option title="????????????" value="<%= request.getRequestURI()+"?"+queryString.replace("&desc="+desc, "")%>" <%=(desc)?"":"selected" %>>Ascending</option>
					<option title="????????????" value="<%= request.getRequestURI()+"?"+queryString.replace("desc="+desc, "desc=true")%>" <%=(desc)?"selected":"" %>>Descending</option>
			  	</select>
			</section>
			<section class="modify">  
				<p>????????????</p>
				<select class="modify" onchange="location=this.value;">
					<%int[] displayList = {5,10,20,50,100};
					for(int d:displayList){%>
					<option title="??????<%=d %>?????????" value="<%= request.getRequestURI()+"?"+queryString.replace("display="+display, "display="+d).replace("page="+pageNum, "page=1")%>" <%=(d==display)?"selected":"" %>>
					display by <%=d %></option>
					<%} %>
			  	</select>
			 </section>
		</div>
	</div>
	<table class="result">
		<thead><tr><td>?????????</td><td>????????????<br>(name)</td><td>????????????</td><td>????????????<br>(Description)</td></tr></thead>
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
					<p>??????(Country): <%=index.getCountry() %></p>
					<p>??????(Subject): <%=index.getSubject() %></p>
					<p>????????????(Time range): <%=index.getTimeRange().getStartTimeString() %>~<%=index.getTimeRange().getEndTimeString() %></p>
					<p>??????(Unit): <%=index.getUnit() %></p>
					<%=(index.getReference()!=null)?"<p>????????????(Reference): "+index.getReference()+"</p>":"" %>
				</td>
			</tr>
			<%} %>
		</tbody>
	</table>
	<div id="gotoCart"><p class="cart">?????????<span class="cart"><%=(cart!=null)?cart.getTotalSize():0 %></span>?????????<br>(<span class="cart"><%=(cart!=null)?cart.getTotalSize():0 %></span> items included)</p>
	<a href="<%= request.getContextPath() %>/cart/retrieving_list"><span class="zh">??????????????????</span><span>(Go to retrieving list)</span></a></div>
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