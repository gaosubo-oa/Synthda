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
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title><%--会议通知--%><fmt:message code="dem.th.ConferenceNotice" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/meeting/myMeeting.css">
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <style>
        table tbody tr td:nth-child(1){
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
        }
    </style>
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/qrcode.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <style>
        /*.table table td{*/
        /*padding: 10px;*/
        /*}*/
        .table .span_td{
            text-align: right;
        }
        .showQRCode{
            /*	position: absolute;*/
            right: 32px;
            top:50px;
            z-index:99999;

        }
        .jump-ipt{
            float: left;
            width: 30px;
            height: 30px;
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
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_myMeeting.png" alt="">
    </div>
    <div class="divTitle">
        <%--会议通知--%><fmt:message code="dem.th.ConferenceNotice" />
    </div>
</div>
<div class="main">
    <div class="byDepart">
        <div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 10px;">
            <table>
                <thead>
                <tr>
                    <th style="text-align: center" width="15%"><fmt:message code="meet.th.ConferenceName" /></th>
                    <th style="text-align: center" width="9%"><fmt:message code="sup.th.Applicant" /></th>
                    <th style="text-align: center" width="15%"><fmt:message code="sup.th.startTime" /></th>
                    <th style="text-align: center" width="15%"><fmt:message code="meet.th.EndTime" /></th>
                    <th style="text-align: center" width="7%"><fmt:message code="doc.th.ConferenceStatus" /></th>
                    <th style="text-align: center" width="9%"><fmt:message code="meet.th.ConferenceRoom" /></th>
                    <%--<th style="text-align: center" width="30%"><fmt:message code="menuSSetting.th.menuSetting" /></th>--%>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

            </div>
        </div>
    </div>
</div>

<script>
    var user_id='';
    //时间控件调用
    var start = {
        format: 'YYYY/MM/DD hh:mm:ss',
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    $(function () {

        var ajaxPageLe={
            data:{
                page:1,//当前处于第几页
                pageSize:5,//一页显示几条
                useFlag:true
                // computationNumber:null
            },
            page:function () {
                var me=this;

                $.ajax({
                    url: '/meeting/getMeetingNotify',
                    type: 'get',
                    data:me.data,
                    dataType: 'json',
                    success: function (obj) {
                        var data = obj.obj;
                        if(data.length>0){
                            var str = "";
                            for (var i = 0; i < data.length; i++) {
                                str += '<tr height="40px">' +
                                    '<td style="text-align: center" width="15%" title="' + data[i].meetName + '"><a href="javascript:void(0);" class="meetingDetail"  sid="'+data[i].sid+'">' + data[i].meetName + '</a></td>' +
                                    '<td style="text-align: center" width="9%">' + data[i].userName + '</td>' +
                                    '<td style="text-align: center" width="15%">' + data[i].startTime + '</td>' +
                                    '<td style="text-align: center" width="15%">' + data[i].endTime + '</td>' +
                                    '<td style="text-align: center" width="7%">' + data[i].statusName + '</td>' +
                                    '<td style="text-align: center" width="9%"><a href="javascript:void(0);" class="meetRoomDetail"  meetRoomId="'+data[i].meetRoomId+'">' + data[i].meetRoomName + '</a></td>' +
//                            '<td style="text-align: center;position: relative" width="30%">' +
                                    '<a href="javascript:;" style="display: block;" class="summaryDetail" sid="'+data[i].sid+'"><fmt:message code="doc.th.ViewConferenceMinutes" /></a> ';
                                /*'<a href="javascript:;" style="display: block;">编辑会议纪要</a>' +*/
                                if($.cookie("uid")==data[i].recorderId){
                                    str+='<a href="javascript:;" style="display: block;" class="edtiSummary" sid="'+data[i].sid+'"><fmt:message code="doc.th.EditMeetingMinutes" /></a>';
                                }
                                if($.cookie("uid")==data[i].uid){
                                    str+='<a href="javascript:;" style="" class="attendQR" sid="'+data[i].sid+'">二维码</a>&nbsp;';
                                }
                                str+='<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a> &nbsp;' +
                                    '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a> &nbsp;' +
                                    '<a href="/meeting/outMeetingMsg?sid=' + data[i].sid + '"><fmt:message code="global.lang.report" /></a> &nbsp;' +
                                    '</td>' +
                                    '</tr>';
                            }
                            $("#already tbody").html(str);
                            me.pageTwo(obj.totleNum,me.data.pageSize,me.data.page)

                        }else{
                            $.layerMsg({content:'暂无相关信息！',icon:6});
                        }
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

        //查询按钮点击事件
        $("#query").click(function () {
            var paraData = {
                meetName: $("#meetName").val(),
                startTime: $("#startTime").val(),
                endTime: $("#endTime").val(),
            }
            $.ajax({
                url: '/meeting/getMyMeeting',
                type: 'get',
                dataType: 'json',
                data: paraData,
                success: function (obj) {
                    var data = obj.obj;
                    if(data.length>0){
                        var str = "";
                        for (var i = 0; i < data.length; i++) {
                            str += '<tr>' +
                                '<td style="text-align: center" width="15%" title="' + data[i].meetName + '"><a href="javascript:void(0);" class="meetingDetail"  sid="'+data[i].sid+'">' + data[i].meetName + '</a></td>' +
                                '<td style="text-align: center" width="9%">' + data[i].userName + '</td>' +
                                '<td style="text-align: center" width="15%">' + data[i].startTime + '</td>' +
                                '<td style="text-align: center" width="15%">' + data[i].endTime + '</td>' +
                                '<td style="text-align: center" width="7%">' + data[i].statusName + '</td>' +
                                '<td style="text-align: center" width="9%"><a href="javascript:void(0);" class="meetRoomDetail"  meetRoomId="'+data[i].meetRoomId+'">' + data[i].meetRoomName + '</a></td>' +
                                '<td style="text-align: center;position: relative" width="30%">'+
                                '<a href="javascript:;" style="display: block;" class="summaryDetail" sid="'+data[i].sid+'"><fmt:message code="doc.th.ViewConferenceMinutes" /></a>' ;
                            /* '<a href="javascript:;" style="display: block;">编辑会议纪要</a>' +*/
                            if($.cookie("uid")==data[i].recorderId){
                                str+='<a href="javascript:;" style="display: block;" class="edtiSummary" sid="'+data[i].sid+'"><fmt:message code="doc.th.EditMeetingMinutes" /></a>';
                            }
                            if($.cookie("uid")==data[i].uid){
                                str+='<a href="javascript:;" style="" class="attendQR" sid="'+data[i].sid+'">二维码</a>&nbsp;';
                            }
                            str+='<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a>&nbsp;' +
                                '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a>&nbsp;' +
                                '<a href="/meeting/outMeetingMsg?sid=' + data[i].sid + '"><fmt:message code="global.lang.report" /></a>&nbsp;' +
                                '</td>' +
                                '</tr>';

                        }
                        $("#already tbody").html(str);
                    }else{
                        $.layerMsg({content:'暂无相关信息！',icon:6});
                    }
                }
            });
        })

        //重置按钮点击事件
        $("#clearCondition").click(function () {
            $("#meetName").val("");
            $("#startTime").val("");
            $("#endTime").val("");
        })
    })

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
                                    '<td>' + data[i].userPrivName + '</td>' + '<td>' + data[i].attendFlagStr + '</td>' + '<td>' + data[i].confirmTime + '</td>' +'<td>' + data[i].remark + '</td>' +
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

    //点击会议名称显示会议详情
    $('.pagediv').on('click','.meetingDetail',function (event){
        $.ajax({
            url: '/meeting/queryMeetingById',
            type: 'get',
            dataType: 'json',
            data: {
                sid: $(this).attr("sid")
            },
            success: function (obj) {
                var data=obj.object;
                var str='';
                if(data.attachmentList.length>0){
                    for(var i=0;i<data.attachmentList.length;i++){
                        str+='<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?'+data.attachmentList[i].attUrl+'">'+data.attachmentList[i].attachName+'</a></div>'
                    }
                }else{
                    str='';
                }
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['600px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.close" />'],
                    content:  '<div class="table"><table style="margin:auto;">' +
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>'+data.meetName+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>'+data.subject+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>'+data.userName+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>'+data.recorderName+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span>从 &nbsp;</span><span>'+data.startTime+'</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>'+data.endTime+'</span></td><tr>' +
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>'+data.meetRoomName+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>'+data.managerName+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>'+data.attendeeOut+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>'+data.attendeeName+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>'+data.equipmentNames+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">'+str+'</div></span></td><tr>' +
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>'+data.meetDesc+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.MySignin" />：</span></td><td><span>'+data.myAttend+'</span></td><tr>'+
                    '</table></div>',
                })
            }
        })
        //进行签阅
        $.ajax({
            url: '/meeting/readMeeting',
            type: 'get',
            dataType: 'json',
            data: {
                meetingId: $(this).attr("sid")
            },
            success: function (obj) {

            }
        })
    })

    //点击会议室名称显示会议室详情
    $('.pagediv').on('click','.meetRoomDetail',function (event){
        $.ajax({
            url: '/meetingRoom/getMeetRoomBySid',
            type: 'get',
            dataType: 'json',
            data: {
                sid: $(this).attr("meetRoomId")
            },
            success: function (obj) {
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
            }
        })
    })

    //点击查看会议纪要
    $('.pagediv').on('click','.summaryDetail',function(event){
        var sId=$(this).attr("sid");
        event.stopPropagation();
        layer.open({
            type: 1,
            title:['<fmt:message code="main.meetingsummary" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['800px', '350px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.close" />'],
            content: '<div class="table"><table style="width: 80%; margin-left:60px; margin-top: 30px;">' +
            '<tr style="height: 50px;"><td style="width: 100px"><fmt:message code="workflow.th.name" />：</td><td class="data1" style="text-align: center"></td></tr>' +
            '<tr  style="height: 50px;"><td style="width: 100px"><fmt:message code="meet.th.DesignatedReader" />：</td><td class="data2" style="text-align: center"></td></tr>' +
            '<tr  style="height: 50px;"><td style="width: 100px"><fmt:message code="email.th.file" />：</td><td class="data3" style="text-align: center"></td></tr>' +
            '<tr  style="height: 50px;"><td rowspan="3" style="width: 100px"><fmt:message code="meet.th.SummaryContent" />：</td><td class="data4" style="text-align:center;"> </td></tr>' +
            '</table></div>',
            success:function(){
                $.ajax({
                    type:'get',
                    url:'/MeetSummary/getMeetSummarydetail',
                    dataType:'json',
                    data:{'sid':sId},
                    success:function(res){
                        var datas =res.object;
                        var str='';
                        if(datas.attachmentList.length>0){
                            for(var i=0;i<datas.attachmentList.length;i++){
                                str+='<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?'+datas.attachmentList[i].attUrl+'">'+datas.attachmentList[i].attachName+'</a></div>'
                            }
                        }else{
                            str='';
                        }

                        $('.data1').append(datas.meetName);
                        $('.data2').append(datas.readPeopleNames);
                        $('.data3').append(str);
                        $('.data4').append(datas.summary);
                    }
                })
            },
            yes:function(index){

                layer.close(index);
            },
        });
    });

    //编辑会议纪要
    $('.pagediv').on('click','.edtiSummary',function (event){
        var sid=$(this).attr("sid");
        event.stopPropagation();
        layer.open({
            type: 1,
            title:['<fmt:message code="doc.th.EditMeetingMinutes" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['500px', '400px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            content: '<div class="div_table" style="margin-left: 15px;">' +
            '<div class="div_tr"><span class="span_td"><fmt:message code="workflow.th.name" />：</span><span><input type="text" style="width: 180px; float: none" name="typeName" class="inputTd meetName" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
            '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.DesignatedReader" />：</span><span><div class="inPole" style="float: none;"><textarea  name="txt" class="recorderName" id="recoderDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
            '<div class="div_tr"><span class="span_td"><fmt:message code="sup.th.RelatedAccessories" />：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
            '<form id="uploadimgform" target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
            '<input type="file" name="file" id="uploadinputimg"  class="w-icon5" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
            '<a href="javascript:;" id="uploadimg">' +
            '<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
            '</form></div></span></div>'+
            '<div class="div_tr"><span class="span_td"><fmt:message code="doc.th.MeetingMinutesContent" />：</span><span><div class="inPole"><textarea name="meetDesc" id="meetDesc" class="meetDesc" value="6868686" style="min-width: 300px;min-height:60px;"></textarea></div></span></div>'+
            '</div>',
            success:function(){
                $.ajax({
                    url:'/MeetSummary/getMeetSummarydetail',
                    type:'get',
                    dataType:'json',
                    data:{
                        sid:sid
                    },
                    success:function(obj){
                        var data=obj.object;
                        var str='';
                        if(data.attachmentList.length>0){
                            for(var i=0;i<data.attachmentList.length;i++){
                                str+='<div class="dech" deUrl="'+data.attachmentList[i].attUrl+'"><a href="/download?'+data.attachmentList[i].attUrl+'" NAME="'+data.attachmentList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.attachmentList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.attachmentList[i].aid+'@'+data.attachmentList[i].ym+'_'+data.attachmentList[i].attachId+',"></div>';
                            }
                        }else{
                            str='';
                        }
                        $('input[name="typeName"]').val(data.meetName);
                        $('#recoderDuser').val(data.readPeopleNames);
                        $('#recoderDuser').attr('dataid', data.readPeopleId);
                        $('#meetDesc').val(data.summary);
                        $('.Attachment').append(str);
                    }
                });
                //删除附件
                $('.Attachment').on('click','.deImgs',function(){
                    var data=$(this).parents('.dech').attr('deUrl');
                    var dome=$(this).parents('.dech');
                    deleteChatment(data,dome);
                })
            },
            yes:function(index){
                if($('input[name="typeName"]').val() == '' ){
                    $.layerMsg({content:'<fmt:message code="sup.th.With*" />！',icon:2});
                    return;
                }
                var aId='';
                var uId='';
                for(var i=0;i<$('.Attachment .inHidden').length;i++){
                    aId += $('.Attachment .inHidden').eq(i).val();
                }
                for(var i=0;i<$('.Attachment .inHidden').length;i++){
                    uId += $('.Attachment a').eq(i).attr('NAME');
                }
                var paraData={
                    sid:sid,
                    meetName:   $('input[name="typeName"]').val(),
                    readPeopleId:     $('#recoderDuser').attr('dataid'),
                    summary: $('#meetDesc').val(),
                    summaryAttachmentId:aId,
                    summaryAttachmentName:uId
                }

                $.ajax({
                    url: '/MeetSummary/editMeetSummarydetail',
                    type: 'get',
                    dataType: 'json',
                    data: paraData,
                    success: function (obj) {
                        if(obj.flag){
                            $.layerMsg({content:'<fmt:message code="menuSSetting.th.editSuccess" />！',icon:1});
                        }else{
                            $.layerMsg({content:'<fmt:message code="menuSSetting.th.editFail" />！',icon:2});
                        }
                    }
                })
                layer.close(index);
            },

        });
        //删除附件
        $('.Attachment').on('click','.deImgs',function(){
            var data=$(this).parents('.dech').attr('deUrl');
            var dome=$(this).parents('.dech');
            deleteChatment(data,dome);
        })
        $('#selectRecorder').click(function(){//选人员控件（纪要员）
            user_id='recoderDuser';
            $.popWindow("../common/selectUser");
        });
        $('#clearRecoder').click(function(){ //清空人员（纪要员）
            $('#recoderDuser').attr('user_id','');
            $('#recoderDuser').attr('dataid','');
            $('#recoderDuser').val('');
        });
        <%--$('#uploadimg').on('click',function(){--%>
        <%--$('#uploadinputimg').click();--%>
        <%--})--%>
        <%--$('#uploadinputimg').change(function(e){--%>
        <%--var target = $(e.target);--%>
        <%--var file;--%>
        <%--if(target[0].files && target[0].files[0]){--%>
        <%--file=target[0].files[0];--%>
        <%--}--%>
        <%--if(file){--%>
        <%--$.upload($('#uploadimgform'),function(res){--%>
        <%--var data=res.obj;--%>
        <%--var str='';--%>
        <%--var str1='';--%>
        <%--console.log(res);--%>
        <%--for(var i=0;i<data.length;i++){--%>
        <%--str+='<div class="dech" deUrl="'+data[i].attUrl+'"><a href="/download?'+data[i].attUrl+'" NAME="'+data[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data[i].attachName+'</a><img class="deImg" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',"></div>';--%>
        <%--/*str1+='<input type="hidden" class="inHidden" value="'+data[i].aid+'@'+data[i].ym+'_'+data[i].attachId+',">';*/--%>
        <%--}--%>
        <%--$('.Attachment').append(str);--%>
        <%--});--%>
        <%--}--%>
        <%--});--%>

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

    })

    //附件删除
    function deleteChatment(data,element){

        layer.confirm('<fmt:message code="menuSSetting.th.isdeleteMenu" />？', {
            btn: ['<fmt:message code="global.lang.ok" />','<fmt:message code="depatement.th.quxiao" />'], //按钮
            title:"<fmt:message code="notice.th.DeleteAttachment" />"
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
    $(function() {
        //点击二维码后的弹框attendQR
        $('#already').on('click', '.attendQR', function () {
            var meetingId = $(this).attr('sid');
            var str = "";
            layer.open({
                type: 1,
                /* skin: 'layui-layer-rim', //加上边框 */
                offset: '80px',
                area: ['650px', '400px'], //宽高
                title: "二维码打卡",
                closeBtn: 1,
                content: '<div class="qrTotal"><div class="qrCenter" style="margin-left: 200px;margin-top: 36px;"><span class="showQRCode" id="showQRCode"  style="display: inline-block;"></span></div></div>',
                btn: ['<fmt:message code="global.lang.close" />'],
                success: function () {
                    var qrcode = new QRCode(document.getElementById("showQRCode"), {
                        width: 250,//设置宽高
                        height: 250
                    });
                    str = '{"mark":"SID_MEETING","sid":' + meetingId + '}';
                    qrcode.makeCode(str);
                },
                end: function (index) {
//                clearTimeout(timer);
                    layer.close(index);
                }
            })
        })
    })

</script>
</body>
</html>
