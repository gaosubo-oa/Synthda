<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>

<html lang="en" class=" js flexbox canvas canvastext webgl no-touch geolocation postmessage websqldatabase indexeddb hashchange history draganddrop websockets rgba hsla multiplebgs backgroundsize borderimage borderradius boxshadow textshadow opacity cssanimations csscolumns cssgradients cssreflections csstransforms csstransforms3d csstransitions fontface generatedcontent video audio localstorage sessionstorage webworkers applicationcache svg inlinesvg smil svgclippaths"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <head>
        <title>企业微信设置</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <script type="text/javascript" >
            var MYOA_JS_SERVER = "";
            var MYOA_STATIC_SERVER = "";
        </script>
        <link rel="stylesheet" href="/css/base/base.css?20201106.1">
        <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    </head>
<body>
<link rel="stylesheet" type="text/css" href="../../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../../css/enterpriseManage/weixinqy.css">
<script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>

<style>

    body,html{
        font: 14px "微软雅黑";
        height: 100%;
    }
    body a{
        color:#3b474d;
    }
    i{ font-style:normal;font-weight: bold;float: right;}
    li:hover i{
        color: #00a0e9;
    }
    .container{
        margin: 0;
    }
    #homepage{
        padding: 0;
        width: 100%;
    }
    li{
       background-color:  #f5f7f8;

    }
    a img{
        float: right;
        margin-top: 8px;
    }
    .row{
        height: 100%;
    }
    ul li{
        font-size: 13pt;
        line-height: 28px;
    }

</style>
<div class="head-top">
    <ul class="clearfix" style="margin: 0px;">
        <li class="fl head-top-li active cur" url="/qiyeWeixin/arameterSetting">基础参数设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li pd2" url="/qiyeWeixin/oaBinding">企业微信用户绑定OA用户</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li pd2" url="/qiyeWeixin/wxToOa">企业微信组织架构同步OA</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li pd2" url="/sysMenuH5/index">企业微信H5主页设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li pd2" url="enterpriseAppSetting">企业微信应用设置</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li pd2" url="/qiyeWeixin/governmentWeChatPlatformSetting">政务微信平台设置</li>
    </ul>
</div>
<div id="homepage" class="container" style="margin-top:46px;">
    <div class="row" style="margin: 0 0 0 2px;">

        <div id="content-wrap" class="" style="height:98%;float: left;width: 100%;">
            <iframe id="iframe" src="/qiyeWeixin/arameterSetting" frameborder="0"></iframe>
        </div>

    </div>
</div>
</body>
<script type="text/javascript">
    function pd(id){
        $(id).on("click", function(){
            var pd=$('#iframe').attr('v-s');
        });

    }
    $(function(){
        $(".head-top li").on("click", function(){

            $(".head-top li").removeClass("cur");
            $(".head-top li").removeClass("active");

            $(this).addClass("cur");
            $(this).addClass("active");

            var src=$(this).attr('url');

            $("#iframe").attr("src", src);

        });
        pd('.pd1')
        pd('.pd2')
    });
</script>
</html>