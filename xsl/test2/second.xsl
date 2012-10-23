<?xml version="1.0" encoding="gb2312"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:template match="/">
		<html lang="zh_cn">
			<head>			
		<script src="/view/js/cherry.js"></script>
		<script src="/view/js/mobileBridge.js"></script>
		<script src="/cssjs/jquery.js"></script>
		<script src="/cssjs/jquery.mobile-1.0.1.js"></script>
		
		<script type="text/javascript"></script>
<script type="text/javascript">

			$(document).ready(function(){
			
			try{
				
				cherry.bridge.registerEvent("editButton", "touchUp", function(oper) {
				alert(1);
						
						document.getElementById("username1").value ="gbk"
					
				});
				cherry.bridge.flushOperations();
				
			}catch(err){
				alert(err.message);//错误信息
				alert(err.sourceURL);//文件
				alert(err.line);//错误所在行

			}		
		});
		


</script>
			</head>
			<body>
				
				<ul id="viewBody" data-role="listview" data-theme="c" data-inset="true" style="max-width:450px;">
					<li data-role="fieldcontain">
						<div style="width:100%;" align="left">
							<label><strong>帐  号:</strong></label>
							<input type="text" name="username" id="username" value=""  />
						</div>
					</li>
					<li data-role="fieldcontain">
						<div style="width:100%;" align="left">
							<label><strong>密  码:</strong></label>
							<input type="password" name="password" id="password" value=""  />
						</div>
					</li>
				</ul>

			</body>
		</html>
	</xsl:template>


</xsl:stylesheet>
