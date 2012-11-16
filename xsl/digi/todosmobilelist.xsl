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
				<script src="/cssjs/jquery.mobile-1.0.1.js"></script>
				<script src="/view/js/hori.js"></script>

				<script>
					$(document).ready(function(){
						var hori=$.hori;
						/*设置标题*/
						hori.setHeaderTitle("代办");

					});
				</script>
				<script>
					var npage = 1;
					var ncount = 20;
					function fetch(){
						$.hori.$.hori.showLoading();						
						npage = npage+1;
						var itcode = "<xsl:value-of select='substring-before(substring-after(//url/text(), "dfmsg_"), ".nsf")'/>";
						var url = "/view/digi2/todosmobilesub/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&amp;login&amp;0.47540903102505816&amp;server=V7dev/DigiWin=&amp;dbpath=DFMessage/dfmsg_"+itcode+".nsf&amp;view=vwTaskUnDoneForMobile&amp;thclass=&amp;page="+npage+"&amp;count="+ncount;
						$.ajax({
							type: "get", url: url,
							success: function(response){
								//$.mobile.hidePageLoadingMsg();
								$("#more").remove();
								$("ul").append(response);
								$("ul").listview('refresh');
								$.hori.hideLoading();
							},
							error:function(response){
								//$.mobile.hidePageLoadingMsg();
								$.hori.hideLoading();
								alert("错误:"+response.responseText);
							}
						});
					}
				</script>
			</head>
			<body>
				<div id="list" data-role="page" class="type-home">
					<div data-role="content" align="center">
						<script>
							function changepage(url){
								
								$.hori.loadPage(url);
							}
						</script>
						<ul data-role="listview" data-inset="true">
							<xsl:apply-templates select="//viewentry" />
							<xsl:if test="count(//viewentry)=0">
								<li><a>无内容</a></li>
							</xsl:if>
							<xsl:if test="count(//viewentry)!=0">
								<li id="more">
									<a href="javascript:void(0);" onclick="fetch();" data-icon="none" data-iconpos="none">
										<div style="width:100%;" align="center"><h3>载入更多</h3></div>
									</a>
								</li>
							</xsl:if>
						</ul>
						<br/>
						<br/>
						<br/>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="viewentry">
		<li>
			<a  href="javascript:void(0)" onclick="changepage('/view/digi2/contentmobile/Produce/DigiFlowMobile.nsf/showform?openform&amp;login&amp;apptype=msg&amp;appserver=V7dev/DigiWin&amp;appdbpath=DFMessage/dfmsg_{substring-before(substring-after(//param[@key='dbpath']/@value, 'dfmsg_'), '.nsf')}.nsf&amp;appdocunid={@unid}')" data-icon="arrow-r" data-iconpos="right">
				<h3><xsl:value-of select="substring-after(substring-before(entrydata[2]/., ']]'), 'CDATA[')"/></h3>
				<p>
					时间:<font color="#0080FF"><xsl:value-of select="substring-after(substring-before(entrydata[1]/., ']]'), 'CDATA[')"/></font>
					状态:<font color="#0080FF"><xsl:value-of select="substring-after(substring-before(entrydata[3]/., ']]'), 'CDATA[')"/></font>
				</p>
			</a>
		</li>
	</xsl:template>
</xsl:stylesheet>
