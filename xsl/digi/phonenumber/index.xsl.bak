<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:variable name="start"><xsl:value-of select="//input[@name='start']/@value"/></xsl:variable>
	<xsl:variable name="count"><xsl:value-of select="//input[@name='count']/@value"/></xsl:variable>
	<xsl:variable name="total"><xsl:value-of select="//input[@name='total']/@value"/></xsl:variable>
	<xsl:variable name="currentPage"><xsl:value-of select="floor($start div $count)+1"/></xsl:variable>
	<xsl:variable name="totalPage"><xsl:value-of select="floor(($total - 1) div $count)+1"/></xsl:variable>
	<xsl:variable name="nextStart"><xsl:value-of select="($currentPage * $count) + 1"/></xsl:variable>
	<xsl:variable name="preStart"><xsl:value-of select="$nextStart - $count - $count"/></xsl:variable>

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
					<![CDATA[
					
					cherry.bridge.registerEvent("case", "navButtonTouchUp", function(oper) {
						submit();
					});
					function submit(){
						var username = $("#phonenumber").val();
						username = encodeURI(escape(username));
						
						$.mobile.showPageLoadingMsg();
						
						var url = "/view/digi/phonenumberrequest/Produce/WeboaConfig.nsf/telSearchForm?openform&svrName=CN=v7dev/O=DigiWin&queryStr="+username+"&dbFile=Produce/DigiFlowOrgPsnMng.nsf&showField=UserDeptPhone";
						$.ajax({
							type: "post", url: url,
							success: function(response){
								$.mobile.hidePageLoadingMsg();
								$("#viewValue").html(response);
								$("#viewValue ul").listview();
								$("#viewValue ul").listview();    
							},
							error:function(response){
								$.mobile.hidePageLoadingMsg();
								alert("错误:"+response.responseText);
							}
						});
					}
					]]>
				</script>
			</head>
			<body>
				<div id="list" data-role="page" class="type-home">
					<div data-role="content" align="center">

						<div align="center" >
							<input type="text" id="phonenumber" name="phonenumber" value="" />
						</div>
						<div id="viewValue" >
							<ul data-role="listview" data-inset="true">
								<li data-role="list-divider"></li>
								<li>无数据</li>
							</ul>
						</div>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="tr">
		<li href="">
			<a href="/bridge/oa/noticecontent{td[4]/a/@href}" data-icon="arrow-r" data-iconpos="right">
				<h3><xsl:value-of select="td[4]/."/></h3>
				<p>时间:<xsl:value-of select="td[3]/."/></p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
