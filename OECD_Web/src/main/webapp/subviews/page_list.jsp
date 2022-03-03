<%@page import="tedc.oecd.service.IndexService"%>
<%@page import="java.util.List"%>
<%@page import="tedc.oecd.entity.Index"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
	String pageStr = request.getParameter("page");
	String displayStr = request.getParameter("display");
	String countStr = request.getParameter("count");
	String queryString = request.getQueryString();
	if(queryString==null) queryString = "bank="+bank;
	int pageNum = 1;
	if(pageStr!=null && pageStr.matches("\\d+")){
		pageNum = Integer.parseInt(pageStr);
	}else{
		queryString += ("&page="+pageNum);
	}
	int display = Index.pageLimit;
	if(displayStr!=null && displayStr.matches("\\d+")){
		display = Integer.parseInt(displayStr);
	}else{
		queryString += ("&display="+display);
	}
	int count = 0;
	IndexService iService = new IndexService();
	if(countStr!=null && countStr.matches("\\d+")){
		count = Integer.parseInt(countStr);
	}
	int pageTotal = (int)Math.ceil(count*1D/display);
%>
<!-- page_list.jsp start -->
<ul class="pages">
	<li><a href="<%=request.getRequestURI() %>?<%=queryString.replace("page="+pageNum, "page=1")%>">第一頁</a></li>
	<li><a href="<%=(pageNum-1>0)?request.getRequestURI()+"?"+queryString.replace("page="+pageNum, "page="+(pageNum-1)):""%>">上一頁</a></li>
	<%if(pageNum-4>2){%>
		<li>...</li>
	<%}
	for(int i=pageNum-4; i<=pageNum+4; i++){ 
		if(i>0 && i<=pageTotal){%>
			<li><a href="<%= request.getRequestURI()+"?"+queryString.replace("page="+pageNum, "page="+i)%>"><%=(i==pageNum)?"<b>"+i+"</b>":i %></a></li>
		<%} %>
	<%} %>
	<%if(pageNum+4<pageTotal-1){%>
		<li>...</li>
	<%}%>
	<li><a href="<%=(pageNum+1<=pageTotal)?request.getRequestURI()+"?"+queryString.replace("page="+pageNum, "page="+(pageNum+1)):""%>">下一頁</a></li>
	<li><a href="<%=request.getRequestURI() %>?<%=queryString.replace("page="+pageNum, "page="+pageTotal)%>">最後一頁</a></li>
</ul>
<!-- page_list.jsp end -->