<%@page import="java.util.Set"%>
<%@page import="tedc.oecd.entity.Cart"%>
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
	String storedbank = (String)session.getAttribute("bank");
	if(storedbank==null) session.setAttribute("bank", bank);
	else if(!storedbank.equals(bank)){
		session.removeAttribute("categoryMap");
		session.setAttribute("bank", bank);
	}
	String keyword = request.getParameter("keyword");
	if(keyword==null){
		keyword = (String)session.getAttribute("keyword");
		if(keyword==null || keyword.length()<=0) session.removeAttribute("keyword");
	}else if(keyword.length()>0) session.setAttribute("keyword", keyword);
	else session.removeAttribute("keyword");
	Map<Category, List<String>> categoryMap = (Map<Category, List<String>>)session.getAttribute("categoryMap");
	String category = request.getParameter("category");
	int count = 0;
	IndexService iService = new IndexService();
	if(bank!=null){
		bank = bank.trim();
		count = iService.getTotalCounts(bank, keyword, categoryMap);
	}
	int categorySize = 0;
	Cart cart = (Cart)session.getAttribute("cart");
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
	$("input.keyword").val('${sessionScope.keyword }');
	
	<%if(category!=null && categoryMap!=null){
		if(category.equals(Category.country.name()) && categoryMap.get(Category.country)!=null && !categoryMap.get(Category.country).isEmpty()){
			categorySize = categoryMap.get(Category.country).size();
			for(String countryCode:categoryMap.get(Category.country)) {%>
				$("input[name='<%=countryCode%>']").prop('checked',true);
			<%}%>
		<%}else if(category.equals(Category.subject.name()) && categoryMap.get(Category.subject)!=null && !categoryMap.get(Category.subject).isEmpty()){
			categorySize = categoryMap.get(Category.subject).size();
			for(String subject:categoryMap.get(Category.subject)) {%>
				$("input[name='<%=subject%>']").prop('checked',true);
			<%}%>
		<%}else if(category.equals(Category.frequency.name()) && categoryMap.get(Category.frequency)!=null && !categoryMap.get(Category.frequency).isEmpty()){
			categorySize = categoryMap.get(Category.frequency).size();
			for(String frequency:categoryMap.get(Category.frequency)) {%>
				$("input[name='<%=frequency%>']").prop('checked',true);
			<%}%>
		<%}else if(category.equals(Category.name.name()) && categoryMap.get(Category.name)!=null && !categoryMap.get(Category.name).isEmpty()){
			String nameStr = "";
			for(String name:categoryMap.get(Category.name)) {
				nameStr += ("*"+name);
			}%>
			$("textarea[name='name']").val('<%=nameStr.replaceFirst("\\*", "")%>');
		<%}else if(category.equals(Category.description.name()) && categoryMap.get(Category.description)!=null && !categoryMap.get(Category.description).isEmpty()){
			String descriptionStr = "";
			for(String description:categoryMap.get(Category.description)) {
				descriptionStr += ("*"+description);
			}%>
			$("textarea[name='description']").val('<%=descriptionStr.replaceFirst("\\*", "")%>');
		<%}%>
	<%}%>
	
	<%if(cart!=null){
		for(Frequency freq:cart.keySet()){
			Set<Index> set = cart.getSetByFrequency(freq);
			for(Index index:set){%>
				$("input[name='<%=index.getName()%>']").prop('checked',true);
			<%}
		}
	}%>
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
					<p><a href="<%=request.getContextPath()+"/list/index_list.jsp?bank="+bank+(keyword!=null&&keyword.length()>0?"&keyword="+keyword:"") %>">搜尋結果(Results)</a></p>
					<p>共<%=count %>筆資料</p>
					<%if(categoryMap!=null){
						if(categoryMap.get(Category.country)!=null && !categoryMap.get(Category.country).isEmpty()){%>
						<form class="refine" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
							<input type="hidden" name="bank" value="${param.bank }">
							<input type="hidden" name="catDel" value="<%=Category.country.name() %>">
							<span class="refine"><span>已篩選<%=categoryMap.get(Category.country).size() %>個國家或組織<br>
							(<%=categoryMap.get(Category.country).size()>1?categoryMap.get(Category.country).size()+" countries":categoryMap.get(Category.country).size()+" country" %> refined)</span>
							<button type="submit" class="catDel">x</button></span>
						</form>
						<%} 
						if(categoryMap.get(Category.subject)!=null && !categoryMap.get(Category.subject).isEmpty()){%>
						<form class="refine" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
							<input type="hidden" name="bank" value="${param.bank }">
							<input type="hidden" name="catDel" value="<%=Category.subject.name() %>">
							<span class="refine"><span>已篩選<%=categoryMap.get(Category.subject).size() %>個主題<br>
							(<%=categoryMap.get(Category.subject).size()>1?categoryMap.get(Category.subject).size()+" topics":categoryMap.get(Category.subject).size()+" topic" %> refined)</span>
							<button type="submit" class="catDel">x</button></span>
						</form>
						<%}
						if(categoryMap.get(Category.frequency)!=null && !categoryMap.get(Category.frequency).isEmpty()){%>
						<form class="refine" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
							<input type="hidden" name="bank" value="${param.bank }">
							<input type="hidden" name="catDel" value="<%=Category.frequency.name() %>">
							<span class="refine"><span>已篩選<%=categoryMap.get(Category.frequency).size() %>個頻率<br>
							(<%=categoryMap.get(Category.frequency).size()>1?categoryMap.get(Category.frequency).size()+" frequencies":categoryMap.get(Category.frequency).size()+" frequency" %> refined)</span>
							<button type="submit" class="catDel">x</button></span>
						</form>
						<%} 
						if(categoryMap.get(Category.name)!=null && !categoryMap.get(Category.name).isEmpty()){%>
						<form class="refine" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
							<input type="hidden" name="bank" value="${param.bank }">
							<input type="hidden" name="catDel" value="<%=Category.name.name() %>">
							<span class="refine"><span>已篩選指定的檢索代號<br>
							(Names refined)</span>
							<button type="submit" class="catDel">x</button></span>
						</form>
						<%} 
						if(categoryMap.get(Category.description)!=null && !categoryMap.get(Category.description).isEmpty()){%>
						<form class="refine" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
							<input type="hidden" name="bank" value="${param.bank }">
							<input type="hidden" name="catDel" value="<%=Category.description.name() %>">
							<span class="refine"><span>已篩選指定的資料敘述<br>
							(Descriptions refined)</span>
							<button type="submit" class="catDel">x</button></span>
						</form>
						<%} %>
					<%} %>
					<table class="search">
						<thead><tr><td>分類查詢<br>Refine your search</td></tr></thead>
						<tbody>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=country">依國家篩選<br>(Countries)</a></td></tr>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=subject">依主題篩選<br>(Topics)</a></td></tr>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=frequency">依資料頻率篩選<br>(Frequencies)</a></td></tr>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=name">依檢索代號篩選<br>(Names)</a></td></tr>
							<tr><td><a href="<%=request.getRequestURI() %>?bank=<%=bank %>&category=description">依資料敘述篩選<br>(Descriptions)</a></td></tr>
						</tbody>
					</table>
					<br>
					<span>本搜尋系統輸入英文字母並不分別大小寫。
					大寫或小寫均接受，而視為相同(Case-insensitive)。
					又查詢文字串可用“,”(代表 and，即交集) 或者“*”(代表 or，即聯集) 連結起來。
					例如：France,GDP或者France*GDP</span><br>
				</div>
				<div class="result">
					<form id="submitKey" autocomplete="off" method="GET">
						<div class="keyword">
							<input type="hidden" name="bank" value="${param.bank }">
							<input type="search" class="keyword" name="keyword" placeholder="輸入關鍵字(keyword search)">
							<input type="submit" id="search" value="">
						</div>
					</form>
					<form class="clearKeyword" autocomplete="off" method="GET">
						<input type="hidden" name="bank" value="${param.bank }">
						<input type="hidden" name="keyword" value="">
						<input type="submit" value="清除關鍵字(Clear)">
					</form>
					<%if(category!=null && Category.checkCategory(category)){ %>
					<jsp:include page="/subviews/searchBy_${param.category }.jsp" >
						<jsp:param name="bank" value="${param.bank }" />
						<jsp:param name="category" value="${param.category }" />
						<jsp:param name="categorySize" value="<%=categorySize %>" />
					</jsp:include>
					<%}else{ %>
					<jsp:include page="/subviews/result_table.jsp" >
						<jsp:param name="bank" value="${param.bank }" />
						<jsp:param name="keyword" value="${sessionScope.keyword }" />
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