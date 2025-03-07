
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="notice.th.notificationManagement" /></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <script src="/js/common/language.js"></script>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        .main{
            margin-top:46px;
            width: 100%;
        }

    </style>
</head>
<body>
<div class="head-top">
    <ul class="clearfix">
        <li class="fl head-top-li active" data-type=""><fmt:message code="notice.th.notificationManagement" /></li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="0"><fmt:message code="notice.th.createANewNotification" /> <%--新建--%>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="1"><fmt:message code="notice.th.notificationQuery" /></li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="2"><fmt:message code="notice.th.notificationStatistics" /></li>
    </ul>
</div>
<div class="main" style="min-width: 1150px;">
    <iframe name="notices" src="../../notice/notiManagement" frameborder="0"></iframe>
</div>
<script>
    function addEventHandler(target,type,fn){
        if(target.addEventListener){
            target.addEventListener(type,fn,false);
        }else{
            target.attachEvent("on"+type,fn,false);
        }
    }
    $('.main').height((document.documentElement.clientHeight || document.body.clientHeight)-50)

    addEventHandler(window,'resize',function () {
        // location.reload();
        $('.main').height((document.documentElement.clientHeight || document.body.clientHeight)-50)

    })
    $('.head-top li').click(function () {
        $(this).siblings('li').removeClass('active')
        $(this).addClass('active')
        if($(this).attr('data-type')==''){
            $('.main').find('iframe').prop('src','../../notice/notiManagement')
        }else if($(this).attr('data-type')=='0'){
            $.ajax({
                    url:'/userCountPer',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        if(res.flag){
                            $('.main').find('iframe').prop('src','../../notice/newNotification?type=new')
                        }else{
                            $.layerMsg({content:'<fmt:message code="workflow.th.HeadcountCeiling" />',icon:6})
                        }
                    }
            })

        }else if($(this).attr('data-type')=='1'){
            $('.main').find('iframe').prop('src','../../notice/notificationInquiry')
        }
        else if($(this).attr('data-type')=='2'){
            $('.main').find('iframe').prop('src','../../notice/statisticalPt')
        }
    })
</script>
</body>
</html>