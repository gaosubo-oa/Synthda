<%--
  Created by IntelliJ IDEA.
  User: jiazhimin
  Date: 2018/4/18
  Time: 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>系统参数设置</title>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" type="text/css" href="../lib/laydate/skins/default/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/dept/deptManagement.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/easyui/themes/easyui.css"/>
    <link rel="stylesheet" type="text/css" hcont_rigref="../lib/easyui/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <style>
        html,body{
            width:100%;
        }
        #search{
            margin-left: 360px;
            font-size: 16px;
        }
        #export{
            font-size: 16px;
        }
        .newNew tr td{
            border:none;
        }
        .newNew .tableHead tr td{
            border:1px solid #c0c0c0;
        }
        .ban{
            width: 80px;
            height: 28px;
            padding-left: 10px;
        }
        .left{
            float:left;
        }

        /*导航栏*/
        .header{
            position: fixed;
            width: 100%;
            background: #fff;
            width:100%;
            height:45px;
            border-bottom:1px solid #9E9E9E;
        }
        .nav{
            overflow:hidden;
        }
        .nav li{
            height:28px;
            line-height:28px;
            float:left;
            font-size:14px;
            margin-left:20px;
            margin-top:6px;
            cursor:pointer;
        }
        .space{
            width:2px;
            margin-left:16px;
        }
        .pad{
            padding:6px 14px;
            line-height:28px;
        }
        .pad a{
            color: #666;
        }
        .select{
            background-color:#2F8AE3;
            color:#fff;
            border-radius:20px;
            -webkit-border-radius:20px;
            -moz-border-radius:20px;
            -o-border-radius:20px;;
            -ms-border-radius:20px;
        }
        .select a{
            color: #fff;
        }
        /*content*/
        .tableTitle span{
            font-size:22px;
            color:#494d59;
            padding-left:20px;
        }
        .box{
            height:100%;
        }
        .word2,.word3{
            display: none !important;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../lib/laydate/laydate.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <style type="text/css">
        .divBtn{
            width: 120px;
            height: 30px;
            background: #2b7fe0;
            margin-top: 7px;
            cursor: pointer;
            line-height: 30px;
            margin-left:300px;
        }
        .header {
            height: auto;
            border-bottom: none;
            overflow: hidden;
            margin-bottom: 10px;
            position: fixed;
            top: 0px;
            width: 100%;
            background-color: #fff;
            z-index:1099;
        }
        h1{
            line-height: 45px;
            font-size: 22px;
        }
        table{
            width: 99%;
            margin-top: 125px;
            margin-left: 10px;
        }
        th{
            font-size: 13pt;
        }
        td{
            font-size: 11pt;
        }
        .saveBtn{
            width: 70px;
            height: 28px;
            margin: 0 auto;
            line-height: 28px;
            text-align: center;
            border-radius: 4px;
            cursor: pointer;
            background: url("../../img/confirm.png") no-repeat;
        }
        input[type="checkbox"],input[type="radio"]{
            background: transparent;
            border: 0;
        }
    </style>
    <script type="text/javascript">
        // 判断是否开启三员管理
        $.ajax({
            url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
            success:function(res) {
                var data = res.object[0];
                var userId = $.cookie("userId");
                if(data.paraValue == 0) {
                    if(userId == "admin") {
                        $("#emptyShowPas").hide();
                        $("#msgPushSet").hide();
                        $("#loginSecureKey").hide();
                        $("#userDeptOrder").hide();
                        $("#priv1DeleteUser").hide();
                        $("#pcFavoriteMenu").hide();
                        $("#demoSetting").hide();
                        $("#isCheckDemo").hide();
                        $("#sysPersionSelectOrg").hide();
                        $("#cacheSetting").hide();
                        $('#securitySystem').show()
                        $('#messageSetting').show()
                        $('#clientSetting').show()
                    } else if(userId == "secadm") {
                        $("#sysPersionSelectOrg").hide();
                        $("#cacheSetting").hide();
                        $("#useUserId").hide();
                        $("#emptyShowPas").hide();
                        $("#msgPushSet").hide();
                        $("#loginSecureKey").hide();
                        $("#userDeptOrder").hide();
                        $("#priv1DeleteUser").hide();
                        $("#pcFavoriteMenu").hide();
                        $("#demoSetting").hide();
                        $("#isCheckDemo").hide();
                    }else if(userId != "admin" && userId != "secadm") {
                        $('#securitySystem').hide()
                        $('#messageSetting').hide()
                        $('#clientSetting').hide()
                    }
                }

            }
        })
        $.ajax({
            url:"/syspara/querySecrecySysPara",
            success:function(res) {
                var data = res.obj;
                var result = data.filter(function(it) {
                    return it.paraName == "IS_USE_APP"
                })
                if(result[0].paraValue == 1) {
                    $('.showApp').hide()
                }else {
                    $('.show').show()
                }
            }
        })
        $(function(){
            if(!matchString($('#module').val(),'8')){
                $('input[name="AES_ENCRYPTION"]').attr('disabled','disabled')
            }
            if(!matchString($('#module').val(),'12')){
                $('input[name="LOGIN_SECURE_KEY"]').attr('disabled','disabled')
            }
            // $('input[name="DOCUMENT_PREVIEW_OPEN"]').change(function () {
            //     var num=$(this).val();
            //     if(num == '0'){
            //         $('input[name="WORD_TO_HTML_OPEN"][value="0"]').prop('checked','checked');
            //         $('.intnetShow').val('');
            //         $('.word2').hide();
            //         $('.word1').hide();
            //     }else if(num == '1'){
            //         $('input[name="WORD_TO_HTML_OPEN"][value="0"]').prop('checked','checked');
            //         $('.intnetShow').val('https://owa-box.vips100.com');
            //         $('.word2').hide();
            //         $('.word1').show();
            //     }else{
            //         $('input[name="WORD_TO_HTML_OPEN"][value="1"]').prop('checked','checked');
            //         $('.word1').hide();
            //         $('.word2').show();
            //     }
            // })
            $('input[name="WORD_TO_HTML_OPEN"]').change(function () {
                var num=$(this).val();
                if(num == '0'){
                    $('.word3').hide();
                }else if(num == '1'){
                    $('.word3').show();
                }
            })
            $('input[name="AES_ENCRYPTION"]').change(function () {
                var num=$(this).val();
                if(num == '1'){
                    $('input[name="KEY_ENCRYPTION"]').hide();
                }else{
                    $('input[name="KEY_ENCRYPTION"]').show();
                }
            })
//            获取外部服务地址
            $.ajax({
                type:'get',
                url:'/longin/mainstrBackUrl',
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        $('input[name="OUTSIDE_ADDRESS"]').val(res.obj1);
                    }
                }
            })
            $.ajax({
                type:'post',
                url:'/sysTasks/selectAll',
                dataType:'json',
                success:function (reg) {
                    var item=reg.obj;
//                    $('input[name="SEC_RETRY_BAN"]').attr("checked",item.sysUser);
//                    alert(item.sysUser);
//                    alert($("input[name='sysUser']").val());

                    for(var i=0;i<item.length;i++){
                        if(item[i].paraName =='USER_DEPT_ORDER' ){
                            $(":radio[name='USER_DEPT_ORDER'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='MSG_PUSH_SET' ){
                            $(":radio[name='MSG_PUSH_SET'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='USERID_LOGIN_SET' ){
                            $(":radio[name='USERID_LOGIN_SET'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='SEC_RETRY_BAN' ){

                            $(":radio[name='SEC_RETRY_BAN'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='AES_ENCRYPTION' ){

                            $(":radio[name='AES_ENCRYPTION'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                            if(item[i].paraValue==0){
                                $('input[name="KEY_ENCRYPTION"]').show();
                            }else{
                                $('input[name="KEY_ENCRYPTION"]').hide();
                            }
                        }
                        if(item[i].paraName =='KEY_ENCRYPTION'){
                             $('input[name="KEY_ENCRYPTION"]').val(item[i].paraValue);
                        }
                        if(item[i].paraName =='SEC_RETRY_TIMES' ){
                            $('input[name="SEC_RETRY_TIMES"]').val(item[i].paraValue);
                        }
                        if(item[i].paraName =='PASSWORD_VALIDITY_CHECK' ){
                            $('input[name="PASSWORD_VALIDITY_CHECK"]').val(item[i].paraValue);
                        }
                        if(item[i].paraName =='SYS_SESSION_TIME' ){
                            $('input[name="SYS_SESSION_TIME"]').val(item[i].paraValue);
                        }
                        if(item[i].paraName =='SEC_BAN_TIME' ){

                            $('input[name="SEC_BAN_TIME"]').val(item[i].paraValue);
                        }
                        if(item[i].paraName =='SEC_GRAPHIC' ){

                            $(":radio[name='SEC_GRAPHIC'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='PC_FAVORITE_MENU'){
                            $(":radio[name='PC_FAVORITE_MENU'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='LOGIN_DISPLACE'){
                            $(":radio[name='LOGIN_DISPLACE'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='EDIT_BYNAME'){
                            $(":radio[name='EDIT_BYNAME'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='SEC_INIT_PASS'){
                            $(":radio[name='SEC_INIT_PASS'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='LOGIN_SECURE_KEY'){
                            $(":radio[name='LOGIN_SECURE_KEY'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='SEC_INIT_PASS_SHOW'){
                            $(":radio[name='SEC_INIT_PASS_SHOW'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='SEC_PASS_FLAG'){
                            $(":radio[name='SEC_PASS_FLAG'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='SEC_PASS_MIN' ){

                            $('input[name="SEC_PASS_MIN"]').val(item[i].paraValue);
                        }
                        if(item[i].paraName =='SEC_PASS_MAX' ){

                            $('input[name="SEC_PASS_MAX"]').val(item[i].paraValue);
                        }
                        if(item[i].paraName =='SEC_PASS_SAFE'){
                            $(":radio[name='SEC_PASS_SAFE'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='PASSWORD_STRENGTH_CHECK'){
                            $(":radio[name='PASSWORD_STRENGTH_CHECK'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='RETRIEVE_PWD'){
                            $(":radio[name='RETRIEVE_PWD'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='SEC_USER_MEM'){
                            $(":radio[name='SEC_USER_MEM'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }

                        if(item[i].paraName =='OFFICE_EDIT'){
                            $(":radio[name='OFFICE_EDIT'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        if(item[i].paraName =='CAPTCHA'){
                            $(":radio[name='CAPTCHA'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }

                        // word转换html开关
                        if(item[i].paraName =='WORD_TO_HTML_OPEN'){
                            $(":radio[name='WORD_TO_HTML_OPEN'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        //word转换html地址
                        if(item[i].paraName =='WORD_TO_HTML_ADDRESS' ){
                            $('input[name="WORD_TO_HTML_ADDRESS"]').val(item[i].paraValue);
                        }

                        //允许app扫二维码登录
                        if(item[i].paraName =='QRCODE_LOGIN_SET' ){
                            $(":radio[name='QRCODE_LOGIN_SET'][value='" + item[i].paraValue + "']").prop("checked", "checked");
                        }
                        //app扫二维码登录密钥
                        if(item[i].paraName =='QRCODE_LOGIN_SECRET_KEY' ){
                            $('input[name="QRCODE_LOGIN_SECRET_KEY"]').val(item[i].paraValue);
                        }
                        //邮件附件大小
                        if(item[i].paraName =='ONE_ATTACHMENT_SIZE' ){
                            $('input[name="ONE_ATTACHMENT_SIZE"]').val(item[i].paraValue);
                        }



//                        if(item[i].paraName =='ONE_USER_MUL_LOGIN'){
//                            $(":radio[name='ONE_USER_MUL_LOGIN'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='MOBILE_PC_OPTION'){
//                            $(":radio[name='MOBILE_PC_OPTION'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='LOGIN_KEY'){
//                            $(":radio[name='LOGIN_KEY'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='SEC_KEY_USER'){
//                            $(":radio[name='SEC_KEY_USER'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='LOGIN_SECURE_KEY'){
//                            $(":radio[name='LOGIN_SECURE_KEY'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='LOGIN_USE_DOMAIN'){
//                            $(":radio[name='LOGIN_USE_DOMAIN'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='SEC_SHOW_IP'){
//                            $(":radio[name='SEC_SHOW_IP'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='SEC_ON_STATUS'){
//                            $(":radio[name='SEC_ON_STATUS'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='SEC_OC_MARK'){
//                            $(":radio[name='SEC_OC_MARK'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='SEC_OC_REVISION'){
//                            $(":radio[name='SEC_OC_REVISION'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='PUSH_TD_NOTICE'){
//                            $(":radio[name='PUSH_TD_NOTICE'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='USE_DISCUZ'){
//                            $(":radio[name='USE_DISCUZ'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='SEC_USE_RTX'){
//                            $(":radio[name='SEC_USE_RTX'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='MOBILE_PUSH_OPTION'){
//                            $(":radio[name='MOBILE_PUSH_OPTION'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='PCONLINE_MOBILE_PUSH'){
//                            $(":radio[name='PCONLINE_MOBILE_PUSH'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }
//                        if(item[i].paraName =='SECURE_DOC_OPTION'){
//                            $(":radio[name='SECURE_DOC_OPTION'][value='" + item[i].paraValue + "']").prop("checked", "checked");
//                        }

                    }
                }
            })
            $.ajax({
                type:'get',
                url:'/syspara/selectDemo',
                dataType:'json',
                data:{
                    paraName:'IS_CHECK_DEMO'
                },
                success:function (res) {
                    if(res.flag){
                        $('input[name="IS_CHECK_DEMO"][value="'+res.object.paraValue+'"]').prop('checked','checked');
                    }
                }
            })
            $.ajax({
                type:'get',
                url:'/syspara/selectByParaName',
                dataType:'json',
                data:{
                    paraName:'PRIV1_DELETE_USER'
                },
                success:function (res) {
                    if(res.flag){
                        $('input[name="PRIV1_DELETE_USER"][value="'+res.object+'"]').prop('checked','checked');
                    }
                }
            })
            $.ajax({
                type:'get',
                url:'/sysTasks/selectPreview',
                dataType:'json',
                success:function (res) {
                    if(res.flag){
                        $('input[name="DOCUMENT_PREVIEW"]').val(res.obj.paraValue?res.obj.paraValue:"");
                    }
                }
            })
            // $.ajax({
            //     type:'get',
            //     url:'/sysTasks/selectPreviewOpen',
            //     dataType:'json',
            //     success:function (res) {
            //         if(res.flag){
            //             $('input[name="DOCUMENT_PREVIEW_OPEN"][value="'+res.object.paraValue+'"]').prop('checked','checked');
            //             if(res.object.paraValue == '0'){
            //                 $('.word2').hide();
            //                 $('.word1').hide();
            //             }else if(res.object.paraValue == '1'){
            //                 $('.word2').hide();
            //                 $('.word1').show();
            //             }else{
            //                 $('.word1').hide();
            //                 $('.word2').show();
            //             }
            //         }
            //     }
            // })
            //点击确定
            $('.saveBtn').click(function () {
                var arr=[];
                var object0={};
                object0.paraName="PC_FAVORITE_MENU";//COMMON_APP
                object0.paraValue=$('input[name="PC_FAVORITE_MENU"]:checked').val();
                arr.push(object0);
                var object1={};
                object1.paraName="EDIT_BYNAME";
                object1.paraValue=$('input[name="EDIT_BYNAME"]:checked').val();
                arr.push(object1);
                var object2={};
                object2.paraName="SEC_INIT_PASS";
                object2.paraValue=$('input[name="SEC_INIT_PASS"]:checked').val();
                arr.push(object2);
                var object3={};
                object3.paraName="SEC_PASS_FLAG";
                object3.paraValue=$('input[name="SEC_PASS_FLAG"]:checked').val();
                arr.push(object3);
                if($('input[name="SEC_PASS_MIN"]').val() < 6){
                    layer.msg('密码位数最少是6位', {icon: 2,time:3000,title: "温馨提示",offset:"40%"});
                    return false;
                }
                var object4={};
                object4.paraName="SEC_PASS_MIN";
                object4.paraValue=$('input[name="SEC_PASS_MIN"]').val();
                arr.push(object4);
                var object5={};
                object5.paraName="SEC_PASS_MAX";
                object5.paraValue=$('input[name="SEC_PASS_MAX"]').val();
                arr.push(object5);
                var object6={};
                object6.paraName="SEC_PASS_SAFE";
                object6.paraValue=$('input[name="SEC_PASS_SAFE"]:checked').val();
                arr.push(object6);
                var object7={};
                object7.paraName="RETRIEVE_PWD";
                object7.paraValue=$('input[name="RETRIEVE_PWD"]:checked').val();
                arr.push(object7);
                var object8={};
                object8.paraName="SEC_USER_MEM";
                object8.paraValue=$('input[name="SEC_USER_MEM"]:checked').val();
                arr.push(object8);
                var object9={};
                object9.paraName="SEC_RETRY_BAN";
                object9.paraValue=$('input[name="SEC_RETRY_BAN"]:checked').val();
                arr.push(object9);
                var object10={};
                object10.paraName="SEC_RETRY_TIMES";
                object10.paraValue=$('input[name="SEC_RETRY_TIMES"]').val();
                arr.push(object10);
                var object11={};
                object11.paraName="SEC_BAN_TIME";
                object11.paraValue=$('input[name="SEC_BAN_TIME"]').val();
                arr.push(object11);
                var object12={};
                object12.paraName="SEC_GRAPHIC";
                object12.paraValue=$('input[name="SEC_GRAPHIC"]:checked').val();
                arr.push(object12);
                var object13={};
                object13.paraName="SEC_INIT_PASS_SHOW";
                object13.paraValue=$('input[name="SEC_INIT_PASS_SHOW"]:checked').val();
                arr.push(object13);
                var object14={};
                object14.paraName="LOGIN_SECURE_KEY";
                object14.paraValue=$('input[name="LOGIN_SECURE_KEY"]:checked').val();
                arr.push(object14);
                 var object15={};
                object15.paraName="OFFICE_EDIT";
                object15.paraValue=$('input[name="OFFICE_EDIT"]:checked').val();
                arr.push(object15);
                var object16={};
                object16.paraName="CAPTCHA";
                object16.paraValue=$('input[name="CAPTCHA"]:checked').val();
                arr.push(object16);
                var object17={};
                object17.paraName="USER_DEPT_ORDER";
                object17.paraValue=$('input[name="USER_DEPT_ORDER"]:checked').val();
                arr.push(object17);
                // 是否允许系统管理员删除用户开始
                var object18={};
                object18.paraName="PRIV1_DELETE_USER";
                object18.paraValue=$('input[name="PRIV1_DELETE_USER"]:checked').val();
                arr.push(object18);
                // 是否允许系统管理员删除用户结束

                // word转换html开关
                var object19={};
                object19.paraName="WORD_TO_HTML_OPEN";
                object19.paraValue=$('input[name="WORD_TO_HTML_OPEN"]:checked').val();
                arr.push(object19);
                // word转换html地址
                var object20={};
                object20.paraName="WORD_TO_HTML_ADDRESS";
                object20.paraValue=$('input[name="WORD_TO_HTML_ADDRESS"]').val();
                arr.push(object20);
                // var object21={};
                // object21.paraName="PASSWORD_NULL_TIPS";
                // object21.paraValue=$('input[name="PASSWORD_NULL_TIPS"]:checked').val();
                // arr.push(object21);
                var object21={};
                object21.paraName="QRCODE_LOGIN_SET";
                object21.paraValue=$('input[name="QRCODE_LOGIN_SET"]:checked').val();
                arr.push(object21);
                // 密码强度不够,登录时强制修改密码
                var object22={};
                object22.paraName="PASSWORD_STRENGTH_CHECK";
                object22.paraValue=$('input[name="PASSWORD_STRENGTH_CHECK"]:checked').val();
                arr.push(object22);
                // 密码设置有效期,登录时强制修改密码
                var object23={};
                object23.paraName="PASSWORD_VALIDITY_CHECK";
                object23.paraValue=$('input[name="PASSWORD_VALIDITY_CHECK"]').val();
                arr.push(object23);
                //app扫二维码登陆密码
                var object24={};
                object24.paraName="QRCODE_LOGIN_SECRET_KEY";
                object24.paraValue=$('input[name="QRCODE_LOGIN_SECRET_KEY"]').val();
                arr.push(object24);
                //邮件附件大小
                var object25={};
                object25.paraName="ONE_ATTACHMENT_SIZE";
                object25.paraValue=$('input[name="ONE_ATTACHMENT_SIZE"]').val();
                arr.push(object25);
                //是否启用消息推送和天气预报
                var object26={};
                object26.paraName="MSG_PUSH_SET";
                object26.paraValue=$('input[name="MSG_PUSH_SET"]:checked').val();
                arr.push(object26);
                //允许使用用户ID登录（一般应使用用户名登录）
                var object27={};
                object27.paraName="USERID_LOGIN_SET";
                object27.paraValue=$('input[name="USERID_LOGIN_SET"]:checked').val();
                arr.push(object27);
                //登录后无操作，会话失效时间
                var object28={};
                object28.paraName="SYS_SESSION_TIME";
                object28.paraValue=$('input[name="SYS_SESSION_TIME"]').val();
                arr.push(object28);
                //相同账号只允许同时登录一个
                var object29={};
                object29.paraName="LOGIN_DISPLACE";
                object29.paraValue=$('input[name="LOGIN_DISPLACE"]:checked').val();
                arr.push(object29);
                $.ajax({
                    type:'post',
                    url:'/sysTasks/updateSysTasks',
                    dataType:'json',
                    data:{
                        jsonStr:JSON.stringify(arr)
                    },
                    success:function (res) {
                        if(res.flag){
                            var str='修改成功'
                            layer.msg(str, {icon: 1,time:3000,title: "温馨提示",offset:"40%"});
                        }else {
                            layer.msg('修改失败！', {icon: 2,time:3000,title: "温馨提示",offset:"40%"});
                        }
                    }
                })
                $.ajax({
                    type:'post',
                    url:'/syspara/updateDemo',
                    dataType:'json',
                    data:{
                        paraName:'IS_CHECK_DEMO',
                        paraValue:$('input[name="IS_CHECK_DEMO"]:checked').val()
                    },
                    success:function (res) {
                        if(res.flag){
                        }else {
                            layer.msg('修改失败！', {icon: 2});
                        }
                    }
                })
                // 是否允许系统管理员删除用户修改接口开始
                $.ajax({
                    type:'get',
                    url:'/syspara/updateSysParaPlus',
                    dataType:'json',
                    data:{
                        paraName:'PRIV1_DELETE_USER',
                        paraValue:$('input[name="PRIV1_DELETE_USER"]:checked').val()
                    },
                    success:function (res) {
                        if(res.flag){
                        }else {
                            layer.msg('修改失败！', {icon: 2});
                        }
                    }
                })
                // 是否允许系统管理员删除用户修改接口结束
                var data1={
                    paraName:'DOCUMENT_PREVIEW',
                    paraValue:$('.intnetShow').val(),
                }
                var data2={
                    paraName:'OUTSIDE_ADDRESS',
                    paraValue:$('input[name="OUTSIDE_ADDRESS"]').val(),
                }
                getView(data1);
                getView(data2);

                $.ajax({  // 附件加密
                    type:'post',
                    url:'/sysTasks/setEncryptionKEY',
                    dataType:'json',
                    data:{
                        Switch:$("input[name='AES_ENCRYPTION']:checked").val(),
                        key:$("input[name='AES_ENCRYPTION']:checked").val()== 0?$("input[name='KEY_ENCRYPTION']").val():''
                    },
                    success:function (res) {
                        if(res.flag){

                        }else{
                            layer.msg('修改失败！', {icon: 2});
                        }
                    }
                })
            })
        })
        function getView(data) {
            $.ajax({  //office文档在线预览服务器
                type:'post',
                url:'/sysTasks/upPreview',
                dataType:'json',
                data:data,
                success:function (res) {
                    if(res.flag){

                    }else{
                        layer.msg('修改失败！', {icon: 2});
                    }
                }
            })
        }
        //更新
       function changeRadioParaValue(paraName,paraValue) {
           $.ajax({
               url:'/sysTasks/updateSysTasks',
               data:{
                   paraName:paraName,
                   paraValue:paraValue
               },
               dataType:'json',
               success:function (reg) {
                  if(reg.flag){
                      var str='修改成功'
                      layer.msg(str, {icon: 1});
                      window.location.reload();
                  }else{
                      layer.msg(reg.msg, {icon: 2});
                  }
               }
           })
       }
       function changetextParaValue(paraName){
           var paraValue=$('input[name='+paraName+']').val();
           $.ajax({
               url:'/sysTasks/updateSysTasks',
               data:{
                   paraName:paraName,
                   paraValue:paraValue
               },
               dataType:'json',
               success:function (reg) {
                   if(reg.flag){
                       alert("修改成功");
                   }else{
                       alert("修改失败");
                   }
               }
           })
       }
    </script>
</head>
<body>
<input type="hidden" value="${sessionScope.module }" id="module">
    <div class="header">
        <ul class="nav" style="height: 43px;border-bottom: 1px solid #9E9E9E;">
            <li url="/vote/manage/publishVote">
                <span class="select pad"><a href="#"><fmt:message code="system_config.basic_parameter_setting" /></a></span>
                <img class="space" src="../../img/twoth.png" alt="">
            </li>

            <li id="messageSetting" style="margin-top:6px;" url="/vote/manage/unPublishVote">
                <span class="pad"><a href="/sysTasks/getIMTasks"><fmt:message code="system_config.instant_messaging_setting" /></a></span>
                <img class="space" src="../../img/twoth.png" alt="">
            </li>

            <li style="margin-top:6px;" url="/sysTasks/sysPersionSelectOrg" id="sysPersionSelectOrg">
                <span class="pad"><a href="/sysTasks/sysPersionSelectOrg"><fmt:message code="system_config.branch_global_setting" /></a></span>
                <img class="space" src="../../img/twoth.png" alt="">
            </li>
            <li id="clientSetting" style="margin-top:6px;" url="/sysTasks/sysPersionSelectOrg">
                <span class="pad"><a href="/sysTasks/ClientSeting"><fmt:message code="system_config.client_version_number" /></a></span>
                <img class="space" src="../../img/twoth.png" alt="">
            </li>
            <li style="margin-top:6px;" url="/sysTasks/cacheSetting" id="cacheSetting">
                <span class="pad"><a href="/sysTasks/opencache"><fmt:message code="system_config.cache_setting" /></a></span>
                <img class="space" src="../../img/twoth.png" alt="">
            </li>
            <li id="securitySystem" style="margin-top:9px;" url="/sysTasks/ClassifiedSetting">
                <span class="pad"><a href="/sysTasks/ClassifiedSetting"><fmt:message code="system_config.confidential_system_setting" /></a></span>
            </li>
        </ul>
        <h1 style="height: 80px;line-height: 80px;">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
            <fmt:message code="system_config.basic_parameter_setting" />
        </h1>
    </div>

    <div>
        <%--<form action="/sysTasks/updateSysTasks" method="post">--%>
            <table>
                <thead>
                <th><fmt:message code="system_setting.option" /></th>
                <th><fmt:message code="system_setting.parameter" /></th>
                <th><fmt:message code="system_setting.remark" /></th>
                </thead>
                <tbody>
                <tr>
                    <td nowrap="" colspan="3" align="left" style="border-bottom:1px solid #c0c0c0;">
                        <img src="/img/sys/icon_jichu.png" style="float:left;margin-right: 12px;vertical-align: baseline;">
                        <b style="color: #2F5C8F; font-size: 13pt; vertical-align: middle;"><fmt:message code="system_setting.basic_parameter_setting" /></b>
                    </td>
                </tr>
                <tr><td><fmt:message code="system_setting.same_account_login_limit" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="LOGIN_DISPLACE"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="LOGIN_DISPLACE"  value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                    </td>
                <tr>
                    <td><fmt:message code="system_setting.login_session_timeout" /></td>
                    <td>
                        <label for="">
                            <input type="text" style="width:20px" name="SYS_SESSION_TIME"> <fmt:message code="system_setting.minute" />
                        </label>
                    </td>
                    <td>
                    </td>
                </tr>
                </tr>
                <tr><td><fmt:message code="system_setting.allow_username_modify" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="EDIT_BYNAME"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="EDIT_BYNAME"  value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.username_modify_remark" />
                    </td>
                </tr>
                <tr id="useUserId"><td><fmt:message code="system_setting.use_user_id_login" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="USERID_LOGIN_SET"  value="1" checked>
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="USERID_LOGIN_SET"  value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr id="emptyShowPas"><td><fmt:message code="system_setting.empty_pass_show_modify" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="SEC_INIT_PASS_SHOW"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="SEC_INIT_PASS_SHOW" checked  value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.empty_pass_show_modify_remark" />
                    </td>
                </tr>
                <tr><td><fmt:message code="system_setting.init_pass_show_modify" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="SEC_INIT_PASS"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="SEC_INIT_PASS"  value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.init_pass_show_modify_remark" />
                    </td>
                </tr>

                <tr><td><fmt:message code="system_setting.enable_captcha" /></td>
                    <td>
                        <label for="">
                            <input type="radio"  name="CAPTCHA"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="CAPTCHA" checked value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.enable_captcha_remark" />
                    </td>
                </tr>

                <tr id="msgPushSet"><td><fmt:message code="system_setting.close_msg_push" /></td>
                    <td>
                        <label for="">
                            <input type="radio"  name="MSG_PUSH_SET"  value="0">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="MSG_PUSH_SET" checked value="1">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.close_msg_push_remark" />
                    </td>
                </tr>

                <tr id="loginSecureKey"><td><fmt:message code="system_setting.enable_dynamic_password_card" /></td>
                    <td>
                        <label for="">
                            <input type="radio"  name="LOGIN_SECURE_KEY"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="LOGIN_SECURE_KEY" checked value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.enable_dynamic_password_card_remark" />
                    </td>
                </tr>
                <tr><td><fmt:message code="system_setting.password_length" /></td>
                    <td>
                        <label for="">
                            <input type="text" style="width:20px" name="SEC_PASS_MIN"> <fmt:message code="system_setting.digit" />-
                        </label>
                        <label for="">
                            <input type="text" style="width:20px" name="SEC_PASS_MAX" > <fmt:message code="system_setting.digit" />
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.password_length_remark" />
                    </td>
                </tr>
                <tr><td><fmt:message code="system_setting.password_safety" /></td>
                    <td>
                        <label for="" style="display: block">
                            <input type="radio" name="SEC_PASS_SAFE"  value="0">
                            <span><fmt:message code="system_setting.no_limit" /></span>
                        </label>
                        <label for="" style="display: block" >
                            <input type="radio" name="SEC_PASS_SAFE"  value="1">
                            <span><fmt:message code="system_setting.password_contains_letter_number" /></span>
                        </label>
                        <label for="" style="display: block">
                            <input type="radio" name="SEC_PASS_SAFE"  value="2">
                            <span><fmt:message code="system_setting.password_contains_letter_number_symbol" /></span>
                        </label>
                        <label for="" style="display: block">
                            <input type="radio" name="SEC_PASS_SAFE"  value="3">
                            <span><fmt:message code="system_setting.password_contains_uppercase_lowercase_number" /></span>
                        </label>
                        <label for="" style="display: block">
                            <input type="radio" name="SEC_PASS_SAFE"  value="4">
                            <span><fmt:message code="system_setting.password_contains_uppercase_lowercase_number_symbol" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.password_safety_remark" />
                    </td>
                </tr>
                <tr>
                    <td><fmt:message code="system_setting.force_modify_password_weak" /></td>
                    <td>
                        <label for="">
                            <input type="radio"  name="PASSWORD_STRENGTH_CHECK"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="PASSWORD_STRENGTH_CHECK" checked value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td><fmt:message code="system_setting.password_validity" /></td>
                    <td>
                        <label for="">
                            <input type="text" style="width:20px" name="PASSWORD_VALIDITY_CHECK"> <fmt:message code="system_setting.day" />
                        </label>
                    </td>
                    <td>

                    </td>
                </tr>
                <tr><td><fmt:message code="system_setting.login_error_limit" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="SEC_RETRY_BAN"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="SEC_RETRY_BAN"  value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                        <label style="margin: 0 10px">
                            <fmt:message code="system_setting.login_error_exceed" /> <input type="text" style="width:20px" name="SEC_RETRY_TIMES"> <fmt:message code="system_setting.time" /> <input type="text" style="width:20px" name="SEC_BAN_TIME"> <fmt:message code="system_setting.minute" /> <fmt:message code="system_setting.can_login" />
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.login_error_limit_remark" />
                    </td>
                </tr>
                <tr class="showApp">
                    <td><fmt:message code="system_setting.allow_app_qr_login" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="QRCODE_LOGIN_SET"  value="1" checked>
                            <span><fmt:message code="system_setting.open" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="QRCODE_LOGIN_SET"  value="0">
                            <span><fmt:message code="system_setting.close" /></span>
                        </label>
                    </td>
                    <td></td>
                </tr>
                <tr class="showApp">
                    <td><fmt:message code="system_setting.app_qr_login_secret_key" /></td>
                    <td>
                        <input type="" name="QRCODE_LOGIN_SECRET_KEY"  style="width: 200px" >
                    </td>
                    <td></td>
                </tr>
                <tr id="userDeptOrder">
                    <td><fmt:message code="system_setting.department_user_order" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="USER_DEPT_ORDER"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="USER_DEPT_ORDER"  value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.department_user_order_remark" />
                    </td>
                </tr>
                <tr id="priv1DeleteUser">
                    <td><fmt:message code="system_setting.only_admin_delete_user" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="PRIV1_DELETE_USER"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="PRIV1_DELETE_USER" checked value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.only_admin_delete_user_remark" />
                    </td>
                </tr>
                <tr><td><fmt:message code="system_setting.enable_attachment_encryption" /></td>
                    <td>
                        <label for="">
                            <input type="radio"  name="AES_ENCRYPTION"  value="0">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="AES_ENCRYPTION" checked value="1">
                            <span><fmt:message code="system_setting.no" /> :</span>
                        </label>
                        <input type="text" style="display: none;width: 150px;" maxlength="16" onkeyup="value=value.replace(/[^0-9a-zA-Z]/g,'')" name="KEY_ENCRYPTION" >
                    </td>
                    <td >
                        <fmt:message code="system_setting.enable_attachment_encryption_remark" />
                    </td>
                </tr>
                <tr>
                    <td><fmt:message code="system_setting.single_file_upload_size" /></td>
                    <td>
                        <input type="" name="ONE_ATTACHMENT_SIZE" value="0"  style="width: 100px" >M
                    </td>
                    <td>
                        <fmt:message code="system_setting.single_file_upload_size_remark" />
                    </td>
                </tr>
                <tr id="pcFavoriteMenu"><td><fmt:message code="system_setting.pc_favorite_menu" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="PC_FAVORITE_MENU"  value="1">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="PC_FAVORITE_MENU"  value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                </tr>
                <tr style="border-bottom: none;display: none">
                    <td><fmt:message code="system_setting.document_preview" /></td>
                    <td colspan="2">
                        <label>
                            <input type="radio" name="DOCUMENT_PREVIEW_OPEN" value="2">
                            <span style="margin-right: 10px;"><fmt:message code="system_setting.built_in_preview_service" /></span>
                        </label>
                        <label>
                            <input type="radio" name="DOCUMENT_PREVIEW_OPEN" checked value="1">
                            <span style="margin-right: 10px;"><fmt:message code="system_setting.microsoft_preview_service" /></span>
                        </label>
                        <label>
                            <input type="radio" name="DOCUMENT_PREVIEW_OPEN" value="0">
                            <span><fmt:message code="system_setting.close" /></span>
                        </label>

                    </td>

                </tr>
                <tr class="word1" style="border-bottom: none;border-top: none;display: none">
                    <td><fmt:message code="system_setting.office_server" /></td>
                    <td><input type="text" class="intnetShow" style="width: 230px;" name="DOCUMENT_PREVIEW" value="https://owa-box.vips100.com"></td>
                    <td>
                        <fmt:message code="system_setting.also_can_use_server" />
                        <fmt:message code="system_setting.another_server_address" />
                    </td>
                </tr>
                <tr class="word2" style="border-bottom: none;border-top: none;display: none">
                    <td><fmt:message code="system_setting.word_to_html" /></td>
                    <td colspan="2">
                        <label>
                            <input type="radio" name="WORD_TO_HTML_OPEN" checked value="1">
                            <span style="margin-right: 10px;"><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label>
                            <input type="radio" name="WORD_TO_HTML_OPEN" value="0">
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>

                    </td>
                </tr>
                <tr class="word2 word3" style="border-bottom: none;border-top: none;display: none">
                    <td><fmt:message code="system_setting.microsoft_office_server_address" /></td>
                    <td>
                        <label>
                            <input type="text" class="wordToHtmlAddress" style="width: 230px;" name="WORD_TO_HTML_ADDRESS" value="http://127.0.0.1:8080">
                        </label>
                    </td>
                    <td>
                        <fmt:message code="system_setting.example" />
                        <fmt:message code="system_setting.address_example" />
                    </td>
                </tr>

                <tr style="display: none">
                    <td><fmt:message code="system_setting.office_edit" /></td>
                    <td >
                        <label >
                            <input type="radio" name="OFFICE_EDIT" checked value="1">
                            <span style="margin-right: 10px;"><fmt:message code="system_setting.dianju_plugin" /></span>
                        </label>
                        <label >
                            <input type="radio" name="OFFICE_EDIT" value="0">
                            <span><fmt:message code="system_setting.ruanhang_plugin" /></span>
                        </label>

                    </td>
                    <td>
                        <fmt:message code="system_setting.office_edit_remark" />
                    </td>
                </tr>
                <tr style="border-bottom: none;border-top: none;display: none">
                    <td><fmt:message code="system_setting.outside_address" /></td>
                    <td class="externalServices">
                        <input type="text" name="OUTSIDE_ADDRESS" style="width: 230px;" placeholder="<fmt:message code="system_setting.please_fill_address" />">
                    </td>
                    <td><fmt:message code="system_setting.address_example_info" /></td>
                </tr>
                <tr id="demoSetting">
                    <td nowrap="" colspan="3" align="left" style="border-bottom:1px solid #c0c0c0;">
                        <img src="/img/sys/icon_yanshi.png" style="float:left;margin-right: 12px;vertical-align: baseline;">
                        <b style="color: #2F5C8F; font-size: 13pt; vertical-align: middle;"><fmt:message code="system_setting.demo_setting" /></b>
                    </td>
                </tr>
                <tr id="isCheckDemo">
                    <td><fmt:message code="system_setting.is_demo_system" /></td>
                    <td>
                        <label for="">
                            <input type="radio" name="IS_CHECK_DEMO"  value="0">
                            <span><fmt:message code="system_setting.yes" /></span>
                        </label>
                        <label for="">
                            <input type="radio" name="IS_CHECK_DEMO"  value="1" checked>
                            <span><fmt:message code="system_setting.no" /></span>
                        </label>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <div class="saveBtn"><span style="margin-left: 20px;font-size: 10px"><fmt:message code="system_setting.confirm" /></span></div>
                    </td>
                </tr>
                </tbody>
            </table>

        <%--</form>--%>

    </div>
</body>
</html>
