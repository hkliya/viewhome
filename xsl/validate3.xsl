<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="//data-client/issucceed/text()='false'">{"success":false, "msg":"登录失败：账户被禁用!"}</xsl:when>
			<xsl:when test="//form[@action='/names.nsf?Login']">{"success":false, "msg":"登录失败：请检查用户名密码是否正确!"}</xsl:when>
			<!--<xsl:when test="not(//form[@action='/names.nsf?Login'])">{"success":true, "cnname":"<xsl:value-of select="//input[@name='myinfo']/@value"/>"}</xsl:when>-->
			<xsl:when test="not(//form[@action='/names.nsf?Login'] or //form[@action='/pkmslogin.form'])">{"success":true, "cnname":"<xsl:value-of select="//input[@name='myinfo']/@value"/>"}</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
