<%--
  Created by IntelliJ IDEA.
  User: 程叶同
  Date: 2017/10/22
  Time: 14:33
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
	<title><fmt:message code="event.th.LeaderInquiry" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
	<link rel="stylesheet" href="/css/meeting/myMeeting.css">
	<link rel="stylesheet" href="/css/meeting/query.css">
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
	<link rel="stylesheet" href="/lib/pagination/style/pagination.css">
	<style>
		table tbody td{
			overflow: hidden;
			text-overflow:ellipsis;
			white-space: nowrap;
		}
		table thead{
			font-size: 13pt;
		}
		td{
			font-size: 11pt;
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
		#query {
			background: #2b7fe0 url(/img/taisousuo.png) no-repeat 9px 6px!important;
			width: 87px;
		}
		#clearCondition{
			width: 87px;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
	<%--<link rel="stylesheet" href="/css/base.css">--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script src="/lib/layer/layer.js?20201106"></script>
	<script src="/js/base/base.js"></script>
	<script src="/lib/laydate/laydate.js"></script>
	<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body style="font-family: 微软雅黑;">
<div class="headTop">
	<div class="headImg">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/lingdaochaxun.png" alt="">
	</div>
	<div class="divTitle">
		<fmt:message code="event.th.LeaderInquiry" />
	</div>
</div>
<div class="main">
	<div class="byDepart">
		<div class="queryConditon">
			<span style="margin-left: 20px;"><fmt:message code="workflow.th.name" />：</span>
			<input type="text" name="meetName" id="meetName">
			<%--<a href="javascript:;">选择</a><a href="javascript:;">清空</a>--%>
			<span><fmt:message code="email.th.time" />：</span>
			<input type="text" name="startTime" id="startTime" onclick="laydate(end)">
			<span style="margin: 0 5px;"><fmt:message code="global.lang.to" /></span>
			<input type="text" name="endTime" id="endTime" onclick="laydate(end)">
			<span><fmt:message code="sup.th.Applicant" />：</span>
			<textarea name="txt" id="userDuser" class="userName" user_id="" value="" dataid="" disabled style="min-width: 180px;min-height:30px;"></textarea>
			<a href="javascript:;" id="stateUser"><fmt:message code="global.lang.add" /></a><a href="javascript:;" id="clearState"><fmt:message code="global.lang.empty" /></a>
			<span class="btnSpan" id="query" style="margin-left: 1%"><fmt:message code="global.lang.query" /></span>
			<span class="btnSpan" id="clearCondition"><fmt:message code="workflow.th.Reset" /></span>
		</div>
		<%--<div class="queryConditon">
			&lt;%&ndash;<span><fmt:message code="notice.th.state" />：</span>
			<select name="selectStatus" id="status">
				<option value="0"><fmt:message code="notice.th.all" /></option>
				<option value="1"><fmt:message code="meet.th.PendingApproval" /></option>
				<option value="2"><fmt:message code="meet.th.Ratified" /></option>
				<option value="3"><fmt:message code="meet.th.HaveHand" /></option>
				<option value="4"><fmt:message code="meet.th.unratified" /></option>
				<option value="5"><fmt:message code="meet.th.IsOver" /></option>
			</select>
			<span><fmt:message code="meet.th.ConferenceRoom" />：</span>
			<select name="selectRoom" id="meetRoom">

			</select>&ndash;%&gt;
			<span class="btnSpan" id="query" style="margin-left: 45%"><fmt:message code="global.lang.query" /></span>
			<span class="btnSpan" id="clearCondition"><fmt:message code="workflow.th.Reset" /></span>
		</div>--%>

		<div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 10px;">
			<table>
				<thead>
				<tr>
					<%--<th style="text-align: center" width="3%">选择</th>--%>
					<th style="text-align: center" width="13%">开始时间</th>
					<th style="text-align: center" width="13%">结束时间</th>
					<th style="text-align: center" width="15%">活动名称</th>
					<th style="text-align: center" width="8%"><fmt:message code="sup.th.Applicant" /></th>
					<th style="text-align: center" width="12%"><fmt:message code="event.th.Organizer" /></th>
					<th style="text-align: center" width="8%"><fmt:message code="event.th.place" /></th>
					<%--<th style="text-align: center" width="12%"><fmt:message code="event.th.Participant" /></th>--%>
					<%--<th style="text-align: center" width="16%">操作</th>--%>
				</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
		<div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 2%">

		</div>
	</div>
</div>

<script>
    var user_id='';
    //时间控件调用
    var start = {
        format: 'YYYY-MM-DD hh:mm:ss',
        istime: true,
        /*istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }*/
    };
    var end = {
        format: 'YYYY-MM-DD hh:mm',
		/*min: laydate.now(),*/
		/*max: '2099-06-16 23:59:59',*/
        istime: true,
        /*istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }*/
    };
    function look(id) {
        $.popWindow("leaderDetail?id="+id,'领导活动安排详细信息','0','0','1150px','600px');
    }

    $(function () {
        //申请人的添加
        $("#stateUser").on("click",function(){//选人员控件
            user_id='userDuser';
            $.popWindow("../common/selectUser?0");
        });
        $('#clearState').on("click",function(){ //清空人员
            $('#userDuser').attr('user_id','');
            $('#userDuser').attr('dataid','');
            $('#userDuser').val('');
        });

        //会议室下拉列表
        $.ajax({
            url:'/meetingRoom/getAllMeetRoomInfo',
            type:'get',
            dataType:'json',
            success:function(obj){
                $("#meetRoom").html("");
                var data=obj.obj;
              $("#meetRoom").append('<option value="'+0+'"><fmt:message code="meet.th.Choosemeetingroom" /></option>');
                for(var i=0;i<data.length;i++){
                    $("#meetRoom").append('<option value="'+data[i].sid+'">'+data[i].mrName+'</option>');
                }
            }
        });

        //会议列表显示
        var ajaxPageLe={
            data:{
                page:1,//当前处于第几页
                pageSize:5,//一页显示几条
                useFlag:true,
                query:'query'
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

                            str +="<tr sid='"+data.obj[i].id+"'>"+
                                "<td style='text-align:center;' >"+data.obj[i].beginTimeStr+"</td>" +
                                "<td style='text-align:center;' >"+data.obj[i].endTimeStr+"</td>" +
                                "<td style='text-align:center;color:#59b7fb;cursor:pointer' onclick='look("+data.obj[i].id+")'>"+data.obj[i].scheduleType+"</td>" +
                                "<td style='text-align:center;' >"+data.obj[i].appUser+"</td>" +
                                "<td style='text-align:center;'><span rel='tooltip' title='' data-original-title='undertake'>"+data.obj[i].undertake+"</span></td>" +
                                "<td style='text-align:center;' ><span rel='tooltip' title='' data-original-title='location'>"+data.obj[i].location+"</span></td>"
//                        "<td style='text-align:center;' width='8%'>"+data.obj[i].attentee+"</td>" +



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



        //查询按钮点击事件
        $("#query").on("click",function () {
            var create_user=$(".userName").attr("dataid");

            if(create_user!=""){
                create_user=parseInt(create_user);
            }

            if($("#startTime").val()==""){
                var begin=''
			}else{
                var begin=$("#startTime").val()+':00';
                begin=js_strto_time(begin) + '000';
			}
			if($("#endTime").val()==""){
                var end=''
			}else{
                var end=$("#endTime").val()+':00';
                end=js_strto_time(end) + '000';
			}


            // if(begin!=""&&begin!=null) {
            //     begin = new Date(begin).getTime();
            // }else{
            //     begin=0;
			// }
            // if(end!=""&&end!=null){
            //     end=new Date(end).getTime();
			// }else{
            //     begin=0;
			// }


//            var paraData={
//                subject:$("#meetName").val(),
//                begin_time:begin,
//                end_time:end,
//                create_user:create_user,
//                query:'query'
//            }
            <%--$.ajax({--%>
                <%--url:'/leaderschedule/queryLeaderActiveAll',--%>
                <%--type:'get',--%>
                <%--dataType:'json',--%>
                <%--data:paraData,--%>
                <%--success:function(data){--%>

                    <%--if(data.obj!=undefined && data.obj!=""){--%>
                    <%--var str="";--%>
                        <%--for (var i = 0; i < data.obj.length; i++) {--%>

                            <%--str +="<tr sid='"+data.obj[i].id+"'>"+--%>
                                <%--"<td style='text-align:center;' >"+data.obj[i].beginTimeStr+"</td>" +--%>
                                <%--"<td style='text-align:center;' >"+data.obj[i].endTimeStr+"</td>" +--%>
                                <%--"<td style='text-align:center;color:#59b7fb;cursor:pointer' onclick='look("+data.obj[i].id+")'>"+data.obj[i].scheduleType+"</td>" +--%>
                                <%--"<td style='text-align:center;' >"+data.obj[i].appUser+"</td>" +--%>
                                <%--"<td style='text-align:center;'><span rel='tooltip' title='' data-original-title='undertake'>"+data.obj[i].undertake+"</span></td>" +--%>
                                <%--"<td style='text-align:center;' ><span rel='tooltip' title='' data-original-title='location'>"+data.obj[i].location+"</span></td>"--%>
<%--//                        "<td style='text-align:center;' width='8%'>"+data.obj[i].attentee+"</td>" +--%>



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
                    page:1,//当前处于第几页
                    pageSize:5,//一页显示几条
                    useFlag:true,
                    // computationNumber:null
                    schedule_type:$("#meetName").val(),
                    begin_time:begin,
                    end_time:end,
                    create_user:create_user,
                    query:'query'
                },
                page:function () {
                    var me=this;
                    $.ajax({
                        url:'/leaderschedule/queryLeaderActiveAll',
                        type:'get',
                        data:me.data,
                        dataType:'json',
                        success:function(data) {
                            if (data.obj != undefined && data.obj != "") {

                                var str = "";
                                for (var i = 0; i < data.obj.length; i++) {

                                    str += "<tr sid='" + data.obj[i].id + "'>" +
                                        "<td style='text-align:center;' >" + data.obj[i].beginTimeStr + "</td>" +
                                        "<td style='text-align:center;' >" + data.obj[i].endTimeStr + "</td>" +
                                        "<td style='text-align:center;color:#59b7fb;cursor:pointer' onclick='look(" + data.obj[i].id + ")'>" + data.obj[i].scheduleType + "</td>" +
                                        "<td style='text-align:center;' >" + data.obj[i].appUser + "</td>" +
                                        "<td style='text-align:center;'><span rel='tooltip' title='' data-original-title='undertake'>" + data.obj[i].undertake + "</span></td>" +
                                        "<td style='text-align:center;' ><span rel='tooltip' title='' data-original-title='location'>" + data.obj[i].location + "</span></td>"
//                        "<td style='text-align:center;' width='8%'>"+data.obj[i].attentee+"</td>" +


									/*"<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>" +*/
//
//                    if($.cookie("uid")==1&&data.obj[i].status=='未审批'){
//                        str+="<td style='text-align:center;' width='8%'  ><a class='td-link-icon' title='' rel='tooltip' href='javascript:void(0);' onclick=\"commitLeaderActivity('"+data.obj[i].id+"');\" data-original-title='审批'><i class='icon-pencil-5'></i>审批</a></td>";
//                    }else{
//                        str+="<td style='text-align:center;' width='8%'  ></td>";
//                    }
                                    str += "</tr>";

                                }
                                $("#already tbody").html(str);
                                me.pageTwo(data.totleNum, me.data.pageSize, me.data.page)
                            }else{
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
        $("#clearCondition").on("click",function(){
            $("#meetName").val("");
            $("#startTime").val("");
            $("#endTime").val("");
            $("#userDuser").attr("dataid","");
            $("#userDuser").attr("");
            $("#userDuser").val("");
            $("#status").val(0);
            $("#meetRoom").val(0);
            $("#stateUser").val("");

        })
    })

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
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['600px', '500px'],
                    offset: ['30px', '400px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: [ '<fmt:message code="global.lang.close" />'],
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
                    '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole"></td><tr>' +
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>'+data.meetDesc+'</span></td><tr>'+
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
                    offset: ['50px', '150px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: [ '<fmt:message code="global.lang.close" />'],
                    content: str
                })
            }
        })
    })

    function js_strto_time(str_time){
        var new_str = str_time.replace(/:/g,"-");
        new_str = new_str.replace(/ /g,"-");
        var arr = new_str.split("-");
        var datum = new Date(Date.UTC(arr[0],arr[1]-1,arr[2],arr[3]-8,arr[4],arr[5]));
        return strtotime = datum.getTime()/1000;

    }
</script>
</body>
</html>
