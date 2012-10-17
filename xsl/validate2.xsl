<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="GBK" indent="yes"/>
	<xsl:template match="/">
	  <html>
		<head></head>
		<body>
			<xsl:choose>
			<xsl:when test="//data-client/issucceed/text()='false'">
				登录失败：<xsl:value-of select="//body/text()"/>
			</xsl:when>
			<xsl:when test="//form[@action='/names.nsf?Login']">
				登录失败：请检查用户名密码是否正确
			</xsl:when>
			<xsl:when test="not(//form[@action='/names.nsf?Login'])">
				登录成功正在跳转...
				<script type="text/javascript">
					window.location.href="../../home.html"; 
				</script>
			</xsl:when>
			</xsl:choose>
			<br/>
			**************************************************
			<a href="/bridge/login.html">注销</a>
		</body>
	  </html>
	</xsl:template>
</xsl:stylesheet>
