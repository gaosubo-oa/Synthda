<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="mian.panel" /></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/sys/userInfor.css"/>
    <link rel="stylesheet" type="text/css" href="/css/sys/url.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
    <style>

        .btn input{
            padding: 2px 10px;
            border-radius: 5px;
            border-width: 1px;
            border-style: solid;
        }
        .content{
            background-color: #ffffff;
        }
        .content .right{
            width: 100%;
        }
        .colo{
            background: #3791DA;
            color: white;
        }
        .listShow tr{
            border: 1px solid #c0c0c0;
        }
        .listShow td{
            padding: 7px;
            /*font: 14px "微软雅黑";*/
            font: 11pt "微软雅黑";
            text-align:left;
            padding-left:10px;
        }
        .titleText{
            font-size: 14px;
            margin-left: 46px;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            margin-top: 12px;
            margin-bottom: 10px;
            margin-right: 40px;
            font-size: 22px;
            color: #494d59;
        }
        .title{
            height:35px;
            line-height:35px;
        }
        .title span{
            margin-left:0px;
            font-size:22px;
            line-height:35px;
        }
        .title img{
            margin-left:15px;
            vertical-align: middle;
            width:24px;
            height:26px;
            padding-bottom:8px;
        }
        th{
            color:#2F5C8F;
            text-align:left;
            padding-left:10px;
            font-size: 13pt;
        }
        table tr{
            height:40px;
            line-height:40px;
        }
        table.table{
            width:90%;
        }

       .clearfix:after{
             content:'';
             display: block;
             clear: both;
         }
        .fl{
            float: left;
        }
        .xia{margin-bottom: 18px;}


    </style>
</head>
<body>
<div class="content">
    <div class="right" style="display: none;">
        <div class="title">
            <img src="../img/modifypassword.png" alt="修改账户">
            <span>修改密码</span>
        </div>
        <div class="main">
            <table class="table" cellspacing="0" cellpadding="0" style="border-collapse:collapse;background-color: #fff">
                <tr>
                    <td class="red_text"><fmt:message code="userName" />:</td>
                    <td>
                       <input id="username" type="text" readonly="readonly">
                    </td>
                </tr>
                <tr>
                    <td class="red_text"><fmt:message code="url.th.OriginalPW" />:</td>
                    <td>
                        <input type="password" id="oldpassword" class="pw"/>
                    </td>
                </tr>
                <tr>
                    <td class="red_text"><fmt:message code="url.th.newPW" />:</td>
                    <td>
                        <input type="password" id="password" class="pw"/><%--<fmt:message code="url.th.numbers" />--%>
                    </td>
                </tr>
                <tr>
                    <td class="red_text"><fmt:message code="url.th.Confirm" />:</td>
                    <td>
                        <input type="password" id="repassword" class="pw"    onkeydown="validatePwdStrong(this.value);"/>
                        <span class="passWordRuleSpan"></span><span><fmt:message code="sys.th.zimu" /></span><%--<fmt:message code="url.th.numbers" />--%>
                        <div class="clearfix" style="    width: 206px;height: 10px;border: 1px solid #ccc;margin-top: 5px;border-radius: 4px;" id="main">
                            <span class="fl" style="display:inline-block;width: 67px;height:10px;border-right: 1px solid #ccc" id="low"></span>
                            <span class="fl" style="display:inline-block;width: 67px;height:10px;border-right: 1px solid #ccc" id="medium"></span>
                            <span class="fl" style="display:inline-block;width: 68px;height:10px;" id="height"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="red_text"><fmt:message code="url.th.LastModified" />:</td>
                    <td>
                        <span id="lastEditTime"></span>
                    </td>
                </tr>
                <tr class="pasexpire">
                    <td class="red_text"><fmt:message code="url.th.PasswordExpired" />:</td>
                    <td>
                        <fmt:message code="url.th.passwordNeverExpires" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="btn">
                            <input id="submit" type="button" class="inpuBtn backOkBtn"  value="&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message code="global.lang.save" />">
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div  class="title xia">
            <img  src="../img/password_log.png" alt="密码日志">
            <span><fmt:message code="url.th.LastLogs" /></span>
        </div>
        <div style="text-align: -webkit-center;margin:0 auto">
            <table class="listShow" cellspacing="0" cellpadding="0" class="tab" style="border-collapse:collapse;background-color: #fff;width: 90%;margin:0 auto">
                <thead>
                 <tr>
                      <th><fmt:message code="journal.th.user" /></th>
                      <th><fmt:message code="email.th.time" /></th>
                      <th><fmt:message code="journal.th.IPaddress" /></th>
                      <th><fmt:message code="notice.th.type" /></th>
                      <th><fmt:message code="journal.th.Remarks" /></th>
                  </tr>
                </thead>
                <tbody class="modifyPwdLogList">

                </tbody>
            </table>
        </div>
    </div>

</div>

<script>
    var flag = 0;
    var start = 0;
    var end = 0;
    var seaUrl = window.location.search.substr(1);
    $(function(){
        //如果开启三员管理隐藏修改密码日志
        $.ajax({
            url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
            success:function(res) {
                var data = res.object[0];
                if(data.paraValue == 0) {
                    $(".xia").hide()
                    $(".listShow").hide()
                    $(".pasexpire").hide()
                }
            }
        })
        // 查询密码限制长度
        var passWordMin=6,passWordMax=20;
        $.ajax({
            url:"/user/getPwRule",
            type:"get",
            dataType: 'json',
            success:function (res) {
                if(res.flag){
                    var obj = res.object;
                    passWordMin = obj.secPassMin;
                    passWordMax = obj.secPassMax;
                    start = passWordMin
                    end = passWordMax
                    $('.passWordRuleSpan').html(passWordMin+"-"+passWordMax);
                }
            }
        });

        $.ajax({
            url:'/sysTasks/selectAll',
            dataType:'json',
            type:'get',
            success:function (res) {
                var data = res.obj;
                for(var i=0;i<data.length;i++){
                    if(data[i].paraName=='SEC_PASS_SAFE'){
                        if(data[i].paraValue == 0){
                            flag = 0
                            $('.passWordRuleSpan').next().html('<fmt:message code="system_setting.digit" />')
                        }else if(data[i].paraValue == 1){
                            flag = 1
                            $('.passWordRuleSpan').next().html('<fmt:message code="sys.th.zimu" />')
                        }else if(data[i].paraValue == 2){
                            flag = 2
                            $('.passWordRuleSpan').next().html('位，必须同时包含字母和数字和字符')
                        }else if(data[i].paraValue == 3){
                            flag = 3
                            $('.passWordRuleSpan').next().html('位，必须同时包含大写字母和小写字母和数字')
                        }else if(data[i].paraValue == 4){
                            flag = 4
                            $('.passWordRuleSpan').next().html('位，必须同时包含大写字母和小写字母和数字和特殊字符')
                        }
                    }
                }
                $('.right').show();
            }
        })
        $('#password').on({
            blur:function() {
                var oldpws = $('#oldpassword').val();
                var newpws = $(this).val();
                if(newpws && !oldpws) {
                    layer.msg('您还没有输入原密码',{icon:0})
                }
                if(oldpws && newpws && (oldpws == newpws)) {
                    layer.msg('新密码和原密码相同',{icon:0})
                }
            }
        })
        $.ajax({
            type: "get",
            url: "/getUsersByuserId",
            dataType: 'json',
            success: function (obj) {
                if(obj.flag){

                    $('#username').val(obj.object.byname);
                    $('#username').attr({
                        'userId':obj.object.userId,
                        'uid':obj.object.uid
                    })
                    var timeStamp=obj.object.lastPassTime;
                    if(timeStamp!=undefined) {
                        var time = new Date(timeStamp);
                        var year = time.getFullYear();//年
                        var month = time.getMonth() + 1;//月
                        var date = time.getDate();//日
                        var hour = time.getHours(); //时
                        var minu = time.getMinutes(); //分
                        var conds = time.getSeconds(); //秒
                        var new_months;
                        var new_dates;
                        var new_hours;
                        var new_minus;
                        var new_condss;
                        if (month < 10) {
                            new_months = "0" + month
                        } else {
                            new_months = month;
                        }
                        if (date < 10) {
                            new_dates = "0" + date
                        } else {
                            new_dates = date;
                        }
                        if (minu < 10) {
                            new_minus = "0" + minu
                        } else {
                            new_minus = minu;
                        }
                        if (hour < 10) {
                            new_hours = "0" + hour;
                        } else {
                            new_hours = hour;
                        }
                        if (conds < 10) {
                            new_condss = "0" + conds;
                        } else {
                            new_condss = conds;
                        }
                        var str_time = year + "-" + new_months + "-" + new_dates + " " + new_hours + ":" + new_minus + ":" + new_condss;

                        $('#lastEditTime').html(str_time);
                    }else {
                        $('#lastEditTime').html("");
                    }
                }
            },
        });
        $('#submit').click(function(){
            var repassword = $('#repassword').val();
            var password = $('#password').val();
            var oldpassword = $('#password').val()
            var reg =/^[0-9]*$/; //数字
            var reg1=/^(?![^a-zA-Z]+$)(?!\D+$).{1,}$/  //字母和数字
            var reg2 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/; //字母、数字、特殊字符
            var reg3 = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/  //大写字母、小写字母、数字
            var reg4 = /^.*(?=.{1,})(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[,.:;!@#$%^&*? ]).*$/;  //大写字母、小写字母、数字、特殊字符
//                    var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/;
//            var values = $('#repassword').val()
//            console.log(repassword)
//            console.log(password)
//            console.log(flag)
//            console.log(reg4.test(repassword))
            if(password ==''){
                $.layerMsg({content:'<fmt:message code="url.th.PasswordNotEmpty" />！',icon:1},function(){
                    return false;
                });
            } else if(repassword == '' ){
                $.layerMsg({content:'<fmt:message code="url.th.VerifynotEmpty" />！',icon:1},function(){
                    return false;
                });
            }else if(oldpassword == ''){
                $.layerMsg({content:'<fmt:message code="url.th.TheOldNotEmpty" />！',icon:1},function(){
                   return false;
                });
            }else if(repassword == password){
                if(flag == 0){
                    if(repassword.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'<fmt:message code="system_setting.digit" />',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'<fmt:message code="system_setting.digit" />',icon:6,time:3000})
                        return false;
                    }
                }if(flag == 1 ){
                    if(!reg1.test(repassword)){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字',icon:6,time:3000})
                        return false;
                    }
                }else if(flag == 2 ){
                    if(!reg2.test(repassword)){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }
                }else if(flag == 3 ){
                    if(!reg3.test(repassword)){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字',icon:6,time:3000})
                        return false;
                    }
                }else if(flag == 4 ){
                    if(!reg4.test(repassword)){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length < start){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }else if(repassword.toString().length > end){
                        $.layerMsg({content:'您输入的密码格式不正确，要求密码长度为'+start+'-'+end+'位，密码强度为密码必须包含：大写字母 和 小写字母 和 数字 和 特殊字符',icon:6,time:3000})
                        return false;
                    }
                }
                $.ajax({
                    type: "post",
                    url: "/editPwd",
                    dataType: 'json',
                    data: {
                        password:$('#oldpassword').val(),
                        userId:$('#username').attr('userId'),
                        uid:$('#username').attr('uid'),
                        newPwd:$('#password').val()
                    },
                    success: function (obj) {
                        if(obj.flag){
                            if(/(Android)/i.test(navigator.userAgent)){
                                Android.logOut();
                            }else if(( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) )){
                                try{
                                    window.webkit.messageHandlers.logOut.postMessage("");
                                }
                                catch(err) {
                                    logOut();
                                }
                            }
                            else{
                                if(seaUrl!=undefined&&seaUrl == 1){
                                    window.location.href = '/'
                                }else{
                                    $.layerMsg({content:'<fmt:message code="url.th.PasswordChangesSucceeded" />！',icon:1},function(){
                                        location.reload();
                                    });
                                }
                            }
                        }else if(obj.msg == "原密码错误"){
                            $.layerMsg({content:"原密码错误" ,icon:2},function(){
                                // location.reload();
                            });
                        }else{
                            $.layerMsg({content:'<fmt:message code="url.th.PasswordModificationFailed" />！',icon:2},function(){
//                                 location.reload();
                        });
                        }
                    }
                });
            }else{
                $.layerMsg({content:'<fmt:message code="url.th.TwoPassword" />！',icon:0},function(){
                     location.reload();
                });
            }

        });




        //初始化修改登录日志列表显示
        logListShow();
    })
    //修改登录日志列表显示
    function logListShow(){
        $.ajax({
            type: "post",
            url: "/sys/getModifyPwdLog",
            dataType: 'json',
            success:function(data){
               var obj=data.obj;
               if(data.flag&&obj.length>0){
                   var str="";
                   for(var i=0;i<obj.length;i++){
                       str+='<tr><td>'+obj[i].userName+'</td><td>'+obj[i].time+'</td><td>'+obj[i].ip+'</td><td>'+obj[i].typeName+'</td><td>'+obj[i].remark+'</td></tr>';
                   }
                   $('.modifyPwdLogList').html(str.toString());
                   $('#lastEditTime').html(obj[0].time);
               }
            }
        })
    }

    /******************************************************验证用户输入******************************************************/


    function ValidateInput(element, value) {
//验证密码

        var i = start;
        var j = end;
        var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{1,}$/

        if(flag == 1 && !reg.test(value)){
            $.layerMsg({content:'密码必须包含大写字母、小写字母和数字',icon:6})
            return;
        }else if(flag == 0 && Evaluate(value) != 2){
            $.layerMsg({content:'密码必须包含字母和数字',icon:6})
            return;
        }

        if (element == "password") {
            if (value.toString().length < start) {
                $.layerMsg({content:'您的密码不到'+start+'<fmt:message code="system_setting.digit" />',icon:6})
//                 alert("您的密码不到6位")
                return;
            }
        }

    }



    /*================================密码强度 ===========Begin=======================================*/

    function Evaluate(word) {
        var low =/^[0-9]*$/;
        var mid=/^[A-Za-z0-9]+$/
        var big=/[0-9a-zA-Z\._\$%&\*\!]/


//        var low = /^(?:\d+|[a-zA-Z]+|[,.:;!@#$%^&*]+)$/  //密码强度为弱 纯数字，纯字母，纯特殊字符
//        var mid = /^(?![^a-zA-Z]+$)(?!\D+$).*$/  //密码强度为中 字母+数字，字母+特殊字符，数字+特殊字符
//        var big = /^.*(?=.*)(?=.*\d)(?=.*[A-Za-z])(?=.*[,.:;!@#$%^&*? ]).*$/  //密码强度为强 字母+数字+特殊字符


        if(low.exec(word)){
            return 1;
        }else if(mid.exec(word)){
            return 2;
        }else if(big.exec(word)){
            return 3;
        }else {
            return 1;
        }
    }
    function colorInit() {
        $('#low').css("backgroundColor","#fff")
        $('#medium').css("backgroundColor","#fff")
        $('#height').css("backgroundColor","#fff")

    }
    function validatePwdStrong(value) {
        if (Evaluate(value) == 1) {
            colorInit();
            $('#low').css("backgroundColor","red")
            $('#medium').css("backgroundColor","#fff")
            $('#height').css("backgroundColor","#fff")

        }
        else if (Evaluate(value) == 2) {
            colorInit();
            $('#low').css("backgroundColor","#dfff36")
            $('#medium').css("backgroundColor","#dfff36")
            $('#height').css("backgroundColor","#fff")

        }
        else if (Evaluate(value) == 3) {
            colorInit();
            $('#low').css("backgroundColor","#2dff44")
            $('#medium').css("backgroundColor","#2dff44")
            $('#height').css("backgroundColor","#2dff44")
            $('#height').css("width","70")

        }


    }

</script>

</body>
</html>

