<%@page import="java.time.Year"%>
<%@page import="tedc.oecd.entity.Index"%>
<%@page import="java.util.Set"%>
<%@page import="tedc.oecd.entity.Frequency"%>
<%@page import="tedc.oecd.entity.Cart"%>
<%@ page pageEncoding="utf-8"%>
<%
	Cart cart = (Cart)session.getAttribute("cart");
	Set<Index> indexSet = null;
	if(cart!=null){
		indexSet = cart.getSetByFrequency(Frequency.M);
	}
%>
<!-- monthly.jsp start -->
<div id='monthly' class='orders'>
	<section class="order">
	<%if(cart==null || indexSet==null || indexSet.isEmpty()){ %>
		<p class="error">查無<%=Frequency.M.getDescription() %></p>
	<%}else{ %>
		<form class="cart" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/update_cart.do">
		<table class="result cart">
			<thead><tr><td>資料庫</td><td>檢索代號</td><td>資料敘述</td><td>國家</td><td>主題</td><td>起始時間</td><td>最新時間</td><td class="delete">可刪除</td></tr></thead>
			<tbody>
				<%for(Index index:indexSet){ %>
				<tr>
					<td><%=index.getBank() %></td>
					<td><%=index.getName() %></td>
					<td class="desc"><%=index.getDescription() %></td>
					<td><%=index.getCountry() %></td>
					<td><%=index.getSubject() %></td>
					<td><%=index.getTimeRange().getStartTimeString() %></td>
					<td><%=index.getTimeRange().getEndTimeString() %></td>
					<td class="slim checkbox delete"><input type="checkbox" name="<%=index.getName()%>"></td>
				</tr>
				<%} %>
			</tbody>
		</table>
		<section class="selection">
			<div class="delete">
				<input class='delete' type='submit' name='delete' value='刪除選取項 ( Delete checked )'>
				<input class='delete' type='submit' name='deleteAll' value='刪除所有<%=Frequency.M.getDescription() %> ( Delete ALL )'>
			</div>
		</section>
		</form>
		<form class="download" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/download_xls.do">
			<section class="timeRange">
				<span>期間設定： 
				起始
				<select class="timeRange" name="startYear">
				<%for(int i=1901; i<=Year.now().getValue(); i++){ %>
					<option value="<%=i%>" <%=(i==2000)?"selected":"" %>><%=i%>年</option>
				<%} %>
				</select>
				<select class="timeRange" name="startMonth">
				<%for(int i=1; i<=12; i++){ %>
					<option value="<%=i%>" <%=(i==1)?"selected":"" %>><%=i%>月</option>
				<%} %>
				</select>
				~結束
				<select class="timeRange" name="endYear">
				<%for(int i=1901; i<=Year.now().getValue()+2; i++){ %>
					<option value="<%=i%>" <%=(i==Year.now().getValue())?"selected":"" %>><%=i%>年</option>
				<%} %>
				</select>
				<select class="timeRange" name="endMonth">
				<%for(int i=1; i<=12; i++){ %>
					<option value="<%=i%>" <%=(i==12)?"selected":"" %>><%=i%>月</option>
				<%} %>
				</select>
				</span>
			</section>
			<div class="download"><input class="download" type="submit" value="索取<%=Frequency.M.getDescription() %>"></div>
		</form>
	<%} %>
	</section>
</div>
<!-- monthly.jsp end -->