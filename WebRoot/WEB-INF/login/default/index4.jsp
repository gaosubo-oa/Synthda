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

    <link rel="stylesheet" type="text/css" href="/css/default/theme4/loginInterface.css"/>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
<%--    <!--[if IE 8]>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <![endif]-->--%>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js"></script>
    <script charset="utf-8" src="/js/login/scanLogin.js?20220320"></script>
    <script src="/js/login/login.js?20230306.1"></script>
    <script charset="utf-8" src="/js/login/jsencrypt.js?20210429.3"></script>
    <!--index2-->
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
<div class="form1">
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
                <select id="language" name="language" style="width: 70px;height: 23px;margin-right: 30px;">
                    <option value="?lang=zh_CN">中文</option>
                    <option value="?lang=en_US" selected="selected">English</option>
                    <option value="?lang=zh_tw">繁体</option>
                </select>
                <span class="icon">
								<a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
									<img src="/img/default/theme4/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                <div class="posit" id="android">
							<span class="iconT">
								<img src="/img/default/theme4/Android.png?20210113.1" title='<fmt:message code="global.th.downloadTheAndroidClient" />'/>
							</span>
                    <div class="QRCode codeT" style="display: none;">
                        <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="/img/default/sy07.png?${versionAndroid}"/>
                    </div>
                </div>
                <div class="posit" id="iphone">
							<span class="iconH">
								<img src="/img/default/theme4/Apple.png" title='<fmt:message code="global.th.downloadTheIPhoneClient" />'/>
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
                            <img src="/img/default/theme4/loginlogo.png" alt="">
                        </div>
                    </div>
                    <div class="mainMiddle"></div>
                    <div class="mainRight">
                        <div style="position: absolute;top: -52px;right: -28px;" title="扫码登录" class="scanLogin">
                            <img src="/img/default/theme17/scan.png" style="width: 24px;cursor:pointer;"/>
                        </div>
                        <div class="txt">
                            <div class="imgDiv">
                                <img src="/img/default/theme4/icon_organination_2.png"/>
                            </div>
                            <select name="departs" id="departs">
                                <%--<option value="0">总部</option>
                                <option value="1">北京分公司</option>--%>
                            </select>
                        </div>
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
                            <input type="password" name="password" autocomplete="off" id="password" placeholder="<fmt:message code="global.lang.password" />"/>
                            <div style="color:red;padding:2px; position:absolute; display:none;font-size: 13px;padding-left: 45px;" id="capital">大写锁定已开启</div>
                        </div>
                        <div class="resetPsword">
                            <span autocomplete="off" style="color: rgb(82, 174, 251); float:right; display: inline-block;font-size: 10px;margin-top: 6px;"><fmt:message code="global.lang.forgetPW"/></span>
                        </div>
                        <div id="SecGraphic" class="txt" style="display: none;margin-top: 22px;height: 30px;position: relative;">
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
<div id="beianhao" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
    <p style="text-align: center;margin-bottom: 5px">
        <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;" href="http://www.beian.miit.gov.cn"></a>
    </p>
    <p style="text-align: center;">
        <label style="color: #399be0">网站备案号：</label>
        <span class="ptwo" style="margin: 0 auto;height: 19px;color: #399be0;"></span>
    </p>
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
        window.location.href = '/resetPsword?type=2'
    })
    /*   function createCode() {
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
        $('.mainCon').height($(document).height() - $('.header').height());
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
        // $('#pcdownload').prop('href', pcDownLoad)
        autodivheight()
        window.onresize = function () {
            throttle(autodivheight)
        };

        var isa = 0;
        // 高度设置
        $.get('/sys/getInterfaceParam', {params:"loginLiterals,fileNumber,loginValidation"},function (json) {
            if (json.flag) {
                if (json.obj.loginLiterals != '') {
                    $('.mainLefttext').text(json.obj.loginLiterals)
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
                if(json.obj.QRCODE_LOGIN_SET == '0' ||  json.obj.IS_USE_APP == 1 ){
                    $('.scanLogin').css('display','none')
                }else{
                    $('.scanLogin').css('display','block')
                }
            }
        }, 'json')
        // 查询是否开启黑色主题
        getBlackTheme()
        //部门列表
        departmentAll()
        //登录按钮三种状态
        $('.loginBtn').on('mouseover', function () {
            $(this).css('background', 'url(/img/default/theme4/loginAfter.png) no-repeat');
        })
        $('.loginBtn').on('click', function () {
            $(this).css('background', 'url(/img/default/theme4/loginClick.png) no-repeat');
        })
        $('.loginBtn').on('mouseout', function () {
            $(this).css('background', 'url(/img/default/theme4/loginback.png) no-repeat');
        })
        //右侧图标点击扫码下载

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
            /* if (pwd.length>0){
                 var pwd = encryptPadding(pwd);
             }*/
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
                                lockded1= false
                                // 验证码刷新
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
                                    lockded1= false
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
                        str += '<option value="' + data[i].oid + '" isOrg="' + data[i].isOrg + '" >' + data[i].name + '</option>';
                    }
                    if (data.length == 1) {
                        $('select[name="departs"]').append(str);
                        $(".txt").eq(0).hide();
                        $('.entry ').css("height", "290px")
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
                        $('#imgCode').attr('src','/GetCodeImgServlet?'+Math.random())
                        $('#SecGraphic').show()
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
</script>
<script  src="/js/login/showPassword.js?20230418.1"></script>
</body>
</html>
