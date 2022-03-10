<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AREMOS OECD 統計資料庫網路版</title>
<link href="<%= request.getContextPath() %>/css/main_template.css" type="text/css" rel="stylesheet" />
<link href="<%= request.getContextPath() %>/css/cart.css" type="text/css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/javascript/main_template.js"></script>
</head>
<body>
	<jsp:include page="/subviews/mainHeader.jsp" />
	<nav class="bank">
		<div class="title">
			<h1 class="title">「OECD資料庫」索取清單</h1>
		</div>
	</nav>
	<main>
		<aside id="left"></aside>
		<section class="cart">
			<ul class="orders">
				<li value='div#annual' class='target'><div class='side'><div class='inner left'></div></div><div class='title'><span>年資料</span></div><div class='side'><div class='inner right'></div></div></li>
				<li value='div#quarterly'><div class='side'><div class='inner left'></div></div><div class='title'><span>季資料</span></div><div class='side'><div class='inner right'></div></div></li>
				<li value='div#monthly'><div class='side'><div class='inner left'></div></div><div class='title'><span>月資料</span></div><div class='side'><div class='inner right'></div></div></li>
			</ul>
			<div class='container'>
				<jsp:include page="/subviews/annual.jsp" />
				<jsp:include page="/subviews/quarterly.jsp" />
				<jsp:include page="/subviews/monthly.jsp" />
			</div>
		</section>
		<aside id="right"></aside>
	</main>
	<jsp:include page="/subviews/mainFooter.jsp" />
</body>
</html>