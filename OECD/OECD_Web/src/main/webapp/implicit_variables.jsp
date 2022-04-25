<%@page import="java.util.Date"%>
<%@page import="java.util.Random"%>
<%@ page pageEncoding="UTF-8" isErrorPage="true"%>
<%
	request.setCharacterEncoding("utf-8");
	/*GET請求預設使用UTF-8編碼，而POST請求則需事先設定*/
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>隱含變數</title>
<style type="text/css">
	label{font-weight: bold; color:gray;}
	table, td{border: 1px solid black;}
	a{text-decoration: none;}
</style>
</head>
<body>
	<h2>隱含變數(implicit variables)</h2>
	<table>
		<tr>
			<td><a href="#response">response</a></td>
			<td><a href="#out">out</a></td>
			<td><a href="#session">session</a></td>
			<td><a href="#application">application</a></td>
			<td><a href="#config">config</a></td>
			<td><a href="#pageContext">pageContext</a></td>
			<td><a href="#page">page</a></td>
			<td><a href="#exception">exception</a></td>
		</tr>
	</table>
	<h3>request***(內部轉交)</h3>
	<%
		String method = request.getMethod();
	%>
	<p>請求方式<%= method %></p>
	<p><label>request.getRequestURL():</label> <%= request.getRequestURL() %></p>
	<p><label>request.getRequestURI():</label> <%= request.getRequestURI() %></p>
	<p><label>request.getProtocol():</label> <%= request.getProtocol() %></p>
	<p><label>(Server) request.getLocalName():</label> <%= request.getLocalName() %></p>
	<p><label>(Server) request.getLocalAddr():</label> <%= request.getLocalAddr() %></p>
	<p><label>(Server) request.getLocalPort():</label> <%= request.getLocalPort() %></p>
	<%-- out.flush(); //到此大致為1kb的容量
		Thread.sleep(new Random().nextInt(1700)+500);//for test --%>
	<p><label>getContextPath():</label> <%= request.getContextPath() %></p>
	<p><label>getQueryString():</label> <%= request.getQueryString() %></p>
	<p><label>getHeader("user-agent"):</label> <%= request.getHeader("user-agent") %></p>
	<p><label>getHeader("accept"):</label> <%= request.getHeader("accept") %></p>
	<p><label>getHeader("accept-language"):</label> <%= request.getHeader("accept-language") %></p>
	
	<p><label>(Client) request.getRemoteHost():</label> <%= request.getRemoteHost() %></p>
	<p><label>(Client) request.getRemoteAddr():</label> <%= request.getRemoteAddr() %></p>
	<p><label>(Client) request.getRemotePort():</label> <%= request.getRemotePort() %></p>
	<!-- 以Form Data傳送POST請求必須注意編碼問題 -->
	<form method='POST' action="#testForm" id="testForm"><!-- #:頁面書籤，可自動對位到物件位置 -->
		<fieldset>
			<legend>POST Form Data</legend>
			<input name="id" placeholder="請輸入id" required>
			<input type="submit">
		</fieldset>
	</form>
	<p><label>getParameter("id"):</label> <%= request.getParameter("id") %></p>
	<hr>
	<h3 id="response">response</h3>
	<p><label>getContentType():</label> <%= response.getContentType() %></p>
	<p><label>getBufferSize():</label> <%= response.getBufferSize() %></p><!-- 單次buffer回傳大小(預設為8kb) -->
	<% //<%@ buffer="1kb":設定buffer容量 autoFlush: 是否分批傳送(預設true) %>
	<hr>
	<h3 id="out">out*</h3><% //可以<%=來取代 %>
	<p><label>out.getBufferSize():</label> <% out.print(out.getBufferSize()); %></p>
	<hr>
	<h3 id="session">session**</h3>
	<p><label>sessionId:</label> <%= session.getId() %></p>
	<p><label>timeout:</label> <%= session.getMaxInactiveInterval() %> sec</p>
	<!-- getCreationTime()/getLastAccessedTime():以毫秒為單位，from 1970-01-01 00:00:00.0001 -->
	<p><label>created time:</label> <%= new Date(session.getCreationTime()) %></p>
	<p><label>last accessed time:</label> <%= new Date(session.getLastAccessedTime()) %></p>
	<hr>
	<h3 id="application">application*</h3><!-- 最好不要用避免資安問題 -->
	<p><label>ContextPath:</label> <%= application.getContextPath() %></p>
	<p><label>real Path:</label> <%= application.getRealPath("/") %></p>
	<hr>
	<h3 id="config">config</h3><!-- config == this -->
	<p><label>this.ServletName:</label> <%= this.getServletName() %></p>
	<p><label>config.ServletName:</label> <%= config.getServletName() %></p>
	<hr>
	<h3 id="pageContext">pageContext</h3>
	<p><label>ContextPath:</label> <%= ((HttpServletRequest)pageContext.getRequest()).getContextPath() %></p>
	<p><label>ContextPath:</label> <%= request.getContextPath() %></p>
	<p><label>config.ServletName:</label> <%= pageContext.getServletConfig().getServletName() %></p>
	<p><label>config.ServletName:</label> <%= config.getServletName() %></p>
	<hr>
	<h3 id="page">page</h3><!-- page跟this都指派到同一個物件，但page的宣告型別為Object，需透過轉型才能抓到this的方法 -->
	<p><label>this.getServletName:</label> <%= this.getServletName() %></p>
	<p><label>this.getServletName:</label> <%= ((HttpServlet)page).getServletName() %></p>
	<%! int i=200; %>
	<% int i=20; %>
	<p>this.i: <%= this.i %></p>
	<p>i: <%= i %></p>
	<p>this==page: <%=this==page %></p>
	<hr>
	
	<h3 id="exception">exception*</h3><!-- Ch.20 -->
	<p>exception: <%= exception %></p>
</body>
</html>