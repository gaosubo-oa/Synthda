<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/13
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="workflow.th.resource" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>

    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script src="../../js/common/language.js"></script>
    <script src="/js/UserPriv/theHumanResources.js"></script>
    <style>
        tr td{
            text-align: center;
        }
        .tr_td thead td{
            background-color: #fff;
            font-size: 15px;
            color: #2F5C8F!important;
            font-weight: bold;
        }
        .head .headli1_2{
            margin-top: -5px;
        }

    </style>
</head>
<body class="bodycolor">

<div id="north">
    <div class="head w clearfix">
        <ul class="index_head clearfix">
            <li data_id="0">
                <span class="headli1_1 ">
                <a  href="roleAuthorization" data-Url="" ><fmt:message code="roleAuthorization.th.RoleMmanagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>

            <%--<li>--%>
                <%--<span class="headli1_1 ">--%>
                    <%--<a  href="newRole?0" data-Url="" ><fmt:message code="roleAuthorization.th.NewRole" /></a></span>--%>
                <%--<img src="../img/twoth.png" alt="" class="headli1_2">--%>
            <%--</li>--%>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="adjustTheRole" data-Url="" ><fmt:message code="roleAuthorization.th.AdjustRoleSorting" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="modifyThePermissions?0" data-Url="" ><fmt:message code="roleAuthorization.th.Add-delete" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="theAuxiliaryRole" data-Url="" ><fmt:message code="roleAuthorization.th.Add-remove" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="superPassword" data-Url="" ><fmt:message code="roleAuthorization.th.SuperPasswordSettings" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1 one">
                <a  href="theHumanResources" data-Url="" ><fmt:message code="roleAuthorization.th.HR" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="roleAndClassification" data-Url="" ><fmt:message code="roleAuthorization.th.RoleClassificationManagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
        </ul>
    </div>

</div>
<div class="navigation  clearfix" style="margin-top: 43px;">
    <div class="left">
        <img src="../img/userPriv/newHuman.png" alt="">
        <div class="news newtwo"><fmt:message code="roleAuthorization.th.HR" /></div>
        <div id="Confidential" style="display: inline-block"></div>
    </div>
</div>
<div id="showdiv">
    <table class="tr_td" width="45%" align="center">
        <form action="rolemanagement_submit.php" method="post" name="form1" onsubmit="return CheckForm();"></form>
        <tbody><tr>
            <td nowrap="" class="TableData"><fmt:message code="roleAuthorization.th.selectPersonnel" />：</td>
            <td class="TableData">
                <input type="hidden" name="HR_ROLE_MANAGE" value="">
                <textarea cols="50"  id="mainss" name="COPY_TO_NAME" rows="5" class="BigStatic" wrap="yes" readonly=""></textarea>
                <a href="javascript:;" class="orgAdd" data-num="0"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="orgClear" data-numTwo="0"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="TableData"><fmt:message code="hr.th.SelectRoles" />：</td>
            <td nowrap="" class="TableData">
                <input type="hidden" name="PRIV_ID" value="">
                <textarea cols="50" id="PRIV_ID" name="PRIV_NAME" rows="5" class="BigStatic" wrap="yes" readonly=""></textarea>
                <a href="javascript:;" class="orgAdd" data-num="1"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="orgClear" data-numTwo="1"><fmt:message code="global.lang.empty" /></a><br>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="TableControl" colspan="2" align="center">
                <input type="button" value="<fmt:message code="global.lang.add" />" class="import oneim">&nbsp;&nbsp;
            </td>
        </tr>

        </tbody>
    </table>
    <div class="navigation  clearfix">
        <div class="left">
            <img src="../img/department/groupManager.png" alt="">
            <div class="news"><fmt:message code="global.lang.management" /></div>
        </div>
    </div>
    <table class="tr_td tr_tds" width="70%" align="center" style="margin-bottom: 20px;">
        <thead>
        <tr class="TableHeader">
            <td nowrap="" align="center"><fmt:message code="hr.th.number" /></td>
            <td nowrap="" align="center"><fmt:message code="hr.th.num2" /></td>
            <td nowrap="" align="center"><fmt:message code="roleAuthorization.th.ManagementRoles" /></td>
            <td nowrap="" align="center"><fmt:message code="menuSSetting.th.menuSetting" /></td>
        </tr>
        </thead>
        <tbody>
        </tbody></table>

</div>
<div id="hidediv" style="display: none">
    <table class="tr_td" width="45%" align="center">
        <form action="rolemanagement_submit.php" method="post" name="form1" onsubmit="return CheckForm();"></form>
        <tbody><tr>
            <td nowrap="" class="TableData"><fmt:message code="roleAuthorization.th.selectPersonnel" />：</td>
            <td class="TableData">
                <input type="hidden" name="HR_ROLE_MANAGE" value="">
                <textarea cols="50" id="mainsstwo" name="COPY_TO_NAME" rows="5" class="BigStatic" wrap="yes" readonly="" dataid="9," user_id="zhaomin,"></textarea>
                <a href="javascript:;" class="orgAdd" data-num="0"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="orgClear" data-numTwo="0"><fmt:message code="global.lang.empty" /></a>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="TableData"><fmt:message code="hr.th.SelectRoles" />：</td>
            <td nowrap="" class="TableData">
                <input type="hidden" name="roleManagerIdTwo" value="">
                <textarea cols="50" id="PRIV_IDtwo" name="PRIV_NAME" rows="5" class="BigStatic" wrap="yes" readonly=""></textarea>
                <a href="javascript:;" class="orgAdd" data-num="1"><fmt:message code="global.lang.add" /></a>
                <a href="javascript:;" class="orgClear"><fmt:message code="global.lang.empty" /></a><br>
            </td>
        </tr>
        <tr>
            <td nowrap="" class="TableControl" colspan="2" align="center">
                <input type="button" value="<fmt:message code="depatement.th.modify" />" class="import twoim">&nbsp;&nbsp;
            </td>
        </tr>

        </tbody>
    </table>
</div>


<script>
    function jump(me){
        parent.newjump($(me).attr('data-Url'))
    }
    $.ajax({
        type:'get',
        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
        dataType:'json',
        success:function (res) {
            var data=res.object[0]
            if (data.paraValue!=0){
                $('#Confidential').append('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 20px;margin-top: 10px;"> 机密级★ </span>')
            }
        }
    })
</script>
</body>
</html>
