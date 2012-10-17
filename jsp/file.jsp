<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page language="java" import="cc.movein.mda.system.control.Query"%>
<html lang="zh_cn">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=3;"/>
		<meta name="format-detection" content="telephone=no" />
		<script src="/cssjs/jquery.js"></script>
		<script src="/view/js/cherry.js"></script>
		<style>
			pre {
				white-space: pre-wrap;
				white-space: -moz-pre-wrap;
				white-space: -pre-wrap;
				white-space: -o-pre-wrap;
				word-wrap: break-word;
			}
		</style>
	</head>
	<body style="margin:0px;padding:0px;">
		<div data-role="page" style="margin:0px;padding:0px;">
			<div data-role="content" style="margin:0px;padding:0px;">
				<!--
				<link rel="stylesheet"  href="/cssjs/scrollview/jquery.mobile.scrollview.css" />
				<script src="/cssjs/scrollview/jquery.easing.1.3.js"></script>
				<script src="/cssjs/scrollview/jquery.mobile.scrollview.js"></script>
				<script src="/cssjs/scrollview/scrollview.js"></script>
				-->
				<%
				Query q = Query.getInstance(request);
				String path = q.getContent();
				path = path.replace("\\", "/");
				String type = q.getContentType();
				boolean ispage = false;
				if(type.indexOf("image")!=-1){
					%>
					<div align="center" style="margin:0;padding:0;">
						<img width="100%" src="/view<%=path%>" />
					</div>
					<%
				}else if(type.indexOf(".png")!=-1){
					%>
					<div align="center" style="margin:0;padding:0;"> 
						<img width="100%" src="/view<%=path%>" />
					</div>
					<%
				}else if(type.indexOf("text/plain")!=-1){
					%>
					<div align="left" style="margin:0;padding:0;">
						<pre><%=path%></pre>
					</div>
					<%
				}else if(type.indexOf("application/pdf")!=-1 || type.indexOf("application/msword")!=-1 || type.indexOf("application/octet-stream")!=-1 || type.indexOf("application/vnd.ms-powerpoint")!=-1){
					ispage = true;
					%>
					<div align="center">
						<div id="imgtitle" align="center" style="width:100%;background-color:#FFFFFF;display:none;"></div>
						<img width="100%" id="imgcontent" src="<%=q.getRequest().getRequestURI() %>?data-page=1" />
					</div>
					<%
				}
				%>
				<script>
					cherry.bridge.registerEvent("previousButton", "touchUp", function(oper) {
						prewpage();
					});
					cherry.bridge.registerEvent("nextButton", "touchUp", function(oper) {
						nextpage();
					});
					var isshowed = false;
					var currentPage = 1;
					var total = <%=q.getPageSize() %>;
					var path = "<%=q.getRequest().getRequestURI() %>";
					$("#imgtitle").html("第"+currentPage+"页/共" + total + "页");
					
					new cherry.bridge.NativeOperation("case","setProperty",["title","第"+currentPage+"页/共" + total + "页"]).dispatch();
					cherry.bridge.flushOperations();
					function changeimg(){
						$("#imgcontent").attr("src", "");
						$("#imgtitle").html("第"+currentPage+"页/共" + total + "页");
						
						new cherry.bridge.NativeOperation("case","setProperty",["title","第"+currentPage+"页/共" + total + "页"]).dispatch();
						cherry.bridge.flushOperations();
						if(path.indexOf('?')==-1){
							$("#imgcontent").attr("src", path + "?data-page=" + currentPage+"&data-cache=true").one('load',function(){$.mobile.hidePageLoadingMsg();});
						}else{
							$("#imgcontent").attr("src", path + "&data-page=" + currentPage+"&data-cache=true").one('load',function(){$.mobile.hidePageLoadingMsg();});
						}
					}
					function prewpage(){
						if(currentPage > 1){
							currentPage = currentPage - 1;
							changeimg();
						}
					}
					function nextpage(){
						if(currentPage < total){
							currentPage = currentPage + 1;
							changeimg();
						}
					}
				</script>
			</div><!-- /content -->
				<div style="display:none;">
				<a data-iconpos="top" data-icon="arrow-l" href="javascript:void(0);" onclick="prewpage();">PREW</a>
				<a data-iconpos="top" data-icon="arrow-r" href="javascript:void(0);" onclick="nextpage();">NEXT</a>
				</div>
				<!-- /footer -->
			</div>
		</div>
	</body>
</html>