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
<html>
<head>
	<title><fmt:message code="meet.th.ConferenceQuery" /></title>
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
		.btnSpan{
			width:78px;
		}
		#laydate_hms{
			display: none!important;
		}
		#laydate_clear{
			text-align: center;
			width: 50px;
			margin-right: 15px;
			display: block;
			border-right: 1px solid #ccc;
		}
		#laydate_today{
			text-align: center;
			width: 50px;
			margin-right: 15px;
			display: block;
			border-right: 1px solid #ccc;
		}
		#laydate_ok{
			width: 50px;
			display: block;
			text-align: center;
		}
	</style>
	<%--<link rel="stylesheet" href="/css/base.css">--%>
	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script src="/lib/layer/layer.js?20201106"></script>
	<script src="/js/base/base.js"></script>
	<script src="/lib/laydate/laydate.js"></script>
	<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="font-family: 微软雅黑;">
<div class="headTop">
	<div class="headImg">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_conQuery.png" alt="">
	</div>
	<div class="divTitle">
		<fmt:message code="meet.th.ConferenceQuery" />
	</div>
</div>
<div class="main">
	<div class="byDepart">
		<div class="queryConditon">
			<span style="margin-left: 20px;"><fmt:message code="workflow.th.name" />：</span>
			<input type="text" name="meetName" id="meetName" style="border:1px solid rgb(235,235,235);">
			<%--<a href="javascript:;">选择</a><a href="javascript:;">清空</a>--%>
			<span><fmt:message code="email.th.time" />：</span>
			<input type="text" name="startTime" id="startTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" style="border:1px solid rgb(235,235,235);">
			<span style="margin: 0 5px;"><fmt:message code="global.lang.to" /></span>
			<input type="text" name="endTime" id="endTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" style="border:1px solid rgb(235,235,235);">
			<span><fmt:message code="sup.th.Applicant" />：</span>
			<textarea name="txt" id="userDuser" class="userName" user_id="" value="" dataid="" disabled style="min-width: 180px;min-height:30px;"></textarea>
			<a href="javascript:;" id="stateUser"><fmt:message code="global.lang.add" /></a><a href="javascript:;" id="clearState"><fmt:message code="global.lang.empty" /></a>

		</div>
		<div class="queryConditon" style="margin-top: 10px">
			<span><fmt:message code="notice.th.state" />：</span>
			<select name="selectStatus" id="status" style="margin-left: 0px;width: 160px">
				<option value="0"><fmt:message code="notice.th.all" /></option>
				<option value="1"><fmt:message code="meet.th.PendingApproval" /></option>
				<option value="2"><fmt:message code="meet.th.Ratified" /></option>
				<option value="3"><fmt:message code="meet.th.HaveHand" /></option>
				<option value="4"><fmt:message code="meet.th.unratified" /></option>
				<option value="5"><fmt:message code="meet.th.IsOver" /></option>
			</select>
			<span style="margin-left: 8px"><fmt:message code="meet.th.ConferenceRoom" />：</span>
			<select name="selectRoom" id="meetRoom" style="margin-left: 0px;width: 160px">

			</select>
			<span class="btnSpan" id="clearCondition" style="float: right; margin-right: 1.5%;"><fmt:message code="workflow.th.Reset" /></span>
			<span class="btnSpan" id="query" style="float: right;"><fmt:message code="global.lang.query" /></span>
			<span class="btnSpan" id="meetexport"  style="float: right;"><fmt:message code="interfaceSetting.th.export" /></span>
		</div>
		<div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 10px;">
			<table>
				<thead>
				<tr>
					<th width="20%" style="text-align: center"><fmt:message code="meet.th.ConferenceName" /></th>
					<th width="15%" style="text-align: center"><fmt:message code="sup.th.Applicant" /></th>
					<th width="20%" style="text-align: center"><fmt:message code="sup.th.startTime" /></th>
					<th width="20%" style="text-align: center"><fmt:message code="meet.th.EndTime" /></th>
					<th width="10%" style="text-align: center"><fmt:message code="doc.th.ConferenceStatus" /></th>
					<th width="15%" style="text-align: center"><fmt:message code="meet.th.ConferenceRoom" /></th>
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
        //申请人的添加
        $("#stateUser").on("click",function(){//选人员控件
            user_id='userDuser';
            $.popWindow("../common/selectUser?0");
        });
        $('#clearState').click(function(){ //清空人员
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



        //        列表带分页
        var ajaxPageLe={
            data:{
                page:1,//当前处于第几页
                pageSize:10,//一页显示几条
                useFlag:true
                // computationNumber:null
            },
            page:function () {
				// 更新会议状态
				$.ajax({url:'/meeting/updateStatus', async:false});
                var me=this;
                $.ajax({
                    url:'/meeting/meetingQuery',
                    type:'get',
                    data:me.data,
                    dataType:'json',
                    success:function(obj){
                        var data=obj.obj;
                        var str="";
                        for(var i=0;i<data.length;i++){
                            str+='<tr>' +
                                '<td style="text-align: center" width="20%" title="'+data[i].meetName+'"><a href="javascript:void(0);" class="meetingDetail"  sid="'+data[i].sid+'">'+data[i].meetName+'</a></td>'+
                                '<td style="text-align: center" width="15%">'+data[i].userName+'</td>'+
                                '<td style="text-align: center" width="20%">'+data[i].startTime+'</td>'+
                                '<td style="text-align: center" width="20%">'+data[i].endTime+'</td>'+
                                '<td style="text-align: center" width="10%">'+data[i].statusName+'</td>'+
                                '<td style="text-align: center" width="15%"><a href="javascript:void(0);" class="meetRoomDetail"  meetRoomId="'+data[i].meetRoomId+'">'+data[i].meetRoomName+'</a></td>' +
                                '</tr>';
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

		//导出按钮点击事件
		$("#meetexport").click(function(){
			window.location.href = '/meeting/meetingQuery?export=true&meetName='+$("#meetName").val()+'&startTime='+$("#startTime").val()+'&endTime='+$("#endTime").val()+'&status='+$("#status").val()+'&meetRoomId='+$("#meetRoom").val();
		})

        //查询按钮点击事件
        $("#query").click(function () {
            var uidId=$(".userName").attr("dataid");
            if(uidId != "" && uidId != undefined){
                var uid=uidId.substr(0,uidId.length-1);
            }
            var paraData={
                meetName:$("#meetName").val(),
                startTime:$("#startTime").val(),
                endTime:$("#endTime").val(),
                uid:uid,
                status:$("#status").val(),
                meetRoomId:$("#meetRoom").val(),
                page:1,//当前处于第几页
                pageSize:10,//一页显示几条
                useFlag:true
            }


            var ajaxPageLe={
                data:paraData,
                page:function () {
					// 更新会议状态
					$.ajax({url:'/meeting/updateStatus', async:false});
                    var me=this;
                    $.ajax({
                        url:'/meeting/meetingQuery',
                        type:'get',
                        dataType:'json',
                        data:me.data,
                        success:function(obj){
                            var data=obj.obj;
                            if(data!=undefined && data!=""){
                                var str="";
                                for(var i=0;i<data.length;i++){
									/*str+='<tr><td><a href="javascript:void(0);" class="meetingDetail"  sid="'+data[i].sid+'">'+data[i].meetName+'</a></td>'+'<td>'+data[i].userName+'</td>'+'<td>'+data[i].startTime+'</td>'+
									 '<td>'+data[i].endTime+'</td>'+'<td>'+data[i].statusName+'</td>'+'<td><a href="javascript:void(0);" class="meetRoomDetail"  meetRoomId="'+data[i].meetRoomId+'">'+data[i].meetRoomName+'</a></td></tr>';
									 */
                                    str+='<tr>' +
                                        '<td style="text-align: center" width="20%" title="'+data[i].meetName+'"><a href="javascript:void(0);" class="meetingDetail"  sid="'+data[i].sid+'">'+data[i].meetName+'</a></td>'+
                                        '<td style="text-align: center" width="15%">'+data[i].userName+'</td>'+
                                        '<td style="text-align: center" width="20%">'+data[i].startTime+'</td>'+
                                        '<td style="text-align: center" width="20%">'+data[i].endTime+'</td>'+
                                        '<td style="text-align: center" width="10%">'+data[i].statusName+'</td>'+
                                        '<td style="text-align: center" width="15%"><a href="javascript:void(0);" class="meetRoomDetail"  meetRoomId="'+data[i].meetRoomId+'">'+data[i].meetRoomName+'</a></td>' +
                                        '</tr>';
                                }
                                $("#already tbody").html(str);
								$('#dbgz_page').show();
                                me.pageTwo(obj.totleNum,me.data.pageSize,me.data.page)

                            }
                            else{
                                $("#already tbody").html("");
                                $('#dbgz_page').hide();
                                layer.msg('<fmt:message code="withdraw.th.No" />', {icon: 6});
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

        })

        //重置按钮点击事件
        $("#clearCondition").click(function(){
            $("#meetName").val("");
            $("#startTime").val("");
            $("#endTime").val("");
            $("#userDuser").removeAttr("dataid");
            $("#userDuser").val("");
            $("#status").val(0);
            $("#meetRoom").val(0);
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
				    var str='';
                if(data.attachmentList && data.attachmentList.length>0){
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
                    offset: ['30px', '400px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: [ '<fmt:message code="global.lang.close" />'],
                    content:  '<div class="table"><table style="margin:auto;">' +
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>'+data.meetName+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>'+data.subject+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>'+data.userName+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td">联系电话：</span></td><td><span>'+data.mobileNo+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>'+data.recorderName+'</span></td><tr>'+
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span>从 &nbsp;</span><span>'+data.startTime+'</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>'+data.endTime+'</span></td><tr>' +
                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>'+data.meetRoomName+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>'+data.managerName+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>'+data.attendeeOut+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>'+data.attendeeName+'</span></td><tr>'+
                    '<tr><td><span class="span_td">前台会议服务人员：</span></td><td><span>'+(data.serviceUserName || '')+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>'+data.equipmentNames+'</span></td><tr>'+
                    '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">'+str+'</td><tr>' +
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
</script>
</body>
</html>
