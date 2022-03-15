<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>找不到網頁</title>
<link href="<%= request.getContextPath() %>/css/main_template.css" type="text/css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/javascript/main_template.js"></script>
</head>
<body>
	<jsp:include page="/subviews/mainHeader.jsp" />
	<nav class="bank"></nav>
	<main>
		<aside></aside>
		<section>
			<h2>找不到這個網頁: <span><%= request.getAttribute("javax.servlet.error.request_uri")%></span></h2><%--錯誤網址 --%>
			<img id="notFound404" alt="" src="<%= request.getContextPath() %>/images/404.png">
		</section>
		<aside></aside>
	</main>
	<jsp:include page="/subviews/mainFooter.jsp" />
</body>
</html>