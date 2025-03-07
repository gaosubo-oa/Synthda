<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/14
  Time: 9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="roleAuthorization.th.AdjustRoleSorting" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="../js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script src="/js/UserPriv/adjustTheRole.js"></script>
</head>
<style>
    .head .headli1_2{
        margin-top: -5px;
    }
</style>
<body>
<div id="north">
    <div class="head w clearfix">
        <ul class="index_head clearfix">
            <li data_id="0">
                <span class="headli1_1">
                <a  href="roleAuthorization" data-Url="" ><fmt:message code="roleAuthorization.th.RoleMmanagement" /></a>
                </span><img class="headli1_2" src="../img/twoth.png" alt="">
            </li>

            <%--<li>--%>
                <%--<span class="headli1_1">--%>
                    <%--<a  href="newRole" data-Url="" ><fmt:message code="roleAuthorization.th.NewRole" /></a></span>--%>
                <%--<img src="../img/twoth.png" alt="" class="headli1_2">--%>
            <%--</li>--%>
            <li data_id="1">
                  <span class="headli1_1 one">
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
                  <span class="headli1_1">
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
<div class="navigation  clearfix" style="margin-top: 43px">
    <div class="left">
        <img src="../img/icon_changerole_06.png" alt="">
        <div class="news"><fmt:message code="roleAuthorization.th.AdjustRoleSorting" /></div>
        <div id="Confidential" style="display: inline-block"></div>
    </div>
</div>


<table class="tr_td" width="400" align="center">
    <tbody><tr class="TableHeader">
        <td align="center"><b><fmt:message code="userManagement.th.role" /></b></td>
        <td align="center" style="border: 1px solid #ddd"><fmt:message code="email.th.order" /></td>
    </tr>
    <tr class="TableData">
        <td valign="top" style="border: 1px solid #ddd;" align="center">
            <select id="select1" name="select1" multiple="" style="width:200px;height:280px">


            </select>
        </td>
        <td align="center" style="border: 1px solid #ddd">
            <input type="button" class="SmallInput" style="width: 30px" value=" ↑ " onclick="func_up();">
            <br><br>
            <input type="button" class="SmallInput" style="width: 30px" value="↓ " onclick="func_down();">
        </td>
    </tr>
    <tr class="TableControl">
        <td align="center" valign="top" colspan="4">
            <input type="button" class="import" value='<fmt:message code="global.lang.save" />' onclick="mysubmit();">&nbsp;&nbsp;
        </td>
    </tr>

    </tbody>
</table>
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
