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
    <title><fmt:message code="attend.th.Newschedule" /></title>
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
        /*.nav{*/
            /*width: 70%;*/
            /*overflow: hidden;*/
            /*text-overflow: ellipsis;*/
            /*white-space: nowrap;*/
            /*height: 22px;*/
            /*line-height: 22px;*/
            /*margin-top: 15px;*/
        /*}*/
        #header{
            background-color: #3984ff;
            box-shadow: 1px 1px 7px rgba(0, 0, 0, .85);
        }
        #header a{
            color: #fff;
        }
        #header h1{
            color: #fff;
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
    <h1 class="mui-title" id="mtitle"><fmt:message code="attend.th.Newschedule" /></h1>
    <a href="javascript:;" id="add" class="mui-pull-right " style="padding-top: 14px;padding-right: 5px;" ><fmt:message code="global.lang.save" /></a>
</header>
<div class="mui-content" style="overflow: auto;">
    <ul>
        <li class="ulli">
            <div class="fl" style="height: 50px"><fmt:message code="main.schedule" />：</div>
            <div class="nav fr">
                <span class="navc fl"><fmt:message code="attend.th.Worktransaction" /></span>
                <span  class="fr"><fmt:message code="attend.th.Persontransaction" /></span>
            </div>
        </li>
        <li class="ulli"><fmt:message code="calendar.th.priorityLevel" />：<a  href="#modal" style="border-right: 1px solid #e2e2e2;"><span id="yspan"><fmt:message code="calendar.th.notSpecified" /></span></a></li>
        <li class="ulli" id="demo"><fmt:message code="sup.th.startTime" />：<span class="result"><fmt:message code="calendar.th.selectTime" /></span></li>
        <li class="ulli"id="demo1"><fmt:message code="meet.th.EndTime" />：<span class="result1"><fmt:message code="calendar.th.selectTime" /></span></li>
    </ul>
    <textarea name="" id="cont"   placeholder="<fmt:message code="calendar.th.enterTheScheduleContent" />" style="padding: 6px 0 0 6px;width: 90%;height: 45%;margin-left: 5%;margin-top: 10px;"></textarea>
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
    $('#add').click(function(){
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
        mui.ajax('/schedule/addCalender',{
        data:{
            'calTime':calTime,
            'endTime':endTime,
            'content':content,
            'calType':calType,
            'calLevel':calLevel,
            'userId':userId,

        },
        dataType:'json',//服务器返回json格式数据
        type:'post',//HTTP请求类型
        success:function(data){
            if(data.flag){
                var btnArray = ['<fmt:message code="main.th.confirm" />'];
                mui.confirm('<fmt:message code="diary.th.modify" />', ' ', btnArray, function(e) {
                    mui.openWindow({
                        url: '/calender/calendarh5'
                    })
                })
            }else{
                var btnArray = ['<fmt:message code="main.th.confirm" />'];
                mui.confirm('<fmt:message code="meet.th.SaveFailed" />！', ' ', btnArray, function(e) {
                })
            }
        }
        })
    })



//    var mtype='inbox'
//
//    //    function plusReady(){
//    //        // 在这里调用plus api
//    //    }
//    //    if(window.plus){
//    //        plusReady();
//    //    }else{
//    //        document.addEventListener('plusready',plusReady,false);
//    //    }
//    window.addEventListener('refresh',function(e){
//        location.reload();
//    });
//    (function($, doc) {
////        mui.init({
////            swipeBack:true, //启用右滑关闭功能
////            preloadPages:[{
////                id:'detailh5',
////                url:'detailh5'
////            }]
////        });
////        $.back=function(){
////            plus.SimbaPlugin.quitApp();
////        };
//        var rmail='rmail';
//        get_data(rmail);
////        var detailPage=null;
//        mui('#ul_calendar').on('tap', 'a.mui-navigate-right', function() {
////            mtype=event.target.getAttribute('data-type');
//            var bodyId = this.getAttribute('bodyId');
//            var href = this.href;
////            var mid = this.getAttribute('data-did');
////            var mtype=this.getAttribute('mtype');
////            var type = this.getAttribute("open-type");
////            if(!detailPage){
////                detailPage = plus.webview.getWebviewById('detailh5');
////            }
////            mui.fire(detailPage,'newsId',{
////                mid:mid,
////                mtype:mtype
////            });
//
//            if( mtype == "inbox"|| mtype =="recycle"){
//                mui.openWindow({
//                    url: 'detailh5?flag='+mtype+'&emailID='+bodyId
//                });
//            }else {
//                mui.openWindow({
//                    url: 'detailh5?flag='+mtype+'&bodyId='+bodyId
//                });
//            }
//
//
//        });
//        //向左侧滑删除本条数据
//        mui('#ul_calendar').on('tap', '.mui-btn', function(event) {
//            var btnArray = ['确认', '取消'];
//            var elem = this;
//            var li = elem.parentNode.parentNode;
//            var bodyId = elem.getAttribute('bodyId');
//            mui.confirm('确认删除该条记录？', ' ', btnArray, function(e) {
////                var mtype=elem.parentNode.parentNode.lastChild.firstChild.getAttribute('mtype');
//                var mid=elem.parentNode.parentNode.lastChild.firstChild.getAttribute('data-did');
//                if (e.index == 0) {
//                    console.log(mtype);
//                    if(mtype=="drafts") {
//                        mui.ajax('/email/deleteDraftsEmail',{
//                            data:{
//                                bodyId:bodyId
//                            },
//                            dataType:'json',//服务器返回json格式数据
//                            type:'get',//HTTP请求类型
//                            success:function(data){
//                                if(data.flag == true){
//                                    mui.toast("删除成功！");
//                                    li.parentNode.removeChild(li);
//                                }else{
//                                    mui.toast("删除失败！");
//                                }
//                            }
//                        });
//                    } else {
//                        mui.ajax('/email/deleteEmail',{
//                            data:{
//                                flag:mtype,
//                                emailID:bodyId,
//                                deleteFlag:0
//                            },
//                            dataType:'json',//服务器返回json格式数据
//                            type:'get',//HTTP请求类型
//                            success:function(data){
//                                if(data.flag == true){
//                                    mui.toast("删除成功！");
//                                    li.parentNode.removeChild(li);
//                                }else{
//                                    mui.toast("删除失败！");
//                                }
//                            }
//                        });
//
//                    }
//                } else {
//                    setTimeout(function() {
//                        $.swipeoutClose(li);
//                    }, 0);
//                }
//            });
//        });
//        /*收件箱，发件箱，油标箱，草稿等切换*/
//        mui('#mailtype').on('tap', 'a', function() {
//            mtype=event.target.getAttribute('data-type');
//            var title=event.target.text;
//            document.getElementById('mtitle').innerHTML= title;
//            mui('#Popover_0').popover('hide');
//            mui.ajax('/email/showEmail?flag='+mtype+'&page=1&pageSize=3&useFlag=false',{
//                dataType:'json',//服务器返回json格式数据
//                type:'get',//HTTP请求类型
//                success:function(data){
//                    var cal='';
//
//
//                    $("#ul_calendar")[0].innerHTML='';
//                    if( data.obj.length != 0){
//                        for(var i=0;i<data.obj.length;i++){
//                            var ics
//                            if( mtype == "inbox"|| mtype =="recycle"){
//
//                                ics=data.obj[i].emailList[0].emailId
//                                console.log(ics)
//
//                            }else {
//                                ics=data.obj[i].bodyId
//                            }
//
//                            cal+='<li class="mui-table-view-cell mui-transitioning">' +
//                                '<div class="mui-slider-right mui-disabled">' +
//                                '<a class="mui-btn mui-btn-red" bodyId="'+ics+'">删除</a>' +
//                                '</div>' +
//                                '<div class="mui-slider-handle">' +
//                                '<a class="mui-navigate-right" href="/detail" bodyId="'+ics+'" >' +
//                                '<p style="color:#333;font-size:1.1em">'+data.obj[i].users.userName+'<span style="font-size: 12px;color:#ccc;width: 65%;display: inline-block;text-align: right;">'+data.obj[i].probablyDate+'</span></p>' +
//                                '<p class="nav">ReAll:<span >'+data.obj[i].subject+'</span></p>' +
//                                '<div class="nav">'+data.obj[i].content+'</div>'+
//                                '</a>' +
//                                '</div>' +
//                                '</li>';
//                        }
//                        $("#ul_calendar")[0].innerHTML = cal;
//                    }else{
//                        $("#ul_calendar")[0].innerHTML = '<li class="mui-table-view-cell">暂无内容</li>';
//                    }
//                }
//            });
//        });
//        /*点击写邮箱*/
//        var btn = document.getElementById("Popover_1");
//        btn.addEventListener('tap', function() {
//            mui.openWindow({
//                url: 'addMailh5',
//                id:'add'
//            });
//        });
//    })(mui, document);
//    function get_data(m){
//        var cal='';
//        mui.ajax('/email/showEmail?flag=inbox&page=1&pageSize=3&useFlag=false',{
//            data:{
////                mtype:m,
////                flag:'loadlist',
////                ftype:'refresh'
//            },
//            dataType:'json',//服务器返回json格式数据
//            type:'get',//HTTP请求类型
//            success:function(data){
//                if( data.obj.length != 0){
//                    for(var i=0;i<data.obj.length;i++){
//                        cal+='<li class="mui-table-view-cell mui-transitioning">' +
//                            '<div class="mui-slider-right mui-disabled">' +
//                            '<a class="mui-btn mui-btn-red" bodyId="'+data.obj[i].emailList[0].emailId+'">删除</a>' +
//                            '</div>' +
//                            '<div class="mui-slider-handle">' +
//                            '<a class="mui-navigate-right" href="/detailh5" bodyId="'+data.obj[i].emailList[0].emailId+'">' +
//                            '<p style="color:#333;font-size:1.1em;height: 22px;line-height: 22px;"><span style="display: inline-block;float: left">'+data.obj[i].users.userName+'</span><span style="font-size: 12px;color:#ccc;display: inline-block;float: right;padding-right: 10px;">'+data.obj[i].probablyDate+'</span></p>' +
//                            '<p class="nav">ReAll:<span >'+data.obj[i].subject+'</span></p>' +
//                            '<div class="nav">'+data.obj[i].content+'</div>'+
//                            '</a>' +
//                            '</div>' +
//                            '</li>';
//                    }
//                    $("#ul_calendar")[0].innerHTML = cal;
//                }else{
//                    $("#ul_calendar")[0].innerHTML = '<li class="mui-table-view-cell">暂无内容</li>';
//                }
//            }
//        });
//    }
</script>
</body>
</html>
