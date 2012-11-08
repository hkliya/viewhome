<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<html lang="zh_cn">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=3;"/>
		<meta name="format-detection" content="telephone=no" />
		<script src="/cssjs/jquery.js"></script>
		<script src="/view/js/cherry.js"></script>
		<script src="/view/js/mobileBridge.js"></script>
		<style>
			pre {
				white-space: pre-wrap;
				white-space: -moz-pre-wrap;
				white-space: -pre-wrap;
				white-space: -o-pre-wrap;
				word-wrap: break-word;
			}
			img{
			}
		</style>
	</head>
	<body style="margin:0px;padding:0px;">
		<div data-role="page" style="margin:0px;padding:0px;">
			<div data-role="content" style="margin:0px;padding:0px;">
				<%
				Query q = Query.getInstance(request);
				String path = q.getContent();
				path = path.replace("\\", "/");
				String type = q.getContentType();
				boolean ispage = false;
				if(type.indexOf("image")!=-1){
					path="/view"+path;
					%>
					<div align="center" style="margin:0;padding:0;">
						<img id="imgcontent"/>
					</div>
					<%
				}else if(type.indexOf(".png")!=-1 || type.indexOf(".jpg")!=-1){
					path="/view"+path;
					%>
					<div align="center" style="margin:0;padding:0;">
						<img id="imgcontent"/>
					</div>
					<%
				}else if(type.indexOf("text/")!=-1){
					%>
					<div align="left" style="margin:0;padding:0;">
						<pre><%=path%></pre>
					</div>
					<%
				}else if(type.indexOf("application/vnd")!=-1 || type.indexOf("application/pdf")!=-1 || type.indexOf("application/msword")!=-1 || type.indexOf("application/octet-stream")!=-1 || type.indexOf("application/vnd.ms-powerpoint")!=-1){
					ispage = true;
					path = q.getRequest().getRequestURI() + "?data-page=1";
					%>
					<div align="center">
						<div id="imgtitle" align="center" style="background-color:#FFFFFF;display:none;"></div>
						<img id="imgcontent"/>
					</div>
					<%
				}
				%>
				<script>
					var initwidth = document.body.clientWidth;
					$(document).ready(function(){
						cherry.bridge.registerEvent("previousButton", "touchUp", function(oper) {
							prewpage();
						});
						cherry.bridge.registerEvent("nextButton", "touchUp", function(oper) {
							nextpage();
						});
						var path = "<%=path %>";
						if(path.indexOf("?")!=-1){
							path = path + "&data-random=" + Math.random();
						}else{
							path = path + "?data-random=" + Math.random();
						}
						if($("#imgcontent")){
							$("#imgcontent").attr("src", path);
							$("#imgcontent").attr("width", initwidth);
						}
						showHideButtons();
					});

					var loaded = true;
					var isshowed = true;
					var currentPage = 1;
					var total = <%=q.getPageSize() %>;
					var path = "<%=q.getRequest().getRequestURI() %>";
					new cherry.bridge.NativeOperation("case","setProperty",["title","第"+currentPage+"页/共" + total + "页"]).dispatch();
					cherry.bridge.flushOperations();

					$("#imgtitle").html("第"+currentPage+"页/共" + total + "页");

					function showHideButtons() {
						if (currentPage > 1) {
							showButton("previousButton");
						} else {
							hideButton("previousButton");
						}
						if (currentPage < total) {
							showButton("nextButton");
						} else {
							hideButton("nextButton");
						}
					}
					
					
					function changeimg(){
						$("#imgcontent").attr("width", initwidth);
						showLoading();
						//$.mobile.showPageLoadingMsg();
						loaded = false;
						//$("#imgtitle").html("第"+currentPage+"页/共" + total + "页");
						new cherry.bridge.NativeOperation("case","setProperty",["title","第"+currentPage+"页/共" + total + "页"]).dispatch();
						cherry.bridge.flushOperations();
						showHideButtons();
						var random = parseInt(Math.random()*1000+1)
						if(path.indexOf('?')==-1){
							$("#imgcontent").attr("src", path + "?data-page=" + currentPage+"&data-cache=false&data-random=" + random).one('load',function(){
							hiddenLoading();loaded=true;});
						}else{
							$("#imgcontent").attr("src", path + "&data-page=" + currentPage+"&data-cache=false&data-random=" + random).one('load',function(){hiddenLoading();loaded=true;});
						}
					}
					function prewpage(){
						if(currentPage > 1 && loaded==true){
							currentPage = currentPage - 1;
							changeimg();
						}
					}
					function nextpage(){
						if(currentPage < total && loaded==true){
							currentPage = currentPage + 1;
							changeimg();
						}
					}
					function hideButton(xmlButtonName){
						new cherry.bridge.NativeOperation(xmlButtonName,"setProperty",["hidden","1"]).dispatch();
						cherry.bridge.flushOperations();
					}
					function showButton(xmlButtonName){
						new cherry.bridge.NativeOperation(xmlButtonName,"setProperty",["hidden","0"]).dispatch();
						cherry.bridge.flushOperations();
					}
				</script>
			</div><!-- /content -->
		</div>
	</body>
</html>