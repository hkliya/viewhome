<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html lang="zh_cn">
	<head>  
        <title>DigiFlow</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-capable" content="yes" /> 
		<meta name="apple-mobile-web-app-status-bar-style" content="black" /> 
		<link rel="apple-touch-icon-precomposed" href="icon.png" /> 
		<link rel="apple-touch-startup-image" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)" href="loading_1024_748.png"/>
		<link rel="apple-touch-startup-image" media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)" href="loading_768_1004.png"/>
		<link rel="apple-touch-startup-image" media="screen and (max-device-width: 320px)" href="loading_320_480.png"/>
		<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.0.1.css" />
		<link rel="stylesheet" href="/ios/ios.css" />
		<style>
			body .ui-page{
				-webkit-backface-visibility: hidden;
				-webkit-Perspective:1000;
			}
			a{ TEXT-DECORATION:none }
			.bubble-count { font-size: 11px; font-weight: bold; padding: .2em .5em; margin-left:-.5em;}
		</style>
		<script type="text/javascript">
			if(window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
				document.write('<link href="/view/i.css" rel="stylesheet" type="text/css">');
			}else if(window.navigator.userAgent.match(/android/i)) {
				document.write('<link href="/view/a.css" rel="stylesheet" type="text/css">');
			}else{
				document.write('<link href="/view/t.css" rel="stylesheet" type="text/css">');
			}
		</script>
		<script src="/cssjs/jquery.js"></script>
		<script src="/cssjs/jquery.cookie.js"></script>
		<script src="/view/js/cherry.js"></script>
		<script src="/view/mobileBridge.js"></script>
		<script>
			$(document).bind("mobileinit", function(){
				//$.mobile.defaultPageTransition="slide"; 
				$.mobile.defaultPageTransition = "none";
				
				$.mobile.pushStateEnabled = false;
				$.support.cors = true;
				$.mobile.allowCrossDomainPages = true;
				
				$.mobile.page.prototype.options.addBackBtn = false;
				$.mobile.useFastClick  = false;
				$.mobile.loadingMessage = "载入中...";
				$.mobile.page.prototype.options.backBtnText = "后退";
　　			$.mobile.pageLoadErrorMessage = "连接服务器出错,请重试!";

				inittodos();
			});
			function MoveIn(){
				this.path = '';
			}
			MoveIn.prototype.viewfile = function(url){
				this.path = url;
				$.mobile.changePage('/view/file.html', {
					reverse: false,
					changeHash: false
				});
			}
			MoveIn.prototype.getpath  = function(){
				return this.path;
			}
			var action = new MoveIn();
			//设置首页标题
			var setNavigationTitle=new cherry.bridge.NativeOperation("case","setProperty",["title","首页"]);
			cherry.bridge.registerEvent("case", "navButtonTouchUp", function(oper) {
					//alert("niubility");
					changePageBackWithBridge( 1);
				});
			setNavigationTitle.dispatch();
			//隐藏返回按钮
			var setNavigationBack=new cherry.bridge.NativeOperation("case","setProperty",["backButtonHidden","1"]);
			setNavigationBack.dispatch();
//场景显示消息
			cherry.bridge.registerEvent("case", "casePresented", function(oper) {
					//alert("niubility");
					inittodos();
				});

			//设置titleBar颜色

			/*
			var setTitleBarColor=new cherry.bridge.NativeOperation("case","setProperty",["navBarColor","#ff0000ff"]);
			setTitleBarColor.dispatch();
			cherry.bridge.flushOperations();
			*/

			function inittodos(){
				var url = "/view/digi/todosnum/Produce/GeneralMessage.nsf/GetAllMsgInfoAgent?openagent";
				$.ajax({
					type: "POST", url: url, data:'data-xml=yes^~^app|8|taskByDateDownUnDoneView|taskByDateDownDoneView^~^msg|5|msgByDateDownUnRdView|msgByDateDownRdView^~^flowinfo|5|FlowUndoView|FlowDoneView', dataType: "text", cache:false,
					success: function(response){
						$("#spanTodo").html(response);
					},
					error:function(response){
						alert("错误:"+response.responseText);
					}
				});
			}
		</script>
	<script src="../cssjs/jquery.mobile-1.0.1.js"></script>
    <style>
		.ui-header{
			position:fixed;
		}
	</style>
    </head>
	<body>
		<div data-role="page" id="home" style="background:url(/view/png/digi/bg_empty.png);background-size:cover;-moz-background-size:cover;" class="mi-bg">
		<!--
			<div data-role="header">
				<a data-icon="home" data-role="button" data-rel="back">返回</a>
				<h1>首页</h1>
				<a data-icon="home" data-role="button" href="javascript:void(0)" onclick="pushtest();" >推送</a>
			</div>
		-->
			<div data-role="content" align="center">
				<script>
					function openmail(){
						
						var runMail=new cherry.bridge.NativeOperation("application", "runTraveler", []).dispatch();
						var travelerScript = new cherry.bridge.ScriptOperation(function(){
								var result = runMail.returnValue;
								alert(result);
								
						});
						travelerScript.addDependency(runMail);
						travelerScript.dispatch();
						cherry.bridge.flushOperations();
						
					}
					function registdevice(){
						var getdeviceid = new cherry.bridge.NativeOperation("application", "getDeviceId", []).dispatch();
						var saveCookieScript = new cherry.bridge.ScriptOperation(function(){
							var result = getdeviceid.returnValue;
							if(result == ""){
								alert("无法获取设备ID");
								return;
							}
							$.ajax({
								type: "POST", url: "/view/digi?data-action=regisdevice&data-device-type=android&data-device-token="+result,
								success: function(response){
									alert("绑定成功，DeviceId为"+result);
								},
								error:function(response){
									alert("绑定失败!");
								}
							});
						});
						saveCookieScript.addDependency(getdeviceid);		
						saveCookieScript.dispatch();			
						cherry.bridge.flushOperations();
					}
					function pushtest(){
						try{
							window.plugins.propertiesPlugin.getDeviceId(
								{}, 
								function(result){
									var message = prompt("请输入发给自己的内容?");
									if(message==null){
										return;
									}
									if(message==""){
										alert("消息为空");
									}
									
									var url = "http://1.202.226.107:8082/server/push/message";
									$.ajax({
										type: "get",
										url: url,
										data: "deviceType=android&deviceToken="+result+"&message="+message,
										success: function(response){
											alert("发送成功!");
										}
									});
								},
								function(){}
							);
						}catch(e){}
						
					}
					function changepage(url){
						$.mobile.changePage(url, {changeHash:true, type: "post"});
					}
					//设置气泡的位置
					$(document).ready(function(){
							var imgOffset=$("#imgToDo").offset();
							var divOneOffset=$("#divOne").offset();
							var spanTodo=$("#spanTodo").get(0);
							spanTodo.style.position="fixed";
							//68为图片宽度
							if(window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
								spanTodo.style.top=divOneOffset.top-25;
								spanTodo.style.left=imgOffset.left+65;
								$("#aOpenMail").href="mailto:lvjx@sugon.com";
								$("#aOpenMail").removeAttr("onclick");
					
								
								

							}else if(window.navigator.userAgent.match(/android/i)) {
								
								spanTodo.style.top=divOneOffset.top;
								spanTodo.style.left=imgOffset.left+68+10;
							}else{
								alert('other')
								spanTodo.style.top=divOneOffset.top;
								spanTodo.style.left=imgOffset.left+68+10;
							
							}	
						}
					);
				</script>
				
				<div class="ui-grid-b" id="divOne" style="padding-top:1em">
                    <div class="ui-block-a" >
						
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('http://1.202.226.107:8082/view/digi/todosmobile/Produce/DigiFlowMobileJC.nsf/dataformserver?openform&thserver=&thdir=DFMessage&thdb=dfmsg_<%=request.getParameter("itcode") %>.nsf&thview=vwTaskUnDoneForMobile&bdoptdesname=%E5%BE%85%E5%8A%9E%E4%BB%BB%E5%8A%A1')">
							<img width="68" height="68" id= "imgToDo" src="/view/png/digi/todos.png" />
						</a>
						<span id="spanTodo" class="bubble-count ui-btn-up-c ui-btn-corner-all">...</span>
					
                        <br/>
						
                        <span style="color:white;"><strong>待办事宜</strong></span>
						
                    </div>
                    <div class="ui-block-b">
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('http://1.202.226.107:8082/view/digi/messagelist/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&login&0.6922244625974295&server=&dbpath=DFMessage/dfmsg_<%=request.getParameter("itcode") %>.nsf&view=vwMsgUnRdForMobile&thclass=&page=1&count=15&pageFrom=homepage')">
							<img width="68" height="68" src="/view/png/digi/unread.png" />
						</a>
                        <br/>
                        <span style="color:white;"><strong>未读消息</strong></span>
                    </div>
					 <div class="ui-block-b">
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('http://1.202.226.107:8082/view/digi/messagereadlist/DFMessage/dfmsg_<%=request.getParameter("itcode") %>.nsf/msgByDateDownRdView?readviewentries?login&start=1&count=3')">
							<img width="68" height="68" src="/view/png/digi/unread.png" /> 
						</a>
                        <br/>
                        <span style="color:white;"><strong>已读消息</strong></span>
                    </div>
                </div>
                <br/>
                <div class="ui-grid-b">
                    <div class="ui-block-a">
						<a href="javascript:void(0);" onclick="showLoading();changePageWithBridge('http://1.202.226.107:8082/view/digi/newslist/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&login&0.30080900634742125&server=&dbpath=Application/DigiFlowInfoPublish.nsf&view=InfoByDateView_2&thclass=Dir01$&page=1&count=15')">
							<img width="68" height="68" src="/view/png/digi/news.png" />
						</a>
                        <br/>
                        <span style="color:white;"><strong>企业新闻</strong></span>
                    </div>
                    <div class="ui-block-b">
						<a href="mailto:lvjx@sugon.com" id="aOpenMail">
                        <img width="68" height="68" src="/view/png/digi/mail.png" />
						</a>
                        <br/>
                        <span style="color:white;"><strong>邮件</strong></span>
                    </div>
                    <div class="ui-block-c">
						<a href="javascript:void(0)" onclick="showLoading();changePageWithBridge('http://1.202.226.107:8082/view/digi/phonenumber/Produce/WeboaConfig.nsf/telSearchForm?openform','http://1.202.226.107:8082/view/Resources/searchContact.xml')">
                        <img width="68" height="68" src="/view/png/digi/addressbook.png" />
						</a>
                        <br/>
                        <span style="color:white;"><strong>通讯录</strong></span>
                    </div>
                </div>
				
                <br/>
                <div class="ui-grid-b">
                    <div class="ui-block-a">
						<a href="javascript:void(0)" onclick="registdevice();">
                        <img width="68" height="68" src="/view/png/digi/notice.png" />
						</a>
                        <br/>
                        <span style="color:white;"><strong>终端注册</strong></span>
                    </div>
					
                </div>
				
			</div>
		</div>
		<iframe src="/view/digi?data-action=createuser" border="0" frameborder="no" framespacing="0" width="0" height="0"></iframe>
		
	</body>
</html>