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
				<script src="/view/js/mobileBridge.js"></script>
				<script src="/cssjs/jquery.mobile-1.0.1.js"></script>
				<script>
					var setNavigationTitle=new cherry.bridge.NativeOperation("case","setProperty",["title","<xsl:value-of select='//title/text()'/>"]);
					setNavigationTitle.dispatch();
				</script>
			</head>
			<body>
				<div id="notice" data-role="page">
					<div data-role="content" align="center">
						<script>
							<![CDATA[
							function submit(value){
								var question = window.confirm("确定提交吗?"); 
								if(question){
									var appserver = $("#appserver").val();
									var appdbpath = $("#appdbpath").val();
									var appdocunid = $("#appdocunid").val();
									var CurUserITCode = $("#CurUserITCode").val();
									var FlowMindInfo = $("#FlowMindInfo").val();
									FlowMindInfo = encodeURI(escape(FlowMindInfo));
									
									var soap = "<SOAP-ENV:Envelope xmlns:SOAP-ENV='http://schemas.xmlsoap.org/soap/envelope/' xmlns:SOAP-ENC='http://schemas.xmlsoap.org/soap/encoding/' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema'><SOAP-ENV:Body><m:bb_dd_GetDataByView xmlns:m='http://sxg.bbdd.org' SOAP-ENV:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/'><db_ServerName xsi:type='xsd:string'>"+appserver+"</db_ServerName><db_DbPath xsi:type='xsd:string'>"+appdbpath+"</db_DbPath><db_DocUID xsi:type='xsd:string'>"+appdocunid+"</db_DocUID><db_UpdInfo xsi:type='xsd:string'></db_UpdInfo><db_OptPsnID xsi:type='xsd:string'>"+CurUserITCode+"</db_OptPsnID><db_TempAuthors xsi:type='xsd:string'></db_TempAuthors><db_MsgTitle xsi:type='xsd:string'></db_MsgTitle><db_ToNodeId xsi:type='xsd:string'></db_ToNodeId><db_Mind xsi:type='xsd:string'>"+FlowMindInfo+"</db_Mind><db_OptType xsi:type='xsd:string'>"+value+"</db_OptType></m:bb_dd_GetDataByView></SOAP-ENV:Body></SOAP-ENV:Envelope>";

									$.mobile.showPageLoadingMsg();
									var url = "/view/digi/request/Produce/ProInd.nsf/THFlowBackTraceAgent?openagent&login";
									var data = "data-xml="+soap;
									$.ajax({
										type: "post", url: url, data:data,
										success: function(response){
											$.mobile.hidePageLoadingMsg();
											alert(response);
											changePageBackWithBridge(1);
										},
										error:function(response){
											$.mobile.hidePageLoadingMsg();
											alert("错误:"+response.responseText);
										}
									});
								}
							}
						]]>
						</script>
						<ul data-role="listview">
							<li data-role="list-divider">
								<div data-role="controlgroup" data-type="horizontal" align="right">
									<xsl:if test="//a[contains(., '下一步')]">
										<button type="button" style="padding:0 30 0 30;" onclick="submit(this.value);" value="submit" data-rel="dialog"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>下一步<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text></button>
									</xsl:if>
									<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
									<xsl:if test="//a[contains(., '退回')]">
										<button type="button" data-theme="b" onclick="submit(this.value);" value="reject" data-rel="dialog"><xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>退回<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text></button>
									</xsl:if>
								</div>
							</li>
						</ul>
						<br/>
						<ul data-role="listview" data-inset="true" data-theme="d">
							<li data-role="list-divider">基本信息</li>
							<li><xsl:apply-templates select="//div[@id='applycontent']//table[@id='tblapplycontent']" mode="c1"/></li>
							<li data-role="list-divider">审批意见</li>
							<li>
								<xsl:if test="//textarea[@name='FlowMindInfo']">
									<table style="border:0;padding:0;margin:0;" width="100%" border="0">
										<tr style="width:100%">
											<td style="width:50%" align="left">
												<span><strong>您的意见:</strong></span>
											</td>
											<td style="width:50%" align="left">
												<select onChange='$("#FlowMindInfo").val($("#FlowMindInfo").val()+this.value);' data-theme="a" data-icon="gear" data-native-menu="true">
													<option selected="selected">常用语</option>
													<option value="同意">同意</option>
													<option value="不同意">不同意</option>
												</select>
											</td>
										</tr>
										<tr style="width:100%">
											<td colspan="2" style="width:100%" align="center">
												<textarea id="FlowMindInfo" name="FlowMindInfo"></textarea>
											</td>
										</tr>
										<tr style="width:100%">
											<td colspan="2" style="width:100%" align="left">
												<span><strong>消息标题</strong></span>
											</td>
										</tr>
										<tr style="width:100%">
											<td colspan="2" style="width:100%" align="center">
												<input id="msgtitle" name="msgtitle" />
											</td>
										</tr>
									</table>
								</xsl:if>
							</li>
							<xsl:if test="normalize-space(//*[@name='Fck_HTML']/.)!='' and normalize-space(//*[@name='Fck_HTML']/.)!='临时作者字段：'">
								<li data-role="list-divider">正文内容</li>
								<li>
									<xsl:value-of select="//*[@name='Fck_HTML']/."/>
								</li>
							</xsl:if>
							<li data-role="list-divider">当前环节信息</li>
							<li>
								<xsl:apply-templates select="//table[@id='tblnodeinfo']//tr[position()&gt;1]" mode="c2"/>
							</li>
							<li data-role="list-divider">审批意见</li>
							<li>
								<xsl:apply-templates select="//table[@id='tblmindinfo']//table[@id='tblmindinfo']//tr[position()&gt;1]" mode="option"/>
							</li>
							
						</ul>
						<xsl:apply-templates select="//input[@type='hidden']" mode="hidden"/>
					</div><!-- /content -->
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="input" mode="hidden">
		<input type="hidden" id="{@name}" name="{@name}" value="{@value}" />
	</xsl:template>
	
	<xsl:template match="tr" mode="option">
		<div style="width;100%" align="left"><xsl:value-of select="td[4]/."/></div>
		<div style="width;100%" align="right">
			<xsl:value-of select="td[1]/."/><br/>
			<xsl:value-of select="td[2]/."/><br/>
			<xsl:value-of select="td[3]/."/><br/>
		</div>
		<hr/>
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
		<div style="width:100%" align="left">
			<xsl:attribute name="align">
				<xsl:if test="not(position()=1 or position()=3)">left</xsl:if>
			</xsl:attribute>
			<xsl:apply-templates mode="c3"/>
		</div>
		<hr color="gray"/>
	</xsl:template>

	<xsl:template match="td" mode="c3">
		<xsl:if test=".!=''">
		<xsl:if test="not(@style) or not(contains(@style, 'display:none'))">
			<!-- 发文红色字体特殊处理 -->
			<xsl:choose>
				<xsl:when test="position()=1">
					<span style="width:38%;display:inline-block;text-align:right"><font color="red"><xsl:value-of select="."/>
						<xsl:if test="not(contains(., ':'))">:</xsl:if>
					</font></span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="c4"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="position()=2">
				<br/>
			</xsl:if>
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
