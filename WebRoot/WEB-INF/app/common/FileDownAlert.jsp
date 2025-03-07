<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <style>
        html,body,div{margin: 0;padding: 0;}
        html,body{font-family: 微软雅黑;width: 100%;}
        .content{width: 100%;}
    </style>
</head>
<body>
    <div class="content">

    </div>
</body>
<script>
    $(function(){
        layer.confirm('${msg}', {
            btn: ['<fmt:message code="global.lang.close" />'], //按钮/*关闭*/
            title:'<fmt:message code="common.th.prompt" />'/*提示*/
        }, function(){
            layer.closeAll();
//            parent.location.reload();
//            window.history.back();
            history.back();
        });
    })
</script>
</html>
