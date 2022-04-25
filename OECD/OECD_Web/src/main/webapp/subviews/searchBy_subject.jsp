<%@page import="java.util.List"%>
<%@page import="tedc.oecd.entity.Category"%>
<%@page import="java.util.Map"%>
<%@page import="tedc.oecd.service.IndexService"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
	String categorySizeStr = request.getParameter("categorySize");
	int categorySize = 0;
	if(categorySizeStr!=null && categorySizeStr.matches("\\d+")){
		categorySize = Integer.valueOf(categorySizeStr);
	}
	IndexService iService = new IndexService();
	List<String> subjectList = iService.getSubjects(bank);
	int listSize = subjectList.size();
%>
<!-- searchBy_subject.jsp start -->
<section class="result">
<%if(subjectList==null || listSize<=0){ %>
	<p class="error">查無主題資料</p>
<%}else{%>
	<form autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
	<input class="total" type="hidden" data-total="<%=listSize%>">
	<input type="hidden" name="bank" value="${param.bank }">
	<input type="hidden" name="category" value="${param.category }">
	<div class="selection">
		<section class="selection">
			<input class='selection' type='button' name='selectAll' value='全選 ( Check ALL boxes )' onclick='selectHandler(this)'>
			<input class='selection' type='button' name='cancelAll' value='全部清除 ( Clear ALL checked )' onclick='selectHandler(this)'>
			<p class='selection'>已選取<span class="categories"><%=categorySize %></span>個主題(<span class="categories"><%=categorySize %></span> selected)</p>
		</section>
		<section class="submit">
			<input class='submit' type='submit' value='送出選取Submit'>
		</section>
	</div>
	<table class="result">
		<thead><tr><td>請勾選</td><td>主題(topic)</td></tr></thead>
		<tbody>
		<%int count = 1;
		for(String subject:subjectList){%>
			<tr>
				<td class="slim checkbox"><input class="category" type="checkbox" name="<%=subject%>"></td>
				<td><%=subject %></td>
			</tr>
		<%} %>
		</tbody>
	</table>
	</form>
<%} %>
</section>
<!-- searchBy_subject.jsp end -->