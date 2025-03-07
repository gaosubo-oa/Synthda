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
    <title><fmt:message code="dem.th.WageInquiries" /></title>
    <link rel="stylesheet" type="text/css" href="../../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/laydate.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/base.css" />
    <link rel="stylesheet" type="text/css" href="../../css/news/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/news/management_query.css" />
<%--    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
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
            overflow-x: hidden;
        }
    </style>

</head>
<body id="body">
<div id="header" class="head w clearfix">
    <ul class="index_head">
        <li data_id="0" url="/salary/wages" data-num="0"><span class="one headli1_1">我的工资数据查询</span><img class="headli1_2" src="../img/twoth.png" alt=""/>
        </li>

        <li data_id="" url="/salary/bonus" data-num="1"><span class="headli2_1">我的奖金数据查询</span><img src="../img/twoth.png" alt="" class="headli2_2"/>
        </li>

        <li data_id="" url="/bonusmsg/subWages" data-num="2" class="headli3_1" style="visibility: hidden"><span class="headli3_1">下属工资数据查询</span><img src="../img/twoth.png" alt="" class="headli2_2"/>
        </li>

        <li data_id="" url="/bonusmsg/affBonus" data-num="3" class="headli4_1" style="visibility: hidden"><span class="headli4_1">下属奖金数据查询</span>
        </li>
    </ul>
</div>

<div id="iframebox" style="margin-top: 30px;">
    <iframe src="/salary/wages" frameborder="0" scrolling="no"  noresize="noresize"  id="iframes"></iframe>

</div>
<script>
    $('.index_head').on('click','li',function() {
        var dataNum=$(this).attr('data-num');
        $('.index_head span').removeClass('one');
        $(this).children('span').addClass('one');
        if(dataNum == '1'){
            $('.head').width($(window.body).width());
            $('#index_head').width($(window.body).width())
            $('#iframes').width($(window.body).width());
            $('#iframes').attr('src','/salary/bonus');
        }else if (dataNum == '0'){
            $('.head').width($(window.body).width());
            $('#index_head').width($(window.body).width())
            $('#iframes').width($(window.body).width());
            $('#iframes').attr('src','/salary/wages');
        }else if (dataNum == '2'){
            $('.head').width($(window.body).width());
            $('#iframes').width($(window.body).width());
            $('#iframes').attr('src','/bonusmsg/subWages');
        }else if (dataNum == '3') {
            $('.head').width($(window.body).width());
            $('#iframes').width($(window.body).width());
            $('#iframes').attr('src','/bonusmsg/affBonus');
        }
//        var url=$(this).attr('url');
//        $('#iframes').attr('src',url);

    });
    $(function () {
        $('#iframes').width($(window.body).width())
        var ifm= document.getElementById("iframes");
        var ifHeight=$('#body').height()-$('.head').height();
        ifm.height=ifHeight-35;

        if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
            window.location.replace('/bonusmsg/h5tolead');
        }
    })

    //当前用户登录权限是否显示下属工资与奖金
        $.ajax({
            url:'/bonusPriv/bonusPrivType',
            type:'get',
            dataType:'json',
            success: function (data) {
                if(data.flag){
                    if(data.object.type==1){
                        $('.headli3_1').css('visibility','visible');
                        $('.headli4_1').css('visibility','visible');
                        parent();
                    }else{
                        $('.headli3_1').css('visibility','hidden');
                        $('.headli4_1').css('visibility','hidden');
                        parent();
                    }
                }
            }
        });
            $('#0130', parent.document).on('click',function () {
                location.reload();
            })

//    ifm.height=document.documentElement.clientHeight;
</script>

</body>
</html>
