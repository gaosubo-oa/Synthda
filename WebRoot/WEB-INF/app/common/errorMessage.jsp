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
    <title>附件下载错误信息提示</title>
    <style type="text/css">
        *{margin: 0;padding: 0;}
        html,body{width: 100%;height: 100%;font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;}
        .developo{width: 100%;height: 100%;}
        .developo .text{width: 100%;position: relative;height: 100%;}
        /*.developo .text img{display: block;position: absolute;left: 50%;top: 50%;margin-left: -47px;margin-top: -82px;}*/
        div{text-align:center}
        .position{
            width: 300px;
            height: 200px;
            /*border: #ccc 1px solid;*/
            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -150px;
            margin-top: -150px;
        }
        .information{
            word-wrap:break-word;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="developo">
    <div class="text">
        <%--<img src="../img/common/development.png"/>--%>
        <div class="position">
            <div><img src="/img/common/icon_errorMessage.png"/></div>

            <p class="information">您要下载或查看的资源不存在！</p>
        </div>

    </div>
</div>
</body>
</html>

