<%--
  Created by IntelliJ IDEA.
  User: 牛江丽
  Date: 2017/9/11
  Time: 17:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="main.assetmanage" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../css/base.css?20201224" />
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    body,html{
        width:100%;
        height:94%;
    }
  .navigation{
      margin-left: 3%;
  }
    .head{
        height:45px;
    }
</style>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body style="font-family: 微软雅黑;">
<div>
    <%--标题头--%>
    <div class="head w clearfix">
        <ul class="index_head">
            <li data_id=""  url="/eduFixAssets/fixAssetsManager">
                <span class="one headli1_1">
                 资产管理
               </span>
                <img class="headli1_2" src="../img/twoth.png" alt=""/>
            </li>
            <%--<li data_id="0" url="/eduFixAssets/fixAssetsEdit?editFlag=0&id=0">--%>
                <%--<span class="headli2_1">--%>
                   <%--<fmt:message code="event.th.NewAssets" />--%>
                <%--</span>--%>
                <%--<img src="../img/twoth.png" alt="" class="headli2_2"/>--%>
            <%--</li>--%>
            <li data_id="1"  url="/eduFixAssets/fixAssetsQuery">
                <span class="headli3_1">
                  资产查询
               </span>
                <img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
            <li data_id="2"  url="/eduFixAssets/fixAssetsInput">
                <span class="headli3_1">
                  资产导入
               </span>
                <img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
            <li data_id="2"  url="/eduFixAssets/fixAssetsStatic">
                <span class="headli3_1">
                  资产分布概况
               </span>
                <img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
             <li data_id="2"  url="/eduFixAssets/fixAssetsSetting">
                <span class="headli3_1">
                  二维码设置
               </span>
                <img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
            <li data_id="2"  url="/eduFixAssets/fixAssetsType">
                <span class="headli3_1">
                  资产类别设置
               </span>
            </li>

        </ul>
    </div>
</div>
<div style="width:100%;height:100%;">
    <iframe class="fixAssets_iframe" src="/eduFixAssets/fixAssetsManager" frameborder="0" width="100%" height="100%"></iframe>
</div>
<script>
    //标题头操作
    $(function () {
        /*点击标题，获取对应的url，显示对应的src*/
        $('.index_head').on('click', 'li', function () {
            // 设置样式
            $('.index_head span').removeClass("one")
            $(this).children("span").addClass("one");
            // 获取url
            var url = $(this).attr('url');
            $('.fixAssets_iframe').attr('src', url);
        });
    });
    function show(){
        $('.index_head li').eq(0).find('span').addClass('one').parent().siblings().find('span').removeClass('one')
    }
</script>
</body>
</html>
