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
    <title><fmt:message code="event.th.LeadershipActivitiesArrangement" /></title>
    <link rel="stylesheet" href="/css/meeting/index.css">
    <link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.print.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/css/meeting/myMeeting.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <style>
        table tbody tr td:nth-child(1){
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
        }
        .pagediv tr {
            height: 50px;!important;
        }
        table thead{
            font-size: 13pt;
        }
        td{
            font-size: 11pt;
        }.btnSpan{
            width:98px;
                 }
    </style>
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <%--<script src="/js/meeting/Mymeeting.js"></script>--%>
    <script src="/js/base/base.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>

    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
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
        #newActivity{
            padding-left:25px;!important;
        }
        .newActivity {
            float: right;
            width: 70px;
            height: 28px;
            background: url(../../img/file/cabinet01.png) no-repeat;
            color: #fff;
            font-size: 14px;
            line-height: 28px;
            margin-right: 4%;
            margin-top: 8px;
            cursor: pointer;
        }
        .queryConditon span{
            margin-left: 20px !important;
        }
        .edit_btn,.del_btn,.detail_btn{
            cursor:pointer;
        }
        tfoot div{
            float:left;
        }
        #del{
            background:url(../../img/news/btn_delete_min_03.png) 0px 0px no-repeat;
            background-size: 62px;
            font-size: 12px;
            width: 50px;
            height: 28px;
            line-height: 25px;
            padding-left: 13px;
            margin-left:20px;
            cursor:pointer;
            margin-top: 8px;
        }
        #allDel{
            background:url(../../img/news/btn_delete_fourfont_07.png) 0px 0px no-repeat;
            font-size: 12px;
            width: 72px;
            height: 28px;
            line-height: 25px;
            padding-left: 14px;
            margin-left:10px;
            cursor:pointer;
            margin-top: 8px;
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

        .queryConditon input{
            width: 140px;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/lingdaohuodong.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="event.th.LeadershipActivitiesArrangement" />
    </div>
    <div class="newActivity">
        <span class="btnSpans"  id="newActivity"><img style="margin-right: 4px;margin-left: -16px;margin-bottom: -1px;" src="../../img/mywork/newbuildworjk.png" alt=""><fmt:message code="global.lang.new" /></span>
    </div>

</div>
<div class="main">
    <div class="byDepart">
        <div class="queryConditon" style="float: left;margin-bottom: 12px">
            <span style="margin-left: 20px;"><fmt:message code="event.th.NameActivity" />：</span>
            <input type="text" name="taskClass" id="meetName">
            <span style="margin-left: 20%;"><fmt:message code="email.th.time" />：</span>
            <input type="text" name="startTime" id="startTime" onclick="laydate(end)">
            <span style="margin: 0 5px;"><fmt:message code="global.lang.to" /></span>
            <input type="text" name="endTime" id="endTime" onclick="laydate(end)">
            <span class="btnSpan" id="query"><fmt:message code="global.lang.query" /></span>
            <span class="btnSpan" id="clearCondition"><fmt:message code="workflow.th.Reset" /></span>

        </div>

        <div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 10px;">
            <table id="tr_td">
                <thead>
                <tr>
                    <th style="text-align: center" width="3%"><fmt:message code="notice.th.chose" /></th>
                    <th style="text-align: center" width="13%"><fmt:message code="sup.th.startTime" /></th>
                    <th style="text-align: center" width="13%"><fmt:message code="meet.th.EndTime" /></th>
                    <th style="text-align: center" width="15%"><fmt:message code="event.th.ActiveName" /></th>
                    <th style="text-align: center" width="8%"><fmt:message code="sup.th.Applicant" /></th>
                    <th style="text-align: center" width="12%"><fmt:message code="event.th.Organizer" /></th>
                    <th style="text-align: center" width="8%"><fmt:message code="event.th.place" /></th>
                    <%--<th style="text-align: center" width="12%"><fmt:message code="event.th.Participant" /></th>--%>
                    <th style="text-align: center" width="16%"><fmt:message code="notice.th.operation" /></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot>
                <tr>
                    <td colspan="8">
                        <div style="margin-left: 1%">
                            <input id="allChoose" type="checkbox">
                            <span><fmt:message code="notice.th.allchose" /></span>
                        </div>
                        <div id="del">
                            <fmt:message code="global.lang.delete" />
                        </div>
                        <%--<div id="allDel">--%>
                            <%--<fmt:message code="meet.th.DeleteAll" />--%>
                        <%--</div>--%>
                        <%-- <div id="empty">
                             <fmt:message code="notice.th.wipeData" />
                         </div>--%>
                    </td>
                </tr>
                </tfoot>
            </table>
        </div>
        <%--分页按钮--%>
        <div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

        </div>
    </div>
</div>

<script>
    var isShowSecret=false;
    var isShowSecret1=false;
    var isOpenSanyuan = false;
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 0) {
                //    进入此判断说明开启了三员管理
                isOpenSanyuan = true;
            }
        }
    })

    //        点击全选
    $('#allChoose').on("click",function(){
        var state=$(this).prop('checked');
        if(state == true){
            $(this).prop('checked',true);
            $('.childCheck').prop('checked',true);
        }else{
            $(this).prop('checked',false);
            $('.childCheck').prop('checked',false);
        }
    })

    //        点击删除
    $('#del').on("click",function(){
        var checkL=$('.childCheck:checkbox:checked').length;
        var arr=[];
        var str="";
        if(checkL != 0){
            $('.childCheck:checkbox:checked').each(function(){
                if(this.checked){
                    var sId=$(this).attr('conid');
                    arr.push(sId);

                }

            })
            layer.confirm(' <fmt:message  code="workflow.th.que"/>', {
                btn: [' <fmt:message  code="global.lang.ok"/>', ' <fmt:message  code="depatement.th.quxiao"/>'], //按钮
                title: " <fmt:message code="common.th.prompt" />"
            },function(){
                $.ajax({
                    url:'/leaderschedule/deleteByids',
                    type:'post',
                    dataType:'json',
                    data:{ids:arr.join()},
                    success:function(obj){
                        if (obj.code == '100066'){
                            layer.msg('进入删除审批，审批通过后删除', {icon: 4});
                        } else {
                            layer.msg(' <fmt:message  code="workflow.th.delsucess"/>', {icon: 6});
                        }
                        window.location.reload();
                    }
                })
            }, function () {
                layer.closeAll();
            })

        }
    })

    //后台返回的时间处理函数
    function turnTime(data){
        var browser=navigator.appName
        var b_version=navigator.appVersion
        var version=b_version.split(";");
        var trim_Version=version[1].replace(/[ ]/g,"");
//        if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0")
//        {
            data = data.replace("-", "/").replace("-", "/");
//        }

        var t = new Date(data);
        var year  = t.getFullYear();
        var month = t.getMonth()+1;
        var day = t.getDate();
        var hour =t.getHours();
        var minutes =t.getMinutes();
        var seconds = t.getSeconds();
        return year+"/"+plusZero(month)+"/"+plusZero(day)+" "+plusZero(hour)+":"+plusZero(minutes)+":"+plusZero(seconds);

    }
    //补零
    function plusZero(data){
        if(data>=10){
            return data
        }else{
            return "0"+data
        }

    }
    var user_id='';
    var dept_id='';
    var priv_id='';
    //时间控件调用
    var start = {
        format: 'YYYY/MM/DD hh:mm:ss',
        istime: true,
        /*istoday: false,
        choose: function(datas){
          //  end.min = datas; //开始日选好后，重置结束日的最小日期
         //   end.start = datas //将结束日的初始值设定为开始日
        }*/
    };
    var end = {
        format: 'YYYY/MM/DD hh:mm:ss',
        /*min: laydate.now(),*/
        /*max: '2099-06-16 23:59:59',*/
        istime: true,
        /*istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }*/
    };
    //删除
    $("#tr_td").on("click",".del_btn",function (){


        var id= $(this).attr("id");

        layer.confirm('<fmt:message code="workflow.th.que" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'],//按钮
            title: "删除领导活动安排"
        }, function () {
            //确定删除，调接口
            $.ajax({
                url: '/leaderschedule/deleteScheduleById',
                type: 'get',
                data: {
                    id: id,
                },
                dataType: 'json',
                success: function (json) {
                    if (json.code == '100066'){
                        $.layerMsg({content: '进入删除审批，审批通过后删除', icon: 4}, function () {
                            window.location.reload();
                        });
                    } else if (json.flag) {
                        $.layerMsg({content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1}, function () {
                            window.location.reload();

                        });
                    }
                }
            })
        }, function () {
            layer.closeAll();
        });
    })

    //编辑
    $("#tr_td").on("click",".edit_btn",function(){
        var id= $(this).attr("id");
        $.ajax({
            url:"/leaderschedule/selectScheduleById",
            data:{
                id:id
            },
            type:"get",
            dataType:"json",
            success:function(res){
                if(res.flag){
                    var data = res.object;
                    console.log(data)
                    var timestamp = Date.parse(new Date());
                    var timer=parseInt(timestamp)+7200000;
                    var startTime=new Date(timestamp).Format('hh:mm:ss');
                    var endTime=new Date(timer).Format('hh:mm:ss');
                    //事务提醒的回显
                    if(data.remind=='0'){
                        $('.remind').prop("checked", false);
                    }else if(data.remind=='1'){
                        $('.remind').prop("checked", true);
                    }
                    if(data.smsRemind=='0'){
                        $('.smsRemind').prop("checked", false);
                    } else if (data.smsRemind=='1'){
                        $('.smsRemind').prop("checked", true);
                    }
                    layer.open({
                        type: 1,
                        title: ['领导活动编辑', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['600px', '500px'],
                        offset: ['30px', '200px'],
                        shadeClose: true, //点击遮罩关闭
                        btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                        content: '<div class="div_table" style="">' +
                        '<div id="transactionContent" class="div_tr">' +
                        '<span class="span_td"><fmt:message code="event.th.ActiveName" />：</span>' +
                        '<span><input type="text" style="width: 180px;margin-left: 5px;" name="typeName" id="subject" class="inputTd meetName test_null" value="'+data.subject+'" /></span>' +
                        '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="email.th.Project" />：</span>'+
                        '<span><input type="text" style="width: 180px;margin-left: 5px;" name="typeName" id="schedule_type" class="inputTd subject test_null" value="'+data.scheduleType+'" /></span>' +
                        '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="event.th.Organizer" />：</span>' +
                        '<span>' +
                        '<div class="inPole">' +
                        '<textarea name="txt" dataid="" class="userName test_null" id="dept_id" deptid="'+data.undertakeId+'" value="'+data.undertake+'" disabled style="min-width: 220px;min-height:60px;">'+data.undertake+'</textarea>' +
                        '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" class="Add "><fmt:message code="global.lang.add" /></a></span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" style="color:red;" id="clearDept" class="clearUser "><fmt:message code="global.lang.empty" /></a></span>' +
                        '</div>' +
                        '</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="event.th.Leadership" />：</span>'+
                        '<span>' +
                        '<div class="inPole"><textarea name="txt" dataid="" class="recorderName" id="recoderDuser" user_id="'+data.leaderId+'" value="'+data.leader+'" disabled style="min-width: 220px;min-height:60px;">'+data.leader+'</textarea>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" style="color:red;" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span>'+
                        '</div>' +
                        '</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span>' +
                        '<span><input type="text" style="width: 140px;margin-left: 5px;" name="typeName" class="test_null inputTd startTime" id="start_time" value="'+turnTime(data.beginTimeStr)+'" onclick="laydate(end)" /></span>' +
                        '<span> <fmt:message code="global.lang.to" /> </span>' +
                        '<span><input type="text" style="width: 140px;" name="typeName" class="endTime test_null" value="'+turnTime(data.endTimeStr)+'" id="end_time" onclick="laydate(end)" /></span>' +
                        '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span>'+
                        '<span><select name="typeName" class="meetRoomId" id="meetRoomId"></select></span>' +
                        '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;"></span>' +
                        '<span><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="sup.th.Applicant" />：</span>' +
                        '<span><select name="typeName" class="managerId test_null" id="managerId" cr_userId="'+data.createUserId+'"><option value="'+data.appUser+'">'+data.appUser+'</option></select></span>' +
                        '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="event.th.place" />：</span><span><div class="inPole"><textarea name="attendeeOut" id="location" class="attendeeOut" value="'+data.location+'" style="min-width: 220px;min-height:58px;">'+data.location+'</textarea></div></span></div>' +
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.internal" />：</span><span><div class="inPole"><textarea name="txt" class="attendee" id="attendeeDuser" user_id="'+data.attenteeId+'" value="'+data.attentee+'" disabled style="min-width: 220px;min-height:60px;">'+data.attentee+'</textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee " style="color:red;"><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                        '<div class="div_tr"><span class="span_td"><fmt:message code="journal.th.Remarks" />：</span><span><div class="inPole"><textarea name="meetDesc" id="remark" class="meetDesc" value="'+data.remark+'" style="min-width: 300px;min-height:60px;">'+data.remark+'</textarea></div></span></div>' +
                        '<div class="div_tr items"><span class="span_td tixing">事务提醒:</span><span><input type="checkbox" class="remind" checked="checked">发送事务提醒消息&nbsp;&nbsp;<input type="checkbox" class="smsRemind">使用手机短信提醒</span></div>\n'+
                        '</div>',
                        success: function () {
                            // 是否允许发送事务提醒
                            if(isCan){
                                $('.remind').prop("checked", false);
                                $('.smsRemind').prop("checked", false);
                                $('.items').hide();
                            }
                            $.ajax({
                                type:'get',
                                url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                                dataType:'json',
                                success:function (res) {
                                    if(res.object.length!=0){
                                        var data1=res.object[0]
                                        if (data1.paraValue!=0){
                                            isShowSecret1=true;
                                            $('#transactionContent').after('<div style="margin-left: 103px;" class="div_tr">' +
                                                '<span>密级:</span>'+
                                                '<select id="contentSecrecy" style="height: 30px;width: 178px;margin-left: 15px;">' +
                                                '<option id="first">请选择密级</option>'+
                                                '</select>'+
                                                '<span style="color:red;font-size:14px;margin-left: 10px">*</span>'+
                                                '</div>')
                                            $.ajax({
                                                type:'get',
                                                url:'/code/getCode?parentNo=CONTENT_SECRECY',
                                                dataType:'json',
                                                success:function (res) {
                                                    var str=''
                                                    for (let i = 0; i <res.obj.length ; i++) {
                                                        if(data.contentSecrecy.indexOf(res.obj[i].codeNo)!=-1){
                                                            str += '<option selected value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                                        }else {
                                                            str += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                                        }
                                                    }
                                                    $('#first').after(str)
                                                }
                                            })

                                        }
                                    }
                                }
                            })
//                            initManager();
                            initMeetRoom(data.room_id);
                            //点击会议室名称显示会议室详情
                            $('.meetRoomDetail').on("click",function (){
                                $.ajax({
                                    url: '/meetingRoom/getMeetRoomBySid',
                                    type: 'get',
                                    dataType: 'json',
                                    data: {
                                        sid: $(".meetRoomId").val()
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
                        },
                        yes: function (index) {
                            var array=$(".test_null");
                            var attendId='';
                            var attendName='';
                            for(var i=0;i<array.length;i++){
                                if(array[i].value==""){
                                    $.layerMsg({content:"<fmt:message code="sup.th.With*" />",icon:2},function(){
                                    });
                                    return;
                                }
                            }
                            if (isShowSecret1){
                                if($('#contentSecrecy').val()==''){
                                    layer.msg('请选择密级！',{icon:0});
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
                            for(var i=0;i<$('.Attachment .inHidden').length;i++){
                                attendId += $('.Attachment .inHidden').eq(i).val();
                            }
                            for(var i=0;i<$('.Attachment .inHidden').length;i++){
                                attendName += $('.Attachment a').eq(i).attr('NAME');
                            }


                            /*var begin_time = new Date(Date.parse($("#begin_time").val().replace(/-/g, "/")));
                             var end_time=new Date(Date.parse($("#end_time").val().replace(/-/g, "/")));*/
                            var beginTime=new Date($("#start_time").val());
                            var endTime=new Date($("#end_time").val());
                            var undertake=$("#dept_id").attr('deptid');
                            if (undertake.charAt(undertake.length - 1) == ",") {
                                undertake=undertake.substring(0,undertake.length-1);
                            }
                            var leader=$("#recoderDuser").attr('user_id');
                            if (leader.charAt(leader.length - 1) == ",") {
                                leader=leader.substring(0,leader.length-1);
                            }
                            var attendee=$("#attendeeDuser").attr('user_id');
                            if (attendee.charAt(attendee.length - 1) == ",") {
                                attendee=attendee.substring(0,attendee.length-1);
                            }
                            var createUser=$("#managerId").attr('cr_userId');
                            if (createUser.charAt(createUser.length - 1) == ",") {
                                createUser=createUser.substring(0,createUser.length-1);
                            }
                            var para={
                                id:data.id,
                                subject:$("#subject").val(),
                                scheduleType:$("#schedule_type").val(),
                                /*undertake:$("#dept_id").val().substring(0,$("#dept_id").val().length-1),*/
                                undertake:undertake,
                                /*leader:$("#recoderDuser").val(),*/
                                leader:leader,
                                beginTime:beginTime.getTime(),
                                endTime:endTime.getTime(),
                                roomId:$("#meetRoomId").val(),
                                createUser:createUser,
                                location:$("#location").val(),
                                /*attendee:$("#attendeeDuser").val().substring(0,$("#attendeeDuser").val().length-1),*/
                                attendee:attendee,
                                remark:$("#remark").val(),
                                contentSecrecy:$("#contentSecrecy").val(),
                                remind:function(){
                                    if($('.remind').prop('checked')==false){
                                        return '0';
                                    }else {
                                        return '1';
                                    }
                                },
                                smsRemind:function(){
                                    if($('.smsRemind').prop('checked')==false){
                                        return '0';
                                    }else {
                                        return '1';
                                    }
                                }
                            };

                            $.ajax({
                                cache: true,
                                type: "POST",
                                url:"/leaderschedule/updateSchedule",
                                data:para,
                                datatype:"json",
                                error: function(request) {
                                    alert("Connection error");
                                },
                                success: function(data) {
                                    var content=data.msg;
                                    if(data.flag!=false){
                                        $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1}, function () {

                                        });
                                        location.reload();
                                        layer.close(index);
                                    }
                                }
                            });


                        }
                    });




                    $('#selectUser').on("click",function(){//选人员控件(申请人)
                        user_id='userDuser';
                        $.popWindow("../common/selectUser?0");
                    });
                    $('#selectDept').on("click",function(){//选人员控件(申请人)
                        dept_id='dept_id';
                        $.popWindow("../common/selectDept?0");
                    });
                    $('#selectRecorder').on("click",function(){//选人员控件（纪要员）
                        user_id='recoderDuser';
                        $.popWindow("../common/selectUser");
                    });
                    $('#selectAttendee').on("click",function(){//选人员控件（出席内部人员）
                        user_id='attendeeDuser';
                        $.popWindow("../common/selectUser");
                    });
                    $('#clearUser').on("click",function(){ //清空人员(申请人)
                        $('#userDuser').attr('user_id','');
                        $('#userDuser').attr('dataid','');
                        $('#userDuser').val('');
                    });
                    $('#clearDept').on("click",function(){ //清空承办单位
                        $('#dept_id').attr('dept_id','');
                        $('#dept_id').attr('dataid','');
                        $('#dept_id').val('');
                    });
                    $('#clearRecoder').on("click",function(){ //清空人员（纪要员）
                        $('#recoderDuser').attr('user_id','');
                        $('#recoderDuser').attr('dataid','');
                        $('#recoderDuser').val('');
                    });
                    $('#clearAttendee').on("click",function(){ //清空人员（出席内部人员）
                        $('#attendeeDuser').attr('user_id','');
                        $('#attendeeDuser').attr('dataid','');
                        $('#attendeeDuser').val('');
                    });

                    //查询所有办公设备？？？
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
                    $(".addEquipment").on("click",function(){
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
                                $(".equipClick").on("click",function(){
                                    $(this).toggleClass('equipSpan');
                                })
                                $("#addAll").on("click",function(){
                                    $(".equipClick").addClass('equipSpan');
                                })
                                $("#delAll").on("click",function(){
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
                    $(".clearEquipment").on("click",function(){
                        $(".equipmentId").attr("equipmentId","");
                        $(".equipmentId").val("");
                    })


                }

            }
        })







        $('#selectUser').on("click",function(){//选人员控件(申请人)
            user_id='userDuser';
            $.popWindow("../common/selectUser?0");
        });
        $('#selectDept').on("click",function(){//选人员控件(申请人)
            dept_id='dept_id';
            $.popWindow("../common/selectDept?0");
        });
        $('#selectRecorder').on("click",function(){//选人员控件（纪要员）
            user_id='recoderDuser';
            $.popWindow("../common/selectUser");
        });
        $('#selectAttendee').on("click",function(){//选人员控件（出席内部人员）
            user_id='attendeeDuser';
            $.popWindow("../common/selectUser");
        });
        $('#clearUser').on("click",function(){ //清空人员(申请人)
            $('#userDuser').attr('user_id','');
            $('#userDuser').attr('dataid','');
            $('#userDuser').val('');
        });
        $('#clearDept').on("click",function(){ //清空承办单位
            $('#dept_id').attr('dept_id','');
            $('#dept_id').attr('dataid','');
            $('#dept_id').val('');
        });
        $('#clearRecoder').on("click",function(){ //清空人员（纪要员）
            $('#recoderDuser').attr('user_id','');
            $('#recoderDuser').attr('dataid','');
            $('#recoderDuser').val('');
        });
        $('#clearAttendee').on("click",function(){ //清空人员（出席内部人员）
            $('#attendeeDuser').attr('user_id','');
            $('#attendeeDuser').attr('dataid','');
            $('#attendeeDuser').val('');
        });



    })


    //        列表带分页
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
                url:'/leaderschedule/queryLeaderActiveAll',
                type:'get',
                data:me.data,
                dataType:'json',
                success:function(data){

                    var str = "";
                    for (var i = 0; i < data.obj.length; i++) {

                        str +="<tr sid='"+data.obj[i].id+"'><td style='text-align:center;' ><input class='childCheck' type='checkbox' conid="+data.obj[i].id+" name='check' value=''></td>" +
                            "<td style='text-align:center;' >"+data.obj[i].beginTimeStr+"</td>" +
                            "<td style='text-align:center;' >"+data.obj[i].endTimeStr+"</td>" +
                            "<td style='text-align:center;color:#59b7fb;cursor:pointer' onclick='look("+data.obj[i].id+")'>"+data.obj[i].scheduleType+"</td>" +
                            "<td style='text-align:center;' >"+data.obj[i].appUser+"</td>" +
                            "<td style='text-align:center;'><span rel='tooltip' title='' data-original-title='undertake'>"+data.obj[i].undertake+"</span></td>" +
                            "<td style='text-align:center;' ><span rel='tooltip' title='' data-original-title='location'>"+data.obj[i].location+"</span></td>" +
//                        "<td style='text-align:center;' width='8%'>"+data.obj[i].attentee+"</td>" +
                            "<td><a class='detail_btn' id='"+data.obj[i].id+"'><fmt:message code="roleAuthorization.th.ViewDetails" /></a>&nbsp;&nbsp;<a class='edit_btn' id='"+data.obj[i].id+"'><fmt:message code='global.lang.edit'/></a>" +
                            "&nbsp;&nbsp;" +
                            "<a class='del_btn'style='color:red' id='"+data.obj[i].id+"'><fmt:message code='global.lang.delete' /></a>"+

                            "</td>";


                        /*"<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>" +*/
//
//                    if($.cookie("uid")==1&&data.obj[i].status=='未审批'){
//                        str+="<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>";
//                    }else{
//                        str+="<td style='text-align:center;' width='8%'  ></td>";
//                    }
                        str+="</tr>";

                    }
                    $("#already tbody").html(str);
                    if(isOpenSanyuan){
                        $('.edit_btn').hide();
                    }else{
                        $('.edit_btn').show();
                    };
                    me.pageTwo(data.totleNum,me.data.pageSize,me.data.page)
                }
            })

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

    //详情
    $(document).on('click','.detail_btn',function () {
        var id= $(this).attr("id");
        $.popWindow("leaderDetail?id="+id,'领导活动安排详细信息','0','0','1150px','600px');

    })

    function look(id) {
        $.popWindow("leaderDetail?id="+id,'领导活动安排详细信息','0','0','1150px','600px');
    }

        //查询按钮点击事件
        $("#query").on("click",function () {
            var create_user=$(".userName").attr("dataid");
            if(create_user!=""){
                create_user=parseInt(create_user);
            }

            var begin=$("#startTime").val();
            var end=$("#endTime").val();
            if(begin>end){
                layer.msg("开始时间不能大于结束时间",{icon:2},function(){

                });
                return false;
            }
            if(begin!=""&&begin!=null) {
                begin = new Date(begin).getTime();

            }else{
                begin=0;
            }
            if(end!=""&&end!=null){
                end=new Date(end).getTime();
            }else{
                end=0;
            }


            <%--var paraData={--%>
                <%--subject:$("#meetName").val(),--%>
                <%--begin_time:begin,--%>
                <%--end_time:end--%>
            <%--}--%>
            <%--$.ajax({--%>
                <%--url:'/leaderschedule/queryLeaderActiveAll',--%>
                <%--type:'get',--%>
                <%--dataType:'json',--%>
                <%--data:paraData,--%>
                <%--success:function(data){--%>

                    <%--if(data.obj!=undefined && data.obj!=""){--%>
                        <%--var str="";--%>
                        <%--for (var i = 0; i < data.obj.length; i++) {--%>

                            <%--str +="<tr sid='"+data.obj[i].id+"'><td style='text-align:center;' ><input class='childCheck' type='checkbox' conid="+data.obj[i].id+" name='check' value=''></td>" +--%>
                                <%--"<td style='text-align:center;' >"+data.obj[i].beginTimeStr+"</td>" +--%>
                                <%--"<td style='text-align:center;' >"+data.obj[i].endTimeStr+"</td>" +--%>
                                <%--"<td style='text-align:center;color:#59b7fb;cursor:pointer' onclick='look("+data.obj[i].id+")'>"+data.obj[i].scheduleType+"</td>" +--%>
                                <%--"<td style='text-align:center;' >"+data.obj[i].appUser+"</td>" +--%>
                                <%--"<td style='text-align:center;'><span rel='tooltip' title='' data-original-title='undertake'>"+data.obj[i].undertake+"</span></td>" +--%>
                                <%--"<td style='text-align:center;' ><span rel='tooltip' title='' data-original-title='location'>"+data.obj[i].location+"</span></td>" +--%>
<%--//                        "<td style='text-align:center;' width='8%'>"+data.obj[i].attentee+"</td>" +--%>
                                <%--"<td><a class='edit_btn' id='"+data.obj[i].id+"'><fmt:message code='global.lang.edit'/></a>" +--%>
                                <%--"&nbsp;&nbsp;" +--%>
                                <%--"<a class='del_btn'style='color:red' id='"+data.obj[i].id+"'><fmt:message code='global.lang.delete' /></a>"+--%>
                                <%--"&nbsp;&nbsp;" +--%>
                                <%--"<a class='detail_btn' id='"+data.obj[i].id+"'>查看详情</a>"+--%>
                                <%--"</td>";--%>


                            <%--/*"<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>" +*/--%>
<%--//--%>
<%--//                    if($.cookie("uid")==1&&data.obj[i].status=='未审批'){--%>
<%--//                        str+="<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>";--%>
<%--//                    }else{--%>
<%--//                        str+="<td style='text-align:center;' width='8%'  ></td>";--%>
<%--//                    }--%>
                            <%--str+="</tr>";--%>

                        <%--}--%>
                        <%--$("#already tbody").html(str);--%>
                    <%--}--%>
                    <%--else{--%>
                        <%--$("#already tbody").html("");--%>
                        <%--layer.msg('<fmt:message code="event.th.NoInformation" />', {icon: 6});--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>

            var ajaxPageLe={
                data:{
                    schedule_type:$("#meetName").val(),
                    begin_time:begin,
                    end_time:end,
                    page:1,//当前处于第几页
                    pageSize:5,//一页显示几条
                    useFlag:true
                    // computationNumber:null
                },
                page:function () {
                    var me=this;
                    $.ajax({
                        url:'/leaderschedule/queryLeaderActiveAll',
                        type:'get',
                        data:me.data,
                        dataType:'json',
                        success:function(data){
                            if(data.obj!=undefined && data.obj!="") {

                                var str = "";
                                for (var i = 0; i < data.obj.length; i++) {

                                    str +="<tr sid='"+data.obj[i].id+"'><td style='text-align:center;' ><input class='childCheck' type='checkbox' conid="+data.obj[i].id+" name='check' value=''></td>" +
                                        "<td style='text-align:center;' >"+data.obj[i].beginTimeStr+"</td>" +
                                        "<td style='text-align:center;' >"+data.obj[i].endTimeStr+"</td>" +
                                        "<td style='text-align:center;color:#59b7fb;cursor:pointer' onclick='look("+data.obj[i].id+")'>"+data.obj[i].scheduleType+"</td>" +
                                        "<td style='text-align:center;' >"+data.obj[i].appUser+"</td>" +
                                        "<td style='text-align:center;'><span rel='tooltip' title='' data-original-title='undertake'>"+data.obj[i].undertake+"</span></td>" +
                                        "<td style='text-align:center;' ><span rel='tooltip' title='' data-original-title='location'>"+data.obj[i].location+"</span></td>" +
//                        "<td style='text-align:center;' width='8%'>"+data.obj[i].attentee+"</td>" +
                                        "<td><a class='detail_btn' id='"+data.obj[i].id+"'><fmt:message code="roleAuthorization.th.ViewDetails" /></a>&nbsp;&nbsp;<a class='edit_btn' id='"+data.obj[i].id+"'><fmt:message code='global.lang.edit'/></a>" +
                                        "&nbsp;&nbsp;" +
                                        "<a class='del_btn'style='color:red' id='"+data.obj[i].id+"'><fmt:message code='global.lang.delete' /></a>"+

                                        "</td>";


                                    /*"<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>" +*/
//
//                    if($.cookie("uid")==1&&data.obj[i].status=='未审批'){
//                        str+="<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>";
//                    }else{
//                        str+="<td style='text-align:center;' width='8%'  ></td>";
//                    }
                                    str+="</tr>";

                                }
                            $("#already tbody").html(str);
                                if(isOpenSanyuan){
                                    $('.edit_btn').hide();
                                }else{
                                    $('.edit_btn').show();
                                };
                            me.pageTwo(data.totleNum,me.data.pageSize,me.data.page)
                        }
                            else{
                                $("#already tbody").html("");
                                layer.msg('<fmt:message code="event.th.NoInformation" />', {icon: 6});
                            }
                        }

                    })

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
        })

        //重置按钮点击事件
        $("#clearCondition").on("click",function () {
            $("#meetName").val("");
            $("#startTime").val("");
            $("#endTime").val("");
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
                        url:'/leaderschedule/queryLeaderActiveAll',
                        type:'get',
                        data:me.data,
                        dataType:'json',
                        success:function(data){

                            var str = "";
                            for (var i = 0; i < data.obj.length; i++) {

                                str +="<tr sid='"+data.obj[i].id+"'><td style='text-align:center;' ><input class='childCheck' type='checkbox' conid="+data.obj[i].id+" name='check' value=''></td>" +
                                    "<td style='text-align:center;' >"+data.obj[i].beginTimeStr+"</td>" +
                                    "<td style='text-align:center;' >"+data.obj[i].endTimeStr+"</td>" +
                                    "<td style='text-align:center;color:#59b7fb;cursor:pointer' onclick='look("+data.obj[i].id+")'>"+data.obj[i].scheduleType+"</td>" +
                                    "<td style='text-align:center;' >"+data.obj[i].appUser+"</td>" +
                                    "<td style='text-align:center;'><span rel='tooltip' title='' data-original-title='undertake'>"+data.obj[i].undertake+"</span></td>" +
                                    "<td style='text-align:center;' ><span rel='tooltip' title='' data-original-title='location'>"+data.obj[i].location+"</span></td>" +
                                    //                        "<td style='text-align:center;' width='8%'>"+data.obj[i].attentee+"</td>" +
                                    "<td><a class='detail_btn' id='"+data.obj[i].id+"'><fmt:message code="roleAuthorization.th.ViewDetails" /></a>&nbsp;&nbsp;<a class='edit_btn' id='"+data.obj[i].id+"'><fmt:message code='global.lang.edit'/></a>" +
                                    "&nbsp;&nbsp;" +
                                    "<a class='del_btn'style='color:red' id='"+data.obj[i].id+"'><fmt:message code='global.lang.delete' /></a>"+

                                    "</td>";


                                /*"<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>" +*/
//
//                    if($.cookie("uid")==1&&data.obj[i].status=='未审批'){
//                        str+="<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>";
//                    }else{
//                        str+="<td style='text-align:center;' width='8%'  ></td>";
//                    }
                                str+="</tr>";

                            }
                            $("#already tbody").html(str);
                            if(isOpenSanyuan){
                                $('.edit_btn').hide();
                            }else{
                                $('.edit_btn').show();
                            };
                            me.pageTwo(data.totleNum,me.data.pageSize,me.data.page)
                        }
                    })

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
        })



    //点击会议室名称显示会议室详情？？？？干啥的？
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




    $(function(){
        $(".pagediv").on('mouseover','.QRCode',function(){
            var temp=$(this).attr('num');
            console.log("aa0"+temp)
            $(".showQRCode").html('')
            $($(".showQRCode")[temp]).qrcode({
                render: "canvas",
                width: 100,
                height:100,/*"/meeting/MeetingAttend"*/
                text:'http://192.168.0.78:8080/meeting/MeetingAttend?meetingId='+$(this).attr('sid')
            });
        })

        $(".pagediv").on('mouseout','.QRCode',function(){
            var temp=$(this).attr('num');
            $(".showQRCode").html('');
            /* $(this).next().hide()*/
        })
    })

    // 判断是否需要发送事务提醒
    var isCan = false;
    // 查询提醒权限
    $.ajax({
        type:'get',
        url:'/smsRemind/getRemindFlag',
        dataType:'json',
        data:{
            type:27
        },
        success:function (res) {
            if(res.flag){
                if(res.obj.length>0){
                    var data = res.obj[0];
                    // 是否默认发送
                    if(data.isRemind=='0'){
                        $('.remind').prop("checked", false);
                    }else if(data.isRemind=='1'){
                        $('.remind').prop("checked", true);
                    }
                    // 是否手机短信默认提醒
                    if(data.isIphone=='0'){
                        $('.smsRemind').prop("checked", false);
                    } else if (data.isIphone=='1'){
                        $('.smsRemind').prop("checked", true);
                    }
                    // 是否允许发送事务提醒
                    if(data.isCan=='0'){
                        isCan = true;
                        $('.remind').prop("checked", false);
                        $('.smsRemind').prop("checked", false);
                        $('.tixing').hide();
                    }

                }
            }
        }
    })
    $('#newActivity').on("click",function(){
       /* dayClick:function(date, allDay, jsEvent, view){*/

            var timestamp = Date.parse(new Date());
            var timer=parseInt(timestamp)+7200000;
            var startTime=new Date(timestamp).Format('hh:mm:ss');
            var endTime=new Date(timer).Format('hh:mm:ss');
            layer.open({
                type: 1,
                title: ['<fmt:message code="event.th.NewLeadershipActivities" />', 'background-color:#2b7fe0;color:#fff;'],
                area: ['650px', '450px'],
                offset: ['17%', '30%'],
                shadeClose: true, //点击遮罩关闭
                btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                content: '<div class="div_table" style="">' +
                '<div id="transactionContent" class="div_tr">' +
                '<span class="span_td"><fmt:message code="event.th.ActiveName" />：</span>' +
                '<span><input type="text" style="width: 180px;margin-left: 5px;" name="typeName" id="subject" class="inputTd meetName test_null" value="" /></span>' +
                '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><fmt:message code="email.th.Project" />：</span>'+
                '<span><input type="text" style="width: 180px;margin-left: 5px;" name="typeName" id="schedule_type" class="inputTd subject test_null" value="" /></span>' +
                '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><fmt:message code="event.th.Organizer" />：</span>' +
                '<span>' +
                '<div class="inPole">' +
                '<textarea name="txt" dataid="" class="userName test_null" id="dept_id" dept_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea>' +
                '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectDept" class="Add "><fmt:message code="global.lang.add" /></a></span>' +
                '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearDept" class="clearUser "><fmt:message code="global.lang.empty" /></a></span>' +
                '</div>' +
                '</span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><fmt:message code="event.th.Leadership" />：</span>'+
                '<span>' +
                '<div class="inPole"><textarea name="txt" dataid="" class="recorderName" id="recoderDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea>' +
                '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span>' +
                '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span>'+
                '</div>' +
                '</span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span>' +
                '<span><input type="text" style="width: 140px;margin-left: 5px;" name="typeName" class="test_null inputTd startTime" id="start_time" value="" onclick="laydate(end)" /></span>' +
                '<span><fmt:message code="global.lang.to" /></span>' +
                '<span><input type="text" style="width: 140px;" name="typeName" class="endTime test_null" value="" id="end_time" onclick="laydate(end)" /></span>' +
                '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span>'+
                '<span><select name="typeName" class="meetRoomId" id="meetRoomId"></select></span>' +
                '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;"></span>' +
                '<span><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><fmt:message code="sup.th.Applicant" />：</span>' +
                '<span><select name="typeName" class="managerId test_null" id="managerId"></select></span>' +
                '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><fmt:message code="event.th.place" />：</span><span><div class="inPole"><textarea name="attendeeOut" id="location" class="attendeeOut" value="" style="min-width: 220px;min-height:58px;"></textarea></div></span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.internal" />：</span><span><div class="inPole"><textarea name="txt" class="attendee" id="attendeeDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="journal.th.Remarks" />：</span><span><div class="inPole"><textarea name="meetDesc" id="remark" class="meetDesc" value="" style="min-width: 300px;min-height:60px;"></textarea></div></span></div>' +
                 '<div class="div_tr items"><span class="span_td tixing">事务提醒:</span><span><input type="checkbox" class="remind" checked>发送事务提醒消息&nbsp;&nbsp;<input type="checkbox" class="smsRemind">使用手机短信提醒</span></div>\n'+
                '</div>',
                success: function () {
                    // 是否允许发送事务提醒
                    if(isCan){
                        $('.remind').prop("checked", false);
                        $('.smsRemind').prop("checked", false);
                        $('.items').hide();
                    }
                    $.ajax({
                        type:'get',
                        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                        dataType:'json',
                        success:function (res) {
                            if(res.object.length!=0){
                                var data=res.object[0]
                                if (data.paraValue!=0){
                                    isShowSecret=true;
                                    $('#transactionContent').after('<div style="margin-left: 103px;" class="div_tr">' +
                                        '<span>密级:</span>'+
                                        '<select id="contentSecrecy" style="height: 30px;width: 178px;margin-left: 15px;">' +
                                        '<option id="first">请选择密级</option>'+
                                        '</select>'+
                                        '<span style="color:red;font-size:14px;margin-left: 10px;">*</span>'+
                                        '</div>')
                                    $.ajax({
                                        type:'get',
                                        url:'/code/getCode?parentNo=CONTENT_SECRECY',
                                        dataType:'json',
                                        success:function (res) {
                                            var str=''
                                            for (let i = 0; i <res.obj.length ; i++) {
                                                str += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                            }
                                            $('#first').after(str)
                                        }
                                    })

                                }
                            }
                        }
                    })
                    initManager();
                    initMeetRoom();
                    //点击会议室名称显示会议室详情
                    $('.meetRoomDetail').on("click",function (){
                        $.ajax({
                            url: '/meetingRoom/getMeetRoomBySid',
                            type: 'get',
                            dataType: 'json',
                            data: {
                                sid: $(".meetRoomId").val()
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
                },
                yes: function (index) {
                    var array=$(".test_null");
                    var attendId='';
                    var attendName='';
                    for(var i=0;i<array.length;i++){
                        if(array[i].value==""){
                            $.layerMsg({content:"<fmt:message code="sup.th.With*" />",icon:2},function(){
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
                    for(var i=0;i<$('.Attachment .inHidden').length;i++){
                        attendId += $('.Attachment .inHidden').eq(i).val();
                    }
                    for(var i=0;i<$('.Attachment .inHidden').length;i++){
                        attendName += $('.Attachment a').eq(i).attr('NAME');
                    }
                    if($('#start_time').val() == ''){
                        layer.msg('请选择申请开始时间',{icon:6});
                        return false;
                    }
                    if($('#end_time').val() == ''){
                        layer.msg('请选择申请结束时间',{icon:6});
                        return false;
                    }
                    if (isShowSecret){
                        if($('#contentSecrecy').val()==''){
                            layer.msg('请选择密级！',{icon:0});
                            return;
                        }
                    }



                    /*var begin_time = new Date(Date.parse($("#begin_time").val().replace(/-/g, "/")));
                    var end_time=new Date(Date.parse($("#end_time").val().replace(/-/g, "/")));*/
                    var beginTime=new Date($("#start_time").val());
                    var endTime=new Date($("#end_time").val());
                    var para={
                        subject:$("#subject").val(),
                        schedule_type:$("#schedule_type").val(),
                        undertake:$("#dept_id").attr('deptid').substring(0,$("#dept_id").attr('deptid').length-1),
                        leader:$("#recoderDuser").attr('user_id').substring(0,$("#recoderDuser").attr('user_id').length-1),
                        begin_time:beginTime.getTime(),
                        end_time:endTime.getTime(),
                        room_id:$("#meetRoomId").val(),
                        create_user:${uid},
                        location:$("#location").val(),
                        attendee:$("#attendeeDuser").attr('user_id').substring(0,$("#attendeeDuser").attr('user_id').length-1),
                        remark:$("#remark").val(),
                        contentSecrecy:$("#contentSecrecy").val(),
                        remind:function(){
                            if($('.remind').prop('checked')==false){
                                return '0';
                            }else {
                                return '1';
                            }
                        },
                        smsRemind:function(){
                            if($('.smsRemind').prop('checked')==false){
                                return '0';
                            }else {
                                return '1';
                            }
                        }

                    };

                    $.ajax({
                        cache: true,
                        type: "POST",
                        url:"/leaderschedule/saveSchedule",
                        data:para,
                        datatype:"json",
                        error: function(request) {
                            alert("Connection error");
                        },
                        success: function(data) {
                            var content=data.msg;

                            if(data.flag!=false){

                                location.reload();
                                layer.close(index);
                            }
                        }
                    });


                }
            });




            $('#selectUser').on("click",function(){//选人员控件(申请人)
                user_id='userDuser';
                $.popWindow("../common/selectUser?0");
            });
        $('#selectDept').on("click",function(){//选人员控件(申请人)
            dept_id='dept_id';
            $.popWindow("../common/selectDept?0");
        });
            $('#selectRecorder').on("click",function(){//选人员控件（纪要员）
                user_id='recoderDuser';
                $.popWindow("../common/selectUser");
            });
            $('#selectAttendee').on("click",function(){//选人员控件（出席内部人员）
                user_id='attendeeDuser';
                $.popWindow("../common/selectUser");
            });
            $('#clearUser').on("click",function(){ //清空人员(申请人)
                $('#userDuser').attr('user_id','');
                $('#userDuser').attr('dataid','');
                $('#userDuser').val('');
            });
        $('#clearDept').on("click",function(){ //清空承办单位
            $('#dept_id').attr('dept_id','');
            $('#dept_id').attr('dataid','');
            $('#dept_id').val('');
        });
            $('#clearRecoder').on("click",function(){ //清空人员（纪要员）
                $('#recoderDuser').attr('user_id','');
                $('#recoderDuser').attr('dataid','');
                $('#recoderDuser').val('');
            });
            $('#clearAttendee').on("click",function(){ //清空人员（出席内部人员）
                $('#attendeeDuser').attr('user_id','');
                $('#attendeeDuser').attr('dataid','');
                $('#attendeeDuser').val('');
            });

            //查询所有办公设备？？？
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
            $(".addEquipment").on("click",function(){
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
                        $(".equipClick").on("click",function(){
                            $(this).toggleClass('equipSpan');
                        })
                        $("#addAll").on("click",function(){
                            $(".equipClick").addClass('equipSpan');
                        })
                        $("#delAll").on("click",function(){
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
            $(".clearEquipment").on("click",function(){
                $(".equipmentId").attr("equipmentId","");
                $(".equipmentId").val("");
            })

    })
    //获取申请人信息
    function initManager(id){

        var userId="${userId}";
                $.ajax({
            url: '/user/getUserNameById',
            type: 'get',
            dataType: 'json',
            data: {
                userIds:userId
            },
            success: function (obj) {
                var data=obj.object;
               /* var managerIdArray=data.paraValue.split(",");
                var managerNameArray=data.userName.split(",");*/
                var str="";

                str+='<option value="'+data+'">'+data+'</option>';
               /* for(var i=0;i<managerIdArray.length;i++){

                }*/
                $(".managerId").html(str);
            }
        });
    }

    //初始化会议室下拉列表
    function initMeetRoom(id){
        $.ajax({
            url: '../../meetingRoom/getAllMeetRoom',
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                var data=obj.obj;
                var str="";
                for(var i=0;i<data.length;i++){
                    if(data[i].sid==id){
                        str+='<option value="'+data[i].sid+'" selected="selected">'+data[i].mrName+'</option>';
                    }else{
                        str+='<option value="'+data[i].sid+'">'+data[i].mrName+'</option>';
                    }

                }
                $(".meetRoomId").html(str);
            }
        });
    }
    function commitLeaderActivity(id){

        var id={id:id};
        $.ajax({
            type: "POST",
            url:"/leaderschedule/commitSchedule",
            data:id,// 你的formid
            datatype:"json",
            error: function(request) {
                alert("Connection error");
            },
            success: function(data) {
                var content=data.msg;
                if(data.flag!=false){
                    layer.msg('<fmt:message code="event.th.SubmitSuccessfully" />', {icon: 6});
                    window.location.reload();
                }
            }
        });
    }
</script>
</body>
</html>