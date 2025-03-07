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
    <title>管理员登录</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="/css/base.css"/>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
</head>
<style>
    .btn {
        text-align: center;
    }

    .btn_ {
        width: 100px;
        height: 30px;
        margin-top: 25px;
        font-size: 14px;
        cursor: pointer;
        background: url(../../img/confirm.png) no-repeat;

    }

    .table {
        width: 60%;
        margin: 20px auto;
    }

    td {
        width: 50%;
    }

    table, tr, td, th {
        border: 1px solid #eee;
        border-collapse: collapse;
    }

    input {
        width: 80%;
    }

    .left {
        width: 30%;
        background: #ddd;
    }

    .right {
        width: 70%;
    }
</style>
<body>
<table class="table">
    <tr>
        <td class="left">请输入效能监察管理密码：</td>
        <td class="right"><input type="password" id="password"></td>
    </tr>
</table>
<div class="btn">
    <button id="saveBtn" class="btn_">确认</button>
</div>

</body>
<script>
    //初始化
    //点击保存
    $("#saveBtn").click(function () {
        var pwd = $("#password").val();
        $.ajax({
            url: "/FlowPara/logincheck",
            type: "post",
            dataType: "json",
            data: {
                pwd: pwd
            },
            success: function (res) {
                if (res.flag) {
                    layer.msg('登录成功！', {icon: 1});
                    window.location.href = "/SuperSettingMain/index?flag=1";
                } else {
                    layer.msg('登录失败！', {icon: 2});
                    $("#password").val("");
                }

            }
        })

    })

</script>
</html>