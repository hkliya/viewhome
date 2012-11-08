<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="GBK" indent="yes"/>
	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="//form[@name='_DominoForm']">{"success":false, "msg":"用户名或密码错误!"}</xsl:when>
			<xsl:otherwise>{"success":true,"itcode":"<xsl:value-of select="//input[@name='ITCode']/@value"/>"}</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>