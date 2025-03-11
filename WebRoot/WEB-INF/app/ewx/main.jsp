<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title></title>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <style>
        .nav{
            font-size: 0.28rem;
            color: #666;
            margin: 0 0.2rem;
            line-height: 0.8rem;
            padding-left: 0.18rem;
            position: relative;
        }
        .chunk{
            width: 4px;
            height: 13px;
            background:#7caeff;
            display: inline-block;
            position: relative;
            top: 2px;
            right: 9px;
        }
        .usernav {
            font-size: 0.24rem;
            display: flex;
            /*align-items: center;*/
            background-color: #fff;
            text-align: center;
            flex-wrap: wrap;
        }
        .usernav img{
            width: 0.9rem;
            height: 0.9rem;
            margin:0 auto;
        }
        .usernav div{
            padding-top: 0.15rem;
            color: #666;
        }
        input{
            width: 88%;
            border:1px solid #ccc;
            padding-left: .05rem;
            height: .5rem;
            margin: .1rem 0;
            border-radius: 3px;

        }
        .usernav a{
            width: 25%;
            position: relative;
            margin: .2rem 0;
        }

        .nav:after {
            position: absolute;
            top: 40px;
            right: 0;
            left: 0;
            height: 1px;
            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);
            background-color: #c8c7cc;
        }

        .spinner {
            margin: 100px auto;
            width: 50px;
            height: 60px;
            text-align: center;
            font-size: 10px;
        }

        .spinner > div {
            background-color: #67CF22;
            height: 100%;
            width: 6px;
            display: inline-block;

            -webkit-animation: stretchdelay 1.2s infinite ease-in-out;
            animation: stretchdelay 1.2s infinite ease-in-out;
        }

        .spinner .rect2 {
            -webkit-animation-delay: -1.1s;
            animation-delay: -1.1s;
        }

        .spinner .rect3 {
            -webkit-animation-delay: -1.0s;
            animation-delay: -1.0s;
        }

        .spinner .rect4 {
            -webkit-animation-delay: -0.9s;
            animation-delay: -0.9s;
        }

        .spinner .rect5 {
            -webkit-animation-delay: -0.8s;
            animation-delay: -0.8s;
        }

        @-webkit-keyframes stretchdelay {
            0%, 40%, 100% { -webkit-transform: scaleY(0.4) }
            20% { -webkit-transform: scaleY(1.0) }
        }

        @keyframes stretchdelay {
            0%, 40%, 100% {
                transform: scaleY(0.4);
                -webkit-transform: scaleY(0.4);
            }  20% {
                   transform: scaleY(1.0);
                   -webkit-transform: scaleY(1.0);
               }
        }

    </style>
    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750  * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>
</head>
<body>
<div class="mui-content" style="background: #ffffff;">

    <div class="spinner">
        <div class="rect1"></div>
        <div class="rect2"></div>
        <div class="rect3"></div>
        <div class="rect4"></div>
        <div class="rect5"></div>
    </div>

</div>
</body>
<script src="../../js/ewx/jweixin-1.2.0.js"></script>
<script src="/js/base/vconsole.min.js"></script>
<script>
    // var vConsole = new VConsole();
    var signUrl = "https://work.weixin.qq.com/api/jsapidemo";
    var accessiontoken = '';
    var ticket = "";
    var code = GetRequest()['code']
    var openType = GetRequest()['openType']==undefined?"":GetRequest()['openType'];
    var menuUrl = GetRequest()['menuUrl']==undefined?"":GetRequest()['menuUrl'];
    var params = GetRequest()['params']==undefined?"":GetRequest()['params'];
    if (params !== "") {
        // ~转义为=
        params = params.replaceAll("~", "=");
    }
    var config ;
    //alert(location.href);
    //$('.mui-content').append(location.href);
    $.ajax({
        url:'/sys/getauthmoudle',
        type:'get',
        dataType:'json',
        success:function(res){
            sessionStorage.setItem("module", res.obj);
        }
    })
    $.ajax({
        method:'get',
        url:'/ewx/getjsapiticket',
        data:{
            url:location.href,
            menuUrl:menuUrl
        },
        dataType:'json',
        success:function(res){
            /*
             * 注意：
             * 所有的JS接口只能在应用配置的安全域名下面使用。
             *
             */
            var obj = res.object;
            menuUrl = obj.menuUrl;
            config = obj;
            accessiontoken = obj.accesstoken;
            getUserInfo(accessiontoken,code).then(function (userid) {
                console.log('login')
                login(userid,code,function (res) {
                    console.log('loginSuccess')
                    // 判断是否传入的menuUrl跳转地址
                    if(menuUrl!=undefined&&menuUrl!=''){
                        location.href = menuUrl+'?JSESSIONID1='+res.token+'&dataType=1'+'&'+params;
                        if (openType!=undefined && openType!=''){
                            location.href=openType;
                        }
                    } else {
                        var sUserAgent = navigator.userAgent.toLowerCase();
                        if (/ipad|iphone|midp|rv:1.2.3.4|ucweb|android|windows ce|windows mobile/.test(sUserAgent)) {
                            //跳转移动端页面
                            location.href = '/ewx/index?JSESSIONID1='+res.token+'&dataType=1';
                            if (openType!=undefined && openType!=''){
                                location.href = openType;
                            }
                        } else {
                            //跳转pc端页面
                            if (openType!=undefined && openType!=''){
                                if (openType.indexOf("/workflow/work/workformh5")!=-1){
                                    location.href = openType.replace("/workflow/work/workformh5","/workflow/work/workform");
                                }else if (openType.indexOf("/ewx/emailDetail")!=-1){
                                    location.href = openType.replace("/ewx/emailDetail","/email/emailDetail").replace("emailID","id");
                                }else if (openType.indexOf("/ewx/noticeDetail")!=-1){
                                    location.href = openType.replace("/ewx/noticeDetail","/notice/detail");
                                }else if (openType.indexOf("/ewx/newsDetail")!=-1){
                                    location.href = openType.replace("/ewx/newsDetail","/news/detail");
                                }
                            }else {
                                location.href = '/main?JSESSIONID1='+res.token+'&dataType=1&openType='+openType;
                            }

                        }
                    }
                })
            }).catch(function (reason) {
                //alert(reason)
                console.log('logincatch')
            })
            localStorage.setItem('appId', obj.appId);
            localStorage.setItem('timestamp', obj.timestamp);
            localStorage.setItem('nonceStr', obj.nonceStr);
            localStorage.setItem('signature', obj.signature);
            wx.config({
                debug: false,
                beta: true,
                appId: obj.appId,
                timestamp: obj.timestamp,
                nonceStr: obj.nonceStr,
                signature: obj.signature,
                jsApiList: [
                    'checkJsApi',
                    'onMenuShareAppMessage',
                    'onMenuShareWechat',
                    'onMenuShareTimeline',
                    'shareAppMessage',
                    'shareWechatMessage',
                    'startRecord',
                    'stopRecord',
                    'onVoiceRecordEnd',
                    'playVoice',
                    'pauseVoice',
                    'stopVoice',
                    'uploadVoice',
                    'downloadVoice',
                    'chooseImage',
                    'previewImage',
                    'uploadImage',
                    'downloadImage',
                    'getNetworkType',
                    'openLocation',
                    'getLocation',
                    'hideOptionMenu',
                    'showOptionMenu',
                    'hideMenuItems',
                    'showMenuItems',
                    'hideAllNonBaseMenuItem',
                    'showAllNonBaseMenuItem',
                    'closeWindow',
                    'scanQRCode',
                    'previewFile',
                    'openEnterpriseChat',
                    'selectEnterpriseContact',
                    'onHistoryBack',
                    'openDefaultBrowser'
                ]
            });
        }
    });
    wx.ready(function(){
        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
        wx.getLocation({
            type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
            success: function (res) {
                var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
                var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
                var speed = res.speed; // 速度，以米/每秒计
                var accuracy = res.accuracy; // 位置精度
                console.log('企业微信定位:')
                console.log('维度：'+latitude)
                console.log('精度：'+longitude)
                console.log('速度：'+speed)
                console.log('位置精度：'+accuracy)
                console.log(res)
                localStorage.setItem('wxLocation', longitude+'|'+latitude);
            }
        });
    });
    wx.error(function(res){
        // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
        console.log(res)
       // alert(res)
    });
    function login(userid,code,cb){
        $.ajax({
            method:'post',
            url:'/jsonp/login',
            data:{
                username:userid,
                password:'',
                thirdPartyType:1,
                thirdAssessToken:code
            },
            dataType:'json',
            success:function(res){
                cb(res)
            },
            error:function(res){
                console.log('loginError')
            }
        })

    }

    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for(var i = 0; i < strs.length; i ++) {
                theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }
    function getUserInfo(token,code) {
        if(code==undefined||code==''){
            if(config.apiDomain!=''&&config.apiDomain!='https://qyapi.weixin.qq.com'){
                window.location.href =config.apiDomain + '/connect/oauth2/authorize?appid='+ config.appId +'&redirect_uri='+encodeURI(location)+'&response_type=code&scope=snsapi_base&agentid='+config.agentid+'#wechat_redirect"'
            } else {
                window.location.href ='https://open.weixin.qq.com/connect/oauth2/authorize?appid='+ config.appId +'&redirect_uri='+encodeURI(location)+'&response_type=code&scope=snsapi_base&agentid='+config.agentid+'#wechat_redirect"'
            }
        }
        return new Promise(function(resolve,reject){
            $.ajax({
                method:'get',
                url:'/ewx/getWxUserByCode',
                data:{
                    access_token:token,
                    code:code,
                    menuUrl:menuUrl
                },
                dataType:'json',
                success:function(res){
                    //alert(res.UserId)
                    resolve(res.UserId);
                }
            })
        })
    }

</script>
</html>