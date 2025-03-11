<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>心通达OA</title>
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
<%--<script src="https://g.alicdn.com/dingding/dingtalk-jsapi/2.7.13/dingtalk.open.js"></script>--%>
<script src="/lib/dingding/dingtalk.open.js"></script>
<script>
    var accessiontoken = '';

    var code = GetRequest()['code']

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
        url:'/dingding/getjsapi',
        data:{
            url:location.href
        },
        dataType:'json',
        success:function(res){
            if(res.flag){

                var _config = res.data;

                dd.config({
                    agentId: _config.agentId,
                    corpId: _config.corpId,
                    timeStamp: _config.timeStamp,
                    nonceStr: _config.nonceStr,
                    signature: _config.signature,
                    jsApiList: [
                        'runtime.info',
                        'biz.contact.choose',
                        'device.notification.confirm',
                        'device.notification.alert',
                        'device.notification.prompt',
                        'biz.ding.post',
                        'runtime.permission.requestAuthCode'
                    ]
                });


                dd.ready(function() {

                    // dd.ready参数为回调函数，在环境准备就绪时触发，jsapi的调用需要保证在该回调函数触发后调用，否则无效。
                    dd.runtime.permission.requestAuthCode({
                        corpId: _config.corpId, // 企业id
                        onSuccess: function (info) {

                            code = info.code; // 通过该免登授权码可以获取用户身份

                            getUserInfo(code).then(function (userid) {
                                var sUserAgent = navigator.userAgent.toLowerCase();
                                if (/ipad|iphone|midp|rv:1.2.3.4|ucweb|android|windows ce|windows mobile/.test(sUserAgent)) {
                                    //跳转移动端页面
                                    login(userid,code,function (res) {
                                        location.href = '/ewx/index?JSESSIONID1='+res.token+'&dataType=2';
                                    })

                                } else {
                                    //跳转pc端页面
                                    window.open('/dingding/m/mainPC?code='+code+'&dataType=2&userid='+userid);
                                }

                            }).catch(function (reason) {
                                //alert(reason)
                            })

                        },
                        onFail : function(err) {
                            alert(JSON.stringify(err));
                        }
                    });

                });

                dd.error(function(error){
                    /**
                     {
                        errorMessage:"错误信息",// errorMessage 信息会展示出钉钉服务端生成签名使用的参数，请和您生成签名的参数作对比，找出错误的参数
                        errorCode: "错误码"
                     }
                     **/
                    alert('dd error: ' + JSON.stringify(error));
                });


            }

        }
    });



    function login(userid,code,cb){
        //alert(userid)
        $.ajax({
            method:'get',
            url:'/jsonp/login',
            data:{
                username:userid,
                password:'',
                thirdPartyType:2,
                thirdAssessToken:code
            },
            dataType:'json',
            success:function(res){
                cb(res)
            }
        })

    }


    function getUserInfo(code) {
        return new Promise(function(resolve,reject){
            $.ajax({
                method:'get',
                url:'/dingding/getUserIdByCode',
                data:{
                    code:code
                },
                dataType:'json',
                success:function(res){
                    resolve(res);
                }
            })
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

</script>
</html>