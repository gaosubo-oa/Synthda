<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title><fmt:message code="main.worklog"/></title>
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
    <link rel="stylesheet" type="text/css" href="../css/dept/workLog.css"/>
    <script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>

</head>
<body>
<div class="headDept clearfix">
    <div class="head w clearfix">
        <ul class="index_head">
            <li data_id=""><span class="one headli1_1"><fmt:message
                    code="news.th.newsmanage"/></span><img class="headli1_2" src="../img/twoth.png" alt=""/>
            </li>
            <li data_id="0"><span class="headli2_1"><fmt:message
                    code="news.th.newbuild"/></span><img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
            <li data_id="1"><span class="headli3"><fmt:message code="news.title.query"/></span></li>
        </ul>
    </div>
</div>





</body>



</html>
