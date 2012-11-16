var cherry = new Object();
(function($){
/*
@author:lvjx
@统一cherry脚本，作为jquery扩展函数

*/
var opts={

	browerDebug:true,
	mobileDebug:false
}
//_init()中调用不同平台的function 做相应的初始化_cherryIos和_cherryAndroid
// var cherry;
var self=this;
var uma;			//用户手机浏览器版本

/*
	_getMobileAgent
	@return :返回用户浏览器类型 @type 对象{
		shell:浏览器内核
		mobile:undefined|apple|android|webos
	}
	@example:var ua=_getMobileAgent();
	if[ua["mobile"]]{
		
	}
	
	判断是否是手机


*/
function _getMobileAgent() {

    var ua = navigator.userAgent,
        EMPTY = '', MOBILE = 'mobile',
        core = EMPTY, shell = EMPTY, m,
        IE_DETECT_RANGE = [6, 9], v, end,
        VERSION_PLACEHOLDER = '{{version}}',
        IE_DETECT_TPL = '<!--[if IE ' + VERSION_PLACEHOLDER + ']><s></s><![endif]-->',
        div = document.createElement('div'), s,
        o = {
            // browser core type
            //webkit: 0,
            //trident: 0,
            //gecko: 0,
            //presto: 0,

            // browser type
            //chrome: 0,
            //safari: 0,
            //firefox:  0,
            //ie: 0,
            //opera: 0

            //mobile: '',
            //core: '',
            //shell: ''
        },
        numberify = function(s) {
            var c = 0;
            // convert '1.2.3.4' to 1.234
            return parseFloat(s.replace(/\./g, function() {
                return (c++ === 0) ? '.' : '';
            }));
        };

    // try to use IE-Conditional-Comment detect IE more accurately
    // IE10 doesn't support this method, @ref: http://blogs.msdn.com/b/ie/archive/2011/07/06/html5-parsing-in-ie10.aspx
    div.innerHTML = IE_DETECT_TPL.replace(VERSION_PLACEHOLDER, '');
    s = div.getElementsByTagName('s');

    if (s.length > 0) {

        shell = 'ie';
        o[core = 'trident'] = 0.1; // Trident detected, look for revision

        // Get the Trident's accurate version
        if ((m = ua.match(/Trident\/([\d.]*)/)) && m[1]) {
            o[core] = numberify(m[1]);
        }

        // Detect the accurate version
          // 注意：
        //  o.shell = ie, 表示外壳是 ie
        //  但 o.ie = 7, 并不代表外壳是 ie7, 还有可能是 ie8 的兼容模式
        //  对于 ie8 的兼容模式，还要通过 documentMode 去判断。但此处不能让 o.ie = 8, 否则
        //  很多脚本判断会失误。因为 ie8 的兼容模式表现行为和 ie7 相同，而不是和 ie8 相同
        for (v = IE_DETECT_RANGE[0],end = IE_DETECT_RANGE[1]; v <= end; v++) {
            div.innerHTML = IE_DETECT_TPL.replace(VERSION_PLACEHOLDER, v);
            if (s.length > 0) {
                o[shell] = v;
                break;
            }
        }

    } else {

        // WebKit
        if ((m = ua.match(/AppleWebKit\/([\d.]*)/)) && m[1]) {
            o[core = 'webkit'] = numberify(m[1]);

            // Chrome
            if ((m = ua.match(/Chrome\/([\d.]*)/)) && m[1]) {
                o[shell = 'chrome'] = numberify(m[1]);
            }
            // Safari
            else if ((m = ua.match(/\/([\d.]*) Safari/)) && m[1]) {
                o[shell = 'safari'] = numberify(m[1]);
            }

            // Apple Mobile
            if (/ Mobile\//.test(ua)) {
                o[MOBILE] = 'apple'; // iPad, iPhone or iPod Touch
            }
            // Android mobile
            if ((m = ua.match(/Android \d\.\d/))) {
                o[MOBILE] = 'android'; // Nokia N-series, Android, webOS, ex: NokiaN95
            }
            // webos mobile
            if ((m = ua.match(/webOS \d\.\d/))) {
                o[MOBILE] = 'webos'; // Nokia N-series, Android, webOS, ex: NokiaN95
            }
			 // Other WebKit Mobile Browsers
            else if ((m = ua.match(/NokiaN[^\/]*|webOS\/\d\.\d/))) {
                o[MOBILE] = m[0].toLowerCase(); // Nokia N-series, Android, webOS, ex: NokiaN95
            }
        }
        // NOT WebKit
        else {
            // Presto
            // ref: http://www.useragentstring.com/pages/useragentstring.php
            if ((m = ua.match(/Presto\/([\d.]*)/)) && m[1]) {
                o[core = 'presto'] = numberify(m[1]);

                // Opera
                if ((m = ua.match(/Opera\/([\d.]*)/)) && m[1]) {
                    o[shell = 'opera'] = numberify(m[1]); // Opera detected, look for revision

                    if ((m = ua.match(/Opera\/.* Version\/([\d.]*)/)) && m[1]) {
                        o[shell] = numberify(m[1]);
                    }

                    // Opera Mini
                    if ((m = ua.match(/Opera Mini[^;]*/)) && m) {
                        o[MOBILE] = m[0].toLowerCase(); // ex: Opera Mini/2.0.4509/1316
                    }
                    // Opera Mobile
                    // ex: Opera/9.80 (Windows NT 6.1; Opera Mobi/49; U; en) Presto/2.4.18 Version/10.00
                    // issue: ÓÉÓÚ Opera Mobile ÓÐ Version/ ×Ö¶Î£¬¿ÉÄÜ»áÓë Opera »ìÏý£¬Í¬Ê±¶ÔÓÚ Opera Mobile µÄ°æ±¾ºÅÒ²±È½Ï»ìÂÒ
                    else if ((m = ua.match(/Opera Mobi[^;]*/)) && m) {
                        o[MOBILE] = m[0];
                    }
                }

                // NOT WebKit or Presto
            } else {
                // MSIE
                // ÓÉÓÚ×î¿ªÊ¼ÒÑ¾­Ê¹ÓÃÁË IE Ìõ¼þ×¢ÊÍÅÐ¶Ï£¬Òò´ËÂäµ½ÕâÀïµÄÎ¨Ò»¿ÉÄÜÐÔÖ»ÓÐ IE10+
                if ((m = ua.match(/MSIE\s([^;]*)/)) && m[1]) {
                    o[core = 'trident'] = 0.1; // Trident detected, look for revision
                    o[shell = 'ie'] = numberify(m[1]);

                    // Get the Trident's accurate version
                    if ((m = ua.match(/Trident\/([\d.]*)/)) && m[1]) {
                        o[core] = numberify(m[1]);
                    }

                    // NOT WebKit, Presto or IE
                } else {
                    // Gecko
                    if ((m = ua.match(/Gecko/))) {
                        o[core = 'gecko'] = 0.1; // Gecko detected, look for revision
                        if ((m = ua.match(/rv:([\d.]*)/)) && m[1]) {
                            o[core] = numberify(m[1]);
                        }

                        // Firefox
                        if ((m = ua.match(/Firefox\/([\d.]*)/)) && m[1]) {
                            o[shell = 'firefox'] = numberify(m[1]);
                        }
                    }
                }
            }
        }
    }

    o.core = core;
    o.shell = shell;
    o._numberify = numberify;
    return o;
}

/*
	_cherryIos
	_cherryAndroid
	@description:负责跟手机通讯用脚本
	@return {brrdge 对象，提供跟手机交互桥接功能}
*/
function _cherryIos(){

	var bridge = new Object();
	var __nativeReadyQueue = new Array();
	var __scriptReadyQueue = new Array();

	var __runningOperations = new Object();

	bridge._beginNativeOperation = function () {
		var operation = __nativeReadyQueue.shift();
		if (operation != undefined) {
			__runningOperations[operation.__index] = operation;
			return operation.toString();
		} else
			return "";
	};

	bridge._endNativeOperation = function (returnStatus) {
		var operation = __runningOperations[returnStatus.index];
		if (operation) {
			operation.returnValue = returnStatus.returnValue;
			operation.stateCode = returnStatus.stateCode;
			operation._complete();
			delete __runningOperations[returnStatus.index];
		}
	};

	bridge._executeScriptOperations = function () {
		var operation = undefined;
		var executed = false;
		if ((operation = __scriptReadyQueue.shift()) != undefined) {
			operation._execute();
			operation._complete();
			executed = true;
		}
		return executed;
	};

	bridge._batchScriptOperations = function () {
		var count = 0;
		while (bridge._executeScriptOperations())
			count ++;
		return count;
	};

	var __bridgeFrame = (function () {
		frame = document.createElement("iframe");
		frame.setAttribute("width", "0px");
		frame.setAttribute("height", "0px");
		frame.setAttribute("id", "cherry_bridge_frame");
		frame.setAttribute("src", "bridge://localhost/flush");
		document.documentElement.appendChild(frame);
		return frame;
	})();

	bridge.flushOperations = function () {
		var frame = document.getElementById("cherry_bridge_frame");
		//frame.contentDocument.location.reload();
		frame.src = frame.src;
	};

	/**
	 * @class cherry.bridge.Operation
	 * @memberof cherry.bridge
	 * @brief The base class of operations
	 */
	var Operation = function () {
		/**
		 * @detail The operation state
		 *  state 0, not dispatched
		 *  state 1, waiting
		 *  state 2, in ready queue
		 *  state 3, finished
		 *
		 */
		this.__state = 0;
		this.__stateListener = undefined;
		this.__depCount = 0;
		this.__followers = new Array();
	};

	Operation.prototype.isDispatched = function () {
		return this.__state > 0;
	};

	Operation.prototype.isWaiting = function () {
		return this.__state == 1;
	};

	Operation.prototype.isReady = function () {
		return this.__state == 2;
	};

	Operation.prototype.isFinished = function () {
		return this.__state >= 3;
	};

	Operation.prototype._setState = function (state) {
		if (state != this.__state) {
			this.__state = state;
			if (this.stateListener != undefined)
				this.stateListener(state);
		}
	};

	Operation.prototype._complete = function () {
		this._setState(3);
		var follower = undefined;
		while ((follower = this.__followers.shift()) != undefined) {
			if ((-- follower.__depCount) == 0)
				follower._ready();
		}
	};

	Operation.prototype._ready = function () {
		this._setState(2);
	};

	Operation.prototype.setStateListener = function (stateListener) {
		if (this.isDispatched())
			throw new Error();
		this.__stateListener = stateListener;
	};

	Operation.prototype.addDependency = function (dependency)  {
		if (! dependency instanceof Operation)
			throw new Error();
		if (! dependency.isDispatched())
			throw new Error();
		if (this.isDispatched())
			throw new Error();
		if (!dependency.isFinished()) {
			dependency.__followers.push(this);
			this.__depCount ++;
		}
		return this;
	};

	Operation.prototype.dispatch = function () {
		if (! this.isDispatched()) {
			this._setState(1);
			if (this.__depCount == 0)
				this._ready();
		}
		return this;
	};

	var ScriptOperation = function (func) {
		Operation.apply(this);
		this.__func = func;
	};

	ScriptOperation.prototype = new Operation();

	ScriptOperation.prototype._ready = function () {
		Operation.prototype._ready.apply(this);
		__scriptReadyQueue.push(this);
	};

	ScriptOperation.prototype._execute = function () {
		this.__func(this);
	};

	var __indexCounter = 0;

	var NativeOperation = function (target, method, args) {
		Operation.apply(this);
		this.__target = target;
		this.__method = method;
		this.__args = args;
		this.__index = __indexCounter;
		__indexCounter = ((__indexCounter + 1) & 0x7fffffff);
	};

	NativeOperation.prototype = new Operation();

	NativeOperation.prototype._ready = function () {
		Operation.prototype._ready.apply(this);
		__nativeReadyQueue.push(this);
	};

	NativeOperation.prototype.toString = function () {
		return JSON.stringify({
			'target' : this.__target,
			'method' : this.__method,
			'args'   : this.__args,
			'index'  : this.__index,
		});
	};

	bridge.ScriptOperation = ScriptOperation;
	bridge.NativeOperation = NativeOperation;

	var __eventHandlers = new Object();

	bridge.registerEvent = function (target, eventName, routine) {
		if (__eventHandlers[target] == undefined)
			__eventHandlers[target] = new Object();
		__eventHandlers[target][eventName] = routine;
	};

	bridge._fireEvent = function (params) {
		var target = __eventHandlers[params.source];
		if (!target) {
			return false;	
		}

		var routine = target[params.eventName];
		if (!routine) {
			return false;	
		}

		var operation = new ScriptOperation(routine);
		operation.args = params.args;
		operation.dispatch();
		return true;
	};

	return bridge;
}




function _cherryAndroid(){
	var bridge = new Object();

	var __runningOperations = new Object();

	bridge._nativeOperationDidComplete = function (returnStatus) {
		var operation = __runningOperations[returnStatus.operationID];
		if (operation) {
			operation.returnValue = returnStatus.returnValue;
			operation.stateCode = returnStatus.stateCode;
			// alert("delete native operation " + returnStatus.operationID);
			delete __runningOperations[returnStatus.operationID];
		}
	};

	bridge._runScriptOperation = function (operationID) {
		var operation = __runningOperations[operationID];
		if (operation) {
			if (operation.__func) {
				// alert("running script operation:\n"+operation.__func);
				operation.__func.apply();
			}
			// alert("delete script operation " + returnStatus.operationID);
			delete __runningOperations[operationID];
		}
	};

	bridge.flushOperations = function () {
		cherry_bridge.Bridge_flush();
	};

	/**
	 * @class cherry.bridge.Operation
	 * @memberof cherry.bridge
	 * @brief The base class of operations
	 */
	var Operation = function (operationID) {
		// alert('operation: '+operationID);
		this.__operationID = operationID;
		if (__runningOperations[operationID]) {
			alert("Internal error, an existing operation #" + operationID + "is overrided");
		} else {
			__runningOperations[operationID] = this;
		}
	};

	Operation.prototype.addDependency = function (dependency)  {
		cherry_bridge.Operation_addDependency(this.__operationID, dependency.__operationID);
		return this;
	};

	Operation.prototype.dispatch = function () {
		cherry_bridge.Operation_dispatch(this.__operationID);
		return this;
	};

	var ScriptOperation = function (func) {
		var operationID = cherry_bridge.Bridge_createScriptOperation();
		// alert("create script operation #" + operationID);
		Operation.apply(this, [ operationID ]);
		this.__func = func;
	};


	var NativeOperation = function (target, method, args) {
		var operationID = cherry_bridge.Bridge_createNativeOperation(target, method, args);
		// alert("create native operation #" + operationID);
		Operation.apply(this, [ operationID ]);
		this.__target = target;
		this.__method = method;
		this.__args = args;
	};

	operationProto = new Operation(-1);
	ScriptOperation.prototype = operationProto;
	NativeOperation.prototype = operationProto;

	bridge.ScriptOperation = ScriptOperation;
	bridge.NativeOperation = NativeOperation;

	var __eventHandlers = new Object();

	bridge.registerEvent = function (target, eventName, routine) {
		if (__eventHandlers[target] == undefined)
			__eventHandlers[target] = new Object();
		__eventHandlers[target][eventName] = routine;
	};

	bridge._fireEvent = function (params){
		var target = __eventHandlers[params.source];
		if (!target) {
			return false;	
		}

		var routine = target[params.eventName];
		if (!routine) {
			return false;	
		}
		routine();
		return true;
	};

	return bridge;
}




/*
@descripttion: 根据不同的平台分别初始化cherry
触发horiInit事件
*/
(function _initCherry(){
	var ua=_getMobileAgent();
	if(ua["mobile"]){
		if(ua["mobile"]==="apple"){
			cherry=_cherryIos();
			// 兼容ios客户端暴露cherry.bridge
			cherry.bridge=cherry;

			return 	
		}
		if(ua["mobile"]==="android"){
			cherry=_cherryAndroid();
	
			return 	
		}
		// $.trigger("horiInit",cherry);
	}else{
		// 可能是浏览器模式,按照ios方式 初始化方便调试
		// cherry={};
		cherry=_cherryIos();
	}
	cherry.bridge=cherry;

})();
//返回给外部调用的对象
var horiPub={
	/*
		@param targetUrl @trype String 目标url 相对路径
		@param componetXmlUrl @type string  容器url 相对路径
	*/
	loadPage:function(targetUrl,componetXmlUrl){
		
		var ua=_getMobileAgent();
		if(ua["mobile"]){

			var serverUrl = document.location.protocol + "//" + document.location.host;
			
			if (typeof(componetXmlUrl) == " undefined ") {
				componetXmlUrl = serverUrl + "/view/Resources/PureWeb.scene.xml ";
				
			} else {
				componetXmlUrl = serverUrl + componetXmlUrl;
			}
			if (targetUrl == " ") {
				alert(" targetUrl参数不能为空 ");
			}
			targetUrl = serverUrl + targetUrl;
			if (opts.mobileDebug) {
				alert(" targetUrl = " + targetUrl);
				alert(" componetXmlUrl = " + componetXmlUrl);
			}
			
			var pushScene = new cherry.NativeOperation("application", "pushScene", [componetXmlUrl, targetUrl]);
			pushScene.dispatch();
			cherry.flushOperations()
		}else{
			if (opts.browerDebug) {
				window.location.href = targetUrl;
				return;
			}		
		}
	},
	/*
		@param forceRefresh @type:string  
		@default:"0" 如果强制刷新传"1" 即可
	*/
	backPage: function(forceRefresh) {
		var ua=_getMobileAgent();
		if(ua["mobile"]) {
			if(typeof(forceRefresh) == " undefined " || parseInt(forceRefresh, 10) == 0) {

				var refreshFlag = " 0 ";
			} else {
				var refreshFlag = " 1 ";
			}
			var popScene = new cherry.NativeOperation("application", "popScene", [refreshFlag]);

			popScene.dispatch();

			cherry.flushOperations();

		} else {

			if(opts.browerDebug) {
				window.go(-1);
				return;
			}
		}
	},
	// 调用原生loading页面
	showLoading:function(){
		if (opts.browerDebug) {		

		}
		if(_getMobileAgent()["mobile"]) {

			var loading = new cherry.NativeOperation("application", "showLoadingSheet", []);
			loading.dispatch();
			cherry.flushOperations();
		}

	},
	// 隐藏原生loading页面
	// @return :无

	hiddeLoading:function(){
		if (opts.browerDebug) {
			
		}
		if(_getMobileAgent()["mobile"]) {
			var hiddenLoading = new cherry.NativeOperation("application", "hideLoadingSheet", []);
			hiddenLoading.dispatch();
			cherry.flushOperations();
			
		}
	},
	/*
		@description:返回设备的uuid
		@return :uuid或空串
		@type:string	
		@param:callback 回调函数
	*/
	getDeviceId:function(callback){
		if($.isFunction(callback)){
			
			var getdeviceIdNative = new cherry.NativeOperation("application", "getDeviceId", []).dispatch();			
			
			var cherryScript = new cherry.ScriptOperation(function(){
				var deveiceId="";
				deveiceId=getdeviceIdNative.returnValue;				
				callback.apply(this,[deveiceId]);
					
			})
		
			cherryScript.addDependency(getdeviceIdNative);		
			cherryScript.dispatch();
			cherry.flushOperations();
			
		}else{
			alert("请传入正确的回调函数");
		}
	},
	/*
		@description:得到手机类型
		@return undefined 表示是浏览器 |apple|android|webos|nonia
	*/
	getMobileType:function(){
		return _getMobileAgent()["mobile"]
	},
	
	setHeaderTitle:function(title){
			var headerTitle="";
			if(title){
				headerTitle=title;
			}
			new cherry.NativeOperation("case","setProperty",["title",headerTitle]).dispatch();
			cherry.flushOperations();
	},
	/*
		返回cherry对象共外部调用
	*/
	"cherry":cherry


}
//rend hori
$(document).ready(function(){
	$(window.document).trigger("horiInit",[opts]);
	var hori=$.extend({},horiPub,opts);
	jQuery.extend({hori:hori})
	// $(window.document).trigger("horidone",[hori]);
	}	
)	

})(jQuery)