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
	Map<String, String> countryMap = iService.getCountries(bank);
	int mapSize = countryMap.size();
%>
<!-- searchBy_country.jsp start -->
<section class="result">
<%if(countryMap==null || mapSize<=0){ %>
	<p class="error">查無國家資料</p>
<%}else{%>
	<form autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
	<input class="total" type="hidden" data-total="<%=mapSize%>">
	<input type="hidden" name="bank" value="${param.bank }">
	<input type="hidden" name="category" value="${param.category }">
	<div class="selection">
		<section class="selection">
			<input class='selection' type='button' name='selectAll' value='全選 ( Check ALL boxes )' onclick='selectHandler(this)'>
			<input class='selection' type='button' name='cancelAll' value='全部清除 ( Clear ALL checked )' onclick='selectHandler(this)'>
			<p class='selection'>已選取<span class="categories"><%=categorySize %></span>個國家或組織(<span class="categories"><%=categorySize %></span> selected)</p>
		</section>
		<section class="submit">
			<input class='submit' type='submit' value='送出選取Submit'>
		</section>
	</div>
	<ul class="country">
		<li>
			<table class="result country">
				<thead><tr><td>請勾選</td><td>國名(country)/組織名(organization)</td></tr></thead>
				<tbody>
				<%int count = 1;
				for(String countryCode:countryMap.keySet()){
					if(count>Math.ceil(mapSize*1D/2)){
						count = 1;%>
					</tbody>
			</table>
		</li>
		<li>
			<table class="result country">
				<thead><tr><td>請勾選</td><td>國名/組織名</td></tr></thead>
				<tbody>
					<%} %>
					<tr>
						<td class="slim checkbox"><input class="category" type="checkbox" name="<%=countryCode%>"></td>
						<td><%=countryMap.get(countryCode) %></td>
					</tr>
				<%count++;
				} %>
				</tbody>
			</table>
		</li>
	</ul>
	</form>
<%} %>
</section>
<!-- searchBy_country.jsp end -->