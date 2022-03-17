<%@ page pageEncoding="utf-8"%>
<!-- mainHeader.jsp start -->
<header>
	<h1 id="home">
		<a id="logo" href='https://www.tedc.org.tw/'>
			<img id="logoImg" src="<%= request.getContextPath() %>/images/banner_2.jpg">
		</a>
	</h1>
	<div id="headerMenu">
		<ul id="mainMenu">
			<li id="oecd"><a href="<%= request.getContextPath() %>">OECD首頁(Home)</a></li>
			<li id="qnia"><a href="<%= request.getContextPath() %>/search/index_list?bank=qnia">QNIA</a></li>
			<li id="mei"><a href="<%= request.getContextPath() %>/search/index_list?bank=mei">MEI</a></li>
			<li id="cart"><a href="<%= request.getContextPath() %>/cart/retrieving_list">索取清單(Retrieving List)</a></li>
		</ul>
	</div>
</header>
<!-- mainHeader.jsp end -->
