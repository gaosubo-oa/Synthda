<%--
  Created by IntelliJ IDEA.
  User: 牛江丽
  Date: 2017/9/11
  Time: 17:00
 办公用品库存管理
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="vote.th.inventoryManagement" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../css/base.css" />
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
</head>
<style>
  html,body{
      height:100%;
  }
</style>

<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body style="font-family: 微软雅黑;overflow: hidden;">
<div class="box">
    <%--标题头--%>
    <div class="head w clearfix">
        <ul class="index_head">
            <li data_id=""  url="/officetransHistory/goFixDepository" >
                <span class="one headli1_1">
                 <fmt:message code="vote.th.InventoryMaintenance" />
               </span>
                <img class="headli1_2" src="../../img/twoth.png" alt=""/>
            </li>
         <%--   <li data_id="0" url="/officetransHistory/goPendregistration"  >
                <span class="headli2_1">
                 代登记
                </span>
                <img src="../../img/twoth.png" alt="" class="headli2_2"/>
            </li>--%>
            <li data_id="0" url="/officetransHistory/goQuery"  >
                <span class="headli2_1">
                 <fmt:message code="vote.th.OfficeInquiries" />
                </span>
                <%--<img src="../../img/twoth.png" alt="" class="headli2_2"/>--%>
            </li>
        </ul>
    </div>
</div>
<div class="div_iframe" style="width:100%;height:100%;">
    <iframe class="workPlan_iframe" src="/officetransHistory/goFixDepository" frameborder="0" width="100%" height="100%"></iframe>
</div>
<script>
    //标题头操作
    $(function () {
//        var iframeH=$('.box').height()-$('.head').height();
//        $('.div_iframe').height(iframeH);

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
</body>
</html>
