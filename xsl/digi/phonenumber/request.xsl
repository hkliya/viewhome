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
		<li>
			<font>
				<xsl:text>ITCode:</xsl:text><xsl:value-of select="td[1]/."/>
			</font><br/>
			<font>
				<xsl:text>用户名:</xsl:text><xsl:value-of select="td[2]/."/>
			</font><br/>
			<font>
				<xsl:text>部门名称:</xsl:text><xsl:value-of select="td[3]/."/>
			</font><br/>
			<font>
				<xsl:text>移动电话:</xsl:text><xsl:value-of select="td[4]/."/>
			</font><br/>
			<font>
				<xsl:text>办公电话:</xsl:text><xsl:value-of select="td[5]/."/>
			</font><br/>			
			<font>
			<xsl:text>邮 箱:</xsl:text>
				<a href="mailto:{td[6]/.}" target="_blank" data-role="none">
					<xsl:value-of select="td[6]/."/>
				</a>
			</font>
		</li>
	</xsl:template>
</xsl:stylesheet>
