<%--
  Created by IntelliJ IDEA.
  User: huangzhijian
  Date: 2017/12/29
  Time: 0:26
  To change this template use File | Settings | File Templates.
--%>
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
    <title>工资管理</title>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css" />
    <link rel="stylesheet" type="text/css" href="../../css/news/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/management_query.css" />
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../lib/laydate/laydate.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <!-- word文本编辑器 -->
    <script src="../../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/news/page.js"></script>
    <script src="../../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>

    <style type="text/css">
        html,body{
            height: 100%;
        }
        .head{
            height: 45px;
        }
        .head .index_head li span{
            /*margin-top: 5px;*/
            margin-left: 18px;
        }
    </style>

</head>
<body id="body">
<div class="head w clearfix " id="header" style="width:2150px;">
    <ul class="index_head" id="iframeUl">
        <li data_id="0" url="/personSalary/personWages" data-num="0"><span class="one headli1_1"><fmt:message code="adding.th.EducationalWages" /></span><img class="headli1_2" src="../img/twoth.png" alt=""/>
        </li>

        <li data_id="" url="/personSalary/personBonus" data-num="1"><span class="headli2_1"><fmt:message code="adding.th.EducationalBonus" /></span><img src="../img/twoth.png" alt="" class="headli2_2"/>
        </li>

       <li data_id="" url="/personSalary/personPayimport" data-num="2"><span class="headli3_1">工资/奖金导入</span>
        </li>

        <%--<li data_id="" url="/personBonusmsg/personSetting" data-num="3"> <img src="../img/twoth.png" alt="" class="headli2_2"/> <span class="headli4_1">权限设置</span></li>--%>
    </ul>
</div>

<div id="iframebox" style="margin-top: 30px;">
    <iframe src="/personSalary/personWages" frameborder="0" width="2150px" scrolling="no" noresize="noresize"  id="iframes"></iframe>

</div>
<script>
    var ifm= document.getElementById("iframes");

    var ifHeight=$('#body').height()-$('.head').height();
    ifm.height=ifHeight-35;


    $('.index_head').on('click','li',function() {
        var dataNum=$(this).attr('data-num');
        $('.index_head span').removeClass('one')
        $(this).children('span').addClass('one')
        if(dataNum == '2'){
            $('.head').width('100%');
            $('#iframes').width('100%');
        }else if(dataNum == '1'){
            $('.head').width('3350px');
            $('#iframes').width('3350px');
        }else if(dataNum == '0'){
            $('.head').width('2150px');
            $('#iframes').width('2150px');
        }else if(dataNum == '3'){
            $('.head').width('100%');
            $('#iframes').width('100%');
        }
        var url=$(this).attr('url');
        $('#iframes').attr('src',url);
    });


//    ifm.height=document.documentElement.clientHeight;
</script>

</body>
</html>
