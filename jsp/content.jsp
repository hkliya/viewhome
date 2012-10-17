<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page language="java" import="com.top.mobile.system.control.Query"%>
<html lang="zh_cn">
	<head></head>
	<body>
		<div data-role="page" class="type-home">
			<div data-role="header" data-position="fixed">
				<a data-icon="home" data-role="button" href="/bridge/home.html">返回</a>
				<h1>通知公告2</h1>
			</div><!-- /header --> 
			<div data-role="content" align="center">
				<%="JSP文件输出内容" %>
				<br/>
				<%
				Query q = (Query)request.getAttribute(Query.CurrentQuery);
				q.setUrl("http://oa.smartdot.com");
				q.setMethod("get");
				q.setEncoding("gb18030");
				
				Query t = q.process();
				out.println(t.valueOf("//title/text()"));
				%>
			</div><!-- /content -->
		</div>
	</body>
</html>