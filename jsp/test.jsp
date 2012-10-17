<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html lang="zh_cn">
	<head></head>
	<body>
		<div data-role="page" class="type-home">
			<div data-role="header" data-position="fixed">
				<a data-icon="home" data-role="button" href="/bridge/home.html">返回</a>
				<h1>通知公告</h1>
			</div><!-- /header --> 
			<div data-role="content" align="center">
				<%="JSP文件输出内容" %>
			</div><!-- /content -->
			<%
				Server.forward("/routing.jsp");
			%>
		</div>
	</body>
</html>