<%@page import="java.util.List"%>
<%@page import="tedc.oecd.entity.Category"%>
<%@page import="java.util.Map"%>
<%@page import="tedc.oecd.service.IndexService"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
%>
<!-- searchBy_description.jsp start -->
<section class="result">
	<form autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
	<input type="hidden" name="bank" value="${param.bank }">
	<input type="hidden" name="category" value="${param.category }">
	<div class="text">
		<section class="text">
			<p>請輸入資料敘述文字串:</p>
		</section>
		<section class="text">
			<textarea name="description" placeholder="輸入資料敘述" autofocus tabindex="1"></textarea>
			<input class='submit' type='submit' value='查詢'>
		</section>
	</div>
	</form>
</section>
<!-- searchBy_description.jsp end -->