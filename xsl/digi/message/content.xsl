<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>							
				<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.0.1.css" />
				<link rel="stylesheet" href="/ios/ios.css" />
				<script src="/cssjs/jquery.js"></script>
				<script src="/cssjs/jquery.cookie.js"></script>
				<script src="/view/js/cherry.js"></script>
				<script src="http://mobile.sugon.com/view/mobileBridge.js"></script>
				<script src="/cssjs/jquery.mobile-1.0.1.js"></script>
				<script>
					var setNavigationTitle=new cherry.bridge.NativeOperation("case","setProperty",["title","<xsl:value-of select='//title/text()'/>"]);
					setNavigationTitle.dispatch();
				</script>
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<ul data-role="listview" data-inset="true" data-theme="d">
							<li data-role="list-divider">基本信息:</li>
							<li><xsl:apply-templates select="//fieldentry" mode="f1"/></li>
							<li data-role="list-divider">附件信息:</li>
							<xsl:apply-templates select="//td[@id='attachinfo']//a" mode="file"/>
							<li data-role="list-divider">当前环节信息:</li>
							<li>
							<xsl:text>无</xsl:text>
							</li>

						</ul>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="fieldentry" mode="f1">
		<span style="width:38%;display:inline-block;text-align:right"><font color="red"><xsl:value-of select="@title"/>:</font></span>
		<xsl:value-of select="substring-before(substring-after(text/., 'CDATA['), ']]>')"/>
		<hr/>
	</xsl:template>

	
	<xsl:template match="a" mode="file">
		<li>
		<a href="javascript:void(0)" onclick="changePageWithBridge('http://mobile.sugon.com/view/digi/file{@href}')"><xsl:value-of select="."/></a>
		</li>
	</xsl:template>

	<!-- 表单批量格式化模版 -->
	<!-- variable of $mini and $aliasname at mdp.xsl -->
	<xsl:template match="table" mode="c1">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tbody" mode="c2">
		<xsl:apply-templates mode="c2"/>
	</xsl:template>

	<xsl:template match="tr" mode="c2">
		<xsl:if test="position()=1 or position()=2">
			<!--<div style="width:100%" align="center">
				<xsl:value-of select=".//q/." />
			</div>-->
		</xsl:if>
		<xsl:if test="not(position()=1 or position()=2)">
			<div style="width:100%" align="left">
				<xsl:attribute name="align">
					<xsl:if test="not(position()=2 or position()=4)">left</xsl:if>
				</xsl:attribute>
				<xsl:apply-templates mode="c3"/>
			</div>
		</xsl:if>
		<hr/>
	</xsl:template>

	<xsl:template match="td" mode="c3">
		<xsl:if test="not(@style) or not(contains(@style, 'display:none'))">
			<!-- 发文红色字体特殊处理 -->
			<xsl:choose>
				<xsl:when test="@class='DF_GTable_LTD_Style'">
					<span style="width:38%;display:inline-block;text-align:right"><font color="red"><xsl:value-of select="."/></font></span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="c4"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@class='DF_GTable_RTD_Style'">
				<br/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="text()" mode="c4">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="q" mode="c4">
		<xsl:apply-templates mode="c4"/>
	</xsl:template>
	<xsl:template match="b" mode="c4">
		<xsl:if test="normalize-space(.)!=''">
			<strong><xsl:apply-templates mode="c4"/></strong>
		</xsl:if>
	</xsl:template>
	<xsl:template match="center" mode="c4">
		<span width="100%" align="center" mode="c4">
			<xsl:apply-templates mode="c4"/>
		</span>
	</xsl:template>
	<xsl:template match="font" mode="c4">
		<font>
			<xsl:apply-templates mode="c4"/>
		</font>
	</xsl:template>
	<xsl:template match="input" mode="c4">
		<xsl:value-of select="@value"/>
	</xsl:template>
	<xsl:template match="select" mode="c4">
		<xsl:if test="starts-with(@name, 'fld')">
			<xsl:value-of select="option[@selected='selected']/text()"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="textarea" mode="c4">
		<xsl:value-of select="text()"/>
	</xsl:template>
	<xsl:template match="hr" mode="c4">
		<hr size="{@size}">
			<xsl:attribute name="color">
				<xsl:call-template name="color">
					<xsl:with-param name="name"><xsl:value-of select="@color" /></xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
		</hr>
	</xsl:template>
	<xsl:template match="div" mode="c4">
		<xsl:apply-templates mode="c4" />
	</xsl:template>
	<xsl:template match="img" mode="c4">
	</xsl:template>
	<xsl:template name="color">
		<xsl:param name="name" />
		<xsl:choose>
			<xsl:when test="@color='red'">
				<xsl:text>#FF0000</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>#FF0000</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>