<%@page import="tedc.oecd.entity.Frequency"%>
<%@page import="tedc.oecd.service.IndexService"%>
<%@page import="tedc.oecd.entity.Index"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
	String pageStr = request.getParameter("page");
	String displayStr = request.getParameter("display");
	int pageNum = 1;
	if(pageStr!=null && pageStr.matches("\\d+")){
		pageNum = Integer.parseInt(pageStr);
	}
	int display = Index.pageLimit;
	if(displayStr!=null && displayStr.matches("\\d+")){
		display = Integer.parseInt(displayStr);
	}
	List<Index> list = null;
	int count = 0;
	IndexService iService = new IndexService();
	if(bank!=null){
		bank = bank.trim();
		list = iService.getIndexByPage(bank, pageNum, display);
		count = iService.getTotalCounts(bank);
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
</head>
<body>
	<jsp:include page="/subviews/mainHeader.jsp" />
	<nav class="bank">
		<div class="title">
		<%if(bank.equals("qnia")){ %>
			<h1 class="title">季度國民所得與會計帳</h1>
			<h1 class="title">Quarterly National Accounts (QNIA)</h1>
		<%}else if(bank.equals("mei")){ %>
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
		<form autocomplete="off" method="POST" action="">
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
				</div>
				<div class="result">
					<div class="keyword">
						<input type="search" class="keyword" name="keyword" placeholder="輸入關鍵字" autofocus>
						<input type="submit" id="search" value="">
					</div>
					<section class="result">
					<%if(list==null || list.size()<=0){ %>
						<p class="error">查無資料</p>
					<%}else{
						int pageTotal = (int)Math.ceil(count*1D/display);%>
						<ul class="pages">
							<li><a href="<%=request.getRequestURI() %>?bank=<%=bank%>&page=1">第一頁</a></li>
							<li><a href="<%=(pageNum-1>0)?request.getRequestURI()+"?bank="+bank+"&page="+(pageNum-1):""%>">上一頁</a></li>
							<%if(pageNum-4>2){%>
								<li>...</li>
							<%}
							for(int i=pageNum-4; i<=pageNum+4; i++){ 
								if(i>0 && i<=pageTotal){%>
									<li><a href="<%= request.getRequestURI()+"?bank="+bank+"&page="+i%>"><%=(i==pageNum)?"<b>"+i+"</b>":i %></a></li>
								<%} %>
							<%} %>
							<%if(pageNum+4<pageTotal-1){%>
								<li>...</li>
							<%}%>
							<li><a href="<%=(pageNum+1<=pageTotal)?request.getRequestURI()+"?bank="+bank+"&page="+(pageNum+1):""%>">下一頁</a></li>
							<li><a href="<%=request.getRequestURI() %>?bank=<%=bank%>&page=<%=pageTotal%>">最後一頁</a></li>
						</ul>
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
										<p>時間範圍: <%=index.getTimeRange().getStartTimeString() %>~<%=index.getTimeRange().getEndTimeString() %></p>
										<p>單位: <%=index.getUnit() %></p>
										<%=(index.getReference()!=null)?"<p>基準時間: "+index.getReference()+"</p>":"" %>
									</td>
								</tr>
								<%} %>
							</tbody>
						</table>
						<ul class="pages">
							<li><a href="<%=request.getRequestURI() %>?bank=<%=bank%>&page=1">第一頁</a></li>
							<li><a href="<%=(pageNum-1>0)?request.getRequestURI()+"?bank="+bank+"&page="+(pageNum-1):""%>">上一頁</a></li>
							<%if(pageNum-4>2){%>
								<li>...</li>
							<%}
							for(int i=pageNum-4; i<=pageNum+4; i++){ 
								if(i>0 && i<=pageTotal){%>
									<li><a href="<%= request.getRequestURI()+"?bank="+bank+"&page="+i%>"><%=(i==pageNum)?"<b>"+i+"</b>":i %></a></li>
								<%} %>
							<%} %>
							<%if(pageNum+4<pageTotal-1){%>
								<li>...</li>
							<%}%>
							<li><a href="<%=(pageNum+1<=pageTotal)?request.getRequestURI()+"?bank="+bank+"&page="+(pageNum+1):""%>">下一頁</a></li>
							<li><a href="<%=request.getRequestURI() %>?bank=<%=bank%>&page=<%=pageTotal%>">最後一頁</a></li>
						</ul>
					<%} %>
					</section>
				</div>
			</div>
		</form>
		</section>
		<aside id="right"></aside>
	</main>
	<jsp:include page="/subviews/mainFooter.jsp" />
</body>
</html>