<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">

    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <title>企业微信企业号设置</title>
    <style>
        html,body{
            width:100%;
            height:100%
        }

        .newNew tr td{
            border:none;
        }
        .newNew .tableHead tr td{
            border:1px solid #c0c0c0;
        }


        /*导航栏*/
        .header{
            width:100%;
            height:45px;
            border-bottom:1px solid #9E9E9E;
            position:fixed;
            top:0px;
            z-index: 100;
            background: #fff;
        }
        .nav{
            overflow:hidden;
        }
        .nav li{
            height:28px;
            line-height:28px;
            float:left;
            font-size:14px;
            margin-left:20px;
            margin-top:6px;
            cursor:pointer;
            padding-bottom: 8px;
        }
        .space{
            width:2px;
            margin-left:16px;
        }
        .pad{
            padding:3px 10px;
            line-height:28px;
            font-size: 22px;
            color: #494d59;
        }
        .select{
            background-color:#2F8AE3;
            color:#fff;
            border-radius:20px;
            -webkit-border-radius:20px;
            -moz-border-radius:20px;
            -o-border-radius:20px;;
            -ms-border-radius:20px;
        }
        .tableTitle span{
            font-size:22px;
            color:#494d59;
            padding-left:20px;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">
<div>
    <div class="header">
        <ul class="nav">
            <%--<li url="/infoCenter/getEnterpriseManage">--%>
                <%--<span class="select pad">微信企业号设置</span>--%>
                <%--<img class="space" src="../../img/twoth.png" alt="">--%>
            <%--</li>--%>
            <li url="/dingdingManage/getWechatEnterpriseSetting">
                <span class=" pad">企业微信企业号设置</span>
                <%--<img class="space" src="../../img/twoth.png" alt="">--%>
            </li>
        </ul>
    </div>
</div>
<%--学生信息列表--%>
<div class="list" style="width:100%;height:100%">
    <iframe vote_id="0" v-s="1" id="iframe" src="/enterpriseWeChatManage/getWechatEnterpriseSetting" frameborder="0" style="width:100%;height:calc(100% - 50px);padding-top:45px;" ></iframe>
</div>
</body>

<script type="text/javascript">

//    $('.header').on('click','li',function(){
//        $('.header span').removeClass('select')
//        $(this).find('span').addClass('select');
//        var url=$(this).attr('url');
//        $('#iframe').attr('src',url);
//    })
//    function show(){
//        $('.nav li').eq(0).find('span').addClass('select').parent().siblings().find('span').removeClass('select')
//    }

</script>
</html>
