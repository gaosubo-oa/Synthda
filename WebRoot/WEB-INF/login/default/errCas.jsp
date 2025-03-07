<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>CAS提示页</title>
    <meta charset="UTF-8">
    <style>
        .timeOut{
            position: fixed;
            width: 400px;
            height: 370px;
            top: 50%;
            left: 50%;
            margin-left: -135px;
            margin-top: -195px;
            text-align: center;
        }
        .timeOut .timeOutMain{
            width: 100%;
            height: 315px;
            background-size: contain;
        }
        .timeOut .register{
            display: inline-block;
            margin-top: 46px;
            padding: 10px 54px;
            background: #2b7fe0;
            border-radius: 4px;
            color: #fff;
            display: none;
            cursor:pointer;
            font-size: 16px;
            margin: -30px auto;
        }

        .timeOut a{
            display: inline-block;
            margin-top: 46px;
            padding: 10px 54px;
            background: #2b7fe0;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            margin: -30px auto;
        }
        a{
            text-decoration:none
        }
        .alertText{
            top: 190px;
            position: relative;
            color: #809ab7;
            font-size: 18px;
        }
        .return{
            width: 103px;
            height: 28px;
            background: #2b7fe0;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            color: #ffffff;
            line-height: 28px;
            font-size: 14px;
            margin: 30px auto;
        }
        .return a{
            color: #ffffff;
        }
    </style>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="timeOut">
    <div class="timeOutMain" style="background:url(/img/loginOut.png) no-repeat 45px 0px">
        <span class="alertText" id="alertText"><span style="font-weight: bold;font-size: 24px;">用户不存在，请重新登录</span><br></span>
    </div>
    <a class="logon" href="/">重新登录</a>
</div>
</body>
</html>
