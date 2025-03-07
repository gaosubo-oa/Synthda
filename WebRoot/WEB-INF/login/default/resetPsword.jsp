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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <title>密码重置</title>

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js" type="text/javascript" charset="utf-8"></script>
<%--    <!--[if IE 8]>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <![endif]-->--%>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
</head>
<style>
    *{
        margin: 0;
        padding: 0;
    }
    body{
        /*background-color: #2b908f;*/
        /*background: url("/img/default/theme1/backgroundMainCon.png") no-repeat;*/
        display: flex;
        /*justify-content: center;*/
        /*align-items: center;*/
        text-align: center;
    }
    .bodyclass{
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center 0;
        background-attachment: fixed;
        background-size: cover;
        -webkit-background-size: cover;
    }
    .biggest{
        height: 520px;
        margin: 0 auto;
        margin-top: 70px;
        width: 900px;
    }
    .bigger{
        font-size: 14px;
        color: #333;
        width: 623px;
        margin: 0 auto;
        text-align: center;
    }
    .bigger h3 {
        line-height: 90px;
        font-size: 28px;
        font-weight: bold;
    }
    .bigger ul{
        display: table;
        width: 100%;
        text-align: center;
    }
    .bigger ul li {
        display: table-cell;
        height: 36px;
        line-height: 36px;
        font-size: 17px;
    }
    .test {
        color: #31acfb;
    }
    .bigger ul li.test {
        text-align: left;
    }
    .layui-form-item .layui-input-inline{
        width: 260px;
    }
    .layui-form-label {
        font-size: 15px;
    }
</style>
<body>
<%--手机号码验证--%>
<div class="biggest" id="oneForm">
    <div class="bigger">
        <h3 class="titles" style="margin-top: 30px"><fmt:message code="reset.resetLoginPassword" /></h3>
        <ul>
            <li class="test"><fmt:message code="reset.identityVerification" /></li>
            <li><fmt:message code="reset.resetLoginPassword" /></li>
            <li><fmt:message code="reset.resetCompleted" /></li>
        </ul>
        <div style="position: relative">
            <img id="imgOne" src="/img/resetOne.png" style="width: 26px;float: left; margin-left: 20px; margin-top: -6px;">
            <div style="border: 1px solid #CCC; position: absolute; width: 36%; top: 7px; left: 55px;"></div>
            <img src="../img/resetTwo.png" style="width: 26px; margin-top: -6px; margin-left: -50px;">
            <div style="border: 1px solid #CCC; position: absolute; width: 29%; top: 7px; left: 335px;"></div>
            <img src="../img/resetTwo.png" style="width: 26px; position: absolute; right: 73px; top: -6px;">
        </div>
        <div class="layui-form formOne" style="margin-top: 35px;">
            <div class="layui-form-item">
                <div class="layui-inline username">
                    <label class="layui-form-label"><fmt:message code="reset.username" /></label>
                    <div class="layui-input-inline">
                        <input type="tel" name="username" autocomplete="off" class="layui-input" placeholder="<fmt:message code="reset.pleaseInputUsername" />">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline phoneNum">
                    <label class="layui-form-label"><fmt:message code="reset.phoneNumber" /></label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input" placeholder="<fmt:message code="reset.pleaseInputPhoneNumber" />">
                    </div>
                </div>
            </div>
        </div>
        <div>
            <button type="button" class="layui-btn layui-btn-normal stage" id="nextStage" style="width: 22%;font-size: 16px; border-radius: 12px;margin-top: 15px;"><fmt:message code="reset.nextStep" /></button>
        </div>
    </div>
</div>
<%--密码重置--%>
<div class="biggest" id="twoForm" style="display: none">
    <div class="bigger">
        <h3 class="titles" style="margin-top: 30px"><fmt:message code="reset.resetLoginPassword" /></h3>
        <ul>
            <li class="test"><fmt:message code="reset.identityVerification" /></li>
            <li class="two" style="color: #31acfb;"><fmt:message code="reset.resetLoginPassword" /></li>
            <li><fmt:message code="reset.resetCompleted" /></li>
        </ul>
        <div style="position: relative">
            <img id="imgOnes" src="/img/resetOne.png" style="width: 26px;float: left; margin-left: 20px; margin-top: -6px;">
            <div class="lineOne" style="border: 1px solid white; position: absolute; width: 36%; top: 7px; left: 55px;"></div>
            <img id="imgTwo" src="../img/resetOne.png" style="width: 26px; margin-top: -6px; margin-left: -50px;">
            <div style="border: 1px solid #CCC; position: absolute; width: 29%; top: 7px; left: 335px;"></div>
            <img src="../img/resetTwo.png" style="width: 26px; position: absolute; right: 73px; top: -6px;">
        </div>
        <div class="layui-form formOne" style="margin-top: 35px;">
            <div class="layui-form-item">
                <div class="layui-inline phoneNum">
                    <label class="layui-form-label"><fmt:message code="reset.newPassword" /></label>
                    <div class="layui-input-inline" style="position: relative">
                        <input type="password" name="newPsword" onkeyup="pwdStrong(this.value);" autocomplete="off"
                               class="layui-input newPsword" placeholder="<fmt:message code="reset.pleaseInputNewLoginPassword" />">
                        <span class="regex" style="position: absolute; top: 10px; right: -55px;"></span>
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="position: relative">
                <div class="layui-inline phoneNum">
                    <label class="layui-form-label"><fmt:message code="reset.confirmPassword" /></label>
                    <div class="layui-input-inline">
                        <input type="password" class="layui-input surePsword" placeholder="<fmt:message code="reset.pleaseInputNewPasswordAgain" />">
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="position: relative">
                <div class="layui-inline phoneNum">
                    <label class="layui-form-label"><fmt:message code="reset.verificationCode" /></label>
                    <div class="layui-input-inline">
                        <input type="text" style="width: 55%;" class="layui-input testNum" placeholder="<fmt:message code="reset.pleaseInputVerificationCode" />">
                        <input type="button" class="layui-input mobilNo" style="position: absolute; background-color: #d6d2d2; top: 0px; right: 0px; width: 41%;"
                               id="btn" value="<fmt:message code="reset.getVerificationCode" />" onclick="sendemail()"/>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <button type="button" class="layui-btn layui-btn-normal stage" id="lastStage" style="width: 22%;font-size: 16px; border-radius: 12px;margin-top: 20px;"><fmt:message code="reset.nextStep" /></button>
        </div>
    </div>
</div>
<%--密码重置成功--%>
<div class="biggest" id="threeForm" style="display: none">
    <div class="bigger">
        <h3 class="titles" style="margin-top: 30px"><fmt:message code="reset.resetLoginPassword" /></h3>
        <ul>
            <li class="test"><fmt:message code="reset.identityVerification" /></li>
            <li class="two" style="color: #31acfb;"><fmt:message code="reset.resetLoginPassword" /></li>
            <li class="three" style="color: #31acfb;"><fmt:message code="reset.resetCompleted" /></li>
        </ul>
        <div style="position: relative">
            <img id="imgOness" src="/img/resetOne.png" style="width: 26px;float: left; margin-left: 20px; margin-top: -6px;">
            <div class="lineOne" style="border: 1px solid white; position: absolute; width: 36%; top: 7px; left: 55px;"></div>
            <img id="imgTwos" src="../img/resetOne.png" style="width: 26px; margin-top: -6px; margin-left: -50px;">
            <div class="lineTwo" style="border: 1px solid white; position: absolute; width: 29%; top: 7px; left: 335px;"></div>
            <img id="imgThree" src="../img/resetOne.png" style="width: 26px; position: absolute; right: 73px; top: -6px;">
        </div>
        <div style="height: 96px; padding-top: 85px; font-size: 18px;">
            <p class="sub"><span>-^0^-</span> <fmt:message code="reset.newLoginPasswordResetSuccess" /> <fmt:message
                    code="reset.pleaseRelogin" /></p>
        </div>
        <div>
            <button type="button" class="layui-btn layui-btn-normal stage" id="reLogin"  style="width: 22%;font-size: 16px; border-radius: 12px;margin-top: -10px;">重新登录</button>
        </div>
    </div>

</div>

</body>
</html>
<script>
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
    var type = getQueryString('type')
    //根据主题显示不同样式
    $(function(){
        var src2 = '/img/default/loginBackground.png';
        if(type == '1'){
            var src = '/img/default/theme1/backgroundMainCon.png';
            $('body').css('background-image',"url("+src+")")
            $('body').addClass('bodyclass')
            $('.biggest').css('background-image',"url("+src2+")")
            $('.biggest').css('background-repeat',"no-repeat")
            $('.biggest').css('background-size',"900px 520px")
            $('.titles').css('color',"white")
            $('.test').css('color',"white")
            $('.stage').css('background-color',"#FFA042")
            $('.two').css('color','white')
            $('.three').css('color',"white")
            $('.sub').css('color',"white")
            $('.layui-form-label').css('color',"white")
        }else if(type == '2'){
            var src = '/img/default/backgroundMainCon_2.jpg';
            var srcs = '/img/default/gradient.png';
            $('body').css('background-image',"url("+src+")")
            $('body').addClass('bodyclass')
            $('.biggest').css('background-image',"url("+srcs+")")
            $('.biggest').css('background-repeat',"no-repeat")
            $('.biggest').css('background-size',"900px 520px")
        } else if(type == '3'){
            var src = '/img/default/theme2/backgroundMainCon.png';
            $('body').css('background-image',"url("+src+")")
            $('body').addClass('bodyclass')
            $('.biggest').css('background-image',"url("+src2+")")
            $('.biggest').css('background-repeat',"no-repeat")
            $('.titles').css('color',"red")
            $('.biggest').css('background-size',"900px 520px")
            $('.stage').css('background-color',"red")
            $('.test').css('color',"red")
            $('.two').css('color',"red")
            $('.three').css('color',"red")
            $('#imgOne').attr('src',"/img/titleRed.png")
            $('#imgTwo').attr('src',"/img/titleRed.png")
            $('#imgOnes').attr('src',"/img/titleRed.png")
            $('#imgTwos').attr('src',"/img/titleRed.png")
            $('#imgOness').attr('src',"/img/titleRed.png")
            $('#imgThree').attr('src',"/img/titleRed.png")
            $('.layui-form-label').css('color',"red")
            $('.sub').css('color',"red")
        }else if(type == '4'){
            var src = '/img/default/theme3/backgroundMain.png';
            var srcs = '/img/default/theme3/loginBackgroundbox.png';
            $('body').css('background-image',"url("+src+")")
            $('body').addClass('bodyclass')
            $('.biggest').css('background-image',"url("+srcs+")")
            $('.biggest').css('background-repeat',"no-repeat")
            $('.biggest').css('background-size',"900px 520px")
            $('.titles').css('color',"white")
            $('.test').css('color',"white")
            $('.stage').css('background-color',"#FFA042")
            $('.two').css('color',"white")
            $('.three').css('color',"white")
            $('.sub').css('color',"white")
            $('.layui-form-label').css('color',"white")
        }else if(type == '5'){
            var src = '/img/default/theme4/backgroundMainCon.png';
            $('body').css('background-image',"url("+src+")")
            $('body').addClass('bodyclass')
            $('.biggest').css('background-image',"url("+src2+")")
            $('.biggest').css('background-repeat',"no-repeat")
            $('.biggest').css('background-size',"900px 520px")
            $('.stage').css('background-color',"#9b5d3d")
            $('.titles').css('color',"#9b5d3d")
            $('.test').css('color',"#9b5d3d")
            $('.two').css('color',"#9b5d3d")
            $('.three').css('color',"#9b5d3d")
            $('#imgOne').attr('src',"/img/resetFive.png")
            $('#imgTwo').attr('src',"/img/resetFive.png")
            $('#imgOnes').attr('src',"/img/resetFive.png")
            $('#imgTwos').attr('src',"/img/resetFive.png")
            $('#imgOness').attr('src',"/img/resetFive.png")
            $('#imgThree').attr('src',"/img/resetFive.png")
            $('.layui-form-label').css('color',"#9b5d3d")
            $('.sub').css('color',"#9b5d3d")
        }else if(type == '6'){
            var src = '/img/default/theme5/backgroundMainCon.png';
            $('body').css('background-image',"url("+src+")")
            $('body').addClass('bodyclass')
            $('.biggest').css('background-image',"url("+src2+")")
            $('.biggest').css('background-repeat',"no-repeat")
            $('.biggest').css('background-size',"900px 520px")
            $('.titles').css('color',"#e7db24")
            $('.test').css('color',"yellow")
            $('.two').css('color',"yellow")
            $('.three').css('color',"yellow")
            $('#imgOne').attr('src',"/img/titleRed.png")
            $('#imgTwo').attr('src',"/img/titleRed.png")
            $('#imgOnes').attr('src',"/img/titleRed.png")
            $('#imgTwos').attr('src',"/img/titleRed.png")
            $('#imgOness').attr('src',"/img/titleRed.png")
            $('#imgThree').attr('src',"/img/titleRed.png")
            $('.stage').css('background-color',"#e26028")
            $('.layui-form-label').css('color',"red")
            $('.sub').css('color',"red")
        }
    })

    /*================================身份验证页==================================================*/
    var username
    var phone
    var testNum
    var flag = 0;
    var start = 0;
    var end = 0;
    var passWordMin=6,passWordMax=20;

    //点击下一步
    $('#nextStage').on('click', function () {
        username = $("input[name='username']").val();
        phone = $("input[name='phone']").val();
        // testNum = $(".testNum").val();
        var testPhone = /^1(3|4|5|7|8|9)\d{9}$/;
        if (username == '') {
            layer.msg('<fmt:message code="input.pleaseEnterUsername" />', {icon: 2});
            return false;
        } else if (phone == "") {
            layer.msg('<fmt:message code="input.pleaseEnterPhoneNumber" />', {icon: 2});
            return false;
        } else {
            if (!testPhone.test(phone)) {
                layer.msg('<fmt:message code="input.incorrectPhoneFormat" />', {icon: 2});
                return false;
            } else {
                $.ajax({
                    url: '/verification/inspectCode',
                    dataType: 'json',
                    type: 'post',
                    data: {
                        numberStr: testNum,
                        Mobile: phone,
                        byname: username,
                    },
                    success: function (res) {
                        if (res.flag == true) {
                            $('#twoForm').css('display', 'block');
                            $('#oneForm').css('display', 'none');
                            pswordTest();
                        } else {
                            layer.msg(res.msg, {icon: 2});
                            return false;
                        }
                    }
                })
            }
        }
    });

    var countdown = 60;

    //发送验证码
    function sendemail() {
        var obj = $("#btn");
        if ($("input[name='phone']").val()!= '' && $("input[name='username']").val()!= '') {
            $.ajax({
                url: '/verification/smsNoCode',
                dataType: 'json',
                type: 'post',
                data: {
                    Mobile: $("input[name='phone']").val(),
                    byname: $("input[name='username']").val(),
                },
                success: function (res) {
                    if (res.msg == 'ok') {
                        layer.msg('<fmt:message code="send.success" />', {icon: 1});
                        settime(obj);
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                }
            })
        } else if ($("input[name='username']").val() == '') {
            layer.msg('<fmt:message code="input.pleaseEnterUsername" />', {icon: 2});
            return false;
        } else if ($("input[name='phone']").val() == '') {
            layer.msg('<fmt:message code="input.pleaseEnterPhoneNumber" />', {icon: 2});
            return false;
        }
    }

    //验证码倒计时
    function settime(obj) { //发送验证码倒计时
        if (countdown == 0) {
            obj.attr('disabled', false);
            obj.val('<fmt:message code="send.getVerificationCode" />');
            countdown = 300;
            return;
        } else {
            obj.attr('disabled', true);
            obj.val('<fmt:message code="send.resend" />' + "(" + countdown + ")");
            countdown--;
        }
        setTimeout(function () {
                settime(obj)
            },
            1000)
    }



    /*================================重置密码页=======================================*/
    //验证密码复杂度
    function pswordTest(){
        // 查询密码限制长度
        var passWordMin=6,passWordMax=20;
        $.ajax({
            url:"/user/getPwRule",
            type:"post",
            dataType: 'json',
            success:function (res) {
                if(res.flag){
                    var obj = res.object;
                    passWordMin = obj.secPassMin;
                    passWordMax = obj.secPassMax;
                    start = passWordMin
                    end = passWordMax
                    $('.regex').text(passWordMin+"-"+passWordMax+"位");
                }
            }
        });

        $.ajax({
            url:'/sysTasks/selectAll',
            dataType:'json',
            type:'post',
            success:function (res) {
                var data = res.obj;
                for(var i=0;i<data.length;i++){
                    if(data[i].paraName=='SEC_PASS_SAFE'){
                        if (data[i].paraValue == 0) {
                            flag = 0;
                            $('.regex').next().text('<fmt:message code="password.rule.unit" />');
                        } else if (data[i].paraValue == 1) {
                            flag = 1;
                            $('.regex').next().html('<fmt:message code="password.rule.letterNumber" />');
                        } else if (data[i].paraValue == 2) {
                            flag = 2;
                            $('.regex').next().html('<fmt:message code="password.rule.letterNumberChar" />');
                        } else if (data[i].paraValue == 3) {
                            flag = 3;
                            $('.regex').next().html('<fmt:message code="password.rule.caseNumber" />');
                        } else if (data[i].paraValue == 4) {
                            flag = 4;
                            $('.regex').next().html('<fmt:message code="password.rule.caseNumberSpecialChar" />');
                        }
                    }
                }
            }
        })
    }
    //点击下一步
    $('#lastStage').on('click',function(){
        var psword = $('.newPsword').val();
        var surePsword = $('.surePsword').val();
        testNum = $(".testNum").val();
        var reg1 = /^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
        var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/ //字母、数字、特殊字符
        var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/   //大写字母、小写字母、数字
        // var reg4 = /^(?=.*[a-zA-Z])(?=.*[1-9])(?=.*[\W])$/  //大写字母、小写字母、数字、特殊字符
        var reg4 = /^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)(?=.*?[!#@*&.])[a-zA-Z\d!#@*&.]*$/   //大写字母、小写字母、数字、特殊字符
        if(psword == ''){
            layer.msg("新密码项不能为空！",{icon:2});
        }else if(surePsword == ''){
            layer.msg("确认密码项不能为空！",{icon:2});
        }else if(psword != surePsword){
            layer.msg("两次密码不一致！",{icon:2});
        }else if(psword == surePsword){
            if (flag == 0) {
                if (surePsword.toString().length < start) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatLengthBegin" />' + start + '<fmt:message code="password.incorrectFormatLengthEnd" />' + end + '<fmt:message code="password.incorrectFormatLengthUnit" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length > end) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatLengthBegin" />' + start + '<fmt:message code="password.incorrectFormatLengthEnd" />' + end + '<fmt:message code="password.incorrectFormatLengthUnit" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                }
            } else if (flag == 1) {
                if (!reg1.test(surePsword)) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatLetterNumberBegin" />' + start + '<fmt:message code="password.incorrectFormatLetterNumberEnd" />' + end + '<fmt:message code="password.incorrectFormatLetterNumberUnit" />' + '<fmt:message code="password.incorrectFormatLetterNumberContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length < start) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatLetterNumberBegin" />' + start + '<fmt:message code="password.incorrectFormatLetterNumberEnd" />' + end + '<fmt:message code="password.incorrectFormatLetterNumberUnit" />' + '<fmt:message code="password.incorrectFormatLetterNumberContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length > end) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatLetterNumberBegin" />' + start + '<fmt:message code="password.incorrectFormatLetterNumberEnd" />' + end + '<fmt:message code="password.incorrectFormatLetterNumberUnit" />' + '<fmt:message code="password.incorrectFormatLetterNumberContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                }
            } else if (flag == 2) {
                if (!reg2.test(surePsword)) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatLetterNumberSpecialBegin" />' + start + '<fmt:message code="password.incorrectFormatLetterNumberSpecialEnd" />' + end + '<fmt:message code="password.incorrectFormatLetterNumberSpecialUnit" />' + '<fmt:message code="password.incorrectFormatLetterNumberSpecialContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length < start) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatLetterNumberSpecialBegin" />' + start + '<fmt:message code="password.incorrectFormatLetterNumberSpecialEnd" />' + end + '<fmt:message code="password.incorrectFormatLetterNumberSpecialUnit" />' + '<fmt:message code="password.incorrectFormatLetterNumberSpecialContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length > end) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatLetterNumberSpecialBegin" />' + start + '<fmt:message code="password.incorrectFormatLetterNumberSpecialEnd" />' + end + '<fmt:message code="password.incorrectFormatLetterNumberSpecialUnit" />' + '<fmt:message code="password.incorrectFormatLetterNumberSpecialContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                }
            } else if (flag == 3) {
                if (!reg3.test(surePsword)) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatCaseNumberBegin" />' + start + '<fmt:message code="password.incorrectFormatCaseNumberEnd" />' + end + '<fmt:message code="password.incorrectFormatCaseNumberUnit" />' + '<fmt:message code="password.incorrectFormatCaseNumberContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length < start) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatCaseNumberBegin" />' + start + '<fmt:message code="password.incorrectFormatCaseNumberEnd" />' + end + '<fmt:message code="password.incorrectFormatCaseNumberUnit" />' + '<fmt:message code="password.incorrectFormatCaseNumberContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length > end) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatCaseNumberBegin" />' + start + '<fmt:message code="password.incorrectFormatCaseNumberEnd" />' + end + '<fmt:message code="password.incorrectFormatCaseNumberUnit" />' + '<fmt:message code="password.incorrectFormatCaseNumberContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                }
            } else if (flag == 4) {
                if (!reg4.test(surePsword)) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatCaseNumberSpecialBegin" />' + start + '<fmt:message code="password.incorrectFormatCaseNumberSpecialEnd" />' + end + '<fmt:message code="password.incorrectFormatCaseNumberSpecialUnit" />' + '<fmt:message code="password.incorrectFormatCaseNumberSpecialContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length < start) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatCaseNumberSpecialBegin" />' + start + '<fmt:message code="password.incorrectFormatCaseNumberSpecialEnd" />' + end + '<fmt:message code="password.incorrectFormatCaseNumberSpecialUnit" />' + '<fmt:message code="password.incorrectFormatCaseNumberSpecialContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                } else if (surePsword.toString().length > end) {
                    $.layerMsg({
                        content: '<fmt:message code="password.incorrectFormatCaseNumberSpecialBegin" />' + start + '<fmt:message code="password.incorrectFormatCaseNumberSpecialEnd" />' + end + '<fmt:message code="password.incorrectFormatCaseNumberSpecialUnit" />' + '<fmt:message code="password.incorrectFormatCaseNumberSpecialContent" />',
                        icon: 5,
                        time: 8000
                    });
                    return false;
                }
            }
            $.ajax({
                url:'/verification/editPwd',
                dataType:'json',
                type:'post',
                data:{
                    numberStr:testNum,
                    Mobile:phone,
                    byname:username,
                    newPwd:surePsword,
                },
                success:function(res){
                    if(res.flag == true){
                        $('#twoForm').css('display','none')
                        $('#oneForm').css('display','none')
                        $('#threeForm').css('display','block')
                    }else{
                        layer.msg(res.msg,{icon:2});
                        return false;
                    }
                }
            })

        }
    })
    //校验密码
    function pwdStrong(value) {
        // var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g")  //强
        // var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g")  //中
        // var enoughRegex = new RegExp("(?=.{6,}).*", "g") //弱
        if (value.length >= 8 && value.length <= 20) {
            if (/\d/.test(value)) {
                $('.regex').text('<fmt:message code="password.strength.weak" />');
                $('.regex').css('color', 'red');
                $('.regex').css('right', '-27px');
            }
            if (/[a-zA-Z]/.test(value)) {
                $('.regex').text('<fmt:message code="password.strength.medium" />');
                $('.regex').css('color', 'red');
                $('.regex').css('right', '-27px');
            }
            if (/[\W|_]/.test(value)) {
                $('.regex').text('<fmt:message code="password.strength.strong" />');
                $('.regex').css('color', 'red');
                $('.regex').css('right', '-27px');
            }
        } else if (value.length > 20) {
            layer.msg('<fmt:message code="password.length.exceeded" />', {icon: 2});
        }
    }


    /*===============================重置完成页==================================================*/
    $('#reLogin').on('click',function(){
        //window.location.href = '/defaultIndex'
        history.back(-1);
    })


</script>
