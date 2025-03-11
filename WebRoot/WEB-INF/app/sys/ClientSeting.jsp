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
</head>
<body>
<div class="header">
    <ul class="nav" style="height: 43px;border-bottom: 1px solid #9E9E9E;">
        <li url="/vote/manage/publishVote">
            <span class="pad"><a href="/sysTasks/sysTaskIndex"><fmt:message code="system_config.basic_parameter_setting" /></a></span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>

        <li id="messageSetting" style="margin-top:6px;"  url="/vote/manage/unPublishVote">
            <span class="pad"><a href="/sysTasks/getIMTasks"><fmt:message code="system_config.instant_messaging_setting" /></a></span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li style="margin-top:6px;" url="/sysTasks/sysPersionSelectOrg" id="sysPersionSelectOrg">
            <span class="pad"><a href="/sysTasks/sysPersionSelectOrg"><fmt:message code="system_config.branch_global_setting" /></a></span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li  style="margin-top:6px;" url="#">
            <span class="select pad "><a href="/sysTasks/ClientSeting"><fmt:message code="system_config.client_version_number" /></a></span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li style="margin-top:6px;" url="/sysTasks/opencache" id="cacheSetting">
            <span class="pad"><a href="/sysTasks/opencache"><fmt:message code="system_config.cache_setting" /></a></span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li id="securitySystem" style="margin-top:9px;" url="/sysTasks/ClassifiedSetting">
            <span class="pad"><a href="/sysTasks/ClassifiedSetting"><fmt:message code="system_config.confidential_system_setting" /></a></span>
        </li>
    </ul>
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        <fmt:message code="system_config.client_version_number" />
    </h1>
</div>

<div>
    <table>
        <thead>
        <tr>
            <th><fmt:message code="system_config.option" /></th>
            <th><fmt:message code="system_config.version_number" /></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td style="text-align: center;"><fmt:message code="system_config.pc_client_version_number" /></td>
            <td style="text-align: center;">
                <label for="">
                    <input type="text" style="width:200px" name="pcVersion" >
                </label>
            </td>
        </tr>
        <tr class="showApp">
            <td style="text-align: center;"><fmt:message code="system_config.ios_client_version_number" /></td>
            <td style="text-align: center;">
                <label for="">
                    <input type="text" style="width:200px" name="iosVersion" >
                </label>
            </td>
        </tr>
        <tr class="showApp">
            <td style="text-align: center;"><fmt:message code="system_config.android_client_version_number" /></td>
            <td style="text-align: center;">
                <label for="">
                    <input type="text" style="width:200px" name="AndroidVersion" >
                </label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <div class="saveBtn"><span style="margin-left: 20px;font-size: 10px"><fmt:message code="system_config.confirm" /></span></div>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<script>

    $(function(){


        // 判断是否开启三员管理
        $.ajax({
            url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
            success:function(res) {
                var data = res.object[0];
                var userId = $.cookie("userId");
                if(data.paraValue == 0 ) {
                    if(userId == "admin") {
                        $("#sysPersionSelectOrg").hide();
                        $("#cacheSetting").hide();
                        $('#securitySystem').show()
                        $('#messageSetting').show()
                        $('#clientSetting').show()
                    }else {
                        $("#sysPersionSelectOrg").hide();
                        $("#cacheSetting").hide();
                        $('#securitySystem').hide()
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
        $.ajax({
            type:'post',
            url:'/syspara/selectSysPCAI',
            dataType:'json',
            success:function(res){
                if(res){
                    $('input[name="pcVersion"]').val(res.APP_PC_Version);
                    $('input[name="iosVersion"]').val(res.APP_IOS_Version);
                    $('input[name="AndroidVersion"]').val(res.APP_Android_Version);
                }
            }
        })
        //点击确定
        $('.saveBtn').click(function () {

            var object1={};
            object1.pcVersion=$('input[name="pcVersion"]').val();
            object1.iosVersion=$('input[name="iosVersion"]').val();
            object1.AndroidVersion=$('input[name="AndroidVersion"]').val();


            $.ajax({
                type:'post',
                url:'/code/editServerVersion',
                dataType:'json',
                data:object1,
                success:function (res) {
                    if(res.flag){
                        var str='保存成功'
                        layer.msg(str, {icon: 1});
                    }else {
                        layer.msg('保存失败！', {icon: 2});
                    }
                }
            })
        })
    })

</script>
</body>
</html>
