<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>会签</title>
    <script type="text/javascript" src="/js/xoajq/xoajq1.11.1.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/js/spirit/qwebchannel.js"></script>
    <style>
        *{
            padding: 0;
            margin: 0;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        span{
            font-size:12px;
            color: #666666;
        }
        ul, ol ,li{
            list-style: none;
        }
        /*******************header头部**************************/
        #header{
            width: 100%;
            height: 30px;
            background-color: #eaeaea;
            border-bottom: 1px solid #c6c6c6;
        }
        .btnBox li{
            float: left;
            height: 25px;
            margin-top: 3px;
        }
        .btnBox span{
            color: #439cd1;
        }
        .searchBtn{
            width: 50px;
            margin-left: 5px;
            background-color: #5b7fcb;
            -webkit-border-radius:2px;
            -moz-border-radius:2px;
            border-radius:2px;
        }
        .searchBtn span{
            color: #fff;
            margin-left: 8px;
        }
    </style>
</head>
<body>
    <div id="header">
        <ul class="btnBox">
            <li class="searchBtn">
                <span>排序</span>
            </li>
            <li style="margin-left: 15px;">
                <span>新建</span>
            </li>
            <li style="margin-left: 20px;">
                <span>导出</span>
            </li>

        </ul>
    </div>
</body>
</html>