<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/12
  Time: 15:290
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="dem.th.gatewayAdministration"/></title>


    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

    <script src="../../js/common/language.js?20220316.1"></script>
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/smsSettings/sms.js?20220316.1"></script>

    <style>
        .news{
            cursor: pointer;
        }
        label b{
            color: red;
        }
        .th{
            font-size: 13pt;
        }
        td{
            font-size: 11pt;
        }
    </style>

</head>
<body style="background: #fff">
<div class="maintop clearfix" style="">
    <p style="margin-left: 10px;padding-top: 10px;">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/wangguan.png" style="width: 25px;height: 24px;vertical-align: text-bottom;" alt="">
        <label><fmt:message code="dem.th.gatewayAdministration"/></label><%--内部接口配置--%>
    </p>
    <a  class="newsBtn newsBtntwo btnTheme " id="newBtn1" style="float: right;margin-right: 3%;margin-top: 5px;" href="javascript:void (0)" data-num="0"><img src="../../img/mywork/newbuildworjk.png" alt="" style="margin:-3px 0px 0px -8px;"><fmt:message code="global.lang.new" /></a><%--新建--%>
</div>

<div class="mainBottom" style="margin-top: 21px;">
    <table>
        <thead>
        <tr>
            <th class="th" width="10%" align="center"><fmt:message code="workflow.th.Serial"/></th><%--序号--%>
            <th class="th" width="10%" align="center"><fmt:message code="user.th.dffs"/></th><%--业务模块--%>
            <th class="th" width="10%" align="center"><fmt:message code="user.th.dfs"/></th><%--名称--%>
            <th class="th" width="10%" align="center"><fmt:message code="user.th.sdd"/></th><%--数据方向--%>
            <th class="th" width="10%" align="center"><fmt:message code="user.th.knfl"/></th><%--流程--%>
            <th class="th" width="20%" align="center"><fmt:message code="user.th.dfsds"/></th><%--数据映射--%>
            <th class="th" width="10%" align="center"><fmt:message code="notice.th.state"/></th><%--描述--%>
            <th class="th" width="20%" align="center"><fmt:message code="notice.th.operation"/></th><%--操作--%>
        </tr>
        </thead>
        <tbody>
        <tr>

        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
