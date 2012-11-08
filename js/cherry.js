var scriptUrl=""
if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
	scriptUrl="http://moa.lovol.com.cn:8088/view/js/cherry_ios.js";
} else if (window.navigator.userAgent.match(/android/i)) {
	scriptUrl="http://moa.lovol.com.cn:8088/view/js/cherry_android.js";
}

$.ajax({
		type: "get", 
		url: scriptUrl, 
		dataType: "script", 
		cache:false,
		async:false
})			