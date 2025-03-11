<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <title><fmt:message code="email.th.emptyFolder" /></title><%--空文件夹--%>
    <style type="text/css">
        *{margin: 0;padding: 0;}
        .img{width: 100%;height: 100%;}
        .img .divIm{width: 170px;height: 200px;margin: 150px auto;}
        .img .divIm p{margin-top: 10px;font-size: 14px;color: #aaa;margin-left: 7px;}
    </style>
</head>
<body>
<div class="img">
    <div class="divIm">
        <img src="../img/img_nomessage_03.png" alt='<fmt:message code="email.th.emptyFolder" />' /><%--空文件夹--%>
        <p><fmt:message code="email.th.folderNoMail" /></p><%--该文件夹没有邮件--%>
    </div>
</div>
</body>
</html>

