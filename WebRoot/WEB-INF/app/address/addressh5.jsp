<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="main.addressbook" /></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <style>
        * {
              margin: 0;
              padding: 0;
          }
        body{
            font-size:16px;
        }
        .header{

            position: fixed;
            left: 0;
            top: 0;
            z-index: 99;
            width: 100%;
            height: 45px;
            background: #3c92e5;
            text-align: center;
        }
        .header p{
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            height: 45px;
            line-height: 45px;
            color: #fff;
            font-size: 18px;
            display:inline-block;
        }
        .header span{
            color:#fff;
            margin-right: 20px;
            float: right;
            line-height: 45px;
        }
        .content{
            margin-top:45px;
        }
        .nav{
            background-color: #fff;
        }
        .header-two{
            position: fixed;
            top: 45px;
            left:0px;
            /*padding-top:45px;*/
            z-index: 99999;
            width: 100%;
            height: 45px;
            background: #fff;


        }
        .header-two p{
            margin-left:20px;
            height: 45px;
            line-height: 45px;
            color: #fff;
            font-size: 18px;
            display:inline-block;
        }
        .header-two span{
            color:#fff;
            margin-left:6px;
            line-height: 45px;
        }
        .header-two i{
            color:#fff;
            margin-left: 20px;
            line-height: 45px;
        }
        .header-two input{
            border:none;

            width:92%;
            background-color:transparent;
        }
        .sort_box-two{
            display:block;
        }
        .input{
            display: inline-block;
            height: 42px;
            width: 100%;
        }
        #search{
            height: 25px;
            margin-top: 6px;
            border:1px solid #3c92e5;
            font-size:11pt;
        }
        ul li{list-style: none;}
        a{text-decoration: none;cursor: pointer;}
        html{height: 100%;}
        a,input,img,textarea,span,div{outline: 0;-webkit-tap-highlight-color:rgba(255,0,0,0);}

        #letter{
            width: 100px;
            height: 100px;
            border-radius: 5px;
            font-size: 75px;
            color: #555;
            text-align: center;
            line-height: 100px;
            background: rgba(145,145,145,0.6);
            position: fixed;
            left: 50%;
            top: 50%;
            margin:-50px 0px 0px -50px;
            z-index: 99;
            display: none;
        }
        #letter img{
            width: 50px;
            height: 50px;
            float: left;
            margin:25px 0px 0px 25px;
        }
        [class^="sort_box"]{
            width: 100%;
            padding-top: 4px;
            overflow: hidden;

        }
        [class^="sort_list"]{
            padding: 0px 60px 0px 69px;
            position: relative;
            line-height: 50px;
            border-bottom:1px solid #ddd;
        }

        [class^="sort_list"] .num_logo{
            width: 50px;
            height: 50px;
            border-radius: 10px;
            overflow: hidden;
            position: absolute;
            left: 20px;
        }
        /*[class^="sort_list"] .num_logo img{*/
            /*width: 50px;*/
            /*height: 50px;*/
        /*}*/
        [class^="sort_list"] .num_name{
            color: #000;
        }

        .sort_letter{
            height: 30px;
            line-height: 30px;
            padding-left: 20px;
            color:#787878;
            font-size: 14px;
            border-bottom:1px solid #ddd;
        }
        .initials{
            position: fixed;
            top: 119px;
            right: 6px;
            height: 100%;
            width: 15px;
            padding-right: 10px;
            text-align: center;
            font-size: 12px;
            z-index: 99;
            background: rgba(145,145,145,0);
        }
        .initials li{
           margin-left:-25px;

        }
        .initials li img{
            width: 14px;
        }
        .sort_letter{
            background: #eee;
        }
        .sort_box-two{
            padding-top: 86px;
        }
    </style>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:300,400' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,900' rel='stylesheet' type='text/css'>
    <!-- CSS Libs -->
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.bootcss.com/bootstrap-switch/4.0.0-alpha.1/css/bootstrap-switch.css">

    <script src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.charfirst.pinyin.js"></script>
    <script type="text/javascript" src="/js/address/circle.js"></script>

</head>
<body>
<div class="header-two">
    <div>
        <%--<i class="glyphicon glyphicon-chevron-left" onclick="back()"><a href="javascript:back()"></a> </i>--%>
        <div class="input">
            <span class="glyphicon glyphicon-search"></span>
            <input id="search" type="text" placeholder="<fmt:message code="url.th.Home2" />"/>
        </div>
    </div>
</div>

<div class="header">
    <div>
        <p><fmt:message code="main.addressbook" /></p>
        <span class="glyphicon glyphicon-plus"></span>
        <span id="gosearch" class="glyphicon glyphicon-search"></span>
    </div>
</div>
<div id="letter" ></div>
<div class="sort_box-two">

</div>
<div class="sort_box">
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">张三</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">李四</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">王五</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">刘六</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">马七</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">黄八</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">莫九</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">陈十</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">陈十</div>--%>
    <%--</div><div class="sort_list">--%>
    <%--<div class="num_logo">--%>
        <%--<img src="images/avator.png" alt="">--%>
    <%--</div>--%>
    <%--<div class="num_name">陈十</div>--%>
<%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">a九</div>--%>
    <%--</div>--%>
    <%--<div class="sort_list">--%>
        <%--<div class="num_logo">--%>
            <%--<img src="images/avator.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="num_name">1十</div>--%>
    <%--</div>--%>
</div>
<div class="initials">
    <ul>
    </ul>
</div>
</body>
</html>
