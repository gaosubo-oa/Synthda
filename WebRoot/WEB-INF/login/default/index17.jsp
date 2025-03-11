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
    <meta name="renderer" content="ie-stand">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="/css/default/theme17/loginInterface.css?20220317"/>
    <script src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
<%--    <!--[if IE 8]>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <![endif]-->--%>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js?20220320"></script>
    <script src="/js/login/login.js?20230306.1"></script>
    <script charset="utf-8" src="/js/login/scanLogin.js?20220309"></script>
    <script charset="utf-8" src="/js/login/jsencrypt.js?20210429.3"></script>
    <script src="/ui/js/qrcode.min.js"></script>
    <!--index17-->
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

        img[src=""] {
            opacity: 0;
            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0);
        }

        .header .logo img {
            width: auto;
        }
        .SecGraphic {
            float: right;
        }

        .code {
            font-family: Arial;
            font-style: italic;
            color: Red;
            border: 0;
            padding: 2px 3px;
            letter-spacing: 3px;
            font-weight: bolder;
        }

        .unchanged {
            border: 0;
        }
        input::-webkit-input-placeholder{
            color: #b52222;
        }
        input:-internal-autofill-previewed,
        input:-internal-autofill-selected {
            -webkit-text-fill-color: #b52222 !important;
            transition: background-color 5000s ease-in-out 0s !important;
            border: none;
            border-bottom: 1px solid white;
        }
        .mainCon .entry .entryTwo .txt input {
            height: 34px;
            line-height: 34px;
            width: 100%;
            margin: 5px 5px auto 0px;
            /*padding-left: 55px;*/
            font-size: 14px;
            width: 357px\9;
            background-color: rgba(0,0,0,0);
            border: none;
            border-bottom: 2px solid #b52222;
            box-shadow: none;
            outline: none;
            color: #b52222;
            border-radius: 0px;
        }
        .mainCon .entry .entryTwo .txt img.img {
            position: absolute;
            z-index: 2;
            top: 25px;
            width: 25px;
            left: 20px;
        }
        .mainCon .entry .entryTwo .loginBtn {
            width: 100%;
            height: 40px;
            margin: 20px 0px;
            color: #FFFFFF;
            line-height: 40px;
            font-size: 17px;
            cursor: pointer;
            text-align: center;
            background: none;
            background-color: #ca3b3b;
            border-radius: 10px;
        }
        .txt span{
            font-size: 15px;
        }
        #departs{
            height: 34px;
            width: 100%;
            border: none;
            margin: 20px 5px auto 0px;
            padding-left: 0px;
            font-size: 14px;
            background-color: transparent;
            color: #b52222;
            border-bottom: 2px solid #b52222;
            border-radius: 0px;
            margin-top: 30px;
            appearance:none;
            -moz-appearance:none;
            -webkit-appearance:none;
        }
        #departs::-ms-expand { display: none; }
        option{
            color: black;
        }
        select:focus{
            outline: none;
        }
        .disClick{
            pointer-events: none;
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
<form name="form1">
    <div class="content" style="background: url(/img/default/theme17/background_r.png) no-repeat;background-position: right;">
        <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
            提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
        </div>
        <div class="header clearfix" style="display: none;">
            <%--            <div class="logo">--%>
            <%--                <img height="57" src="LogoImg" onerror="imgerror2(this,1)"/>--%>
            <%--            </div>--%>
            <div style="margin-top: 20px;display: inline-block;margin-left: 30px;" >
                <img src="LogoImg" onerror="imgerror2(this,17)" style="width: 270px"/>
            </div>
            <div class="banRight">
                <div style="display: inline-block;position: absolute;top: 27px;right: 194px;">
                    <img src="/img/default/theme17/language.png" style="width: 22px;right: 91px;top: 2px;position: absolute;">
                    <select id="language" name="language" style="width: 70px;height: 23px;margin-right: 20px;border: none;color: white; background: none;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                </div>
                <span class="icon">
								<a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme16/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                <div class="posit" id="android">
							<span class="iconT">
								<img src="/img/default/theme16/Android.png"
                                     title='<fmt:message code="global.th.downloadTheAndroidClient" />'/>
							</span>
                    <div class="QRCode codeT" style="display: none;">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;"
                             src="/img/default/sy07.png?${versionAndroid}"/>
                    </div>
                </div>
                <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme16/Apple.png" title='<fmt:message code="global.th.downloadTheIPhoneClient" />'/>
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
                    <div style="font-size: 30px;margin-top: 15px;color: #807d7d;">
                        <span class="titleTxt"></span>
                    </div>
                    <div class="loginPart">
                        <div class="txt" >
                            <select id="departs" name="departs">
                                <%--<option value="0">总部</option>
                                <option value="1">北京分公司</option>--%>
                            </select>
                            <img src="/img/default/theme17/xiala.png" style="position: absolute;width: 14px;right: -3px;top: 38px;"/>
                        </div>
                        <div class="txt" style="margin-top: 20px;color: #7d7c7c;">
                            <span  style="display: block;"><fmt:message code="global.lang.user" /></span>
                            <input type="text" name="user" id="user" placeholder="<fmt:message code="global.lang.user" />" value=""/>
                        </div>
                        <div class="txt" style="margin-top: 20px;color: #7d7c7c;">
                            <span  style="display: block;"><fmt:message code="global.lang.password" /></span>
                            <input type="password" autocomplete="off" name="password" id="password" placeholder="<fmt:message code="global.lang.password" />" value=""/>
                        </div>
                        <div id="SecGraphic" class="txt" style="margin-top: 22px;height: 30px;position: relative;">
                            <img class="img" src="/img/default/theme16/icon_graphic.png" style="position: absolute;z-index: 2;top: 13px;width: 15px;left: 20px;"/>
                            <input type="text" id="graphic" style="width: 296px;margin-top: 5px;" placeholder="请输入图中验证码"/>
                            <%--                        <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                            <img src="" alt="" style="position: absolute;top: 8px;right: -4px;"
                                 onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                        </div>
                        <div style="margin-top: 25px;height: 22px">
                            <img src="/img/default/theme17/scan.png" id="scanBtn" style="width: 22px;cursor:pointer;" onclick="creatCode()">
                            <span class="resetPsword" autocomplete="off" style="color: #adacac; float:right; display: inline-block;font-size: 10px;padding-top: 3px;"><fmt:message code="global.lang.forgetPW"/></span>
                        </div>
                        <div class="loginBtn">
                            <span style=""><fmt:message code="global.lang.login"/></span>
                        </div>
                    </div>
                    <div class="scanPart" style="display: none;margin-top: 25px;">
                        <div style="width: 170px;margin: 0 auto;" class="twoCode"> <img class="scanUrl" src="" style="width: 100%"/></div>
                        <div class="shixiao" style="text-align: center;margin-top: -115px;font-size: 22px;display: none;margin-bottom: 45px;">
                            <span style="display: block">二维码已失效</span><span style="display: block">点击重新获取</span>
                        </div>
                        <img src="/img/default/theme17/return.png" id="returnBtn" style="margin-top: 10px;width: 20px;cursor:pointer;" onclick="returnFun()">
                       <div style="color: black;font-size: 12px;display: inline-block;margin-left: 8px;">可使用APP扫描二维码进行登录</div>
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
<div id="beianhao" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
    <p style="text-align: center;margin-bottom: 5px">
        <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
           href="http://www.beian.miit.gov.cn"></a>
    </p>
    <p style="text-align: center;">
        <label style="color: red">网站备案号：</label>
        <span class="ptwo" style="margin: 0 auto;height: 19px;color: black;"></span>
    </p>
</div>
<script>
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    var selected = getQueryString("selected");
    if(selected == '17'){
        $('.loginBtn').addClass('disClick')
    }
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
    //忘记密码功能
    $('.resetPsword').on('mouseover', function () {
        $(this).css('cursor', 'pointer');
    })
    $('.resetPsword').on('click', function () {
        window.location.href = '/resetPsword?type=4'
    })
    window.onload = function () {
        var inputtwo = document.getElementById('user');
        inputtwo.focus()
    }
    //生成二维码
    function creatCode() {
        $('.loginPart').css('display','none')
        $('.scanPart').css('display','block')
        $('#scanBtn').css('display','none')
        var selectPart = $('select[name="departs"] option:checked').val()
        getSecret(selectPart)
    }
    function returnFun() {
        $('.loginPart').css('display','block')
        $('.scanPart').css('display','none')
        $('#scanBtn').css('display','inline-block')
        clearInterval(timer);
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
        // createCode();
        autodivheight()
        window.onresize = function () {
            throttle(autodivheight)
        };
        var isa = 0;

        $.get('/sys/getInterfaceParam?params=loginLiterals,fileNumber,loginValidation', function (json) {
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
                if(json.obj.QRCODE_LOGIN_SET == '0' || json.obj.IS_USE_APP == 1){
                    $('#scanBtn').css('display','none')
                }else{
                    $('#scanBtn').css('display','inline-block')
                }
            }
        }, 'json')
        // 查询是否开启黑色主题
        getBlackTheme()
        departmentAll()

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
                    }
                    if (data.length == 1) {
                        $('select[name="departs"]').append(str);
                        $(".txt").eq(0).hide();
                        $(".txt").eq(1).css("margin-top", "40px")
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
                    }
                    //判断是否开启验证码
                    if (res.code == 1) {
                        $('.entryTwo').css('top','-30px')
                        $('#SecGraphic').show()
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
                // if($('#password').val() == ''){
                //     layer.msg('您当前密码为空，请尽快修改。')
                // }
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
                                var bol1 = 0 ;
                                $.get('/sysTasks/selectAll', function (datas) {
                                    var datas = datas.obj;
                                    for (var i = 0; i < datas.length; i++) {
                                        if (datas[i].paraName == 'SEC_INIT_PASS_SHOW' && datas[i].paraValue == 1 && $('#password').val() == "") {
                                            bol = 1;
                                        }
                                    }
                                    for (var a = 0; a < datas.length; a++) {
                                        if (datas[a].paraName == 'PASSWORD_NULL_TIPS' && datas[a].paraValue == 1 && $('#password').val() == "") {
                                            bol1 = 1;
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
                                if(bol1 != 0){
                                    // layer.msg('您的登录密码为空，存在风险，请尽快修改！',{time:6000})
                                    alert('您的登录密码为空，存在风险，请尽快修改！')
                                }
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
                                lockded = false;lockded1= false
                                $("#imgCode").attr('src', '/GetCodeImgServlet?' + Math.random())
                                if (res.code == 100040) {
                                    alert(res.msg);
                                    reg.msg == 0;
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
                var byName = $('#user').val();
                if (byName.length == 0) {
                    alert("请输入用户名！");
                    return;
                }
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
                                    lockded = false;lockded1= false
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


        })

    })
</script>
<script  src="/js/login/showPassword.js?20230418.1"></script>
</body>
</html>

