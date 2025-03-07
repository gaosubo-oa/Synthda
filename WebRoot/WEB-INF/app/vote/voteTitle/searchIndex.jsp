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
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/css/base.css">

    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="vote.th.vote" /></title>
    <style>
        html,body{
            width:100%;
            height:100%
        }
        #search{
            margin-left: 360px;
            font-size: 16px;
        }
        #export{
            font-size: 16px;
        }
        .newNew tr td{
            border:none;
        }
        .newNew .tableHead tr td{
            border:1px solid #c0c0c0;
        }
        .ban{
            width: 80px;
            height: 28px;
            padding-left: 10px;
        }
        .left{
            float:left;
        }

        /*导航栏*/
        .header{
            width:100%;
            height:43px;
            border-bottom:1px solid #9E9E9E;
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
        }
        .space{
            width:2px;
            margin-left:16px;
        }
        .pad{
            padding:3px 10px;
            line-height:28px;
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
        /*content*/
        .tableTitle span{
            font-size:22px;
            color:#494d59;
            padding-left:20px;
        }
    </style>
</head>
<body style="overflow:scroll;overflow-y: auto;overflow-x:hidden;">

<div>
    <div class="header">
        <ul class="nav">
            <li url="/vote/manage/voteList">
                <img src="../../img/edu/eduSchoolCalendar/computer.png" alt="">
                <span class="select pad"><fmt:message code="vote.th.Published" /></span>
                <img class="space" src="../img/02.png" alt="">
            </li>

            <li style="margin-top:9px;" url="/vote/manage/newVote">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/new_dept.png" alt="">
                <span class="pad"><fmt:message code="vote.th.Discontinued" /></span>
            </li>
        </ul>
    </div>

</div>
<%--学生信息列表--%>
<div class="list" style="width:100%;height:100%">
    <%--列表展示部分--%>
    <iframe vote_id="0" id="iframe" src="/vote/manage/voteList" frameborder="0" style="width:100%;height:100%"></iframe>
</div>
</body>

<script type="text/javascript">

    $('.header').on('click','li',function(){
        $('.header span').removeClass('select')
        $(this).find('span').addClass('select');

        var url=$(this).attr('url');
        $('#iframe').attr('src',url);
    })

</script>
</html>
