<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/main/intranetBlue.css">
    <link rel="stylesheet" type="text/css" href="../css/diary/calendar1.css"/>
    <script src="../../js/common/language.js"></script>
    <script type="text/javascript" src="js/jquery/jquery-1.9.1.js"></script>
    <script src="js/base/base.js"></script>
    <script type="text/javascript" src="../js/diary/calendar1.js/"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>

    <title><fmt:message code="main.th.Intranet"/></title>

    <style>
        .textmains .buttom span{
            height: 22px;
        }
        .daibanbuttom .left p,
        .daibanbuttom .right .top,
        .daibanbuttom .right .buttom{
            font-size: 11pt;
        }

        .calendar-display{
            font-size: 21pt;
        }
        .navigations span,
        .textmains .top,
        .textmains .buttom
        {
            font-size: 9pt;
        }
        .richengHover,.daibanHover,.personInfo,.rizhiHover{
            box-sizing: border-box;
        }
        .emailHover{
            border-left: #ddd 1px solid;
        }
        .richengHover:hover,.daibanHover:hover,.personInfo:hover,.rizhiHover:hover,.emailHover:hover{
            /*border:#fea8a8 1px solid;*/
            box-shadow: 0 0 10px #47a4fb;
            z-index: 99;
        }
        .daibantop .right div>img{
            height:50px;
        }
        .buttommai-main li>span img{
            height: 38px;
        }

    </style>

</head>
<body >
    <div class="topmain clearfix">
        <div class="topmainleft">
            <div class="daiban">
                <ul class="daibantop clearfix">
                    <li class="fl left richengHover" style="cursor:pointer;" onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="/schedule/index">
                        <h4 style="margin: 0 auto;font-size: 16pt;;color: #fff;margin-top: 20px;"></h4>
                        <h3 style="margin: 0 auto;font-size: 12pt;;color: #fff;margin-top: 10px;"></h3>
                        <span style="color: #fff;margin-top: 5px;"></span>
                        <h2 class="hide">日程安排</h2>
                    </li>
                    <li class="fl right">
                        <div class="clearfix">
                            <div class="personInfo" style="float: left;width: 70%;height: 100%;box-sizing: border-box;cursor: pointer;" onclick="parent.getMenuOpen(this)" menu_tid="0140" data-url="/controlpanel/index">
                                <img class="fl"  id="nameurl" src="/img/user/boy.png" alt="">
                                <span class="fl" style="width: 60%;margin-left:3% ;">
                                <strong></strong>
                                <label style="cursor: pointer;" class="zhiwei"></label>
                                 <h2 class="hide">控制面板</h2>
                            </span>
                            </div>

                            <div class="fr emailHover" onclick="parent.getMenuOpen(this)" menu_tid="0101"  data-url="email"
                                 style="cursor:pointer;width: 30%;text-align: center;box-sizing: border-box;height: 100%;">
                                <img style="width: 45px;margin-top: 32px;" src="img/main_img/emaildianji.png" alt="">
                                <label style="margin: 0;color: #2a79d5;display: inline-block;width: 100%;
font-size: 11pt;"><fmt:message code="email.title.waitmail"/></label>
                                <h2 class="hide"><fmt:message code="notice.th.mail"/></h2>
                            </div>
                        </div>
                    </li>
                </ul>
                <ul class="daibanbuttom clearfix">
                    <li class="fl left daibanHover" style="cursor:pointer;" onclick="parent.getMenuOpen(this)" menu_tid="1020" data-url="/workflow/work/workList">
                        <p style="margin-top: 11px;"><fmt:message code="attend.th.needDealt"/> : <span>0</span></p>
                        <p style="margin-top: 5px;"><fmt:message code="attend.th.Have"/> : <span>0</span></p>
                        <h2 class="hide">我的工作</h2>
                    </li>
                    <li class="fl right rizhiHover" style="cursor:pointer;" onclick="parent.getMenuOpen(this)" menu_tid="0128" data-url="/diary/index">
                        <p class="top"><fmt:message code="diary.th.personLog"/>:</p>
                        <p class="buttom"></p>
                        <h2 class="hide">工作日志</h2>
                    </li>
                </ul>
            </div>

            <div class="changyong">
                <p class="pbg">
                    <span class="titleleft"><fmt:message code="main.th.yiyong"/></span>
                </p>
                <ul class="changyongmain clearfix">
                    <%--<li class="fl" onclick="parent.getMenuOpen(this)" menu_tid="0116" data-url="notify/show">--%>
                        <%--<img src="img/main_img/app/0116.png" alt="">--%>
                        <%--<h4><fmt:message code="notice.th.notice"/></h4>--%>
                        <%--<h2 class="hide"><fmt:message code="notice.th.notice"/></h2>--%>
                    <%--</li>--%>
                    <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="0101" data-url="email">--%>
                        <%--<img src="img/main_img/app/0101.png" alt="">--%>
                        <%--<h4><fmt:message code="notice.th.mail"/></h4>--%>
                        <%--<h2 class="hide"><fmt:message code="notice.th.mail"/></h2>--%>
                    <%--</li>--%>
                    <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="0124" data-url="calendar">--%>
                        <%--<img src="img/main_img/app/0124.png" alt="">--%>
                        <%--<h4><fmt:message code="email.th.agenda"/></h4>--%>
                        <%--<h2 class="hide"><fmt:message code="email.th.agenda"/></h2>--%>
                    <%--</li>--%>
                    <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="0117" data-url="news/show">--%>
                        <%--<img src="img/main_img/app/0117.png" alt="">--%>
                        <%--<h4><fmt:message code="email.th.news"/></h4>--%>
                        <%--<h2 class="hide"><fmt:message code="email.th.news"/></h2>--%>
                    <%--</li>--%>
                    <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="3001" data-url="file_folder/index2.php">--%>
                        <%--<img src="img/main_img/app/0136.png" alt="">--%>
                        <%--<h4><fmt:message code="file.th.file"/></h4>--%>
                        <%--<h2 class="hide"><fmt:message code="file.th.file"/></h2>--%>
                    <%--</li>--%>
                    <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="0128" data-url="diary/show">--%>
                        <%--<img src="img/main_img/app/0128.png" alt="">--%>
                        <%--<h4><fmt:message code="main.worklog"/></h4>--%>
                        <%--<h2 class="hide"><fmt:message code="main.worklog"/></h2>--%>
                    <%--</li>--%>
                </ul>
            </div>
        </div>



        <div class="topmaincenter">
            <div class="pbg" style="margin-bottom: 13px;">
                <span class="titleleft" style="padding-left: 35px;"><fmt:message code="email.th.news"/></span>
                <div class="fr" onclick="parent.getMenuOpen(this)" menu_tid="0117" data-url="news/show">
                        <a class="fr" href="javascript:void(0)"
                           style="color: #3c92e5;font-size: 11pt;margin-right: 14px;">
                            <fmt:message code="email.th.more"/>&gt;&gt;
                        </a>
                        <h2 class="hide"><fmt:message code="main.news"/></h2>
                 </div>

            </div>
            <%--<img src="/img/main_img/bglans.png" alt="">--%>
            <img src="" alt="">

        </div>




        <div class="topmainright">
            <div class="pbg">
                <span class="titleleft" ><fmt:message code="calendar.th.myCalendar"/></span>
                <div class="fr"  onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">
                    <a class="fr" href="javascript:void(0)"
                       style="color: #3c92e5;font-size: 11pt;margin-right: 14px;">
                        <fmt:message code="calendar.th.addCalendar"/>
                    </a>
                    <h2 class="hide"><fmt:message code="calendar.th.manageCalendar"/></h2>
                </div>

            </div>
            <div id="ca">

            </div>
            <ul class="topmainright-main" style="overflow: auto">

            </ul>
        </div>
    </div>


    <div class="buttommain">
        <div class="buttommainleft">
            <div class="pbg">
                <span class="titleleft" ><fmt:message code="main.email"/></span>
                <div class="navigations fr">
                    <span class="active" data-type="all"><fmt:message code="notice.th.all"/></span>
                    <span data-type="yidu"><fmt:message code="email.th.read"/></span>
                    <span data-type="weidu"><fmt:message code="email.th.unread"/></span>
                </div>
            </div>
            <ul class="buttommai-main" data-t="all">

            </ul>
            <ul class="buttommai-main" data-t="yidu" style="display: none">

            </ul>
            <ul class="buttommai-main" data-t="weidu" style="display: none">


            </ul>
        </div>



        <div class="buttommaincontent">
            <div class="pbg">
                <span class="titleleft" ><fmt:message code="notice.th.notice"/></span>
            </div>
            <ul class="buttommai-main" id="buttommaincontent">

            </ul>
        </div>



        <div class="buttommainleft">
            <div class="pbg">
                <span class="titleleft" ><fmt:message code="main.workflow"/></span>
            </div>
            <ul class="buttommai-main" id="liucheng">

            </ul>
        </div>
    </div>
    <script src="/js/main_js/intranetBlue.js"></script>
<script>
    var $width=$('#ca').width();
    $('#ca').hide();
    $('#ca').calendar({
        width: $width,
        height: 260,
        data: [
//            {
//                date: '2015/12/24',
//                value: 'Christmas Eve'
//            },
//            {
//                date: '2015/12/25',
//                value: 'Me rry Christmas'
//            },
//            {
//                date: '2016/01/01',
//                value: 'Happy New Year'
//            }
        ],
        onSelected: function (view, date) {
//            console.log(date.Format('yyyy-MM-dd'))
            richeng(new Date(date.Format('yyyy-MM-dd')).getTime()/1000)
        }
    });

    $(function () {
        getPicApplication();

//        查询左上角模块权限
        $.ajax({
            type:'get',
            url:'/portals/selPortalsUser',
            dataType:'json',
            success:function (res) {
                var data=res.obj1;
                if(data.currentUserSchedulePer){
                    $('.richengHover').attr('onclick','parent.getMenuOpen(this)');
                }else{
                    $('.richengHover').attr('onclick','');
                }
                if(data.currentUserEmailPer){
                    $('.emailHover').attr('onclick','parent.getMenuOpen(this)');
                }else{
                    $('.emailHover').attr('onclick','');
                }
                if(data.currentUserMyWorkPer){
                    $('.daibanHover').attr('onclick','parent.getMenuOpen(this)');
                }else{
                    $('.daibanHover').attr('onclick','');
                }
                if(data.currentUserControlCenterPer){
                    $('.personInfo').attr('onclick','parent.getMenuOpen(this)');
                }else{
                    $('.personInfo').attr('onclick','');
                }
                if(data.currentUserWorkLogPer){
                    $('.rizhiHover').attr('onclick','parent.getMenuOpen(this)');
                }else{
                    $('.rizhiHover').attr('onclick','');
                }
            }
        })
        
    })
    function getPicApplication() {
        $.ajax({
            type:'get',
            url:'/getMenu',
            dataType:'json',
            success:function (res) {
                var data=res.obj;
                if(res.obj.length > 0){
                    var str='';
                    if(res.obj.length > 6){
                        for(var i=0;i<6;i++){
                            str+='<li class="fl" onclick="parent.getMenuOpen(this)" menu_tid="'+data[i].id+'" data-url="'+data[i].url+'">'+
                                '<img src="img/main_img/app/' + data[i].id + '.png" alt="">'+
                                '<h4>'+data[i].name+'</h4>'+
                                '<h2 class="hide">'+data[i].name+'</h2>'+
                                '</li>'
                        }
                    }else {
                        for(var i=0;i<data.length;i++){
                            str+='<li class="fl" onclick="parent.getMenuOpen(this)" menu_tid="'+data[i].id+'" data-url="'+data[i].url+'">'+
                                '<img src="img/main_img/app/' + data[i].id + '.png" alt="">'+
                                '<h4>'+data[i].name+'</h4>'+
                                '<h2 class="hide">'+data[i].name+'</h2>'+
                                '</li>'
                        }
                    }

                    $('.changyongmain').html(str);
                }
            }
        })
    }
</script>
</body>
</html>
