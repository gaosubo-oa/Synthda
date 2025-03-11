
<%--
  Created by IntelliJ IDEA.
  User: Machenike
  Date: 2020/6/10
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <title>后台调用全部人员接口</title>
    <style type="text/css">

    </style>
</head>
<body>
<script type="text/javascript">
    function    add(){
        //域名
        var realm_name='http://58.57.20.53:10000/'
        //应用内部ID
        var app_id='ces-id'  ;
        //调用接口凭证
        var access_token='847c4dc1d2a84c1c8e6bda663f7c3eef' ;
        //OA用户账号，或第三方应用的自身账号（需要先与OA系统账号进行映射绑定）
        var user_id="测试";
        //登录授权成功后，重定向的 接口API地址
        var redirect_uri=  '/workflow/work/addwork';




        var   uri= decodeURI(redirect_uri)

        console.log(redirect_uri)
            window.location.href=realm_name+"/connect/syslogin?app_id="+app_id+"&access_token="+access_token+"&user_id="+user_id+"&redirect_uri="+uri;
    }
    add()
</script>
<%--</body>http://58.57.20.53:10000/connect/syslogin?app_id=ces-id&access_token=847c4dc1d2a84c1c8e6bda663f7c3eef&user_id=管理员&redirect_uri=/workflow/work/workfastAdd?flowId=139&prcsId=1&flowStep=1&runId=&preView=0&runName=测试--%>
</html>