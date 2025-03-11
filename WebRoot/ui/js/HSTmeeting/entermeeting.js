window.its || (window.its = {}),
its.x || (its.x = {}),
its.x.util || (its.x.util = {}),
its.x.util.array || (its.x.util.array = {}),
    its.x.uniqueGuid = 1,
    its.x.attachGuid = function(t) {
        t.__guid || (t.__guid = its.x.uniqueGuid++)
    },
    its.x.browserName = function() {
        return its.x.isOpera() ? "opera": its.x.isKhtml() ? "khtml": its.x.isSafari() ? "safari": its.x.isChrome() ? "chrome": its.x.isWebKit() ? "webkit": its.x.isIE7() ? "ie7": its.x.isIE8() ? "ie8": its.x.isIE() ? "ie": its.x.isFirefox() ? "firefox": "unknown"
    },
    its.x.initBrowserDetect = function() {
        if (typeof its.x.initBrowserDetect.browser == "undefined" || !its.x.initBrowserDetect.browser) {
            var t = navigator,
                n = t.userAgent,
                r = t.appVersion,
                i = parseFloat(r),
                s = {};
            s.isOpera = n.indexOf("Opera") >= 0 ? i: undefined,
                s.isKhtml = r.indexOf("Konqueror") >= 0 ? i: undefined,
                s.isWebKit = parseFloat(n.split("WebKit/")[1]) || undefined,
                s.isChrome = parseFloat(n.split("Chrome/")[1]) || undefined,
                s.isFirefox = /Firefox[\/\s](\d+\.\d+)/.test(n);
            var o = Math.max(r.indexOf("WebKit"), r.indexOf("Safari"), 0);
            if (o && !s.isChrome) {
                s.isSafari = parseFloat(r.split("Version/")[1]);
                if (!s.isSafari || parseFloat(r.substr(o + 7)) <= 419.3) s.isSafari = 2
            }
            if (document.all && !s.isOpera) {
                s.isIE = parseFloat(r.split("MSIE ")[1]) || undefined;
                var u = new RegExp("MSIE ([0-9]{1,}[.0-9]{0,})"),
                    a = -1;
                u.exec(n) != null && (a = parseFloat(RegExp.$1)),
                    s.isIE7 = a >= 7 && a < 8,
                    s.isIE8 = a >= 8 && a < 9
            }
            its.x.initBrowserDetect.browser = s
        }
        return its.x.initBrowserDetect.browser
    },
    its.x.isIE = function() {
        return its.x.initBrowserDetect().isIE
    },
    its.x.isIE7 = function() {
        return its.x.initBrowserDetect().isIE7
    },
    its.x.isIE8 = function() {
        return its.x.initBrowserDetect().isIE8
    },
    its.x.isOpera = function() {
        return its.x.initBrowserDetect().isOpera
    },
    its.x.isKhtml = function() {
        return its.x.initBrowserDetect().isKhtml
    },
    its.x.isWebKit = function() {
        return its.x.initBrowserDetect().isWebKit
    },
    its.x.isChrome = function() {
        return its.x.initBrowserDetect().isChrome
    },
    its.x.isSafari = function() {
        return its.x.initBrowserDetect().isSafari
    },
    its.x.isFirefox = function() {
        return its.x.initBrowserDetect().isFirefox
    },
window.its || (window.its = {}),
its.detect || (its.detect = {}),
    its.detect.FMLAUNCHER_INSTALLED_COOKIE_NAME = "FMLauncherPresent";

var userAgent = navigator.userAgent;
var isAndroid = userAgent.indexOf('Android') > -1 || userAgent.indexOf('Adr') > -1;
var isiOS = !!userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);

var port = "1089";

//PC客户端登录协议
function getURLForPC(roomId, roomPwd, userName, userPwd, nickName){
    var userType = getUserType();

    var room_para = "-link TCP:" + address + ":" + port + " -node 1";

    if(userType == 1){
        room_para += " " + "-uname" + " \"" + userName + "\"";
        room_para += " " + "-upwd"+" " + userPwd;
    }else{
        room_para += " " + "-uname" + " \"" + nickName + "\"";
        room_para += " " + "-rid" + " " + roomId;
        if(roomPwd != null && roomPwd != 'null' && roomPwd != ''){
            room_para += " " + "-rpwd" + " " + roomPwd;
        }
    }
    room_para += " -utype" + " " + userType;
    var url = "{" + clientForPCDownloadAddr + "}{Fastonz}{FMDesktop}{" + room_para + "}";
    console.log(url);
    url = encodeURIComponent(url);
    return "Launcher.FSM://" + encode64(url);
}

//Android客户端登录协议
function getURLForAndroid(roomId, roomPwd, userName, userPwd, nickName) {
    var NodeManAddr = "TCP:" + address + ":" + port;
    var userType = getUserType();
    if (userType == 0) {
        userName = nickName;
    }
    var room_para = "";
    room_para = "link="+ encodeURIComponent(NodeManAddr) + "/uname=" + encodeURIComponent(userName) + "/utype=" + encodeURIComponent(userType);
    if( roomId != null && roomId != 'null'&& roomId != '') {
        room_para += "/rid=" + encodeURIComponent(roomId);
    }
    if( userPwd != null && userPwd != 'null' && userPwd != '') {
        room_para += "/upwd=" + encodeURIComponent(userPwd);
    }
    if( roomPwd != null && roomPwd != 'null' && roomPwd != '') {
        room_para += "/rpwd=" + encodeURIComponent(roomPwd);//alert(room_para);
    }
    return "launcher.fsm://" + room_para;
}

//IOS客户端登录协议
function getURLForIphone(roomId, roomPwd, userName, userPwd, nickName) {
    var userType = getUserType();

    //iphone提供的userType 2为匿名登陆，1为凭用户名密码登陆
    if(userType == "0") {
        userType="2";
    }

    var room_para = "";
    room_para = "auto(1)openByLink(1)svrAddress("+ address + ")svrPort(" + port + ")userType(" + userType +")";
    if( userType == "1") {
        room_para += "userName(" + encodeURIComponent(userName) + ")";
    } else {
        room_para += "nickName(" + encodeURIComponent(nickName) + ")";
    }
    if( roomId != null && roomId != 'null'&& roomId != '' && userType == "2") {
        room_para += "roomID(" + roomId + ")";
    }
    if( userPwd != null && userPwd != 'null' && userPwd != '') {
        room_para += "userPwd(" + userPwd + ")";
    }
    if( roomPwd != null && roomPwd != 'null' && roomPwd != '') {
        room_para += "roomPwd(" + roomPwd + ")";
    }
    return "FSMeetingClient://" + escape(room_para);
}