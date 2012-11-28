<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html lang="zh_cn">
	<head>  
        <title>移动办公</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<link rel="stylesheet"  href="/cssjs/jquery.mobile-1.2.0.css" />
		
		<script src="/cssjs/jquery.js"></script>
		
		<script src="/cssjs/jquery.mobile-1.2.0.js"></script>
		<script src="/view/js/hori.js?tag=201211136"></script>

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
				$.hori.getDeviceId(function(result){
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
				}
			);
		}

		function inittodos(){
			// var icount=0;
			
			if (icount!=gcount){
			

				var url = "/view/digi2/todosnum/Produce/GeneralMessage.nsf/GetAllMsgInfoAgent?openagent";
				$.ajax({
					type: "POST", url: url, data:'data-xml=yes^~^app|8|taskByDateDownUnDoneView|taskByDateDownDoneView^~^msg|5|msgByDateDownUnRdView|msgByDateDownRdView^~^flowinfo|5|FlowUndoView|FlowDoneView', dataType: "text", cache:false,
					success: function(response){
						$("#spanTodo").html(response);
					},
					error:function(response){
						alert("错误:"+response.responseText);
					}
				});
				icount=gcount;
			}
		}
			/*
				调整气泡位置
			*/
		function adjustBubble(){
			var imgOffset=$("#imgToDo").offset();
			var divOneOffset=$("#divOne").offset();
			var spanTodo=$("#spanTodo").get(0);
			spanTodo.style.position="fixed";
			//68为图片宽度
			if(window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
				spanTodo.style.top=divOneOffset.top-25;
				spanTodo.style.left=imgOffset.left+65;
				
	
			}else if(window.navigator.userAgent.match(/android/i)) {
				
				spanTodo.style.top=divOneOffset.top;
				spanTodo.style.left=imgOffset.left+68+10;
			}else{
				//alert('other')
				spanTodo.style.top=divOneOffset.top;
				spanTodo.style.left=imgOffset.left+68+10;
			
			}	
		}
		var gcount=1;
		var icount=0;
		$(document).ready(function(){
			try{
				var hori=$.hori;
				registdevice();
				/*设置标题*/
				hori.setHeaderTitle("首页");
				/*隐藏后退按钮*/
				hori.hideBackBtn();
				/*注册注销事件*/
				cherry.bridge.registerEvent("case", "navButtonTouchUp", function() {
						hori.backPage(1);
					});
				//刷新气泡显示代办条数
				cherry.bridge.registerEvent("case", "casePresented", function() {
						// alert("niubility");
						// 调用代办条数
						inittodos();
				});
				// 调整气泡位置
				adjustBubble();
				
			}catch(e){

			}
			
		});
		
		</script>
		<style>
			a{text-decoration:none;}
			.bubble-count { font-size: 11px; font-weight: bold; padding: .2em .5em; margin-left:-.5em;}
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
			
	
				<div class="ui-grid-b" id="divOne">
                    <div class="ui-block-a">
						<a href="javascript:void(0);" onclick="gcount+=1;$.hori.showLoading();$.hori.loadPage('/view/digi2/todosmobile/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&login&0.47540903102505816&server=V7dev/DigiWin=&dbpath=DFMessage/dfmsg_<%=request.getParameter("itcode")%>.nsf&view=vwTaskUnDoneForMobile&thclass=&page=1&count=20')">
							<img id= "imgToDo" width="68" height="68" src="/view/png/dbsy.png" />
						</a>
						
						<span id="spanTodo" class="bubble-count ui-btn-up-c ui-btn-corner-all">0</span>

                        <br/>
                        <span style="color:white;"><strong>待办事宜</strong></span>
                    </div>
                    <div class="ui-block-b">
						<a href="javascript:void(0);" onclick="$.hori.showLoading();$.hori.loadPage('/view/digi2/messagelist/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&login&0.6922244625974295&server=V7dev/DigiWin&dbpath=DFMessage/dfmsg_<%=request.getParameter("itcode")%>.nsf&view=vwMsgUnRdForMobile&thclass=&page=1&count=20&pageFrom=homepage')">
							<img width="68" height="68" src="/view/png/gwyl.png" />
						</a>
                        <br/>
                        <span style="color:white;"><strong>未读消息</strong></span>
                    </div>
					 <div class="ui-block-b">
						<a href="javascript:void(0);" onclick="$.hori.showLoading();$.hori.loadPage('/view/digi2/messagereadlist/Produce/DigiFlowMobile.nsf/agGetViewData?openagent&login&0.6922244625974296&server=V7dev/DigiWin=&dbpath=DFMessage/dfmsg_<%=request.getParameter("itcode") %>.nsf&view=vwMsgRdForMobile&thclass=&page=1&count=20')">
							<img width="68" height="68" src="/view/png/icon2.png"/> 
						</a>
                        <br/>
                        <span style="color:white;"><strong>已读消息</strong></span>
                    </div>
                </div>
                <br/>

                <div class="ui-grid-b">
					
                    
                    <div class="ui-block-a">
						<a href="javascript:void(0)" onclick="$.hori.showLoading();$.hori.loadPage('/view/digi2/phonenumber/Produce/WeboaConfig.nsf/telSearchForm?openform','/view/Resources/searchContact.xml')">
                        <img width="68" height="68" src="/view/png/digi/addressbook.png">
						</a>
                        <br/>
                        <span style="color:white;"><strong>电话查询</strong></span>
                    </div>
                    <div class="ui-block-b">
						<a href="javascript:void(0);" onclick="$.hori.showLoading();$.hori.loadPage('/view/digi2/newslist/Application/DigiFlowInfoPublish.nsf/InfoByDateView_2?readviewentries?login&start=1&count=20')">
							<img width="68" height="68" src="/view/png/kgxw.png">
						</a>
                        <br/>
                        <span style="color:white;"><strong>企业新闻</strong></span>    
                    </div>
                     

                   
                </div>
				
                <br/>
               
				
			</div>
		</div>

		
	</body>
</html>
