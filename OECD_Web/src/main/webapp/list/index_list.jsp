<%@page import="tedc.oecd.entity.Category"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="tedc.oecd.entity.Frequency"%>
<%@page import="tedc.oecd.service.IndexService"%>
<%@page import="tedc.oecd.entity.Index"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
	Map<Category, List<String>> categoryMap = (Map<Category, List<String>>)session.getAttribute("categoryMap");
	String keyword = request.getParameter("keyword");
	String category = request.getParameter("category");
	int count = 0;
	IndexService iService = new IndexService();
	if(bank!=null){
		bank = bank.trim();
		if(keyword!=null && keyword.length()>0){
			count = iService.getTotalCounts(bank, keyword);
		}else if(categoryMap!=null){
			count = iService.getTotalCounts(bank, categoryMap);
		}else{
			count = iService.getTotalCounts(bank, "");
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AREMOS OECD 統計資料庫網路版</title>
<link href="<%= request.getContextPath() %>/css/main_template.css" type="text/css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/javascript/main_template.js"></script>
<script type="text/javascript">
$(document).ready(init);
function init(){
	repopulateForm();
}
function repopulateForm(){
	$("input[name='keyword']").val('${param.keyword}');
}
</script>
</head>
<body>
	<jsp:include page="/subviews/mainHeader.jsp" />
	<nav class="bank">
		<div class="title">
		<%if(bank!=null && bank.equals("qnia")){ %>
			<h1 class="title">季度國民所得與會計帳</h1>
			<h1 class="title">Quarterly National Accounts (QNIA)</h1>
		<%}else if(bank!=null && bank.equals("mei")){ %>
			<h1 class="title">每月總體經濟指標</h1>
			<h1 class="title">Monthly Economic Indicators (MEI)</h1>
		<%} %>
		</div>
		<p>資料出處： 經濟合作暨發展組織</p>
		<p>Source: Organization for Economic Cooperation and Development (OECD)</p>
	</nav>
	<main>
		<aside id="left"></aside>
		<section>
			<div class="main">
				<div class="search">
					<p>搜尋結果</p>
					<p>共<%=count %>筆資料</p>
					<table class="search">
						<thead><tr><td>分類查詢</td></tr></thead>
						<tbody>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=country">依國家查詢</a></td></tr>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=subject">依主題查詢</a></td></tr>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=frequency">依資料頻率查詢</a></td></tr>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=name">依檢索代號查詢</a></td></tr>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=description">依資料敘述查詢</a></td></tr>
						</tbody>
					</table>
					<br>
					<span>本搜尋系統輸入英文字母並不分別大小寫。大寫或小寫均接受，而視為相同。又查詢文字串可用“,”(代表 and，即交集) 或者“*”(代表 or，即聯集) 連結起來。例如：France,GDP或者France*GDP</span><br>
				</div>
				<div class="result">
					<form id="submitKey" autocomplete="off" method="GET">
						<div class="keyword">
							<input type="hidden" name="bank" value="${param.bank }">
							<input type="search" class="keyword" name="keyword" placeholder="輸入關鍵字" autofocus>
							<input type="submit" id="search" value="">
						</div>
					</form>
					<%if(category!=null && Category.checkCategory(category)){ %>
					<jsp:include page="/subviews/searchBy_${param.category }.jsp" >
						<jsp:param name="bank" value="${param.bank }" />
					</jsp:include>
					<%}else{ %>
					<jsp:include page="/subviews/result_table.jsp" >
						<jsp:param name="bank" value="${param.bank }" />
						<jsp:param name="keyword" value="${param.keyword }" />
						<jsp:param name="count" value="<%=count %>" />
					</jsp:include>
					<%} %>
				</div>
			</div>
		</section>
		<aside id="right"></aside>
	</main>
	<jsp:include page="/subviews/mainFooter.jsp" />
</body>
</html>