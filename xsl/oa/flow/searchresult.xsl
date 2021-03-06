<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<ul data-role="listview" data-inset="true">
			<li data-role="list-divider"></li>
			<xsl:apply-templates select="//id"/>
			<xsl:choose>
			<xsl:when test="contains(//body/text(), '查询结果大于50')">
				<li><xsl:value-of select="//body/text()"/></li>
			</xsl:when>
			<xsl:when test="count(//id)&lt;2">
				<li><a>无结果</a></li>
			</xsl:when>
			</xsl:choose>
		</ul>
	</xsl:template>

	<xsl:template match="id">
		<xsl:if test="position()!=1">
			<li>
				<input type="radio" name="radio-choice" value="{@id}" id="{substring-before(@name, '[')}"/><xsl:value-of select="substring-before(@name, '/')"/> 
				[ <xsl:value-of select="substring-before(substring-after(@name, '['),']')"/> ]
				<xsl:value-of select="@id"/>
			</li>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
