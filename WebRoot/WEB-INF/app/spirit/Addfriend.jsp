<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- saved from url=(0082)file:///C:/Users/gaosubo/Desktop/OA%E7%B2%BE%E7%81%B5_files/saved_resource(1).html -->
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>添加好友</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="../css/spirit/style.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/ipanel.css">
    <link rel="stylesheet" type="text/css" href="../css/main/theme1/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="../css/main/theme1/index.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="../css/spirit/user_online.css">
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
</head>
<body>
    <div id="PC_addfriendBOX"></div>

    <iframe id="every_module" src="/common/selectUser" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe>
</body>
</html>