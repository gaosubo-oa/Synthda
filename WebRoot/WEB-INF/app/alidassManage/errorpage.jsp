<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>error</title>
</head>
<body>
<div align="center">
    <div style="margin-top: 150px">
        <h2 style="font-size: 35px">错误：</h2>
        <span style="font-size: 25px">
             <%
                 String msg = (String) request.getAttribute("error");
                 out.write(msg);
             %>
       </span>
    </div>
</div>
</body>
</html>
