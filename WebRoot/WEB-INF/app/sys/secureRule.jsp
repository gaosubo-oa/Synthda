<%--
  Created by IntelliJ IDEA.
  User: luopeng
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title><fmt:message code="three.th.ThreeRule" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body style="font-family: 微软雅黑;">
<%--<div class="headTop">
    <div class="headImg">
        <img src="/img/meeting/icon_equipment.png" alt="">
    </div>
    <div class="divTitle">
        三员规则设置
    </div>
</div>--%>
<div id="loginAdmin" style="display: block">
    <div class="navigation  clearfix" style="margin-top:0;">
        <div class="left">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/key_03.png" alt="">
            <div class="news"><fmt:message code="three.th.EnterThree" /></div>
        </div>
    </div>
    <table class="tr_td" width="50%" align="center">
        <tbody>
        <tr>
            <td class="th" colspan="2">
                <b><fmt:message code="roleAuthorization.th.Explain" />：</b>
                <fmt:message code="roleAuthorization.th.superPassword" />
            </td>
        </tr>
        <tr>
            <td class="TableContent" style="width: 27%">
                <fmt:message code="three.th.SuperPassword" />：
            </td>
            <td class="TableData">
                <input style="margin-left: 10px;" placeholder=" <fmt:message code="three.th.first" />" type="password" id="super_pass" name="super_pass" class="inp" size="50" ><span class="super_pass_msg"></span>
            </td>
        </tr>
        <td nowrap="" style="padding: 7px;" align="center" colspan="2">
            <input class="import"  type="button" value="<fmt:message code="global.lang.ok" />">
        </td>
        </tbody>
    </table>
</div>
<div class="main" style="display: none">
    <div class="headImg">
        <img src="//img/commonTheme/${sessionScope.InterfaceModel}/icon_equipment.png" alt="">
        <fmt:message code="three.th.ThreeRule" />
    </div>
    <div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 50px;">
        <table>
            <thead>
            <tr>
                <th width="15%"><fmt:message code="three.th.RuleCode" /></th>
                <th style="padding-left: 20px;" width="40%"><fmt:message code="workflow.th.RuleDescription" /></th>
                <th style="padding-left: 20px;" width="15%"><fmt:message code="three.th.OperationAuthority" /></th>
                <th style="padding-left: 20px;" width="15%"><fmt:message code="notice.th.state" /></th>
                <th style="padding-left: 20px;" width="15%"><fmt:message code="notice.th.operation" /></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<div class="bottom" style="display: none">
    <table>
        <tr><td><fmt:message code="three.th.RulDetails" />:</td><td><fmt:message code="three.th.CreateUsers" /></td></tr>
        <tr>
            <td><fmt:message code="three.th.RulesRoles" />:</td>
            <td>
                <select id="select_1">
                    <option value="1"><fmt:message code="email.th.systemmanager" /></option>
                    <option value="2"><fmt:message code="three.th.SecurityOfficer" /></option>
                    <option value="3"><fmt:message code="three.th.auditor" /></option>
                </select>
            </td>
        </tr>
        <td><fmt:message code="three.th.Enable" />:</td>
        <td class="TableData">
            <INPUT class="radio_1" style="width: 15px;float: none;vertical-align: middle;" type="radio" name="TRAIL_PASS_OR_NOT" value="1" onClick="expandIt1()"><fmt:message code="three.th.increase" />
            <INPUT class="radio_1" style="width: 15px;float: none;vertical-align: middle;" type="radio" name="TRAIL_PASS_OR_NOT" value="0" onClick="expandIt1()" checked><fmt:message code="three.th.reduce" />
        </td>
        <tr></tr>
    </table>
</div>

<script>
  $(function () {
     init();
  });
  function init(){
      //发送ajaxhuoq数据。
  }

</script>
</body>
</html>
