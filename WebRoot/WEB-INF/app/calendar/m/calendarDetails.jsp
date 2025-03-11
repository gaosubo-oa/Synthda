<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String corpId = (String)request.getAttribute("corpId");
    String corpSecret = (String)request.getAttribute("corpSecret");
%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title><fmt:message code="calendar.th.scheduleDetails" /></title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>

    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <script type="text/javascript" src="../../js/notes/jquery-2.1.2.min.js" ></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/diary/m/simbaJs.js" ></script>

    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>
    <style>
        #header{
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        #header a{
            color: #fff;
        }
        #header h1{
            color: #fff;
            margin: 0px 60px;
        }
        .ulli{
            margin: 0 20px;
            border-bottom: 1px solid #c8c7cc;
            height: 50px;
            line-height: 58px;
        }

        .nav{
            height: 31px;
            line-height: 28px;
            border: 1px solid #e1dddd;
            border-radius: 10px;
            width: 66%;
            margin-top: 13px;
            margin-right: 27px;
        }
        .nav span{
            width: 48%;
            display: inline-block;
            text-align: center;
        }
        .navc{
            background-color: #00a0e9;
            color: #fff;
            border-radius: 10px;
        }
        .fl{
            float: left;
        }
        .fr{
            float: right;
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
        #yspan{
            padding: 4px 10px;
            background-color: #00a0e9;
            color: #fff;
            border-radius: 5px;
            margin-left: 14px;
        }
        .result,.result1{
            color:#00a0e9;
            padding-left: 17px;
        }
    </style>
</head>

<body data-role="page">
<header data-role="header" class="mui-bar mui-bar-nav" id="header">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" ></a>
    <h1 class="mui-title" id="mtitle"><fmt:message code="calendar.th.scheduleDetails" /></h1>
    <a href="javascript:;" id="addes" class="mui-pull-right " style="padding-top: 14px;padding-right: 5px;" ><fmt:message code="global.lang.delete" /></a>
    <a href="javascript:;" id="add1" class="mui-pull-right " style="padding-top: 14px;padding-right: 22px;" ><fmt:message code="global.lang.edit" /></a>
</header>
<div class="mui-content" style="overflow: auto;">
    <ul>
        <li class="ulli">
            <div class="fl" style="height: 50px"><fmt:message code="main.schedule" />：</div>
            <div class="nav fr">
                <span class="fl fl1"><fmt:message code="attend.th.Worktransaction" /></span>
                <span  class="fr fr1"><fmt:message code="attend.th.Persontransaction" /></span>
            </div>
        </li>
        <li class="ulli"><fmt:message code="calendar.th.priorityLevel" />：<a  href="#modals" style="border-right: 1px solid #e2e2e2;" id="ass"><span id="yspan"><fmt:message code="calendar.th.notSpecified" /></span></a></li>
        <li class="ulli" id="demo"><fmt:message code="sup.th.startTime" />：<span class="result"><fmt:message code="calendar.th.selectTime" /></span></li>
        <li class="ulli"id="demo1"><fmt:message code="meet.th.EndTime" />：<span class="result1"><fmt:message code="calendar.th.selectTime" /></span></li>
    </ul>
    <textarea name="" id="cont" disabled="true"  placeholder="<fmt:message code="calendar.th.enterTheScheduleContent" />" style="padding: 6px 0 0 6px;width: 90%;height: 45%;margin-left: 5%;margin-top: 10px;"></textarea>
</div>

<div id="modal" class="mui-modal">
    <header class="mui-bar mui-bar-nav" id="header2">
        <a class="mui-icon mui-icon-close mui-pull-left" href="#modal"></a>
        <h1 class="mui-title"><fmt:message code="calendar.th.pleaseSelectThePriorityLevel" /></h1>
        <a class="mui-btn-link mui-pull-right" id="re_mail" href="javascript:;"><fmt:message code="calendar.th.pleaseSelectThePriorityLevel" /></a>
    </header>
    <div class="mui-content" style="height: 100%;">
        <ul class="mui-table-view" id="mailtype">
            <li class="mui-table-view-cell" data-type=""><a href="#"><fmt:message code="calendar.th.notSpecified" /></a>
            </li>
            <li class="mui-table-view-cell" data-type="1"><a href="#"><fmt:message code="attend.th.Importanturgent" /></a>
            </li>
            <li class="mui-table-view-cell" data-type="2"><a href="#" ><fmt:message code="attend.th.Importanturgent" /></a>
            </li>
            <li class="mui-table-view-cell" data-type="3"><a href="#"><fmt:message code="attend.th.NOImportanturgent" /></a>
            </li>
            <li class="mui-table-view-cell" data-type="4"><a href="#"><fmt:message code="attend.th.NOImportantNOurgent" /></a>
            </li>
        </ul>
    </div>
</div>
<script>
    $(function(){
        alert(1)
        var content = sessionStorage.getItem("content");
        var stim = sessionStorage.getItem("stim");
        var etim = sessionStorage.getItem("etim");
        var calType = sessionStorage.getItem("calType");
        var calLevel = sessionStorage.getItem("calLevel");
        var calId = sessionStorage.getItem("calId");
        if(calType==1){
            $('.fl1').addClass('navc')
        }else {
            $('.fr1').addClass('navc')
        }
        if(calLevel==1){
            calLevel="<fmt:message code="attend.th.Importanturgent" />";
        }else if(calLevel==2){
            calLevel="<fmt:message code="attend.th.Importanturgent" />";
        }else if(calLevel==3){
            calLevel="<fmt:message code="attend.th.NOImportanturgent" />";
        }else if(calLevel==4){
            calLevel="<fmt:message code="attend.th.NOImportantNOurgent" />";
        }else{
            calLevel="<fmt:message code="calendar.th.notSpecified" />";
        }
        $('#yspan').text(calLevel);
        $('.result').text(stim);
        $('.result1').text(etim);
        $('#cont').val(content);

        mui("#header").on('tap', '#addes', function(event){
            var btnArray = ['<fmt:message code="main.th.confirm" />','<fmt:message code="depatement.th.quxiao" />'];
            mui.confirm('<fmt:message code="calendar.th.areYouSureYouWantToDelete" />！', ' ', btnArray, function (e) {
                if(e.index==0){
                    mui.ajax('/schedule/delete',{
                        data:{
                            'calId':calId
                        },
                        dataType:'json',//服务器返回json格式数据
                        type:'post',//HTTP请求类型
                        success:function(data){
                            if(data.flag){
                                var btnArray = ['<fmt:message code="main.th.confirm" />'];
                                mui.confirm('<fmt:message code="workflow.th.delsucess" />', ' ', btnArray, function(e) {
//                                mui.back(e);
                                    mui.openWindow({
                                        url: '/calender/calendarh5'
                                    })
                                })
                            }else{
                                mui.toast("<fmt:message code="workflow.th.delsucess" />！");
                            }
                        }
                    })
                }else {
                    mui.toast("<fmt:message code="calendar.th.cancelled" />！");
                }

            })
        })

    })
    mui("#header").on('tap', '#add1', function(event){
        $("#cont").attr('disabled',false)
        var calId = sessionStorage.getItem("calId");
         $("#addes").remove();
        $("#add1").remove();
        $('#ass').attr('href','#modal')
        $("#header").append('<a href="javascript:;" id="add2" class="mui-pull-right " style="padding-top: 14px;padding-right: 5px;" ><fmt:message code="global.lang.save" /></a>')
        var con=''
        var conid
        function mustWrite() {
            if($('.result').text()=='<fmt:message code="calendar.th.selectTime" />') {
                mui.toast("<fmt:message code="sup.th.selectStartTime" />！");
                return false;
            }
            if($('.result1').text()=='<fmt:message code="calendar.th.selectTime" />') {
                mui.toast("<fmt:message code="sup.th.selectEndTime" />！");
                return false;
            }
            if($('#cont').val()=='') {
                mui.toast("<fmt:message code="calendar.th.pleaseFillInTheContent" />！");
                return false;
            }
            if($('.result').text()==$('.result1').text()){
                mui.toast("<fmt:message code="calendar.th.pleaseSelectADifferentTime" />！");
                return false;
            }
        }
        //取cooke代码

        function getCookie(name)
        {
            var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
            if(arr=document.cookie.match(reg))
                return unescape(arr[2]);
            else
                return null;
        }
        var userId=getCookie('userId')

        $('.nav').on('click','span',function(){
            $('span').removeClass('navc')
            $(this).addClass('navc')
        })
        $('#mailtype').on('click','li',function(){
            $('li').removeClass('navc')
            $(this).addClass('navc')
            con=$(this).text()
            conid=$(this).attr('data-type')
        })
        $('#re_mail').on('click',function(){
            $('#yspan').text(con)
            $('#yspan').attr('data-type',conid)
            $('#modal').removeClass('mui-active')
        })

        var year=new Date().getFullYear() ;

        var  month=new Date().getMonth();

        var day=new Date().getDate();
        $("#demo").click(function(){
            var picker = new mui.DtPicker({
                type: "datetime",//设置日历初始视图模式
                beginDate: new Date(year, month, day),//设置开始日期
                endDate: new Date(2222, 04, 25),//设置结束日期
                labels: ['<fmt:message code="chat.th.year" />', '<fmt:message code="global.lang.month" />', '<fmt:message code="global.lang.day" />', '<fmt:message code="calendar.th.hour" />', '<fmt:message code="calendar.th.minute" />'],//设置默认标签区域提示语
            })
            picker.show(function(rs) {
//
                $(".result").html(  rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
//
//            //return false;    //这是阻止对话框关闭的
//
                picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例
            })
            $('.mui-btn').html('<fmt:message code="depatement.th.quxiao" />');
            $('.mui-btn-blue').html('<fmt:message code="calendar.th.pleaseSelectThePriorityLevel" />');
        })
        $("#demo1").click(function(){
            var picker = new mui.DtPicker({
                type: "datetime",//设置日历初始视图模式
                beginDate: new Date(year, month, day),//设置开始日期
                endDate: new Date(2222, 04, 25),//设置结束日期
                labels: ['<fmt:message code="chat.th.year" />', '<fmt:message code="global.lang.month" />', '<fmt:message code="global.lang.day" />', '<fmt:message code="calendar.th.hour" />', '<fmt:message code="calendar.th.minute" />'],//设置默认标签区域提示语
            })
            picker.show(function(rs) {
//
                $(".result1").html(  rs.text);  //rs.text.split(' ')[0]只获取年。下标改成1，只获取月，以此类推
//
//            //return false;    //这是阻止对话框关闭的
//
                picker.dispose();  //释放组件资源，释放后将将不能再操作组件.所以每次用完便立即调用 dispose 进行释放，下次用时再创建新实例

            })
            $('.mui-btn').html('<fmt:message code="depatement.th.quxiao" />');
            $('.mui-btn-blue').html('<fmt:message code="calendar.th.pleaseSelectThePriorityLevel" />');

        })
        mui("#header").on('tap', '#add2', function(event){
            if(mustWrite()==false) {
                return;
            }
            var content=$('#cont').val();
            var calTime=Date.parse(new Date($('.result').text().replace(/-/g,"/")))/1000;
            var endTime=Date.parse(new Date($('.result1').text().replace(/-/g,"/")))/1000;
            var calType
            if($('.fl').hasClass('navc')){
                calType=1
            }
            if($('.fr').hasClass('navc')){
                calType=2
            }
            var calLevel=$('#yspan').attr('data-type')
            if(calLevel==undefined){
                calLevel=''
            }
            mui.ajax('/schedule/editCalender',{
                data:{
                    'calTime':calTime,
                    'endTime':endTime,
                    'content':content,
                    'calType':calType,
                    'calLevel':calLevel,
                    'userId':userId,
                    'calId':calId
                },
                dataType:'json',//服务器返回json格式数据
                type:'post',//HTTP请求类型
                success:function(data){
                    if(data.flag){
                        var btnArray = ['<fmt:message code="main.th.confirm" />'];
                        mui.confirm('<fmt:message code="netdisk.th.Editsuccess" />', ' ', btnArray, function(e) {
                            mui.openWindow({
                                url: '/calender/calendarh5'
                            })
                        })
                    }else{
                        var btnArray = ['<fmt:message code="main.th.confirm" />'];
                        mui.confirm('<fmt:message code="event.th.EditFailed" />！', ' ', btnArray, function(e) {
                        })
                    }
                }
            })
        })
    });
</script>
</body>
</html>
