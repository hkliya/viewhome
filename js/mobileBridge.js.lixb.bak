/*
  页面 跳转 依赖 cherry.js
  para:targetUrl 目标url
  componetXmlUrl:可选 默认组件为  web 容器 路径：view/resources/Resources/PureWeb.scene.xml
 
*/
function changePageWithBridge(targetUrl,componetXmlUrl){
	
	var serverUrl="http://mobile.sugon.com";
	
	if(typeof(componetXmlUrl)=="undefined"){
			componetXmlUrl=serverUrl+"/view/Resources/PureWeb.scene.xml";
			
	}

	var pushScene = new cherry.bridge.NativeOperation("application", "pushScene", [componetXmlUrl,targetUrl]);
	pushScene.dispatch();
	cherry.bridge.flushOperations();
	return pushScene;
		
}
/*
 页面 跳转  多用于返回上一页
 依赖 cherry.js
  para:targetUrl 目标url
  componetXmlUrl:可选 默认组件为  web 容器 路径：view/resources/Resources/PureWeb.scene.xml
*/
function changePageBackWithBridge(){
	
	var popScene = new cherry.bridge.NativeOperation("application", "popScene", []);
	
	popScene.dispatch();

	cherry.bridge.flushOperations();
	
	return popScene;
}


new cherry.bridge.NativeOperation("case","setProperty",["title","内容"]).dispatch();
cherry.bridge.flushOperations();