<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/1/6
  Time: 13:48
  To change this template use File | Settings | File Templates.
--%>
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
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/default/theme89/loginInterface.css?20230106"/>
    <link rel="stylesheet" href="/css/swiper/swiper.min.css">
    <script src="/js/swiper/swiper.min.js"></script>
    <script src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
<%--    <!--[if IE 8]>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <![endif]-->--%>

    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js?20220320"></script>
    <script src="/js/login/login.js?20200710.1"></script>
    <script charset="utf-8" src="/js/login/scanLogin.js?20220309"></script>
    <script charset="utf-8" src="/js/login/jsencrypt.js?20210429.3"></script>
    <script src="/ui/js/qrcode.min.js"></script>
</head>
<body>
<img src="/img/xcLogin/login_bg.png" class="login_bg" alt="">
<div class="de-box">
    <img src="/img/xcLogin/top_01.jpg" class="log" alt="">
    <div class="banner">
        <div class="swiper">
            <div class="swiper-wrapper">
                <div class="swiper-slide banner1"></div>
                <div class="swiper-slide banner2"></div>
                <div class="swiper-slide banner3"></div>
            </div>
        </div>
    </div>
    <div class="con1">
        <div style="    font-family: '宋体';
  font-size: 13px;
  color: #ffffff;
  line-height: 26px;
  padding-left: 100px;
  padding-top: 66px;">欢迎使用国家矿山安全监察局湖北局协同办公平台，请在右边输入用户名和密码登陆系统。<br>
            如账号登录遇到问题，请联系管理员。
        </div>
        <form class="login-form">
            <div class="loginPart" style="margin-top: 30px;">
<%--                <div class="txt" >--%>
<%--                    <img class="img" src="/img/default/theme16/zuzhi.png"/>--%>
<%--                    <select id="departs" name="departs">--%>
<%--                    </select>--%>
<%--                    <img src="/img/default/theme16/xiala.png" style="position: absolute;width: 16px;right: -3px;top: 30px;opacity: .7;"/>--%>
<%--                </div>--%>
                <div class="txt" style="display: block !important;">
                    <img class="img" src="/img/xcLogin/username.png"/>
                    <input type="text" name="user" id="user" placeholder="用户名" value="" />
                </div>
                <div class="txt">
                    <img class="img" src="/img/xcLogin/password.png"/>
                    <input type="password" autocomplete="off" name="password" id="password" placeholder="密码" value="" />
                </div>
<%--                <div class="resetPsword">--%>
<%--                    <span autocomplete="off" style="color: #f9f7f6; float:right; display: inline-block;font-size: 10px;margin-top: 22px;"><fmt:message code="global.lang.forgetPW"/></span>--%>
<%--                </div>--%>
                <div id="SecGraphic" class="txt" style="margin-top: 10px;height: 30px;position: relative;">
                    <img class="img" src="/img/xcLogin/captcha.png" style="position: absolute;z-index: 2;top: 4px;width: 17px;left: 1px;"/>
                    <input type="text" id="graphic" style="margin-top: 5px;" placeholder="请输入图中验证码"/>
<%--                   <input type="text" onclick="createCode()" readonly="readonly" id="checkCode" class="unchanged" style="width: 80px;background :honeydew;color: red;text-align: center"/><br/>--%>
                    <img src="" alt="" style="position: absolute;top: -7px;right: -4px;"
                         onclick="$(this).attr('src','/GetCodeImgServlet?'+Math.random())" id="imgCode">
                </div>
                <div class="loginBtn" style="margin: 20px 0 30px 0px;">
                    <span style="">登录</span>
                </div>
            </div>
        </form>
    </div>
</div>
<script>

    var pc_height = document.documentElement.clientHeight;
    var pc_width = document.documentElement.clientWidth;
    if(pc_width < 1400){
        $('.entryTwo').css('padding-top','30px');
        $('.entry').css('margin-top','10px');
        $('.entry').css('height','485px');
        $('.header').css('height','60px')
        $('#beianhao').css('height','30px')
    }
    try{
        var mySwiper = new Swiper('.swiper', {
            loop: true, // 循环模式选项
            autoplay:true
        })
    }catch(e){
        console.log(e)
    }

    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    var selected = getQueryString("selected");
    if(selected == '89'){
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
    if (window.navigator.userAgent.indexOf('compatible') != -1) {
        $('.txt input').css('background-color','#1b3e69')
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
        // $('.entryTwo').css('left','100px')
        $('#scanBtn').css('display','none')
        $('#returnBtn').css('display','block')
        var selectPart = $('select[name="departs"] option:checked').val()
        getSecret(selectPart)
    }
    function returnFun() {
        $('.loginPart').css('display','block')
        $('.scanPart').css('display','none')
        $('#scanBtn').css('display','block')
        $('#returnBtn').css('display','none')
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
                    if(json.obj.loginLiterals === '国家矿山安监局湖北局协同办公平台') {
                        $('.titleTxt1').css('display','block').text('国家矿山安监局湖北局');
                        $('.titleTxt').text('协同办公平台');
                    }else {
                        $('.titleTxt').text(json.obj.loginLiterals)
                    }


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
                         //$(".txt").eq(0).hide();
                        $('.entry ').css({'height':'460px','width':'350px'})
                        $('.entry ').css("margin-top", "54")
                        $('.loginPart').css('margin-top','45px')
                    } else {
                        $('select[name="departs"]').append(str);
                        if ($.cookie('historyCompany') != null) {
                            $('select[name="departs"]').val($.cookie('historyCompany'));
                        }
                        if (location.href.indexOf('.yun-he.cn') > -1) {
                            $('#departs').append('<option value="'+ location.href.split('.yun-he.cn')[0].split('//')[1] +'"></option>');
                            //$(".txt").eq(0).hide();
                        } else if (location.href.indexOf('oa.8oa.cn') > -1) {
                            $('#departs').append('<option value="1002"></option>');
                            //$(".txt").eq(0).hide();
                        }else if (location.href.indexOf('.yiht.net') > -1) {
                            $("#departs option[value='"+ location.href.split('.yiht.net')[0].split('//')[1] +"']").attr("selected","selected");
                            //$(".txt").eq(0).hide();
                        }
                    }
                    //判断是否开启验证码
                    if (res.code == 1) {
                        $('.resetPsword span').css('margin-top','10px')
                        $('.entry ').css('height','550px')
                        $('#SecGraphic').show()
                        $('#imgCode').attr('src','/GetCodeImgServlet?'+Math.random())
                        isa = 1
                    }
                    else {
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
        $('#iconL').on('mouseover', function () {
            $('#language').show();
        })
        $('#iconL').on('mouseout', function () {
            $('#language').hide();
        })
        var url = window.location.href.split('=')[1];
        if (url == 'zh_CN') {
            $('[name="language"]').attr('lang','?lang=zh_CN')
        } else if (url == 'zh_tw') {
            $('[name="language"]').attr('lang','?lang=zh_tw')
        } else {
            url = 'en_US'
            $('[name="language"]').attr('lang','?lang=en_US')
        }
        $('#language div').on('click', function () {
            var language = $(this).attr('langType')
            window.location.href = language
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
                                loginCokie.language = $('#language').attr('lang')? $('#language').attr('lang').split('=')[1] : 'zh_CN';
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
                                    loginCokie.language = $('#language').attr('lang')?$('#language').attr('lang').split('=')[1] : 'zh_CN';
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
