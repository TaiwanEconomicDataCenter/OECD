<%@page import="java.time.format.FormatStyle"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.format.TextStyle"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page pageEncoding="utf-8"%>
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
	<main class="index">
		<aside id="left"></aside>
		<section>
			<nav>
				<div class="title">
					<h1 class="title">國際經濟統計資料庫</h1>
					<h1>AREMOS 經濟合作暨發展組織(OECD)</h1>
					<h1>季度國民所得與會計帳(QNIA)、每月總體經濟指標(MEI)資料庫</h1>
				</div>
				<div class="time">
				<%=LocalDate.now().getYear() %>年
				<%=LocalDate.now().getMonthValue() %>月
				<%=LocalDate.now().getDayOfMonth() %>日
				<%=LocalDate.now().getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.getDefault()) %>
				<%=LocalTime.now().format(DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT).withLocale(Locale.getDefault())) %>
				</div>
			</nav>
			<div class="main">
				<div class="link">
					<p>請選擇資料庫</p>
					<ul>
						<li class="qnia"><a href="<%= request.getContextPath() %>/list/index_list.jsp?bank=qnia&page=1"><p class="name">QNIA</p><p class="desc">(Quarterly National Accounts)</p></a></li>
						<li class="mei"><a href="<%= request.getContextPath() %>/list/index_list.jsp?bank=mei&page=1"><p class="name">MEI</p><p class="desc">(Monthly Economic Indicators)</p></a></li>
					</ul>
				</div>
				<div class="description">
					<h2>概述</h2>
					<p>本中心建置並維護「AREMOS 經濟統計資料庫」。多年來，這個資料庫系統以「PC 單機版」方式安裝於各大專校院系所、圖書館及政府單位、研究機構等以供使用。自 2010 年起，本中心因應使用者的需求建議，設計推出 AREMOS 台灣經濟統計資料庫「網路版」。凡有訂購「PC 單機版」之學校老師、學生，以及政府單位、研究機構工作人員，均可取得授權帳號免費上網使用「網路版」。若有疑難無法上網使用，歡迎跟我們聯絡，電話：(02)2366-1944 轉 71 找鄭老師。</p>
				</div>
			</div>
		</section>
		<aside id="right"></aside>
	</main>
	<jsp:include page="/subviews/mainFooter.jsp" />
</body>
</html>