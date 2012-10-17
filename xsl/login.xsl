<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/">
		<html>
			<head>
											
				<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.0.1.css" />
				<link rel="stylesheet" href="/ios/ios.css" />
				<script src="/cssjs/jquery.js"></script>
				<script src="/cssjs/jquery.cookie.js"></script>
				<script src="resource://localhost/cherry.js"></script>
				<script src="http://mobile.sugon.com/view/mobileBridge.js"></script>
				<script src="/cssjs/jquery.mobile-1.0.1.js"></script>
			
			</head>
			<body>
				登录
				<hr/>
				<form method="post" action="/bridge/oa/loginvalidate/pkmslogin.form" name="_DominoForm">
					用户名:<input type="input" name="username" /><br/>
					密码:<input  type="password" name="password"/><br/>

					<input type="submit" value="submit"/>
					<!--<input type="hidden" name="data-cookie" value="loginSign:innet"/>-->
					<input type="hidden" name="login-form-type" value="pwd"/>
					<input type="hidden" name="data-userid" value="username"/>
					<input type="hidden" name="data-password" value="password"/>
					<input type="hidden" name="data-login" value="true"/>
				</form>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
