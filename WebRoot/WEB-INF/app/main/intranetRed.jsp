<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" type="text/css" href="../css/diary/calendar1.css"/>
    <link rel="stylesheet" href="/css/main/intranetRed.css?20201106.1">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="js/jquery/jquery-1.9.1.js"></script>
    <script src="js/base/base.js"></script>
    <script type="text/javascript" src="../js/diary/calendar1.js/"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/main_js/intranetRed.js"></script>
    <title><fmt:message code="main.th.Intranet"/></title><%--内网门户--%>
    <style>
        .buttommai-main li.clearfix:hover{
            background: #e9f3ff;
        }
        .buttommai-main li{
            height: 46px;
        }
        .lef{
            height: 46px;
        }
        .lef img{
            margin-top: 3px;
        }
        .lef a{
            height: 23px;
            line-height: 23px!important;

        }
        .flowBtn , .reveiveBtn , .sendBtn{
            height: 20px;
            border-radius: 4px;
            line-height: 20px;
            margin: 4px;
            padding: 0;
            background: #ffffff;
            cursor: pointer;
            font-size: 8pt;
            color: #dd2e2c;
            border: #dd2e2c 1px solid;
            display: inline-block;
            width: 34px;
            text-align: center;
        }
        .btnSelect{
            background: #dd2e2c !important;
            color: #fff !important;
        }
    </style>
</head>
<body>
<div class="topmain clearfix">
    <div class="topmainleft">
        <div class="daiban">
            <div class="pbg">
                <span class="titleleft" ><fmt:message code="main.news"/></span><%--新闻政策--%>
            </div>
            <div class="more">
                <span><a class="mores" style="cursor: pointer" onclick="parent.getMenuOpen(this)" menu_tid="0117" data-url="news/show"><fmt:message code="email.th.more"/>>><h2 class="hide"><fmt:message code="email.th.news"/></h2></a></span><%--更多--%>

            </div>
            <div class="lt"><img width="100%" height="100%" src="" alt="">
            <ul class="sorc" id="sorcs" style="margin-top: -7px;"></ul>
            </div>
            <div class="rt">
                <ul class="sorc" id="sorc" style="margin-top: -7px;">

                </ul>
            </div>
        </div>

        <div class="changyong">
            <p class="pbg">
                <span class="titleleft"><fmt:message code="app.th.application"/></span><%--常用应用--%>
            </p>
            <ul class="changyongmain clearfix">
                <%--<li class="fl" onclick="parent.getMenuOpen(this)" menu_tid="0116" data-url="notify/show">--%>
                    <%--<img src="img/main_img/app/0116.png" alt="">--%>
                    <%--<h4><fmt:message code="notice.th.notice"/></h4>&lt;%&ndash;公告&ndash;%&gt;--%>
                    <%--<h2 class="hide"><fmt:message code="notice.th.notice"/></h2>&lt;%&ndash;公告&ndash;%&gt;--%>
                <%--</li>--%>
                <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="0101" data-url="email">--%>
                    <%--<img src="img/main_img/app/0101.png" alt="">--%>
                    <%--<h4><fmt:message code="notice.th.mail"/></h4>&lt;%&ndash;邮件&ndash;%&gt;--%>
                    <%--<h2 class="hide"><fmt:message code="notice.th.mail"/></h2>&lt;%&ndash;邮件&ndash;%&gt;--%>
                <%--</li>--%>
                <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="0124" data-url="calendar">--%>
                    <%--<img src="img/main_img/app/0124.png" alt="">--%>
                    <%--<h4><fmt:message code="email.th.agenda"/></h4>&lt;%&ndash;日程&ndash;%&gt;--%>
                    <%--<h2 class="hide"><fmt:message code="email.th.agenda"/></h2>&lt;%&ndash;日程&ndash;%&gt;--%>
                <%--</li>--%>
                <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="0117" data-url="news/show">--%>
                    <%--<img src="img/main_img/app/0117.png" alt="">--%>
                    <%--<h4><fmt:message code="email.th.news"/></h4>&lt;%&ndash;新闻&ndash;%&gt;--%>
                    <%--<h2 class="hide"><fmt:message code="email.th.news"/></h2>&lt;%&ndash;新闻&ndash;%&gt;--%>
                <%--</li>--%>
                <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="3001" data-url="file_folder/index2.php">--%>
                    <%--<img src="img/main_img/app/0136.png" alt="">--%>
                    <%--<h4><fmt:message code="file.th.file"/></h4>&lt;%&ndash;文件柜&ndash;%&gt;--%>
                    <%--<h2 class="hide"><fmt:message code="file.th.file"/></h2>&lt;%&ndash;文件柜&ndash;%&gt;--%>
                <%--</li>--%>
                <%--<li class="fl" onclick="parent.getMenuOpen(this)"  menu_tid="0128" data-url="diary/show">--%>
                    <%--<img src="img/main_img/app/0128.png" alt="">--%>
                    <%--<h4><fmt:message code="main.worklog"/></h4>&lt;%&ndash;日志&ndash;%&gt;--%>
                    <%--<h2 class="hide"><fmt:message code="main.worklog"/></h2>&lt;%&ndash;日志&ndash;%&gt;--%>
                <%--</li>--%>
            </ul>
        </div>
    </div>

    <div class="topmainright">
        <div class="r-top">
            <h3></h3>
            <h4></h4>
        </div>
        <div class="r-bot">
        <div class="pbg">
            <span class="titleleft" ><fmt:message code="calendar.th.myCalendar"/></span><%--我的日程--%>
            <div class="fr"  onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">
                <a class="fr" href="javascript:void(0)"
                   style="color: #bc0f14;font-size: 14px;margin-right: 14px;">
                    <fmt:message code="calendar.th.addCalendar"/><%--新增日程--%>
                </a>
                <h2 class="hide"><fmt:message code="calendar.th.manageCalendar"/></h2><%--日程管理--%>
            </div>

        </div>
        <div id="ca">

        </div>
        <ul class="topmainright-main" style="overflow: auto">

        </ul>
        </div>
    </div>
</div>


<div class="buttommain">
    <div class="buttommainleft">
        <div class="pbg">
            <span class="titleleft" >收文</span><%--待办收文--%>
        </div>
        <span class="dai reveiveBtn btnSelect" datatype="0" style="position: absolute;top: 12px;right: 130px;">待办</span>
        <span class="yiban reveiveBtn" datatype="1" style="position: absolute;top: 12px;right: 82px;">已办</span>
        <div class="more" onclick="parent.getMenuOpen(this)" style="display: inline-block"  menu_tid="650505" data-url="document/recv/backlog">
            <h2 style="display: none">待办收文</h2>
            <span><a class="mores" style="cursor: pointer" ><fmt:message code="email.th.more"/>>></a></span><%--更多--%>
        </div>
        <ul class="buttommai-main" id="witgw">

        </ul>
    </div>



    <div class="buttommaincontent">
        <div class="pbg">
            <span class="titleleft" >发文</span><%--待办发文--%>
        </div>
        <span class="dai sendBtn btnSelect" datatype="0" style="position: absolute;top: 12px;right: 130px;">待办</span>
        <span class="yiban sendBtn" datatype="1" style="position: absolute;top: 12px;right: 82px;">已办</span>
        <div class="more" onclick="parent.getMenuOpen(this)"  menu_tid="650105" data-url="document/send/backlog">
            <span><a class="mores" style="cursor: pointer" ><fmt:message code="email.th.more"/>>><h2 class="hide">待办发文</h2></a></span><%--更多--%>
            <h2 style="display: none">待办发文</h2>
        </div>
        <ul class="buttommai-main" id="dbsend">

        </ul>
    </div>



    <div class="buttommainleft">
        <div class="pbg">
            <span class="titleleft" >工作流</span><%--待批会议--%>
        </div>
        <div class="more">
            <span class="dai flowBtn btnSelect" datatype="0">待办</span>
            <span class="yiban flowBtn" datatype="1">已办</span>
            <div  style="display: inline-block;" onclick="parent.getMenuOpen(this)"  menu_tid="1020" data-url="workflow/list"><a class="mores" href="javascript:;"  target="_blank"><fmt:message code="email.th.more"/>>></a> <h2 style="display: none">我的工作</h2></div><%--更多--%>
        </div>
        <ul class="buttommai-main" id="huiyi">

        </ul>
    </div>
</div>

<script>
    var $width=$('#ca').width();
    $('#ca').calendar({
        width: $width,
        height: 180,
        data: [
            {
                date: '2015/12/24',
                value: 'Christmas Eve'
            },
            {
                date: '2015/12/25',
                value: 'Me rry Christmas'
            },
            {
                date: '2016/01/01',
                value: 'Happy New Year'
            }
        ],
        onSelected: function (view, date) {
//            console.log(date.Format('yyyy-MM-dd'))
            richeng(new Date(date.Format('yyyy-MM-dd')).getTime()/1000)
        }
    });

    $(function () {
        getPicApplication();
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
