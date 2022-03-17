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
						<li class="qnia"><a href="<%= request.getContextPath() %>/search/index_list?bank=qnia"><p class="name">QNIA</p><p class="desc">(Quarterly National Accounts)</p><p class="">季度國民所得與會計帳</p></a></li>
						<li class="mei"><a href="<%= request.getContextPath() %>/search/index_list?bank=mei"><p class="name">MEI</p><p class="desc">(Monthly Economic Indicators)</p><p class="">每月總體經濟指標</p></a></li>
					</ul>
				</div>
				<div class="description">
					<h2>概述</h2>
					<p>本中心建置並維護「AREMOS 經濟統計資料庫」。多年來，這個資料庫系統以「PC 單機版」方式安裝於各大專校院系所、圖書館及政府單位、研究機構等以供使用。
					自 2010 年起，本中心因應使用者的需求建議，設計推出 AREMOS 台灣經濟統計資料庫「網路版」。
					凡有訂購「PC 單機版」之學校老師、學生，以及政府單位、研究機構工作人員，均可取得授權帳號免費上網使用「網路版」。
					若有疑難無法上網使用，歡迎跟我們聯絡，電話：(02)2366-1944 轉 71 找鄭老師。</p>
					<p>隨著台灣資料庫「網路版」日漸普受歡迎，有不少使用者建議能收納入國際統計資料庫。
					在本中心工作同仁努力趕工下，已完成建置「OECD 季度國民所得與會計帳 (QNIA) 、每月總體經濟指標 (MEI) 資料庫」之網路版可供使用。
					此資料庫含全球六十幾個發達國家或組織有關總體經濟方面的統計，有國民所得、消費支出、固定資本形成、工資、就業、人口、物價、貨幣供給、工業生產、國際貿易、信心指數等，
					總共約 15 萬筆時間序列。</p>
					<h2>實際進行索取資料</h2>
					<p>使用本 OECD 季度國民所得與會計帳 (QNIA) 、每月總體經濟指標 (MEI) 資料庫「網路版」，您可有六種方式來篩選資料：
					(1) 以英文之字串作「關鍵字搜尋」；
					(2) 以國家為基準作篩選；
					(3) 以主題為基準作篩選；
					(4) 以頻率為基準作篩選；
					(5) 以檢索代號字串作篩選；
					(6) 以資料敘述字串作篩選。</p>
					<p>上述六種方式皆可以混合使用。此外還可以針對頁數、排序條件、顯示資料筆數作調整。</p>
				</div>
			</div>
		</section>
		<aside id="right"></aside>
	</main>
	<jsp:include page="/subviews/mainFooter.jsp" />
</body>
</html>