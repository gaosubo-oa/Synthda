
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
    <title id="noticeTitle"></title>
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
        <li class="fl head-top-li active" data-type="">全部</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="0">新建</li> <%--新建--%>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="1">查询</li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <li class="fl head-top-li" data-type="2">统计</li>
    </ul>
</div>
<div class="main" style="min-width: 1150px;">
    <iframe name="notices" src="" frameborder="0"></iframe>
</div>
<script>
    var specifyTable= $.GetRequest()['notice_type'] || '';
    // var url = "../../myNotice/myManagement?specifyTable="+specifyTable
    $('.main').find('iframe').prop('src','../../myNotice/myManagement?specifyTable='+specifyTable)
    $(function(){
        $.get("/myNotifyConfig/getNotifyType?noticeType="+specifyTable,function(res){
            $('#noticeTitle').text(res.data.mynotice_menu2_name)
        })
    })
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
            $('.main').find('iframe').prop('src','../../myNotice/myManagement?specifyTable='+specifyTable)
        }else if($(this).attr('data-type')=='0'){
            $.ajax({
                    url:'/userCountPer',
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        if(res.flag){
                            $('.main').find('iframe').prop('src','../../myNotice/myNewAndEdit?type=new&specifyTable='+specifyTable)
                        }else{
                            $.layerMsg({content:'人数达到上限，不能新建',icon:6})
                        }
                    }
            })

        }else if($(this).attr('data-type')=='1'){
            $('.main').find('iframe').prop('src','../../myNotice/myTheQuery?specifyTable='+specifyTable)
        }
        else if($(this).attr('data-type')=='2'){
            $('.main').find('iframe').prop('src','../../myNotice/myStatistical?specifyTable='+specifyTable)
        }
    })
</script>
</body>
</html>