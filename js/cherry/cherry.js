﻿var scriptUrl=""
if (window.navigator.userAgent.match(/iPad/i) || window.navigator.userAgent.match(/iPhone/i) || window.navigator.userAgent.match(/iPod/i)) {
	scriptUrl="cherry_ios";
} else if (window.navigator.userAgent.match(/android/i)) {
	scriptUrl="cherry_android";
}
/*
	根据用户手机类型返回对应的cherry变量，暂时返回andriod和ios 以及undefined
*/

define([scriptUrl],function(cherry){
	return cherry;
});