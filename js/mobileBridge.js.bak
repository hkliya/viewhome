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
	//alert("targetUrl="+targetUrl);
	//alert(componetXmlUrl);
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
function changePageBackWithBridge(forceRefresh){
	
	
	if(typeof(forceRefresh)=="undefined" || parseInt(forceRefresh,10)==0){
		
		var refreshFlag="0";
	} else{
		var refreshFlag="1";
	}
	var popScene = new cherry.bridge.NativeOperation("application", "popScene", [refreshFlag]);
	
	popScene.dispatch();

	cherry.bridge.flushOperations();
	
	return popScene;
}

//调用native的 loading页面

function showLoading(){
	var loading=new cherry.bridge.NativeOperation("application","showLoadingSheet",[]);
	loading.dispatch();
	cherry.bridge.flushOperations();
}

//隐藏native的 loading页面

function hiddenLoading(){
	var hiddenLoading=new cherry.bridge.NativeOperation("application","hideLoadingSheet",[]);
	hiddenLoading.dispatch();
	cherry.bridge.flushOperations();
}

function getRequest(name) {
						var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)","i"),
						r = window.location.search.substr(1).match(reg);
						return (r!=null)?  unescape(r[2]) : null;
					}