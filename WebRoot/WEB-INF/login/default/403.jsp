<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title><fmt:message code="main.th.403Page" /></title>
    <meta charset="UTF-8">
    <style>
        .timeOut{
            position: fixed;
            width: 400px;
            height: 370px;
            top: 50%;
            left: 50%;
            margin-left: -135px;
            margin-top: -195px;
            text-align: center;
        }
        .timeOut .timeOutMain{
            width: 100%;
            height: 315px;
            background-size: contain;
        }
        .timeOut .register{
            display: inline-block;
            margin-top: 46px;
            padding: 10px 54px;
            background: #2b7fe0;
            border-radius: 4px;
            color: #fff;
            display: none;
            cursor:pointer;
            font-size: 16px;
            margin: -30px auto;
        }

        .timeOut a{
            display: inline-block;
            margin-top: 46px;
            padding: 10px 54px;
            background: #2b7fe0;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            margin: -30px auto;
        }
        a{
            text-decoration:none
        }
        .alertText{
            top: 190px;
            position: relative;
            color: #809ab7;
            font-size: 18px;
        }
        .return{
            width: 103px;
            height: 28px;
            background: #2b7fe0;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            color: #ffffff;
            line-height: 28px;
            font-size: 14px;
            margin: 30px auto;
        }
        .return a{
            color: #ffffff;
        }
    </style>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body style="height: 1200px;overflow-y: scroll;">
<div class="timeOut">
    <div class="timeOutMain">

        <span class="alertText" id="alertText"></span>
        <div class="jiq"  style="    top: 241px;
    position: absolute;color: #809ab7;
    font-size: 18px;display: none">
            <span><fmt:message code="sysInfo.th.MachineCode" />: <span class="rabit"></span><span style="padding-left:10px;display: inline-block;"><fmt:message code="sysInfo.th.versionNumber" />: <span class="banben"></span></span></span>
        </div>

    </div>
    <a class="logon" href="javascript:void(0)"><fmt:message code="main.th.logInAgain" /></a>
    <span class="register" style="margin-left: 50px" onclick="register()"><fmt:message code="main.th.softwareRegistration" /></span>
</div>
<%--<iframe src="" class="alertRegister" frameborder="0" style="display: none;" scrolling="yes" height="100%" width="100%" noresize="noresize">

</iframe>
<iframe src="" class="alertRegisterNo" frameborder="0" style="display: none;" scrolling="yes" height="100%" width="100%" noresize="noresize">

</iframe>--%>



<c:choose>
    <c:when test="${param.imageType=='403'}">
        <script>
        $('#alertText').html('<fmt:message code="main.th.403.1" /><br><fmt:message code="main.th.403.2" />');
        //服务器session创建失败
        $(".timeOutMain").css("background", "url(/img/loginOut.png) no-repeat 45px 0px")
        $('a').on('click', function () {
            if(typeof parent.urlHost =='function'){
                parent.urlHost('/')
            }else {
                if(self!=top){
                    window.parent.parent.location.href='/';
                }else{
                    if(parent.opener == null){
                        window.location.href='/';
                    }else{
                        parent.opener.parent.parent.location.href='/';
                        window.close();
                    }
                }
            }
        })

        </script>
    </c:when>
    <c:otherwise>


        <script>
            var jqm = "";
            var bbh = "";
            function register() {
                $(".timeOut").hide();
                $.ajax({
                    type:'post',
                    url:'/sys/isLoginRole',
                    dataType:'json',
                    success:function(res){
                        var illegalStr=res.msg;
                        if (illegalStr=="<fmt:message code="main.th.becomeDue" />" || illegalStr=="<fmt:message code="main.th.theUserHasReachedTheUpperLimit" />"){
                            $(".alertRegister").show().attr('src','sys/sysInfo?illegality=true');
                        }else {
                            $(".alertRegisterNo").show().attr('src','sys/sysInfo');
                        }
                    }
                });
            }
            function GetUrlParam(paraName) {
                var url = document.location.toString();
                var arrObj = url.split("?");

                if (arrObj.length > 1) {
                    var arrPara = arrObj[1].split("&");
                    var arr;

                    for (var i = 0; i < arrPara.length; i++) {
                        arr = arrPara[i].split("=");

                        if (arr != null && arr[0] == paraName) {
                            return arr[1];
                        }
                    }
                    return "";
                }
                else {
                    return "";
                }
            }
            var Geturl=GetUrlParam("imageType");
            if(Geturl==100035 ||Geturl==100060){
                $(".register").show();
            }
            function subimtBtn() {
                if($('[name="lecFile"]').val()==''){
                    $.layerMsg({content:'<fmt:message code="withdraw.th.up" />',icon:2})
                    return;
                }
                if(type){
                    console.log('<fmt:message code="main.th.passThrough" />')
                    var form = $("form[id=formSub]");
                    var options = {
                        //上传文件的路径 
                        type:'post',
                        dataType : "json",
                        success:function(data){
                            $.layerMsg({content: '<fmt:message code="main.th.authorizationSuccessful" />！', icon: 1}, function () {
                                location.reload();
                            });
                        }
                    };
                    form.ajaxSubmit(options);
                }else {
                    $.layerMsg({content:'<fmt:message code="main.th.onlyFilesWithTheFileType1" />.txt<fmt:message code="main.th.onlyFilesWithTheFileType2" />',icon:2})
                    window.location.href = "/defaultIndexErr?imageType=100060";
                }

            }

            Array.prototype.indexOf = function(val) {//查找
                for (var i = 0; i < this.length; i++) {
                    if (this[i] == val) return i;
                }
                return -1;
            };
            function types(me) {
                var url=$(me).val().split('\\')
                if(!/\.(dat)$/.test(url)){
                    type=false;
                    $.layerMsg({content:'<fmt:message code="main.th.onlyFilesWithTheFileType1" />.dat<fmt:message code="main.th.onlyFilesWithTheFileType2" />',icon:2})
                    var file = document.getElementById("fileData");
                    var ie = (navigator.appVersion.indexOf("MSIE")!=-1);
                    if( ie ){
                        var file2= file.cloneNode(false);
                        file2.onchange= file.onchange;
                        file.parentNode.replaceChild(file2,file);
                    }else{
                        $(file).val("");
                    }
                }else {
                    type=true;
                }
            }

            var imageType = $.GetRequest().imageType;
            var message = $.GetRequest().message;
            if(imageType==403) {
                $('#alertText').html('<fmt:message code="main.th.403.1" /><br><fmt:message code="main.th.403.2" />');
                //服务器session创建失败
                $(".timeOutMain").css("background", "url(/img/loginOut.png) no-repeat 45px 0px")

            }else{
                $.ajax({
                    url:'/sys/getSysMessage',
                    data:{
                        queryType:'sysInfo'
                    },
                    type:'get',
                    dataType:'json',
                    success:function(res){
                        jqm = res.object.authorizationCode
                        bbh = res.object.softVersion

                        if(imageType!=undefined){
                            if(imageType==100030){
                                //用户权限表缺失
                                $('#alertText').html('<fmt:message code="main.th.loginFailedUserPermissionTableIsMissing" />');
                                $(".timeOutMain").css("background","url(/img/noauth.png) no-repeat 45px 0px")
                            }else if(imageType==403){
                                $('#alertText').html('<fmt:message code="main.th.403.1" /><br><fmt:message code="main.th.403.2" />');
                                //服务器session创建失败
                                $(".timeOutMain").css("background","url(/img/loginOut.png) no-repeat 45px 0px")
                            }else if(imageType==1070){
                                $('#alertText').html('<fmt:message code="main.th.loginFailedUserPermissionTableIsMissing" />');
                                //用户登录过期
                                $(".timeOutMain").css("background","url(/img/loginTimeOut.png) no-repeat 45px 0px")
                            }else if(imageType==100035){
                                //用户授权问件过期缺失

                                if(jqm!=undefined){

                                    $('#alertText').html('<fmt:message code="main.th.OASoftwareHasExpired" />。<p style="margin-top: 5px;"><fmt:message code="main.th.theMachineCodeOfThisSystemIs" />: '+jqm+' </p>');
                                    $(".timeOutMain").css("background","url(/img/noauth.png) no-repeat  40px 0px")


                                }else {

                                    $('#alertText').html('<fmt:message code="main.th.OASoftwareHasExpired" /><p style="margin-top: 5px;"><fmt:message code="main.th.theMachineCodeOfThisSystemIs" />: <span style="color: crimson"><fmt:message code="main.th.theMachineCodeOfThisSystemHasNotBeenObtained" /></span></p>');
                                    $(".timeOutMain").css("background","url(/img/noauth.png) no-repeat  40px 0px")


                                }
                            }
                            else if(imageType==100060){
                                //用户授权问件过期缺失
                                $('#alertText').html('<fmt:message code="main.th.theNumberOfUsersHasReachedTheUpperLimit" />');
                                $('.jiq').show();
                                console.log(jqm)
                                $('.rabit').html(jqm)
                                $('.banben').html(bbh)
                                $(".timeOutMain").css("background","url(/img/noauth.png) no-repeat  40px 0px")
                            }
                            else{
                                //服务器session创建失败
                                $('#alertText').html('<fmt:message code="main.th.403.1" /><br><fmt:message code="main.th.403.2" />');
                                $(".timeOutMain").css("background","url(/img/loginOut.png) no-repeat 45px 0px")
                            }
                        }

                    }
                })}

            $('a').click(function () {
                if(typeof parent.urlHost =='function'){
                    parent.urlHost('/')
                }else {
                    if(self!=top){
                        window.parent.parent.location.href='/';
                    }else{
                        if(parent.opener == null){
                            window.location.href='/';
                        }else{
                            parent.opener.parent.parent.location.href='/';
                            window.close();
                        }
                    }
                }
            })

            $.cookie('JSESSIONID',null)
            $.cookie('company',null)
            $.cookie('deptId',null)
            $.cookie('language',null)
            $.cookie('sex',null)
            $.cookie('uid',null)
            $.cookie('userId',null)
            $.cookie('userName',null)
            $.cookie('userPriv',null)
            $.cookie('userPrivName',null)
        </script>

        <iframe src="" class="alertRegister" frameborder="0" style="display: none;" scrolling="yes" height="100%" width="100%" noresize="noresize">

        </iframe>
        <iframe src="" class="alertRegisterNo" frameborder="0" style="display: none;" scrolling="yes" height="100%" width="100%" noresize="noresize">

        </iframe>


    </c:otherwise>
</c:choose>



</body>
</html>
