<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title></title>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <link href="../../css/H5/default.css" rel="stylesheet"/>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
    <style>
        html,body{
            width: 100%;
            height: 100%;
        }
        .nav{
            font-size: 14px;
            color: #666;
            margin: 0 10px;
            line-height: 40px;
            padding-left: 9rem;
            position: relative;
        }
        .chunk{
            width: 4px;
            height: 13px;
            background:#7caeff;
            display: inline-block;
            position: relative;
            top: 2px;
            right: 9px;
        }
        .usernav {
            font-size: 12rem;
            display: flex;
            /*align-items: center;*/
            background-color: #fff;
            text-align: center;
            flex-wrap: wrap;
        }
        .usernav img{
            width: 45px;
            height: 45px;
            margin:0 auto;
        }
        .usernav div{
            padding-top: 8px;
            color: #666;
        }
        input{
            width: 88%;
            border:1px solid #ccc;
            padding-left: 3px;
            height: 25px;
            margin: 5px 0;
            border-radius: 3px;

        }
        .usernav a{
            width: 25%;
            position: relative;
            margin: 10px 0;
        }

        .nav:after {
            position: absolute;
            top: 40px;
            right: 0;
            left: 0;
            height: 1px;
            content: '';
            -webkit-transform: scaleY(.5);
            transform: scaleY(.5);
            background-color: #c8c7cc;
        }

        .swplb{
            width: 100%;
            box-sizing: border-box;
            /*background: aliceblue;*/
            padding: 15px;
            box-shadow: 1px 1px 4px antiquewhite;
            background: url(/img/main_img/theme6/bg.png) -6px 0px no-repeat;
        }
        .swplb font{
            font-size: 22pt!important;
        }

        .swplb img{
            /*width: 100%;*/
            height: 100%;
        }

        #container{
            box-sizing: border-box;
            padding: 0 15px;
            height:35px;
            line-height: 35px;
            overflow: hidden;
            white-space: nowrap;
            width:98%;
            background: #e8f4fc;
            color: #999999;
            margin: 10px auto;
            text-align: center;
            font-size: 14px;
        }
        #scroll_div {

            position: relative;
            top: 0;
        }
        #scroll_begin,#scroll_end {
            display: block;
            margin-top:0px;
        }
        .square{
            /*padding-bottom: 100%; !* padding百分比是相对父元素宽度计算的 *!*/
            /*margin-bottom: 30px;*/
            position: relative;
            width: 95%;
            margin-left: 3%;
            margin-top: 3%;
        }
        .square-inner{
            /*position: absolute;*/
            /*top: 0;*/
            /*left: 0;*/
            width: 100%;
            /*height: 100%; !* 铺满父元素容器，这时候宽高就始终相等了 *!*/
            height: auto;
        }
        .square-inner>li{
            width: calc(99% / 3);  /* calc里面的运算符两边要空格 */
            overflow: hidden;
            border: 1px solid #F2F2F2;
            margin-left:-1px;
            margin-top:-1px;
        }
        .flex{
            display: inline-flex;
            flex-wrap: wrap;
        }
        .flex>li{
            flex-grow: 1; /* 子元素按1/n的比例进行拉伸 */
            /*background-color: #fff;*/
            text-align: center;
            color: #000;
            font-size: 50px;
            line-height: 2;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .flex>li:nth-of-type(3n){ /* 选择个数是3的倍数的元素 */
            margin-right: 0;
        }
        .flex>li:nth-of-type(n+7){  /* 选择倒数的三个元素，n可以取0 */
            margin-bottom: 0;
        }
        .border{
            border: 1px solid #F2F2F2;
        }
        .tborder{
            border-top: 1px solid #F2F2F2;
        }
        .bborder{
            border-bottom: 1px solid #F2F2F2;
        }
        .lborder{
            border-left: 1px solid #F2F2F2;
        }
        .rborder{
            border-right: 1px solid #F2F2F2;
        }
        .square img{
            width: 60px;
            height: 60px;
            margin:0 auto;
        }

        .square div{
            color: #666;
            font-size: 12px;
            margin-top: -6px;
        }
        .square .titlehead{
            padding-top: 8px;
        }
        .square .titlehead{
            background-color: white;
        }
        .flex li:hover{
            background: #e8f4fc;
        }

        .bot{
            position: fixed;
            bottom: 0;
            height: 75px;
            width: 100%;
            background: #fff;
            display: flex;
            box-shadow: 0px 1px 4px grey;
        }
        .bot div{
            width: calc(100% / 3);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .bot span{
            font-size: 10px;
        }
        .bot img{
            width: 22px;
            height:22px;
            margin:5px auto;
        }
        .pad_right{
            /*flaot:left;*/
            text-align: left;
        }
        .square li {
            display:none;
        }
        /*edu教育模块*/
        .menuTitle{
            padding: 0.2rem;
            background-color: #46a9da;
        }
        .edu-img{
            width: 30px;
            height: 30px;
            margin: 0 auto;
        }
        .menuContent{
            display: flex;
            flex-wrap: wrap;
        }
        .edu-block{
            width: calc(100% / 3);
            overflow: hidden;
            border-bottom: 1px solid #F2F2F2;
            border-right: 1px solid #F2F2F2;
            background-color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 81px;

        }
        .edu-name{
            padding-top: 8px;
            color: #666;
            font-size: 12px;
        }
        .square img {
            position: relative;
            top: 4px;
        }
        .square li {
            width: 30%;
            background-color: white;
            max-width: calc( 100%/3);
            /*margin-left: 5%;*/
        }
        .square li a{
            margin: 10px;
        }
        @media all and (min-width:1000px) {
            .titlehead{
                font-size: 15px;
                height: 45px;
                line-height: 30px;
                /* margin-left: 10px; */
                padding-left: 10px;
                width: 99.7%;
            }
        }
        @media all and (min-width:500px) and (max-width:1000px) {
            .titlehead{
                font-size: 15px;
                height: 45px;
                line-height: 30px;
                /* margin-left: 10px; */
                padding-left: 10px;
                width: 99.5%;
            }
        }
        @media all and (max-width:500px) {
            .titlehead{
                font-size: 15px;
                height: 45px;
                line-height: 30px;
                /* margin-left: 10px; */
                padding-left: 10px;
                width: 99%;
            }
        }
        [v-cloak]{
            display: none;
        }
    </style>
    <script type="text/javascript">
        var fs = document.documentElement.clientWidth / 750  * 100;
        document.querySelector("html").style.fontSize = fs + "px";
    </script>
</head>
<body style="background: #f7f7f7;overflow-y: visible;">
<div class="mui-content" id="app" style="padding-bottom: 1rem;width: 100%">
    <%--顶部轮播图--%>
    <div class="swplb" style="width: 100%;display: none">
        <%--<input type="text" value="${LogoImg}">--%>
        <c:choose>

            <c:when test="${bannerText!=''&&bannerText!=undefined}">
                <font style="${bannerFont}">${bannerText}</font>
            </c:when>
            <c:otherwise>
                <img src="${LogoImg}" style=" margin-top: 11px;margin-left: 1%;height: 61px"/>
            </c:otherwise>
        </c:choose>
        <%--<img src="/img/ewx/LOGO.png" alt="">--%>
    </div>

    <%--滚动公告--%>
    <div id="container" onclick="jumpUrl('/ewx/repository?dataType='+check($.GetRequest().dataType)+'')" style="display: none">
        <div id="scroll_div" class="fl">
            <div id="scroll_begin">
                <%--<span style="letter-spacing: 1px;display: block" class="pad_right">提醒：您有新的工作事项需要办理，请您及时查看办理1。</span>--%>
                <%--<span style="letter-spacing: 1px;display: block" class="pad_right">提醒：您有新的工作事项需要办理，请您及时查看办理2。</span>--%>
                <%--<span style="letter-spacing: 1px;display: block" class="pad_right">提醒：您有新的工作事项需要办理，请您及时查看办理3。</span>--%>
            </div>
            <div id="scroll_end"></div>
        </div>
    </div>


    <%--智慧城建--%>
    <div class="yingyong">
        <%--        <div class="square">--%>
        <%--            <div class="titlehead">--%>
        <%--                <label style="font-size: 15px;color: #a9a6a6" id="menuGroup_01">内部管理</label>--%>
        <%--            </div>--%>

        <%--            <ul class="square-inner flex" id="menus_ul" style="">--%>
        <%--&lt;%&ndash;                <li id="menu_1" onclick="jumpsrc('/ewx/emailList?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="/img/H5/ewxh5/1.1.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>电子邮件</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li  id="menu_4" class="" onclick="jumpsrc('/ewx/noticeList?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/1.2.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>公告通知</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li  id="menu_8" class="" onclick="jumpsrc('/ewx/calendar?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/1.4.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>日程安排</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li id="menu_5" onclick="jumpsrc('/workflow/work/workflowIndexh5?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/2.1.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>工作流</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li id="menu_16" class="" onclick="jumpsrc('/ewx/fileIndex?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a href="">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/1.10.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>个人文件柜</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>

        <%--&lt;%&ndash;                <li id="menu_9" class="" onclick="jumpsrc('/ewx/diaryIndex?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/1.7.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>工作日志</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li id="menu_147" class="" onclick="jumpsrc('/ewx/newsList?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/news.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>新闻</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li id="menu_91" class="" onclick="jumpsrc('/ewx/carList?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/che.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>车辆</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li id="menu_86" class="" onclick="jumpsrc('/ewx/meetingList?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/meeting.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>会议</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>

        <%--&lt;%&ndash;                <li id="menu_93" class="" onclick="jumpsrc('/ewx/carApprovalList?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="/img/commonTheme/theme6/vihicleApply.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>车辆审批</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li id="menu_2287" class="attend_s_menu" style="display: none" onclick="jumpsrc('/ewx/leadCalendar?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/H5/ewxh5/1.4.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>领导日程安排</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li id="menu_7233" class="" onclick="jumpsrc('/ewx/meetingApprovalList?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="/img/commonTheme/theme6/icon_meetingManagr.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>会议审批</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li class="attend_s_menu"  onclick="jumpsrc('/ewx/FrontOfficial?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    <a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <img src="../../img/menu/Documentssupervisor.png"/>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                        <div>公文管理</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                    </a>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li class="attend_s_menu" style="display: none" onclick="jumpsrc('/ewx/attendStatistics?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>
        <%--&lt;%&ndash;                <li class="attend_s_menu" style="display: none" onclick="jumpsrc('/ewx/attendStatistics?dataType='+check($.GetRequest().dataType)+'')">&ndash;%&gt;--%>
        <%--&lt;%&ndash;                </li>&ndash;%&gt;--%>

        <%--            </ul>--%>
        <%--        </div>--%>
        <%--        <div class="square">--%>
        <%--            <div class="titlehead">--%>
        <%--                <label style="font-size: 15px;color: #a9a6a6" id="menuGroup_02">人事管理</label>--%>
        <%--            </div>--%>

        <%--            <ul class="square-inner flex" id="menus_RS" >--%>

        <%--                <li class="" style="display: inherit" onclick="jumpsrc('/ewx/attend?dataType='+check($.GetRequest().dataType)+'')">--%>
        <%--                    <a>--%>
        <%--                        <img src="../../img/menu/ewxh5/PersonalAttendance.png"/>--%>
        <%--                        <div>打卡</div>--%>
        <%--                    </a>--%>
        <%--                </li>--%>
        <%--                <li class="attend_s_menu" style="display: none" onclick="jumpsrc('/ewx/attendStatistics?dataType='+check($.GetRequest().dataType)+'')">--%>
        <%--                    <a>--%>
        <%--                        <img src="../../img/H5/ewxh5/Attendancemanagement.png"/>--%>
        <%--                        <div>打卡统计</div>--%>
        <%--                    </a>--%>
        <%--                </li>--%>
        <%--                <li id="menu_521" class="" onclick="jumpsrc('/train/courses?dataType='+check($.GetRequest().dataType)+'')">--%>
        <%--                    <a>--%>
        <%--                        <img src="/img/commonTheme/theme6/icon_meetingManagr.png"/>--%>
        <%--                        <div>我的课程</div>--%>
        <%--                    </a>--%>
        <%--                </li>--%>

        <%--                <li class="attend_s_menu" style="display: none" onclick="jumpsrc('/DutyPoliceUsers/dutypoliceusersapp?dataType='+check($.GetRequest().dataType)+'')">--%>
        <%--                    <a>--%>
        <%--                        <img src="../../img/menu/Attendancemanagement.png"/>--%>
        <%--                        <div>公安值班</div>--%>
        <%--                    </a>--%>
        <%--                </li>--%>
        <%--            </ul>--%>
        <%--        </div>--%>

        <%--        <div class="edu_div" :style="{'margin-bottom': '0.4rem','margin-top':topsize,'display':'none'}" >--%>
        <%--            <div>--%>
        <%--                <div class="menuTitle">日常事务</div>--%>
        <%--                <div class="menuContent">--%>
        <%--                    <div @click="jumpUrl('/weekSchedule/weekIndex')" class="edu-block">--%>
        <%--                        <img src='/img/H5/ewxh5/email.png' alt="" class="edu-img">--%>
        <%--                        <span class="edu-name">每周工作</span>--%>
        <%--                    </div>--%>
        <%--                    <div @click="jumpUrl('/EduAnnexBulletinController/indexByTeacher')" class="edu-block">--%>
        <%--                        <img src='/img/H5/ewxh5/email.png' alt="" class="edu-img">--%>
        <%--                        <span class="edu-name">材料缴交</span>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--            <div v-for="(item,index) in menu" :key="index">--%>
        <%--                <div class="menuTitle" v-cloak>{{item.name}}</div>--%>
        <%--                <div class="menuContent">--%>
        <%--                    <div v-for="(child,index2) in item.child"--%>
        <%--                         :key="index2"--%>
        <%--                         @click="showChild(child)"--%>
        <%--                         class="edu-block"--%>
        <%--                         v-if="child.isShowFunc==0"--%>
        <%--                    >--%>
        <%--                        <img :src=`/img/menu/\${child.name1}.png` alt="" class="edu-img">--%>
        <%--                        <span class="edu-name" v-cloak>{{ child.name}}</span>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--        </div>--%>
    </div>

</div>
</body>
<script>
    $(function(){


        //获取菜单分组类型
        $.ajax({
            type: 'get',
            url: '/code/getCode?parentNo=PORTAL_GROUP_TYPE',
            dataType: 'json',
            success: function (rsp) {
                var data = rsp.obj;
                var strOut = '';
                for(var i=0;i<data.length;i++){
                    strOut += '<div class="square">\n' +
                        '            <div class="titlehead">\n' +
                        '                <label style="font-size: 15px;color: #a9a6a6" id="menuGroup_'+data[i].codeNo + '">'+ data[i].codeName +'</label>\n' +
                        '            </div>\n' +
                        '            <ul class="square-inner flex" id="menus_ul_' + data[i].codeNo + '" style="">\n' +
                        '            </ul>\n' +
                        '        </div>';
                }
                $('.yingyong' ).html(strOut);
                $('.yingyong' ).children('.square:last-child').addClass('lastGroup');
                showMenuWithPriv();
                showMenuRs();
            }
        })




        // 查询项目类型
        $.ajax({
            url: "/syspara/selectByParaName?paraName=MYPROJECT",
            type: 'get',
            dataType: "JSON",
            success: function (data) {
                if(data.flag){
                    if(data.object!=undefined&&data.object.indexOf('edu')>-1){
                        $('.edu_div').show();
                    } else {
                        $('.edu_div').hide();
                    }
                }
            }
        })
        /*$.ajax('/user/getNowLoginUser',{
            dataType:'json',//服务器返回json格式数据
            type:'get',//HTTP请求类型
            success:function(data){
                if(data.flag){
                    if(data.object.userPriv==1){
                        $('.attend_s_menu').css('display','inherit');
                    }

                }
            }
        });*/

        function showMenuWithPriv(){
            $.ajax('/sysMenuH5/showH5Menus?portalGroupType=01',{
                dataType:'json',//服务器返回json格式数据
                type:'get',//HTTP请求类型

                success:function(res){
                    if(res.flag){
                        var datas = res.data;
                        var str = '';
                        for (var i = 0 ,length=datas.length; i < length; i++) {
                            var obj = datas[i];
                            var jumpSrc = obj.menuH5Url+'?dataType='+check($.GetRequest().dataType);
                            if(obj.menuH5Url.indexOf('/')!=0){
                                jumpSrc = '/'+jumpSrc;
                            }
                            var iconStc = obj.menuIcon;
                            if(iconStc.indexOf('http')===-1){
                                iconStc ='/img/H5/ewxh5/'+iconStc;
                            }

                            str+='<li id="menu_'+obj.menuId+'" class="" style="display: inherit"  onclick="jumpsrc(\''+jumpSrc+'\')">' +
                                '<a>' +
                                '<img src="'+iconStc+'"/>' +
                                '<div>'+obj.menuName+'</div>' +
                                '</a>' +
                                '</li>'
                        }
                        $('#menus_ul_01').html(str);
                        // $('#menu_16 img').attr('src','/ui/img/H5/ewxh5/1.10.png')
                        // $('#menu_18 img').attr('src','../../img/H5/ewxh5/1.10.png')
                        // $('#menu_17 img').attr('src','../../img/H5/ewxh5/PersonalAttendance.png')
                    }
                }
            });
        }
        function showMenuRs(){
            $.ajax('/sysMenuH5/showH5Menus?portalGroupType=02',{
                dataType:'json',//服务器返回json格式数据
                type:'get',//HTTP请求类型

                success:function(res){
                    if(res.flag){
                        var datas = res.data;
                        var str = '';
                        for (var i = 0 ,length=datas.length; i < length; i++) {
                            var obj = datas[i];
                            var jumpSrc = obj.menuH5Url+'?dataType='+check($.GetRequest().dataType);
                            if(obj.menuH5Url.indexOf('/')!=0){
                                jumpSrc = '/'+jumpSrc;
                            }
                            var iconStc = obj.menuIcon;
                            if(iconStc.indexOf('http')===-1){
                                iconStc ='/img/H5/ewxh5/'+iconStc;
                            }

                            str+='<li id="menu_'+obj.menuId+'" class="" style="display: inherit"  onclick="jumpsrc(\''+jumpSrc+'\')">' +
                                '<a>' +
                                '<img src="'+iconStc+'"/>' +
                                '<div>'+obj.menuName+'</div>' +
                                '</a>' +
                                '</li>'
                        }
                        $('#menus_ul_02').html(str);
                    }
                }
            });
        }

    })

    function autodivheight(){
        var winHeight=0;
        var winWidth=0;
        /*if (window.innerHeight)
            winHeight = window.innerHeight;*/
        if (window.outerHeight || window.innerHeight)
            winHeight = (window.outerHeight || window.innerHeight);
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;

        $('.mui-content').css({'width':winWidth +"px",'height':winHeight+'px'})

    }
    function check(name){
        if(name=='undefined'){
            return ''
        }else{
            return name;
        }
    }

    autodivheight();
    window.onresize=function(){
        autodivheight();
    }


    $.ajax({
        url:'/todoList/smsListByType',
        type:'get',
        dataType:'json',
        success:function(res){
            var arr=[];
            var str='';
            if(res.data.email.length>0){
                for(var i=0;i<res.data.email.length;i++){
                    str += ' <span style="letter-spacing: 1px;display: block" class="pad_right">邮件提醒：'+res.data.email[i].content+'</span>'
                }
            }
            if(res.data.workFlow.length>0){
                for(var j=0;j<res.data.workFlow.length;j++){
                    str += ' <span style="letter-spacing: 1px;display: block" class="pad_right">工作流提醒：'+res.data.workFlow[j].content+'</span>'
                }
            }
            if(res.data.notify.length>0){
                for(var j=0;j<res.data.notify.length;j++){
                    str += ' <span style="letter-spacing: 1px;display: block" class="pad_right">公告提醒：'+res.data.notify[j].content+'</span>'
                }
            }
            if(res.data.calendars.length>0){
                for(var j=0;j<res.data.calendars.length;j++){
                    str += ' <span style="letter-spacing: 1px;display: block" class="pad_right">日程提醒：'+res.data.calendars[j].content+'</span>'
                }
            }
            if(res.data.diarys.length>0){
                for(var j=0;j<res.data.diarys.length;j++){
                    str += ' <span style="letter-spacing: 1px;display: block" class="pad_right">工作日志提醒：'+res.data.diarys[j].content+'</span>'
                }
            }
            if(res.data.email.length<=0&&res.data.workFlow.length<=0&&res.data.notify.length<=0&&res.data.calendars.length<=0&&res.data.diarys.length<=0){
                str = ' <span style="letter-spacing: 1px;display: block" class="pad_right">暂无事务提醒</span>'
            }
            // var str2 = '<span style="letter-spacing: 1px;display: block" class="pad_right">工作日志提醒：111</span><span style="letter-spacing: 1px;display: block" class="pad_right">工作日志提醒：22</span>'
            $('#scroll_begin').html(str)
            $('#scroll_end').html($('#scroll_begin').html())
        }
    })

    function jumpsrc(ul) {
        mui.openWindow({
            url: ul
        });
    }
    function jumpUrl(ul) {
        window.location.href=ul;
    }

    // function scroll() {
    var ROLL_SPEED = 2000
    var noticeList1 = $('#scroll_begin');
    var noticeList2 = $('#scroll_end');
    var listWrapper = $('#scroll_div');
    noticeList2.html(noticeList1.html())
    listWrapper.css('top', 0)
    var timer = setInterval(rollStart, ROLL_SPEED);






    function rollStart() {
        if (Math.abs(_subStr(listWrapper.css('top'))) >= noticeList1.height()) {
            listWrapper.css('top', 0)
        } else {
            var top = listWrapper.css('top');
            listWrapper.css('top', _subStr(top) - 35)
        }
    }

    // 截取px前数值
    function _subStr(str) {
        var index = str.indexOf('px');
        if (index > -1) {
            return parseFloat(str.substr(0, index + 1))
        }
    }
    // }


    // roll(50)




    $('#scroll_div').on('click', function () {
        window.parent.swaciom()
    })

    let u = navigator.userAgent
    let isAndroid = u.indexOf('Android') > -1 || u.indexOf('Linux') > -1; //g
    let isIOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端

    var vm = new Vue({
        el:"#app",
        data:{
            menu:[],
            topsize:""
        },
        created(){
            this.getModules()
            if (isAndroid) {
                this.topsize = "40px"
                //这个是安卓操作系统
            }
            if (isIOS) {
                this.topsize = "10px"
                //这个是ios操作系统
            }
        },
        methods:{
            getModules(){
                //教育模块 查询id对应的模块
                const isKeyEqualToValue = key => value => object => object[key] === value;
                const isName = isKeyEqualToValue('name');
                const isComprehensiveData = isName("综合素质数据")//综合素质数据
                const isComprehensiveManage = isName("综合素质管理")//综合素质管理
                const isJiaoyan = isName("教研管理")//教研管理
                const isJIaowu = isName("教务管理")//教务管理
                const isBanjiguanli = isName("班级管理")//班级管理
                const isBoth = predicates => value => predicates.some(predicate=>predicate(value))
                const isAll = isBoth([isComprehensiveData,isComprehensiveManage,isJiaoyan,isJIaowu,isBanjiguanli])
                $.ajax({
                    url:"/showMenu",
                    type:"get",
                    success:(res)=>{
                        if(res.flag){
                            let data = res.obj
                            this.menu = data.filter(isAll)
                        }
                    }
                })
            },
            showChild(item){
                if(item.child.length>0){
                    mui.openWindow({
                        url:'/weixinhtml/childMenu?id='+item.id,
                        id:'Create'
                    });
                    console.log(item)
                }else{
                    mui.openWindow({
                        url:'/'+item.url,
                        id:'Create'
                    });
                }
            },
            jumpUrl(url){
                mui.openWindow({
                    url:url,
                    id:'Create'
                });
            }
        }
    })
</script>
</html>
