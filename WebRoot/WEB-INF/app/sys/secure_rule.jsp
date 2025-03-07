<%--
  Created by IntelliJ IDEA.
  User: gaoyafeng
  Date: 2017/8/11
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <title><fmt:message code="three.th.ThreeManagement" /></title>
    <link rel="stylesheet" href="/css/dept/roleAuthorization.css?20210311.1">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <%--<script src="../../js/UserPriv/roleAuthorization.js"></script>--%>
</head>
<body>
<div id="loginAdmin">
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
            <td class="TableContent" style="width: 25%">
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
<script>
</script>
</body>
</html>
