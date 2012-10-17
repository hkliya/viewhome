<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="GBK" indent="yes"/>
	<xsl:template match="/">
	  <html>
		<head></head>
		<body>
			<xsl:if test="//form[@action='/pkmslogin.form']">
				登录失败
			</xsl:if>
			<xsl:if test="not(//form[@action='/pkmslogin.form'])">
				登录成功<br/>
				--------------------------------------------------
				业务系统<br/>
				**************************************************
				<br/>
				<a href="/bridge/oa/notice/smartdot/xwzx.nsf/content_ejlm?openform&amp;id=8E3F47CBCFDAF16F4825765200048E6A">公告列表</a>
				<br/>
				<a href="/bridge/mail2/inbox/mail/fengkq.nsf/myview?openform&amp;view=%28$inbox%29&amp;start=1&amp;count=20">收件箱</a>
				<br/>
			</xsl:if>
			<br/>
			**************************************************
			<a href="/bridge/login">注销</a>
		</body>
	  </html>
	</xsl:template>
</xsl:stylesheet>
