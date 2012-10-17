<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<xsl:text>/view/digi/messagecontent/Produce/DigiFlowMobile.nsf/showform?openform&amp;login&amp;apptype=msg&amp;appserver=&amp;appdbpath=DFMessage/dfmsg_</xsl:text>
		<xsl:value-of select="//userid/text()"/>
		<xsl:text>.nsf&amp;appdocunid=</xsl:text>
		<xsl:value-of select="substring-before(substring-after(//url/text(),'msgByDateDownView/'), '?')"/>
	</xsl:template>
</xsl:stylesheet>
