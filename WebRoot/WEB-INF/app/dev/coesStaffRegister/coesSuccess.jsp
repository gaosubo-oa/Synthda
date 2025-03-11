<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2022/9/23
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>人员登记</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <style>
        .message {
            width: 80%;
            height: 100px;
            border: 1px solid #ccc;
            position: absolute;
            left: 50%;
            top: 50%;
            background-color: rgb(203, 213, 228);
            margin-left: -150px;
            margin-top: -150px;
            text-align: center;
            line-height: 100px;
            font-size: 30px;
            color: #000;
        }
        .btn {
            width: 80%;
            height: 50px;
            position: absolute;
            left: 50%;
            top: 50%;
            margin-left: -150px;
        }
        .btn button {
            width: 100%;
            height: 100%;
            border: none;
            outline: none;
            font-size: 20px;
            color: #fff;
            background-color: rgb(30, 158, 255);
        }
    </style>
</head>
<body>
<div style="margin-top: 20px;position: relative;" class="head">
    <img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:4px "><span style="margin-left: 49px;font-size: 20px;">人员登记</span>
</div>
        <div class="message">

        </div>
        <div class="btn">
            <button id="closeBtn">关闭</button>
        </div>
<script>
    var data = location.search.split('&');
    var code = data[0].split('=')[1];
    var cCode = +data[1].split('=')[1]
    if(code == 1) {
        $('.message').text('登记成功')
    }else if(code == 2) {
        $('.message').text('离船成功');
    }
   $('#closeBtn').click(function() {
       location.href = location.origin + '/coesStaffRegister/coesStaffRegisterH5?codeNo='+cCode
   })
</script>
</body>
</html>
