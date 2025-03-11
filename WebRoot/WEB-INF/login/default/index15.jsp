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
    <link rel="stylesheet" type="text/css" href="/css/default/theme15/loginInterface.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
<%--    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
<%--    <!--[if IE 8]>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <![endif]-->--%>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js"></script>
    <script charset="utf-8" src="/js/login/scanLogin.js?20220320"></script>
    <script src="/js/login/login.js?20230306.1"></script>
    <script charset="utf-8" src="/js/login/jsencrypt.js?20210429.3"></script>
    <!--index6-->
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
        .experience {
            position: fixed;
            width: 250px;
            padding: 10px 5px;
            top: 110px;
            left: 10px;
            color: #fff;
            z-index: 99999;
            border-radius: 4px;
            font-size: 12pt;
            display: none;
        }

        .experience p {
            line-height: 24px;
        }

        .titleTxt {
            color: #d73c3d;
        }

        .mainCon .title {
            -webkit-text-fill-color: #d73c3d;
        }

        img[src=""] {
            opacity: 0;
            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
        }

        .header .logo img {
            width: auto;
        }


        * {
            margin: 0;
            padding: 0;
            font-family: "Microsoft YaHei";
        }
        html {
            height: 100%;
            overflow: hidden;
        }
        body {
            width: 100%;
            height: 100%;
            font-size: 16px;
            background: url(login_bg.png?20210105) no-repeat;
            background-size: 100% 100%;
            -moz-user-select: none;
            -webkit-user-select: none;
            -ms-user-select: none;
            -khtml-user-select: none;
            user-select: none;
            position: relative;
        }
        .login_bg{
            display: none;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }
        .login_form {
            width: 412px;
            height: 500px;
            position: absolute;
            bottom: 30%;
            left: 50%;
            margin-left: -206px;
        }
        .compony {
            position: absolute;
            width: 200px;
            left: 50%;
            margin-left: -100px;
            bottom: 55px;
            color: #fff;
        }
        .tdxk {
            position: absolute;
            top: 30px;
            left: 30px;
            max-width: 100px;
        }
        .logo {
            margin: 0 auto;
            text-align: left;
        }
        .logo-icon{
            margin: 0 auto;
            display: block;
            margin-left: 10%;
            margin-top: 20px;
        }
        .logo-new-year{
            margin: 0 auto;
            width: 410px;
            display: block;
        }
        .lower-tip{
            display: block;
            padding:10px;
            font-size:14px;
            color: #fff;
        }
        .logo-newyear{
            width: 100%;
        }
        .msg{
            color:#fff;
            margin: 10px 0;
        }
        .msg a{
            color:#fff;
        }
        .msg a:hover{
            color: #EFE4B0;
        }
        #center{
            margin: 0 auto;
            text-align: center;
        }
        #tip {
            padding: 0 20px;
            background: #ffe5e5;
            color: #aa0000;
            height: 26px;
            line-height: 26px;
            visibility: hidden;
            font-size: 12px;
            border-radius: 12px;
            margin: 8px auto 0;
            max-width: 60%;
        }
        div#passWordLogin {
            padding: 0 25px;
        }
        .input-wrap {
            height: 40px;
            color: #666;
            margin: 30px auto;
            border-bottom: 1px solid #ddd;
            text-align: left;
            padding-left: 15px;
        }
        .input-wrap:hover{
            border-bottom: 1px solid #bd2323;
        }
        span.login-title-separator {
            margin-left: 10px;
        }
        .input-wrap:hover .login-title-separator{
            color: #bd2323;
        }
        .input-wrap.password{
        }
        .input-wrap input{
            border: none;
            width: 200px;
            height: 30px;
            line-height: 30px;
            outline: none;
            font-size: 14px;
            background: transparent;
        }
        .input-wrap label{
            width: 70px;
            text-align: right;
            display: inline-block;
        }
        .login_btn{
            margin-top: 5px;
            height: 45px;
            line-height: 45px;
            text-align: center;
            width: 240px;
            font-size: 14px;
            outline: none;
            cursor: pointer;
            border-radius: 6px;
            border: none;
            color: #fff;
            font-weight: bold;
            background: url(/img/default/theme15/login15.png) no-repeat center center;
            background-size: 220px 40px;
            /*é’ˆå¯¹IE8çš„hackï¼Œç›®çš„æ˜¯é™¤æŽ‰ä¹‹å‰background*/
            background: none\9;
        }
        #center i{
            position: relative;
        }
        #center i img{
            width: 12px;
            position: relative;
            top: 2px;
        }
        #changeLogin{
            overflow: hidden;
            /* height: 195px; */
            width: 390px;
            min-height: 300px;
            padding: 15px 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
            -moz-box-shadow: 2px -2px 26px rgba(0,0,0,.2);
            -webkit-box-shadow: 2px -2px 26px rgba(0,0,0,.2);
            box-shadow: 2px -2px 26px rgba(0,0,0,.2);
            margin: 0 auto;
            margin-top: 40px;
            position: relative;
            background: #fff;
        }
        .changeLogin-bg{
            width: 100%;
            height: 100%;
            z-index: -1;
            position: absolute;
            top: 0;
            left: 0;
            background:#fff;
        }
        #changeWay{
            width: 100%;
            height: 60px;
            margin-top: -20px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
        }
        #numSpan,#imgSpan{
            display: block;
            width: 100%;
            float: left;
            color: #666;
            cursor: pointer;
        }
        .waySpan{
            display:inline-block;
            height:40px;

        }
        .selectedSpan{
            color: #bd2323;
        }
        .boxShow{
            display:block;
        }
        .boxHidden{
            display:none;
        }
        .company{
            text-align:center;
            font-size: 13px;
            line-height: 40px;
            margin-top: 15px;
        }
        #changeWay-split {
            height: 20px;
            width: 1px;
            background: #eee;
            float: left;
            margin-top: 10px;
        }
        .input-wrap span.split {
            height: 20px;
            width: 1px;
            background: #ccc;
            display: inline-block;
            vertical-align: middle;
            margin: 0 5px;
        }
        .input-wrap:hover span.split{
            background: #bd2323;
        }
        .input-wrap.captcha{
            text-align:left;
            margin-left: 0 !important;
        }
        #captcha{
            width: 90px;
        }
        #captchaImg{
            height: 29px;
            width: 110px;
            vertical-align: middle;
        }
        img.captchaStatus {
            width: 18px;
            height: 18px;
            vertical-align: middle;
        }
        #erweima{
            width: 120px;
            height: 120px;
            display: block;
            margin: 0 auto;
            margin-top: 50px;
        }
        #userImg{
            overflow:hidden;
            width:364px;
            height:322px;
            margin:0 auto;
            margin-top:52px;
            background:rgba(241, 240, 240, 0.466);
            border-radius:10px;
        }
        #headIcon{
            width:160px;
            height:160px;
            margin:0 auto;
            margin-top:50px;
            background:#fff;
        }
        .mobileCue{
            display:block;
            width:200px;
            height:20px;
            line-height:20px;
            margin:0 auto;
            margin-top:10px;
            font-size:13px;
        }
        #nickName{
            display:block;
            width:200px;
            height:20px;
            line-height:20px;
            margin:0 auto;
            margin-top:20px;
            font-size:13px;
        }
        .backLogin{
            display:block;
            width:200px;
            height:20px;
            line-height:20px;
            font-weight:bold;
            margin:0 auto;
            margin-top:20px;
            color:#666;
            font-size:13px;
            cursor: pointer;
        }
        #overTime{
            width:100%;
            text-align: center;
            overflow:hidden;
        }
        #invalidImg{
            width:160px;
            height:160px;
            display:block;
            margin:0 auto;
            margin-top:40px;
            cursor: pointer;
            background:#fff;
        }
        .overTimeSpan{
            display:block;
            margin-top:18px;
            color:#666;
            font-size:16px;
        }
        .erweimaSpan{
            display:block;
            margin-top:30px;
            color:#666;
            font-size:14px;
        }
        .app-link{
            display: block;
            margin-top: 10px;
            font-size: 12px;
            color: #666;
        }
        .app-link>a{
            color:#666;
            text-decoration:none;
        }
        @media (max-width: 1600px) {
            .login_form{
                bottom: 20%;
                width: 320px;
                margin-left: -160px;
            }
            .logo-new-year {
                width: 290px;
            }
            #changeLogin {
                margin-top: 30px;
                width: 290px;
            }
            .input-wrap input {
                width: 190px;
            }
            #captcha {
                width: 85px;
            }
            #captchaImg{
                width: 80px;
            }
        }
        @media (min-width: 1600px) {
            .logo-new-year {
                margin: 10px auto;
            }
        }
        @media (min-width: 1920px) {
            body {
                background: url(bg_2560.png?20210105) no-repeat;
                background-size: 100% 100%;
            }
            .logo-new-year {
                margin: 15px auto;
            }
        }
        @media (min-width: 2550px) {

        }
        .mainCon {
            height: 83%;

            background-size: 100% 100vh;
            position: relative;
            border: solid 1px transparent;

            width: 100%;

            overflow-y: auto;
            width: 100%;
        }
        /*.content{*/
        /*    height: 100vh;*/
        /*    overflow: auto;*/
        /*}*/
        #numSpan, #imgSpan{
            display: inline-block;
            width: auto;
        }
        #changeWay{
            display: flex;
            justify-content: space-around;
        }
        #changeWay-split{
            margin-top: 0;
        }
        .layui-form{
            margin-top: -23px;
            margin-left: 35px;
        }
        .layui-form-select .layui-input{
            border: 1px solid #e6e6e6;
        }
        .mainCon .entry{
            border-radius: 5px;
            box-shadow: 2px -2px 26px rgba(0,0,0,.2);
        }
        .mainCon .entry{
            background: url(/img/default/theme14/loginBackground.png) no-repeat 460px 420px;
        }
        .layui-form-select .layui-input{
            border: 1px solid #eee;
        }
        #changeWay-split{
            background: #eee;
        }
        .input-wrap,#changeWay{
            border-bottom: 1px solid #eee;
        }
    </style>
</head>
<body style="display: none">

<div class="experience">
    <p><fmt:message code="main.th.ExperienceAccount"/>：</p>
    <p style="padding-left: 2em"><span>zhangwei</span> <label style="margin-left: 1em">董事长/CEO</label></p>
    <p style="padding-left: 2em"><span>wangfang</span> <label style="margin-left: 1em">人事部</label></p>
    <p style="padding-left: 2em"><span>liuyang</span> <label style="margin-left: 1em">财务部</label></p>
    <p style="padding-left: 2em"><span>lihua</span> <label style="margin-left: 1em">研发部</label></p>
    <p style="padding-left: 2em"><span>wangli</span> <label style="margin-left: 1em">研发一组</label></p>
    <p style="padding-left: 2em"><span>wanghai</span> <label style="margin-left: 1em">研发一组</label></p>
    <p style="padding-left: 2em"><span>baixue</span> <label style="margin-left: 1em">客服中心</label></p>
    <p style="padding-left: 2em"><span>wangqiang</span> <label style="margin-left: 1em">生产部</label></p>
    <p><fmt:message code="main.th.FriendshipTips"/>：</p>
    <p style="padding-left: 2em">
        <fmt:message code="main.th.AllPasswordsEmpty"/>。
    </p>
</div>

<%--    <form  name="form1" action="">--%>

    <div class="content">
        <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
            提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
        </div>
        <div class="header clearfix" style="display: none;">
            <div class="logo">
                <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
            </div>
            <div class="banRight">
                <span class="banLang"><fmt:message code="language"/>：</span>
                <select id="language" name="language" style="width: 80px;height: 24px;margin-right: 30px;">
                    <option value="?lang=zh_CN" >中文</option>
                    <option value="?lang=en_US" selected="selected">English</option>
                    <option value="?lang=zh_tw">繁体</option>
                </select>
                <span class="icon">
								<a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme13/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                <div class="posit" id="android">
							<span class="iconT">
								<img src="/img/default/theme13/Android.png" title='<fmt:message code="global.th.downloadTheAndroidClient" />'/>
							</span>
                    <div class="QRCode codeT" style="display: none;">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                             src="/img/default/sy07.png?${versionAndroid}"/>
                    </div>
                </div>
                <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme13/Apple.png" title='<fmt:message code="global.th.downloadTheIPhoneClient" />>'/>
							</span>
                    <div class="QRCode codeH" style="display: none;">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                             src="/img/default/sy08.png?${versionIOS}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="mainCon">
            <div class="title">
                <span class="titleTxt"></span>
            </div>

            <div class="entry entryBg">
                <div style="position: absolute;top: 7px;right: 10px;" title="扫码登录" class="scanLogin" loginType="3">
                    <img src="/img/default/theme17/scan.png" style="width: 24px;cursor:pointer;"/>
                </div>
                <div class="entryTwo" style="top: 55px;width: 60%">
<%--                    <div id="changeWay">--%>
<%--                        <div id="numSpan" style="text-align: center;"><span class="waySpan selectedSpan">账号登录</span></div>--%>
<%--                    </div>--%>

    <div id="changeWay">
        <div id="numSpan"><span class=" waySpan selectedSpan">账号登录</span></div>
        <div id="changeWay-split"></div>
        <div id="imgSpan"><span class="waySpan1 resetPsword">忘记密码</span></div>
    </div>
                    <div class="txt input-wrap name">
                        <i for="name">
                            <img src="/img/default/theme14/icon_depart.png" style="position: relative;top: 4px">
                        </i>
                        <span class="split" style="display: none"></span>

                        <form class="layui-form" action="">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select id="departs" name="departs" style=" appearance:none; width: 200px">
                                    <%--<option value="0">总部</option>
                                    <option value="1">北京分公司</option>--%>
                                </select>
                            </div>
                        </div>
                        </form>
<%--                        <select id="departs" name="departs" style="border: none; appearance:none; width: 200px">--%>
<%--                            &lt;%&ndash;<option value="0">总部</option>--%>
<%--                            <option value="1">北京分公司</option>&ndash;%&gt;--%>
<%--                        </select>--%>
                    </div>
<%--                    <div class="txt">--%>
<%--                        <img src="/img/default/theme14/icon_depart.png" style="margin-right: 13px;"/>--%>
<%--                        <span class="spanColor"--%>
<%--                              style="vertical-align:middle;margin-right: -4px;color: #FFFFFF;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message--%>
<%--                                code="global.lang.tissue"/></span>--%>
<%--                        <select id="departs" name="departs">--%>
<%--                            &lt;%&ndash;<option value="0">总部</option>--%>
<%--                            <option value="1">北京分公司</option>&ndash;%&gt;--%>
<%--                        </select>--%>
<%--                    </div>--%>
                    <div class="input-wrap name">
                        <i for="name">
                            <img src="/img/default/theme14/icon_user.png " style="position: relative;top: 4px">
                        </i>
                        <span class="split"></span>
                        <input type="text" id="user" name="UNAME" maxlength="20" autocomplete="off" onmouseover="this.focus()" onfocus="this.select()" value="" placeholder="用户">
                    </div>
<%--                    <div class="txt">--%>
<%--                        <img class="img" src="/img/default/theme14/icon_user.png"/>--%>
<%--                        <span class="spanColor"--%>
<%--                              style="vertical-align:middle;margin-left: 3px;color: #FFFFFF;margin-right: -4px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message--%>
<%--                                code="journal.th.user"/></span>--%>
<%--                        <input type="text" style="margin-left:1px;" name="user" id="user" value=""/>--%>
<%--                    </div>--%>
                    <div class="input-wrap password">
                        <i for="password">
                            <img src="/img/default/theme14/icon_password.png" style="position: relative;top: 4px">
                        </i>
                        <span class="split"></span>
                        <input type="password" id="password" name="PASSWORD" autocomplete="new-password" onmouseover="this.focus()" onfocus="this.select()" maxlength="200" value="" placeholder="密码">
                        <div style="color:red;padding:13px 2px 2px 37px; position:absolute; display:none;font-size: 13px;" id="capital">大写锁定已开启</div>
                    </div>
<%--                    <div class="txt">--%>
<%--                        <img class="img" style="margin-left: 2px;" src="/img/default/theme14/icon_password.png"/>--%>
<%--                        <span class="spanColor"--%>
<%--                              style="vertical-align:middle;margin-left: 5px;color: #FFFFFF;margin-right: -12px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message--%>
<%--                                code="passWord"/></span>--%>
<%--                        <input type="password" autocomplete="off" style="margin-left:8px;" name="password" id="password"--%>
<%--                               value=""/>--%>
<%--                    </div>--%>
<%--                    <div class="resetPsword">--%>
<%--                        <span autocomplete="off" style="color: red; float:right; display: inline-block;font-size: 10px;margin-top: -22px;">忘记密码？</span>--%>
<%--                    </div>--%>
                    <div id="SecGraphic" class="txt" style="margin-top: 22px;height: 30px;position: relative;">

                        <div class="input-wrap password">
                            <i for="password">
                                <img src="/img/default/theme14/icon_graphic.png" style="position: relative;top: 4px">
                            </i>
                            <span class="split"></span>
                            <input type="text" id="graphic" name="PASSWORD" autocomplete="new-password" onmouseover="this.focus()" onfocus="this.select()" maxlength="200" value="" placeholder="验证码">
                            <img src="" alt=""   style="position: absolute;top: 5px;right: -11px;"  onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                        </div>


<%--                        <img class="img" src="/img/default/theme14/icon_graphic.png"/>--%>
<%--                        <span class="spanColor"  style="color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
<%--                        <input type="text" id="graphic" style="width: 155px;margin-left: 16px;margin-top: 5px;" placeholder="请输入图中验证码"/>--%>
<%--                        &lt;%&ndash;                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>&ndash;%&gt;--%>
<%--                        <img src="" alt=""   style="position: absolute;top: 5px;right: -11px;"  onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">--%>
                    </div>
                    <div class="loginBtn" style="margin-left:66px;margin-top: 30px;">
                        <span style="margin-left: 70px;">登 录</span>
                    </div>
                </div>
            </div>
<%--            <div id="changeLogin" class="">--%>
<%--                <div class="changeLogin-bg"></div>--%>
<%--                <div id="changeWay">--%>
<%--                    <div id="numSpan"><span class=" waySpan selectedSpan">账号登录</span></div>--%>
<%--                </div>--%>
<%--                <div id="passWordLogin" class="">--%>
<%--                    <div class="input-wrap name">--%>
<%--                        <i for="name">--%>
<%--                            <img src="/img/default/theme15/icon_depart.png" style="position: relative;top: 4px">--%>
<%--                        </i>--%>
<%--                        <span class="split"></span>--%>
<%--                        <select id="departs" name="departs" style="appearance: none;width: 200px;border: none" placeholder="组织">--%>
<%--                            &lt;%&ndash; <option >组织</option>--%>
<%--                             <option value="1">北京分公司</option>&ndash;%&gt;--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                    <div class="input-wrap password">--%>
<%--                        <i for="password">--%>
<%--                            <img src="/img/default/theme15/icon_user.png" style="position: relative;top: 4px">--%>
<%--                        </i>--%>
<%--                        <span class="split"></span>--%>
<%--                        <input type="text" id="user" name="UNAME" maxlength="20" autocomplete="off" onmouseover="this.focus()" onfocus="this.select()" value="admin" placeholder="用户">--%>
<%--                    </div>--%>

<%--                    <div class="input-wrap captcha" style="margin-left: 15px;" style="position: relative;top: 4px">--%>
<%--                        <i for="captcha">--%>
<%--                            <img src="/img/default/theme15/icon_password.png" class="captcha-icon">--%>
<%--                        </i>--%>
<%--                        <span class="split"></span>--%>
<%--                        <input type="password" id="password" name="PASSWORD" autocomplete="new-password" onmouseover="this.focus()" onfocus="this.select()" maxlength="200" value="" placeholder="密码">--%>
<%--                    </div>--%>

<%--                    <!-- <div  > -->--%>
<%--                    <input type="hidden" name="encode_type" value="1">--%>
<%--                    <button class="login_btn loginBtn" title="登录"></button>--%>
<%--                </div>--%>
<%--            </div>--%>
        </div>
    </div>
<%--</form>--%>
<div id="beianhao" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
    <p style="text-align: center;margin-bottom: 5px">
        <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;" href="http://www.beian.miit.gov.cn"></a>
    </p>
    <p style="text-align: center;">
        <label style="color: red">网站备案号：</label>
        <span class="ptwo" style="margin: 0 auto;height: 19px;color: red;"></span>
    </p>
</div>
<script type="text/javascript">
    <%--判断浏览器是ie8--%>
    <%--判断浏览器是ie8--%>
    var browser = navigator.appName
    var b_version = navigator.appVersion
    if (b_version.indexOf(';') > -1) {
        var version = b_version.split(";");
        var trim_Version = version[1].replace(/[ ]/g, "");
        if (browser == "Microsoft Internet Explorer" && trim_Version == "MSIE8.0") {
            $('.tips').show()
        } else {
            $('.tips').hide()
        }
    }
    //检测大写锁定
    (function(){
        var inputPWD = document.getElementById('password');
        var capital = false;
        var capitalTip = {
            elem:document.getElementById('capital'),
            toggle:function(s){
                var sy = this.elem.style;
                var d = sy.display;
                if(s){
                    sy.display = s;
                }else{
                    sy.display = d =='none' ? '' : 'none';
                }
            }
        }
        var detectCapsLock = function(event){
            if(capital){return};
            var e = event||window.event;
            var keyCode = e.keyCode||e.which; // 按键的keyCode
            var isShift = e.shiftKey ||(keyCode == 16 ) || false ; // shift键是否按住
            if (
                ((keyCode >= 65 && keyCode <= 90 ) && !isShift) // Caps Lock 打开，且没有按住shift键
                || ((keyCode >= 97 && keyCode <= 122 ) && isShift)// Caps Lock 打开，且按住shift键
            ){capitalTip.toggle('block');capital=true}
            else{capitalTip.toggle('none');}
        }
        inputPWD.onkeypress = detectCapsLock;
        inputPWD.onkeyup=function(event){
            var e = event||window.event;
            if(e.keyCode == 20 && capital){
                capitalTip.toggle();
                return false;
            }
        }
    })()
    //忘记密码功能
    $('.resetPsword').on('mouseover', function () {
        $(this).css('cursor', 'pointer');
    })
    $('.resetPsword').on('click', function () {
        window.location.href = '/resetPsword?type=6'
    })

    //忘记密码
    $('.waySpan1').on('click', function(){
        $('.waySpan1').css('color','#bd2323')
        $('.waySpan').css('color','#666')
        $('.waySpan1').addClass('resetPsword')
    })
    $('.waySpan').on('click', function(){
        $('.waySpan').css('color','#bd2323')
        $('.waySpan1').css('color','#666')

    })


    /*function createCode() {
        code = "";
        var codeLength = 4;
        var checkCode = document.getElementById("checkCode");
        //设置随机字符
        var random = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
        //循环codeLength 我设置的4就是循环4次
        for (var i = 0; i < codeLength; i++) {
            //设置随机数范围,这设置为0 ~ 36
            var index = Math.floor(Math.random() * 36);
            //字符串拼接 将每次随机的字符 进行拼接
            code += random[index];
        }
        if (checkCode) {
            checkCode.className = "code";
            checkCode.value = code;
        }
    }*/


    window.onload = function () {
        var inputtwo = document.getElementById('user');
        inputtwo.focus()
    }


    function autodivheight() {
        $('.mainCon').height($(document).height() - $('.header').height() - 2);
    }


    function throttle(method) {
        clearTimeout(method.tId);
        method.tId = setTimeout(function () {
            method.call();
        }, 100);
    }


    $(function () {
        //首次加载验证码
        //createCode();
        //扫码登陆
        $(document).on("click",'.scanLogin',function(){
            var selectPart = $('select[name="departs"] option:checked').val()
            scanLogin(selectPart);
        })
        // 查询是否开启黑色主题
        getBlackTheme()
        // 高度设置
        autodivheight()
        window.onresize = function () {
            throttle(autodivheight)
        };
        var isa = 0;
        $.get('/sys/getInterfaceParam', {params:"loginLiterals,fileNumber,loginValidation"},function (json) {
            if (json.flag) {
                if (json.obj.loginLiterals != '') {
                    $('.titleTxt').text(json.obj.loginLiterals)
                } else {
                    $('.titleTxt').text("OA网络智能办公系统")
                }
                $('.pone').text(json.obj.fileNumber)
                document.title = json.obj.loginLiterals;
                if (json.obj.loginValidation == 0 || location.href.indexOf('oa.8oa.cn') > -1) {
                    $('.experience').show();
                }
                if(json.obj.MIIBEIAN != ''){
                    $('.ptwo').text(json.obj.MIIBEIAN)
                }else{
                    $('#beianhao').css('display','none')
                }
                if(json.obj.QRCODE_LOGIN_SET == '0' ){
                    $('.scanLogin').css('display','none')
                }else{
                    $('.scanLogin').css('display','block')
                }
            }
        }, 'json')
        //部门列表

        //登录按钮三种状态
//        $('.loginBtn').mouseover(function () {
//            $(this).css('background','url(../img/default/loginAfter.png) no-repeat');
//        })
//        $('.loginBtn').click(function () {
//            $(this).css('background','url(../img/default/loginClick.png) no-repeat');
//        })
//        $('.loginBtn').mouseout(function () {
//            $(this).css('background','url(../img/default/loginback.png) no-repeat');
//        })
        //右侧图标点击扫码下载
        /*$('.iconT img').click(function () {
         $('.iconT').addClass('one');
         $('.codeT').show();
         $('.codeH').hide();
         $('.iconH').removeClass('one');
         })
         $('.iconH img').click(function () {
         $('.iconH').addClass('one');
         $('.codeH').show();
         $('.codeT').hide();
         $('.iconT').removeClass('one');
         })*/

        $('.codeH').on('mouseover', function () {
            $('.iconH').addClass('one');
            $('.codeH').show();
        })
        $('.iconH').on('mouseover', function () {
            $('.iconH').addClass('one');
            $('.codeH').show();
        })

        $('.codeT').on('mouseover', function () {
            $('.iconT').addClass('one');
            $('.codeT').show();
        })
        $('.iconT').on('mouseover', function () {
            $('.iconT').addClass('one');
            $('.codeT').show();
        })

        $('#android').on('mouseout', function () {
            $('.codeT').hide();
            $('.iconT').removeClass('one');
        })
        $('#iphone').on('mouseout', function () {
            $('.codeH').hide();
            $('.iconH').removeClass('one');
        })
        //语言改变事件

        var url = window.location.href.split('=')[1];
        if (url == 'zh_CN') {
            $('[name="language"]').val('?lang=zh_CN')
        } else if (url == 'zh_tw') {
            $('[name="language"]').val('?lang=zh_tw')
        } else {
            url = 'en_US'
            $('[name="language"]').val('?lang=en_US')
        }
        $('select[name="language"]').on('change', function () {
            window.location.href = this.value
        })

        $(document).on('keypress', function (e) {
            // 回车键事件
            if (e.which == 13) {
                $('.loginBtn').click();
            }
        });


        //登录点击事件
        var lockded = false;
        $('.loginBtn').on('click', function () {

            var byName = $('#user').val();
            if (byName.length == 0) {
                alert("请输入用户名！");
                return;
            }
            var result = encryptPadding();
            var encryptor = new JSEncrypt();
            encryptor.setPublicKey(result);
            var pwd = encryptor.encrypt($('#password').val());
            var loginId = $('select[name="departs"] option:checked').val()||$('select[name="departs"]').val();

            if (isa == 0) {
                var data = {
                    userAgent: 'pcc',
                    loginId: loginId,
                    username: encryptor.encrypt($('#user').val()),
                    password: pwd,
                    locales: url
                }
                if (!lockded) {
                    lockded = true;
                    $.ajax({
                        type: 'post',
                        url: 'login',
                        dataType: 'json',
                        data: data,
                        success: function (res) {
                            if (res.flag == true) {
                                var loginCokie = res.object;
                                loginCokie.language = $('#language').val().split('=')[1] || 'zh_CN';
                                loginCokie.company = $('#departs').val();
                                $.setCookie(loginCokie);
                                //同步请求
                                $.ajaxSettings.async = false;
                                var bol = 0 ;
                                $.get('/sysTasks/selectAll', function (datas) {
                                    var datas = datas.obj;
                                    for (var i = 0; i < datas.length; i++) {
                                        if (datas[i].paraName == 'SEC_INIT_PASS_SHOW' && datas[i].paraValue == 1 && $('#password').val() == "") {
                                            bol = 1;
                                        }
                                    }
                                }, 'json')
                                $.ajax({
                                    type: 'post',
                                    url: '/checkPass',
                                    dataType: 'json',
                                    data: {
                                        username:encryptor.encrypt($('#user').val()),
                                        password:encryptor.encrypt($('#password').val())
                                    },
                                    success: function (res) {
                                        if(res.flag){
                                            bol = 0;
                                        }else{
                                            bol = 1;
                                        }
                                    }
                                })
                                if(bol != 0){
                                    window.location.href = '/controlpanel/modifyInfo?1'
                                } else if (url == 'en_US') {
                                    window.location.href = "main?lang=en_US";
                                } else if (url == 'zh_tw') {
                                    window.location.href = "main?lang=zh_tw";
                                } else {
                                    window.location.href = "main";
                                }
                            } else {
                                lockded = false;
                                lockded1=false
                                $("#imgCode").attr('src', '/GetCodeImgServlet?' + Math.random())
                                if (res.code == 100040) {
                                    alert(res.msg);
                                    reg.msg = 0;
                                }
                                if (res.code == 100035) {
                                    past(res.code);
                                    return;
                                }
                                if (res.code == 100060) {
                                    window.location.href = "/defaultIndexErr?imageType=100060";
                                } else if (res.code == 100010) {
                                    alert("用户名或密码错误（错误代码：100010）");
                                } else if (res.code == 100040) {
                                    alert("登录失败，您的账号已被系统锁定，请1分钟后重试（错误代码：100040）");
                                } else if (res.code == 100050) {
                                    alert("登录失败，用户禁止登录（错误代码：100050）")
                                } else {
                                    alert("用户名或密码错误（错误代码：100010）");
                                }
                            }
                        }
                    })
                }



            } else {
                //var checkCode = document.getElementById("checkCode").value;
                var inputCode = document.getElementById("graphic").value;
                if (inputCode.length == 0) {
                    alert("请输入验证码！");
                    return;
                } else if (inputCode.length == 4) {
                    var data = {
                        userAgent: 'pcc',
                        loginId: loginId,
                        username: encryptor.encrypt($('#user').val()),
                        password: encryptor.encrypt($('#password').val()),
                        graphic: $('#graphic').val(),
                        locales: url
                    }
                    if (!lockded) {
                        lockded = true;
                        $.ajax({
                            type: 'post',
                            url: 'login',
                            dataType: 'json',
                            data: data,
                            success: function (res) {
                                if (res.flag == true) {
                                    var loginCokie = res.object;
                                    loginCokie.language = $('#language').val().split('=')[1] || 'zh_CN';
                                    loginCokie.company = $('#departs').val();
                                    $.setCookie(res.object);
                                    //同步请求
                                    $.ajaxSettings.async = false;
                                    var bol = 0 ;
                                    $.get('/sysTasks/selectAll', function (datas) {
                                        var datas = datas.obj;
                                        for (var i = 0; i < datas.length; i++) {
                                            if (datas[i].paraName == 'SEC_INIT_PASS_SHOW' && datas[i].paraValue == 1 && $('#password').val() == "") {
                                                bol = 1;
                                            }
                                        }
                                    }, 'json')
                                    $.ajax({
                                        type: 'post',
                                        url: '/checkPass',
                                        dataType: 'json',
                                        data: {
                                            username:encryptor.encrypt($('#user').val()),
                                            password:encryptor.encrypt($('#password').val())
                                        },
                                        success: function (res) {
                                            if(res.flag){
                                                bol = 0;
                                            }else{
                                                bol = 1;
                                            }
                                        }
                                    })
                                    if(bol != 0){
                                        window.location.href = '/controlpanel/modifyInfo?1'
                                    } else if (url == 'en_US') {
                                        window.location.href = "main?lang=en_US";
                                    } else if (url == 'zh_tw') {
                                        window.location.href = "main?lang=zh_tw";
                                    } else {
                                        window.location.href = "main";
                                    }
                                } else {
                                    lockded = false;
                                    lockded1=false
                                    $("#imgCode").attr('src', '/GetCodeImgServlet?' + Math.random())
                                    if (res.code == 100040) {
                                        alert(res.msg);
                                        reg.msg = 0;
                                    }
                                    if (res.code == 100035) {
                                        past(res.code);
                                        return;
                                    }
                                    if (res.code == 100060) {
                                        window.location.href = "/defaultIndexErr?imageType=100060";
                                    } else if (res.code == 100010) {
                                        alert("用户名或密码错误（错误代码：100010）");
                                        return;
                                    } else if (res.code == 100020) {
                                        alert("您的验证码输入错误，请重新输入！（错误代码：100020）");
                                        return;
                                    } else if (res.code == 100040) {
                                        alert("登录失败，您的账号已被系统锁定，请1分钟后重试（错误代码：100040）");
                                        return;
                                    } else if (res.code = 100050) {
                                        alert("登录失败，用户禁止登录（错误代码：100050）")
                                        return;
                                    } else {
                                        alert("用户名或密码错误（错误代码：100010）");
                                        return;
                                    }
                                }
                            }
                        })
                    }

                } else {
                    alert("您的验证码输入格式错误，请重新输入");
//                    createCode(); //刷新验证码
                    $("#imgCode").attr('src', '/GetCodeImgServlet?' + Math.random())
                }
            }

        });
        layui.use(['form', 'layer','upload'], function() {
            var form = layui.form;
            // form.render('select');
            departmentAll()
            //部门列表请求方法
            function departmentAll() {
                $.ajax({
                    type: 'get',
                    url: 'getCompanyAll',
                    dataType: 'json',
                    data: {
                        locales:window.location.href.split('=')[1]
                    },
                    success: function (res) {
                        var data = res.obj;
                        var str = '';
                        for (var i = 0; i < data.length; i++) {
                            str += '<option value="' + data[i].oid + '">' + data[i].name + '</option>';
                            // str += '<option value="' + data[i].oid + '">' + data[i].name + '</option>';
                        }
                        if (data.length == 1) {
                            $('select[name="departs"]').append(str);
                            $(".txt").eq(0).hide();
                            $('.mainCon .entry').css("height", "350px")
                        } else {
                            $('select[name="departs"]').append(str);
                            if ($.cookie('historyCompany') != null) {
                                $('select[name="departs"]').val($.cookie('historyCompany'));
                            }
                            if (location.href.indexOf('.yun-he.cn') > -1) {
                                $('#departs').append('<option value="'+ location.href.split('.yun-he.cn')[0].split('//')[1] +'"></option>');
                                $(".txt").eq(0).hide();
                            } else if (location.href.indexOf('oa.8oa.cn') > -1) {
                                $('#departs').append('<option value="1002"></option>');
                                $(".txt").eq(0).hide();
                            }
                            // $('.mainCon .entry').css("height", "350px")
                        }
                        form.render('select');
                        //判断是否开启验证码
                        if (res.code == 1) {
                            $('#SecGraphic').show()
                            $('.mainCon .entry').css("height", "465px")
                            $('#imgCode').attr('src','/GetCodeImgServlet?'+Math.random())
                            isa = 1
                        } else {
                            $('#SecGraphic').hide()
                            isa = 0
                        }
                        $('body').show();
                    }
                })
            }

        })



    })
</script>
<script  src="/js/login/showPassword.js?20230418.1"></script>
</body>
</html>

