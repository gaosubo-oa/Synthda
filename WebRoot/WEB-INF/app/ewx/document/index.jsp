<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>公文</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/mui/mui/mui.min.js" ></script>
    <script src="/lib/mui/mui/showLoading.js"></script>
    <link href="../../lib/mui/mui/mui.css?20190819.1" rel="stylesheet">

    <script type="text/javascript" charset="UTF-8">
        mui.init();
    </script>
    <style>
        body{
            background-color: #ffffff;
        }
        .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-object {
            width: 50%;
        }
        .mui-table-view.mui-grid-view .mui-table-view-cell .mui-media-body {
            font-size: 13px;
        }

        .mui-title-bar:after {
            content: ' ';
            border-left: 4px solid #ffa96f;
            line-height: 43px;
            margin-left: 10px;
        }

        .mui-table-view.mui-grid-view {
            padding-top: 4px;
            padding-bottom: 14px;
        }

        img{
            width:38.67px;
            height:38.67px;
        }
    </style>
</head>

<body>
<header class="mui-bar mui-bar-nav" style="display:none;">
    <h1 class="mui-title">审批</h1>
</header>

<body>
<i class="mui-title-bar" style="display:none;"></i>
<div class="mui-card-header" style="display:none;"></div>
<div class="mui-card-content">
    <ul class="mui-table-view mui-grid-view">
        <li style="position: relative;" class="mui-table-view-cell mui-media mui-col-xs-3">
            <span class="mui-badge mui-badge-danger" style="display: none">2</span>
            <a id="wait" class="mui-table-view-cell" href="javascript:;">
                <img class="mui-media-object" src="/img/menu/Todopost.png">
                <div class="mui-media-body " style="height: 15px;margin-top: 4px">发文管理</div>
            </a>
        </li>
        <li class="mui-table-view-cell mui-media mui-col-xs-3" >
            <a id="Launch" class="mui-table-view-cell" id="launch" href="javascript:;">
                <img class="mui-media-object" src="/img/menu/Havetodopost.png">
                <div class="mui-media-body " style="height: 15px;margin-top: 4px">收文管理</div>
            </a>
        </li>
    </ul>
</div>

</body>
</body>
<script type="text/javascript">
    // 发文管理
    document.getElementById('wait').addEventListener('tap', function(e) {
        mui.openWindow({
            url: '/ewx/dealt',
        });

    });
    // 收文管理
    document.getElementById('Launch').addEventListener('tap', function(e) {
        mui.openWindow({
            url: '/ewx/FrontOfficial',
        });
    });

</script>

</html>
