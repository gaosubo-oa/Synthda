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
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	<title>日历统计</title>
	<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
	<script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
	<script src="../js/diary/m/kalendar.js"></script>
	<link href="../css/diary/m/kalendar.css" rel="stylesheet"/>
	<link href="../lib/mui/mui/mui.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="../css/diary/m/iStarted.css">
	<link rel="stylesheet" href="../css/diary/m/diary_base.css" />
</head>
<body id="calender">
<!--header class="mui-bar mui-bar-nav" id="headder">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left mui-nav-btn"></a>
        <h1 class="mui-title"></h1>

    </header-->
<div class="mui-content" style="margin-bottom: 0;">
	<div class="mui-bg-positive mui-bg-positive">

		<h4 class="mui-text-center mui-num weekday" id="weekdays"  style="font-size: 16px;">0</h4>
		<h1  class="mui-date mui-text-center" id="mui-date" style="margin: 10px auto;"></h1>
		<h5 class="mui-month mui-text-center" href="#" style="color: #fff;padding-top: 0;margin-top: 0;"></h5>
	</div>
	<div id="slider" class="mui-slider mui-calender">
		<div id="wrap"></div>
	</div>

</div>
</body>
<script type="text/javascript">
    var day_type=location.search.substr(1).split("=")[1];
    var wait=null;var closewin=null;
    // H5 plus事件处理
    function plusReady(){
        wait=plus.nativeUI.showWaiting('正在加载');
        closewin= plus.nativeUI.closeWaiting();
    }
    if(window.plus){
        plusReady();
    }else{
        document.addEventListener("plusready",plusReady,false);
    }
    function p(s) {
        return s < 10 ? '0' + s: s;
    }
    var date=new Date();
    var d=date.getDate();
    var y=date.getFullYear();
    var m=date.getMonth()+1;
    var Week = ["日","一","二","三","四","五","六"];
    var w=date.getDay();
    var str_month=y+'年'+p(m)+'月';
    jQuery(".mui-month").html(str_month);
    jQuery("#weekdays").html('星期'+Week[w]);
    jQuery("#mui-date").html(p(d));
    (function($, doc) {
        jQuery("#day ul.dayList li").height(jQuery("#day ul.dayList li").width());
        mui.init();
//        mui.ajax({
//            url: '/pda/diary/data/data.php',
//            type: 'POST',
//            data:{
//                flag:16,
//                year:y,
//                luna:p(m)
//            },
//            dataType:'json',
//            async: true,
//            beforeSend: function() {
//                wait;
//            },
//            complete: function() {
//                closewin;
//            },
//            success:function(data){
//                var all_i=document.getElementsByTagName('i');
//                for(var i=0;i<all_i.length;i++){
//                    if(data[i].READ_FLAG=='0'){
//                        all_i[i].className='red_icon';
//                    }else if(data[i].READ_FLAG=='1'){
//                        all_i[i].className='gray_icon';
//                    }else if(data[i].READ_FLAG=='2'){
//                        //无操作
//                    }
//                }
//
//            }
//        });

    })(mui, document);
    function jump_count(date,day_type){
        if(day_type <= 2){
            if(day_type=='0'){
                var time='day';
            }else if(day_type=='1'){
                var time='week';
            }else if(day_type=='2'){
                var time='month';
            }
            mui.openWindow({
                url:'/diary/diaryCountListh5?'+time+'='+date+'&dia_type='+day_type,
                id:'count_list'
            });
        }else{
            if(day_type=='3'){
                var time='time';
            }else if(day_type=='4'){
                var time='time';
            }else if(day_type=='5'){
                var time='time';
            }
            mui.openWindow({
                url:'ireceived.php?'+time+'='+date+'&dia_type='+day_type,
                id:'ireceived'
            });
        }
    }
</script>
</html>