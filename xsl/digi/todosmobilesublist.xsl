<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="GBK" indent="yes"/>
	<xsl:template match="/">
		<xsl:apply-templates select="//viewentry" />

		<xsl:if test="count(//viewentry) &lt; //param[@key='count']/@value">
			<li id="more">
				<div style="width:100%;" align="center"><h3>无数据</h3></div>
			</li>
		</xsl:if>
		<xsl:if test="count(//viewentry) = //param[@key='count']/@value">
			<li id="more">
				<a href="javascript:void(0);" onclick="fetch(this);" data-icon="none" data-iconpos="none">
					<div style="width:100%;" align="center"><h3>载入更多</h3></div>
				</a>
			</li>
		</xsl:if>
	</xsl:template>

	<xsl:template match="viewentry">
		<li>
			<a  href="javascript:void(0)" onclick="changepage('/view/digi2/contentmobile/Produce/DigiFlowMobile.nsf/showform?openform&amp;login&amp;apptype=msg&amp;appserver=OA01/LOVOL&amp;appdbpath=DFMessage/dfmsg_{substring-before(substring-after(//param[@key='dbpath']/@value, 'dfmsg_'), '.nsf')}.nsf&amp;appdocunid={@unid}')" data-icon="arrow-r" data-iconpos="right">
				<h3><xsl:value-of select="substring-after(substring-before(entrydata[2]/., ']]'), 'CDATA[')"/></h3>
				<p>
					时间:<font color="#0080FF"><xsl:value-of select="substring-after(substring-before(entrydata[1]/., ']]'), 'CDATA[')"/></font>
					状态:<font color="#0080FF"><xsl:value-of select="substring-after(substring-before(entrydata[3]/., ']]'), 'CDATA[')"/></font>
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
