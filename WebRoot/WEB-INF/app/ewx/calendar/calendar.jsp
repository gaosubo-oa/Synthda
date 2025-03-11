<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="width=device-width,user-scalable=no" name="viewport" />
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no" />
    <title>日程安排</title>
    <link href="../../css/animate.min.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <style>
        .header {
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 15px;
            color: #fff;
            position: fixed;
            width: 100%;
            z-index: 1;
        }
        .header1 {
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 15px;
            color: #fff;
            position: fixed;
            width: 100%;
            z-index: 1;
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        .header1 i a{
            color: #fff;
            text-decoration:none
        }
        .header1 i{
            display: inline-block;
            padding:0 13px;
            font-style:normal;
        }
        .header i a{
            color: #fff;
            text-decoration:none
        }
        .header i{
            display: inline-block;
            padding:0 13px;
            font-style:normal;
        }
        .herderc{
            background-color: #ececec;
            height: 30px;
            color: #00a0e9;
            margin-top: 10px;
            position: relative;
            z-index: 0;
        }
        body{margin:0;}
        a{-webkit-tap-highlight-color:rgba(0, 0, 0, 0);-moz-tap-highlight-color:rgba(0, 0, 0, 0);-ms-tap-highlight-color:rgba(0, 0, 0, 0);
            -o-tap-highlight-color:rgba(0, 0, 0, 0);tap-highlight-color:rgba(0, 0, 0, 0);}
        #CalendarMain{float:left;width:100%;height:300px;}
        #title{float:left; width:100%;height:40px;background-color:#60a7e8}
        .selectBtn{padding:12px 10px 11px 10px;color:#fff;text-decoration:none;font-weight:900;font-size:15px;cursor:pointer}


        .selectYear{position:absolute;float:left;margin-left:60px}
        .selectMonth{position:absolute;float:left;margin-left:130px}
        .month{position:absolute;float:left}
        .nextMonth{float:right}
        .currentDay{float:right}


        #context{float:left; width:100%;background-color:#000;}
        .week{width:100%;height:30px;background-color:#fff; color:#333;}
        .week>h3{float:left;margin:0;padding:0;margin-top: 5px;color:#333;text-align:center;font-size:15px}
        .dayItem{float:left;padding-bottom:15px;background-color:#fff;}


        /*上月和当月余下的日期填充*/
        .lastItem{color:#d1c7b7 !important; cursor:default;}
        .lastItem>a{color:#d1c7b7 !important;cursor:default;}
        .item{float:left;margin:0;color:#333;text-align:center;font-size:13px;font-family:"微软雅黑";cursor:pointer;}
        .item:hover{color:#b9121b}


        /*当前日期的颜色*/
        .currentItem>a{float:left;width:25px;-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;background-color:#5fa4e7;color:#fff;line-height:25px}
        /*手指点击日期后颜色*/
        .clickItem>a{float:left;width:25px;height:25px; line-height:25px;background-color:#ccc; color:#333;-webkit-border-radius:50%;-moz-border-radius:50%;border-radius:50%;}


        #foots{margin-top:-1px;width:100%;height:35px;border-top:1px solid #ccc;background-color:#fff}
        #footNow{float:left;margin:6px 0 0 5px;color:#009ad6;font-family:"微软雅黑"}
        #Container{float:left;overflow:hidden}


        #center{float:left; overflow:hidden;width:100%;margin-bottom:5px;}
        #centerMain{width: 300%; margin-left: -100%;}
        #selectYearDiv{float:left;width:100%;background-color:#fff}
        #selectYearDiv>div{float:left;margin-top:-1px;margin-left:-1px;border:1px solid #eee;color:#909090;text-align:center;font-size:16px;font-family:"微软雅黑";cursor:pointer}
        .currentMontSd,.currentYearSd{color:#f40!important}
        #selectMonthDiv{float:left;width:100%;background-color:#fff}
        #selectMonthDiv>div{float:left;margin-top:-1px;margin-left:-1px;border:1px solid #eee;color:#909090;text-align:center;font-size:16px;font-family:"微软雅黑";cursor:pointer}
        #selectMonthDiv>div:hover,#selectYearDiv>div:hover{background-color:#efefef}
        #centerCalendarMain{float:left}


        /*底部显示信息*/
        .downdiv{float:left;width:100%;background-color:#fff;margin-top:-10px; padding:5px 0;}
        .downdiv-time{float:left;width:92%;padding:5px 3%;margin-left:1%; line-height:18px; text-indent:3px;}
        .zhibanDiv{float:left;width:92%;padding:5px 3%;margin-left:1%; }
        img{border:0;outline:none;}
        .process-top{position:fixed;top:0;left:0; width:100%;height:50px;line-height:50px;font-size:17px;z-index:6;
            font-weight:normal;text-align:center;margin-bottom:20px;border-bottom:1px solid #dbdbdb;background-color:#fff;color:#333;}

        /*头部左侧*/
        .process-top .left a{position:absolute;left:10px;top:0; color:#333;width:10%;}

        .mobile{position:absolute;top:118px;left:0;width:100%;right:0;z-index:5;}
        .nav{
            width: 60%;
            height: 42px;
            margin: 18px 0;
        }

        /*.navc{*/
        /*background-color: #00a0e9;*/
        /*color: #fff;*/
        /*border-radius: 10px;*/
        /*}*/
        .fl{
            float: left;
        }
        .fr{
            float: right;
        }
        p{
            margin: 6px 0;
        }
        .spanc{
            background-color: #00a0e9;
            width: 40px;
            display: inline-block;
            text-align: center;
            height: 22px;
            line-height: 21px;
            border-radius: 6px;
            color: #fff;
        }
        li{
            list-style: none;
        }
        a{
            text-decoration: none;
            color: #000;
        }
        .ove{
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-weight: bold;
        }

        .nav ul{
            width: 60%;
            height: 28px;
            margin: 8px 20%;
            border-radius: 0.8333333333333333px;
            border: 1px solid #3d91e4;
            border-left: none;
            border-right: none;
            position: fixed;
            z-index: 2;
            padding-left: 0;
            border-radius: 4px;
        }
        .navs li{
            width: 49.0%;
            float: left;
            border-right: 1px solid #3d91e4;
            border-left: 1px solid #3d91e4;
            color: #3d91e4;
            height: 101%;
            line-height: 28px;
            text-align: center;
            font-size: 15px;
            border-radius: 4px 0px 0px 4px;
        }
        .nav .navs .navc{
            color: #ffffff;
            background: #3d91e4;
        }
    </style>
</head>

<body>
<div class="header1">
    <i><a id="back" href="javascript:;">返回</a></i>
    <span>日程安排</span>
    <i><a class="add" id="add" href="javascript:;">新增</a></i>
</div>
<div style="height: 40px"></div>
<%--<div style="padding: 10px 0;">--%>
<%--<div class="nav">--%>
<%--<span class="navc fl">日历</span>--%>
<%--<span  class="fr">列表</span>--%>
<%--</div>--%>

<%--</div>--%>

<div class="nav">
    <ul class="navs">
        <li class="navc fl">日历</li>
        <li class="fr" style="border-radius: 0px 4px 4px 0px;">列表</li>
    </ul>
</div>
<div class="mobile animated fadeInRight">
    <div id="Demo">
        <div id="CalendarMain">
            <div id="title">
                <a class="selectBtn month" href="javascript:" onclick="CalendarHandler.CalculateLastMonthDays();"><</a>
                <a class="selectBtn selectYear" href="javascript:" onclick="CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart);">2014年</a>
                <a class="selectBtn selectMonth" onclick="CalendarHandler.CreateSelectMonth()">6月</a>
                <a class="selectBtn nextMonth" href="javascript:" onclick="CalendarHandler.CalculateNextMonthDays();">></a>
                <a class="selectBtn currentDay" href="javascript:" onclick="CalendarHandler.CreateCurrentCalendar(0,0,0);">今天</a>
            </div>
            <div id="context">
                <div class="week">
                    <h3>一 </h3>
                    <h3>二 </h3>
                    <h3>三 </h3>
                    <h3>四 </h3>
                    <h3>五 </h3>
                    <h3>六 </h3>
                    <h3>日 </h3>
                </div>
                <div id="center">
                    <div id="centerMain">
                        <div id="selectYearDiv"></div>
                        <div id="centerCalendarMain">
                            <div id="Container"></div>
                        </div>
                        <div id="selectMonthDiv"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="downdiv">
        <div class="downdiv-time">
            <label id="lblTime"></label>
        </div>
        <div class="zhibanDiv">
            <div id="zbtbody">

            </div>
        </div>
    </div>
</div>

<div class="nav1 " style="display: none">
    <div>
        <div class="header herderc">
            <i>今天</i>
            <i><a href="javascript:;" class="add" style="color:#00a0e9;">新增</a></i>
        </div>
        <div style="margin: 0 10px;font-size: 13px;">
            <div id="zbtbody1">

            </div>
        </div>
    </div>
    <div>
        <div class="header herderc">
            <i>明天</i>
            <i><a href="javascript:;" class="add" style="color:#00a0e9;">新增</a></i>
        </div>
        <div style="margin: 0 10px;font-size: 13px;">
            <div id="zbtbody2">

            </div>
        </div>
    </div>
    <div>
        <div class="header herderc">
            <i>后天</i>
            <i><a href="javascript:;" class="add" style="color:#00a0e9;">新增</a></i>
        </div>
        <div style="margin: 0 10px;font-size: 13px;">
            <div id="zbtbody3">

            </div>
        </div>
    </div>
    <div>
        <div class="header herderc">
            <i id="datas"></i>
            <i><a href="javascript:;" class="add" style="color:#00a0e9;">新增</a></i>
        </div>
        <div style="margin: 0 10px;font-size: 13px;">
            <div id="zbtbody4">

            </div>
        </div>
    </div>
    <div>
        <div class="header herderc">
            <i id="datas1"></i>
            <i><a href="javascript:;" class="add" style="color:#00a0e9;">新增</a></i>
        </div>
        <div style="margin: 0 10px;font-size: 13px;">
            <div id="zbtbody5">

            </div>
        </div>
    </div>
    <div>
        <div class="header herderc">
            <i id="datas2"></i>
            <i><a href="javascript:;" class="add" style="color:#00a0e9;">新增</a></i>
        </div>
        <div style="margin: 0 10px;font-size: 13px;">
            <div id="zbtbody6">

            </div>
        </div>
    </div>
    <div>
        <div class="header herderc">
            <i id="datas3"></i>
            <i><a href="javascript:;" class="add" style="color:#00a0e9;">新增</a></i>
        </div>
        <div style="margin: 0 10px;font-size: 13px;">
            <div id="zbtbody7">

            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    var dataList1 = [];
    var dataList2 = [];
    var dataList31 = [];
    var userId=''

    $(function(){

        $.ajax('/user/getNowLoginUser',{
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            success:function(data){
                if(data.flag){

                    initData(data.object.userId);
                }
            }
        });

        function initData(userId_p){
            if(userId_p!=undefined&&userId_p!=''){
                userId = userId_p;
            }
            $.ajax({
                type: "get",
                url: "/schedule/getscheduleBycId?userId="+userId+"&time="+getDay(0),
                dataType: "json",
                async: false,
                success: function (data) {
                    if(data.flag){
                        for(var n = 0; n < data.obj.length; n++) {
                            dataList1.push(data.obj[n]);
                        }
                    }
                }
            });


            var date = new Date();
            var needTwo = false;
            var mouth31 = [1,3,5,7,8,10,12];
            var year = date.getFullYear();
            var mouth = date.getMonth() + 1;
            var day = date.getDate();
            if(mouth31.indexOf(mouth)>=0){
                if(day>25){
                    needTwo = true;
                }

                date.setDate(31);
                $.ajax({
                    type: "get",
                    url: "/schedule/getscheduleByDay?userId="+userId+"&time="+getDay(0),
                    dataType: "json",
                    success: function (data) {
                        if(data.flag){
                            for(var i=0;i<data.obj.length;i++) {
                                $('#zbtbody').append("<a class='add' href='/ewx/calendarDetails?calId="+data.obj[i].calId+"&dataType="+$.GetRequest().dataType+"' style='position:relative;' calId='"+data.obj[i].calId+"' calType='"+data.obj[i].calType+"' calLevel='"+data.obj[i].calLevel+"'><img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''><ul><li class='ove1'>" + data.obj[i].content + "</li><li class='ove2'>开始时间" + data.obj[i].stim + "</li><li class='ove3'>结束时间" + data.obj[i].etim + "</li></ul></a>");
                            }
                        }
                    }
                });
            }else{
                if(day>24) {
                    needTwo = true;
                }
                $.ajax({
                    type: "get",
                    url: "/schedule/getscheduleByDay?userId="+userId+"&time="+getDay(0),
                    dataType: "json",
                    success: function (data) {
                        if(data.flag){
                            for(var i=0;i<data.obj.length;i++) {
                                $('#zbtbody').append("<a class='add' href='/ewx/calendarDetails?calId="+data.obj[i].calId+"&dataType="+$.GetRequest().dataType+"' style='position:relative;' calId='"+data.obj[i].calId+"' calType='"+data.obj[i].calType+"' calLevel='"+data.obj[i].calLevel+"'><img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''><ul><li class='ove1'>" + data.obj[i].content + "</li><li class='ove2'>开始时间" + data.obj[i].stim + "</li><li class='ove3'>结束时间" + data.obj[i].etim + "</li></ul></a>");
                            }
                        }
                    }
                });
            }

            if(needTwo){
                $.ajax({
                    type: "get",
                    url: "/schedule/getscheduleBycId?userId="+userId+"&time="+getDay(6),
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if(data.flag){
                            for(var n = 0; n < data.obj.length; n++) {
                                dataList2.push(data.obj[n]);
                            }
                        }
                    }
                });
            }
            for(var j=0; j<7; j++) {
                var i = day + j;
                if(mouth31.indexOf(mouth)>=0) {
                    if(i < 31) {
                        if(typeof(dataList1[i - 1].calMessage)!="undefined") {
                            getSevenDays(j, dataList1[i - 1].calMessage);
                        }
                    }
                } else {
                    if(i < 30) {
                        if(typeof(dataList1[i - 1].calMessage)!="undefined") {
                            getSevenDays(j, dataList1[i - 1].calMessage);
                        }
                    } else {
                        if(typeof(dataList2[i - 31].calMessage)!="undefined") {
                            getSevenDays(j, dataList2[i - 31].calMessage);
                        }
                    }
                }
            }

        }

        $('#back').on('click', function(){
            window.location.href='/ewx/index?dataType='+$.GetRequest().dataType

        })
        $('.add').on('click', function(){
            window.location.href='/ewx/addSchedule?dataType='+$.GetRequest().dataType

        })


    })

    function getSevenDays(i, dataList)
    {
        var j = i+1;
        if(typeof(dataList)!="undefined") {
            $.each(dataList, function (index, item) {
                $('#zbtbody'+(j)).append("<a class='add' href='/ewx/calendarDetails?calId="+item.calId+"&dataType="+$.GetRequest().dataType+"' style='position:relative;' calId='"+item.calId+"' calType='"+item.calType+"' calLevel='"+item.calLevel+"'><img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''><ul><li class='ove1' style='width: 95%;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>" + item.content + "</li><li class='ove2'>开始时间" + item.stim + "</li><li class='ove3'>结束时间" + item.etim + "</li></ul></a>");
            });
        }
    }



    window.addEventListener('refresh', function(e){//执行刷新
        location.reload();
    });
    function getCookie(name)
    {
        var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
        if(arr=document.cookie.match(reg))
            return unescape(arr[2]);
        else
            return null;
    }

    $('.navs').on('click','li',function(){
        $('li').removeClass('navc')
        $(this).addClass('navc')
        if($('.fl').hasClass('navc')){
            $('.nav1').css('display','none')
            $('.mobile').css('display','block')
        }
        if($('.fr').hasClass('navc')){
            $('.nav1').css('display','block')
            $('.mobile').css('display','none')
            $('.mobile').css('background-color','#fff')
        }
    })

    //仅仅只获取年月日
    function getDay(day) {
        var today = new Date();
        var targetday_milliseconds = today.getTime() + 1000 * 60 * 60 * 24 * day;
        today.setTime(targetday_milliseconds); //注意，这行是关键代码
        var tYear = today.getFullYear();
        var tMonth = today.getMonth();
        var tDate = today.getDate();
        tMonth = doHandleMonth(tMonth + 1);
        tDate = doHandleMonth(tDate);
        return tYear + "-" + tMonth + "-" + tDate;
    }
    function doHandleMonth(month) {
        var m = month;
        if (month.toString().length == 1) {
            m = "0" + month;
        }
        return m;
    }


    String.prototype.trimLast = function () {
        /// <summary>去掉最后一个字符 </summary>
        return this.substr(0, this.length - 1);
    }
    //通过正则表达式获取地址栏的参数 var get_name = getQueryName("name");
    function getQueryName(name) {
        var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"));
        if (result == null || result.length < 1) {
            return "";
        }
        return result[1];
    }
    //获取json串的长度 var jsonLen=getJsonLen(jsonData);
    function  getJsonLen (json) {
        var Length = 0;
        for (var item in json) {
            Length++;
        }
        return Length;
    }
    $(document).ready(function (e) {
        CalendarHandler.initialize();
        $(".lastItem").attr("disabled", true);
        $(".lastItem").text("");
        getNowDay();
    });
    function getNowDay() {
        $('#datas').html(getDay(3))
        $('#datas1').html(getDay(4))
        $('#datas2').html(getDay(5))
        $('#datas3').html(getDay(6))
        var nowday = getDay(0);
        $("#lblTime").text(nowday);
        var getuserid = getQueryName("userid"); //获取userid
        //初始加载今天的值班信息
//         $.ajax({
//             type: "get",
//             url: "/schedule/getscheduleBycId?userId="+userId+"&time="+nowday,
//             dataType: "json",
//             success: function (data) {

        var zhibanman = "";
        $('#zbtbody').html("");
        //遍历
        $.each(dataList1, function (index, item) {
            if(nowday==item.calData){

                for(var i=0;i<item.calMessage.length;i++) {
                    $('#zbtbody').append("<a class='add' href='/ewx/calendarDetails?calId="+item.calMessage[i].calId+"&dataType="+$.GetRequest().dataType+"' style='position:relative;' calId='"+item.calMessage[i].calId+"' calType='"+item.calMessage[i].calType+"' calLevel='"+item.calMessage[i].calLevel+"'><img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''><ul><li class='ove1' style='width: 95%;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>" + item.calMessage[i].content + "</li><li class='ove2'>开始时间" + item.calMessage[i].stim + "</li><li class='ove3'>结束时间" + item.calMessage[i].etim + "</li></ul></a>");
                };
            }
        });

//             },
//             error: function (XMLHttpRequest, textStatus, errorThrown) {
//                 // alert(errorThrown);
//             }
//         });
    }
    function addd(id){
        $(id).on('click','.add',function(){
            var content=$(this).children().children(".ove1").text()
            var stims=$(this).children().children(".ove2").text()
            var etims=$(this).children().children(".ove3").text()
            var calType=$(this).attr('calType')
            var calLevel=$(this).attr('calLevel')
            var stim=stims.slice(4)
            var etim=etims.slice(4)
            var calId=$(this).attr('calId')

            sessionStorage.setItem("content", content);
            sessionStorage.setItem("stim", stim);
            sessionStorage.setItem("etim", etim);
            sessionStorage.setItem("calType", calType);
            sessionStorage.setItem("calLevel", calLevel);
            sessionStorage.setItem("calId", calId);
        });
    }
    addd('#zbtbody');
    addd('#zbtbody1');
    addd('#zbtbody2');
    addd('#zbtbody3');
    addd('#zbtbody4');
    addd('#zbtbody5');
    addd('#zbtbody6');
    addd('#zbtbody7');

    function sendDate() {
        $(".dayItem .item").on('click', function () {
            var getClass = $(this).attr('class');
            if (getClass.indexOf("lastItem") == -1) {
                var getyear = $(".selectYear").text();
                getyear = getyear.trimLast();
                var getmonth = $(".selectMonth").text();
                getmonth = getmonth.trimLast();
                var gettext = $(this).text();
                if(gettext<10){
                    gettext=0+$(this).text();
                }
                var sendDate = getyear + "-" +function(){if(getmonth<10){return 0}}()+ getmonth + "-" + gettext;


                $(this).addClass("clickItem").siblings(".item").removeClass("clickItem").removeClass("currentItem");
                $(this).siblings(".item").children("a").css({ 'margin-left': '0', 'margin-top': '0' });
                $(".clickItem>a").css("margin-left", ($(".item").width() - 25) / 2 + "px").css("margin-top", ($(".item").height() - 25) / 2 + "px");
                $(".currentItem>a").css("margin-left", ($(".item").width() - 25) / 2 + "px").css("margin-top", ($(".item").height() - 25) / 2 + "px");


                $(".lastItem").attr("disabled", true); $(".lastItem").text("");
                $("#lblTime").text(sendDate);
                //加载选中日期的值班信息
                if(gettext==31){
                    var date = new Date();
                    date.setMonth(getmonth - 1);
                    date.setDate(31);
                    var date31 =  Math.round(new Date() / 1000);
                    $.ajax({
                        type: "get",
                        url: "/schedule/getscheduleByDay?userId="+userId+"&time="+getDay(0),
                        dataType: "json",
                        success: function (data) {
                            var zhibanman = "";
                            $('#zbtbody').html("");
                            if(data.flag&&data.obj.length>0){
                                for(var i=0;i<data.obj.length;i++) {
                                    $('#zbtbody').append("<a class='add' href='/ewx/calendarDetails?calId="+data.obj[i].calId+"&dataType="+$.GetRequest().dataType+"' style='position:relative;' calId='"+data.obj[i].calId+"' calType='"+data.obj[i].calType+"' calLevel='"+data.obj[i].calLevel+"'><img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''><ul><li class='ove1'>" + data.obj[i].content + "</li><li class='ove2'>开始时间" + data.obj[i].stim + "</li><li class='ove3'>结束时间" + data.obj[i].etim + "</li></ul></a>");
                                };
                            }
                        },
                    });

                }else{
                    $.ajax({
                        type: "get",
                        url: "/schedule/getscheduleBycId?userId="+userId+"&time="+sendDate,
                        dataType: "json",
                        success: function (data) {
                            var zhibanman = "";
                            $('#zbtbody').html("");
                            $.each(data.obj, function (index, item) {
                                if(sendDate == item.calData){
                                    for(var i=0;i<item.calMessage.length;i++) {
                                        $('#zbtbody').append("<a class='add' href='/ewx/calendarDetails?calId="+item.calMessage[i].calId+"&dataType="+$.GetRequest().dataType+"' style='position:relative;' calId='"+item.calMessage[i].calId+"' calType='"+item.calMessage[i].calType+"' calLevel='"+item.calMessage[i].calLevel+"'><img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''><ul><li class='ove1'>" + item.calMessage[i].content + "</li><li class='ove2'>开始时间" + item.calMessage[i].stim + "</li><li class='ove3'>结束时间" + item.calMessage[i].etim + "</li></ul></a>");
                                    };
                                }
                            });
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(errorThrown);
                        }
                    });
                }
            }
        });
    }


    function sendSelectMonth() {
        var getyear = $(".selectYear").text();
        getyear = getyear.trimLast();
        var getmonth = $(".selectMonth").text();
        getmonth = getmonth.trimLast();
        if(getmonth<10){
            getmonth = '0'+getmonth;
        }
        var sendDate = getyear + "-" + getmonth + "-01";
        $("#lblTime").text(sendDate);
        $.ajax({
            type: "get",
            url: "/schedule/getscheduleBycId?userId="+userId+"&time="+sendDate,
            dataType: "json",
            success: function (data) {
                var zhibanman = "";
                $('#zbtbody').html("");
                $.each(data.obj, function (index, item) {
                    if(sendDate == item.calData){
                        for(var i=0;i<item.calMessage.length;i++) {
                            $('#zbtbody').append("<a class='add' href='/ewx/calendarDetails?calId="+item.calMessage[i].calId+"&dataType="+$.GetRequest().dataType+"' style='position:relative;' calId='"+item.calMessage[i].calId+"' calType='"+item.calMessage[i].calType+"' calLevel='"+item.calMessage[i].calLevel+"'><img style='width: 40px;height: 40px;position: absolute;top: 13px;left: -5px;' src='../../img/H5/1.10.png' alt=''><ul><li class='ove1'>" + item.calMessage[i].content + "</li><li class='ove2'>开始时间" + item.calMessage[i].stim + "</li><li class='ove3'>结束时间" + item.calMessage[i].etim + "</li></ul></a>");
                        };
                    }
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown);
            }
        });
    }


    var CalendarHandler = {
        currentYear: 0,
        currentMonth: 0,
        isRunning: false,
        showYearStart: 2009,
        tag: 0,
        initialize: function () {
            $calendarItem = this.CreateCalendar(0, 0, 0);
            $("#Container").append($calendarItem);


            $("#context").css("height", $("#CalendarMain").height() - 65 + "px");
            $("#center").css("height", $("#context").height() - 30 + "px");
            $("#selectYearDiv").css("height", $("#context").height() - 30 + "px").css("width", $("#context").width() + "px");
            $("#selectMonthDiv").css("height", $("#context").height() - 30 + "px").css("width", $("#context").width() + "px");
            $("#centerCalendarMain").css("height", $("#context").height() - 30 + "px").css("width", $("#context").width() + "px");


            $calendarItem.css("height", $("#context").height() - 30 + "px"); //.css("visibility","hidden");
            $("#Container").css("height", "0px").css("width", "0px").css("margin-left", $("#context").width() / 2 + "px").css("margin-top", ($("#context").height() - 30) / 2 + "px");
            $("#Container").animate({
                width: $("#context").width() + "px",
                height: ($("#context").height() - 30) * 2 + "px",
                marginLeft: "0px",
                marginTop: "0px"
            }, 300, function () {
                $calendarItem.css("visibility", "visible");
            });
            $(".dayItem").css("width", $("#context").width() + "px");
            var itemPaddintTop = $(".dayItem").height() / 6;
            $(".item").css({
                "width": $(".week").width() / 7 + "px",
                "line-height": itemPaddintTop + "px",
                "height": itemPaddintTop + "px"
            });
            $(".currentItem>a").css("margin-left", ($(".item").width() - 25) / 2 + "px").css("margin-top", ($(".item").height() - 25) / 2 + "px");
            $(".week>h3").css("width", $(".week").width() / 7 + "px");
            //初始获取年月日
            sendDate();
            this.RunningTime();
        },
        CreateSelectYear: function (showYearStart) {
            CalendarHandler.showYearStart = showYearStart;
            $(".currentDay").show();
            $("#selectYearDiv").children().remove();
            var yearindex = 0;
            for (var i = showYearStart; i < showYearStart + 12; i++) {
                yearindex++;
                if (i == showYearStart) {
                    $last = $("<div>往前</div>");
                    $("#selectYearDiv").append($last);
                    $last.on('click', function () {
                        CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart - 10);
                    });
                    continue;
                }
                if (i == showYearStart + 11) {
                    $next = $("<div>往后</div>");
                    $("#selectYearDiv").append($next);
                    $next.on('click', function () {
                        CalendarHandler.CreateSelectYear(CalendarHandler.showYearStart + 10);
                    });
                    continue;
                }


                if (i == this.currentYear) {
                    $yearItem = $("<div class=\"currentYearSd\" id=\"" + yearindex + "\">" + i + "</div>")


                }
                else {
                    $yearItem = $("<div id=\"" + yearindex + "\">" + i + "</div>");
                }
                $("#selectYearDiv").append($yearItem);
                $yearItem.on('click', function () {
                    $calendarItem = CalendarHandler.CreateCalendar(Number($(this).html()), 1, 1);
                    $("#Container").append($calendarItem);
                    CalendarHandler.CSS()
                    CalendarHandler.isRunning = true;
                    $($("#Container").find(".dayItem")[0]).animate({
                        height: "0px"
                    }, 300, function () {
                        $(this).remove();
                        CalendarHandler.isRunning = false;
                    });
                    $("#centerMain").animate({
                        marginLeft: -$("#center").width() + "px"
                    }, 500);
                    //初始获取年月日
                    sendDate();
                });
                if (yearindex == 1 || yearindex == 5 || yearindex == 9) $("#selectYearDiv").find("#" + yearindex).css("border-left-color", "#fff");
                if (yearindex == 4 || yearindex == 8 || yearindex == 12) $("#selectYearDiv").find("#" + yearindex).css("border-right-color", "#fff");


            }
            $("#selectYearDiv>div").css("width", ($("#center").width() - 4) / 4 + "px").css("line-height", ($("#center").height() - 4) / 3 + "px");
            $("#centerMain").animate({
                marginLeft: "0px"
            }, 300);
        },
        CreateSelectMonth: function () {
            $(".currentDay").show();
            $("#selectMonthDiv").children().remove();
            for (var i = 1; i < 13; i++) {
                if (i == this.currentMonth) $monthItem = $("<div class=\"currentMontSd\" id=\"" + i + "\">" + i + "月</div>");
                else $monthItem = $("<div id=\"" + i + "\">" + i + "月</div>");
                $("#selectMonthDiv").append($monthItem);
                $monthItem.on('click', function () {
                    $calendarItem = CalendarHandler.CreateCalendar(CalendarHandler.currentYear, Number($(this).attr("id")), 1);
                    $("#Container").append($calendarItem);
                    CalendarHandler.CSS()
                    CalendarHandler.isRunning = true;
                    $($("#Container").find(".dayItem")[0]).animate({
                        height: "0px"
                    }, 300, function () {
                        $(this).remove();
                        CalendarHandler.isRunning = false;
                    });
                    $("#centerMain").animate({
                        marginLeft: -$("#center").width() + "px"
                    }, 500);
                    //初始获取年月日
                    sendDate();
                });
                if (i == 1 || i == 5 || i == 9) $("#selectMonthDiv").find("#" + i).css("border-left-color", "#fff");
                if (i == 4 || i == 8 || i == 12) $("#selectMonthDiv").find("#" + i).css("border-right-color", "#fff");
            }
            $("#selectMonthDiv>div").css("width", ($("#center").width() - 4) / 4 + "px").css("line-height", ($("#center").height() - 4) / 3 + "px");
            $("#centerMain").animate({
                marginLeft: -$("#center").width() * 2 + "px"
            }, 300);
        },
        IsRuiYear: function (aDate) {
            return (0 == aDate % 4 && (aDate % 100 != 0 || aDate % 400 == 0));
        },
        CalculateWeek: function (y, m, d) {
            var arr = "7123456".split("");
            with (document.all) {
                var vYear = parseInt(y, 10);
                var vMonth = parseInt(m, 10);
                var vDay = parseInt(d, 10);
            }
            var week = arr[new Date(y, m - 1, vDay).getDay()];
            return week;
        },
        CalculateMonthDays: function (m, y) {
            var mDay = 0;
            if (m == 0 || m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
                mDay = 31;
            } else {
                if (m == 2) {
                    //判断是否为芮年
                    var isRn = this.IsRuiYear(y);
                    if (isRn == true) {
                        mDay = 29;
                    } else {
                        mDay = 28;
                    }
                } else {
                    mDay = 30;
                }
            }
            return mDay;
        },
        CreateCalendar: function (y, m, d) {
            $dayItem = $("<div class=\"dayItem\"></div>");
            //获取当前月份的天数
            var nowDate = new Date();
            if (y == nowDate.getFullYear() && m == nowDate.getMonth() + 1 || (y == 0 && m == 0))
                $(".currentDay").hide();
            var nowYear = y == 0 ? nowDate.getFullYear() : y;
            this.currentYear = nowYear;
            var nowMonth = m == 0 ? nowDate.getMonth() + 1 : m;
            this.currentMonth = nowMonth;
            var nowDay = d == 0 ? nowDate.getDate() : d;
            $(".selectYear").html(nowYear + "年");
            $(".selectMonth").html(nowMonth + "月");
            var nowDaysNub = this.CalculateMonthDays(nowMonth, nowYear);
            //获取当月第一天是星期几
            //var weekDate = new Date(nowYear+"-"+nowMonth+"-"+1);
            //alert(weekDate.getDay());
            var nowWeek = parseInt(this.CalculateWeek(nowYear, nowMonth, 1));
            //nowWeek=weekDate.getDay()==0?7:weekDate.getDay();
            //var nowWeek=weekDate.getDay();
            //获取上个月的天数
            var lastMonthDaysNub = this.CalculateMonthDays((nowMonth - 1), nowYear);


            if (nowWeek != 0) {
                //生成上月剩下的日期
                for (var i = (lastMonthDaysNub - (nowWeek - 1)) ; i < lastMonthDaysNub; i++) {
                    //$dayItem.append("<div class=\"item lastItem\"><a>" + (i + 1) + "</a></div>");
                    $dayItem.append("<div class=\"item lastItem\"><a></a></div>");
                }
            }


            //生成当月的日期
            for (var i = 0; i < nowDaysNub; i++) {
                if (i == (nowDay - 1)) $dayItem.append("<div class=\"item currentItem\"><a>" + (i + 1) + "</a></div>");
                else $dayItem.append("<div class=\"item\"><a>" + (i + 1) + "</a></div>");
            }


            //获取总共已经生成的天数
            var hasCreateDaysNub = nowWeek + nowDaysNub;
            //如果小于42，往下个月推算
            if (hasCreateDaysNub < 42) {
                for (var i = 0; i <= (42 - hasCreateDaysNub) ; i++) {
                    //$dayItem.append("<div class=\"item lastItem\"><a>" + (i + 1) + "</a></div>");
                    $dayItem.append("<div class=\"item lastItem\"><a></a></div>");
                }
            }

            return $dayItem;
        },
        CSS: function () {
            var itemPaddintTop = $(".dayItem").height() / 6;
            $(".item").css({
                "width": $(".week").width() / 7 + "px",
                "line-height": itemPaddintTop + "px",
                "height": itemPaddintTop + "px"
            });
            $(".currentItem>a").css("margin-left", ($(".item").width() - 25) / 2 + "px").css("margin-top", ($(".item").height() - 25) / 2 + "px");
        },
        CalculateNextMonthDays: function () {
            if (this.isRunning == false) {
                $(".currentDay").show();
                var m = this.currentMonth == 12 ? 1 : this.currentMonth + 1;
                var y = this.currentMonth == 12 ? (this.currentYear + 1) : this.currentYear;
                var d = 0;
                var nowDate = new Date();
                if (y == nowDate.getFullYear() && m == nowDate.getMonth() + 1) d = nowDate.getDate();
                else d = 1;
                $calendarItem = this.CreateCalendar(y, m, d);
                $("#Container").append($calendarItem);


                this.CSS();
                this.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
                //初始获取年月日
                sendDate();
                sendSelectMonth();//发送选择的下一月的日
            }
        },
        CalculateLastMonthDays: function () {
            if (this.isRunning == false) {
                $(".currentDay").show();
                var nowDate = new Date();
                var m = this.currentMonth == 1 ? 12 : this.currentMonth - 1;
                var y = this.currentMonth == 1 ? (this.currentYear - 1) : this.currentYear;
                var d = 0;


                if (y == nowDate.getFullYear() && m == nowDate.getMonth() + 1) d = nowDate.getDate();
                else d = 1;
                $calendarItem = this.CreateCalendar(y, m, d);
                $("#Container").append($calendarItem);
                var itemPaddintTop = $(".dayItem").height() / 6;
                this.CSS();
                this.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
                //初始获取年月日
                sendDate();
                sendSelectMonth();//发送选择的下一月的日
            }
        },
        CreateCurrentCalendar: function () {
            if (this.isRunning == false) {
                $(".currentDay").hide();
                $calendarItem = this.CreateCalendar(0, 0, 0);
                $("#Container").append($calendarItem);
                this.isRunning = true;
                $($("#Container").find(".dayItem")[0]).animate({
                    height: "0px"
                }, 300, function () {
                    $(this).remove();
                    CalendarHandler.isRunning = false;
                });
                this.CSS();
                $("#centerMain").animate({
                    marginLeft: -$("#center").width() + "px"
                }, 500);
                sendDate();
                getNowDay();
            }
        },
        RunningTime: function () {
            var mTiming = setInterval(function () {
                var nowDate = new Date();
                var h = nowDate.getHours() < 10 ? "0" + nowDate.getHours() : nowDate.getHours();
                var m = nowDate.getMinutes() < 10 ? "0" + nowDate.getMinutes() : nowDate.getMinutes();
                var s = nowDate.getSeconds() < 10 ? "0" + nowDate.getSeconds() : nowDate.getSeconds();
                var nowTime = h + ":" + m + ":" + s;
                $("#footNow").html(nowTime);
            }, 1000);


        }
    }
</script>

