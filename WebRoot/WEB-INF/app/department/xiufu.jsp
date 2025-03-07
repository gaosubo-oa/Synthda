<%--
  Created by IntelliJ IDEA.
  User: liruixu
  Date: 2017/6/14
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>修复</title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <style>
    a{
        position: fixed;
        width: 140px;
        height: 30px;
        line-height:30px;
        top:50%;
        left: 50%;
        margin-top:-15px;
        margin-left:-70px;
        background: #0B7CC4;
        border-radius: 4px;
        color: #fff;
        text-align: center;
        text-decoration: none;
        font-size: 14px;
    }
    </style>
</head>
<body>
<a href="javascript:;">组织架构结构修正</a>
</body>
<script>
  $('a').click(function () {
      $.get('/department/UsersByUidCorrection',function (json) {
          $.layerMsg({
              content:'修复成功',
              icon:1
          })
      },'json')
  })
</script>
</html>
