<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title><fmt:message code="meet.th.ConferenceApplication" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/meeting/index.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.print.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <%--<link rel="stylesheet" href="/lib/laydate/need/laydate.css">--%>
    <style>
        .equip tbody td{
            text-align: center;
        }
        .equipSpan{
            background-color:#00a2d4;
        }
        .equip {
            width: 77%;
            margin: 20px auto;
        }
        table tbody td{
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
            padding:0;
        }
        .head .headli{
            width:94px;
        }

        .pagediv{
            margin: 0 auto!important;
        }
        .table tr td:first-of-type{
            text-align: right;
        }
        .layui-layer-btn {
            text-align: center!important;
        }
        .layui-laydate-content td, .layui-laydate-content th{
            font-size: 14px;
            line-height: normal;
        }
        .fc-day-number{
            font-weight:700
        }
    </style>
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="../../lib/fullcalendar/moment.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>--%>
    <script src="../../lib/fullcalendar/fullcalendar.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/jquery-ui.custom.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/zh-cn.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js?20190927.1"></script>
    <script src="/lib/layDate-v5.0.9/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/jquery/jquery.jqprint-0.3.js"></script>

    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <%--<script src="/lib/laydate/laydate.js?20210224.1"></script>--%>
    <style>
        .typeBtn{
            float: right;
            margin: 5px 5px;
            width: 60px;
            height: 28px;
            line-height: 38px;
            color: #fff;
            border: 1px solid #ebebeb;
            outline: none;
            font-size: 14px;
            border-radius: 5px;
            line-height: 28px;
            cursor: pointer;
        }
        .M-box3 .active{
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color:#fff;
            text-align:center;
            display: inline-block;
        }
        .M-box3 a{
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align:center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }
        .jump-ipt{
            float: left;
            width: 30px;
            height: 30px;
        }
        .span_td{
            width: 130px;
            text-align: right;
        }
        .table{
            width: 90%;
            margin: 10px auto;
        }
        .div_tr input{
            text-indent: 5px;
        }

        .one {
            border-radius: 20px !important;
        }

        .fc-header-left, .fc-header-right {
            padding: 10px 18px !important;
            box-sizing: border-box;
        }

        .fc-header-left .fc-button, .fc-header-right .fc-button{
            margin-bottom: 0;
        }

        .div_tr {
            margin: 0;
            padding: 10px;
        }

        input[type=file]{
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }
        .btn{
            background-color: white;
            background: #009688;
            border: 0;
            color: #fff;
            width: 100px;
            height: 40px;
            font-size: 16px;
            display: block;
            margin: 0 auto 20px auto;
        }
        /*.fc-day-content{*/
        /*    height: 80vh;*/
        /*}*/
        .fc-view-basicWeek{
            height: 84vh;
        }
        .layui-laydate-content > .layui-laydate-list {
            padding-bottom: 0px;
            overflow: hidden;
        }

        .layui-laydate-content > .layui-laydate-list > li {
            width: 50%
        }

        .merge-box .scrollbox .merge-list {
            padding-bottom: 5px;
        }
        .layui-laydate-main laydate-main-list-0{
            display: none;
        }
        #beginTime1,#editendTime,#editstartTime{
            position: absolute;
            left: 0px;
            top: -4px;
            background: transparent;
            width: 185px;
            padding-left: 85px;
            box-sizing: border-box;
            padding-left: -28px;
            border: 0;
        }
        #endTime1{
            position: absolute;
            left: 0px;
            top: -4px;
            background: transparent;
            width: 185px;
            padding-left: 85px;
            box-sizing: border-box;
            padding-left: -28px;
            border: 0;
        }
</style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="font-family: 微软雅黑;">

<div class="head w clearfix">
    <ul class="index_head">
        <li id="meetingApply" onclick="listByStatus(0)"><span class="one headli"><fmt:message code="meet.th.ConferenceApplication" /></span><img src="../img/twoth.png" alt=""/></li>

        <%--        <li id="PAMeeting" onclick="listByStatus(1)"><span class="headli"><fmt:message code="meet.th.Meeting" /></span><img src="../img/twoth.png" alt=""/></li>--%>
        <li id="ApMeeting" onclick="listByStatus(2)">
            <span class="headli"><fmt:message code="meet.th.Approved" /></span>
            <img style="margin-left: 0;" src="../img/twoth.png" alt=""/></li>
        <li id="HaveMeeting" onclick="listByStatus(3)"><span class="headli"><fmt:message code="meet.th.InSession" />
        </span><img  src="../img/twoth.png" alt=""/>
        </li>
        <li style="width: 200px"><span style="color: red">注：请点击空白区域申请教室！</span></li>
        <%--        <li id="NotMeeting" onclick="listByStatus(4)"><span class="headli" style="margin-top: 4px;"><fmt:message code="meet.th.NotApprovedMeeting" /></span></li>--%>
    </ul>
    <div class="colorClass">

        <button type="button" id="Import"
                style="margin-left: 10px;
    height: 28px;
    line-height: 28px;
    padding: 0 10px;
    font-size: 12px;
    border: none;
    border-radius: 2px;
    cursor: pointer;
    background-color: #009688;
    color: #fff;
    white-space: nowrap;
    text-align: center;
    width: 70px;">
            导入
        </button>


        <%-- <a href="javascript:;" style="background-color: rgb(58, 135, 173);"></a>
         <span><fmt:message code="meet.th.PendingApproval" /></span>--%>
        <a href="javascript:;" style="background-color: rgb(105, 240, 164);"></a>
        <span>所有会议</span>
        <a href="javascript:;" style="background-color: rgb(255, 136, 124);"></a>
        <span><fmt:message code="meet.th.HaveHand" /></span>
        <a href="javascript:;" style="background-color: rgb(245, 181, 46);"></a>
        <%--<span><fmt:message code="meet.th.unratified" /></span>
        <a href="javascript:;" style="background-color: rgb(219, 173, 255);"></a>--%>
        <span style="margin-right: 24px"><fmt:message code="meet.th.IsOver" /></span>



    </div>

</div>
<div class="meentingDate" id="meentingDate" style="display: block;overflow-y: auto;padding: 0 18px 20px;box-sizing: border-box;">
    <%--<input class="typeBtn" type="button" onclick="addMeeting()" value="申请" style="background: dodgerblue"/>--%>
    <div class="mainList">
    </div>
</div>
<div class="pagediv" id="already" style="margin: 0 auto;width: 97%;display: none;margin-top: 10px;">
    <div class="headTop" style="z-index: 999;">
        <div class="headImg">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_apply.png" alt="">
        </div>
        <div class="divTitle">
            <fmt:message code="meet.th.ConferenceApplication" />
        </div>
    </div>
    <table>
        <thead>
        <tr>
            <th width="11%" style="text-align:center"><fmt:message code="meet.th.ConferenceName" /></th>
            <th width="11%" style="text-align:center"><fmt:message code="meet.th.ConferenceTitle" /></th>
            <th width="11%" style="text-align:center">会议验证码</th>
            <th width="13%" style="text-align:center"><fmt:message code="sup.th.ApplicationTime" /></th>
            <th width="13%" style="text-align:center"><fmt:message code="sup.th.startTime" /></th>
            <th width="13%" style="text-align:center"><fmt:message code="meet.th.EndTime" /></th>
            <th width="9%" style="text-align:center"><fmt:message code="meet.th.ConferenceRoom" /></th>
            <th width="6%" style="text-align:center"><fmt:message code="sup.th.Applicant" /></th>
            <th width="9%" style="text-align:center">联系电话</th>
            <th width="15%" style="text-align:center"><fmt:message code="notice.th.operation" /></th>
        </tr>
        </thead>
        <tbody>
        </tbody>

    </table>
    <div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

    </div>
</div>

<script>

    //判断角色是否有新增编辑权限
    var uId = -1 , userId = '' ,userName = '', userId = '',uIdPriv61=[] , userIdPriv61=[],userIdPriv62=[];
    $(function(){
        $.ajax({
            url: '/Meetequipment/getuser',
            type: 'get',
            dataType: 'json',
            success: function (res) {
                userName = res.object.userName;
                userId = res.object.userId;
                uId = res.object.uid;
            }
        })

        //教室管理员
        $.ajax({
            url: "/user/getUserByUserPriv?userPriv=61",
            type: "get",
            dataType: "json",
            success: function (res) {
                var otherUsers = res.object.otherUsers;
                var users = res.object.users;

                for (var i = 0; i < users.length; i++) {
                    userIdPriv61.push(users[i].userId)
                    uIdPriv61.push(users[i].uid)
                }

                for (var j = 0; j < otherUsers.length; j++) {
                    userIdPriv61.push(otherUsers[j].userId)
                    uIdPriv61.push(otherUsers[j].uid)
                }

            }
        })

        //教室申请人
        $.ajax({
            url: "/user/getUserByUserPriv?userPriv=62",
            type: "get",
            dataType: "json",
            success: function (res) {
                var otherUsers = res.object.otherUsers;
                var users = res.object.users;

                for (var i = 0; i < users.length; i++) {
                    userIdPriv62.push(users[i].userId)
                }

                for (var j = 0; j < otherUsers.length; j++) {
                    userIdPriv62.push(otherUsers[j].userId)
                }

            }
        })
    });


    //点击导入按钮
    $(document).on('click','#Import',function(){
        layer.open({
            type: 1,
            title: ['数据导入'],
            area: ['600px', '350px'],
            shadeClose: true, //点击遮罩关闭
            content: '<div style="display: block;" id="uploadfile">' +
                '     <form id="ajaxform" method="post" enctype ="multipart/form-data">' +
                '        <div style="text-align: center">' +
                '          <div style="font-size: 20px;">' +
                '              <button type="button" class="layui-btn" id="test1" style=" display: block; margin: 25px auto; ">\n' +
                '                 <i class="layui-icon">&#xe67c;</i>上传附件\n' +
                '              </button>' +
                '             <a style="color: #03a9f4"  href="/file/meeting/会议管理导入模板.xls">下载导入模板</a>' +
                '          </div>' +
                '          <hr style="height: 2px;margin-top: 50px;"/>' +
                '          <div><span style="color: #03a9f4;">特别提示：在执行导入数据前,请先备份数据库</span><span style="color: red;">导入成功后请刷新页面</span></div>' +
                '        </div>' +
                '     </from>' +
                '</div>' +
                '<div style="display: none; padding: 20px; background-color: #F2F2F2;" id="uploadmsg">' +
                '</div>',
            success: function () {
                layui.use('upload', function(){
                    var upload = layui.upload;
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        ,url: '/meeting/meetingImport' //上传接口
                        ,accept: 'file'
                        ,before: function(obj){
                            layer.load();
                        }
                        ,done: function(res, index, upload){
                            //上传完毕回调
                            if (res.flag){
                                $('#uploadfile').hide();
                                $('#uploadmsg').show();

                                var obj = res.obj;
                                for (var i = 0; i < obj.length ; i++) {
                                    var row = obj[i].row;
                                    var msg = obj[i].msg;
                                    var str = '<div class="layui-card">\n' +
                                        '  <div class="layui-card-header"> 第<span style="color: red;">' + row + '</span>行</div>\n' +
                                        '  <div class="layui-card-body">' + msg.msg + '  </div>\n' +
                                        '</div>';
                                    $('#uploadmsg').append(str);
                                }
                            }else{
                                layer.msg(res.msg);
                            }
                            layer.closeAll('loading');
                        }
                        ,error: function(){
                            //请求异常回调layer
                            layer.msg('异常');
                            layer.closeAll('loading');
                        }
                    });
                })
            }
        });

    });

    $(document).on('click','#selectUser',function(){//选人员控件(申请人)
        user_id='userDuser';
        var selectUserOpen=''
        selectUserOpen="../common/selectUser?0"
        // $.popWindow("../common/selectUser?0");
        selectUsreLayerIndex = layer.open({
            type: 2,
            title: '选择用户',
            content: selectUserOpen,
            area: ['65%', '80%']
        })
    });
    $(document).on('click','#selectRecorder',function(){//选人员控件（纪要员）
        user_id='recoderDuser';
        var selectUserOpen=''
        selectUserOpen="../common/selectUser?0"
        // $.popWindow("../common/selectUser?0");
        selectUsreLayerIndex = layer.open({
            type: 2,
            title: '选择用户',
            content: selectUserOpen,
            area: ['65%', '80%']
        })
    });
    $(document).on('click','#selectAttendee',function(){//选人员控件（出席内部人员）
        user_id='attendeeDuser';
        var selectUserOpen=''
        selectUserOpen="../common/selectUser"
        // $.popWindow("../common/selectUser");
        selectUsreLayerIndex = layer.open({
            type: 2,
            title: '选择用户',
            content: selectUserOpen,
            area: ['65%', '80%']
        })

    });
    $(document).on('click','#clearUser',function(){ //清空人员(申请人)
        $('#userDuser').attr('user_id','');
        $('#userDuser').attr('dataid','');
        $('#userDuser').val('');
    });
    $(document).on('click','#clearRecoder',function(){ //清空人员（纪要员）
        $('#recoderDuser').attr('user_id','');
        $('#recoderDuser').attr('dataid','');
        $('#recoderDuser').val('');
    });
    $(document).on('click','#clearAttendee',function(){ //清空人员（出席内部人员）
        $('#attendeeDuser').attr('user_id','');
        $('#attendeeDuser').attr('dataid','');
        $('#attendeeDuser').val('');
    });

    //拉起视频会议客户端
    function GetDataSet(obj){
        //进行打卡
        $.post('/meeting/readMeeting',{meetingId:obj.sId,attendFlag:1},function (res) {
            if(res.flag){
                //layer.msg('打卡成功');
            }
        });

        var url = "http://127.0.0.1:2900";
        var content = '<?xml version="1.0" encoding="UTF-8" ?>' +
            '<lemeeting>' +
            '<req_type>10001</req_type>' +
            '<login_param>' +
            '-j="'+obj.j+'" -roid='+obj.roid+' -rid='+obj.rid+' -rp="'+obj.rp+'" -aoid='+obj.aoid+' -a="'+obj.a+'" -n="'+obj.n+'" -rmd=1  -ccvt=1 -mpc=100 -mvsc=100 -mipcdc=100 -srf=1 -msfs=4000' +
            '</login_param>' +
            '</lemeeting>';
        var request = null;
        if (window.XMLHttpRequest) {
            request = new XMLHttpRequest();
        } else if (window.ActiveXObject) {
            request = new ActiveXObject("Microsoft.XMLHTTP");
        }
        if(request){
            // 防止缓存&& DECODE
            request.open("POST", url, false);//true异步false同步
            //定义传输的文件HTTP头信息
            request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            request.send(content);
        }
    }

    //初始化申请管理员下拉列表
    $(function(){
        // autoIDheight('meentingDate',46);
        windowReload();
        $('.mainList').fullCalendar({
            header: {
                left: 'prev,next,today',
                center: 'title',
                right: 'month,basicWeek',
            },
            buttonText:{
                today:'<fmt:message code="meet.th.JumpthDay" />'
            },
            lang: 'zh-cn',
            editable: true,
            contentHeight: '800',
            loading: function(sign) {
                if (!sign) {// sign=false时为加载完成,true是正在加载
                    console.log('618261')
                    var screenwidth = document.documentElement.clientHeight;
                    if(screenwidth<$('.fc-day-content>div').css('height')){
                        $('..fc-view-basicWeek').css('overflow','auto')
                    }
                    console.log(screenwidth)
                    console.log($('.fc-day-content>div').css('height'))
                }
            },
            events: function(start,end,timezone, callback) {
                var date = this.getDate().format('YYYY-MM');
                $.ajax({
                    url: '/meeting/queryMeeting',
                    dataType: 'json',
                    data: {
                        date: date
                    },
                    success: function(res) { // 获取当前月的数据
                        var datas=res.obj;
                        var events = [];
                        var TColor='';
                        var BColor='';
                        for(var i=0;i<datas.length;i++){
                            // var arr=datas[i].startTime.split(' ');
                            // var arr2= datas[i].endTime.split(' ');
                            var arr=datas[i].startTime.split(' ');
                            var arr3=arr[1].split(':')[0]+':'+arr[1].split(':')[1];
                            var arr2= datas[i].endTime.split(' ');
                            var arr4= arr2[1].split(':')[0]+':'+arr2[1].split(':')[1];
                            if(datas[i].status == 1){
                                BColor='rgb(58, 135, 173)';
                            }else if(datas[i].status == 2){
                                BColor='rgb(105, 240, 164)';
                            }else if(datas[i].status == 3){
                                BColor='rgb(255, 136, 124)';
                            }else if(datas[i].status == 4){
                                BColor='rgb(245, 181, 46)';
                            }else if(datas[i].status == 5){
                                BColor='rgb(219, 173, 255)';
                            }
                            events.push({
                                id:datas[i].sid,
                                title: datas[i].meetRoomName+' '+arr3+'-'+arr4+' '+datas[i].userName,
                                start: arr[0] , // will be parsed
                                textColor: '#fff',
                                backgroundColor:BColor
                            });
                        }
                        callback(events);
                    }
                });
            },
            dayClick:function(date, allDay, jsEvent, view){
                //新增

                var isinsert = false;
                //判断是否可以新增(会议管理人)
                for (var i = 0; i < userIdPriv61.length; i++) {
                    if (userIdPriv61[i] == userId.toString()) {
                        isinsert = true;
                        break;
                    }
                }

                //会议申请人
                for (var i = 0; i < userIdPriv62.length; i++) {
                    if (userIdPriv62[i] == userId.toString()) {
                        isinsert = true;
                        break;
                    }
                }
                //
                if (!isinsert){
                     layer.msg("您不是 教室申请人 或 教室管理员 无法新增会议");
                     return false;
                 }


                //查是否有权限使用提醒
                var timestamp = Date.parse(new Date());
                var timer=parseInt(timestamp)+7200000;
                var startTime=new Date(timestamp).Format('hh:mm:ss');
                var endTime=new Date(timer).Format('hh:mm:ss');
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.ConferenceApplication" />', 'background-color:#2b7fe0;color:#fff;'],
                    // area: ['600px', '460px'],
                    area: ['800px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                    content: '<div class="div_table" style="">' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>主题名称：</span>' +
                        '<span><input type="text" style="width: 54%;margin-left:5px;" name="typeName" class="inputTd meetName test_null" value="" /></span>' +
                        '</div>' +

                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.Applicant" />：</span>' +
                        '<span>' +
                        '<div class="inPole" style="width: 70%;">' +
                        '<textarea name="txt" dataid="" class="userName test_null onlyOne" id="userDuser" user_id="" value="" disabled readonly style="width: 77%;min-height:60px;resize:none;"></textarea>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        <%--'<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span>' +--%>
                        <%--'<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span>' +--%>
                        '</div>' +
                        '</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td">联系电话：</span>'+
                        '<span><input type="text" style="width: 54%;margin-left:5px;" name="typeName"  class="inputTd mobileNo phone" value="" /></span>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr" style="display:none;">' +
                        '<span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span>'+
                        '<span>' +
                        '<div class="inPole" style="width:70%;"><textarea name="txt" dataid="" class="recorderName onlyOne" id="recoderDuser" user_id="" value="" disabled readonly style="width: 77%;min-height:60px;resize:none;"></textarea>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span>'+
                        '</div>' +
                        '</span>' +
                        '</div>' +
                        '<div class="div_tr"><span class="span_td">是否是周期性事务：</span> '+
                        '<span><input style="height: auto; vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="isCycle" class="isCycle" value="1">是</span><span style="margin-left: 10px;"><input style="height:auto;vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="isCycle" class="isCycle" value="0">否</span></div>' +
                        '<div class="div_tr" id="time_div1" style="display:none">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>会议日期：</span>' +
                        '<span style="margin:0 5px;">从</span><span><input type="text" style="width: 140px;" name="cycleStartDate" id="cycleStartDate" class="inputTd startTime test_null" value="'+date._i+'" /></span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                        '<span><input type="text" style="width: 140px;" name="cycleEndDate" class="endTime test_null" id="cycleEndDate" value="'+date._i+'"  /></span>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr time_div0" style="display:none">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>会议时间：</span>' +
                        '<span style="margin:0 5px;">从</span><span><input type="text" style="width: 140px;" name="cycleStartTime" id="cycleStartTime" class="inputTd startTime test_null" value="08:30:00"  /></span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                        '<span><input type="text" style="width: 140px;" name="cycleEndTime" class="endTime test_null" id="cycleEndTime" value="09:00:00" /></span>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr time_div0" style="display:none">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>申请星期：</span>' +
                        '<span id="WEEKEND0" class="WEEKEND" style="display:none"><input type="checkbox" name="W7" value="1" num="7">星期日</span>\n' +
                        '<span id="WEEKEND1" class="WEEKEND" style="display:none"><input type="checkbox" name="W1" value="1" num="1">星期一</span>\n' +
                        '<span id="WEEKEND2" class="WEEKEND" style="display:none"><input type="checkbox" name="W2" value="1" num="2">星期二</span>\n' +
                        '<span id="WEEKEND3" class="WEEKEND" style="display:none"><input type="checkbox" name="W3" value="1" num="3">星期三</span>\n' +
                        '<span id="WEEKEND4" class="WEEKEND" style="display:none"><input type="checkbox" name="W4" value="1" num="4">星期四</span>\n' +
                        '<span id="WEEKEND5" class="WEEKEND" style="display:none"><input type="checkbox" name="W5" value="1" num="5">星期五</span>\n' +
                        '<span id="WEEKEND6" class="WEEKEND" style="display:none"><input type="checkbox" name="W6" value="1" num="6">星期六</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.ConferenceRoom" />：</span>'+
                        '<span><select style="width: 54%;" name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '<span style="margin-left: 10px"><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span>' +
                        '</div>' +
                        '<div class="div_tr" id="time_div2">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.ApplicationTime" />：</span>' +
                        // '<span style="margin:0 5px;">从</span>' +
                        '<span>' +
                        '<span style="margin:0 5px;">从</span><span style="position:relative"><input type="text" style="width: 185px;" name="typeName" id="beginTime" class="inputTd startTime test_null" disabled autocomplete="off"/>' +
                        ' <input type="text"  name="typeName" id="beginTime1" class="inputTd startTime test_null" autocomplete="off"/></span>' +
                        '</span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                        '<span>' +
                        '<span style="position:relative"><input type="text" style="width: 185px;" name="typeName" class="endTime test_null" id="endTime" disabled autocomplete="off"/>' +
                        '<input type="text" style="width: 185px;" name="typeName" class="endTime test_null" id="endTime1" autocomplete="off"/>' +
                        '</span>' +
                        '</span>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr isVideo" style="display:none"><span class="span_td">是否是视频会议：</span> '+
                        '<span><input style="height:auto;margin-top: 2px;vertical-align: text-top;" type="radio" name="isVideo" class="isVideo" value="1" >是</span>' +
                        '<span style="margin-left: 10px;"><input style="height:auto;margin-top: 2px;vertical-align: text-top;"  type="radio" checked="true" name="isVideo" class="isVideo" value="0" >否</span>' +
                        '</div>' +
                        '<div class="div_tr" style="display: none;" >' +
                        '<span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span>' +
                        '<span><select style="width: 54%; " name="typeName" class="managerId" id="managerId" ></select></span>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr" style="display: none;" >' +
                        '<span class="span_td"><fmt:message code="meet.th.external" />:</span><span><div class="inPole" style="width:70%;"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="width: 77%;min-height:58px;resize: vertical;"></textarea></div></span></div>' +
                        '<div class="div_tr" style="display: none;" ><span class="span_td"><fmt:message code="meet.th.internal" />:</span><span><div class="inPole" style="width:70%;">'+
                        '<textarea name="txt" class="attendee" id="attendeeDuser" user_id="" value="" disabled readonly style="width: 77%;min-height:60px;resize:none;"></textarea>'+
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>'+
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                        '<div class="div_tr" style="display: none;"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span><span><div class="inPole" style="width:70%;"><textarea name="txt" id="equipmentId" class="equipmentId" equipmentId="" disabled style="resize:none;width: 77%;min-height:60px;"></textarea></span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="addEquipment" class="addEquipment"><fmt:message code="global.lang.add" /></a></span>'+
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearEquipment" class="clearEquipment"><fmt:message code="global.lang.empty" /></a></div></span></div>' +
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.WriteSchedule" />：</span><span><input type="checkbox" checked="true" id="isWriteCalendar" class="isWriteCalendar"></span><span><fmt:message code="meet.th.Yes" /></span></div>' +
                        '<div class="div_tr" id="reminds"><span class="span_td"><fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind" class="smsRemind"></span><span style="margin-right: 10px;">事务通知</span><span style="display:none"><input type="checkbox" id="sms2Remind" class="sms2Remind"></span><span style="display:none"><fmt:message code="meet.th.SMSReminder" /></span><span style="margin-left: 10px;"><fmt:message code="meet.th.Advance" /></span><input type="text" style="width:30px" name="resendHour" id="resendHour" class="resendHour"><span><fmt:message code="meet.th.hour" /></span><input type="text" style="width:30px" class="resendMinute" id="resendMinute"><span><fmt:message code="meet.th.Reminder" /></span></div>' +
                        '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12">' +
                        '<div class="layui-form-item layui-form-text">\n' +
                        '    <label class="layui-form-label">相关附件:</label>\n' +
                        '<div class="layui-input-block" style="padding-top: 9px">\n' +
                        '            <div id="fileAll" style="    text-align: left;"></div>\n' +
                        '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                        '                <img src="../img/mg11.png" alt="">\n' +
                        '                <span>添加附件</span>\n' +
                        '                <input type="file" multiple id="fileupload" data-url="../upload?module=meeting" name="file">\n' +
                        '            </a>\n' +
                        '        </div>'+
                        '  </div>'+
                        '</div>'+
                        '</div>'+
                        '    </div>\n' +
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span><span><div class="inPole" style="width: 70%;"><textarea name="meetDesc" id="meetDesc" class="meetDesc" value="" style="width: 77%;min-height:60px;resize: vertical;"></textarea></div></span></div>' +
                        '</div>',
                    success: function () {
                        fileuploadFn('#fileupload', $('#fileAll'));
                        // var valueTime1 = data_string2(date._d,1);
                        // var valueTime2 = data_string2(date._d,2);
                        // $('#beginTime').val(valueTime1)
                        // $('.endTime1').val(valueTime2)

                        //判断是否显示视频会议
                        $.ajax({
                            type:'get',
                            url:'/ShowDownLoadQrCode',
                            dataType:'json',
                            success:function(res){
                                if(res.flag){
                                    if(res.object!='0'){
                                        $('#meetRoomId option:last').remove()
                                        $('.isVideo').hide()
                                    }
                                }
                            }
                        })
                        layui.use('laydate', function(){
                            var laydate = layui.laydate;
                            laydate.render({
                                elem: '#beginTime'
                                ,value:date._i
                            });
                        laydate.render({
                            elem: '#beginTime1'
                            ,type: 'time'
                            ,format: 'HH:mm' //可随意组合
                            ,value:'09:00'
                        });
                        laydate.render({
                            elem: '#endTime1'
                            ,type: 'time'
                            ,format: 'HH:mm' //可随意组合
                            ,value:'10:00'
                            ,done: function(value, date, endDate){
                            //判断会议室是否被占用
                            $.get('/meeting/judgeMeeting',{
                                meetRoomId:$('#meetRoomId').val(),
                                startTime:$('#beginTime').val()+' '+$('#beginTime1').val(),
                                endTime:$('#endTime').val()+' '+value
                            },function(res){
                                if(res.code==1){
                                    $.layerMsg({content: res.msg, icon: 0})
                                    return false
                                }
                            })
                        }

                        });
                        laydate.render({
                                elem: '#endTime'
                                ,value:date._i
                                // ,type: 'time'
                                // ,format: 'HH:mm' //可随意组合
                                // ,value:date._i
                                // ,min: new Date().toLocaleString()
                                // ,done: function(value, date, endDate){
                                //     //判断会议室是否被占用
                                //     $.get('/meeting/judgeMeeting',{
                                //         meetRoomId:$('#meetRoomId').val(),
                                //         startTime:$('#beginTime').val(),
                                //         endTime:value
                                //     },function(res){
                                //         if(res.code==1){
                                //             $.layerMsg({content: res.msg, icon: 0})
                                //             return false
                                //         }
                                //     })
                                // }
                            });

                            laydate.render({
                                elem: '#cycleStartDate'
                                ,done: function(value, date){
                                    week_select()
                                }
                            });
                            laydate.render({
                                elem: '#cycleEndDate'
                                ,done: function(value, date){
                                    week_select()
                                }
                            });

                            //时间选择器
                            laydate.render({
                                elem: '#cycleStartTime'
                                ,type: 'time'
                            });
                            laydate.render({
                                elem: '#cycleEndTime'
                                ,type: 'time'
                            });
                        })


                        $.ajax({
                            url: '/Meetequipment/getuser',
                            type: 'get',
                            dataType: 'json',
                            success: function (res) {
                                $('#userDuser').attr('user_id',res.object.userId+',');
                                $('#userDuser').attr('dataid',res.object.uid+',');
                                $('#userDuser').val(res.object.userName+',');
                                //自动获取当前登录人手机号
                                $('.mobileNo').val(res.object.mobilNo)
                            }
                        })

                        $('input[name="isCycle"]').click(function () {
                            if($(this).val()=='1'){
                                $('#time_div2').css("display","none")
                                //隐藏后移除必填类
                                $('#beginTime').removeClass('test_null')
                                $('#endTime').removeClass('test_null')
                                $('#time_div1').css("display","block")
                                $('.time_div0').css("display","block")
                                week_select()

                            } else {
                                $('#time_div2').css("display","block")
                                //显示后添加必填类
                                $('#beginTime').addClass('test_null')
                                $('#endTime').addClass('test_null')
                                $('#time_div1').css("display","none")
                                $('.time_div0').css("display","none")
                            }
                        });

                        //会议室
                        initMeetRoom();

                        $('#meetRoomId').change(function(){
                            var opvalue=$(this).val();
                            if (opvalue==='0'){
                                $("input[name='isVideo']").each(function(index,item){
                                    $(this).prop("disabled",true);
                                    if(index===0){
                                        $(this).prop("checked",true);
                                    }
                                });
                            }else{
                                //initManager($(this).val());
                                $("input[name='isVideo']").each(function(){
                                    $(this).prop("disabled",false);
                                });
                                initManager(opvalue)
                            }
                        });

                        if(!$('#meetRoomId').val()){
                            layer.msg('没有可用的会议室，请联系管理员！', { icon:0});
                            return false
                        }

                        initManager($('#meetRoomId').val());

                        //点击会议室名称显示会议室详情
                        $('.meetRoomDetail').click(function (){
                            var ismeetRoom=$('#meetRoomId').val();
                            if(ismeetRoom==='0'){
                                $.layerMsg({content:"暂无会议室详情",icon:2});
                                return false;
                            }
                            $.ajax({
                                url: '/meetingRoom/getMeetRoomBySid',
                                type: 'get',
                                dataType: 'json',
                                data: {
                                    sid: $(".meetRoomId").val()
                                },
                                success: function (obj) {
                                    if(obj.flag==true){
                                        var data=obj.object;
                                        var meetList=data.meetingWithBLOBs;
                                        var str= '<div class="table"><table style="margin:auto;">' +
                                            '<tr><td width="20%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span></td><td><span>'+data.mrName+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span></td><td><span>'+data.mrDesc+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span></td><td><span>'+data.managetnames+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span></td><td><span>'+data.meetroomdeptName+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.Application" />：</span></td><td><span>'+data.meetroompersonName+'</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span></td><td><span>'+data.mrCapacity+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span></td><td><span>'+data.mrDevice+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="depatement.th.address" />：</span></td><td><span>'+data.mrPlace+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicationRecord" />：</span></td>' +
                                            '<td>' +
                                            '<table>' +
                                            '<tr>' +
                                            '<td><fmt:message code="meet.th.ConferenceName" /></td>' +
                                            '<td><fmt:message code="sup.th.Applicant" /></td>' +
                                            '<td><fmt:message code="sup.th.startTime" /></td>' +
                                            '<td><fmt:message code="meet.th.EndTime" /></td>' +
                                            '<td><fmt:message code="notice.th.state" /></td>' +
                                            '<tr>';
                                        for(var i=0;i<meetList.length;i++){
                                            str+='<tr>' +
                                                '<td>'+meetList[i].meetName+'</td>' +
                                                '<td>'+meetList[i].userName+'</td>' +
                                                '<td>'+meetList[i].startTime+'</td>' +
                                                '<td>'+meetList[i].endTime+'</td>' +
                                                '<td>'+meetList[i].statusName+'</td>' +
                                                '<td>'+meetList[i].statusName+'</td>' +
                                                '</tr>'
                                        }
                                        str+='</table></td></tr>'+
                                            '</table></div>';
                                        layer.open({
                                            type: 1,
                                            title: ['<fmt:message code="meet.th.SeeDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                            area: ['900', '460px'],
                                            offset: ['60px', '200px'],
                                            shadeClose: true, //点击遮罩关闭
                                            btn: [ '<fmt:message code="global.lang.close" />'],
                                            content: str
                                        })
                                    }else{
                                        $.layerMsg({content:"暂无会议室详情",icon:2});
                                    }
                                }
                            })
                        })

                        //是否有权限使用事务、短信提醒
                        $.ajax({
                            type:'get',
                            url:'/smsRemind/getRemindFlag',
                            dataType:'json',
                            data:{
                                type:8
                            },
                            success:function (res) {
                                if(res.flag){
                                    if(res.obj.length>0){
                                        var data = res.obj[0];
                                        // 是否默事务提醒认发送
                                        if(data.isRemind=='0'){
                                            $('.smsRemind').prop("checked", false);
                                        }else if(data.isRemind=='1'){
                                            $('.smsRemind').prop("checked", true);
                                        }
                                        // 是否手机短信默认提醒
                                        if(data.isIphone=='0'){
                                            $('.sms2Remind').prop("checked", false);
                                        } else if (data.isIphone=='1'){
                                            $('.sms2Remind').prop("checked", true);
                                        }
                                        // 是否允许发送事务提醒
                                        if(data.isCan=='0'){
                                            $('#reminds').hide();
                                            $('.smsRemind').prop("checked", false);
                                            $('.sms2Remind').prop("checked", false);
                                            // $('.remind').parent('tr').hide();

                                        }

                                    }
                                }
                            }
                        })

                    },
                    yes: function (index) {

                        // // 判断手机号码
                        // if($('.phone').val()!=''){
                        //     if(!(/^1[34578]\d{9}$/.test($('.phone').val()))){
                        //         $.layerMsg({content:'手机号格式错误'});
                        //         return false;
                        //     }
                        // }
                        //判断开始时间和结束时间为同一天
                        var first =  $('#beginTime').val();
                        var second = $('#endTime ').val()
                        var data1 = Date.parse(first.replace(/-/g,   "/"));
                        var data2 = Date.parse(second.replace(/-/g,   "/"));
                        var datadiff = data2-data1;
                        var time = 1*24*60*60*1000;
                        if(first.length>0 && second.length>0) {
                            if (datadiff < 0 || datadiff > time) {
                                layer.msg("结束时间应和开始时间为同一天",{icon:2});
                                return false;
                            }
                        }
                        var array=$(".test_null");
                        var attendId='';
                        var attendName='';
                        <%--for(var i=0;i<array.length;i++){--%>
                            <%--if(array[i].value==""){--%>
                                <%--$.layerMsg({content:"<fmt:message code="sup.th.With*" />",icon:2},function(){--%>
                                <%--});--%>
                                <%--return;--%>
                            <%--}--%>
                        <%--}--%>
                        for(var i=0;i<$('.onlyOne').length;i++){
                            if($('.onlyOne').eq(i).val().split(',').length>2){
                                $.layerMsg({content:$('.onlyOne').eq(i).parent().parent().prev().text().substr(0,$('.onlyOne').eq(i).parent().parent().prev().text().length-1)+'只能选一个！',icon:2},function(){
                                });
                                return;
                            }
                        }

                        var isWriteCalednar=0;
                        if($('#isWriteCalendar').is(':checked')){
                            isWriteCalednar=1;
                        }
                        var smsRemind=0;

                        if($('#smsRemind').is(':checked')){
                            smsRemind=1;
                        }
                        var sms2Remind=0;
                        if($('#sms2Remind').is(':checked')){
                            sms2Remind=1;
                        }
                        var recoder=$(".recorderName").attr("dataid");
                        if(recoder!=""){
                            var recorderId=recoder.substr(0,recoder.length-1);
                        }
                        var uidId=$(".userName").attr("dataid");
                        if(uidId!=""){
                            var uid=uidId .substr(0,uidId.length-1);
                        }
                        // for(var i=0;i<$('.Attachment .inHidden').length;i++){
                        //     attendId += $('.Attachment .inHidden').eq(i).val();
                        // }
                        // for(var i=0;i<$('.Attachment .inHidden').length;i++){
                        //     attendName += $('.Attachment a').eq(i).attr('NAME');
                        // }
                        var attendId = '';
                        var attendName = '';
                        for (var i = 0; i < $('#fileAll .dech').length; i++) {
                            attendId += $('#fileAll .dech').eq(i).find('input').val();
                            attendName += $('#fileAll a').eq(i).attr('name');
                        }

                        var cycleStartDate = $('#cycleStartDate').val();
                        var cycleEndDate = $('#cycleEndDate').val();
                        var cycleStartTime = $('#cycleStartTime').val();
                        var cycleEndTime = $('#cycleEndTime').val();
                        var cycleWeek = '';
                        if($('.isCycle:checked').val() == '0'){
                            cycleStartDate = '',cycleEndDate = '',cycleStartTime = '',cycleEndTime = '';
                        }else{
                            var $thisweek = $('.WEEKEND input[type=checkbox]:checked');
                            for(var i=0;i<$thisweek.length;i++){
                                if(i == $thisweek.length -1){
                                    cycleWeek += $thisweek.eq(i).attr('num');
                                }else{
                                    cycleWeek += $thisweek.eq(i).attr('num')+',';
                                }
                            }
                        }
                        //开始时间必须大于当前时间
                        if($('#time_div2').css('display')!='none'){
                            var ddYest=dateYest()
                            if($("#beginTime").val()<=ddYest){
                                $.layerMsg({content:'申请时间的开始时间请选择今天以后的时间!', icon: 0})
                                return;
                            }
                            if(new Date($("#beginTime").text())<new Date()){
                                $.layerMsg({content:"开始时间必须大于当前时间",icon:2},function(){
                                });
                                return;
                            }
                            //结束时间必须大于开始时间
                            if($("#beginTime").val()>$("#endTime").val()){
                                $.layerMsg({content:"结束时间必须大于开始时间",icon:2},function(){
                                });
                                return;
                            }
                        }

                        var userDuser = $("#userDuser").attr('dataid');
                        var paraData = {
                            mobileNo:$('.mobileNo').val(),
                            cycle:$('.isCycle:checked').val(),
                            cycleStartDate:cycleStartDate,
                            cycleEndDate:cycleEndDate,
                            cycleStartTime:cycleStartTime,
                            cycleEndTime:cycleEndTime,
                            cycleWeek:cycleWeek,
                            meetName: $(".meetName").val(),
                            subject: $(".meetName").val(),
                            uid: uid,
                            recorderId:recorderId,
                            startTime: $("#beginTime").val() + ' ' + $("#beginTime1").val() + ':00',
                            endTime: $("#endTime").val() + ' ' + $("#endTime1").val()+':00',
                            attendeeOut: $(".attendeeOut").val(),
                            attendee: $(".attendee").attr("dataid"),
                            isWriteCalednar: isWriteCalednar,
                            smsRemind: smsRemind,
                            sms2Remind: sms2Remind,
                            resendHour: $(".resendHour").val(),
                            resendMinute: $(".resendMinute").val(),
                            meetDesc: $(".meetDesc").val(),
                            managerId: userDuser.substring(0,userDuser.length-1),
                            meetRoomId: $("#meetRoomId").val(),
                            meetRoomName:$("#meetRoomId").find("option:selected").text(),
                            equipmentNames: $(".equipmentId").val(),
                            equipmentIds: $(".equipmentId").attr("equipmentId"),
                            attachmentId:attendId,
                            attachmentName:attendName,
                            videoConfFlag:$('.isVideo:checked').val(),
                            status:2
                        }

                        $.ajax({
                            url: '/meeting/PTinsertMeeting',
                            type: 'post',
                            dataType: 'json',
                            data: paraData,
                            success: function (obj) {
                                if (obj.flag) {
                                    if(obj.msg=="申请成功"){
                                        $.layerMsg({content: '<fmt:message code="sup.th.SuccessfulApplication" />！', icon: 1}, function () {
                                            //更新列表
                                            listByStatus(queryStatus);
                                        })
                                        location.reload();
                                        layer.close(index);
                                    }
                                }else{
                                    alert('<fmt:message code="meet.th.Occupied" />');
                                }
                            }
                        })
                    }
                });
                //删除附件
                $(document).on('click','.deImgs',function(){
                    var data=$(this).parents('.dech').attr('deUrl');
                    var dome=$(this).parents('.dech');
                    deleteChatment(data,dome);
                })
                $('#uploadinputimg').fileupload({
                    dataType:'json',
                    done: function (e, data) {
                        if(data.result.obj != ''){
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:5px;vertical-align: text-bottom;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                            }
                            $('.Attachment').append(str);
                        }else{
                            //alert('添加附件大小不能为空!');
                            layer.alert('添加附件大小不能为空!',{},function(){
                                layer.closeAll();
                            });
                        }
                    }
                });

                //查询所有办公设备
                var equipStr='';
                $.ajax({
                    url: '/Meetequipment/getAllEquiet',
                    type: 'get',
                    dataType: 'json',
                    success: function (obj) {
                        var data=obj.obj;
                        for(var i=0;i<data.length;i++){
                            equipStr+='<tr><td class="equipClick" equipmentid="'+data[i].sid+'">'+data[i].equipmentName+'</td></tr>';
                        }
                    }
                })
                //选择办公设备控件
                $(".addEquipment").click(function(){
                    layer.open({
                        type: 1,
                        title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['300px', '500px'],
                        offset: ['30px', '400px'],
                        shadeClose: true, //点击遮罩关闭
                        btn: ['<fmt:message code="global.lang.ok" />'],
                        content:'<table class="equip">' +
                            '<tr><td><span><fmt:message code="meet.th.SelectDevice" /></span></td></tr>'+
                            '<tr><td id="addAll"><span><fmt:message code="meet.th.addAll" /></span></td></tr>'+
                            '<tr><td id="delAll"><span><fmt:message code="meet.th.DeleteAll" /></span></td></tr>'+
                            equipStr+
                            '</table>',
                        success:function(){
                            $(".equipClick").click(function(){
                                $(this).toggleClass('equipSpan');
                            })
                            $("#addAll").click(function(){
                                $(".equipClick").addClass('equipSpan');
                            })
                            $("#delAll").click(function(){
                                $(".equipClick").removeClass('equipSpan');
                            })
                        },
                        yes:function(index){
                            var equipSpanArray=$(".equipSpan");
                            var equipId="";
                            var equipName="";
                            for(var i=0;i<equipSpanArray.length;i++){
                                equipName+=$(equipSpanArray[i]).html()+",";
                                equipId+=$(equipSpanArray[i]).attr("equipmentid")+",";
                            }
                            $(".equipmentId").attr("equipmentId",equipId);
                            $(".equipmentId").val(equipName);
                            layer.close(index);
                        }

                    })
                })
                $(".clearEquipment").click(function(){
                    $(".equipmentId").attr("equipmentId","");
                    $(".equipmentId").val("");
                })

            },
            eventClick:function(calEvent){

                //编辑
                var sid=calEvent.id;
                console.log(calEvent)

                // var leet = getNextDate(calEvent.start._i)
                var leet = calEvent.start._i
                var myDate = new Date();
                var newTime = data_string(myDate)
                var newTime2 = newTime.split(' ')[0]
                var leet2 = parserDate(leet)
                var newTime3 = parserDate(newTime2)
                layer.open({
                    type: 1,
                    title:['<fmt:message code="meet.th.Editorial" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['800px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn:  ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />','删除'],
                    content: '<div class="div_table" style="margin-left: 15px;">' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>主题<fmt:message code="workflow.th.name" />：</span><span><input type="text" style="width: 54%;margin-left:5px;" name="typeName" class="inputTd meetName test_null" value="" /></span></div>'+

                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.Applicant" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" class="userName test_null onlyOne" id="userDuser" user_id="" dataid="" value="" disabled style="width: 77%;min-height:60px;resize: none"></textarea></div></span></div>'+ //<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span>
                        '<div class="div_tr"><span class="span_td">联系电话：</span>' +
                        '<span>' +
                        '<input style="width:54%;margin-left:5px;" type="text" name="typeName" readonly="readonly"  class="inputTd mobileNo  phones" value=""  onclick="laydate({istime: true, format: "YYYY-MM-DD hh:mm:ss"})">'+
                        // '<input type="text" style="width:54%;margin-left:5px;"  name="typeName" class="inputTd mobileNo  phones" value="" /></span>' +
                        '</div>'+
                        '<div class="div_tr" style="display:none;"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span><span><div class="inPole" style="width: 70%;"><textarea name="txt" class="recorderName onlyOne" id="recoderDuser" user_id="" dataid="" value="" disabled style="width: 77%;min-height:60px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.ConferenceRoom" />：</span><span><select style="width: 54%;" name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span><span style="margin-left: 10px;"><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span></div>'+
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.ApplicationTime" />：</span><span style="margin:0 5px;">从</span>：<span style="position:relative">'+
                        '<input style="width: 180px" type="text" name="typeName" id="beginTime" readonly="readonly" class="inputTd startTime test_null endTime2" disabled>' +
                        '<input type="text"  name="typeName" id="editstartTime" class="inputTd  test_null" autocomplete="off"/>' +
                        '</span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>'+
                        '<span style="position:relative"><input style="width: 180px" type="text" name="typeName" id="endTime" readonly="readonly" class="endTime1 endTime test_null" disabled>' +
                        '<input type="text"  name="typeName" id="editendTime" class="inputTd  test_null" autocomplete="off"/>' +
                        '</span>' +
                        '</div>' +
                        '<div class="div_tr isVideo" style="display:none"><span class="span_td">是否是视频会议：</span> '+
                        '<span><input style="height:auto;margin-top: 2px;vertical-align: text-top;" type="radio" name="isVideo" class="isVideo" value="1" >是</span>' +
                        '<span style="margin-left: 10px;"><input style="height:auto;margin-top: 2px;vertical-align: text-top;"  type="radio" checked="true" name="isVideo" class="isVideo" value="0" >否</span>' +
                        '</div>' +
                        '<div class="div_tr" ><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span><span><select style="width: 40%;" name="typeName" class="managerId" id="managerId"></select><input type="hidden" id="isOld"></span></div>'+
                        '<div class="div_tr" style="display:none;"><span class="span_td" style="display:none;"><fmt:message code="meet.th.external" />：</span><span><div class="inPole" style="width:70%;"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="width:77%;min-height:58px;resize:vertical"></textarea></div></span></div>'+
                        '<div class="div_tr" style="display:none;"><span class="span_td"><fmt:message code="meet.th.internal" />：</span><span><div class="inPole" style="width:70%;"><textarea name="txt" class="attendee" id="attendeeDuser" user_id="" value="" disabled style="width: 77%;min-height:60px;resize: none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
                        '<div class="div_tr" style="display:none;"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span><span><div class="inPole" style="width:70%;"><textarea name="txt" id="equipmentId" class="equipmentId" equipmentId="" disabled style="width: 77%;min-height:60px;resize:none;"></textarea></span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="addEquipment" class="addEquipment"><fmt:message code="global.lang.add" /></a></span>'+
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearEquipment" class="clearEquipment"><fmt:message code="global.lang.empty" /></a></div></span></div>' +                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.WriteSchedule" />：</span><span><input type="checkbox" id="isWriteCalendar" class="isWriteCalendar"></span><span><fmt:message code="meet.th.Yes" /></span></div>'+
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind" class="smsRemind"></span><span style="margin-right: 10px;">事务通知</span><span style="display:none"><input type="checkbox" id="sms2Remind" class="sms2Remind"></span><span style="display:none"><fmt:message code="meet.th.SMSReminder" /></span><span style="margin-left: 10px;"><fmt:message code="meet.th.Advance" /></span><input type="text" style="width:30px" name="resendHour" id="resendHour" class="resendHour"><span><fmt:message code="meet.th.hour" /></span><input type="text" style="width:30px" class="resendMinute" id="resendMinute"><span><fmt:message code="meet.th.Reminder" /></span></div>'+
                        <%--'<div class="div_tr"><span class="span_td" style="text-align: right"><fmt:message code="sup.th.RelatedAccessories" />：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +--%>
                        <%--'<form id="uploadimgform" target="uploadiframe"  action="../upload?module=meeting" enctype="multipart/form-data" method="post" >'+--%>
                        <%--'<input type="file" name="file" id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +--%>
                        <%--'<a href="javascript:;" id="uploadimg">' +--%>
                        <%--'<img style="margin-right:5px;vertical-align: middle;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+--%>
                        <%--'</form></div></span></div>'+--%>
                        '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12">' +
                        '<div class="layui-form-item layui-form-text">\n' +
                        '    <label class="layui-form-label">相关附件:</label>\n' +
                        '<div class="layui-input-block" style="padding-top: 9px">\n' +
                        '            <div id="fileAll" style="    text-align: left;"></div>\n' +
                        '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                        '                <img src="../img/mg11.png" alt="">\n' +
                        '                <span>添加附件</span>\n' +
                        '                <input type="file" multiple id="fileupload" data-url="../upload?module=meeting" name="file">\n' +
                        '            </a>\n' +
                        '        </div>'+
                        '  </div>'+
                        '</div>'+
                        '</div>'+
                        '    </div>\n' +
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span><span><div class="inPole" style="width:70%;"><textarea name="meetDesc" id="meetDesc" class="meetDesc" value="" style="width: 77%;min-height:60px;resize:vertical"></textarea></div></span></div>'+
                        '</div>',
                    success:function(){
                        fileuploadFn('#fileupload', $('#fileAll'));
                        //判断是否显示视频会议
                        $.ajax({
                            type:'get',
                            url:'/ShowDownLoadQrCode',
                            dataType:'json',
                            success:function(res){
                                if(res.flag){
                                    if(res.object!='0'){
                                        $('#meetRoomId option:last').remove()
                                        $('.isVideo').hide()
                                    }
                                }
                            }
                        });

                        //会议室选择下拉初始化
                        initMeetRoom();
                        $('#meetRoomId').change(function(){
                            var opvalue=$(this).val();
                            if (opvalue==='0'){
                                $("input[name='isVideo']").each(function(index,item){
                                    $(this).prop("disabled",true);
                                    if(index===0){
                                        $(this).prop("checked",true);
                                    }
                                });
                            }else{
                                //initManager($(this).val());
                                $("input[name='isVideo']").each(function(){
                                    $(this).prop("disabled",false);
                                });
                                initManager(opvalue)
                            }
                        })

                        //审批管理员
                        initManager($('#meetRoomId').val());

                        //回显接口
                        $.ajax({
                            url:'/meeting/queryMeetingById',
                            type:'get',
                            dataType:'json',
                            data:{
                                sid:sid
                            },
                            success:function(obj){
                                var data=obj.object;
                                var str='';
                                <%--if(data.attachmentList.length>0){--%>
                                    <%--for(var i=0;i<data.attachmentList.length;i++){--%>
                                        <%--str+='<div class="dech" deUrl="'+data.attachmentList[i].attUrl+'"><a href="/download?'+data.attachmentList[i].attUrl+'" NAME="'+data.attachmentList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.attachmentList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.attachmentList[i].aid+'@'+data.attachmentList[i].ym+'_'+data.attachmentList[i].attachId+',"></div>';--%>
                                    <%--}--%>
                                <%--}else{--%>
                                    <%--str='';--%>
                                <%--}--%>
                                if(data.attachmentList.length>0){
                                    var  attachmentList = data.attachmentList
                                    if(attachmentList !=undefined && attachmentList.length>0){
                                        for(var i=0;i<attachmentList.length;i++){
                                            str+='<div class="dech" deUrl="' +attachmentList[i].attUrl + '"><a href="/download?' + attachmentList[i].attUrl + '" NAME="' + attachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + attachmentList[i].aid + '@' + attachmentList[i].ym + '_' + attachmentList[i].attachId +',"></div>'
                                        }
                                    }else{
                                        str='';
                                    }
                                    $('#fileAll').html(str)
                                }
                                //如果当前登陆人 不是创建人  就不可以编辑   ，如果  不是会议管理人不可以编辑
                                if ( data.uid != uId ){
                                    $("input").attr("disabled","true");
                                    $("select").attr("disabled","true");
                                    $("textarea").attr("disabled","true");
                                    $(".add").css("display","none");
                                    $(".selectAttenddee").css("display","none");
                                    $(".addEquipment").css("display","none");
                                    $("#uploadimg").css("display","none");
                                    $(".clearAttendee ").css("display","none");
                                    $(".clearRecoder ").css("display","none");
                                    $(".clearUser  ").css("display","none");
                                    $(".clearEquipment  ").css("display","none");
                                }


                                $(".meetName").val(data.meetName);
                                $(".mobileNo").val(data.mobileNo);
                                $(".subject").val(data.subject);
                                $(".userName").val(data.userName);
                                $(".userName").attr("dataid",data.uid);
                                $(".userName").attr("user_id",data.userId);
                                $(".recorderName").val(data.recorderName);
                                $(".recorderName").attr("dataid",data.recorderId);
                                $(".recorderName").attr("user_id",data.recorderUserId);
                                // $(".startTime").val(data.startTime);
                                // $(".endTime").val(data.endTime);
                                $(".startTime").val(data.startTime.substr(0,10));
                                $(".endTime").val(data.endTime.substr(0,10));
                                $("#editstartTime").val(data.startTime.substr(11,5));
                                $("#editendTime").val(data.endTime.substr(11,5));

                                $(".attendeeOut").val(data.attendeeOut);
                                $(".attendee").val(data.attendeeName);
                                $(".attendee").attr("dataid",data.attendee);
                                $(".attendee").attr("user_id",data.attendeeUserId);
                                /*$(".equipmentId").val()*/
                                if(data.isWriteCalednar==1){
                                    $(".isWriteCalendar").attr("checked",true);
                                }
                                if(data.smsRemind==1){
                                    $(".smsRemind").attr("checked",true)
                                }
                                if(data.sms2Remind==1){
                                    $(".sms2Remind").attr("checked",true);
                                }
                                $(".resendHour").val(data.resendHour);
                                $(".resendMinute").val(data.resendMinute);
                                $(".meetDesc").val(data.meetDesc);
                                //会议室
                                $("#meetRoomId").val(data.meetRoomId);
                                $("input[name='isVideo']").each(function(index,item){
                                    if(data.meetRoomId===0){
                                        $(this).prop("disabled",true);
                                        if(index===0){
                                            $(this).prop("checked",true);
                                        }
                                    }else{
                                        if(Number(data.videoConfFlag)===index){
                                            $(this).prop("checked",false);
                                        }else{
                                            $(this).prop("checked",true);

                                        }
                                    }
                                });

                                //审批管理员
                                $("#managerId").val(data.managerId);
                                $('#isOld').val(data.managerId)
                                laydate.render({
                                    elem: '#editstartTime'
                                    ,type: 'time'
                                    ,format: 'HH:mm' //可随意组合
                                });
                                laydate.render({
                                    elem: '#editendTime'
                                    ,type: 'time'
                                    ,format: 'HH:mm' //可随意组合
                                    ,done: function(value, date, endDate){
                                        //判断会议室是否被占用
                                        $.get('/meeting/judgeMeeting',{
                                            meetRoomId:$('#meetRoomId').val(),
                                            startTime:$('.startTime').val()+' '+$('#editstartTime').val(),
                                            endTime:$(".endTime").val()+' '+value
                                        },function(res){
                                            if(res.code==1){
                                                $.layerMsg({content: res.msg, icon: 0})
                                                return false
                                            }
                                        })
                                    }
                                });
                                // laydate.render({
                                //     elem: '.startTime'
                                //     ,type: 'datetime'
                                //     ,format: 'yyyy-MM-dd HH:mm'
                                // });
                                // laydate.render({
                                //     elem: '.endTime'
                                //     ,type: 'datetime'
                                //     ,format: 'yyyy-MM-dd HH:mm'
                                //     ,done: function(value, date, endDate){
                                //         //判断会议室是否被占用
                                //         $.get('/meeting/judgeMeeting',{
                                //             meetRoomId:$('#meetRoomId').val(),
                                //             startTime:$('.startTime').val(),
                                //             endTime:value
                                //         },function(res){
                                //             if(res.code==1){
                                //                 $.layerMsg({content: res.msg, icon: 0})
                                //                 return false
                                //             }
                                //         })
                                //     }
                                // });
                            }
                        });

                        //点击会议室名称显示会议室详情
                        $('.meetRoomDetail').click(function (){
                            var ismeetRoom=$('#meetRoomId').val();
                            if(ismeetRoom==='0'){
                                $.layerMsg({content:"暂无会议室详情",icon:2});
                                return false;
                            }

                            $.ajax({
                                url: '/meetingRoom/getMeetRoomBySid',
                                type: 'get',
                                dataType: 'json',
                                data: {
                                    sid: $(".meetRoomId").val()
                                },
                                success: function (obj) {
                                    if(obj.flag){
                                        var data=obj.object;
                                        var meetList=data.meetingWithBLOBs;
                                        var str= '<div class="table"><table style="margin:auto;">' +
                                            '<tr><td width="20%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span></td><td><span>'+data.mrName+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span></td><td><span>'+data.mrDesc+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span></td><td><span>'+data.managetnames+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span></td><td><span>'+data.meetroomdeptName+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.Application" />：</span></td><td><span>'+data.meetroompersonName+'</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span></td><td><span>'+data.mrCapacity+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span></td><td><span>'+data.mrDevice+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="depatement.th.address" />：</span></td><td><span>'+data.mrPlace+'</span></td></tr>'+
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicationRecord" />：</span></td>' +
                                            '<td>' +
                                            '<table>' +
                                            '<tr>' +
                                            '<td><fmt:message code="meet.th.ConferenceName" /></td>' +
                                            '<td><fmt:message code="sup.th.Applicant" /></td>' +
                                            '<td><fmt:message code="sup.th.startTime" /></td>' +
                                            '<td><fmt:message code="meet.th.EndTime" /></td>' +
                                            '<td><fmt:message code="notice.th.state" /></td>' +
                                            '<tr>';
                                        for(var i=0;i<meetList.length;i++){
                                            str+='<tr>' +
                                                '<td>'+meetList[i].meetName+'</td>' +
                                                '<td>'+meetList[i].userName+'</td>' +
                                                '<td>'+meetList[i].startTime+'</td>' +
                                                '<td>'+meetList[i].endTime+'</td>' +
                                                '<td>'+meetList[i].statusName+'</td>' +
                                                '</tr>'
                                        }
                                        str+='</table></td></tr>'+
                                            '</table></div>';
                                        layer.open({
                                            type: 1,
                                            title: ['<fmt:message code="meet.th.SeeDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                            area: ['900', '500px'],
                                            shadeClose: true, //点击遮罩关闭
                                            btn: [ '<fmt:message code="global.lang.close" />'],
                                            content: str
                                        })
                                    }else{
                                        $.layerMsg({content:"暂无会议室详情",icon:2},function(){
                                        });
                                    }
                                }
                            })


                        })

                        $(document).on('click','.deImgs',function(){
                            var data=$(this).parents('.dech').attr('deUrl');
                            var dome=$(this).parents('.dech');
                            deleteChatment(data,dome);
                        })
                    },
                    yes:function(index){

                        if(newTime3 > leet2){
                            layer.msg('历史预订的教室信息不能修改！', {icon: 1});
                            return false
                        }
                        // // 判断手机号码
                        // if($('.phones').val()!=''){
                        //     if(!(/^1[34578]\d{9}$/.test($('.phones').val()))){
                        //         $.layerMsg({content:'手机号格式错误'});
                        //         return false;
                        //     }
                        // }
                        //判断开始时间和结束时间为同一天
                        var first =  $('#beginTime').val();
                        var second = $('#endTime ').val()
                        var data1 = Date.parse(first.replace(/-/g,   "/"));
                        var data2 = Date.parse(second.replace(/-/g,   "/"));
                        var datadiff = data2-data1;
                        var time = 1*24*60*60*1000;
                        if(first.length>0 && second.length>0) {
                            if (datadiff < 0 || datadiff > time) {
                                layer.msg("结束时间应和开始时间为同一天",{icon:2});
                                return false;
                            }

                        }

                        var array=$(".test_null");
                        for(var i=0;i<array.length;i++){
                            if(array[i].value==""){
                                $.layerMsg({content:"<fmt:message code="sup.th.With*" />",icon:2},function(){
                                });
                                return;
                            }
                        }
                        for(var i=0;i<$('.onlyOne').length;i++){
                            if($('.onlyOne').eq(i).val().split(',').length>2){
                                $.layerMsg({content:$('.onlyOne').eq(i).parent().parent().prev().text().substr(0,$('.onlyOne').eq(i).parent().parent().prev().text().length-1)+'只能选一个！',icon:2},function(){
                                });
                                return;
                            }
                        }
                        var isWriteCalednar=0;
                        var attendId='';
                        var attendName='';
                        if($('#isWriteCalendar').is(':checked')){
                            isWriteCalednar=1;
                        }
                        var smsRemind=0;

                        if($('#smsRemind').is(':checked')){
                            smsRemind=1;
                        }
                        var sms2Remind=0;
                        if($('#sms2Remind').is(':checked')){
                            sms2Remind=1;
                        }
                        var recorderId=$(".recorderName").attr("dataid");
                        if(recorderId!="" && recorderId.indexOf(",") >= 0){
                            recorderId=recorderId.substr(0,recorderId.length-1);
                        }
                        var uid=$(".userName").attr("dataid");
                        if(uid!="" && uid.indexOf(",") >= 0 ){
                            uid=uid .substr(0,uid.length-1);
                        }
                        for(var i=0;i<$('.Attachment .inHidden').length;i++){
                            attendId += $('.Attachment .inHidden').eq(i).val();
                        }
                        for(var i=0;i<$('.Attachment .inHidden').length;i++){
                            attendName += $('.Attachment a').eq(i).attr('NAME');
                        }
                        var paraData={
                            sid:sid,
                            meetName: $(".meetName").val(),
                            mobileNo: $(".mobileNo").val(),
                            subject:$(".meetName").val(),
                            uid: uid,
                            recorderId:recorderId,
                            startTime: $("#beginTime").val() + ' ' + $("#beginTime1").val() + ':00',
                            endTime: $("#endTime").val() + ' ' + $("#endTime1").val()+':00',
                            attendeeOut:$(".attendeeOut").val(),
                            attendee:$(".attendee").attr("dataid"),
                            isWriteCalednar:isWriteCalednar,
                            smsRemind:smsRemind,
                            sms2Remind:sms2Remind,
                            resendHour:$(".resendHour").val(),
                            resendMinute:$(".resendMinute").val(),
                            meetDesc:$(".meetDesc").val(),
                            managerId:$("#managerId").val(),
                            meetRoomId:$("#meetRoomId").val(),
                            equipmentNames:$(".equipmentId").val(),
                            equipmentIds:$(".equipmentId").attr("equipmentId"),
                            attachmentId:attendId,
                            attachmentName:attendName,
                            videoConfFlag:$('.isVideo:checked').val()
                        }

                        $.ajax({
                            url: '/meeting/updateMeetingById',
                            type: 'get',
                            dataType: 'json',
                            data: paraData,
                            success: function (obj) {
                                if(obj.flag){
                                    $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1},function() {
                                        //更新列表
                                        listByStatus(queryStatus);
                                    })
                                    location.reload();
                                    layer.close(index);
                                }
                            }
                        })
                        layer.close(index);
                    }
                    ,btn3: function(index, layero){
                        var user_id = $('#userDuser').attr('dataid');

                        if ( user_id != uId ){
                            return false;
                        }
                        $.layerConfirm({title:'删除会议',content:'确定删除所选记录,删除后将不可恢复！',icon:0},function(){
                            $.ajax({
                                url:'/meeting/delMeetingById',
                                type:'get',
                                dataType:'json',
                                data:{
                                    sid:sid
                                },
                                success:function(obj){
                                    location.reload();
                                }
                            });
                        })
                    }
                });
                $(document).on('click','.deImgs',function(){
                    var data=$(this).parents('.dech').attr('deUrl');
                    var dome=$(this).parents('.dech');
                    deleteChatment(data,dome);
                })
                $('#uploadinputimg').fileupload({
                    dataType:'json',
                    done: function (e, data) {
                        if(data.result.obj != ''){
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                            }
                            $('.Attachment').append(str);
                        }else{
                            //alert('添加附件大小不能为空!');
                            layer.alert('添加附件大小不能为空!',{},function(){
                                layer.closeAll();
                            });
                        }
                    }
                });
                //查询所有办公设备
                var equipStr='';
                $.ajax({
                    url: '/Meetequipment/getAllEquiet',
                    type: 'get',
                    dataType: 'json',
                    success: function (obj) {
                        var data=obj.obj;
                        for(var i=0;i<data.length;i++){
                            equipStr+='<tr><td class="equipClick" equipmentid="'+data[i].sid+'">'+data[i].equipmentName+'</td></tr>';
                        }
                    }
                })
                //选择办公设备控件
                $(".addEquipment").click(function(){
                    layer.open({
                        type: 1,
                        title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['300px', '500px'],
                        shadeClose: true, //点击遮罩关闭
                        btn: ['<fmt:message code="global.lang.ok" />'],
                        content:'<table class="equip">' +
                            '<tr><td><span><fmt:message code="meet.th.SelectDevice" /></span></td></tr>'+
                            '<tr><td id="addAll"><span><fmt:message code="meet.th.addAll" /></span></td></tr>'+
                            '<tr><td id="delAll"><span><fmt:message code="meet.th.DeleteAll" /></span></td></tr>'+
                            equipStr+
                            '</table>',
                        success:function(){
                            $(".equipClick").click(function(){
                                $(this).toggleClass('equipSpan');
                            })
                            $("#addAll").click(function(){
                                $(".equipClick").addClass('equipSpan');
                            })
                            $("#delAll").click(function(){
                                $(".equipClick").removeClass('equipSpan');
                            })
                        },
                        yes:function(index){
                            var equipSpanArray=$(".equipSpan");
                            var equipId="";
                            var equipName="";
                            for(var i=0;i<equipSpanArray.length;i++){
                                equipName+=$(equipSpanArray[i]).html()+",";
                                equipId+=$(equipSpanArray[i]).attr("equipmentid")+",";
                            }
                            $(".equipmentId").attr("equipmentId",equipId);
                            $(".equipmentId").val(equipName);
                            layer.close(index);
                        }

                    })
                })
                $(".clearEquipment").click(function(){
                    $(".equipmentId").attr("equipmentId","");
                    $(".equipmentId").val("");
                })
            }
        });
    })

    //初始化会议室下拉列表
    function initMeetRoom(){
        $.ajax({
            url: '../../meetingRoom/getAllMeetRoom',
            type: 'get',
            async:false,
            dataType: 'json',
            success: function (obj) {
                var data=obj.obj;
                var str="";
                var firstRoomId;
                if(!data.length){
                    // $('#meetRoomId').attr('noRoom','true')
                    return false
                }
                for(var i=0;i<data.length;i++){
                    str+='<option value="'+data[i].sid+'">'+data[i].mrName+'</option>';
                    if(i==0){
                        firstRoomId = data[i].sid;
                    }
                }
                if (str===''){
                    $("input[name='isVideo']").each(function(index,item){
                        $(this).prop("disabled",true);
                        if(index===0){
                            $(this).prop("checked",true);
                        }
                    });
                }
                str+="<option value='0'>视频会议</option>";
                $(".meetRoomId").html(str);
                //initManager(firstRoomId);

            }
        });
    }

    //审批管理员
    function initManager(roomId,managerId){
        $.ajax({
            url: '/meeting/getManagers',
            type: 'get',
            dataType: 'json',
            async:false,
            data: {
                paraName:"MEETING_MANAGER_TYPE",
                roomId:roomId
            },
            success: function (obj) {
                var data=obj.object;
                var managerArray=data.usersList;
                var str="";
                for(var i=0;i<managerArray.length;i++){
                    if(managerId==undefined){
                        str+='<option value="'+managerArray[i].uid+'">'+managerArray[i].userName+'</option>';
                    }else if(managerId==managerArray[i].uid){
                        str+='<option value="'+managerArray[i].uid+'" selected>'+managerArray[i].userName+'</option>';
                    }
                }
                $(".managerId").html(str);
            }
        });
    }

    function  DateNextDay(d2) {
        //slice返回一个数组
        var str = d2.slice(5) + "-" + d2.slice(0,4);
        var d = new Date(str);
        var d3 = new Date(d.getFullYear(),d.getMonth(),d.getDate()+1);
        var month=returnMonth(d3.getMonth());
        var day=d3.getDate();
        day=day < 10? "0"+day:day;
        var str2=d3.getFullYear()+"-"+month+"-"+day;
        return str2;
    }

    function returnMonth(num) {
        var str= "";
        switch(num) {
            case 0: str= "01"; break;
            case 1: str= "02"; break;
            case 2: str= "03"; break;
            case 3: str= "04"; break;
            case 4: str= "05"; break;
            case 5: str= "06"; break;
            case 6: str= "07"; break;
            case 7: str= "08"; break;
            case 8: str= "09"; break;
            case 9: str= "10"; break;
            case 10: str= "11"; break;
            case 11: str= "12"; break;
        }
        return str;
    }
    function week_select() {
        $('.WEEKEND').hide();

        var x = $('#cycleStartDate').val();
        y = x.replace(/-/, ",");
        y = y.replace(/-/, "/");
        y = new Date(y);

        var z = $('#cycleEndDate').val();
        r = z.replace(/-/, ",");
        r = r.replace(/-/, "/");
        r = new Date(r);

        a = r - y;
        a= a/24/60/60/1000+1;

        if(a>6) {
            $('.WEEKEND').css('display','');
        }
        else {
            for(var i=x;i<=z;i=DateNextDay(i)) {
                i = i.replace(/-/, ",");
                i = i.replace(/-/, "/");
                v = new Date(i);
                s = v.getDay();
                if(/^[-]?\d+$/.test(s)) {
                    w = "WEEKEND"+s;
                    document.getElementById(w).style.display="";
                }
            }
        }
    }
    $(function () {
        //修改会议
        $('.pagediv').on('click','.editData',function (event){
            var sid=$(this).attr("sid");
            event.stopPropagation();
            layer.open({
                type: 1,
                title:['<fmt:message code="meet.th.ModifyInformation" />', 'background-color:#2b7fe0;color:#fff;'],
                area: ['800px', '500px'],
                // offset: '100px',meetRoomId
                shadeClose: true, //点击遮罩关闭
                btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                content: '<div class="div_table" style="margin-left: 15px;">' +
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span>主题<fmt:message code="workflow.th.name" />：</span><span><input type="text" style="width: 70%;margin-left: 5px;" name="typeName" class="inputTd meetName test_null" value="" /></span></div>'+
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="sup.th.Applicant" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" class="userName test_null onlyOne" id="userDuser" user_id="" dataid="" value="" disabled style="width: 77%;min-height:60px;resize:none;"></textarea></div></span></div>'+//<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span>
                    '<div class="div_tr">联系电话：</span><span><input type="text" style="width: 70%;margin-left: 5px;"  name="typeName" class="inputTd mobileNo" value="" /></span></div>'+
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" class="recorderName onlyOne" id="recoderDuser" user_id="" dataid="" value="" disabled style="width: 54%;min-height:60px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="meet.th.ConferenceRoom" />：</span><span><select style="width: 43%;" name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span><span style="margin-left: 10px;"><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span></div>'+
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="sup.th.ApplicationTime" />：</span><span style="margin:0 5px;">从</span>：'+
                    '<span style="position:relative"><input type="text" style="width: 140px;" name="typeName" class="inputTd startTime test_null endTime2" value="" />' +
                    '</span>' +
                    '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>'+
                    '<span><input type="text" style="width: 140px;" name="typeName" class="endTime test_null endTime1" value="" /></span>' +
                    '</div>' +
                    '<div class="div_tr isVideo" style="display:none"><span class="span_td">是否是视频会议：</span> '+
                    '<span style="margin-right: 10px;"><input style="height:auto;margin-top:2px;vertical-align: text-top;" type="radio" name="isVideo" class="isVideo" value="1">是</span>' +
                    '<span><input style="height:auto;margin-top:2px;vertical-align: text-top;" type="radio" checked="true" name="isVideo" class="isVideo" value="0">否</span>' +
                    '</div>' +
                    '<div class="div_tr" style="display: none;"><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span><span><select style="width: 43%;" name="typeName" class="managerId test_null" id="managerId"></select><input type="hidden" id="isOld"></span></div>'+
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.external" />：</span><span><div class="inPole" style="width: 70%"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="width: 85%;min-height:58px;resize:vertical"></textarea></div></span></div>'+
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.internal" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" class="attendee" id="attendeeDuser" user_id="" value="" disabled style="width: 77%;min-height:60px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" id="equipmentId" class="equipmentId" equipmentId="" disabled style="width: 85%;min-height:60px;resize:none;"></textarea></span>' +
                    '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="addEquipment" class="addEquipment"><fmt:message code="global.lang.add" /></a></span>'+
                    '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearEquipment" class="clearEquipment"><fmt:message code="global.lang.empty" /></a></div></span></div>' +                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.WriteSchedule" />：</span><span><input type="checkbox" id="isWriteCalendar" class="isWriteCalendar"></span><span><fmt:message code="meet.th.Yes" /></span></div>'+
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind" class="smsRemind"></span><span style="margin-right: 10px;">事务通知</span><span><input type="checkbox" id="sms2Remind" class="sms2Remind"></span><span><fmt:message code="meet.th.SMSReminder" /></span><span style="margin-left: 10px;"><fmt:message code="meet.th.Advance" /></span><input type="text" name="resendHour" id="resendHour" style="width: 30px;" class="resendHour"><span><fmt:message code="meet.th.hour" /></span><input type="text"class="resendMinute" style="width: 30px;" id="resendMinute"><span><fmt:message code="meet.th.Reminder" /></span></div>'+
                    <%--'<div class="div_tr"><span class="span_td" style="text-align: right"><fmt:message code="sup.th.RelatedAccessories" />：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +--%>
                    <%--'<form id="uploadimgform" target="uploadiframe"  action="../upload?module=meeting" enctype="multipart/form-data" method="post" >'+--%>
                    <%--'<input type="file" name="file" id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +--%>
                    <%--'<a href="javascript:;" id="uploadimg">' +--%>
                    <%--'<img style="margin-right:5px;vertical-align: text-bottom;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+--%>
                    <%--'</form></div></span></div>'+--%>
                    '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs12">' +
                    '<div class="layui-form-item layui-form-text">\n' +
                    '    <label class="layui-form-label">相关附件:</label>\n' +
                    '<div class="layui-input-block" style="padding-top: 9px">\n' +
                    '            <div id="fileAll" style="    text-align: left;"></div>\n' +
                    '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                    '                <img src="../img/mg11.png" alt="">\n' +
                    '                <span>添加附件</span>\n' +
                    '                <input type="file" multiple id="fileupload" data-url="../upload?module=meeting" name="file">\n' +
                    '            </a>\n' +
                    '        </div>'+
                    '  </div>'+
                    '</div>'+
                    '</div>'+
                    '    </div>\n' +
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span><span><div class="inPole" style="width: 70%;"><textarea name="meetDesc" id="meetDesc" class="meetDesc" value="" style="width: 77%;min-height:60px;resize:vertical;"></textarea></div></span></div>'+
                    '</div>',
                success:function(){
                    fileuploadFn('#fileupload', $('#fileAll'));
                    //判断是否显示视频会议
                    $.ajax({
                        type:'get',
                        url:'/ShowDownLoadQrCode',
                        dataType:'json',
                        success:function(res){
                            if(res.flag){
                                if(res.object!='0'){
                                    $('#meetRoomId option:last').remove()
                                    $('.isVideo').hide()
                                }
                            }
                        }
                    });


                    //会议室
                    initMeetRoom();
                    $('#meetRoomId').change(function(){
                        var opvalue=$(this).val();
                        if (opvalue==='0'){
                            $("input[name='isVideo']").each(function(index,item){
                                $(this).prop("disabled",true);
                                if(index===0){
                                    $(this).prop("checked",true);
                                }
                            });
                        }else{
                            //initManager($(this).val());
                            $("input[name='isVideo']").each(function(){
                                $(this).prop("disabled",false);
                            });
                            initManager(opvalue);
                        }
                    });

                    //审批管理员
                    initManager($('#meetRoomId').val());

                    //回显
                    $.ajax({
                        url:'/meeting/PTqueryMeetingById',
                        type:'get',
                        dataType:'json',
                        data:{
                            sid:sid
                        },
                        success:function(obj){
                            var data=obj.object;
                            var str='';
                            <%--if(data.attachmentList.length>0){--%>
                                <%--for(var i=0;i<data.attachmentList.length;i++){--%>
                                    <%--str+='<div class="dech" deUrl="'+data.attachmentList[i].attUrl+'"><a href="/download?'+data.attachmentList[i].attUrl+'" NAME="'+data.attachmentList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.attachmentList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.attachmentList[i].aid+'@'+data.attachmentList[i].ym+'_'+data.attachmentList[i].attachId+',"></div>';--%>
                                <%--}--%>
                            <%--}else{--%>
                                <%--str='';--%>
                            <%--}--%>
                            if(data.attachmentList.length>0){
                                var  attachmentList = data.attachmentList
                                if(attachmentList !=undefined && attachmentList.length>0){
                                    for(var i=0;i<attachmentList.length;i++){
                                        str+='<div class="dech" deUrl="' +attachmentList[i].attUrl + '"><a href="/download?' + attachmentList[i].attUrl + '" NAME="' + attachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + attachmentList[i].aid + '@' + attachmentList[i].ym + '_' + attachmentList[i].attachId +',"></div>'
                                    }
                                }else{
                                    str='';
                                }
                                $('#fileAll').html(str)
                            }

                            $(".meetName").val(data.meetName);
                            $(".mobileNo").val(data.mobileNo);
                            $(".subject").val(data.subject);
                            $(".userName").val(data.userName);
                            $(".userName").attr("dataid",data.uid);
                            $(".userName").attr("user_id",data.userId);
                            $(".recorderName").val(data.recorderName);
                            $(".recorderName").attr("dataid",data.recorderId);
                            $(".recorderName").attr("user_id",data.recorderUserId);
                            // $(".startTime").val(data.startTime);
                            // $(".endTime").val(data.endTime);
                            $(".startTime").val(data.startTime.substr(0,16));
                            $(".endTime").val(data.endTime.substr(0,16));
                            laydate.render({
                                elem: '#beginTime'
                                ,value:date._i
                            });
                            laydate.render({
                                elem: '.startTime'
                                ,type: 'datetime'
                                ,format: 'yyyy-MM-dd HH:mm'
                            });
                            laydate.render({
                                elem: '.endTime'
                                ,type: 'datetime'
                                ,format: 'yyyy-MM-dd HH:mm'
                                ,done: function(value, date, endDate){
                                    //判断会议室是否被占用
                                    $.get('/meeting/judgeMeeting',{
                                        meetRoomId:$('#meetRoomId').val(),
                                        startTime:$('.startTime').val(),
                                        endTime:value
                                    },function(res){
                                        if(res.code==1){
                                            $.layerMsg({content: res.msg, icon: 0})
                                            return false
                                        }
                                    })
                                }
                            });
                            $(".attendeeOut").val(data.attendeeOut);
                            $(".attendee").val(data.attendeeName);
                            $(".attendee").attr("dataid",data.attendee);
                            $(".attendee").attr("user_id",data.attendeeUserId);
                            if(data.isWriteCalednar==1){
                                $(".isWriteCalendar").attr("checked",true);
                            }
                            if(data.smsRemind==1){
                                $(".smsRemind").attr("checked",true)
                            }
                            if(data.sms2Remind==1){
                                $(".sms2Remind").attr("checked",true);
                            }
                            $(".resendHour").val(data.resendHour);
                            $(".resendMinute").val(data.resendMinute);
                            $(".meetDesc").val(data.meetDesc);
                            //会议室
                            $("#meetRoomId").val(data.meetRoomId);
                            $("input[name='isVideo']").each(function(index,item){
                                if(data.meetRoomId===0){
                                    $(this).prop("disabled",true);
                                    if(index===0){
                                        $(this).prop("checked",true);
                                    }
                                }else{
                                    if(Number(data.videoConfFlag)===index){
                                        $(this).prop("checked",false);
                                    }else{
                                        $(this).prop("checked",true);

                                    }
                                }
                            });
                            //审批管理员
                            $("#managerId").val(data.managerId);
                            $('#isOld').val(data.managerId)


                            $(".equipmentId").val(data.equipmentNames);
                            $(".equipmentId").attr("equipmentId",data.equipmentIds);
                            $('.Attachment').append(str);
                        }
                    });

                    //点击会议室名称显示会议室详情
                    $('.meetRoomDetail').click(function (){

                        var ismeetRoom=$('#meetRoomId').val();
                        if(ismeetRoom==='0'){
                            $.layerMsg({content:"暂无会议室详情",icon:2});
                            return false;
                        }

                        $.ajax({
                            url: '/meetingRoom/getMeetRoomBySid',
                            type: 'get',
                            dataType: 'json',
                            data: {
                                sid: $(".meetRoomId").val()
                            },
                            success: function (obj) {
                                if(obj.flag){
                                    var data = obj.object;
                                    var meetList = data.meetingWithBLOBs;
                                    var str = '<div class="table"><table style="margin:auto;">' +
                                        '<tr><td width="20%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span></td><td><span>' + data.mrName + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span></td><td><span>' + data.mrDesc + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span></td><td><span>' + data.managetnames + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span></td><td><span>' + data.meetroomdeptName + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.Application" />：</span></td><td><span>' + data.meetroompersonName + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span></td><td><span>' + data.mrCapacity + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span></td><td><span>' + data.mrDevice + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="depatement.th.address" />：</span></td><td><span>' + data.mrPlace + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicationRecord" />：</span></td>' +
                                        '<td>' +
                                        '<table>' +
                                        '<tr>' +
                                        '<td><fmt:message code="meet.th.ConferenceName" /></td>' +
                                        '<td><fmt:message code="sup.th.Applicant" /></td>' +
                                        '<td><fmt:message code="sup.th.startTime" /></td>' +
                                        '<td><fmt:message code="meet.th.EndTime" /></td>' +
                                        '<td><fmt:message code="notice.th.state" /></td>' +
                                        '<tr>';
                                    for (var i = 0; i < meetList.length; i++) {
                                        str += '<tr>' +
                                            '<td>' + meetList[i].meetName + '</td>' +
                                            '<td>' + meetList[i].userName + '</td>' +
                                            '<td>' + meetList[i].startTime + '</td>' +
                                            '<td>' + meetList[i].endTime + '</td>' +
                                            '<td>' + meetList[i].statusName + '</td>' +
                                            '</tr>'
                                    }
                                    str += '</table></td></tr>' +
                                        '</table></div>';
                                    layer.open({
                                        type: 1,
                                        title: ['<fmt:message code="meet.th.SeeDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                        area: ['900', '500px'],
                                        shadeClose: true, //点击遮罩关闭
                                        btn: ['<fmt:message code="global.lang.close" />'],
                                        content: str
                                    })
                                }
                                else{
                                    $.layerMsg({content:"暂无会议室详情",icon:2},function(){
                                    });
                                }
                            }
                        })
                    })
                    //删除附件
                    $(document).on('click','.deImgs',function(){
                        var data=$(this).parents('.dech').attr('deUrl');
                        var dome=$(this).parents('.dech');
                        deleteChatment(data,dome);
                    })
                },
                yes:function(index){
                    var array=$(".test_null");
                    for(var i=0;i<array.length;i++){
                        if(array[i].value==""){
                            $.layerMsg({content:"<fmt:message code="sup.th.With*" />",icon:2},function(){
                            });
                            return;
                        }
                    }
                    for(var i=0;i<$('.onlyOne').length;i++){
                        if($('.onlyOne').eq(i).val().split(',').length>2){
                            $.layerMsg({content:$('.onlyOne').eq(i).parent().parent().prev().text().substr(0,$('.onlyOne').eq(i).parent().parent().prev().text().length-1)+'只能选一个！',icon:2},function(){
                            });
                            return;
                        }
                    }
                    var isWriteCalednar=0;
                    var attendId='';
                    var attendName='';
                    if($('#isWriteCalendar').is(':checked')){
                        isWriteCalednar=1;
                    }
                    var smsRemind=0;

                    if($('#smsRemind').is(':checked')){
                        smsRemind=1;
                    }
                    var sms2Remind=0;
                    if($('#sms2Remind').is(':checked')){
                        sms2Remind=1;
                    }
                    var recorderId=$(".recorderName").attr("dataid");
                    if(recorderId!="" && recorderId.indexOf(",") >= 0){
                        recorderId=recorderId.substr(0,recorderId.length-1);
                    }
                    var uid=$(".userName").attr("dataid");
                    if(uid!="" && uid.indexOf(",") >= 0 ){
                        uid=uid .substr(0,uid.length-1);
                    }
                    // for(var i=0;i<$('.Attachment .inHidden').length;i++){
                    //     attendId += $('.Attachment .inHidden').eq(i).val();
                    // }
                    // for(var i=0;i<$('.Attachment .inHidden').length;i++){
                    //     attendName += $('.Attachment a').eq(i).attr('NAME');
                    // }
                    var attendId = '';
                    var attendName = '';
                    for (var i = 0; i < $('#fileAll .dech').length; i++) {
                        attendId += $('#fileAll .dech').eq(i).find('input').val();
                        attendName += $('#fileAll a').eq(i).attr('name');
                    }
                    var paraData={
                        sid:sid,
                        meetName: $(".meetName").val(),
                        mobileNo: $(".mobileNo").val(),
                        subject:$(".subject").val(),
                        uid: uid,
                        recorderId:recorderId,
                        startTime:$("#startTime").val()+':00',
                        endTime:$("#endTime").val()+':00',
                        attendeeOut:$(".attendeeOut").val(),
                        attendee:$(".attendee").attr("dataid"),
                        isWriteCalednar:isWriteCalednar,
                        smsRemind:smsRemind,
                        sms2Remind:sms2Remind,
                        resendHour:$(".resendHour").val(),
                        resendMinute:$(".resendMinute").val(),
                        meetDesc:$(".meetDesc").val(),
                        managerId:$("#managerId").val(),
                        meetRoomId:$("#meetRoomId").val(),
                        equipmentNames:$(".equipmentId").val(),
                        equipmentIds:$(".equipmentId").attr("equipmentId"),
                        attachmentId:attendId,
                        attachmentName:attendName,
                        videoConfFlag:$('.isVideo:checked').val()
                    }
                    if($('#isOld').val()!=$("#managerId").val()){
                        paraData.Status=1
                    }else{
                        paraData.Status=0
                    }

                    $.ajax({
                        url: '/meeting/updateMeetingById',
                        type: 'get',
                        dataType: 'json',
                        data: paraData,
                        success: function (obj) {
                            if(obj.flag){
                                $.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1},function() {
                                    //更新列表
                                    listByStatus(queryStatus);
                                })
                                layer.close(index);
                            }
                        }
                    })
                }
            });
            // $('.Attachment').on('click','.deImgs',function(){
            //     var data=$(this).parents('.dech').attr('deUrl');
            //     var dome=$(this).parents('.dech');
            //     deleteChatment(data,dome);
            // })
            $(document).on('click','.deImgs',function(){
                var data=$(this).parents('.dech').attr('deUrl');
                var dome=$(this).parents('.dech');
                deleteChatment(data,dome);
            })
            $('#uploadinputimg').fileupload({
                dataType:'json',
                done: function (e, data) {
                    if(data.result.obj != ''){
                        var data = data.result.obj;
                        var str = '';
                        var str1 = '';
                        for (var i = 0; i < data.length; i++) {
                            str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                        $('.Attachment').append(str);
                    }else{
                        //alert('添加附件大小不能为空!');
                        layer.alert('添加附件大小不能为空!',{},function(){
                            layer.closeAll();
                        });
                    }
                }
            });

            //查询所有办公设备
            var equipStr='';
            $.ajax({
                url: '/Meetequipment/getAllEquiet',
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    var data=obj.obj;
                    for(var i=0;i<data.length;i++){
                        equipStr+='<tr><td class="equipClick" equipmentid="'+data[i].sid+'">'+data[i].equipmentName+'</td></tr>';
                    }
                }
            })
            //选择办公设备控件
            $(".addEquipment").click(function(){
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['300px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.ok" />'],
                    content:'<table class="equip">' +
                        '<tr><td><span><fmt:message code="meet.th.SelectDevice" /></span></td></tr>'+
                        '<tr><td id="addAll"><span><fmt:message code="meet.th.addAll" /></span></td></tr>'+
                        '<tr><td id="delAll"><span><fmt:message code="meet.th.DeleteAll" /></span></td></tr>'+
                        equipStr+
                        '</table>',
                    success:function(){
                        $(".equipClick").click(function(){
                            $(this).toggleClass('equipSpan');
                        })
                        $("#addAll").click(function(){
                            $(".equipClick").addClass('equipSpan');
                        })
                        $("#delAll").click(function(){
                            $(".equipClick").removeClass('equipSpan');
                        })
                    },
                    yes:function(index){
                        var equipSpanArray=$(".equipSpan");
                        var equipId="";
                        var equipName="";
                        for(var i=0;i<equipSpanArray.length;i++){
                            equipName+=$(equipSpanArray[i]).html()+",";
                            equipId+=$(equipSpanArray[i]).attr("equipmentid")+",";
                        }
                        $(".equipmentId").attr("equipmentId",equipId);
                        $(".equipmentId").val(equipName);
                        layer.close(index);
                    }

                })
            })
            $(".clearEquipment").click(function(){
                $(".equipmentId").attr("equipmentId","");
                $(".equipmentId").val("");
            })
        })

        $('#meetingApply').click(function(){
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('.meentingDate').show();
            $('#already').hide();
            $('.colorClass').show();
        })
        $('#PAMeeting').click(function(){
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.meentingDate').hide();
            $('.colorClass').hide();
        })
        $('#ApMeeting').click(function(){
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.meentingDate').hide();
            $('.colorClass').hide();
        })
        $('#HaveMeeting').click(function(){
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.meentingDate').hide();
            $('.colorClass').hide();
        })
        $('#NotMeeting').click(function(){
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.meentingDate').hide();
            $('.colorClass').hide();
        })
    })

    //点击各个状态后显示的列表
    function listByStatus(status){
        var paraData;
        queryStatus=status;
        if(status==0){
            paraData={}
        }else{
            paraData={
                uid:$.cookie('uid'),
                status:status,
                page:1,//当前处于第几页
                pageSize:5,//一页显示几条
                useFlag:true
            }
        }

        var ajaxPageLe={
            data:paraData,
            page:function () {
                var me=this;

                $.ajax({
                    url:'/meeting/queryMeeting',
                    type:'get',
                    dataType:'json',
                    data:me.data,
                    success:function(obj){
                        var data=obj.obj;
                        var str="";
                        for(var i=0;i<data.length;i++) {
                            str += '<tr>' +
                                '<td style="text-align: center" width="11%" title="' + data[i].meetName + '"><a class="meetingDetail" href="javascript:void(0)" sid="' + data[i].sid + '">' + data[i].meetName + '</a></td>' +
                                '<td style="text-align:center" width="11%" title="' + data[i].subject + '">' + data[i].subject + '</td>' +
                                '<td style="text-align:center" width="11%" title="' + data[i].meetCode + '">' + function () {
                                    if (data[i].meetCode!=undefined && data[i].meetCode!=''){
                                        return data[i].meetCode;
                                    }
                                    return "无";
                                }() + '</td>' +
                                '<td style="text-align:center" width="13%">' + data[i].createTime + '</td>' +
                                '<td style="text-align:center" width="13%">' + data[i].startTime + '</td>' +
                                '<td style="text-align:center" width="13%">' + data[i].endTime + '</td>' +
                                '<td style="text-align:center" width="9%">' + data[i].meetRoomName + '</td>'+
                                '<td style="text-align:center" width="6%">' + data[i].userName + '</td>'+
                                '<td style="text-align:center" width="9%">' + function () {
                                    if(data[i].mobileNo==undefined){
                                        return ''
                                    } else{
                                        return data[i].mobileNo
                                    }
                                }() + '</td>';

                            if(status==1 || status==4){
                                str+='<td style="text-align:center" width="15%">' +
                                    '<a href="javascript:;" style="" class="editData" sid="'+data[i].sid+'"><fmt:message code="depatement.th.modify" /></a>&nbsp;&nbsp;'+
                                    '<a href="javascript:;" style="" onclick="delMeeting('+data[i].sid+')"' + '><fmt:message code="global.lang.delete" /></a></td>'+
                                    '</tr>';
                            }
                            if(status==2){
                                str+= '<td style="text-align:center" width="15%"><a href="javascript:;" style="" onclick="attendState('+data[i].sid+',1)"><fmt:message code="mee.th.Participants" /></a>&nbsp;&nbsp;'+
                                    '<a href="javascript:;" style="" onclick="attendState('+data[i].sid+',2)"><fmt:message code="meet.th.ReadingStatus" /></a>&nbsp;&nbsp;'+
                                    function (){
                                        if (data[i].videoContent!=undefined && data[i].videoConfFlag==="1"){
                                            return '<a href="javascript:;" onclick="GetDataSet('+JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;')+')">参加视频会议</a>';
                                        }
                                        return ''
                                    }()+
                                    '</td>'+
                                    '</tr>';
                            }
                            if(status==3){
                                str+='<td width="15%" style="text-align:center"><a href="javascript:;" style="" onclick="attendState('+data[i].sid+',1)"><fmt:message code="mee.th.Participants" /></a>&nbsp;&nbsp;'+
                                    '<a href="javascript:;" style="" onclick="attendState('+data[i].sid+',2)"><fmt:message code="meet.th.ReadingStatus" /></a>&nbsp;&nbsp;'+
                                    function (){
                                        if (data[i].videoContent!=undefined && data[i].videoConfFlag==="1"){
                                            return '<a href="javascript:;" onclick="GetDataSet('+JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;')+')">参加视频会议</a>';
                                        }
                                        return ''
                                    }()+
                                    '</tr>';
                            }
                        }
                        $("#already tbody").html(str);
                        me.pageTwo(obj.totleNum,me.data.pageSize,me.data.page)
                    }
                });

            },
            pageTwo:function (totalData, pageSize,indexs) {
                var mes=this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage:'',
                    endPage: '',
                    current:indexs||1,
                    callback: function (index) {
                        mes.data.page=index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPageLe.page();
    }

    //参会情况和签阅情况
    function attendState(meetingId,join){
        if(join==1){//参会情况
            $.ajax({
                url:'/meeting/queryAttendConfirm',
                type:'get',
                dataType:'json',
                data:{
                    meetingId:meetingId
                },
                success:function(obj){
                    var data=obj.obj;
                    layer.open({
                        type: 1,
                        /* skin: 'layui-layer-rim', //加上边框 */
                        offset: '80px',
                        area: ['800px', '400px'], //宽高
                        title: "<fmt:message code="meet.th.ViewParticipants" />",
                        closeBtn: 1,
                        content:
                            '<div class="mainRight attendContent"><div class="pagediv" style="margin: 0 auto;width: 97%;" id="showList">'+
                            '<table><thead>'+
                            '<tr> <th><fmt:message code="workflow.th.Serial" /></th><th><fmt:message code="userDetails.th.name" /></th> <th><fmt:message code="workflow.th.sector" /></th> <th><fmt:message code="userManagement.th.role" /></th><th><fmt:message code="meet.th.AttendanceStatus" /></th><th><fmt:message code="meet.th.ConfirmationTime" /></th><th><fmt:message code="hr.th.Explain" /></th></tr>'+
                            '</thead>' +
                            '<tbody></tbody>'+
                            '</table>'+
                            '</div></div>',
                        btn: ['<fmt:message code="global.lang.close" />'],
                        success:function () {
                            $(".attendContent tbody").html("");
                            var str="";
                            for(var i=0;i<data.length;i++){
                                str += '<tr><td>' +(i+1)+ '</td>' + '<td>' + data[i].attendeeName + '</td>' + '<td>' + data[i].deptName + '</td>' +
                                    '<td>' + data[i].userPrivName + '</td>' + '<td>' + data[i].attendFlagStr + '</td>' + '<td>' + data[i].createTime + '</td>' +'<td>' + data[i].remark + '</td>' +
                                    '</tr>';
                            }
                            $(".attendContent tbody").html(str);
                        }
                    })
                }
            });
        }else {//签阅情况
            $.ajax({
                url: '/meeting/queryAttendConfirm',
                type: 'get',
                dataType: 'json',
                data: {
                    meetingId: meetingId
                },
                success: function (obj) {
                    var data = obj.obj;
                    layer.open({
                        type: 1,
                        /* skin: 'layui-layer-rim', //加上边框 */
                        offset: '80px',
                        area: ['800px', '400px'], //宽高
                        title: "<fmt:message code="meet.th.CheckMeeting" />",
                        closeBtn: 1,
                        content: '<div class="mainRight attendContent"><div class="pagediv" style="margin: 0 auto;width: 97%;" id="showList">' +
                            '<table><thead>' +
                            '<tr> <th><fmt:message code="workflow.th.Serial" /></th><th><fmt:message code="userDetails.th.name" /></th> <th><fmt:message code="workflow.th.sector" /></th> <th><fmt:message code="userManagement.th.role" /></th><th><fmt:message code="meet.th.ReadStatus" /></th><th><fmt:message code="meet.th.TimeRead" /></th></tr>' +
                            '</thead>' +
                            '<tbody></tbody>' +
                            '</table>' +
                            '</div></div>',
                        btn: ['<fmt:message code="global.lang.close" />'],
                        success: function () {
                            $(".attendContent tbody").html("");
                            var str = "";
                            for (var i = 0; i < data.length; i++) {
                                str += '<tr><td>' + (i + 1) + '</td>' + '<td>' + data[i].attendeeName + '</td>' + '<td>' + data[i].deptName + '</td>' +
                                    '<td>' + data[i].userPrivName + '</td>' + '<td>' + data[i].readFlagStr + '</td>' + '<td>' + data[i].readingTime + '</td>' +
                                    '</tr>';
                            }
                            $(".attendContent tbody").html(str);
                        }
                    })
                }
            });
        }
    }



    $('.fc-button-basicWeek').click(function(){
        var screenwidth = document.documentElement.clientHeight;
    })
    //删除会议
    function delMeeting(sid){
        $.layerConfirm({title:'<fmt:message code="meet.th.DeleteSession" />',content:'<fmt:message code="meet.th.DeterminesRecovered" />！',icon:0},function(){
            $.ajax({
                url:'/meeting/delMeetingById',
                type:'get',
                dataType:'json',
                data:{
                    sid:sid
                },
                success:function(obj){
                    $.layerMsg({content:'<fmt:message code="workflow.th.delsucess" />！',icon:1},function(){
                        //更新列表
                        listByStatus(queryStatus)
                        //更新数量
                        //各个状态的数量显示
                        $.ajax({
                            url:'/meeting/queryCountByStatus',
                            type:'get',
                            dataType:'json',
                            success:function(obj){
                                var data=obj.object;
                                $("#pendingCount").html(data.pendingCount);
                                $("#approvedCount").html(data.approvedCount);
                                $("#processingCount").html(data.processingCount);
                                $("#notApprovedCount").html(data.notApprovedCount);
                                $("#overCount").html(data.overCount);
                            }
                        });
                    })
                }
            });
        })
    }
    //附件删除
    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteFile" />"
        }, function(){
            //确定删除，调接口
            $.ajax({
                type:'get',
                url:'../delete',
                dataType:'json',
                data:data,
                success:function(res){

                    if(res.flag == true){
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', { icon:6});
                        element.remove();
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', { icon:6});
                    }
                }
            });

        }, function(index){
            layer.close(index);
        });
    }

    $('.pagediv').on('click','.meetingDetail',function (event) {
        $.ajax({
            url: '/meeting/PTqueryMeetingById',
            type: 'get',
            dataType: 'json',
            data: {
                sid: $(this).attr("sid")
            },
            success: function (obj) {

                var data = obj.object;
                var str = '';
                if (data.attachmentList.length > 0) {
                    for (var i = 0; i < data.attachmentList.length; i++) {
                        str += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?' + data.attachmentList[i].attUrl + '">' + data.attachmentList[i].attachName + '</a></div>'
                    }
                } else {
                    str = '';
                }
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['800px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['打印','<fmt:message code="global.lang.close" />'],
                    content: '<div class="table"><table style="margin:auto;" class="detailTable">' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>' + data.meetName + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>' + data.subject + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>' + data.userName + '</span></td><tr>' +
                            '<tr><td width="30%"><span class="span_td">联系电话：</span></td><td><span>' + data.mobileNo + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>' + data.recorderName + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span>从 &nbsp;</span><span>' + data.startTime + '</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>' + data.endTime + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>' + data.meetRoomName + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>' + data.managerName + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>' + data.attendeeOut + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>' + data.attendeeName + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>' + data.equipmentNames + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">' + str + '</div></span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>' + data.meetDesc + '</span></td><tr>' +
                        '</table></div>',
                    success:function(){
                        $('.table td').css({
                            "overflow": "hidden",
                            "text-overflow": "ellipsis",
                            "white-space": "nowrap",
                            "padding": 0,
                        });
                        for(var i=0;i<$('.table tr').length;i++){
                            $('.table tr').eq(i).find('td').eq(0).css('text-align','right');
                        }

                    },
                    yes:function(){
                        $('.table').jqprint({
                            debug: false,
                            importCSS: true,
                            printContainer: true,
                            operaSupport: false
                        });
                    }
                })
            }
        })
        //queryStatus
    })



    //获取昨天时间最晚时间
    function dateYest(){
        var time=new Date();
        time.setTime(time.getTime()-24*60*60*1000);
        // var date=year+'-'+mon+'-'+da+' '+h+':'+m+':'+s
        var mon=time.getMonth()+1
        var da=time.getDate()
        if (mon < 10) mon = "0" + mon;
        if (da < 10) da = "0" + da;
        var date=time.getFullYear()+"-" + mon + "-" + da+' '+'23:59:59'
        return date
    }
    //后一天
    function getNextDate(date,day) {
        var dd = new Date(date);
        dd.setDate(dd.getDate() + day);
        var y = dd.getFullYear();
        var m = dd.getMonth() + 1 < 10 ? "0" + (dd.getMonth() + 1) : dd.getMonth() + 1;
        var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();
        var getNextDate = y + "-" + m + "-" + d;
        return getNextDate
    }
    //时间日期转换成string
    function data_string(now) {
        var yy = now.getFullYear();      //年
        var mm = now.getMonth() + 1;     //月
        var dd = now.getDate();          //日
        var hh = now.getHours()+1;         //时
        var ii = now.getMinutes();       //分
        var ss = now.getSeconds();       //秒
        var clock = yy + "-";
        if(mm < 10) clock += "0";
        clock += mm + "-";
        if(dd < 10) clock += "0";
        clock += dd + " ";
        if(hh < 10) clock += "0";
        clock += hh + ":";
        if (ii < 10) clock += '0';
        clock += ii + ":";
        if (ss < 10) clock += '0';
        clock += ss;
        return clock;
    }
    function data_string2(now,num) {
        var yy = now.getFullYear();      //年
        var mm = now.getMonth() + 1;     //月
        var dd = now.getDate();          //日

        if(num == 1){
            var hh = now.getHours()+1;
        }else {
            var hh = now.getHours()+2;
        }
            //时
        var ii = now.getMinutes();       //分
        var ss = now.getSeconds();       //秒
        var clock = yy + "-";
        if(mm < 10) clock += "0";
        clock += mm + "-";
        if(dd < 10) clock += "0";
        clock += dd + " ";
        if(hh < 10) clock += "0";
        clock += hh + ":";
        if (ii < 10) clock += '0';
        clock += ii ;
        return clock;
    }
    //时间戳
    function parserDate(date) {
        var date2 = new Date(date);
        var date = date2.getTime();
        return date
    }

    //时间戳转变日期格式 年-月-日 时-分-秒
    function timestampToTime1() {
        var date = new Date();//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
        return Y+M+D;
    }

</script>
</body>
</html>
