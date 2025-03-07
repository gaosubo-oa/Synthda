document.write("<script language=javascript src='/js/spirit/qwebchannel.js'></script>");
document.write("<script language=javascript src='/lib/es6/es6-promise.auto.min.js'></script>");
var specialdept = '';
var domains = '';  //获取当前域名（）
var datatyoe = {
    'docx': 'word',
    'doc': 'word',
    'DOCX': 'word',
    'DOC': 'word',
    'word': 'word',
    'WORD': 'word',
    'pptx': 'ppt',
    'ppt': 'ppt',
    'xlsx': 'excel',
    'xls': 'excel',
    'pdf': 'pdf',
    'ofd': 'ofd',
    'exe': 'exe',
    'bmp': 'pic',
    'jpg': 'pic',
    'jpeg': 'pic',
    'gif': 'pic',
    'png': 'pic',
    'rar': 'zip',
    'zip': 'zip',
    'AVI': 'video',
    'wma': 'video',
    'rmvb': 'video',
    'rm': 'video',
    'flash': 'video',
    'mp4': 'video',
    'mid': 'video',
    '3gp': 'video'
};
if (typeof (qt) != 'undefined') {
    window.close = function () {
        new QWebChannel(qt.webChannelTransport, function (channel) {
            var content = channel.objects.interface;
            content.xoa_sms('', window.location.href, "CLOSEWINDOWS");
        });
    }
}

/***************转换string的html文本**********************************/
function htmlEscape(s) {
    return s.replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/'/g, '&#039;')
        .replace(/"/g, '&quot;')
        .replace(/\n/g, '<br />');
}

/****************END*******************************/

/***************判断date是否是合法日期********************************/
function checkDate(date) {
    return (new Date(date).getDate() == date.substring(date.length - 2));
}

/****************END*******/
/****************判断link、script是否含有某些文件**************************/
function isInclude(name) {
    var js = /js$/i.test(name);
    var es = document.getElementsByTagName(js ? 'script' : 'link');
    for (var i = 0; i < es.length; i++)
        if (es[i][js ? 'src' : 'href'].indexOf(name) != -1) return true;
    return false;
}

/****************END*******/
function getCookie(name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}

/****************判断object是否为空***********************************/
function isObjectNull(data) {
    if (JSON.stringify(data) === '{}') {
        return false // 如果为空,返回false
    }
    return true // 如果不为空，则会执行到这一步，返回true
}

/****************END*******/

/****************promise封装的请求方法*******/
function myPromiseGet(url, params, dataType) {
    if (!dataType) {
        dataType = 'json'
    }
    return new Promise(function (resolve, reject) {
        $.get(url, params, function (data, status, xhr) {
            if (status == "success") {
                resolve(data);
            } else {
                reject(data)
            }
        }, dataType)
    })
}

function myPromisePost(url, params, dataType) {
    if (!dataType) {
        dataType = 'json'
    }
    return new Promise(function (resolve, reject) {
        $.post(url, params, function (data, status, xhr) {
            if (status == "success") {
                resolve(data);
            } else {
                reject(data)
            }
        }, dataType)
    })
}

/****************END*******/

/******array类型原型链增加：isArray、forEach方法*******/
if (!Array.isArray) {
    Array.isArray = function (arg) {
        return Object.prototype.toString.call(arg) === '[object Array]';
    };
}
if (!Array.prototype.forEach) {
    Array.prototype.forEach = function (callback/*, thisArg*/) {

        var T, k;

        if (this == null) {
            throw new TypeError('this is null or not defined');
        }

        // 1. Let O be the result of calling toObject() passing the
        // |this| value as the argument.
        var O = Object(this);

        // 2. Let lenValue be the result of calling the Get() internal
        // method of O with the argument "length".
        // 3. Let len be toUint32(lenValue).
        var len = O.length >>> 0;

        // 4. If isCallable(callback) is false, throw a TypeError exception.
        // See: /#x9.11
        if (typeof callback !== 'function') {
            throw new TypeError(callback + ' is not a function');
        }

        // 5. If thisArg was supplied, let T be thisArg; else let
        // T be undefined.
        if (arguments.length > 1) {
            T = arguments[1];
        }

        // 6. Let k be 0.
        k = 0;

        // 7. Repeat while k < len.
        while (k < len) {

            var kValue;

            // a. Let Pk be ToString(k).
            //    This is implicit for LHS operands of the in operator.
            // b. Let kPresent be the result of calling the HasProperty
            //    internal method of O with argument Pk.
            //    This step can be combined with c.
            // c. If kPresent is true, then
            if (k in O) {

                // i. Let kValue be the result of calling the Get internal
                // method of O with argument Pk.
                kValue = O[k];

                // ii. Call the Call internal method of callback with T as
                // the this value and argument list containing kValue, k, and O.
                callback.call(T, kValue, k, O);
            }
            // d. Increase k by 1.
            k++;
        }
        // 8. return undefined.
    };
}
/****************END*******/

/***********Date类型原型链增加转格式方法************/
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1,                 //月份
        "d+": this.getDate(),                    //日
        "h+": this.getHours(),                   //小时
        "m+": this.getMinutes(),                 //分
        "s+": this.getSeconds(),                 //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds()             //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));

    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
/****************END*******/

/*********String类型原型链增加去除ATTACHMENT_NAME方法**************/
String.prototype.clearAttachName = function () {
    var url = this;
    var clearAtmentName = url;
    if (url.indexOf('&ATTACHMENT_NAME=') > -1) {
        clearAtmentName = url.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
        if (url.split('&ATTACHMENT_NAME=')[1].indexOf('&FILESIZE=') > -1) {
            clearAtmentName += '&FILESIZE=' + url.split('&ATTACHMENT_NAME=')[1].split('&FILESIZE=')[1]
        }
    } else {
        clearAtmentName += '&ATTACHMENT_NAME=';
    }
    return clearAtmentName
}
/****************END*******/
;
;

if (window["context"] == undefined) {
    if (!window.location.origin) {
        window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
    }
    window["context"] = location.origin;
}
var domain = document.location.origin;
var hostname = document.location.hostname;
var layerjspate = domain + '/lib/layer/layer.js?20201106';
document.write("<script src=" + layerjspate + "><\/script>");
var widthnum = 1;
var boolTwo = true;
var departments = true;
var numstring = false;
var employeeUrl = '/getUserByCondition';
var employeeUrlExt = '/getUserByConditionExt';
var employeeUrlExt_s = '/hr/api/getByDeptIdStatusTwo';
var pcDownLoad = '/file/pc/ispiritXOASetup.exe';

//获取国际语言标志
var type = getCookie("language");

var ok = "";
var cancle = "";
var user_th_selectDepartment = "";
var select_the_category = "";
var ds = "";
var role = "";
var PreviewPage = "";
if (type == 'zh_CN') {
    ok = '确定';
    cancle = '取消';
    user_th_selectDepartment = '全部部门';
    user_th_specialselectDepartment = '系统（仅由系统管理员管理）';
    select_the_category = '请选择类别';
    ds = '请选择';
    role = '请选择角色';
    PreviewPage = '预览';
} else if (type == 'en_US') {
    ok = 'ok';
    cancle = 'cancle';
    user_th_selectDepartment = 'Please select the Department';
    user_th_specialselectDepartment = 'System (only by the system administrator)';
    select_the_category = 'Please select the category';
    ds = 'Please choose';
    role = 'Please choose the role';
    PreviewPage = 'preview';
} else if (type == 'zh_TW') {
    ok = '確定';
    cancle = '取消';
    user_th_selectDepartment = '全部部門';
    user_th_specialselectDepartment = '系統（僅由系統管理員管理）';
    select_the_category = '請選擇類別';
    ds = '請選擇';
    role = '請選擇角色';
    PreviewPage = '預覽';
} else {
    ok = '确定';
    cancle = '取消';
    user_th_selectDepartment = '全部部门';
    user_th_specialselectDepartment = '系统（仅由系统管理员管理）';
    select_the_category = '请选择类别';
    ds = '请选择';
    role = '请选择角色';
    PreviewPage = '预览';
}

//获取浏览器版本信息
function myBrowser() {
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    //alert(navigator.userAgent)
    var isOpera = userAgent.indexOf("Opera") > -1; //判断是否Opera浏览器
    var isIE = userAgent.indexOf("compatible") > -1
        && userAgent.indexOf("MSIE") > -1 && !isOpera; //判断是否IE浏览器
    var isEdge = userAgent.indexOf("Edge") > -1; //判断是否IE的Edge浏览器
    var isFF = userAgent.indexOf("Firefox") > -1; //判断是否Firefox浏览器
    var isSafari = userAgent.indexOf("Safari") > -1
        && userAgent.indexOf("Chrome") == -1; //判断是否Safari浏览器
    var isChrome = userAgent.indexOf("Chrome") > -1
        && userAgent.indexOf("Safari") > -1; //判断Chrome浏览器

    if (isIE) {
        var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
        reIE.test(userAgent);
        var fIEVersion = parseFloat(RegExp["$1"]);
        if (fIEVersion == 7) {
            return "IE7";
        } else if (fIEVersion == 8) {
            return "IE8";
        } else if (fIEVersion == 9) {
            return "IE9";
        } else if (fIEVersion == 10) {
            return "IE10";
        } else if (fIEVersion == 11) {
            return "IE11";
        } else {
            return "0";
        }//IE版本过低
        return "IE";
    }
    if (isOpera) {
        return "Opera";
    }
    if (isEdge) {
        return "Edge";
    }
    if (isFF) {
        return "FF";
    }
    if (isSafari) {
        return "Safari";
    }
    if (isChrome) {
        return "Chrome";
    }
    if (userAgent.indexOf('Trident/') > -1) {
        if (userAgent.indexOf('Trident/7.0')) {
            return "IE11";
        } else if (userAgent.indexOf('Trident/6.0')) {
            return "IE10";
        } else if (userAgent.indexOf('Trident/5.0')) {
            return "IE9";
        } else if (userAgent.indexOf('Trident/4.0')) {
            return "IE8";
        } else {
            //IE版本过低
            return "IE";
        }
    }

}

function imgerror(e, opt) {
    if (opt) {
        var url = '';
        switch (opt) {
            case 1://头像
                url = domain + '/img/user/boy.png';
                break;
            case 2://logo
                url = '';
                break;
            default:

        }
    }
    $(e).attr('src', url);
    var img = event.srcElement;
    img.onerror = null; //控制不要一直跳动

}

function imgerror1(e, opt) {
    if (opt) {
        var url = '';
        switch (opt) {
            case 1://头像
                url = domain + '/img/replaceImg/theme6/LOGOMain.png';
                break;
            case 2://logo
                url = '';
                break;
            default:

        }
    }
    $(e).attr('src', url);
}

function imgerror2(e, opt) {
    if (opt) {
        var url = '';
        switch (opt) {
            case 1://登录页logo
                url = domain + '/img/replaceImg/theme1/LOGO.png';
                break;
            case 2://logo
                url = '';
                break;
            case 16://logo
                url = domain + '/img/replaceImg/theme20/LOGO.png';
                break;
            case 17://logo
                url = domain + '/img/replaceImg/theme17/LOGO.png';
                break;
            case 18://logo
                url = domain + '/img/replaceImg/theme18/LOGO.png';
                break;
            default:

        }
    }
    $(e).attr('src', url);
}

function imgerrorSpecial(e, opt) {
    if (opt) {
        var url = '';
        switch (opt) {
            case 1://头像
                url = domain + '/img/main_img/nantouxiang.png';
                break;
            case 2://logo
                url = domain + '/img/main_img/nvtouxiang.png';
                break;
            default:

        }
    }
    $(e).attr('src', url);
}

/****************循环匹配字符start*****************************/
function matchString(string, character) {
    var flag = false;
    for (var i = 0; i < string.split(',').length; i++) {
        if (string.split(',')[i] != '' && string.split(',')[i] == character) {
            flag = true;
            return flag;
        }
    }
    return flag;
}

/****************END*******/

function imgDown(deptNum, me) {
    if ($(me).attr('data-types') == undefined) {
        $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
            $(me).find('img').width(8);
            $(me).find('img').height(14);
            $(me).next().hide();
            // $(me).next().html('')
        } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
            $(me).find('img').width(14);
            $(me).find('img').height(9);
            $(me).next().show();
        }
    } else {
        $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('img').width(8);
            $(me).find('img').height(14);
        } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('img').width(14);
            $(me).find('img').height(9);
        }
        if ($(me).attr('data-types') == '1') {
            $(me).next().show();
            $(me).attr('data-types', '2')
        } else if ($(me).attr('data-types') == '2') {
            $(me).next().hide();
            $(me).attr('data-types', '1')
        }
    }

    $('#btn').attr('data_id', deptNum);

    if ($(me).attr('data-numstring') == 1) {
        if (boolTwo) {
            if ($(me).next().css('display') == 'none') {
                return;
            }
            $.loadrole($(me).next(), deptNum, $(me).attr('data-numtrue'));
        } else {
            $.loadSidebar($(me).next(), deptNum)
        }
    }
    if ($(me).next().html() == '') {
        if (boolTwo) {
            $.loadrole($(me).next(), deptNum, $(me).attr('data-numtrue'), function () {
                if (departments) {
                    $.loadSidebar($(me).next(), deptNum)
                }
            })
        }

    }
    if ($(me).attr('data-numstring') == 2) {
        if (numstring) {
            $.loadSidebar($(me).next(), deptNum)
        }
    }

}

function imgDown3(deptNum, me) {
    if ($(me).attr('data-types') == undefined) {
        $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
            $(me).find('img').width(8);
            $(me).find('img').height(14);
            $(me).next().hide();
            // $(me).next().html('')
        } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
            $(me).find('img').width(14);
            $(me).find('img').height(9);
            $(me).next().show();
        }
    } else {
        $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('img').width(8);
            $(me).find('img').height(14);
        } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('img').width(14);
            $(me).find('img').height(9);
        }
        if ($(me).attr('data-types') == '1') {
            $(me).next().show();
            $(me).attr('data-types', '2')
        } else if ($(me).attr('data-types') == '2') {
            $(me).next().hide();
            $(me).attr('data-types', '1')
        }
    }

    $('#btn').attr('data_id', deptNum);

    if ($(me).attr('data-numstring') == 1) {
        if (boolTwo) {
            if ($(me).next().css('display') == 'none') {
                return;
            }
            $.loadrole2($(me).next(), deptNum, $(me).attr('data-numtrue'));
        } else {
            $.loadSidebar($(me).next(), deptNum)
        }
    }
    if ($(me).next().html() == '') {
        if (boolTwo) {
            $.loadrole2($(me).next(), deptNum, $(me).attr('data-numtrue'), function () {
                if (departments) {
                    $.loadSidebar($(me).next(), deptNum)
                }
            })
        }

    }
    if ($(me).attr('data-numstring') == 2) {
        if (numstring) {
            $.loadSidebar($(me).next(), deptNum)
        }
    }

}

function imgDown4(deptNum, me) {
    if ($(me).attr('data-types') == undefined) {
        $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
            $(me).find('img').width(8);
            $(me).find('img').height(14);
            $(me).next().hide();
            // $(me).next().html('')
        } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
            $(me).find('img').width(14);
            $(me).find('img').height(9);
            $(me).next().show();
        }
    } else {
        $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('img').width(8);
            $(me).find('img').height(14);
        } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('img').width(14);
            $(me).find('img').height(9);
        }
        if ($(me).attr('data-types') == '1') {
            $(me).next().show();
            $(me).attr('data-types', '2')
        } else if ($(me).attr('data-types') == '2') {
            $(me).next().hide();
            $(me).attr('data-types', '1')
        }
    }

    $('#btn').attr('data_id', deptNum);

    if ($(me).attr('data-numstring') == 1) {
        if (boolTwo) {
            if ($(me).next().css('display') == 'none') {
                return;
            }
            $.loadrole3($(me).next(), deptNum, $(me).attr('data-numtrue'));
        } else {
            $.loadSidebar($(me).next(), deptNum)
        }
    }
    if ($(me).next().html() == '') {
        if (boolTwo) {
            $.loadrole3($(me).next(), deptNum, $(me).attr('data-numtrue'), function () {
                if (departments) {
                    $.loadSidebar($(me).next(), deptNum)
                }
            })
        }

    }
    if ($(me).attr('data-numstring') == 2) {
        if (numstring) {
            $.loadSidebar($(me).next(), deptNum)
        }
    }

}

//用户管理
function imgDown_s(deptNum, me) {
    if ($(me).attr('data-types') == undefined) {
        $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": ""});
            $(me).find('img').width(8);
            $(me).find('img').height(14);
            $(me).next().hide();
            // $(me).next().html('')
        } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('img').css({"margin-top": "-3px", "margin-right": "4px", "margin-left": "-5px"});
            $(me).find('img').width(14);
            $(me).find('img').height(9);
            $(me).next().show();
        }
    } else {
        $(me).find('img').attr('src', $(me).find('img').attr('src') == '/img/sys/dapt_right.png' ? '/img/sys/dapt_down.png' : '/img/sys/dapt_right.png');
        if ($(me).find('img').attr('src') == '/img/sys/dapt_right.png') {
            $(me).find('img').width(8);
            $(me).find('img').height(14);
        } else if ($(me).find('img').attr('src') == '/img/sys/dapt_down.png') {
            $(me).find('img').width(14);
            $(me).find('img').height(9);
        }
        if ($(me).attr('data-types') == '1') {
            $(me).next().show();
            $(me).attr('data-types', '2')
        } else if ($(me).attr('data-types') == '2') {
            $(me).next().hide();
            $(me).attr('data-types', '1')
        }
    }

    $('#btn').attr('data_id', deptNum);

    if ($(me).attr('data-numstring') == 1) {
        if (boolTwo) {
            if ($(me).next().css('display') == 'none') {
                return;
            }
            $.loadroleUser($(me).next(), deptNum, $(me).attr('data-numtrue'));
        } else {
            $.loadSidebar($(me).next(), deptNum)
        }
    }
    if ($(me).next().html() == '') {
        if (boolTwo) {
            $.loadroleUser($(me).next(), deptNum, $(me).attr('data-numtrue'), function () {
                if (departments) {
                    $.loadSidebar($(me).next(), deptNum)
                }
            })
        }

    }
    if ($(me).attr('data-numstring') == 2) {
        if (numstring) {
            $.loadSidebar($(me).next(), deptNum)
        }
    }

}

//取文件后缀名
function GetFileExt(filepath) {
    if (filepath != "") {
        var pos = "." + filepath.replace(/.+\./, "");
        return pos;
    }
}

//取文件名不带后缀
function GetFileNameNoExt(filepath) {
    var pos = strturn(GetFileExt(filepath));
    var file = strturn(filepath);
    var pos1 = strturn(file.replace(pos, ""));
    var pos2 = GetFileName(pos1);
    return pos2;

}

//字符串逆转
function strturn(str) {
    if (str && str != "") {
        var str1 = "";
        for (var i = str.length - 1; i >= 0; i--) {
            str1 += str.charAt(i);
        }
        return (str1);
    } else {
        return ''
    }
}

//取文件全名名称
function GetFileName(filepath) {
    if (filepath != "") {
        var names = filepath.split("\\");
        return names[names.length - 1];
    }
}

//设定一个元素高度
function autoIDheight(id, height) {
    var winHeight = 0;
    if (window.innerHeight)
        winHeight = window.innerHeight;
    else if ((document.body) && (document.body.clientHeight))
        winHeight = document.body.clientHeight;
    if (document.documentElement && document.documentElement.clientHeight)
        winHeight = document.documentElement.clientHeight;
    winWidth = document.documentElement.clientWidth;
    document.getElementById(id).style.height = winHeight - parseInt(height) + "px";
}

//设定页面大小变化刷新
function windowReload() {
    window.onresize = function () {
        location.reload();
    }
}

/**********计算控件计算公式匹配*************/
function excSumFormitem(formtitle, formitem) {
    if (formtitle.indexOf('(' + formitem + '+') > -1 || formtitle.indexOf('(' + formitem + '-') > -1 || formtitle.indexOf('(' + formitem + '*') > -1 || formtitle.indexOf('(' + formitem + '/') > -1 || formtitle.indexOf('(' + formitem + '^') > -1 || formtitle.indexOf('(' + formitem + ')') > -1
        || formtitle.indexOf('+' + formitem + '+') > -1 || formtitle.indexOf('+' + formitem + '-') > -1 || formtitle.indexOf('+' + formitem + '*') > -1 || formtitle.indexOf('+' + formitem + '/') > -1 || formtitle.indexOf('+' + formitem + '^') > -1 || formtitle.indexOf('+' + formitem + ')') > -1
        || formtitle.indexOf('-' + formitem + '+') > -1 || formtitle.indexOf('-' + formitem + '-') > -1 || formtitle.indexOf('-' + formitem + '*') > -1 || formtitle.indexOf('-' + formitem + '/') > -1 || formtitle.indexOf('-' + formitem + '^') > -1 || formtitle.indexOf('-' + formitem + ')') > -1
        || formtitle.indexOf('*' + formitem + '+') > -1 || formtitle.indexOf('*' + formitem + '-') > -1 || formtitle.indexOf('*' + formitem + '*') > -1 || formtitle.indexOf('*' + formitem + '/') > -1 || formtitle.indexOf('*' + formitem + '^') > -1 || formtitle.indexOf('*' + formitem + ')') > -1
        || formtitle.indexOf('/' + formitem + '+') > -1 || formtitle.indexOf('/' + formitem + '-') > -1 || formtitle.indexOf('/' + formitem + '*') > -1 || formtitle.indexOf('/' + formitem + '/') > -1 || formtitle.indexOf('/' + formitem + '^') > -1 || formtitle.indexOf('/' + formitem + ')') > -1
        || formtitle.indexOf('^' + formitem + '+') > -1 || formtitle.indexOf('^' + formitem + '-') > -1 || formtitle.indexOf('^' + formitem + '*') > -1 || formtitle.indexOf('^' + formitem + '/') > -1 || formtitle.indexOf('^' + formitem + '^') > -1 || formtitle.indexOf('^' + formitem + ')') > -1
        || formtitle.indexOf('(' + formitem + ',') > -1 || formtitle.indexOf(',' + formitem + ',') > -1 || formtitle.indexOf(',' + formitem + ')') > -1
        || formtitle.indexOf('(' + formitem + '，') > -1 || formtitle.indexOf('，' + formitem + '，') > -1 || formtitle.indexOf('，' + formitem + ')') > -1) {
        return true;
    } else {
        return false;
    }
}

function returnArr(formtitle, formitem) {
    var returnArr = [];
    var arr2 = formtitle;
    if (formtitle.indexOf('(' + formitem + '+') > -1) {
        var arr1 = '(' + formitem + '+';
        var arr3 = '(';
        var arr4 = '+';
    } else if (formtitle.indexOf('(' + formitem + '-') > -1) {
        var arr1 = '(' + formitem + '-';
        var arr3 = '(';
        var arr4 = '-';
    } else if (formtitle.indexOf('(' + formitem + '*') > -1) {
        var arr1 = '(' + formitem + '*';
        var arr3 = '(';
        var arr4 = '*';
    } else if (formtitle.indexOf('(' + formitem + '/') > -1) {
        var arr1 = '(' + formitem + '/';
        var arr3 = '(';
        var arr4 = '/';
    } else if (formtitle.indexOf('(' + formitem + '^') > -1) {
        var arr1 = '(' + formitem + '^';
        var arr3 = '(';
        var arr4 = '^';
    } else if (formtitle.indexOf('(' + formitem + ')') > -1) {
        var arr1 = '(' + formitem + ')';
        var arr3 = '(';
        var arr4 = ')';
    } else if (formtitle.indexOf('+' + formitem + '+') > -1) {
        var arr1 = '+' + formitem + '+';
        var arr3 = '+';
        var arr4 = '+';
    } else if (formtitle.indexOf('+' + formitem + '-') > -1) {
        var arr1 = '+' + formitem + '-';
        var arr3 = '+';
        var arr4 = '-';
    } else if (formtitle.indexOf('+' + formitem + '*') > -1) {
        var arr1 = '+' + formitem + '*';
        var arr3 = '+';
        var arr4 = '*';
    } else if (formtitle.indexOf('+' + formitem + '/') > -1) {
        var arr1 = '+' + formitem + '/';
        var arr3 = '+';
        var arr4 = '/';
    } else if (formtitle.indexOf('+' + formitem + '^') > -1) {
        var arr1 = '+' + formitem + '^';
        var arr3 = '+';
        var arr4 = '^';
    } else if (formtitle.indexOf('+' + formitem + ')') > -1) {
        var arr1 = '+' + formitem + ')';
        var arr3 = '+';
        var arr4 = ')';
    } else if (formtitle.indexOf('-' + formitem + '+') > -1) {
        var arr1 = '-' + formitem + '+';
        var arr3 = '-';
        var arr4 = '+';
    } else if (formtitle.indexOf('-' + formitem + '-') > -1) {
        var arr1 = '-' + formitem + '-';
        var arr3 = '-';
        var arr4 = '-';
    } else if (formtitle.indexOf('-' + formitem + '*') > -1) {
        var arr1 = '-' + formitem + '*';
        var arr3 = '-';
        var arr4 = '*';
    } else if (formtitle.indexOf('-' + formitem + '/') > -1) {
        var arr1 = '-' + formitem + '/';
        var arr3 = '-';
        var arr4 = '/';
    } else if (formtitle.indexOf('-' + formitem + '^') > -1) {
        var arr1 = '-' + formitem + '^';
        var arr3 = '-';
        var arr4 = '^';
    } else if (formtitle.indexOf('-' + formitem + ')') > -1) {
        var arr1 = '-' + formitem + ')';
        var arr3 = '-';
        var arr4 = ')';
    } else if (formtitle.indexOf('*' + formitem + '+') > -1) {
        var arr1 = '*' + formitem + '+';
        var arr3 = '*';
        var arr4 = '+';
    } else if (formtitle.indexOf('*' + formitem + '-') > -1) {
        var arr1 = '*' + formitem + '-';
        var arr3 = '*';
        var arr4 = '-';
    } else if (formtitle.indexOf('*' + formitem + '*') > -1) {
        var arr1 = '*' + formitem + '*';
        var arr3 = '*';
        var arr4 = '*';
    } else if (formtitle.indexOf('*' + formitem + '/') > -1) {
        var arr1 = '*' + formitem + '/';
        var arr3 = '*';
        var arr4 = '/';
    } else if (formtitle.indexOf('*' + formitem + '^') > -1) {
        var arr1 = '*' + formitem + '^';
        var arr3 = '*';
        var arr4 = '^';
    } else if (formtitle.indexOf('*' + formitem + ')') > -1) {
        var arr1 = '*' + formitem + ')';
        var arr3 = '*';
        var arr4 = ')';
    } else if (formtitle.indexOf('/' + formitem + '+') > -1) {
        var arr1 = '/' + formitem + '+';
        var arr3 = '/';
        var arr4 = '+';
    } else if (formtitle.indexOf('/' + formitem + '-') > -1) {
        var arr1 = '/' + formitem + '-';
        var arr3 = '/';
        var arr4 = '-';
    } else if (formtitle.indexOf('/' + formitem + '*') > -1) {
        var arr1 = '/' + formitem + '*';
        var arr3 = '/';
        var arr4 = '*';
    } else if (formtitle.indexOf('/' + formitem + '/') > -1) {
        var arr1 = '/' + formitem + '/';
        var arr3 = '/';
        var arr4 = '/';
    } else if (formtitle.indexOf('/' + formitem + '^') > -1) {
        var arr1 = '/' + formitem + '^';
        var arr3 = '/';
        var arr4 = '^';
    } else if (formtitle.indexOf('/' + formitem + ')') > -1) {
        var arr1 = '/' + formitem + ')';
        var arr3 = '/';
        var arr4 = ')';
    } else if (formtitle.indexOf('^' + formitem + '+') > -1) {
        var arr1 = '^' + formitem + '+';
        var arr3 = '^';
        var arr4 = '+';
    } else if (formtitle.indexOf('^' + formitem + '-') > -1) {
        var arr1 = '^' + formitem + '-';
        var arr3 = '^';
        var arr4 = '-';
    } else if (formtitle.indexOf('^' + formitem + '*') > -1) {
        var arr1 = '^' + formitem + '*';
        var arr3 = '^';
        var arr4 = '*';
    } else if (formtitle.indexOf('^' + formitem + '/') > -1) {
        var arr1 = '^' + formitem + '/';
        var arr3 = '^';
        var arr4 = '/';
    } else if (formtitle.indexOf('^' + formitem + '^') > -1) {
        var arr1 = '^' + formitem + '^';
        var arr3 = '^';
        var arr4 = '^';
    } else if (formtitle.indexOf('^' + formitem + ')') > -1) {
        var arr1 = '^' + formitem + ')';
        var arr3 = '^';
        var arr4 = ')';
    } else if (formtitle.indexOf('(' + formitem + ',') > -1) {
        var arr1 = '(' + formitem + ',';
        var arr3 = '(';
        var arr4 = ',';
    } else if (formtitle.indexOf(',' + formitem + ',') > -1) {
        var arr1 = ',' + formitem + ',';
        var arr3 = ',';
        var arr4 = ',';
    } else if (formtitle.indexOf(',' + formitem + ')') > -1) {
        var arr1 = ',' + formitem + ')';
        var arr3 = ',';
        var arr4 = ')';
    } else if (formtitle.indexOf('(' + formitem + '，') > -1) {
        var arr1 = '(' + formitem + '，';
        var arr3 = '(';
        var arr4 = '，';
    } else if (formtitle.indexOf('，' + formitem + '，') > -1) {
        var arr1 = '，' + formitem + '，';
        var arr3 = '，';
        var arr4 = '，';
    } else if (formtitle.indexOf('，' + formitem + ')') > -1) {
        var arr1 = '，' + formitem + ')';
        var arr3 = '，';
        var arr4 = ')';
    }
    returnArr.push(arr1, arr2, arr3, arr4)
    return returnArr
}

var formulaOpt = '';

function translateTo(formula, v) {
    var opt = formula;
    var arr = returnArr(opt, v.title);
    var repalce1 = arr[0];
    if (v.value) {
        var reg = /^(\d{4})-(\d{2})-(\d{2})$/;
        if (v.value.indexOf('上午') > -1 || v.value.indexOf('下午') > -1) {
            var strtime = v.value.split(' ')[0];
            var time = strtime.replace(/\-/g, '/');
            if (opt.indexOf(v.title + '-') > -1) {
                if (v.value.indexOf('上午') > -1) {
                    time += ' 12:00:00';
                } else if (v.value.indexOf('下午') > -1) {
                    time += ' 23:59:59';
                }
            } else {
                if (v.value.indexOf('上午') > -1) {
                    time += ' 00:00:00';
                } else if (v.value.indexOf('下午') > -1) {
                    time += ' 12:00:00';
                }
            }
            var repalce2 = parseFloat(new Date(time).getTime() / 1000);
            repalce2 = arr[2] + repalce2 + arr[3];
        } else {
            if ((v.value.indexOf('-') > -1 && v.value.indexOf(':') > -1) || reg.test(v.value)) {
                var time = v.value.replace(/\-/g, '/');
                if (v.value.indexOf(':') == -1 && opt.indexOf('DAY(' + v.title) > -1) {
                    var repalce2 = parseFloat(new Date(time).getTime() / 1000) + 86400;
                } else {
                    var repalce2 = parseFloat(new Date(time).getTime() / 1000);
                }
            } else {
                var repalce2 = v.value.replace(/[^\-?\d][^0-9.]/g, "");
            }
            repalce2 = arr[2] + repalce2 + arr[3];
        }
    } else {
        var repalce2 = arr[2] + 0 + arr[3];
    }
    opt = opt.replace(repalce1, repalce2);
    formulaOpt = opt;
    if (opt.indexOf(v.title) > -1 && excSumFormitem(opt, v.title)) {
        translateTo(opt, v)
    }
}

/***********END************/

$.extend({
    popWindow: function (url, title, top, left, width, height) {
        if ((url.indexOf('/webOffice') > -1
            || url.indexOf('/ntko') > -1) && navigator.userAgent.indexOf('QtWeb') > -1) {
            url += '&ie_open=yes';
            window.open(url);
            return false;
        }
        // 判断打开的通过软航NTKO或点聚WebOffice加载的查阅Office格式文件页面、PDF预览页面、工作流相关页面，直接用浏览器新标签打开
        if (url.indexOf('/webOffice') > -1 || url.indexOf('/ntko') > -1 || url.indexOf('/pdfPreview') > -1
            || url.indexOf('/work/workformPreView') > -1 || url.indexOf('/work/workform') > -1) {
            window.open(url);
            return false;
        }
        var top = top || '100';
        var left = left || '300';
        var width = width || '1080';
        var height = height || '500';
        if (top == 0 && left == 0 & width == '1200px' && height == '600px') {
            top = '0px';
            left = '100px';
            width = window.screen.width - 200 + 'px';
            height = window.screen.height - 100 + 'px';
        }
        if (url.indexOf('/common/selectPriv?') > -1) {
            width = '544';
        }

        var specs = 'top=' + top + ',left=' + left + ',width=' + width + ',height=' + height + ',toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no';
        window.open(url, title, specs);
    },
    layerAlert: function (option, cb) {
        layer.alert(option.content, {
            icon: option.icon,
            title: option.title
        }, function (index) {
            layer.close(index);
            cb();
        });
    },
    layerMsg: function (option, cb) {
        layer.msg(option.content, {icon: option.icon, time: 3000}, function () {
            if (cb) {
                cb();
            }
        });
    },
    layerConfirm: function (option, success, cancel) {
        layer.confirm(option.content, {
            offset: option.offset || 'auto',
            icon: option.icon,
            title: option.title,
            btn: [ok, cancle] //按钮
        }, function (index) {
            if (success) {
                success();
                layer.close(index)
            }
        }, function () {
            if (cancel) {
                cancel();
            }
        });
    },
    GetRequest: function (urls) {//获取get窗口数据
        var url;
        if (urls == undefined) {
            url = location.search; //获取url中"?"符后的字串
        } else {
            url = urls.substr(urls.indexOf("?"))
        }
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
            }
        }
        return theRequest;
    },
    UrlGetRequest: function (urls) {//获取get窗口数据
        var url;
        if (urls == undefined) {
            url = location.search; //获取url中"?"符后的字串
        } else {
            url = urls.substr(urls.indexOf("?"))
        }
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                theRequest[strs[i].split("=")[0]] = (strs[i].split("=")[1]);
            }
        }
        var attach = theRequest.ATTACHMENT_NAME;
        return attach.substring(attach.lastIndexOf(".") + 1, attach.length);
    },
    transforFormula: function (opt, opts) {
        formulaOpt = opt;
        if (opts instanceof Array && opts.length > 0) {
            var opt = "(" + opt.replace(/\s+/g, "") + ")";
            formulaOpt = opt;
            opts.forEach(function (v, i) {
                if (opt.indexOf(v.title) > -1 && excSumFormitem(opt, v.title)) {
                    translateTo(formulaOpt, v)
                }
            });
        }
        var opt = formulaOpt;
        formulaOpt = '';
        return opt;
    },
    pdurl: function (gs, atturl) {
        if (atturl != undefined && atturl.indexOf('&ATTACHMENT_NAME=') > -1 && atturl.indexOf('isOld=1') == -1) {
            var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
            var atturl2 = '';
            if (atturl.split('&ATTACHMENT_NAME=')[1] != undefined && atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1) {
                for (var i = 1; i < atturl.split('&ATTACHMENT_NAME=')[1].split('&').length; i++) {
                    atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
                }
                atturl = atturl1 + atturl2;
            } else {
                atturl = atturl1;
            }
        }
        if (gs == 'pdf' || gs == 'txt' || gs == 'PDF' || gs == 'TXT') {
            $.popWindow("/pdfPreview?" + atturl, PreviewPage, '0', '0', '1200px', '600px');
        } else if (gs == 'png' || gs == 'PNG' || gs == 'jpg' || gs == 'JPG' || gs == 'bmp' || gs == 'BMP') {
            $.popWindow("/xs?" + atturl, PreviewPage, '0', '0', '1200px', '600px');
        } else {
            var url = "/common/webOffice?documentEditPriv=0&fomat=" + gs + "&" + atturl;
            $.ajax({
                url: '/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
                type: 'post',
                datatype: 'json',
                async: false,
                success: function (res) {
                    if (res.flag) {
                        if (res.object[0].paraValue == 0) {
                            //默认加载NTKO插件 进行跳转
                            url = "/common/ntko?documentEditPriv=0&fomat=" + gs + "&" + atturl + '&ie_open=yes&IE=1';
                        } else if (res.object[0].paraValue == 2) {
                            //默认加载NTKO插件 进行跳转
                            url = "/wps/info?" + atturl + "&permission=write";
                        } else if (res.object[0].paraValue == 3) {

                            //默认加载NTKO插件 进行跳转
                            url = "/common/onlyoffice?" + atturl + "&edit=true";
                        }
                    }

                }
            })
            $.popWindow(url, PreviewPage, '0', '0', '1200px', '600px');
        }
    }
});

$.fn.deptSelect = function (args, timers) {
    if (specialdept != undefined) {
        if (specialdept == 1) {
            user_th_selectDepartment = user_th_specialselectDepartment;
        }
    }
    var _this = $(this);
    if (timers != null) {
        clearInterval(timers);
        timers = null;
    }
    $.ajax({
        url: "/department/getAlldept",
        type: 'get',
        data: {},
        dataType: 'json',
        success: function (obj) {
            var data = obj.obj;
            var departmentData = [];
            /*******************处理了分级机构下 下拉菜单存在莫种情况：数据返回的多级部门但未返回它的父部门 start*********************/
            for (var i = 0; i < data.length; i++) {
                if (data[i].deptParent != '0' && data[i].deptParent != 99999999) {
                    for (var j = 0; j < data.length; j++) {
                        if (data[i].deptParent == data[j].deptId) {
                            break;
                        } else {
                            if (j == data.length - 1) {
                                if (digui(data, data[i].deptParent)) {
                                    departmentData = departmentData.concat(digui(data, data[i].deptParent));
                                }
                            }
                        }
                    }
                }
            }
            /********************************end********************************************/
            if (digui(data, 0)) {
                departmentData = departmentData.concat(digui(data, 0));
            }
            var str = departmentChild(departmentData, '<option value="">' + user_th_selectDepartment + '</option>', 0, -1);
            if (_this.hasClass('form_item') && _this.attr('data-type') == 'macros') {
                $('#' + _this.attr('id')).html(str);
            } else {
                _this.html(str);
            }
            if (_this.attr('pval') && (_this.attr('pval').indexOf('_') > -1)) {
                var pval = _this.attr('pval').split('_');
                _this.val(pval[0]);
            }
            if (args != undefined) {
                args(_this);
            }
        },
        error: function () {
        }
    });
};
$.ajaxSetup({cache: false});
$(function () {
    $.ajaxSetup({cache: false});
    $(document).on('click', '.collect span', function () {
        $('.collect span').removeClass('add_back');
        $(this).addClass('add_back');
    })
    //附加下载公有方法
    $(document).on('click', 'a', function (e) {
        var href = $(this).attr('href');
        if (href != undefined) {
            if (href.indexOf('/download') >= 0 && href.indexOf('isOld=1') <= -1) {//兼容通达旧数据需要ATTACHMENT_NAME
                if (e && e.preventDefault) {
                    e.preventDefault();
                } else {
                    window.event.returnValue = false; //兼容I
                }
                var url = $(this).attr('href');
                var file = url.split('ATTACHMENT_NAME=')[1]

                if (file.indexOf('&') >= 0) {
                    file = file.split('&')[1]
                    var attUrl = url.split('ATTACHMENT_NAME=')[0] + 'ATTACHMENT_NAME=&' + file;
                } else {
                    file = ''
                    var attUrl = url.split('ATTACHMENT_NAME=')[0] + 'ATTACHMENT_NAME=';
                }

                window.location.href = attUrl;
            }
        }
    })

    $.extend({
        setCookie: function (user) {
            var uid = user.uid || '';
            var userId = user.userId || '';
            var name = user.userName || ''; //用户名
            var userPriv = user.userPriv || '';
            var userPrivName = user.userPrivName || '';
            var deptId = user.deptId || '';
            var sex = user.sex || '';
            var language = user.language || '';
            var company = user.company || '';
            var color = user.bpNo || '0';
            var byname = user.byname || '0';
            $.cookie('company', company, {expires: 7});
            $.cookie('language', language, {expires: 7});
            $.cookie('uid', uid, {expires: 7});
            $.cookie('userId', userId, {expires: 7});
            $.cookie('userName', name, {expires: 7});
            $.cookie('userPriv', userPriv, {expires: 7});
            $.cookie('userPrivName', userPrivName, {expires: 7});
            $.cookie('deptId', deptId, {expires: 7});
            $.cookie('sex', sex, {expires: 7});
            $.cookie('color', color, {expires: 7});
            $.cookie('byname', byname, {expires: 7});
        }
    });
    $.extend({
        loadSidebar: function (target, deptId, fn) {
            $.ajax({
                url: '/department/getChDeptfq',
                type: 'get',
                data: {
                    deptId: deptId
                },
                dataType: 'json',
                success: function (data) {

                    if (deptId == 0) {
                        var str = '';
                        if ($(target).children('li').length == 0) {
                            data.obj.forEach(function (v, i) {
                                if (v.deptName) {
                                    str += '<li><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                        'onclick= "imgDown(' + v.deptId + ',this)"  ' +
                                        'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                        'deptid="' + v.deptId + '" class="childdept"><span class="">' +
                                        '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                        'style="vertical-align: middle;width: 15px;' +
                                        'margin-right: 10px;margin-left:15px;">' +
                                        '<a href="javascript:void(0)" ' +
                                        'class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a>' +
                                        '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                }
                            })
                            target.html(str);
                        } else {
                            $(target).children('li').each(function (v, l) {
                                for (var i = 0; i < data.obj.length; i++) {
                                    if ($($(target).children('li')[i]).children('span').attr('deptid') != data.obj[i].deptId) {
                                        if (v.deptName) {
                                            str = '<li><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                                'onclick= "imgDown(' + data.obj.deptId + ',this)"  ' +
                                                'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                                'deptid="' + data.obj.deptId + '" class="childdept">' +
                                                '<span class="">' +
                                                '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                                'style="vertical-align: middle;width: 15px;' +
                                                'margin-right: 10px;margin-left:15px;">' +
                                                '<a href="javascript:void(0)" ' +
                                                'class="dynatree-title" title="' + data.obj.deptName + '">' + data.obj.deptName + '</a>' +
                                                '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                        }
                                        $(target).append(str)
                                    }
                                }
                                return false
                            })
                        }
                        widthnum++;
                        if (fn != undefined) {
                            fn($(target).find('.dpetWhole0'))
                        }
                    } else {
                        var str = '';
                        if ($(target).children('li').length == 0) {
                            data.obj.forEach(function (v, i) {
                                var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                                if (v.deptName && v.isHaveCh == 1) {
                                    str += '<li><span  onclick= "imgDown(' + v.deptId + ',this)" ' +
                                        'data-numString="2" deptid="' + v.deptId + '" ' +
                                        'data-numtrue="' + (targetnum + 1) + '"  ' +
                                        'style="padding-left:' +
                                        (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                        'height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept">' +
                                        '<span></span><img id="img' + v.deptId + '" src="/img/sys/dapt_right.png" ' +
                                        'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                        '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                        'title="' + v.deptName + '">' + v.deptName + '</a></span>' +
                                        '<ul style="display:none;"></ul></li>';
                                } else {
                                    str += '<li>' +
                                        '<span onclick="imgDown(' + v.deptId + ',this)" ' +
                                        'data-numString="1" deptid="' + v.deptId + '" ' +
                                        'data-numtrue="' + (targetnum + 1) + '" ' +
                                        'style="padding-left:' + (20 + (20 *
                                            parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                        'height:35px;line-height:35px;"  deptid="' + v.deptId + '" ' +
                                        'class="childdept"><span></span><img  src="/img/sys/dapt_right.png" ' +
                                        'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                        'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                        'title="' + v.deptName + '">' + v.deptName + '</a></span><ul ' +
                                        'style="display:none;"></ul></li>';
                                }

                            });
                            target.html(str);
                        } else {
                            $(target).children('li').each(function (v, l) {

                                for (var i = 0; i < data.obj.length; i++) {


                                    if ($($(target).children('li')[i]).children('span').attr('deptid') != data.obj[i].deptId) {

                                        var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                                        if (data.obj[i].deptName && data.obj[i].isHaveCh == 1) {
                                            str = '<li><span  onclick= "imgDown(' + data.obj[i].deptId + ',this)" ' +
                                                'data-numString="2" deptid="' + data.obj[i].deptId + '" ' +
                                                'data-numtrue="' + (targetnum + 1) + '"  ' +
                                                'style="padding-left:' +
                                                (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                                'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" class="childdept">' +
                                                '<span></span><img id="img' + data.obj[i].deptId + '" src="/img/sys/dapt_right.png" ' +
                                                'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                                '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                                'title="' + data.obj[i].deptName + '">' + data.obj[i].deptName + '</a></span>' +
                                                '<ul style="display:none;"></ul></li>';
                                        } else {
                                            str = '<li>' +
                                                '<span onclick="imgDown(' + data.obj[i].deptId + ',this)" ' +
                                                'data-numString="1" deptid="' + data.obj[i].deptId + '" ' +
                                                'data-numtrue="' + (targetnum + 1) + '" ' +
                                                'style="padding-left:' + (20 + (20 *
                                                    parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                                'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" ' +
                                                'class="childdept"><span></span><img  src="/img/sys/dapt_right.png" ' +
                                                'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                                'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                                'title="' + data.obj[i].deptName + '">' + data.obj[i].deptName + '</a></span><ul ' +
                                                'style="display:none;"></ul></li>';
                                        }
                                        $(target).append(str)
                                    }
                                }
                                return false;
                            })
                        }
                        widthnum++
                        if (fn != undefined) {
                            fn();
                        }
                    }
                }
            })
        },
        loadSidebar2: function (target, deptId, fn) {
            $.ajax({
                url: '../user/queryExportUsers',
                type: 'get',
                data: {
                    deptId: deptId
                },
                dataType: 'json',
                success: function (data) {
                    //  console.log(data);
                    if (deptId == 0) {
                        var str = '';
                        if ($(target).children('li').length == 0) {
                            data.obj.forEach(function (v, i) {
                                if (v.deptName) {
                                    str += '<li><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                        'onclick= "imgDown(' + v.deptId + ',this)"  ' +
                                        'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                        'deptid="' + v.deptId + '" class="childdept"><span class="">' +
                                        '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                        'style="vertical-align: middle;width: 15px;' +
                                        'margin-right: 10px;margin-left:15px;">' +
                                        '<a href="javascript:void(0)" ' +
                                        'class="dynatree-title" title="' + v.deptName + '">' + v.deptName + '</a>' +
                                        '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                }
                            })
                            target.html(str);
                        } else {
                            $(target).children('li').each(function (v, l) {
                                for (var i = 0; i < data.obj.length; i++) {
                                    if ($($(target).children('li')[i]).children('span').attr('deptid') != data.obj[i].deptId) {
                                        if (v.deptName) {
                                            str = '<li><span data-types="1" data-numstring="1"   data-numtrue="1" ' +
                                                'onclick= "imgDown(' + data.obj.deptId + ',this)"  ' +
                                                'style="height:35px;line-height:35px;padding-left: 14px" ' +
                                                'deptid="' + data.obj.deptId + '" class="childdept">' +
                                                '<span class="">' +
                                                '</span><img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_company.png" alt="" ' +
                                                'style="vertical-align: middle;width: 15px;' +
                                                'margin-right: 10px;margin-left:15px;">' +
                                                '<a href="javascript:void(0)" ' +
                                                'class="dynatree-title" title="' + data.obj.deptName + '">' + data.obj.deptName + '</a>' +
                                                '</span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                        }
                                        $(target).append(str)
                                    }
                                }
                                return false
                            })
                        }
                        widthnum++;
                        if (fn != undefined) {
                            fn($(target).find('.dpetWhole0'))
                        }
                    } else {
                        var str = '';
                        if ($(target).children('li').length == 0) {
                            data.obj.forEach(function (v, i) {
                                var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                                if (v.deptName && v.isHaveCh == 1) {
                                    str += '<li><span  onclick= "imgDown(' + v.deptId + ',this)" ' +
                                        'data-numString="2" deptid="' + v.deptId + '" ' +
                                        'data-numtrue="' + (targetnum + 1) + '"  ' +
                                        'style="padding-left:' +
                                        (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                        'height:35px;line-height:35px;"  deptid="' + v.deptId + '" class="childdept">' +
                                        '<span></span><img id="img' + v.deptId + '" src="/img/sys/dapt_right.png" ' +
                                        'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                        '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                        'title="' + v.deptName + '">' + v.deptName + '</a></span>' +
                                        '<ul style="display:none;"></ul></li>';
                                } else {
                                    str += '<li>' +
                                        '<span onclick="imgDown(' + v.deptId + ',this)" ' +
                                        'data-numString="1" deptid="' + v.deptId + '" ' +
                                        'data-numtrue="' + (targetnum + 1) + '" ' +
                                        'style="padding-left:' + (20 + (20 *
                                            parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                        'height:35px;line-height:35px;"  deptid="' + v.deptId + '" ' +
                                        'class="childdept"><span></span><img  src="/img/sys/dapt_right.png" ' +
                                        'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                        'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                        'title="' + v.deptName + '">' + v.deptName + '</a></span><ul ' +
                                        'style="display:none;"></ul></li>';
                                }

                            });
                            target.html(str);
                        } else {
                            $(target).children('li').each(function (v, l) {

                                for (var i = 0; i < data.obj.length; i++) {


                                    if ($($(target).children('li')[i]).children('span').attr('deptid') != data.obj[i].deptId) {

                                        var targetnum = parseInt($(target).prev().attr('data-numtrue'))

                                        if (data.obj[i].deptName && data.obj[i].isHaveCh == 1) {
                                            str = '<li><span  onclick= "imgDown(' + data.obj[i].deptId + ',this)" ' +
                                                'data-numString="2" deptid="' + data.obj[i].deptId + '" ' +
                                                'data-numtrue="' + (targetnum + 1) + '"  ' +
                                                'style="padding-left:' +
                                                (20 + (20 * parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                                'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" class="childdept">' +
                                                '<span></span><img id="img' + data.obj[i].deptId + '" src="/img/sys/dapt_right.png" ' +
                                                'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" alt="">' +
                                                '&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                                'title="' + data.obj[i].deptName + '">' + data.obj[i].deptName + '</a></span>' +
                                                '<ul style="display:none;"></ul></li>';
                                        } else {
                                            str = '<li>' +
                                                '<span onclick="imgDown(' + data.obj[i].deptId + ',this)" ' +
                                                'data-numString="1" deptid="' + data.obj[i].deptId + '" ' +
                                                'data-numtrue="' + (targetnum + 1) + '" ' +
                                                'style="padding-left:' + (20 + (20 *
                                                    parseInt($(target).prev().attr('data-numtrue')))) + 'px;' +
                                                'height:35px;line-height:35px;"  deptid="' + data.obj[i].deptId + '" ' +
                                                'class="childdept"><span></span><img  src="/img/sys/dapt_right.png" ' +
                                                'style="width: 8px;height:14px;margin-top: -3px;margin-right:4px;" ' +
                                                'alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" ' +
                                                'title="' + data.obj[i].deptName + '">' + data.obj[i].deptName + '</a></span><ul ' +
                                                'style="display:none;"></ul></li>';
                                        }
                                        $(target).append(str)
                                    }
                                }
                                return false;
                            })
                        }
                        widthnum++
                        if (fn != undefined) {
                            fn();
                        }
                    }
                }
            })
        },
        loadrole: function (target, teptId, num, fn) {
            $.ajax({
                url: employeeUrl,
                type: 'get',
                data: {
                    deptId: teptId
                },
                dataType: 'json',
                success: function (data) {
                    if (!data.flag) {
                        return
                    }

                    var str = '';
                    var arr = [];
                    if ($(target).children('li').length == 0) {
                        for (var i = 0; i < data.object.length; i++) {
                            str += '<li><span  userId="' + data.object[i].userId + '" data-uid="' + data.object[i].uid + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><input type="checkbox" name="" value="" style="position: relative;bottom: 2px;right: 4px;"><span></span>' +
                                '<img  src="' + function () {
                                    var avatar = data.object[i].avatar;
                                    if (avatar == undefined || avatar == "") {
                                        avatar = data.object[i].sex;
                                    }
                                    if (avatar == 0) {
                                        return '/img/user/boy.png'
                                    } else if (avatar == 1) {
                                        return '/img/user/girl.png'
                                    } else {
                                        return '/img/user/' + data.object[i].avatar
                                    }
                                }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;border-radius: 50%;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';

                        }
                        $(target).html(str);
                    } else {
                        $(target).children('li').each(function (m, b) {
                            for (var i = 0; i < data.object.length; i++) {
                                if ($($(target).children('li')[i]).children('span').attr('data-uid') != data.object[i].uid) {
                                    str = '<li><span  userId="' + data.object[i].userId + '" data-uid="' + data.object[i].uid + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><input type="checkbox" name="" value="" style="position: relative;bottom: 2px;right: 4px;"><span></span>' +
                                        '<img  src="' + function () {
                                            var avatar = data.object[i].avatar;
                                            if (avatar == undefined || avatar == "") {
                                                avatar = data.object[i].sex;
                                            }
                                            if (avatar == 0) {
                                                return '/img/user/girl.png'
                                            } else if (avatar == 1) {
                                                return '/img/user/boy.png'
                                            } else {
                                                return '/img/user/' + data.object[i].avatar
                                            }
                                        }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;border-radius: 50%;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';
                                    $(target).append(str)
                                }
                            }
                            return false
                        })
                    }

                    if (fn != undefined) {
                        fn();
                    }

                }
            })
        },
        loadrole2: function (target, teptId, num, fn) {
            $.ajax({
                url: employeeUrlExt,
                type: 'get',
                data: {
                    deptId: teptId
                },
                dataType: 'json',
                success: function (data) {
                    if (!data.flag) {
                        return
                    }

                    var str = '';
                    var arr = [];
                    if ($(target).children('li').length == 0) {
                        for (var i = 0; i < data.object.length; i++) {
                            str += '<li><span  userId="' + data.object[i].userId + '" data-uid="' + data.object[i].uid + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><input type="checkbox" name="" value="" style="position: relative;bottom: 2px;right: 4px;"><span></span>' +
                                '<img  src="' + function () {
                                    var avatar = data.object[i].avatar;
                                    if (avatar == undefined || avatar == "") {
                                        avatar = data.object[i].sex;
                                    }
                                    if (avatar == 0) {
                                        return '/img/user/boy.png'
                                    } else if (avatar == 1) {
                                        return '/img/user/girl.png'
                                    } else {
                                        return '/img/user/' + data.object[i].avatar
                                    }
                                }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';

                        }
                        $(target).html(str);
                    } else {
                        $(target).children('li').each(function (m, b) {
                            for (var i = 0; i < data.object.length; i++) {
                                if ($($(target).children('li')[i]).children('span').attr('data-uid') != data.object[i].uid) {
                                    str = '<li><span userId="' + data.object[i].userId + '" data-uid="' + data.object[i].uid + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><input type="checkbox" name="" value="" style="position: relative;bottom: 2px;right: 4px;"><span></span>' +
                                        '<img  src="' + function () {
                                            var avatar = data.object[i].avatar;
                                            if (avatar == undefined || avatar == "") {
                                                avatar = data.object[i].sex;
                                            }
                                            if (avatar == 0) {
                                                return '/img/user/boy.png'
                                            } else if (avatar == 1) {
                                                return '/img/user/girl.png'
                                            } else {
                                                return '/img/user/' + data.object[i].avatar
                                            }
                                        }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';
                                    $(target).append(str)
                                }
                            }
                            return false
                        })
                    }

                    if (fn != undefined) {
                        fn();
                    }

                }
            })
        },
        loadrole3: function (target, teptId, num, fn) {
            $.ajax({
                url: employeeUrlExt_s,
                type: 'get',
                data: {
                    deptId: teptId
                },
                dataType: 'json',
                success: function (data) {
                    if (!data.flag) {
                        return
                    }
                    var str = '';
                    var arr = [];
                    if ($(target).children('li').length == 0) {
                        for (var i = 0; i < data.obj.length; i++) {
                            str += '<li><span  userId="' + data.object[i].userId + '" data-uid="' + data.obj[i].staffId + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><span></span>' +
                                '<img  src="' + function () {
                                    // var avatar = data.obj[i].avatar;
                                    // if (avatar == undefined || avatar == "") {
                                    //     avatar = data.obj[i].staffSex;
                                    // }
                                    if (data.obj[i].staffSex == '0') {
                                        return '/img/user/boy.png'
                                    } else {
                                        return '/img/user/girl.png'
                                    }
                                }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.obj[i].staffName + '">' + data.obj[i].staffName + '</a></span></li>';

                        }
                        $(target).html(str);
                    } else {
                        $(target).children('li').each(function (m, b) {
                            for (var i = 0; i < data.obj.length; i++) {
                                if ($($(target).children('li')[i]).children('span').attr('data-uid') != data.obj[i].uid) {
                                    str = '<li><span   userId="' + data.object[i].userId + '" data-uid="' + data.obj[i].staffId + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><span></span>' +
                                        '<img  src="' + function () {
                                            // var avatar = data.obj[i].avatar;
                                            // if (avatar == undefined || avatar == "") {
                                            //     avatar = data.obj[i].sex;
                                            // }
                                            // if (avatar == 0) {
                                            //     return '/img/email/icon_head_man_06.png'
                                            // } else if (avatar == 1) {
                                            //     return '/img/email/icon_head_woman_06.png'
                                            // } else {
                                            //     return '/img/user/' + data.obj[i].avatar
                                            // }
                                            if (data.obj[i].staffSex == '0') {
                                                return '/img/user/boy.png'
                                            } else {
                                                return '/img/user/girl.png'
                                            }
                                        }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.obj[i].staffName + '">' + data.obj[i].staffName + '</a></span></li>';
                                    $(target).append(str)
                                }
                            }
                            return false
                        })
                    }

                    if (fn != undefined) {
                        fn();
                    }

                }
            })
        },
        loadroleUser: function (target, teptId, num, fn) {
            $.ajax({
                url: employeeUrlExt,
                type: 'get',
                data: {
                    deptId: teptId
                },
                dataType: 'json',
                success: function (data) {
                    if (!data.flag) {
                        return
                    }

                    var str = '';
                    var arr = [];
                    if ($(target).children('li').length == 0) {
                        for (var i = 0; i < data.object.length; i++) {
                            str += '<li><span  userId="' + data.object[i].userId + '" data-uid="' + data.object[i].uid + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><input type="checkbox" name="" value="" style="position: relative;bottom: 2px;right: 4px;"><span></span>' +
                                '<img  src="' + function () {
                                    var avatar = data.object[i].avatar;
                                    if (avatar == undefined || avatar == "") {
                                        avatar = data.object[i].sex;
                                    }
                                    if (avatar == 0) {
                                        return '/img/user/boy.png'
                                    } else if (avatar == 1) {
                                        return '/img/user/girl.png'
                                    } else {
                                        return '/img/user/' + data.object[i].avatar
                                    }
                                }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;border-radius: 50%" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';

                        }
                        $(target).html(str);
                    } else {
                        $(target).children('li').each(function (m, b) {
                            for (var i = 0; i < data.object.length; i++) {
                                if ($($(target).children('li')[i]).children('span').attr('data-uid') != data.object[i].uid) {
                                    str = '<li><span userId="' + data.object[i].userId + '" data-uid="' + data.object[i].uid + '" data-numString="1"  style="padding-left:' + (20 + 20 * parseInt(num)) + 'px;height:35px;line-height:35px;"  class="childdept role"><input type="checkbox" name="" value="" style="position: relative;bottom: 2px;right: 4px;"><span></span>' +
                                        '<img  src="' + function () {
                                            var avatar = data.object[i].avatar;
                                            if (avatar == undefined || avatar == "") {
                                                avatar = data.object[i].sex;
                                            }
                                            if (avatar == 0) {
                                                return '/img/user/boy.png'
                                            } else if (avatar == 1) {
                                                return '/img/user/girl.png'
                                            } else {
                                                return '/img/user/' + data.object[i].avatar
                                            }
                                        }() + '" style="width: 20px;height:20px;margin-top: -3px;margin-right:4px;border-radius: 50%" alt="">&nbsp;<a href="javascript:void(0)" class="dynatree-title" title="' + data.object[i].userName + '">' + data.object[i].userName + '</a></span></li>';
                                    $(target).append(str)
                                }
                            }
                            return false
                        })
                    }

                    if (fn != undefined) {
                        fn();
                    }

                }
            })
        }
    })

    $.fn.privSelect = function (args) {
        var _this = $(this);
        $.ajax({
            url: domain + "/userPriv/getAllPriv",
            type: 'get',
            data: {},
            dataType: 'json',
            success: function (res) {
                if (res.flag) {
                    var optionStr = '<option value="0">' + role + '</option>';
                    res.obj.forEach(function (v, i) {
                        optionStr += '<option value="' + v.userPriv + '">' + v.privName + '</option>';
                    });
                }
                _this.html(optionStr);
            },
            error: function () {

            }
        });
    };
    $.extend({
        getQueryString: function (name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        }
    });
    $.extend({
        upload: function (e, cb) {
            if (!$('#uploadiframe').is('iframe')) {
                $("body").append('<iframe id="uploadiframe" style="display:none;"  class="uploadiframe" name="uploadiframe" ></iframe>');
            }
            e.attr('target', 'uploadiframe')
            e.submit();
            var l = $('#uploadiframe'), a = null;
            var f = setInterval(function () {
                try {
                    a = l.contents().find("body").text();

                } catch (i) {
                    //  console.log("上传接口存在跨域", i);
                    clearInterval(f);
                }
                if (a) {
                    clearInterval(f);
                    l.contents().find("body").html("");
                    var c = {};
                    try {
                        c = JSON.parse(a);
                        a = {};
                        $('#uploadiframe').remove()
                    } catch (i) {
                        a = {};
                        alert("你的上传大小超出上限", i)
                    }
                    cb(c);
                }
            }, 300);
        }
    });
    $.extend({
        uploadnew: function (e, num, cb) {
            if (!$('#uploadiframe').is('iframe')) {
                $("body").append('<iframe id="uploadiframe" style="display:none;"  class="uploadiframe" name="uploadiframe" ></iframe>');
            }
            e.attr('target', 'uploadiframe');
            var gs = e.find('.formfile' + num + ' input[type=file]').val().split('.')[1];
            if (gs == 'jsp' || gs == 'css' || gs == 'js' || gs == 'html' || gs == 'java' || gs == 'php') {
                layer.alert('jsp、css、js、html、java文件禁止上传!', {}, function () {
                    layer.closeAll();
                });
            } else {
                e.submit();
            }
            var l = $('#uploadiframe'), a = null;
            var f = setInterval(function () {
                try {
                    a = l.contents().find("body").text();

                } catch (i) {
                    //le.log("上传接口存在跨域", i);
                    clearInterval(f);
                }
                if (a) {
                    clearInterval(f);
                    l.contents().find("body").html("");
                    var c = {};
                    try {
                        c = JSON.parse(a);
                        a = {};
                        $('#uploadiframe').remove()
                    } catch (i) {
                        a = {};
                        alert("你的上传大小超出上限", i)
                    }
                    cb(c);
                }
            }, 300);
        }
    });
})

//部门遍历方法
function digui(datas, departId) {
    var data = new Array();
    for (var i = 0; i < datas.length; i++) {
        if (datas[i].deptParent == departId) {
            datas[i]["childs"] = digui(datas, datas[i].deptId);
            data.push(datas[i]);
        }
    }
    return data;
}

//部门遍历方法
function departmentChild(datas, opt_li, level, dept) {
    for (var i = 0; i < datas.length; i++) {
        var String = "";
        var space = "";
        for (var j = 0; j < level; j++) {
            space += "├&nbsp;";
        }
        if (i == 0) {
            String = space + "┌";
        } else if (i != 0) {
            String = space + "├";
        } else if (i == datas.length - 1) {
            String = space + "└";
        }
        if (dept == datas[i].deptId) {
            opt_li += '<option value="' + datas[i].deptId + '" deptName="' + datas[i].deptName + '" selected="selected">' + String + datas[i].deptName + '</option>';
        } else {
            opt_li += '<option value="' + datas[i].deptId + '" deptName="' + datas[i].deptName + '" >' + String + datas[i].deptName + '</option>';
        }
        /* 	console.log(datas[i].childs);*/
        if (datas[i].childs != null) {
            opt_li = departmentChild(datas[i].childs, opt_li, level + 1, dept);
        }
    }
    return opt_li;
}

//生成生肖、星座
var Calculator = function () {
    /* *
    *  计算生肖
    *      支持简写生日，比如01，转换为2001，89转换为1989；
    *      支持任何可以进行时间转换的格式，比如'1989/01/01','1989 01'等
    * */
    function getShengXiao(birth) {
        birth += '';
        var len = birth.length;
        if (len < 4 && len != 2) {
            return false;
        }
        if (len == 2) {
            birth - 0 > 30 ? birth = '19' + birth : birth = '20' + birth;
        }
        var year = (new Date(birth)).getFullYear();
        var arr = ['猴', '鸡', '狗', '猪', '鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊'];
        return /^\d{4}$/.test(year) ? arr[year % 12] : false;
    }

    /* *
*  计算星座
*      支持传递[月日]，[月,日]，[年月日]等格式，详见例子
* */
    function getxingzuo(month, day) {
        var d = new Date(1999, month - 1, day, 0, 0, 0);
        var arr = [];
        arr.push(["魔羯座", new Date(1999, 0, 1, 0, 0, 0)])
        arr.push(["水瓶座", new Date(1999, 0, 20, 0, 0, 0)])
        arr.push(["双鱼座", new Date(1999, 1, 19, 0, 0, 0)])
        arr.push(["牡羊座", new Date(1999, 2, 21, 0, 0, 0)])
        arr.push(["金牛座", new Date(1999, 3, 21, 0, 0, 0)])
        arr.push(["双子座", new Date(1999, 4, 21, 0, 0, 0)])
        arr.push(["巨蟹座", new Date(1999, 5, 22, 0, 0, 0)])
        arr.push(["狮子座", new Date(1999, 6, 23, 0, 0, 0)])
        arr.push(["处女座", new Date(1999, 7, 23, 0, 0, 0)])
        arr.push(["天秤座", new Date(1999, 8, 23, 0, 0, 0)])
        arr.push(["天蝎座", new Date(1999, 9, 23, 0, 0, 0)])
        arr.push(["射手座", new Date(1999, 10, 22, 0, 0, 0)])
        arr.push(["魔羯座", new Date(1999, 11, 22, 0, 0, 0)])
        for (var i = arr.length - 1; i >= 0; i--) {
            if (d >= arr[i][1]) return arr[i][0];
        }
    }

    return {
        shengxiao: getShengXiao,
        xingzuo: getxingzuo
    }
}()

//所属分类
$.fn.typeSelect = function (args) {
    var _this = $(this);
    $.ajax({
        url: "/supervisionType/getSupNameSelect",
        type: 'get',
        data: {},
        dataType: 'json',
        success: function (obj) {
            var data = obj.obj;
            typementData = typeDigui(data, 0);
            var str = typetmentChild(typementData, '<option value="-1">' + select_the_category + '</option>', 0, -1);
            _this.html(str);

            if (args != undefined) {
                args(_this)
            }
        },
        error: function () {

        }
    });
};

//类别遍历方法
function typeDigui(datas, sid) {
    var data = new Array();
    for (var i = 0; i < datas.length; i++) {
        if (datas[i].parentId == sid) {
            datas[i]["childs"] = typeDigui(datas, datas[i].sid);
            data.push(datas[i]);
        }
    }
    return data;
}

function typetmentChild(datas, opt_li, level, sid) {

    for (var i = 0; i < datas.length; i++) {
        var String = "";
        var space = ""
        for (var j = 0; j < level; j++) {
            space += "├&nbsp;";
        }
        if (i == 0) {
            String = space + "┌";
        } else if (i != 0) {
            String = space + "├";
        } else if (i == datas.length - 1) {
            String = space + "└";
        }
        if (sid == datas[i].sid) {
            opt_li += '<option value="' + datas[i].sid + '" selected="selected">' + String + datas[i].typeName + '</option>';
        } else {
            opt_li += '<option value="' + datas[i].sid + '">' + String + datas[i].typeName + '</option>';
        }
        /* 	console.log(datas[i].childs);*/
        if (datas[i].childs != null) {
            opt_li = typetmentChild(datas[i].childs, opt_li, level + 1, sid);
        }
    }
    return opt_li;
}

$.fn.deptquerySelect = function (args, timers) {
    var _this = $(this);
    if (timers != null) {
        clearInterval(timers);
        timers = null;
    }
    $.ajax({
        url: loadALLDeptSidebarurl,
        type: 'get',
        data: {},
        dataType: 'json',
        success: function (obj) {

            var data = obj.obj;
            departmentData = digui(data, 2);
            var str = departmentChild(departmentData, '<option value="-1">' + ds + '</option>', 0, -1);
            _this.html(str);
            if (_this.attr('pval') && (_this.attr('pval').indexOf('_') > -1)) {
                var pval = _this.attr('pval').split('_');
                _this.val(pval[0]);
            }

            if (args != undefined) {
                args(_this)
            }
        },
        error: function () {

        }
    });
};
$.fn.deptquerySelect2 = function (args, timers) {
    var _this = $(this);
    if (timers != null) {
        clearInterval(timers);
        timers = null;
    }
    $.ajax({
        url: loadALLDeptSidebarurl,
        type: 'get',
        data: {},
        dataType: 'json',
        success: function (obj) {

            var data = obj.obj;
            departmentData = digui(data, 0);
            var str = departmentChild(departmentData, '<option value="-1">' + ds + '</option>', 0, -1);

            if (str == '<option value="-1">请选择</option>' && data.length >= 0) {
                departmentData = digui(data, data[0].deptParent);
                var str = departmentChild(departmentData, '<option value="-1">' + ds + '</option>', 0, -1);
            }
            _this.html(str);
            if (_this.attr('pval') && (_this.attr('pval').indexOf('_') > -1)) {
                var pval = _this.attr('pval').split('_');
                _this.val(pval[0]);
            }

            if (args != undefined) {
                args(_this)
            }
        },
        error: function () {

        }
    });
};

function consult(e) { //附件查阅点击调取
    var atturl = e.attr('attrurl');
    pdurl(UrlGetRequest('?' + atturl), atturl);
}

//转存方法
function transfer(e) {
    var atturl = e.attr('attrurl');

    $.popWindow("/email/transfer?" + atturl, PreviewPage, '0', '0', '1200px', '600px');
}

function pdurl(gs, atturl) { //根据后缀判断选择调取那种打开方式
    if (atturl != undefined && atturl.indexOf('&ATTACHMENT_NAME=') > -1) {
        var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
        var atturl2 = '';
        if (atturl.split('&ATTACHMENT_NAME=')[1] != undefined && atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1) {
            for (var i = 1; i < atturl.split('&ATTACHMENT_NAME=')[1].split('&').length; i++) {
                atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
            }
            atturl = atturl1 + atturl2;
        } else {
            atturl = atturl1;
        }
    }
    if (gs == 'png' || gs == 'jpg' || gs == 'bmp' || gs == 'emf' || gs == 'gif' || gs == 'pcx' || gs == 'pcd' || gs == 'ai' || gs == 'webp' || gs == 'WMF' || gs == 'dxf' || gs == 'PNG' || gs == 'JPG' || gs == 'BMP' || gs == 'EMF' || gs == 'GIF' || gs == 'PCX' || gs == 'PCD' || gs == 'AI' || gs == 'WEBP' || gs == 'wmf' || gs == 'DXF' || gs == 'txt' || gs == 'TXT') {
        $.popWindow("/xs?" + atturl, PreviewPage, '0', '0', '1200px', '600px');
    } else if (gs == 'mp4' || gs == 'rmvb' || gs == 'avi' || gs == 'ifo' || gs == 'wmv' || gs == 'MP4' || gs == 'RMVB' || gs == 'AVI' || gs == 'IFO' || gs == 'WMV') {
        layer.open({
            type: 2,
            title: false,
            area: ['630px', '360px'],
            shade: 0.8,
            closeBtn: 0,
            shadeClose: true,
            content: "/common/video?videoatturlsplit=" + atturl
        });
        layer.msg('点击任意处关闭');
    } else if (gs == 'pdf' || gs == 'PDF') {
        $.popWindow("/pdfPreview?" + atturl, PreviewPage, '0', '0', '1200px', '600px');
    } else if (gs == 'ofd' || gs == 'OFD') {
        $.popWindow("../../lib/ofdViewer/viewer.html?file=" + '/download?' + atturl, PreviewPage, '0', '0', '1200px', '600px')
    } else {
        var url = "/common/webOfficeView?documentEditPriv=0&fomat=" + gs + "&" + atturl;
        $.ajax({
            url: '/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
            type: 'post',
            datatype: 'json',
            async: false,
            success: function (res) {
                if (res.flag) {
                    if (res.object[0].paraValue == 0) {
                        //默认加载NTKO插件 进行跳转
                        url = "/common/ntkoview?documentEditPriv=0&fomat=" + gs + "&" + atturl + '&ie_open=yes&IE=1';
                    } else if (res.object[0].paraValue == 2) {
                        //默认加载NTKO插件 进行跳转
                        url = "/wps/info?" + atturl + "&permission=read";
                    } else if (res.object[0].paraValue == 3) {
                        //默认加载NTKO插件 进行跳转
                        url = "/common/onlyoffice?" + atturl + "&edit=false";
                    }
                }

            }
        })
        $.popWindow(url, PreviewPage, '0', '0', '1200px', '600px');
    }
}

function preview(that, workNum) { //附件预览点击调取
    if (workNum == 1) {
        var attrUrl = that.attr('atturl').split('&FILESIZE')[0];
    } else {
        var attrUrl = that.attr('attrurl');
    }

    var url = attrUrl;
    if (attrUrl != undefined && attrUrl.indexOf('&ATTACHMENT_NAME=') > -1 && attrUrl.indexOf('isOld=1') == -1) {
        var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
        var atturl2 = '';
        if (attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined && attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1) {
            for (var i = 1; i < attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length; i++) {
                atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
            }
            url = atturl1 + atturl2;
        } else {
            url = atturl1;
        }
    }
    var type = UrlGetRequest('?' + attrUrl) || 'docx';
    if (type.indexOf('&') > -1) {
        type = type.split('&')[0];
    }
    type = type.toLowerCase();
    if (type == 'pdf') {
        //$.popWindow('/common/pdfPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
        $.popWindow("/pdfPreview?" + url, PreviewPage, '0', '0', '1200px', '600px');
    } else if (type == 'png' || type == 'jpg' || type == 'txt') {
        $.popWindow("/xs?" + url, PreviewPage, '0', '0', '1200px', '600px');
    } else if (type == 'ofd' || type == 'OFD') {
        $.popWindow("../../lib/ofdViewer/viewer.html?file=" + '/download?' + url, PreviewPage, '0', '0', '1200px', '600px')
    } else if (type == 'doc' || type == 'docx' || type == 'xls' || type == 'xlsx' || type == 'ppt' || type == 'pptx') {
        $.ajax({
            type: 'get',
            url: '/syspara/selectTheSysPara?paraName=DOCUMENT_PREVIEW_OPEN',
            dataType: 'json',
            success: function (res) {
                if (res.flag) {
                    documentPreviewOpen = res.object[0].paraValue;
                    if (documentPreviewOpen == 1) {
                        $.ajax({
                            type: 'get',
                            url: '/sysTasks/getOfficePreviewSetting',
                            dataType: 'json',
                            success: function (res) {
                                if (res.flag) {
                                    var strOfficeApps = res.object.previewUrl;//在线预览服务地址

                                    $.ajax({
                                        url: '/onlyOfficeCode',
                                        dataType: 'json',
                                        type: 'post',
                                        success: function (res) {
                                            if (res.flag) {
                                                var code = res.obj;
                                                $.popWindow(strOfficeApps + '/op/view.aspx?src=' + domains + '/onlyOfficeDownload' + encodeURIComponent('?' + url + '&code=' + code), '', '0', '0', '1200px', '600px');
                                            }
                                        }
                                    })
                                }
                            }
                        })
                    } else if (documentPreviewOpen == 2) {
                        if (type == 'xls' || type == 'xlsx') {
                            $.popWindow('/common/excelPreview?' + url.split('&COMPANY=')[0], '', '0', '0', '1200px', '600px');
                        } else if (type == 'ppt' || type == 'pptx') {
                            $.popWindow('/common/pptPreview?' + url.split('&COMPANY=')[0], '', '0', '0', '1200px', '600px');
                        } else {
                            $.popWindow('/common/officereader?' + url.split('&COMPANY=')[0], '', '0', '0', '1200px', '600px');
                        }
                    } else if (documentPreviewOpen == 3) {
                        $.popWindow("/wps/info?" + url + "&permission=read", '', '0', '0', '1200px', '600px');
                    } else if (documentPreviewOpen == 4) {
                        $.popWindow("/common/onlyoffice?" + url + "&edit=false", '', '0', '0', '1200px', '600px');
                    }
                }
            }
        })
    } else {
        $.ajax({
            type: 'get',
            url: '/sysTasks/getOfficePreviewSetting',
            dataType: 'json',
            success: function (res) {
                if (res.flag) {
                    var strOfficeApps = res.object.previewUrl;//在线预览服务地址
                    if (strOfficeApps == '') {
                        strOfficeApps = 'https://owa-box.vips100.com';
                    }

                    $.ajax({
                        url: '/onlyOfficeCode',
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            if (res.flag) {
                                var code = res.obj;
                                $.popWindow(strOfficeApps + '/op/view.aspx?src=' + domains + '/onlyOfficeDownload' + encodeURIComponent('?' + url + '&code=' + code), '', '0', '0', '1200px', '600px');
                            }
                        }
                    })


                }
            }
        })
    }
}

function UrlGetRequest(name) {//截取附件文件后缀
    var attach = name
    return attach.substring(attach.lastIndexOf(".") + 1, attach.length);
}

function editAttachment(that, print) { //编辑附件
    var atturl = that.attr('attrurl');
    var gs = UrlGetRequest('?' + atturl) || '';

    if (atturl != undefined && atturl.indexOf('&ATTACHMENT_NAME=') > -1 && atturl.indexOf('isOld=1') == -1) {
        var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
        var atturl2 = '';
        if (atturl.split('&ATTACHMENT_NAME=')[1] != undefined && atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1) {
            for (var i = 1; i < atturl.split('&ATTACHMENT_NAME=')[1].split('&').length; i++) {
                atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
            }
            atturl = atturl1 + atturl2;
        } else {
            atturl = atturl1;
        }
    }
    var url = "/common/webOffice?documentEditPriv=1&fomat=" + gs + "&ntType=1&officeType=1&print=" + print + "&" + atturl;
    $.ajax({
        url: '/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
        type: 'post',
        datatype: 'json',
        async: false,
        success: function (res) {
            if (res.flag) {
                if (res.object[0].paraValue == 0) {
                    //默认加载NTKO插件 进行跳转
                    url = "/common/ntko?documentEditPriv=1&fomat=" + gs + "&ntType=1&officeType=1&print=" + print + "&" + atturl;
                } else if (res.object[0].paraValue == 2) {
                    //默认加载NTKO插件 进行跳转
                    url = "/wps/info?" + atturl + "&permission=write";
                } else if (res.object[0].paraValue == 3) {

                    //默认加载NTKO插件 进行跳转
                    url = "/common/onlyoffice?" + atturl + "&edit=true";
                }
            }

        }
    })
    $.popWindow(url, '<fmt:message code="main.th.PreviewPage" />', '0', '0', '1200px', '600px');
}

function deleteAttachment(that) { //附件删除
    var attrUrl = that.attr('attrurl');
    var parentElement = that.parents('.font_');
    deleteChatment(attrUrl, $(parentElement));
}

function deleteChatment(data, element) {
    layer.confirm('确定删除该附件吗？', {
        btn: ['确定', '取消'], //按钮
        title: "附件删除"
    }, function () {
        //确定删除，调接口
        $.ajax({
            type: 'get',
            url: '../delete',
            dataType: 'json',
            data: data,
            success: function (res) {
                if (res.flag == true) {
                    layer.msg('删除成功！', {icon: 6});
                    element.remove();
                } else {
                    layer.msg('删除失败', {icon: 5});
                }
            }
        });

    }, function () {
        layer.closeAll();
    });
}

huoquyuming();

function huoquyuming() {  //获取外部服务器地址
    domains = location.origin;
}

/*************判断当前文件格式*************************/
function getFileIsOffice(file) {
    file = file.toLowerCase();
    if (file == 'doc' || file == 'docx' || file == 'xls' || file == 'xlsx'
        || file == 'ppt' || file == 'pptx') {
        return true;
    } else {
        return false;
    }
}

function getFileIsPDForTXT(file) {
    file = file.toLowerCase();
    if (file == 'pdf' || file == 'txt') {
        return true;
    } else {
        return false;
    }
}

function getFileIsPic(file) {
    file = file.toLowerCase();
    if (file == 'jpg' || file == 'jpeg' || file == 'png' || file == 'bmp') {
        return true;
    } else {
        return false;
    }
}

function getFileIsOfd(file) {
    file = file.toLowerCase();
    if (file == 'ofd') {
        return true;
    } else {
        return false;
    }
}

/*************END*******************/