<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/26
  Time: 10:43
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
<head>
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/css/index/style.css">
    <link rel="stylesheet" href="/css/index/widget.css">
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>

    <title>今日事</title>
    <style>
        .dateNull {
            color: #72aafd;
            width: 100%;
            height: 30px;
            line-height: 30px;
            text-align: center;
            font-size: 14px;
        }
    </style>
</head>


<body>

    <div id="body">
        <div class="info_box todayMenu clearfix">
            <div class="infoBox_header">
                <img src="/img/widgets/menu.png" alt="" style="height: 18px;margin-top: 12px;">
                <span>日程</span>
                <!--<span class="more">更多</span>-->
                <div class="more">
                    <img src="/img/widgets/adds.png" alt="" style="height: 15px;margin-top: 13px;">
                    <span id="schedule">新建</span>
                </div>
            </div>
            <ul class="today_body clearfix" id="today">

                <li>
                <div class="left_tody marginleft"></div>
                <img src="/img/user/boy.png" class="left_tody">
                <div class="left_tody">fdsfds</div>
                <img src="/img/user/boy.png" class="right_tody">
                </li>
            </ul>
        </div>
    </div>


</body>

<script>
    //当前日期日期计算
    var now = null;
    var  today_now=null;
    function p(s) {
        return s < 10 ? '0' + s: s;
    }
    var myDate = new Date();
    //获取当前年
    var year=myDate.getFullYear();
    //获取当前月
    var month=myDate.getMonth()+1;
    //获取当前日
    var date=myDate.getDate();
    var h=myDate.getHours();       //获取当前小时数(0-23)
    var m=myDate.getMinutes();     //获取当前分钟数(0-59)
    var s=myDate.getSeconds();

    now=year+'-'+p(month)+"-"+p(date)+" "+p(h)+':'+p(m)+":"+p(s);
    today_now=year+'-'+p(month)+"-"+p(date);
    // 获取某个时间格式的时间戳
    var timestamp2 = Date.parse(new Date(now));
    timestamp2 = timestamp2 / 1000;//当前时间
    /*console.log(now + "的时间戳为：" + timestamp2);*/
    //今天时间
    var	timestamp1= Date.parse(new Date(today_now));
    timestamp1 = timestamp1 / 1000;//当前今天时间
    $.get('/schedule/getscheduleByDay',{
        userId: $.cookie('userId'),
        time:today_now
    },function (json) {
        if(json.flag){

        }
    },'json')
</script>



</html>
