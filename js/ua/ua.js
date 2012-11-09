/**
 * @module  ua
 * @author  lifesinger@gmail.com
 * @method {
			core,
			mobile����������Ϊundefined���ֻ����� apple|android|webos|nokia
		}
 */
define( function() {

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
        // ע�⣺
        //  o.shell = ie, ��ʾ����� ie
        //  �� o.ie = 7, ������������� ie7, ���п����� ie8 �ļ���ģʽ
        //  ���� ie8 �ļ���ģʽ����Ҫͨ�� documentMode ȥ�жϡ����˴������� o.ie = 8, ����
        //  �ܶ�ű��жϻ�ʧ����Ϊ ie8 �ļ���ģʽ������Ϊ�� ie7 ��ͬ�������Ǻ� ie8 ��ͬ
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
                    // issue: ���� Opera Mobile �� Version/ �ֶΣ����ܻ��� Opera ������ͬʱ���� Opera Mobile �İ汾��Ҳ�Ƚϻ���
                    else if ((m = ua.match(/Opera Mobi[^;]*/)) && m) {
                        o[MOBILE] = m[0];
                    }
                }

                // NOT WebKit or Presto
            } else {
                // MSIE
                // �����ʼ�Ѿ�ʹ���� IE ����ע���жϣ�����䵽�����Ψһ������ֻ�� IE10+
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
});

/**
 * NOTES:
 *
 * 2011.11.08
 *  - ie < 10 ʹ������ע���ж��ںˣ�����ȷ by gonghaocn@gmail.com
 *
 * 2010.03
 *  - jQuery, YUI ����ⶼ�Ƽ�������̽������������̽������̽��ĺô������Զ���Ӧδ���豸��δ֪�豸������
 *    if(document.addEventListener) ���� IE9 ֧�ֱ�׼�¼�������벻���޸ģ�������Ӧ�ˡ�δ�����������
 *    ����δ֪�����Ҳ����ˡ����ǣ��Ⲣ����ζ���������̽�͵ó������������������ȷ���������֪�ض�������ģ�
 *    ͬʱ������ĳ������̽����Խ��ʱ�����������̽�����ܴ�������ļ�࣬ͬʱҲҲ������ʲô�󻼡���֮��һ��
 *    ��Ȩ�⡣
 *  - UA.ie && UA.ie < 8 ������ζ��������Ͳ��� IE8, �п����� IE8 �ļ���ģʽ����һ�����ж���Ҫʹ�� documentMode.
 *
 * TODO:
 *  - test mobile
 *  - 3Q ��ս��360 ȥ���� UA ��Ϣ�е� 360 ��Ϣ������� res ����ȥ�ж�
 *
 */