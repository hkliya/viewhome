<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<ul data-role="listview" data-inset="true">
			<li data-role="list-divider"></li>
			<xsl:apply-templates select="//table[@class='table1']//tr[position()&gt;1]"/>
			<xsl:if test="count(//table[@class='table1']//tr[position()&gt;1])&lt;1">
				<li><a>无结果</a></li>
			</xsl:if>
		</ul>
	</xsl:template>

	<xsl:template match="tr">
		<li>用户名:<xsl:value-of select="td[2]/."/><br/>ITCode:<xsl:value-of select="td[1]/."/><br/>员工编号:<xsl:value-of select="td[3]/."/><br/>移动电话:<xsl:value-of select="td[4]/."/><br/>办公电话:<xsl:value-of select="td[5]/."/></li>
	</xsl:template>
</xsl:stylesheet>
