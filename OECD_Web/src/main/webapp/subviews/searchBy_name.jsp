<%@page import="java.util.List"%>
<%@page import="tedc.oecd.entity.Category"%>
<%@page import="java.util.Map"%>
<%@page import="tedc.oecd.service.IndexService"%>
<%@ page pageEncoding="utf-8"%>
<%
	String bank = request.getParameter("bank");
%>
<!-- searchBy_name.jsp start -->
<section class="result">
	<form autocomplete="off" method="POST" action="<%= request.getContextPath() %>/categories.do">
	<input type="hidden" name="bank" value="${param.bank }">
	<input type="hidden" name="category" value="${param.category }">
	<div class="text">
		<section class="text">
			<p>請輸入檢索代號文字串(Enter names):</p>
		</section>
		<section class="text">
			<textarea name="name" placeholder="輸入檢索代號(names)" autofocus tabindex="1"></textarea>
			<input class='submit' type='submit' value='查詢Submit'>
		</section>
	</div>
	</form>
</section>
<!-- searchBy_name.jsp end -->