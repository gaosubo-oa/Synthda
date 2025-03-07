<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html style="height:100%;">
<head lang="en">
    <title><fmt:message  code="vote.th.Examination"/></title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106"></script>
    <style>
        table{
            table-layout: fixed;
        }
        .bx{
            height: 100%;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="height:100%;">
<div class="bx">
    <!--head开始-->
    <div class="head w clearfix">
        <ul class="index_head">
           <li data_id="0" data-num="0" url="/officetransHistory/NoApproval"><span class="one headli1_1"><fmt:message  code="event.th.PendingApplication"/></span><img class="headli1_2" src="../img/twoth.png" alt=""/>
            </li>
            <li data_id="" data-num="1" url="/officetransHistory/applyRecord"><span class="headli2_1"><fmt:message  code="vote.th.ClaimQuery"/></span>
            </li>
        </ul>
    </div>
    <div class="div_iframe" style="width:100%;height:100%;">
        <iframe class="workPlan_iframe" src="/officetransHistory/NoApproval" frameborder="0" width="100%" height="100%"></iframe>
    </div>
</div>

</body>
</html>

<script>
    //标题头操作
    $(function () {

        //设置高
        var div_iframe_h=$('.bx').height() - $('.head').height() - 7;
        $('.div_iframe').height(div_iframe_h);

        /*点击标题，获取对应的url，显示对应的src*/
        $('.index_head').on('click', 'li', function () {
            // 设置样式
            $('.index_head span').removeClass("one")
            $(this).children("span").addClass("one");
            // 获取url
            var url = $(this).attr('url');
            $('.workPlan_iframe').attr('src', url);
        });
    });
</script>
