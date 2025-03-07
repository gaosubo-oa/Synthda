<%--
  Created by IntelliJ IDEA.
  User: leove
  Date: 2023/3/17
  Time: 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>涉密系统设置</title>
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
<input type="hidden" value="${sessionScope.module }" id="module">
<div class="header">
    <ul class="nav" style="height: 43px;border-bottom: 1px solid #9E9E9E;">
        <li url="/vote/manage/publishVote">
            <span class="pad"><a href="/sysTasks/sysTaskIndex"><fmt:message code="system_config.basic_parameter_setting" /></a></span>
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
            <span class="pad "><a href="/sysTasks/ClientSeting"><fmt:message code="system_config.client_version_number" /></a></span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li style="margin-top:6px;" url="/sysTasks/opencache" id="cacheSetting">
            <span class="pad"><a href="/sysTasks/opencache"><fmt:message code="system_config.cache_setting" /></a></span>
            <img class="space" src="../../img/twoth.png" alt="">
        </li>
        <li style="margin-top:9px;" url="#" >
            <span class="select pad"><a href="/sysTasks/ClassifiedSetting"><fmt:message code="system_config.confidential_system_setting" /></a></span>
        </li>
    </ul>
    <h1 style="height: 80px;line-height: 80px;">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/faceSetting.png" style="margin-top: 29px;float: left;margin-left: 30px;margin-right: 7px;">
        <fmt:message code="system_config.confidential_system_setting" />
    </h1>
</div>

<div>
    <%--<form action="/sysTasks/updateSysTasks" method="post">--%>
        <table>
            <thead>
            <th><fmt:message code="system_config.option" /></th>
            <th><fmt:message code="system_config.parameter" /></th>
            <th><fmt:message code="system_config.remark" /></th>
            </thead>
            <tbody>
            <tr>
                <td nowrap="" colspan="3" align="left" style="border-bottom:1px solid #c0c0c0;">
                    <img src="/img/sys/icon_jichu.png" style="float:left;margin-right: 12px;vertical-align: baseline;">
                    <b style="color: #2F5C8F; font-size: 13pt; vertical-align: middle;"><fmt:message code="system_config.confidential_system_setting" /></b>
                </td>
            </tr>
            <tr>
                <td><fmt:message code="system_config.enable_three_member_management" /></td>
                <td style="text-align: center;">
                    <label for="">
                        <input type="radio" name="IS_OPEN_SANYUAN" value="0">
                        <span><fmt:message code="system_config.yes" /></span>
                    </label>
                    <label for="">
                        <input type="radio" name="IS_OPEN_SANYUAN" value="1" checked>
                        <span><fmt:message code="system_config.no" /></span>
                    </label>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td><fmt:message code="system_config.enable_internet_and_app_functions" /></td>
                <td style="text-align: center;">
                    <label for="">
                        <input type="radio" name="IS_USE_APP" value="0" checked>
                        <span><fmt:message code="system_config.yes" /></span>
                    </label>
                    <label for="">
                        <input type="radio" name="IS_USE_APP" value="1">
                        <span><fmt:message code="system_config.no" /></span>
                    </label>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 250px;"><fmt:message code="system_config.show_confidential_level_text_on_main_page" /></td>
                <td style="width: 370px; text-align: center">
                    <label for="">
                        <input type="radio" name="IS_SHOW_JMJ" value="1">
                        <span><fmt:message code="system_config.yes" /></span>
                    </label>
                    <label for="">
                        <input type="radio" name="IS_SHOW_JMJ" value="0" checked>
                        <span><fmt:message code="system_config.no" /></span>
                    </label>
                </td>
                <td>
                    <fmt:message code="system_config.show_confidential_level_identifier_on_main_interface" />
                </td>
            </tr>
            <tr>
                <td><fmt:message code="system_config.show_secret_level_field_in_module_data" /></td>
                <td style="text-align: center;">
                    <label for="">
                        <input type="radio" name="IS_SHOW_SECRET" value="1">
                        <span><fmt:message code="system_config.yes" /></span>
                    </label>
                    <label for="">
                        <input type="radio" name="IS_SHOW_SECRET" value="0" checked>
                        <span><fmt:message code="system_config.no" /></span>
                    </label>
                </td>
                <td>
                    <fmt:message code="system_config.personnel_and_module_content_can_be_marked_with_secret_level" />
                </td>
            </tr>
            <tr>
                <td><fmt:message code="system_config.open_forget_password_function" /></td>
                <td style="text-align: center">
                    <label for="">
                        <input type="radio" name="IS_OPEN_GET_PASSWORD" value="1" checked>
                        <span><fmt:message code="system_config.yes" /></span>
                    </label>
                    <label for="">
                        <input type="radio" name="IS_OPEN_GET_PASSWORD" value="0">
                        <span><fmt:message code="system_config.no" /></span>
                    </label>
                </td>
                <td>
                    <fmt:message code="system_config.whether_to_enable_forget_password_function_on_login_page" />
                </td>
            </tr>

            <tr>
                <td><fmt:message code="system_config.system_security_administrator_role" /></td>
                <td style="text-align: center;">
                    <input id="SYSECURITY_MANAGE_PRIV" name="SYSECURITY_MANAGE_PRIV" class="theControlData" readonly="readonly" style="width: 70%;" rows="5"></input>
                    <a href="javascript:;" class="addControls" style="margin-left:5px;" data-type="user">Add</a>
                    <a href="javascript:;" class="cleardate">Clear</a>

                </td>
                <td>

                </td>
            </tr>

            <tr>
                <td><fmt:message code="system_config.system_security_confidential_officer_role" /></td>
                <td style="text-align: center;">
                    <input id="SYSECURITY_SECRECY_PRIV" name="SYSECURITY_SECRECY_PRIV" class="theControlData" readonly="readonly" style="width: 70%;" rows="5"></input>
                    <a href="javascript:;" class="addControls" style="margin-left:5px;" data-type="user">Add</a>
                    <a href="javascript:;" class="cleardate">Clear</a>

                </td>
                <td>

                </td>
            </tr>


            <tr>
                <td><fmt:message code="system_config.system_security_auditor_role" /></td>
                <td style="text-align: center;">
                    <input id="SYSECURITY_AUDIT_PRIV" name="SYSECURITY_AUDIT_PRIV" class="theControlData" readonly="readonly" style="width: 70%;" rows="5"></input>
                    <a href="javascript:;" class="addControls" style="margin-left:5px;" data-type="user">Add</a>
                    <a href="javascript:;" class="cleardate">Clear</a>

                </td>
                <td>

                </td>
            </tr>

            <tr>
                <td colspan="3">
                    <div class="saveBtn"><span style="margin-left: 20px;font-size: 10px"><fmt:message code="system_config.confirm" /></span></div>
                </td>
            </tr>

            </tbody>
        </table>

    <%--</form>--%>

</div>
<script type="text/javascript">
    var priv_id = "";
    var result = false;
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            var userId = $.cookie("userId");
            if(data.paraValue == 0) {
                if(userId == "admin") {
                    $("#sysPersionSelectOrg").hide();
                    $("#cacheSetting").hide();
                    $('#securitySystem').show()
                    $('#messageSetting').show()
                    $('#clientSetting').show()
                }else {
                    $('#securitySystem').hide()
                    $('#messageSetting').hide()
                    $('#clientSetting').hide()
                }
            }
        }
    })
    $("input[name=IS_OPEN_SANYUAN]").on("change",function(e) {
        if($(e.target).val() == 0) {
            result = true
        }else {
            result = false;
        }
    })
    $(".addControls").click(function() {
        if(!result) {
            layer.msg("您还没有启用三员管理,无法选择用户",{icon:2});
            return
        }
        priv_id = $(this).siblings('input').prop('id');
        $.popWindow("/common/selectPriv?0");

    })
    $(document).on('click','.cleardate',function () {
        $(this).siblings('input').val('');
        $(this).siblings('input').attr('user_id','');
        $(this).siblings('input').attr('dataid','');
        $(this).siblings('input').attr('username','');

        $(this).siblings('input').attr('deptid','');
        $(this).siblings('input').attr('deptname','');

        $(this).siblings('input').attr('privid','');
        $(this).siblings('input').attr('userpriv','');
        $(this).siblings('input').attr('userprivname','');
    })
    init()
    function init() {
            $.ajax({
                url:"/syspara/querySecrecySysPara",
                success:function(res) {
                    const data = res.obj;
                    //    渲染单选框
                    renderRadio(data)
                }
            })

    }
    //渲染单选框是否选中，默认选择否
    function renderRadio(data) {
        data.forEach(function(it) {
            if(it.paraName === "IS_OPEN_SANYUAN") {
                if(it.paraValue == 0) {
                    result = true
                }else {
                    result = false;
                }
            }
            //是单选框的情况下的回显
            if($('input[name='+it.paraName+']').prop("type") == 'radio') {
                if(it.paraValue == 1) {
                    $('input[name="'+it.paraName+'"][value="1"]').prop("checked","checked")
                }else {
                    $('input[name="'+it.paraName+'"][value="0"]').prop("checked","checked")
                }
            }
        //   选择用户控件回显
            else {
                $('#'+it.paraName).attr("privid",it.paraValue).val(it.userName);
            }

        })
    }
// 得到单选框参数对象
    function getRadioData(dom,name) {
        return {
            paraName: name,
            paraValue:$('input[name='+name+']:checked').val()
        }
    }
//    得到选用户控件的数据
    function getUserData(dom,name) {
        return {
            paraName: name,
            paraValue:$(dom).attr("privid").replaceAll(",","") || " "
        }
    }
$(".saveBtn").click(function() {

        // if(result !=0 || result != doms.length) {
        //     layer.msg("如选择的话系统安全员角色必须全选",{icon:2})
        //     return
        // }
        let arr = [];
        arr.push(getRadioData($('input[name=IS_SHOW_JMJ]'),"IS_SHOW_JMJ"));
        arr.push(getRadioData($('input[name=IS_USE_APP]'),"IS_USE_APP"));
        arr.push(getRadioData($('input[name=IS_OPEN_SANYUAN]'),"IS_OPEN_SANYUAN"));
        arr.push(getRadioData($('input[name=IS_SHOW_SECRET]'),"IS_SHOW_SECRET"));
        arr.push(getRadioData($('input[name=IS_OPEN_GET_PASSWORD]'),"IS_OPEN_GET_PASSWORD"));
        if(result) {
            var doms = $('textarea');
            for(var i = 0; i < doms.length; i++) {
                if(!$(doms[i]).attr("privid")) {
                    layer.msg("系统安全角色必须全选",{icon:2})
                    return
                }
            }
            arr.push(getUserData($('#SYSECURITY_MANAGE_PRIV'),"SYSECURITY_MANAGE_PRIV"));
            arr.push(getUserData($('#SYSECURITY_SECRECY_PRIV'),"SYSECURITY_SECRECY_PRIV"));
            arr.push(getUserData($('#SYSECURITY_AUDIT_PRIV'),"SYSECURITY_AUDIT_PRIV"));
        }
        $.ajax({
            type:"post",
            url:"/syspara/updateSecrecySysPara",
            dataType:"json",
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
})
</script>
</body>
</html>

