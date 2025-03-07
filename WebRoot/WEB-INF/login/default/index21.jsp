<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<% response.setDateHeader("Expires", 0);
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache"); %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
<%--    <!--[if IE 8]>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <![endif]-->--%>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="../../lib/layui/layui/layui.js"></script>
    <!--index-->
    <style>
        <%--去除edge浏览器密码框默认出现小眼睛的问题--%>
        input[type="password"]::-ms-reveal{
            display: none;
        }
        input[type="password"]::-ms-clear{
            display: none;
        }
        input[type="password"]::-o-clear{
            display: none;
        }
        * {
            margin: 0;
            padding: 0;
        }

        html, body {
            width: 100%;
            height: 100%;
            /*overflow: auto;*/
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }

        .content {
            width: 100%;
            height: 100%;
            position: relative;
        }

        .clearfix:after {
            content: '';
            display: block;
            clear: both;
        }

        .header {
            width: 100%;
            min-width: 1100px;
            /*height: 17%;*/
            height: 70px;
            background: url(../../../img/default/backgroundHeader.png) no-repeat;
            background-size: 100% 100%;
            max-height: 148px;
        }

        .header .logo {
            float: left;
            margin: 8px 0px 10px 200px;
        }

        .header .logo img {
            width: 327px;
            height: 57px;
        }

        .header .banRight {
            float: right;
            margin-top: 20px;
            margin-right: 170px;
        }

        .banLang {
            font-size: 16px;
            color: #124175;
        }

        .banRight span img {
            vertical-align: middle;
            border: none;
        }

        .posit {
            display: inline-block;
            position: relative;
        }

        .icon, .iconT, .iconH {
            cursor: pointer;
            display: inline-block;
            width: 80px;
            text-align: center;
            height: 50px;
            line-height: 30px;
            position: relative;
            z-index: 999;
        }

        .iconT, .iconH {
            border: transparent 1px solid;
        }

        .QRCode {
            width: 185px;
            height: 185px;
            position: absolute;
            top: 50px;
            right: 0;
            z-index: 99;
            padding: 5px;
            border: #ccc 1px solid;
            background-color: #fff;
            -webkit-box-shadow: 0 0 6px 3px #999;
            -moz-box-shadow: 0 0 6px 3px #999;
            box-shadow: 6px 6px 16px -3px #127bc1;
        }

        .mainCon .title {

            font-size: 34px;
            margin: 0 auto;
            font-weight: bold;
            color: #fff;
            background-image: -webkit-gradient(linear, 0 20, 1 bottom, from(rgba(255, 255, 255, 1)), to(rgba(167, 194, 244, 1)));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
            margin-top: 30px;
            margin-bottom: 30px;
            /*font-weight: 900;*/
        }

        .titleTxt {
            text-shadow: -1px -1px 0 #fff, 1px 1px 0px rgba(50, 94, 175, 0.71), 1px 1px 0 rgba(35, 82, 152, 0.89);
            letter-spacing: 2px;
        }

        .mainCon .entry {
            width: 500px;
            height: 300px;
            /*background: url(../../img/default/theme3/loginBackgroundbox.png) no-repeat;*/
            background-size: 100% 100%;
            margin: 0 auto;
            position: relative;
            margin-left: 10px;
        }

        .mainCon .entry .entryTwo {
            position: absolute;
            top: 64px;
            left: 100px;
        }

        .mainCon .entry .entryTwo select {
            height: 32px;
            width: 264px;
            border-radius: 5px;
            padding-left: 10px;
            padding-top: 6px \9;
            padding-bottom: 7px \9;
        }

        .mainCon .entry .entryTwo .txt img {
            margin-right: 10px;
            vertical-align: middle;
        }

        .mainCon .entry .entryTwo .txt img.img {
            margin-left: 3px;
        }

        .mainCon .entry .entryTwo .txt input {
            height: 29px;
            width: 255px;
            border-radius: 5px;
            border: none;
            margin-top: 20px;
            padding-left: 10px;
            font-size: 14px;
            line-height: 29px;
        }

        img[src=""] {
            opacity: 0;
            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
        }

        .identitySlect {
            height: 67px;
            width: 100%;
            background: url(../../../img/default/loginBackground.png) no-repeat;
            background-position: -30px -30px;
        }

        .teaUnclick {
            background: url(../../../img/logOn/teaUnclick.png) no-repeat center center;
        }

        .teaClicked {
            background: url(../../../img/logOn/teaClicked.png) no-repeat center center;
        }

        .stuUnclick {
            background: url(../../../img/logOn/stuUnclick.png) no-repeat center center;
        }

        .stuClicked {
            background: url(../../../img/logOn/stuClicked.png) no-repeat center center;
        }

        .parUnclick {
            background: url(../../../img/logOn/parUnclick.png) no-repeat center center;
        }

        .parClicked {
            background: url(../../../img/logOn/parClicked.png) no-repeat center center;
        }

        .identitySlect div {
            float: left;
            width: 100px;
            height: 36px;
            border-radius: 36px;
            background-position: center center;
            cursor: pointer;
            margin-left: 50px;
            margin-top: 18px;
        }

        .userInp {
            width: 100%;
            height: 275px;
            position: relative;
            overflow: hidden;
        }

        .userInp ul {
            width: 300%;
            height: 100%;
            position: absolute;
        }

        .userInp ul li {
            list-style: none;
            width: 33.33333333333333333333333%;
            height: 100%;
            float: left;
        }

        .ID {
            background: url(../img/default/theme3/icon_user.png) no-repeat left center;
        }

        .pass {
            background: url(../img/default/theme3/icon_password.png) no-repeat left center;
        }

        .userInp ul li div {
            width: 85%;
            height: 40px;
            margin: 20px auto;
            padding-left: 40px;
            box-sizing: border-box;
            line-height: 40px;
            background-size: 18px 18px;
            background-color: white;
            background-position: 10px;
            border-radius: 10px;
        }
        .userInp ul li .loginIn {
            padding: 0;
            text-align: center;
            background: url(../../img/default/theme3/loginback.png) no-repeat;
            background-position: -10px;
            background-size: 108% 130%;
            font-size: 20px;
            color: white;
            cursor: pointer;
        }

        .QRCodeA {
            width: 500px;
            height: 220px;
            position: absolute;
            top: 275px;
            background: none;
        }

        .andoridBtn {
            background: url(../img/default/theme1/Android.png) no-repeat;
        }

        .iosBtn {
            background: url(../img/default/Apple.png) no-repeat;
        }

        .downloadBtn {
            width: 130px;
            height: 30px;
            background-color: rgb(249, 255, 252);
            border-radius: 30px;
            background-position: 5px center;
            margin: 10px auto;
            text-align: center;
            line-height: 30px;
            border: 1px solid rgb(149, 222, 230);
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
        }

        .bottom {
            width: 100%;
            height: 135px;
            position: fixed;
            text-align: center;
            line-height: 135px;
            font-weight: 400;
            background: white;
            bottom: 0;
        }

        .publicCode {
            width: 300px;
            height: 80%;
            position: absolute;
            top: 10px;
            right: 30px;
        }

        .publicCode img {
            width: 95px;
            height: 95px;
        }

        .header .logo img {
            width: auto;
        }
        .layui-tab{
            margin: 0;
        }
        .layui-input{
            width: 80%;
        }
        .layui-tab-title li{
            margin-right: 20px;
            background-color: #f2f2f2;
            font-size: 16px;
            line-height: 50px;
            width: 100px;
        }
        .layui-tab-title .layui-this:after{
            height: 50px;
        }
        .layui-tab-title .layui-this {
            color: #000;
            width: 100px;
            background: #009688;
            border-radius: 5px;
            height: 50px;
        }
        .layui-tab-title{
            height: 50px;
        }
        .layui-tab-item{
            margin: 60px auto;
        }
        .entry button{
            margin-left: 165px;
            margin-top: 20px;
            width: 150px;
            border-radius: 5px;
        }
        .layui-form-item{
            margin-bottom: 35px;
        }
        .entryBg{
            position: fixed;
            top: 140px;
            left: 50px;
            margin-left: 50px;
            margin-top: 80px;
        }
    </style>
</head>
<body>
<input type="hidden" name="typeName" value="theme1">
<div class="form1">
    <div class="content">
        <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
            提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
        </div>
        <div class="header clearfix">
            <div class="logo">

            </div>
            <div class="banRight">
                <span class="banLang"><fmt:message code="language"/>：</span>
                <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                    <option value="?lang=zh_CN" >中文</option>
                    <option value="?lang=en_US" selected="selected">English</option>
                    <option value="?lang=zh_tw">繁体</option>
                </select>
                <span class="icon">
                    <a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
                        <img src="../img/default/pc.png" title='<fmt:message code="main.th.pc" />'/>
                    </a>
                </span>
                <div class="posit" id="android">
                    <span class="iconT">
                        <img src="../img/default/theme1/Android.png" title='<fmt:message code="main.th.Android" />'/>
                    </span>
                    <div class="QRCode codeT" style="display: none;">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                             src="../img/default/sy07.png?${versionAndroid}"/>
                    </div>
                </div>
                <div class="posit" id="iphone">
                    <span class="iconH">
                        <img src="../img/default/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
                    </span>
                    <div class="QRCode codeH" style="display: none;">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                             src="../img/default/sy08.png?${versionIOS}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="mainCon">
            <div class="entryBg">
                <div style="float: left;">
                    <img style="height: 400px;" src="../../img/default/theme3/backgroundMain.png">
                </div>
                <div class="entry" style="float: left;">
                    <div class="layui-tab">
                        <ul class="layui-tab-title">
                            <li class="layui-this">密码登录</li>
                            <li>扫描登录</li>
                            <li>短信登录</li>
                        </ul>
                        <div class="layui-tab-content" style="border: 1px solid;height: 325px;border-top: none;">
                            <div class="layui-tab-item layui-show">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">账号</label>
                                    <div class="layui-input-block">
                                        <input type="text" class="layui-input" placeholder=""/>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">密码</label>
                                    <div class="layui-input-block">
                                        <input type="password" class="layui-input" placeholder="" autocomplete="off"/>
                                    </div>
                                </div>
                                <button type="button" class="layui-btn layui-btn-normal">登录</button>
                            </div>
                            <div class="layui-tab-item">内容2</div>
                            <div class="layui-tab-item">内容3</div>
                        </div>
                    </div>
                    <%--<div class="identitySlect">--%>
                        <%--&lt;%&ndash;三个选择按钮&ndash;%&gt;--%>
                        <%--<div class="teacherLogin  teaUnclick teaClicked"></div>--%>
                        <%--<div class="studentLogin stuUnclick"></div>--%>
                        <%--<div class="parentsLogin parUnclick"></div>--%>
                    <%--</div>--%>
                    <%--<div class="userInp">--%>
                        <%--&lt;%&ndash;教师，学生，家长各是一个单独的多个输入框，方便区分&ndash;%&gt;--%>
                        <%--<ul>--%>
                            <%--<li>--%>
                                <%--<div class="teaID ID">--%>
                                    <%--<input type="text" placeholder="账号"/>--%>
                                <%--</div>--%>
                                <%--<div class="teaPass pass">--%>
                                    <%--<input type="password" autocomplete="off" placeholder="密码"/>--%>
                                <%--</div>--%>
                                <%--<div class="teaLogin loginIn">立即登陆</div>--%>
                            <%--</li>--%>
                            <%--<li>--%>
                                <%--<div class="stuID ID">--%>
                                    <%--<input type="text" placeholder="账号"/>--%>
                                <%--</div>--%>
                                <%--<div class="stuPass pass">--%>
                                    <%--<input type="password" placeholder="密码" autocomplete="off"/>--%>
                                <%--</div>--%>
                                <%--<div class="stuLogin loginIn">立即登陆</div>--%>
                            <%--</li>--%>
                            <%--<li>--%>
                                <%--<div class="parID ID">--%>
                                    <%--<input type="text" placeholder="账号"/>--%>
                                <%--</div>--%>
                                <%--<div class="parPass pass">--%>
                                    <%--<input type="password" placeholder="密码" autocomplete="off"/>--%>
                                <%--</div>--%>
                                <%--<div class="parLogin loginIn">立即登陆</div>--%>
                            <%--</li>--%>
                        <%--</ul>--%>
                    <%--</div>--%>
                </div>
            </div>
            <%--<div class="title">--%>
            <%--<span class="titleTxt">春蚕教育学院智慧校园系统</span>--%>
            <%--</div>--%>

            <%--<div class="bottom">--%>
            <%--&lt;%&ndash;底部二维码&ndash;%&gt;--%>
            <%--<span>厦门春蚕教育科技有限公司</span>--%>
            <%--<div class="publicCode" style="line-height:20px">--%>
            <%--<img src="../img/default/sy07.png"/><br/>--%>
            <%--<span>关注厦门春蚕公众号，获取更多咨询</span>--%>
            <%--</div>--%>
            <%--</div>--%>
        </div>

    </div>
</div>
<script type="text/javascript">
    layui.use('element', function(){
        var $ = layui.jquery
            ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

    });
    $(function () {
        autodivheight()
    })
    function autodivheight() {
        $('.entryBg img').width($(document).width()-740)
        $('.mainCon').height($(document).height() - $('.header').height() - 2);
    }
</script>
<script  src="/js/login/showPassword.js?20230418.1"></script>
</body>
</html>

