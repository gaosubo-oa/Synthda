<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-05-15
  Time: 9:36
  To change this template use File | Settings | File Templates.
--%>
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
<head>
    <meta charset="UTF-8">
    <title><fmt:message code="new.th.newsPreview" /></title>
    <link rel="stylesheet" type="text/css" href="../css/news/newsDetail.css"/>
    <script src="/js/common/language.js"></script>
<%--    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="../js/webOffice/fileShow.js?20210423.1" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        .divTxt p{
            word-wrap: break-word;
        }
    </style>
</head>
<body>
<div class="detailsContent">
    <div class="title"></div>
    <div class="infor">
        <ul>
            <li>
                <span><fmt:message code="notice.th.publisher" />：</span>
                <span class="publisher"></span>
            </li>
            <li>
                <span><fmt:message code="notice.th.PostedTime" />：</span>
                <span class="time"></span>
            </li>
        </ul>
    </div>
    <div class="divContent">
        <div class="divTxt">
        </div>
        <div class="divContent1" style="border-top:1px solid #dedede; padding-top:10px;">
            <table class="Table" cellspacing="0" cellpadding="0">
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    var type= getQueryString("type") || ''
    $.get('/portals/selPortalsUser',function (res) {
       $('.publisher').html(res.object.userName)
    })
    if(window.opener.document.getElementById('query_subject').value){
        var title=window.opener.document.getElementById('query_subject').value
    }else if(window.opener.document.getElementById('step3_ip1').value){
        var title=window.opener.document.getElementById('step3_ip1').value
    }else{
        var title=''
    }
    var time=window.opener.document.getElementById('query_newTime').value
    var content=window.opener.document.getElementById('newsPreview').innerHTML
    $('.title').html(title)
    $('.time').html(time)
    $('.divTxt').html(content)
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }
</script>
</body>
</html>


