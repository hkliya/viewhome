<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:variable name="start"><xsl:value-of select="//input[@name='start']/@value"/></xsl:variable>
	<xsl:variable name="count"><xsl:value-of select="//input[@name='count']/@value"/></xsl:variable>
	<xsl:variable name="total"><xsl:value-of select="//input[@name='total']/@value"/></xsl:variable>
	<xsl:variable name="currentPage"><xsl:value-of select="floor($start div $count)+1"/></xsl:variable>
	<xsl:variable name="totalPage"><xsl:value-of select="floor(($total - 1) div $count)+1"/></xsl:variable>
	<xsl:variable name="nextStart"><xsl:value-of select="($currentPage * $count) + 1"/></xsl:variable>
	<xsl:variable name="preStart"><xsl:value-of select="$nextStart - $count - $count"/></xsl:variable>

	<xsl:template match="/">
		<html>
			<head>
											
				<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.0.1.css" />
				<link rel="stylesheet" href="/ios/ios.css" />
				<script src="/cssjs/jquery.js"></script>
				<script src="/cssjs/jquery.cookie.js"></script>
				<script>
					$(document).bind("mobileinit", function(){
						$.mobile.loadingMessage = "载入中...";
						$.mobile.page.prototype.options.backBtnText = "后退";
					});
				</script>
				
				<script src="/view/mobileBridge.js"></script>
				<script src="/cssjs/jquery.mobile-1.0.1.js"></script><script src="/view/js/cherry.js"></script>
				<style>
					a:link{text-decoration:none}
					a:hover{text-decoration:none}
					a:visited{text-decoration:none}
				</style>
				<script>
					var setNavigationTitle=new cherry.bridge.NativeOperation("case","setProperty",["title","通讯录"]);
					setNavigationTitle.dispatch();
					cherry.bridge.flushOperations();
				</script>
			</head>
			<body>
				<div id="list" data-role="page" class="type-home">
					<div data-role="content" align="center">
						<script>
							function changepage(url){
								//$.mobile.changePage(url, {changeHash:true, type: "post"});
								$.hori.loadPage(url);
							}
						</script>
						<ul data-role="listview" data-inset="true">
						    <li data-role="list-divider">通讯录</li>
							<xsl:apply-templates select="//div[@name='person']" />
							<xsl:if test="count(//div[@name='person'])=1">
								<li><a>无内容</a></li>
							</xsl:if>
						</ul>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="div">
	
		<xsl:variable name="name" select="substring-before(text(), '^')"/>
		<xsl:if test="position()!=1">
			<li>
				<a href="javascript:void(0)" onclick="changepage('/view/digi/addressdetail/Produce/DigiFlowOrgSysMng.nsf/SearUserInfoForm?openform&amp;ITCode={$name}')"><xsl:value-of select="substring-before(substring-after(text(), '^'), '^')"/></a>
			</li>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>



