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
<html>
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="roleAuthorization.th.NewRole" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="js/jquery/jquery.min.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>

    <script type="text/javascript" src="js/UserPriv/newRole.js"></script>
    <style>
        tr{
            border: 1px solid #c0c0c0;
        }
    </style>
</head>
<body>
<div id="north">
    <div class="head w clearfix">
        <ul class="index_head clearfix">
            <li data_id="0">
                <span class="headli1_1">
                <a href="roleAuthorization" data-Url="" ><fmt:message code="roleAuthorization.th.RoleMmanagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>

            <li>
                <span class="headli1_1 one">
                    <a  href="newRole?0" data-Url="" ><fmt:message code="roleAuthorization.th.NewRole" /></a></span>
                <img src="../img/twoth.png" alt="" class="headli1_2">
            </li>
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
                <a href="theAuxiliaryRole" data-Url="" ><fmt:message code="roleAuthorization.th.Add-remove" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="superPassword" data-Url="" ><fmt:message code="roleAuthorization.th.SuperPasswordSettings" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
            <li data_id="1">
                  <span class="headli1_1">
                <a  href="theHumanResources" data-Url="" ><fmt:message code="roleAuthorization.th.HR" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>
        </ul>
    </div>


</div>
<div class="navigation  clearfix" style="margin-top: 43px;">
    <div class="left">
        <img src="../img/icon_addrole_06.png" alt="">
        <div class="news"><fmt:message code="roleAuthorization.th.NewRole" /></div>
    </div>
</div>

    <form action="" method="post" name="form1">
        <table class="tr_td" width="450" align="center">
            <tbody><tr>
                <td nowrap="" class="TableData" style="width: 88px;"><fmt:message code="roleAuthorization.th.RoleSortingNumber" />：</td>
                <td nowrap="" class="TableData">
                    <input type="text" name="PRIV_NO" style="margin: 0;" class="inp" size="5" maxlength="10" value="">&nbsp;<br>
                </td>
            </tr>
            <tr>
                <td nowrap="" class="TableData"><fmt:message code="roleAuthorization.th.RoleName" />：</td>
                <td nowrap="" class="TableData">
                    <input type="text" name="PRIV_NAME" style="margin: 0" class="inp" size="25" maxlength="100" value="">&nbsp;
                </td>
            </tr>
            <tr style="display: none">
                <td nowrap="" class="TableData"><fmt:message code="sys.th.roleType" />：</td>
                <td nowrap="" class="TableData">

                    <label><input style="vertical-align: middle" type="radio" name="IS_GLOBAL" class="BigInput" size="25" maxlength="100" value="0" checked=""> <fmt:message code="sys.th.sysAllRole" /></label>
                    <label><input style="vertical-align: middle"  type="radio" name="IS_GLOBAL" class="BigInput" size="25" maxlength="100" value="1"> <fmt:message code="sys.th.sysSelfRole" /></label>
                </td>
            </tr>
            <tr id="dept" style="display: none">
                <td nowrap="" class="TableData"><fmt:message code="workflow.th.sector" />：</td>
                <td nowrap="" class="TableData">
                    <input type="hidden" name="PRIV_DEPT_ID" value="">
                    <input type="text" name="PRIV_DEPT_NAME" class="BigStatic" size="25" maxlength="100" value="" readonly="">&nbsp;
                    <a href="javascript:;" class="orgAdd" onclick="SelectDeptSingle('','PRIV_DEPT_ID', 'PRIV_DEPT_NAME')"><fmt:message code="global.lang.add" /></a>
                    <a href="javascript:;" class="orgClear" onclick="ClearUser('PRIV_DEPT_ID', 'PRIV_DEPT_NAME')"><fmt:message code="global.lang.empty" /></a>
                </td>
            </tr>
            <tr id="org" style="display: none">
                <td nowrap="" class="TableData"><fmt:message code="sys.th.suoshu" />：</td>
                <td nowrap="" class="TableData">
                    <input type="hidden" name="PRIV_ORG_ID" value="">
                    <input type="text" name="PRIV_ORG_NAME" class="BigStatic" size="25" maxlength="100" value="" readonly="">&nbsp;
                    <a href="javascript:;" class="orgAdd" onclick="SelectOrg('','PRIV_ORG_ID', 'PRIV_ORG_NAME', '', '', '1')"><fmt:message code="global.lang.add" /></a>
                    <a href="javascript:;" class="orgClear" onclick="ClearUser('PRIV_ORG_ID', 'PRIV_ORG_NAME')"><fmt:message code="global.lang.empty" /></a>
                </td>
            </tr>
            <tr>
                <td nowrap="" class="TableControl" colspan="2" align="center">
                    <input type="hidden" value="" name="USER_PRIV">
                    <input type="hidden" value="" name="DEPT_ID">
                    <input type="button" value='<fmt:message code="global.lang.ok" />' class="import">&nbsp;&nbsp;
                </td>
            </tr>
            </tbody>
        </table>
    </form>
    <p style="width: 565px;margin: 20px auto;color: red"><fmt:message code="sys.th.tooplis" /></p>
</body>
</html>
