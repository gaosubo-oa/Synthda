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
    <link rel="stylesheet" type="text/css" href="../css/default/theme1/loginInterface.css"/>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js" type="text/javascript" charset="utf-8"></script>

    <script src="../js/jquery/jquery.cookie.js"></script>
    <%--<script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>--%>
    <%--<script type="text/javascript" src="/js/spirit/qwebchannel.js"></script>--%>
    <script src="/js/base/base.js"></script>
    <script src="/js/login/login.js"></script>
    <!--index-->
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
        .mainCon{
            background: url(/login/default/user/theme20/backgroundMainCon.png) no-repeat;
        }
        .header{
            position: fixed;
            top: 0px;
            background: transparent;
            z-index: 99999;
        }
        .mainCon .entry .entryTwo .txt input{
            border:1px solid #b61e06;
            border-radius: 0px;
        }
        .mainCon .entry .entryTwo .loginBtn{
            background: #b61e06;
            width:267px;
            text-align: center;
            margin-left: 65px;
        }
        .banLang {
            font-size: 16px;
            color: red;
        }
        #language {
            border-color: red;
        }
    </style>
</head>
<body>
<input type="hidden" name="typeName" value="theme1">
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
    <div class="content">
        <div class="tips" style="width:100%;background: orange;color: #fff;display: none">
            提示:您正在使用IE8浏览器，可能造成页面不兼容，建议升级IE11或360、UC等浏览器.
        </div>
        <div class="header clearfix">
            <%--<div class="logo">--%>
                <%--<img  height="57" src="/xs?${LogoImg}" onerror="imgerror2(this,1)"/>--%>
            <%--</div>--%>
                <div class="banRight">
                    <span class="banLang"><fmt:message code="language"/>：</span>
                    <select id="language" name="language" style="width: 60px;height: 23px;margin-right: 30px;">
                        <option value="?lang=zh_CN" >中文</option>
                        <option value="?lang=en_US" selected="selected">English</option>
                        <option value="?lang=zh_tw">繁体</option>
                    </select>
                    <span class="icon">
								<a id="pcdownload" href="/file/pc/ispiritXOASetup.exe">
									<img src="../img/default/theme2/pc.png" title='<fmt:message code="main.th.pc" />'/>
								</a>
							</span>
                    <div class="posit" id="android">
							<span class="iconT">
								<img src="../img/default/theme2/Android.png"
                                     title='<fmt:message code="main.th.Android" />'/>
							</span>
                        <div class="QRCode codeT" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="../img/default/sy07.png?${versionAndroid}"/>
                        </div>
                    </div>
                    <div class="posit" id="iphone">
							<span class="iconH">
								<img src="../img/default/theme2/Apple.png"
                                     title='<fmt:message code="main.th.iPhone" />'/>
							</span>
                        <div class="QRCode codeH" style="display: none;">
                            <img style="margin-left: 10px;margin-top: 10px;width: 166px;" src="../img/default/sy08.png?${versionIOS}"/>
                        </div>
                    </div>
                </div>

        </div>
        <div class="mainCon">
            <div class="title">
                 <div class="titleTxt">
                    <img class="img" src="/login/default/user/theme20/logo.png"/>
                </div>
                <span class="titleTxt">
                    <img class="img"  src="/login/default/user/theme20/logoText.png"/>
                </span>
            </div>
            <div class="entry">
                <div class="entryTwo">
                    <div class="txt">
                        <%--<img src="../img/default/theme1/icon_depart.png"/>--%>
                        <span class="spanColor" style="
                        margin-right: -4px;color: #b61e06;
                        letter-spacing: 5px;display: inline-block;width: 62px;"><fmt:message
                                code="global.lang.tissue"/></span>
                        <select id="departs" name="departs">

                        </select>
                    </div>
                    <div class="txt">
                        <%--<img class="img" src="../img/default/theme1/icon_user.png"/>--%>
                        <span class="spanColor" style="margin-left: 3px;color: #b61e06;
                        margin-right: -4px;letter-spacing: 5px;display: inline-block;width: 62px;font-size: 14pt;"><fmt:message
                                code="journal.th.user"/></span>
                        <input type="text" name="user" id="user" value=""/>
                    </div>
                    <div class="txt">
                        <%--<img class="img" src="../img/default/theme1/icon_password.png"/>--%>
                        <span class="spanColor" autocomplete="off" style="margin-left: 5px;color: #b61e06;
                        margin-right: -4px;letter-spacing: 5px;display: inline-block;width: 60px;font-size: 14pt;"><fmt:message
                                code="passWord"/></span>
                        <input type="password" name="password" id="password" value=""/>
                    </div>
                    <%--<div id="SecGraphic" class="txt">--%>
                    <%--<img class="img" src="../img/default/theme1/icon_graphic.png"/>--%>
                    <%--<span class="spanColor" autocomplete="off" style="margin-left: -5px;color: #FFFFFF;--%>
                    <%--margin-right: 0px;letter-spacing: 5px;display: inline-block;width: 65px;">--%>
                    <%--<fmt:message code="graphic"/></span>--%>
                    <%--<input type="text" id="graphic" style="width: 160px;" placeholder="请输入图中验证码"/>--%>
                    <%--<input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged"--%>
                    <%--style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                    <%--</div>--%>
                    <div class="loginBtn" style="margin-top: 20px;">
                        <span style="margin-left: 0px;font-size: 14pt;"><fmt:message code="global.lang.login"/></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<div id="beianhao" style="position: fixed;bottom: 0;left: 0;width: 100%;height: 50px;mso-font-src: 14px">
    <p style="text-align: center;margin-bottom: 5px">
        <a class="pone" target="_blank" style="color: #fff;text-decoration: none;height: 19px;"
           href="http://www.miitbeian.gov.cn"></a>
    </p>
    <p style="text-align: center;">
        <span class="ptwo" style="margin: 0 auto;height: 19px;color: #fff;"></span>
    </p>
</div>
<script type="text/javascript">
    <%--判断浏览器是ie8--%>
    var browser=navigator.appName
    var b_version=navigator.appVersion
    if(b_version.indexOf(';')>-1){
        var version=b_version.split(";");
        var trim_Version=version[1].replace(/[ ]/g,"");
        if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0")
        {
            $('.tips').show()
        }else{
            $('.tips').hide()
        }
    }

    function createCode() {
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
    }


    window.onload = function () {
        var inputtwo = document.getElementById('user');
        inputtwo.focus()
    }

    function autodivheight() {
        $('.mainCon').height($(document).height() -2);
    }
    function throttle(method) {
        clearTimeout(method.tId);
        method.tId = setTimeout(function () {
            method.call();
        }, 100);
    }
    $(function () {
        //首次加载验证码
        createCode();
        // $('#pcdownload').prop('href', pcDownLoad)
        // 高度设置
        autodivheight()
        window.onresize = function () {
            throttle(autodivheight)
        };


        var isa = 0;
        $.get('/sys/getInterfaceInfo', function (json) {
            if (json.flag) {
                if (json.object.attachment2.length != 0) {

//                    $('.header .logo img').attr('src', '/xs?' + json.object.attachment2[0].attUrl.replace('null', (function () {
//                            if ($.cookie('company') != '') {
//                                return $.cookie('company')
//                            } else {
//                                return '1001'
//                            }
//                        })()))

                } else {
//                    $('.header .logo img').attr('src', '/img/replaceImg/theme1/LOGO.png')
                }
                <%--if (json.object.loginLiterals != '') {--%>
                    <%--$('.titleTxt').text(json.object.loginLiterals)--%>

                <%--} else {--%>
                    <%--$('.titleTxt').text('<fmt:message code="xoa.th.title" />')--%>
                <%--}--%>
                //                $('.ptwo').text(json.object.fileNumber)
                $('.pone').text(json.object.fileNumber)
                document.title = json.object.loginLiterals;
                if (json.object.loginValidation == 0) {
                    $('.experience').show();
                }
//                if (json.obj1 == "0") {
//                    isa = 0;
//                    $('#SecGraphic').remove();
//                }
            }
        }, 'json')


        //部门列表
        departmentAll()
        //登录按钮三种状态
        // $('.loginBtn').mouseover(function () {
        //     $(this).css('background', 'url(../img/default/loginAfter.png) no-repeat');
        // })
        // $('.loginBtn').click(function () {
        //     $(this).css('background', 'url(../img/default/loginClick.png) no-repeat');
        // })
        // $('.loginBtn').mouseout(function () {
        //     $(this).css('background', 'url(../img/default/loginback.png) no-repeat');
        // })
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

        $('.codeH').mouseover(function () {
            $('.iconH').addClass('one');
            $('.codeH').show();
        })
        $('.iconH').mouseover(function () {
            $('.iconH').addClass('one');
            $('.codeH').show();
        })

        $('.codeT').mouseover(function () {
            $('.iconT').addClass('one');
            $('.codeT').show();
        })
        $('.iconT').mouseover(function () {
            $('.iconT').addClass('one');
            $('.codeT').show();
        })

        $('#android').mouseout(function () {
            $('.codeT').hide();
            $('.iconT').removeClass('one');
        })
        $('#iphone').mouseout(function () {
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
        $('select[name="language"]').change(function () {
            window.location.href = this.value
        })

        $(document).keypress(function (e) {
            // 回车键事件
            if (e.which == 13) {
                $('.loginBtn').click();
            }
        });
        //登录点击事件
        $('.loginBtn').click(function () {

            if(isa==0){
                var data = {
                    userAgent: 'pcc',
                    loginId: $('select[name="departs"] option:checked').val(),
                    username: $('#user').val(),
                    password: $('#password').val(),
                    locales: url
                };

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
                            $.get('/sysTasks/selectAll',function(datas) {
                                var datas = datas.obj;
                                for (var i = 0; i < datas.length; i++) {
                                    if (datas[i].paraName == 'SEC_INIT_PASS_SHOW' && datas[i].paraValue == 1 && $('#password').val() == "") {
                                        window.location.href='/controlpanel/modifyInfo?1'
                                    }
                                }
                            },'json')
                            if (url == 'en_US') {
                                window.location.href = "main?lang=en_US";
                            } else if (url == 'zh_tw') {
                                window.location.href = "main?lang=zh_tw";
                            } else {
                                window.location.href = "main";
                            }
                        } else {
                            if(res.code == 100040){
                                alert(res.msg);
                                reg.msg ==0;
                            }
                            if(res.code==100035){
                                past(res.code);
                                return;
                            }

                            if (res.code == 100060) {
                                window.location.href = "/defaultIndexErr?imageType=100060";
                            }else if(res.code == 100010){
                                alert("用户名或密码错误（错误代码：100010）");
                            }else if (res.code == 100040) {
                                alert("登录失败，您的账号已被系统锁定，请1分钟后重试（错误代码：100040）");
                            } else if (res.code == 100050) {
                                alert("登录失败，用户禁止登录（错误代码：100050）")
                            } else {
                                alert("用户名或密码错误（错误代码：100010）");
                            }


                        }
                    }
                })
            }else{
                var checkCode = document.getElementById("checkCode").value;
                var inputCode = document.getElementById("graphic").value;
                if (inputCode.length <= 0) {
                    alert("请输入验证码！");
                }
                else if (inputCode.toLowerCase() == checkCode.toLowerCase()) {
                    var data = {
                        userAgent: 'pcc',
                        loginId: $('select[name="departs"] option:checked').val(),
                        username: $('#user').val(),
                        password: $('#password').val(),
                        locales: url
                    };

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
                                if (url == 'en_US') {
                                    window.location.href = "main?lang=en_US";
                                } else if (url == 'zh_tw') {
                                    window.location.href = "main?lang=zh_tw";
                                } else {
                                    window.location.href = "main";
                                }
                            } else {
                                if(res.code == 100040){
                                    alert(res.msg);
                                    reg.msg ==0;
                                }
                                if(res.code==100035){
                                    past(res.code);
                                    return;
                                }
                                if (res.code == 100060) {
                                    window.location.href = "/defaultIndexErr?imageType=100060";
                                }else if(res.code == 100010){
                                    alert("用户名或密码错误（错误代码：100010）");
                                }else if (res.msg == 100040) {
                                    alert("登录失败，您的账号已被系统锁定，请1分钟后重试（错误代码：100040）");
                                } else if (res.msg = 100050) {
                                    alert("登录失败，用户禁止登录（错误代码：100050）")
                                } else {
                                    alert("用户名或密码错误（错误代码：100010）");
                                }
                            }
                        }
                    })
                }else {
                    alert("验证码输入错误！");
                    createCode(); //刷新验证码
                }
            }
        })
        //部门列表请求方法
        function departmentAll() {
            $.ajax({
                type: 'get',
                url: 'getCompanyAll',
                dataType: 'json',
                success: function (res) {
                    var data = res.obj;
                    var str = '';
                    for (var i = 0; i < data.length; i++) {
                        str += '<option value="' + data[i].oid + '">' + data[i].name + '</option>';
                    }
                    if (data.length == 1) {
                        $('select[name="departs"]').append(str);
                        $(".txt").eq(0).hide();
                        $('.entry ').css("height", "290px")
                    } else {
                        $('select[name="departs"]').append(str);
                        if($.cookie('company') != null){
                            $('select[name="departs"]').val($.cookie('company'));
                        }
                    }
                }
            })
        }


    })
</script>
</body>
</html>

