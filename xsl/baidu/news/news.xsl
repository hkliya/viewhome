<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>							

			</head>
			<body>
				<xsl:value-of select="//title/text()"></xsl:value-of>
			</body>
		</html>
	</xsl:template>
	
</xsl:stylesheet>
