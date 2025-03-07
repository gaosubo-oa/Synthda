
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
    <title>登录界面模板预览</title>
    <%--    <meta name="renderer" content="webkit">--%>
    <meta name="renderer" content="ie-stand">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">

    <link rel="stylesheet" type="text/css" href="/css/default/theme1/loginInterface.css"/>
    <link rel="stylesheet" type="text/css" href="/css/sys/loginMouldPreview.css?20220117"/>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <!--[if IE 8]>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <![endif]-->
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/js/login/login.js?20200710.1"></script>
    <script charset="utf-8" src="/js/login/jsencrypt.js?20210429.3"></script>
    <!--index2-->
    <style>
        .experience {
            position: fixed;
            width: 250px;
            padding: 10px 5px;
            top: 110px;
            left: 10px;
            color: #fff;
            z-index: 99999;
            border-radius: 4px;
            font-size: 12px;
            display: none;
        }

        .experience p {
            line-height: 24px;
        }

        img[src=""] {
            opacity: 0;
            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
        }

        .header .logo img {
            width: auto;
        }
    </style>
</head>
<body>
<div class="mouldOne" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme1/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="android">
							<span class="iconT">
								<img src="/img/default/theme1/Android.png?20210113.1"
                                     title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme1/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center">心通达测试云平台</span>
                            <div class="desktop">
                                <img src="/img/default/theme1/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
<%--                            <div class="txt">--%>
<%--                                <div class="imgDiv">--%>
<%--                                    <img src="/img/default/theme1/icon_organination_2.png"/>--%>
<%--                                </div>--%>
<%--                                <select name="departs" id="departs">--%>
<%--                                </select>--%>
<%--                            </div>--%>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme1/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user"  placeholder="<fmt:message code="global.lang.user" />"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme1/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" placeholder="<fmt:message code="global.lang.password" />"/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div id="SecGraphic" class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme1/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>
                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="beianhao" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldTwo" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme2/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" >
							<span class="iconT">
								<img src="/img/default/theme2/Android.png?20210113.1" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" >
							<span class="iconH">
								<img src="/img/default/theme2/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center">心通达测试云平台</span>
                            <div class="desktop">
                                <img src="/img/default/theme2/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
<%--                            <div class="txt">--%>
<%--                                <div class="imgDiv">--%>
<%--                                    <img src="/img/default/theme2/icon_organination_2.png"/>--%>
<%--                                </div>--%>
<%--                                <select name="departs" id="departs">--%>
<%--                                    &lt;%&ndash;<option value="0">总部</option>--%>
<%--                                    <option value="1">北京分公司</option>&ndash;%&gt;--%>
<%--                                </select>--%>
<%--                            </div>--%>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme2/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user" id="user"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme2/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" />
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div  class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme2/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>

                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldThree" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a  href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme3/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit">
							<span class="iconT">
								<img src="/img/default/theme3/Android.png?20210113.1" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit">
							<span class="iconH">
								<img src="/img/default/theme3/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center">心通达测试云平台</span>
                            <div class="desktop">
                                <img src="/img/default/theme3/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme3/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user" placeholder="<fmt:message code="global.lang.user" />"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme3/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" placeholder="<fmt:message code="global.lang.password" />"/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme3/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>

                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldFour" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a  href="/file/pc/ispiritXOASetup.exe"><img src="/img/default/theme4/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" >
							<span class="iconT">
								<img src="/img/default/theme4/Android.png?20210113.1" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" >
							<span class="iconH">
								<img src="/img/default/theme4/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center">心通达测试云平台</span>
                            <div class="desktop">
                                <img src="/img/default/theme4/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme4/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user" id="user" placeholder="<fmt:message code="global.lang.user" />"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme4/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" id="password"
                                       placeholder="<fmt:message code="global.lang.password" />"/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div  class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme4/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>

                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldFive" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a  href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme5/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit">
							<span class="iconT">
								<img src="/img/default/theme5/Android.png?20210113.1" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit">
							<span class="iconH">
								<img src="/img/default/theme5/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center">心通达测试云平台</span>
                            <div class="desktop">
                                <img src="/img/default/theme5/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme5/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user" id="user" placeholder="<fmt:message code="global.lang.user" />"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme5/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" id="password" placeholder="<fmt:message code="global.lang.password" />"/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div  class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme5/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>

                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldSix" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme6/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme6/Android.png?20210113.1"
                                     title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="">
							<span class="iconH">
								<img src="/img/default/theme6/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center">心通达测试云平台</span>
                            <div class="desktop">
                                <img src="/img/default/theme6/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme6/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user" id="user"
                                       placeholder="<fmt:message code="global.lang.user" />"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme6/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" id="password"
                                       placeholder="<fmt:message code="global.lang.password" />"/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div id="" class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme6/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>

                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldSeven" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme7/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme7/Android.png?20210113.1"
                                     title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="">
							<span class="iconH">
								<img src="/img/default/theme7/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center">心通达测试云平台</span>
                            <div class="desktop">
                                <img src="/img/default/theme7/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme7/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user" placeholder="<fmt:message code="global.lang.user" />"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme7/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" placeholder="<fmt:message code="global.lang.password" />"/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div id="" class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme7/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>

                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldEight" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme8/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme8/Android.png?20210113.1" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="">
							<span class="iconH">
								<img src="/img/default/theme8/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center">心通达测试云平台</span>
                            <div class="desktop">
                                <img src="/img/default/theme8/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme8/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user" id="user" placeholder="<fmt:message code="global.lang.user" />"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme8/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" id="password" placeholder="<fmt:message code="global.lang.password" />"/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div id="" class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme8/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>

                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldNine" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme9/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
                </span>
                    <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme9/Android.png?20210113.1" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="">
							<span class="iconH">
								<img src="/img/default/theme9/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft">
                            <span class="mainLefttext" style="text-align: center"></span>
                            <div class="desktop">
                                <img src="/img/default/theme9/loginlogo.png" alt="">
                            </div>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight">
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme9/icon_user_2.png"/>
                                </div>
                                <input type="text" name="user" id="user"
                                       placeholder="<fmt:message code="global.lang.user" />"/>
                            </div>
                            <div class="txt">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme9/icon_password_2.png"/>
                                </div>
                                <input type="password" name="password" autocomplete="off" id="password" placeholder="<fmt:message code="global.lang.password" />"/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div id="" class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                <div class="imgDiv">
                                    <img class="img" src="/img/default/theme9/icon_graphic_2.png"/>
                                </div>
                                <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                            </div>

                            <div class="loginBtn">
                                <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldTen" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme10/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme10/Android.png"
                                     title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme10/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="title">
                    <span class="titleTxt" style="text-shadow: -1px -1px 0 #fff, 1px 1px 0px rgba(50, 94, 175, 0.71), 1px 1px 0 rgba(35, 82, 152, 0.89);letter-spacing: 2px;">心通达测试云平台</span>
                </div>
                <div class="entry">
                    <div class="entryTwo" style="position: absolute;top: 64px;left: 100px;">
                        <div class="txt">
                            <img class="img" src="/img/default/theme10/icon_user.png"/>
                            <span class="spanColor" style="margin-left: 3px;color: #FFFFFF;
                        margin-right: -4px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message code="journal.th.user"/></span>
                            <input type="text" name="user" id="user" value=""/>
                        </div>
                        <div class="txt">
                            <img class="img" src="/img/default/theme10/icon_password.png"/>
                            <span class="spanColor" autocomplete="off" style="margin-left: 5px;color: #FFFFFF;
                        margin-right: -4px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message code="passWord"/></span>
                            <input type="password" name="password" id="password" value="" autocomplete="off"/>
                        </div>
                        <div class="resetPsword">
                            <span autocomplete="off" style="color: #f1ece6; float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                        </div>
<%--                        <div id="SecGraphic" class="txt" style="margin-top: 22px;height: 30px;position: relative;">--%>
<%--                            <img class="img" src="/img/default/theme10/icon_graphic.png"/>--%>
<%--                            <span class="spanColor"--%>
<%--                                  style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message--%>
<%--                                    code="graphic"/></span>--%>
<%--                            <input type="text" id="graphic" style="width: 155px;margin-left: 16px;margin-top: 5px;" placeholder="请输入图中验证码"/>--%>
<%--                            &lt;%&ndash;                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>&ndash;%&gt;--%>
<%--                            <img src="" alt=""   style="position: absolute;top: 5px;right: -8px;"--%>
<%--                                 onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">--%>
<%--                        </div>--%>
                        <div class="loginBtn" style="margin-top: 25px;width: 122px;height: 38px; margin: 27px auto; background: url(/img/default/theme10/loginback.png) no-repeat;background-size: 100% 100%; color: #FFFFFF;line-height: 38px;font-size: 18px;cursor: pointer;">
                            <span style="margin-left: 52px;"><fmt:message code="global.lang.login"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldEleven" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language" />：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme11/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme11/Android.png" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="">
							<span class="iconH">
								<img src="/img/default/theme11/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="title">
                    <span class="titleTxt" style="text-shadow: -1px -1px 0 #fff, 1px 1px 0px rgba(50, 94, 175, 0.71), 1px 1px 0 rgba(35, 82, 152, 0.89);letter-spacing: 2px;">心通达测试云平台</span>
                </div>
                <div class="entry">
                    <div class="entryTwo" style="position: absolute; top: 8px;left: 20px;width: 406px;">
                        <div class="txt">
                            <img class="img" src="/img/default/theme11/icon_user.png"/>
                            <input type="text" name="user" placeholder="账号" value=""/>
                        </div>
                        <div class="txt">
                            <img class="img" src="/img/default/theme11/icon_password.png"/>
                            <input type="password" autocomplete="off" name="password"  placeholder="密码" value=""/>
                        </div>
                        <div class="resetPsword">
                            <span autocomplete="off" style="color: #f9f7f6; float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                        </div>
                        <div class="loginBtn" style="margin: 30px 0px;width: 100%;height: 47px;margin: 23px 0px;background: url(/img/default/theme11/loginback.png) no-repeat; background-size: 100% 100%; color: #FFFFFF;line-height: 47px;font-size: 18px; cursor: pointer; text-align: center;">
                            <span style="">登&nbsp;&nbsp;&nbsp;录</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldTwelve" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang" style="font-size: 16px;color: #9b5d3d;"><fmt:message code="language"/>：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;border-color: #9b5d3d;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a  href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme12/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" >
							<span class="iconT">
								<img src="/img/default/theme12/Android.png" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" >
							<span class="iconH">
								<img src="/img/default/theme12/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="title">
                    <span class="titleTxt" style="color: #9b5d3d;letter-spacing: 2px;">心通达测试云平台</span>
                </div>
                <div class="entry">
                    <div class="entryTwo">
                        <div class="txt">
                            <img class="img" src="/img/default/theme12/icon_user.png"/>
                            <span class="spanColor" style="margin-left: 3px;color: #9b5d3d!important;margin-right: 10px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message code="journal.th.user"/></span>
                            <input type="text" name="user" id="user" value=""/>
                        </div>
                        <div class="txt">
                            <img class="img" src="/img/default/theme12/icon_password.png"/>
                            <span class="spanColor" style="margin-left: 5px;color: #9b5d3d!important;margin-right: 10px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message code="passWord"/></span>
                            <input type="password" autocomplete="off" name="password" id="password" value=""/>
                        </div>
                        <div class="resetPsword">
                            <span autocomplete="off" style="color: #9b5d3d; float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                        </div>
                        <div class="loginBtn" style="text-align: center;margin-left: 110px;margin-top: 22px;">
                            <span style="margin-left: 33px;"><fmt:message code="global.lang.login"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px;">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldThirteen" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang" style="font-size: 16px;color: red;"><fmt:message code="language"/>：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;border-color: red;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme13/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme13/Android.png" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme13/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="title">
                    <span class="titleTxt" style="color: #e7db24;letter-spacing: 2px;">心通达测试云平台</span>
                </div>
                <div class="entry">
                    <div class="entryTwo" style="    position: absolute;top: 64px;left: 100px;">
                        <div class="txt">
                            <img class="img" src="/img/default/theme13/icon_user.png"/>
                            <span class="spanColor" style="margin-left: 3px;color: #FFFFFF;margin-right: -13px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message code="journal.th.user"/></span>
                            <input type="text" style="margin-left: 2px;" name="user" id="user" value=""/>
                        </div>
                        <div class="txt">
                            <img class="img" src="/img/default/theme13/icon_password.png"/>
                            <span class="spanColor" style="margin-left: 5px;color: #FFFFFF;margin-right: -11px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message code="passWord"/></span>
                            <input type="password" autocomplete="off" name="password" id="password" value="" autocomplete="off"/>
                        </div>
                        <div class="resetPsword">
                            <span autocomplete="off" style="color: red; float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                        </div>
<%--                        <div id="SecGraphic" class="txt" style="margin-top: 22px;height: 30px;position: relative;">--%>
<%--                            <img class="img" src="/img/default/theme13/icon_graphic.png"/>--%>
<%--                            <span class="spanColor"--%>
<%--                                  style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message--%>
<%--                                    code="graphic"/></span>--%>
<%--                            <input type="text" id="graphic" style="width: 155px;margin-left: 11px;margin-top: 5px;" placeholder="请输入图中验证码"/>--%>
<%--                            &lt;%&ndash;                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>&ndash;%&gt;--%>
<%--                            <img src="" alt=""   style="position: absolute;top: 5px;right: -11px;"--%>
<%--                                 onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">--%>
<%--                        </div>--%>
                        <div class="loginBtn" style="margin-left:93px;margin-top: 22px;">
                            <span style="margin-left: 91px;"><fmt:message code="global.lang.login"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldFourteen" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <span class="banLang" style="font-size: 16px;color: red;"><fmt:message code="language"/>：</span>
                    <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;border-color: red;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme14/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme14/Android.png" title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="../img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="">
							<span class="iconH">
								<img src="/img/default/theme14/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="title">
                    <span class="titleTxt" style="color: #d73c3d;letter-spacing: 2px;">心通达测试云平台</span>
                </div>
                <div class="entry">
                    <div class="entryTwo" style="top: 55px;position: absolute;left: 100px;">
                        <div class="txt">
                            <img class="img" src="/img/default/theme14/icon_user.png"/>
                            <span class="spanColor" style="vertical-align:middle;margin-left: 3px;color: #FFFFFF;margin-right: -4px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message code="journal.th.user"/></span>
                            <input type="text" style="margin-left:1px;" name="user" id="user" value=""/>
                        </div>
                        <div class="txt">
                            <img class="img" style="margin-left: 2px;" src="/img/default/theme14/icon_password.png"/>
                            <span class="spanColor" style="vertical-align:middle;margin-left: 5px;color: #FFFFFF;margin-right: -12px;letter-spacing: 5px;display: inline-block;width: 60px;"><fmt:message code="passWord"/></span>
                            <input type="password" autocomplete="off" style="margin-left:8px;" name="password"  value=""/>
                        </div>
                        <div class="resetPsword">
                            <span autocomplete="off" style="color: red; float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                        </div>
<%--                        <div id="SecGraphic" class="txt" style="margin-top: 22px;height: 30px;position: relative;">--%>
<%--                            <img class="img" src="/img/default/theme14/icon_graphic.png"/>--%>
<%--                            <span class="spanColor"--%>
<%--                                  style="color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message--%>
<%--                                    code="graphic"/></span>--%>
<%--                            <input type="text" id="graphic" style="width: 155px;margin-left: 16px;margin-top: 5px;" placeholder="请输入图中验证码"/>--%>
<%--                            &lt;%&ndash;                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>&ndash;%&gt;--%>
<%--                            <img src="" alt=""   style="position: absolute;top: 5px;right: -11px;"--%>
<%--                                 onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">--%>
<%--                        </div>--%>
                        <div class="loginBtn" style="margin-left:105px;margin-top: 30px;">
                            <span style="margin-left: 73px;">登 录</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldFifteen" style="display: none">

    <div class="content">
        <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
            提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
        </div>
        <div class="header clearfix">
            <div class="logo">
                <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>
            </div>
            <div class="banRight">
                <span class="banLang" style="font-size: 16px;color: red;"><fmt:message code="language"/>：</span>
                <select id="" name="language" style="width: 60px;height: 23px;margin-right: 30px;border-color: red;">
                    <option value="?lang=zh_CN" >中文</option>
                    <option value="?lang=en_US" selected="selected">English</option>
                    <option value="?lang=zh_tw">繁体</option>
                </select>
                <span class="icon">
								<a id="" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme13/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                <div class="posit" id="">
							<span class="iconT">
								<img src="/img/default/theme13/Android.png" title='<fmt:message code="main.th.Android" />'/>
							</span>
                    <div class="QRCode codeT" style="display: none;">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                    </div>
                </div>
                <div class="posit" id="">
							<span class="iconH">
								<img src="/img/default/theme13/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                    <div class="QRCode codeH" style="display: none;">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="mainCon">
            <div class="title">
                <span class="titleTxt" style="color: #d73c3d;letter-spacing: 2px;">心通达测试云平台</span>
            </div>

            <div class="entry">
                <div class="entryTwo" style="top: 55px;width: 60%;position: absolute;left: 94px;">
                    <div id="changeWay" style="width: 100%;height: 60px;margin-top: -20px;border-bottom: 1px solid #eee;;font-size: 14px;display: flex;justify-content: space-around;">
                        <div id="numSpan" style="display: inline-block; width: auto;float: left;color: #666;cursor: pointer;">
                            <span class=" waySpan selectedSpan">账号登录</span>
                        </div>
                        <div id="changeWay-split" style="background: #eee;margin-top: 0;height: 20px;width: 1px;float: left;"></div>
                        <div id="imgSpan" style="display: inline-block;width: auto;float: left;color: #666;cursor: pointer;"><span class="waySpan1 resetPsword">忘记密码</span></div>
                    </div>
<%--                    <div class="txt input-wrap name">--%>
<%--                        <i for="name">--%>
<%--                            <img src="/img/default/theme14/icon_depart.png" style="position: relative;top: 4px">--%>
<%--                        </i>--%>
<%--                        <span class="split" style="display: none"></span>--%>

<%--                        <form class="layui-form" action="" style="margin-top: -23px;margin-left: 35px;">--%>
<%--                            <div class="layui-inline">--%>
<%--                                <div class="layui-input-inline">--%>
<%--                                    <select  name="departs" style=" appearance:none; width: 200px;height: 31px; border-radius: 5px;padding-left: 10px;display: none;">--%>
<%--                                        <option>心通达测试环境</option>--%>
<%--                                    </select>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </form>--%>
<%--                    </div>--%>
                    <div class="input-wrap name">
                        <i for="name">
                            <img src="/img/default/theme14/icon_user.png " style="position: relative;top: 4px">
                        </i>
                        <span class="split"></span>
                        <input type="text" style="border: 1px solid #eee;" name="UNAME" maxlength="20" autocomplete="off" onmouseover="this.focus()" onfocus="this.select()" value="" placeholder="用户">
                    </div>
                    <div class="input-wrap password">
                        <i for="password">
                            <img src="/img/default/theme14/icon_password.png" style="position: relative;top: 4px">
                        </i>
                        <span class="split"></span>
                        <input type="password" id="" name="PASSWORD" autocomplete="new-password" onmouseover="this.focus()" onfocus="this.select()" maxlength="200" value="" placeholder="密码">
                    </div>
<%--                    <div id="SecGraphic" class="txt" style="margin-top: 22px;height: 30px;position: relative;">--%>

<%--                        <div class="input-wrap password">--%>
<%--                            <i for="password">--%>
<%--                                <img src="/img/default/theme14/icon_graphic.png" style="position: relative;top: 4px">--%>
<%--                            </i>--%>
<%--                            <span class="split"></span>--%>
<%--                            <input type="text" id="graphic" name="PASSWORD" autocomplete="new-password" onmouseover="this.focus()" onfocus="this.select()" maxlength="200" value="" placeholder="验证码">--%>
<%--                            <img src="" alt=""   style="position: absolute;top: 5px;right: -11px;"  onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">--%>
<%--                        </div>--%>
<%--                    </div>--%>
                    <div class="loginBtn" style="margin-left:66px;margin-top: 30px;">
                        <span style="margin-left: 70px;">登 录</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldSixteen" style="display: none">
    <form name="form1">
        <div class="content" style="background: url(/img/default/theme16/background.png) no-repeat;background-size: 100% 100%;">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <%--            <div class="logo">--%>
                <%--                <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>--%>
                <%--            </div>--%>
                <div class="banRight">
                    <%--                <img src="/img/default/theme16/language.png">--%>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme16/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="android">
							<span class="iconT">
								<img src="/img/default/theme16/Android.png"
                                     title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme16/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon" style="background: none">

                <div class="entry" style="background: url(/img/default/theme16/loginBackgroundbox.png) no-repeat;height: 470px" >
                    <img src="/img/default/theme16/scan.png" id="scanBtn" style="float:right;margin-right: 10px;margin-top: 10px;" onclick="creatCode()">
                    <img src="/img/default/theme16/return.png" id="returnBtn" style="float:right;margin-right: 10px;margin-top: 10px;display: none" onclick="returnFun()">
                    <div class="entryTwo" style="left: 100px;">
                        <div style="text-align: center;margin-top: 60px;">
                            <img src="/img/default/theme16/icon_logo.png"/>
                            <%--                        <span class="titleTxt"></span>--%>
                        </div>
                        <div style="text-align: center;font-size: 17px;margin-top: 15px;">
                            <span class="titleTxt" style="color: #cccbcb;">心通达测试云平台</span>
                        </div>
                        <div class="loginPart">
                            <div class="txt" style="display: none">
                                <select id="departs" name="departs">
                                </select>
                            </div>
                            <div class="txt">
                                <img class="img" src="/img/default/theme16/icon_user.png"/>
                                <input type="text" name="user" id="user" placeholder="登录名" value=""/>
                            </div>
                            <div class="txt">
                                <img class="img" src="/img/default/theme16/icon_password.png"/>
                                <input type="password" autocomplete="off" name="password" id="password" placeholder="密码"
                                       value=""/>
                            </div>
                            <div class="resetPsword">
                                <span autocomplete="off" style="color: #f9f7f6; float:right; display: inline-block;font-size: 10px;margin-top: 6px;">忘记密码？</span>
                            </div>
                            <div class="loginBtn" style="margin: 30px 0px;">
                                <span style="">登&nbsp;&nbsp;&nbsp;录</span>
                            </div>
                        </div>
                        <div class="scanPart" style="display: none">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div id="beianhao" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
        <p style="text-align: center;margin-bottom: 5px">
            <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
               href="http://www.beian.miit.gov.cn"></a>
        </p>
        <p style="text-align: center;">
            <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
        </p>
    </div>
</div>
<div class="mouldSeventeen" style="display: none">
    <form name="form1">
        <div class="content" style="background: url(/img/default/theme17/background_r.png) no-repeat;background-position: right;">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <%--            <div class="logo">--%>
                <%--                <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>--%>
                <%--            </div>--%>
                <div style="margin-top: 20px;display: inline-block;">
                    <img src="/img/default/theme17/icon_logo.png"/>
                </div>
                <div class="banRight">
                    <%--                <img src="/img/default/theme16/language.png">--%>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme16/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="android">
							<span class="iconT">
								<img src="/img/default/theme16/Android.png"
                                     title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme16/Apple.png" title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon" style="background: none">

                <div class="entry" style="background: none" >
                    <div class="entryTwo">
                        <div style="font-size: 30px;margin-top: 15px;color: #7d7c7c;">
                            <span class="titleTxt">心通达测试云平台</span>
                        </div>
                        <div class="loginPart">
                            <div class="txt" style="display: none">
                                <select id="departs" name="departs">
                                    <%--<option value="0">总部</option>
                                    <option value="1">北京分公司</option>--%>
                                </select>
                            </div>
                            <div class="txt" style="margin-top: 40px;color: #7d7c7c;">
                                <span  style="display: block;">登录名</span>
                                <input type="text" name="user" id="user" placeholder="用户名" value=""/>
                            </div>
                            <div class="txt" style="margin-top: 20px;color: #7d7c7c;">
                                <span  style="display: block;">密码</span>
                                <input type="password" autocomplete="off" name="password" id="password" placeholder="密码" value=""/>
                            </div>
                            <div>
                                <img src="/img/default/theme17/scan.png" id="scanBtn" style="margin-top: 10px;" onclick="creatCode()">
                                <span class="resetPsword" autocomplete="off" style="color: #b52222; float:right; display: inline-block;font-size: 10px;margin-top: 20px;">忘记密码？</span>
                            </div>
                            <%--                        <div id="SecGraphic" class="txt" style="margin-top: 22px;height: 30px;position: relative;">--%>
                            <%--                            <img class="img" src="/img/default/theme16/icon_graphic.png" style="position: absolute;z-index: 2;top: 13px;width: 15px;left: 20px;"/>--%>
                            <%--                            <input type="text" id="graphic" style="width: 296px;margin-top: 5px;" placeholder="请输入图中验证码"/>--%>
                            <%--                            &lt;%&ndash;                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>&ndash;%&gt;--%>
                            <%--                            <img src="" alt="" style="position: absolute;top: 8px;right: -4px;"--%>
                            <%--                                 onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">--%>
                            <%--                        </div>--%>
                            <div class="loginBtn" style="margin: 30px 0px;">
                                <span style="">登&nbsp;&nbsp;&nbsp;录</span>
                            </div>
                        </div>
                        <div class="scanPart" style="">

                        </div>
                    </div>
                </div>
                <div style="position: absolute; bottom: 0px;">
                    <img src="/img/default/theme17/background_l.png" style="height: 150px">
                </div>
                <div style="margin-left: 55%;margin-top: -300px;position: relative;">
                    <img src="/img/default/theme17/icon_up.png" style="width: 400px;height: 270px;display: block">
                    <img src="/img/default/theme17/icon_down.png" style="width: 400px;height: 220px;margin-top: -10px;">
                    <span style="font-size: 24px;color: #b52222;position: absolute;top: 320px;left: 160px;">HI 您好!</span>
                    <span style="font-size: 24px;color: black;position: absolute;top: 370px;left: 80px;">欢迎登录智能办公平台</span>
                </div>
            </div>
        </div>
    </form>
</div>
<div class="mouldEighteen" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="/img/default/theme18/LogoImg.png" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <%--                <span class="banLang"><fmt:message code="language"/>：</span>--%>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme18/pc.png" title='<fmt:message code="main.th.pc" />' style="width: 24px"/>
								</a>
							</span>
                    <div class="posit" id="android">
							<span class="iconT">
								<img src="/img/default/theme18/Android.png?20210113.1" title='<fmt:message code="main.th.Android" />' style="width: 22px;"/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme18/Apple.png" title='<fmt:message code="main.th.iPhone" />' style="width: 22px"/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                                 src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft" style="margin-top: 0px">
                            <img src="/img/default/theme18/loginpanel.png" style="width: 350px;height: 400px"/>
                        </div>
                        <div class="mainRight" style="top: 0px">
                            <div style="float: right">
                                <img src="/img/default/theme18/qrCode.png" id="scanBtn" onclick="creatCode()"/>
                            </div>
                            <div class="imgDiv" style="text-align: center;margin-top: 70px;color: #0076fe;font-size: 24px;font-weight: 540;">
                                <%--                            <img src="/img/default/theme18/title.png" style="height: 25px;"/>--%>
                                <span class="titleTxt">心通达测试云平台</span>
                            </div>
                            <div class="loginPart">
                                <div class="txt" style="margin-top: 40px;">
                                    <img class="img" src="/img/default/theme18/icon_user_2.jpg"/>
                                    <input type="text" name="user" id="user" placeholder="请输入账号"/>
                                </div>
                                <div class="txt">
                                    <img class="img" src="/img/default/theme18/icon_password_2.jpg"/>
                                    <input type="password" name="password" autocomplete="off" id="password" placeholder="请输入密码"/>
                                    <div style="color:red;padding:2px; position:absolute; display:none;font-size: 13px;padding-left: 45px;" id="capital">大写锁定已开启</div>
                                </div>
                                <div class="resetPsword" style="position:relative;">
                                    <span autocomplete="off" style="color: #0076fe;float: right;display: inline-block;font-size: 10px;top: -30px;position: absolute;right: 20px;">忘记密码？</span>
                                </div>
                                <div id="SecGraphic" class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                    <div class="imgDiv">
                                        <img class="img" src="/img/default/theme1/icon_graphic_2.png"/>
                                    </div>
                                    <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                    <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                    <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                    <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                                </div>

                                <div class="loginBtn">
                                    <span><fmt:message code="global.lang.login"/></span>
                                </div>
                            </div>
                            <div class="scanPart" style="display: none">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="mouldNinteen" style="display: none">
    <div class="form1">
        <div class="content">
            <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
                提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
            </div>
            <div class="header clearfix">
                <div class="logo">
                    <img height="57" src="/img/default/theme19/LogoImg.png" onerror="imgerror2(this,1)"/>
                </div>
                <div class="banRight">
                    <%--                <span class="banLang"><fmt:message code="language"/>：</span>--%>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN">中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme19/pc.jpg" title='<fmt:message code="main.th.pc" />' style="width: 24px"/>
								</a>
							</span>
                    <div class="posit" id="android">
							<span class="iconT">
								<img src="/img/default/theme19/Android.jpg?20210113.1" title='<fmt:message code="main.th.Android" />' style="width: 22px"/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme19/Apple.png" title='<fmt:message code="main.th.iPhone" />' style="width: 22px"/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mainCon">
                <div class="entry">
                    <div class="bbc"></div>
                    <div class="entryBg">
                        <div class="mainLeft" style="margin-top: 0px">
                            <img src="/img/default/theme19/loginpanel.png" style="width: 350px;height: 400px"/>
                            <img src="/img/default/theme19/loginpanel4.png" style="position: absolute;top: 225px;left: 85px;width: 260px;"/>
                        </div>
                        <div class="mainMiddle"></div>
                        <div class="mainRight" style="top: 0px">
                            <div style="float: right">
                                <img src="/img/default/theme19/qrCode.png" id="scanBtn" onclick="creatCode()"/>
                            </div>
                            <div class="imgDiv" style="text-align: center;margin-top: 70px;color: #e81f1f;font-size: 24px;font-weight: 540;">
                                <span class="titleTxt">心通达测试云平台</span>
                            </div>
                            <div class="loginPart" >
                                <div class="txt" style="margin-top: 20px">
                                    <div class="imgDiv">
                                        <img class="img" src="/img/default/theme19/icon_user_2.jpg"/>
                                    </div>
                                    <input type="text" name="user" id="user" placeholder="请输入账号"/>
                                </div>
                                <div class="txt">
                                    <div class="imgDiv">
                                        <img class="img" src="/img/default/theme19/icon_password_2.jpg"/>
                                    </div>
                                    <input type="password" name="password" autocomplete="off" id="password" placeholder="请输入密码"/>
                                    <div style="color:red;padding:2px; position:absolute; display:none;font-size: 13px;padding-left: 45px;" id="capital">大写锁定已开启</div>
                                </div>
                                <div class="resetPsword" style="position: relative">
                                    <span autocomplete="off" style="color: #b8bed1;float: right;display: inline-block;font-size: 10px;top: -30px;position: absolute;right: 30px;">忘记密码</span>
                                </div>
                                <div id="SecGraphic" class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
                                    <div class="imgDiv">
                                        <img class="img" src="/img/default/theme19/icon_graphic_2.png"/>
                                    </div>
                                    <%--<span class="spanColor" style="margin-left: -5px;color: #FFFFFF;margin-right: -15px;letter-spacing: 5px;display: inline-block;width: 65px;"><fmt:message code="graphic"/></span>--%>
                                    <input type="text" id="graphic" style="width: 150px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                                    <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                                    <img src="" alt="" style="position: absolute;top: 6px;right: 1px;" onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                                </div>

                                <div class="loginBtn">
                                    <span><fmt:message code="global.lang.login"/></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
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
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    var selected = getQueryString("selected");
    if(selected == '1'){
        $('.mouldOne').css('display','block')
    }else if(selected == '2'){
        $('.mouldTwo').css('display','block')
    }else if(selected == '3'){
        $('.mouldThree').css('display','block')
    }else if(selected == '4'){
        $('.mouldFour').css('display','block')
    }else if(selected == '5'){
        $('.mouldFive').css('display','block')
    }else if(selected == '6'){
        $('.mouldSix').css('display','block')
    }else if(selected == '7'){
        $('.mouldSeven').css('display','block')
    }else if(selected == '8'){
        $('.mouldEight').css('display','block')
    }else if(selected == '9'){
        $('.mouldNine').css('display','block')
    }else if(selected == '10'){
        $('.mouldTen').css('display','block')
    }else if(selected == '11'){
        $('.mouldEleven').css('display','block')
    }else if(selected == '12'){
        $('.mouldTwelve').css('display','block')
    }else if(selected == '13'){
        $('.mouldThirteen').css('display','block')
    }else if(selected == '14'){
        $('.mouldFourteen').css('display','block')
    }else if(selected == '15'){
        $('.mouldFifteen').css('display','block')
    }else if(selected == '16'){
        $('.mouldSixteen').css('display','block')
    }else if(selected == '17'){
        $('.mouldSeventeen').css('display','block')
    }else if(selected == '18'){
        $('.mouldEighteen').css('display','block')
    }else if(selected == '19'){
        $('.mouldNinteen').css('display','block')
    }
    window.onload = function () {
        var inputtwo = document.getElementById('user');
        inputtwo.focus()
    }

    function autodivheight() {
        if(selected == '1' || selected == '1' || selected == '3' || selected == '4' || selected == '5' || selected == '6' || selected == '7' || selected == '8' || selected == '9'){
            $('.mainCon').height($(document).height() - $('.header').height());
        }else {
            $('.mainCon').height($(document).height() - $('.header').height() - 2);
        }
    }


    function throttle(method) {
        clearTimeout(method.tId);
        method.tId = setTimeout(function () {
            method.call();
        }, 100);
    }

    $(function () {
        autodivheight()
        window.onresize = function () {
            throttle(autodivheight)
        };

        var isa = 0;
        // 高度设置
        // $.get('/sys/getInterfaceParam', {params:"loginLiterals,fileNumber,loginValidation"},function (json) {
        //     if (json.flag) {
        //         if (json.obj.loginLiterals != '') {
        //             $('.mainLefttext').text(json.obj.loginLiterals)
        //         } else {
        //             $('.titleTxt').text("OA网络智能办公系统")
        //         }
        //         $('.pone').text(json.obj.fileNumber)
        //         document.title = json.obj.loginLiterals;
        //         if (json.obj.loginValidation == 0 || location.href.indexOf('oa.8oa.cn') > -1) {
        //             $('.experience').show();
        //         }
        //     }
        // }, 'json')


    })
</script>
</body>
</html>
