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
    <title><fmt:message code="main.news" /></title>
    <link rel="stylesheet" href="../css/news/news_query.css"/>
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script>
        $(function(){
            $("li").click(function(){
                $(this).siblings('li').removeClass('one');  // 删除其他兄弟元素的样式
                $(this).addClass("one");
//            $(".news").html($(this).text());
                /* alert($(this).text());*/
            })
        })

    </script>

</head>
<body>
<!--head通栏开始-->
<div class="head w clearfix">
    <ul>
        <li class="one"><fmt:message code="news.th.allnews" /></li>
        <li style="width:2px;"><img src="images/02query.png" alt=""/></li>
        <li><fmt:message code="news.title.unread" /></li>
        <li style="width:2px;"><img src="images/02query.png" alt=""/></li>
        <li><fmt:message code="news.title.query" /></li>
    </ul>
</div>
<!--head通栏结束-->
<!--center内容部分开始-->
<div class="center w">
    <div class="title clearfix">
        <img src="images/01query.png" alt=""/>
        <div class="news"><fmt:message code="news.title.query" /></div>
    </div>

    <div class="login">
        <div class="header"><fmt:message code="global.lang.inputquerycondition" /></div>
        <div class="middle">
            <div class="le publisher">
                <div class="color"><fmt:message code="notice.th.publisher" />：</div>
                <div><input style="height:50px;width:279px;margin-left:56px;margin-right: 15px;" type="text" /></div>
                <div style="margin-right:23px; color:#207BD6"><fmt:message code="global.lang.add" /></div>
                <div><fmt:message code="global.lang.empty" /></div>
            </div>
            <div class="le subject">
                <div class="color"><fmt:message code="notice.th.title" />：</div>
                <div><input style="height:26px;width:279px;margin-left:69px;margin-right: 15px;" type="text"/></div>
            </div>
            <div class="le date">
                <div class="color"><fmt:message code="notice.title.Releasedate" />：</div>
                <div><input style="height:24px;width:119px;margin-left:38px;margin-right: 11px;" type="text"/></div>
                <div class="color"><fmt:message code="global.lang.to" /></div>
                <div> <input  style="height:24px;width:119px;margin-left:11px;" type="text"/></div>
            </div>
            <div class="le ce1">
                <div class="color"><fmt:message code="notice.th.content" />：</div>
                <div><input  style="height:25px;width:279px;margin-left:70px;"   type="text"/></div>

            </div>
            <div class="le ce2">
                <div class="color"><fmt:message code="notice.th.content" />:</div>
                <div><input   style="height:25px;width:279px;margin-left:80px;" type="text"/></div>

            </div>
        </div>
        <div class="icons">
            <img style="margin-right:30px; cursor: pointer;" src="images/threeth_three.png" alt=""/>
            <img style="margin-right:30px; cursor: pointer;"  src="images/4query.png" alt=""/>
            <img style=" cursor: pointer;" src="images/5query.png" alt=""/>
        </div>
    </div>

</div>
<!--center内容部分结束-->

</body>
</html>