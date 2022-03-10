<%@page import="java.time.Year"%>
<%@page import="org.threeten.extra.YearQuarter"%>
<%@page import="tedc.oecd.entity.Index"%>
<%@page import="java.util.Set"%>
<%@page import="tedc.oecd.entity.Frequency"%>
<%@page import="tedc.oecd.entity.Cart"%>
<%@ page pageEncoding="utf-8"%>
<%
	Cart cart = (Cart)session.getAttribute("cart");
	String freq = request.getParameter("freq");
	Set<Index> indexSet = null;
	if(cart!=null){
		indexSet = cart.getSetByFrequency(Frequency.Q);
	}
%>
<!-- quarterly.jsp start -->
<div id='quarterly' class='orders <%=(freq!=null&&freq.equals(Frequency.Q.name()))?"target":"" %>'>
	<section class="order">
	<%if(cart==null || indexSet==null || indexSet.isEmpty()){ %>
		<p class="error">查無<%=Frequency.Q.getDescription() %></p>
	<%}else{ %>
		<form class="cart" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/update_cart.do">
		<input type="hidden" name="frequency" value="<%=Frequency.Q.name()%>">
		<div class="cart">
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
						<td class="time"><%=index.getTimeRange().getStartTimeString() %></td>
						<td class="time"><%=index.getTimeRange().getEndTimeString() %></td>
						<td class="slim checkbox delete"><input type="checkbox" name="<%=index.getName()%>"></td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		<section class="selection">
			<p>共<%=cart.getSetSizeByFrequency(Frequency.Q) %>筆</p>
			<div class="delete">
				<input class='delete' type='submit' name='delete' value='刪除選取項 ( Delete checked )'>
				<input class='delete' type='submit' name='deleteAll' value='刪除所有<%=Frequency.Q.getDescription() %> ( Delete ALL )'>
			</div>
		</section>
		</form>
		<form class="download" autocomplete="off" method="POST" action="<%= request.getContextPath() %>/download_xls.do">
			<input type="hidden" name="frequency" value="<%=Frequency.Q.name()%>">
			<section class="timeRange">
				<span>期間設定： 
				起始
				<select class="timeRange" name="startYear">
				<%for(int i=1901; i<=Year.now().getValue(); i++){ %>
					<option value="<%=i%>" <%=(i==2000)?"selected":"" %>><%=i%>年</option>
				<%} %>
				</select>
				<select class="timeRange" name="startQuarter">
				<%for(int i=1; i<=4; i++){ %>
					<option value="<%=i%>" <%=(i==1)?"selected":"" %>>第<%=i%>季</option>
				<%} %>
				</select>
				~結束
				<select class="timeRange" name="endYear">
				<%for(int i=1901; i<=Year.now().getValue()+2; i++){ %>
					<option value="<%=i%>" <%=(i==Year.now().getValue())?"selected":"" %>><%=i%>年</option>
				<%} %>
				</select>
				<select class="timeRange" name="endQuarter">
				<%for(int i=1; i<=4; i++){ %>
					<option value="<%=i%>" <%=(i==4)?"selected":"" %>>第<%=i%>季</option>
				<%} %>
				</select>
				</span>
			</section>
			<div class="download"><input class="download" type="submit" value="索取<%=Frequency.Q.getDescription() %>"></div>
		</form>
	<%} %>
	</section>
</div>
<!-- quarterly.jsp end -->