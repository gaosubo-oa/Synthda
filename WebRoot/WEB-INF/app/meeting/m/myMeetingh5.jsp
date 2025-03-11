<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<title>我的会议</title>
	<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="../../lib/mui/mui/mui.min.js"></script>
	<script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
	<link href="../../lib/mui/mui/mui.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="../css/diary/m/iStarted.css">
	<link rel="stylesheet" href="../css/meeting/m/myMeetingh5.css" />
	<script type="text/javascript" charset="utf-8">
        mui.init();
	</script>
	<style media="screen">
		/*覆盖搜索框的图标颜色*/
		.mui-search .mui-placeholder .mui-icon{
			font-size:20px;
			color:#c1c1c1;
		}
		/*修改底部发起日志按钮的边框颜色*/
		.log{
			border-color:#598fde;
		}
		/*覆盖底部按钮父元素边框颜色*/
		#nav{
			-webkit-box-shadow: 0 0 1px #d6d6d6;
		}
	</style>
</head>
<body id="iStarted">
<div class="mui-content">
	<div class="stat_sear">
		<div class="mui-input-row mui-search diarySearch">
			<input type="search" class="mui-input-clear" id="searchLog" placeholder="搜索">
		</div>
	</div>
	<ul class="mui-table-view list" id="list" style="padding-bottom:50px;">
		<li class="mui-table-view-cell">
            <a class="mui-navigate-right">
                <div class="con_bt">
                   <img src="../img/meeting/m/img1.png" alt="">
                   <span class="name"> 需求会议室</span>
                   <span class="f_right end">已结束</span>
                </div>
                <div class="con_bt">
                    <img src="../img/meeting/m/img2.png" alt="">
                    <span>明显</span>
                </div>
                <div>
                    <img src="../img/meeting/m/img3.png" alt="">
                    <span>张伟</span>
                    <span class="f_right time">2018-03-13  13:34:57</span>
                </div>
            </a>
        </li>
        <li class="mui-table-view-cell">
            <a class="mui-navigate-right">
                <div class="con_bt">
                    <img src="../img/meeting/m/img1.png" alt="">
                    <span class="name"> 需求会议室</span>
                    <span class="f_right end">已结束</span>
                </div>
                <div class="con_bt">
                    <img src="../img/meeting/m/img2.png" alt="">
                    <span>明显</span>
                </div>
                <div>
                    <img src="../img/meeting/m/img3.png" alt="">
                    <span>张伟</span>
                    <span class="f_right time">2018-03-13  13:34:57</span>
                </div>
            </a>
        </li>
        <li class="mui-table-view-cell">
            <a class="mui-navigate-right">
                <div class="con_bt">
                    <img src="../img/meeting/m/img1.png" alt="">
                    <span class="name"> 需求会议室</span>
                    <span class="f_right end">已结束</span>
                </div>
                <div class="con_bt">
                    <img src="../img/meeting/m/img2.png" alt="">
                    <span>明显</span>
                </div>
                <div>
                    <img src="../img/meeting/m/img3.png" alt="">
                    <span>张伟</span>
                    <span class="f_right time">2018-03-13  13:34:57</span>
                </div>
            </a>
        </li>
	</ul>
</div>
</body>
</html>
