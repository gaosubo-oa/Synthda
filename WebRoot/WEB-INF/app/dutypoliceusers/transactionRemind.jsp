<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>值班管理查询</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="../../lib/fullcalendar/moment.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/fullcalendar.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/jquery-ui.custom.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/zh-cn.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <style>
        .header {
            font-weight: bold;
            margin: 10px;
            font-size: 20px;
        }

        .main {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
        }

        .main .box {
            width: 100%;
            padding: 20px 30px;
        }
        .main .box p{
            width: 92%;
        }
        .main .box p span {
            color: rgb(42, 88, 140);
            font-weight: bold;
        }
        .header img{
            width: 20px;
            height: 20px;
            vertical-align: middle;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="background-color:#eee;">
<div class="header">
    <img src="/img/commonTheme/theme1/icon_myMeeting.png" alt=""> 值班信息详情
</div>
<div class="main">
    <div class="box">

    </div>
</div>
</body>

</html>
<script>
    $(function () {
        var dutyId = $.getQueryString('dutyId');
        $.ajax({
            type: "post",
            url: "/DutyPoliceUsers/findDutyPoliceById",
            dataType: 'json',
            data: {dutyId:dutyId},
            success: function (res) {
                var data = res.object;
                var p='';
                if(res.flag){
                    var p='<p><span>星期：</span>'+esName(data.dutyweek)+'</p>'+
                        '<p><span>值班日期：</span>'+esName(data.dutyDate)+'</p>'+
                        '<p><span>局带班：</span>'+esName(data.btreeUsersName)+'</p>'+
                        '<p><span>局值班：</span>'+esName(data.bdutyUsersName)+'</p>'+
                        '<p><span>总站带班：</span>'+esName(data.ttreeUsersName)+'</p>'+
                        '<p><span>总站值班：</span>'+esName(data.tdutyUsersName)+'</p>'+
                        '<p><span>操作员：</span>'+esName(data.operatingUsersName)+'</p>'+
                        '<p><span>总站备勤：</span>'+esName(data.preparationUsersName)+'</p>'+
                        '<p><span>中心值班长：</span>'+esName(data.cbigUsersName)+'</p>'+
                        '<p><span>中心值班员：</span>'+esName(data.cpersonUsersName)+'</p>';
                }else{
                    p='<p><span></span>暂无数据</p>';
                }
                $('.box').html(p);
            }
        })
    })

    //判断返回是否为空
    var esName=(esName)=>{
        if (esName!=undefined){
            return esName
        }
        return '';
    };
</script>