<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="main.news" /></title>
    <link rel="stylesheet" href="../css/news/center.css"/>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css?"/>
    <script src="/js/common/language.js"></script>

    <style>

        thead .th{
            font-size: 13pt;
        }
        #j_tb a{
            font-size: 110pt !important;
        }
    </style>

</head>
<body>
<!--head开始-->
<div class="head w clearfix">
    <ul>
        <li class="one"><fmt:message code="news.th.allnews" /></li>
        <li><fmt:message code="news.title.unread" /></li>
        <li><fmt:message code="news.title.query" /></li>
    </ul>
</div>
<!--head通栏结束-->
<!--navigation开始-->
<div class="navigation w clearfix">
<div class="left">
    <img src="../img/news_first.png">
    <div class="news"><fmt:message code="news.th.allnews" /></div>
    <div class="button1">
        <div><fmt:message code="news.th.file" /></div>
        <img src="../img/v.png">
    </div>
    <div >
        <div style="font-size: 15px;"><fmt:message code="global.lang.date" /> :</div>
        <div class="button1">
            <div>2017-03-24</div>
            <img src="../img/v.png">
        </div>

    </div>
    <div class="button1" style="background-color:#F99C0F;padding: 0 10px"><fmt:message code="global.lang.query" /></div>
</div>
<div class="right">
    <div class="one"><fmt:message code="global.page.pre" /></div>
    <div>1</div>
    <div>2</div>
    <div>3</div>
    <div>4</div>
    <div>...</div>
    <div class="one"><fmt:message code="global.page.next" /> 》</div>
</div>

</div>
<!--navigation结束-->

<!--content部分开始-->
<div class="w">
    <div class="wrap">
        <table class="w">
            <thead>
            <tr >
                <td class="th"><fmt:message code="notice.th.title" /></td>
                <td class="th"><fmt:message code="notice.th.type" /></td>
                <td class="th"><fmt:message code="notice.th.PostedTime" /></td>
                <td class="th"><fmt:message code="news.th.clicks" /></td>
                <td class="th"><fmt:message code="news.th.commentnew" /></td>
            </tr>
            </thead>
            <tbody id="j_tb">
            <tr>
                <td>
                   <fmt:message code="news.th.way" />
                </td>
                <td><fmt:message code="news.th.industry" /></td>
                <td>2017-04-14  10:55</td>
                <td>01</td>
                <td>20</td>
            </tr>
            <tr>
                <td>
                    <fmt:message code="news.th.way" />
                </td>
                <td><fmt:message code="news.th.industry" /></td>
                <td>2017-04-14  10:55</td>
                <td>01</td>
                <td>20</td>
            </tr>
            <tr>
                <td>
                    <fmt:message code="news.th.way" />
                </td>
                <td><fmt:message code="news.th.industry" /></td>
                <td>2017-04-14  10:55</td>
                <td>01</td>
                <td>20</td>

            </tr>
            <tr>
                <td>
                    <fmt:message code="news.th.way" />
                </td>
                <td><fmt:message code="news.th.industry" /></td>
                <td>2017-04-14  10:55</td>
                <td>01</td>
                <td>20</td>

            </tr>
            <tr>
                <td>
                    <fmt:message code="news.th.way" />
                </td>
                <td><fmt:message code="news.th.industry" /></td>
                <td>2017-04-14  10:55</td>
                <td>01</td>
                <td>20</td>

            </tr>
            <tr>
                <td>
                    <fmt:message code="news.th.way" /><!-- 团队调高效率的方法 -->
                </td>
                <td><fmt:message code="news.th.industry" /></td><!--行业资讯  -->
                <td>2017-04-14  10:55</td>
                <td>01</td>
                <td>20</td>

            </tr>
            </tbody>
        </table>
    </div>


</div>
<!--content部分结束-->

<!--footer部分开始-->
<div class="footer w clearfix">
 <div><fmt:message code="notice.th.quickoperation" /></div><!-- 快捷操作 -->
 <div><fmt:message code="news.th.signread" /></div><!-- 标识所有的新闻为已读 -->

</div>


<!--footer部分结束-->

</body>

<script>

    // 1. 获得要操作的对象
    var tBody = document.getElementById("j_tb");
    var trs = tBody.children;//只会获得子标签节点，孙子标签节点大大的不要
    // 2. 隔行变色
    for(var i=0;i<trs.length;i++){
        if(i%2==0){
            trs[i].style.backgroundColor = "#F6F7F9";
        }else {
            trs[i].style.backgroundColor = "#fff";
        }
        // 3. 鼠标移入当前行的时候，让当前行的背景颜色 变成白色
        var bg ;
        trs[i].onmouseover =function (){
            bg = this.style.backgroundColor;//将当前的颜色先存起来
            this.style.backgroundColor = "#D3E7FA";
        }
        trs[i].onmouseout = function (){
            this.style.backgroundColor = bg;
        }
    }

</script>
</html>