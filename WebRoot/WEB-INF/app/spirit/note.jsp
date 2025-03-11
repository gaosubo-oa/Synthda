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
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>便签</title>
    <link rel="stylesheet" type="text/css" href="../css/spirit/oaStyle.css"/>
    <link rel="stylesheet" type="text/css" href="../css/spirit/notes.css"/>
    <script type="text/javascript">
        window.onload=function () {
            if(window.external && typeof window.external.OA_SMS != 'undefined') //如果从OA精灵打开，则最大化窗口
            {
                var h = Math.min(800, screen.availHeight - 180),
                    w = Math.min(1280, screen.availWidth - 180);
                window.external.OA_SMS(w, h, "SET_SIZE");
            }
        }
    </script>
</head>
<body>
<div class="content">
    <div class="nav">
        <ul>
            <li><span class="spanTxt">排序</span></li>
            <li>新建</li>
            <li>导出</li>
            <li><img src="../img/spirit/refesh.png"/></li>
        </ul>
    </div>
    <div class="noteMain">
        <div class="mainCont">
            <div class="title" style="background-color: #f7a46e;">
                <span class="Date">2017年4月26日</span><span class="Time">10:00</span>
            </div>
            <div class="mainContList">
                <p>今日安排</p>
                <p>1.上午十一点提交档案</p>
                <p>2.下午三点半作品审核</p>
            </div>
        </div>
        <div class="mainCont">
            <div class="title" style="background-color: #5acaee;">
                <span class="Date">2017年4月26日</span><span class="Time">10:00</span>
            </div>
            <div class="mainContList">
                <p>今日安排</p>
                <p>1.下午一点十分打卡</p>
                <p>2.下午四点作品审核</p>
            </div>
        </div>
        <div class="mainCont">
            <div class="title" style="background-color: #8ab2ef;">
                <span class="Date">2017年4月26日</span><span class="Time">10:00</span>
            </div>
            <div class="mainContList">
                <p>今日安排</p>
                <p>1.下午一点作品审核</p>
                <p>2.下午三点作品审核</p>
                <p>3.下午六点准时打卡...</p>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    if(window.external && typeof window.external.OA_SMS != 'undefined') //如果从OA精灵打开，则最大化窗口
    {
        var h = Math.min(800, screen.availHeight - 180),
            w = Math.min(1280, screen.availWidth - 180);
        window.external.OA_SMS(w, h, "SET_SIZE");
    }
</script>

</html>

