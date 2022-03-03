<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="tedc.oecd.entity.Frequency"%>
<%@page import="tedc.oecd.service.IndexService"%>
<%@page import="tedc.oecd.entity.Index"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
	String keyword = request.getParameter("keyword");
	String pageStr = request.getParameter("page");
	String displayStr = request.getParameter("display");
	String orderBy = request.getParameter("orderBy");
	String descend = request.getParameter("desc");
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
	if(orderBy==null) {
		orderBy = "name";
		queryString += ("&orderBy="+orderBy);
	}
	boolean desc = false;
	if(descend!=null){
		desc = Boolean.valueOf(descend);
	}else{
		queryString += ("&desc="+desc);
	}
	List<Index> list = null;
	int count = 0;
	IndexService iService = new IndexService();
	if(bank!=null){
		bank = bank.trim();
		list = iService.getIndexByPage(bank, pageNum, display, orderBy, desc);
		count = iService.getTotalCounts(bank);
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
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AREMOS OECD 統計資料庫網路版</title>
<link href="<%= request.getContextPath() %>/css/main_template.css" type="text/css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/javascript/main_template.js"></script>
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
							<tr><td>依國家查詢</td></tr>
							<tr><td>依主題查詢</td></tr>
							<tr><td>依檢索代號查詢</td></tr>
							<tr><td>依資料敘述查詢</td></tr>
							<tr><td>依資料頻率查詢</td></tr>
						</tbody>
					</table>
					<br>
					<span>本搜尋系統輸入英文字母並不分別大小寫。大寫或小寫均接受，而視為相同。又查詢文字串可用“,”(代表 and，即交集) 或者“*”(代表 or，即聯集) 連結起來。例如：unemployment,rate或者unemployment*rate</span><br>
				</div>
				<div class="result">
					<form autocomplete="off" method="GET" action="">
						<div class="keyword">
							<input type="search" class="keyword" name="keyword" placeholder="輸入關鍵字" autofocus>
							<input type="submit" id="search" value="">
						</div>
					</form>
					<section class="result">
					<%if(list==null || list.size()<=0){ %>
						<p class="error">查無資料</p>
					<%}else{%>
						<jsp:include page="/subviews/page_list.jsp" >
							<jsp:param name="bank" value="${param.bank }" />
							<jsp:param name="page" value="${param.page }" />
							<jsp:param name="display" value="${param.display }" />
						</jsp:include>
						<div class="modify">
							<select class="modify" onchange="location=this.value;">
								<%for(String ord:orderMap.keySet()){%>
								<option value="<%= request.getRequestURI()+"?"+queryString.replace("orderBy="+orderBy, "orderBy="+ord)%>" <%=(ord.equals(orderBy))?"selected":"" %>>依<%=orderMap.get(ord) %>排序</option>
								<%} %>
						  	</select>
						  	<select class="modify" onchange="location=this.value;">
								<option value="<%= request.getRequestURI()+"?"+queryString.replace("&desc="+desc, "")%>" <%=(desc)?"":"selected" %>>順序排列</option>
								<option value="<%= request.getRequestURI()+"?"+queryString.replace("desc="+desc, "desc=true")%>" <%=(desc)?"selected":"" %>>倒序排列</option>
						  	</select>
							<select class="modify" onchange="location=this.value;">
								<%int[] displayList = {5,10,20,50,100};
								for(int d:displayList){%>
								<option value="<%= request.getRequestURI()+"?"+queryString.replace("display="+display, "display="+d)%>" <%=(d==display)?"selected":"" %>>顯示<%=d %>個項目</option>
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
						</jsp:include>
					<%} %>
					</section>
				</div>
			</div>
		</section>
		<aside id="right"></aside>
	</main>
	<jsp:include page="/subviews/mainFooter.jsp" />
</body>
</html>