﻿//定义根路径和jquery变量
require({
	"baseUrl" : "/view/js/",
	"paths" : {
		"jquery" : "jquery/jquery-1.8.2"
		
	},
	priority : ['jquery']
});

define(["jquery", "cherry/cherry", "./config"], function ($, cherry, config) {
	var browerDebug = config.browerDebug;
	var phoneDebug = config.phoneDebug;
	return {
		//调用native的 loading页面
		showLoading : function () {
			if (browerDebug) {
				return;
			}
			var loading = new cherry.bridge.NativeOperation("application", "showLoadingSheet", []);
			loading.dispatch();
			cherry.bridge.flushOperations();
		},
		//隐藏native的 loading页面
		hiddenLoading : function () {
			if (browerDebug) {
				return;
			}
			var hiddenLoading = new cherry.bridge.NativeOperation("application", "hideLoadingSheet", []);
			hiddenLoading.dispatch();
			cherry.bridge.flushOperations();
		},
		changePageWithBridge : function (targetUrl, componetXmlUrl) {
			if (browerDebug) {
				window.location.href = targetUrl;
				return;
			}
			var serverUrl = document.location.protocol + "//" + document.location.host;
			
			if (typeof(componetXmlUrl) == " undefined ") {
				componetXmlUrl = serverUrl + " /view/Resources/PureWeb.scene.xml ";
				
			} else {
				componetXmlUrl = serverUrl + componetXmlUrl;
			}
			if (targetUrl == " ") {
				alert(" targetUrl参数不能为空 ");
			}
			targetUrl = serverUrl + targetUrl;
			if (phoneDebug) {
				alert(" targetUrl = " + targetUrl);
				alert(" componetXmlUrl = " + componetXmlUrl);
			}
			var pushScene = new cherry.bridge.NativeOperation(" application ", " pushScene ", [componetXmlUrl, targetUrl]);
			pushScene.dispatch();
			cherry.bridge.flushOperations();
			
		},
		changePageBackWithBridge : function (forceRefresh) {
			if (browerDebug) {
				window.go(-1);
				return;
			}
			if (typeof(forceRefresh) == " undefined " || parseInt(forceRefresh, 10) == 0) {
				
				var refreshFlag = " 0 ";
			} else {
				var refreshFlag = " 1 ";
			}
			var popScene = new cherry.bridge.NativeOperation(" application ", " popScene ", [refreshFlag]);
			
			popScene.dispatch();
			
			cherry.bridge.flushOperations();
			
			return popScene;
		},
		getUrlParameter:function(pname){
			var reg = new RegExp("(^ |  & )" + pname + " = ([^ & ] * )( &  | $)", " i "),
			r = window.location.search.substr(1).match(reg);
			return (r != null) ? unescape(r[2]) : null;
		}
	};
})

