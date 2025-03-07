<%--<%@ page language="java" contentType="text/html; charset=UTF-8"--%>
         <%--pageEncoding="UTF-8" %>--%>
<%--<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>--%>
<%--<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>--%>
<%--<%--%>
    <%--String notifyId = request.getParameter("notifyId");--%>
    <%--String path = request.getContextPath();--%>
    <%--String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";--%>
<%--%>--%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title>会议详情</title>
    <link rel="stylesheet" href="../../css/email/m/jquery.mobile.css" />
    <link rel="stylesheet" href="../../lib/mui/mui/mui.min.css"/>
    <link rel="stylesheet" href="../../css/email/m/styles.css" />
    <link rel="stylesheet" href="../../css/email/m/style.css">
    <link rel="stylesheet" href="../../css/email/m/mail.css">
    <link rel="stylesheet" href="../../lib/mui/mui/mui.picker.min.css" />
    <%--<script type="text/javascript" src="../../lib/mui/mui/mui.picker.min.js" ></script>--%>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js" ></script>
    <script type="text/javascript" src="../../js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>

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
        }
        .nav span{
            width: 48%;
            display: inline-block;
            text-align: center;
        }
        #yspan ,#managerId{
            padding: 4px 10px;
            /*background-color: #00a0e9;*/
            color: #fff;
            border-radius: 5px;
            /*margin-left: 14px;*/
        }
        .result,.result1{
            color:#00a0e9;
            padding-left: 17px;
        }
        .mui-input-row label{
            padding-left: 0;
            font-family:'microsoft yahei';
            width: 96px;
        }
        .mui-input-row label~input{
            float: left;
            padding: 10px 0;
            width: calc(100% - 120px);
        }
        .mui-content {
            height: calc(100% - 45px);
            background: #fff;
        }
        #forms label,#forms1 label,#forms3 label,#forms4 label{
            width: 400px;
        }
        .mui-input-row span{
            /*float: right;*/
            line-height: 40px;
        }
        .mui-bar-nav~.mui-content {
            height: 100%;
            background: #fff;
            overflow: auto;
        }
        .radio_inline{
            display: inline-block;
            width: 65%;
        }
        .radio_inline label{
            width: 20%;
            padding-left: 40px;
            padding-right: 40px;
        }
        .radio_inline input[type=radio]{
            width: 15%;
            right:auto;
        }
        .must{
            color: red;
        }
    </style>
</head>
<body>

<%--<div class="content">

</div>--%>
<div class="mui-content" id="aaa" style="overflow: auto;">
    <ul>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>名称：</label><input  readonly="readonly"  type="text" class="meetName  test_null" style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>主题：</label><input  readonly="readonly"  type="text"  class=" subject test_null" style="margin-top: 10px;"  value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>申请人：</label><input  readonly="readonly"  type="text" style="margin-top: 10px;"  value="" class="test_null" id="tname"/></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="width: 100px;"><span class="must">*</span>联系电话：</label><input  readonly="readonly"  type="text" style="margin-top: 10px;"  class=" mobileNo test_null" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" style="padding:11px 0px">会议纪要员：</label><input  readonly="readonly"  type="text"  value="" class="" id="cname"/></li>
        <li class="mui-table-view-cell mui-input-row" id="demo"><span class="must">*</span>开始时间：<span class="result test_nullSpan" id="beginTime"></span></li>
        <li class="mui-table-view-cell mui-input-row"id="demo1"><span class="must">*</span>结束时间：<span class="result1 test_nullSpan " id="endTime"></span></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left"><span class="must">*</span>会议室：</label><input  readonly="readonly"  type="text" id="yspan"  style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row mui-radio"><label class="mui-left" style="padding:11px 4px">是否是视频会议：</label>
            <span class="isVideo"></span>
        </li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">审批管理员：</label><input  readonly="readonly"  type="text" id="managerId"  style="margin-top: 10px;" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left">出席人员（外部）：</label><input  readonly="readonly"  type="text"  style="margin-top: 5px;" class=" attendeeOut" value="" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" ><span class="must">*</span>出席人员（内部）：</label><input  readonly="readonly"  type="text"  style="margin-top: 17px;" value="" class=" attendee test_null" id="inName" /></li>
        <li class="mui-table-view-cell mui-input-row"><label class="mui-left" >会议室设备：</label><input  readonly="readonly"  type="text" value="" class="equipmentId"   id="equipmentName" /></li>
        <li class="mui-table-view-cell mui-input-row "><label class="mui-left" style="padding:11px 4px">写入日程安排：</label>
            <span id="isWriteCalendar"></span>  
        </li>
        <li class="mui-table-view-cell">
            <div class="new_type">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：
                <div class="fujian" style="display: inline-block"></div>
            </div>
        </li>
    </ul>
    <textarea name=""  readonly="readonly"  class="meetDesc"  style="padding: 6px 0 0 6px;width: 90%;height: 45%;margin-left: 5%;margin-top: 10px;"></textarea>
    <div style="padding: 10px;">
        <button type="button" class="mui-btn mui-btn-primary ratify" style="margin-left: 30%;margin-right: .2rem">批准</button>
        <button type="button" class="mui-btn mui-btn-primary approved" >不批准</button>
    </div>
</div>
</body>
<script>
    var fs = document.documentElement.clientWidth / 750  * 100;
    document.querySelector("html").style.fontSize = fs + "px";
    <%--var sid = <%=meetRoomId%>;--%>
    var sid=$.GetRequest().sid
    $(function(){
        $.ajax({
            url:'/meeting/queryMeetingById',
            type:'get',
            data:{
                sid:sid
            },
            dataType:'json',
            success:function(res){
                var data=res.object
                $(".meetName").val(data.meetName)
                $(".subject").val(data.subject)
                $('#tname').val(data.userName)
                $('.mobileNo').val(data.mobileNo)
                $('#cname').val(data.recorderName)
                $("#beginTime").html(data.startTime)
                $("#endTime").html(data.endTime)
                $("#yspan").val(data.meetRoomName)
                if(data.videoConfFlag=='0'){
                    $('.isVideo').html('否')
                }else{
                    $('.isVideo').html('是')
                }
                $('#managerId').val(data.managerName)
                $(".attendeeOut").val(data.attendeeOut)
                $(".attendee").val(data.attendeeName)
                $(".equipmentId").val(data.equipmentNames)
                if(data.isWriteCalednar=='0'){
                    $('#isWriteCalendar').html('否')
                }else{
                    $('#isWriteCalendar').html('是')
                }
                var arrAttach2 = data.attachmentList;
                var stra2 = '';
                if (arrAttach2 && arrAttach2.length > 0){
                    for(var i=0;i<arrAttach2.length;i++){
                        stra2+= '<div class="dech" style="max-width: 550px;" deUrl="' + encodeURI(arrAttach2[i].attUrl)+ '"><a title="'+ arrAttach2[i].attachName +'" style="display:inline-block;width:100%;overflow: hidden; word-break:break-all;white-space: nowrap;text-overflow: ellipsis;" href="/download?'+encodeURI(arrAttach2[i].attUrl)+'" NAME="' + arrAttach2[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + arrAttach2[i].attachName + '</a></div>';
                    }
                } else {
                    stra2='无附件';
                }
                $('.fujian').html(stra2)
                $(".meetDesc").val(data.meetDesc)

            }
        })
    })

    //批准
    $('.ratify').click(function () {
       $.ajax({
           url: '/meeting/updMeetStatusById',
           type: 'get',
           dataType: 'json',
           data: {
               sid: sid,
               status:2
           },
           success:function (res) {
               window.location.href='/ewx/meetingApprovalList'
           }
       })
    })
    //不批准
    $('.approved').click(function () {
        $.ajax({
            url: '/meeting/updMeetStatusById',
            type: 'get',
            dataType: 'json',
            data: {
                sid: sid,
                status:4
            },
            success:function (res) {
                window.location.href='/ewx/meetingApprovalList'
            }
        })
    })
</script>
</html>