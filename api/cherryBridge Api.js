﻿由于时间问题暂时提供简易的api，后期完善

@name base
@class ：负责和navtive的接口，并提供一些常用的功能
@constructor ：
@extends ：类继承的父类
@requires ： require jquery cherry config
@param ：参数
@example : 调用方法:requie(/cherryBridge/base,function(){bridge})


showLoading()
/*
调用native的 loading页面
@param:无

*/
hiddenLoading
/*
隐藏native的 loading页面
@param:无

*/

changePageWithBridge
/*
调用native的接口进行页面切换，一般用于从前往后
@param: targetUrl  要切换目标url，如果手机端一般是相对路径
@type: string
@param:componetXmlUrl 要呈现目标url返回的html的容器xml
@tyep:string
@default: /view/Resources/PureWeb.scene.xml
*/

changePageBackWithBridge
/*
调用native的接口进行页面切换，一般用于返回

@param:forceRefresh 是否为强制刷新,默认为不刷新，1为强制刷新
@tyep:string
@default: "0"
*/
function getDeviceId
/*
@param:function 返回id后回调函数
@return :string如果无法得到在返回空值
@example:$.hor.getDeviceId(function(deviceid){alert(deviceid)})
*/
function setHeaderTitle(title){
	/*
	@description:设置手机最上方一栏标题
	@param:string 
	@return: 无
	@example:$.hori.setHeaderTitle("登录")
	*/
}