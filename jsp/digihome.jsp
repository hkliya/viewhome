<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html lang="zh_cn">
	<head>  
        <title>移动办公</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.0.1.css" />
		<link rel="stylesheet" href="/ios/ios.css" />
		<script src="/cssjs/jquery.js"></script>
		
		<script src="/cssjs/jquery.mobile-1.0.1.js"></script>
		<script src="/view/js/cherry.js"></script>
		<script src="/view/js/mobileBridge.js"></script>
		<script type="text/javascript">
		  function openmail(){
			if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
				window.location.href="mailto:";

			} else if (window.navigator.userAgent.match(/android/i)) {
				var runMail=new cherry.bridge.NativeOperation("application", "runTraveler", []).dispatch();
				var travelerScript = new cherry.bridge.ScriptOperation(function(){
					var result = runMail.returnValue;
					if(!result || result==false || result=='false'){
						alert('请先安装 traveler客户端!');
					}
				});
				travelerScript.addDependency(runMail);
				travelerScript.dispatch();
				cherry.bridge.flushOperations();
			}
		 }
		 function registdevice(){
			var type = "android";
			if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
				type = "iphone";
			}
			var getdeviceid = new cherry.bridge.NativeOperation("application", "getDeviceId", []).dispatch();
			var saveCookieScript = new cherry.bridge.ScriptOperation(function(){
				var result = getdeviceid.returnValue;
				if(result == ""){
					//alert("无法获取设备ID");
					return;
				}
				$.ajax({
					type: "POST", url: "/view/digi?data-action=regisdevice&data-device-type="+type+"&data-device-token="+result,
					success: function(response){
					},
					error:function(response){
					}
				});
			});
			saveCookieScript.addDependency(getdeviceid);		
			saveCookieScript.dispatch();
			cherry.bridge.flushOperations();
		}
		
		$(document).ready(function(){
			registdevice();
			var setNavigationTitle=new cherry.bridge.NativeOperation("case","setProperty",["title","首页"]);
			cherry.bridge.registerEvent("case", "navButtonTouchUp", function(oper) {
					changePageBackWithBridge(1);
				});
			setNavigationTitle.dispatch();
			var setNavigationBack=new cherry.bridge.NativeOperation("case","setProperty",["backButtonHidden","1"]);
			setNavigationBack.dispatch();
			cherry.bridge.flushOperations();

		});
		function test(){
			var soap = '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:DefaultNamespace"><soapenv:Header/><soapenv:Body><urn:GETUSERSTR soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><SERNAME xsi:type="xsd:string">oa.lovol.com.cn</SERNAME><DBPATH xsi:type="xsd:string">lovol/ApplicationFDC/IssuedADocBlackFileOperateFTLW.nsf</DBPATH><UNID xsi:type="xsd:string">09917E14AF15796648257A960025E173</UNID></urn:GETUSERSTR></soapenv:Body></soapenv:Envelope>';

			$.mobile.showPageLoadingMsg();
			var url = "/view/digi4/wb/Produce/DigiFlowMobileHome.nsf/WebMsg?wsdl";
			var data = "data-xml="+soap;
			$.ajax({
				type: "post", url: url, data:data,
				success: function(response){
					$.mobile.hidePageLoadingMsg();
					alert(response);
				},
				error:function(response){
					$.mobile.hidePageLoadingMsg();
					alert("错误:"+response.responseText);
				}
			});
		}
		</script>
		<style>
			a{text-decoration:none;}
		</style>
    </head>
	<body >
		<div data-role="page" id="home" style="background:url(/view/png/digi/bg_empty.png);background-size:cover;-moz-background-size:cover;" class="mi-bg">
		<!--
			<div data-role="header">
				<a data-icon="home" data-role="button" data-rel="back">返回</a>
				<h1>首页</h1>
				<a data-icon="home" data-role="button" href="javascript:void(0)" onclick="pushtest();" >推送</a>
			</div>
		-->
			<div data-role="content" align="center">
			
	
				<div class="ui-grid-b">
                    <div class="ui-block-a">
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('/view/digi2/todosmobile/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&login&0.47540903102505816&server=OA01/LOVOL=&dbpath=DFMessage/dfmsg_<%=request.getParameter("itcode") %>.nsf&view=vwTaskUnDoneForMobile&thclass=&page=1&count=20')">
							<img width="68" height="68" src="/view/png/dbsy.png" />
						</a>
                        <br/>
                        <span style="color:white;"><strong>待办事宜</strong></span>
                    </div>
                    <div class="ui-block-b">
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('/view/digi2/messagelist/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&login&0.6922244625974295&server=OA01/LOVOL&dbpath=DFMessage/dfmsg_<%=request.getParameter("itcode") %>.nsf&view=vwMsgUnRdForMobile&thclass=&page=1&count=20&pageFrom=homepage')">
							<img width="68" height="68" src="/view/png/gwyl.png" />
						</a>
                        <br/>
                        <span style="color:white;"><strong>未读消息</strong></span>
                    </div>
					 <div class="ui-block-b">
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('/view/digi2/messagereadlist/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&login&0.6922244625974296&server=OA01/LOVOL=&dbpath=DFMessage/dfmsg_<%=request.getParameter("itcode") %>.nsf&view=vwMsgRdForMobile&thclass=&page=1&count=20')">
							<img width="68" height="68" src="/view/png/icon2.png"/> 
						</a>
                        <br/>
                        <span style="color:white;"><strong>已读消息</strong></span>
                    </div>
                </div>
                <br/>

                <div class="ui-grid-b">
					
                    
                    <div class="ui-block-a">
						<a href="javascript:void(0)" onclick="showLoading();changePageWithBridge('/view/digi/phonenumber/Produce/WeboaConfig.nsf/telSearchForm?openform','/view/Resources/searchContact.xml')">
                        <img width="68" height="68" src="/view/png/digi/addressbook.png">
						</a>
                        <br/>
                        <span style="color:white;"><strong>电话查询</strong></span>
                    </div>
                    <div class="ui-block-b">
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('/view/oa/imagenewslist/Application/DigiFlowInfoPublish.nsf/InfoPicView1?readviewentries?login&start=1&count=20')">
							<img width="68" height="68" src="/view/png/kgxw.png">
						</a>
                        <br/>
                        <span style="color:white;"><strong>图片新闻</strong></span>    
                    </div>


                    <div class="ui-block-c">
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('/view/oa/hangnei/Application/DigiFlowInfoPublish.nsf/InfoByDateView_2?readviewentries?login&start=1&count=20&RestrictToCategory=Dir11_01$');">
							<img width="68" height="68" src="/view/png/icon3.png">
						</a>
						<br/>
						<span style="color:white;"><strong>行内公告</strong></span>
                    </div>


                </div>
				
                <br/>
                <div class="ui-grid-b">

					<div class="ui-block-a">					
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('/view/oa/business_news/Application/DigiFlowInfoPublish.nsf/InfoByDateView_2?readviewentries?login&start=1&count=20&RestrictToCategory=Dir11_02$');">
							<img width="68" height="68" src="/view/png/icon7.png" />
						</a>
						<br/>
						<span style="color:white;"><strong>行内新闻</strong></span>
                    </div>


					<div class="ui-block-b">					
						
                    </div>
					<div class="ui-block-c">					
						
                    </div>


                </div>
				
			</div>
		</div>


		<iframe src="/view/digi?data-action=createuser" border="0" frameborder="no" framespacing="0" width="0" height="0"></iframe>
		
	</body>
</html>
