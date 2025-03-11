<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
	<title><fmt:message code="meet.th.management" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/css/meeting/myMeeting.css">
	<link rel="stylesheet" href="/css/meeting/leader.css">
	<%--<link rel="stylesheet" href="/css/meeting/index.css">--%>
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
	<link rel="stylesheet" href="/lib/pagination/style/pagination.css">
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
		/*table tbody td{
			overflow: hidden;
			text-overflow:ellipsis;
			white-space: nowrap;
		}*/
		.tdStyle1{
			overflow: hidden;
			text-overflow:ellipsis;
			white-space: nowrap;
		}
		input{
			float: none;
		}
		input[type="checkbox"]{
			width: 15px;
			vertical-align: middle;
		}

		.leftBtn{
			float: left;
			margin-bottom: 6px;
		}
		.leftBtn span{
			display: block;
			float: left;
			margin-left: 20px;
			width: 30px;
			height: 30px;
			background-color: #e5f5fc;
			border: 1px solid #abd5eb;
			border-radius: 4px;
			cursor: pointer;
		}
		.leftBtnTwo{
			width: 60px !important;
			line-height: 30px;
			text-align: center;
			font-size: 14px;
		}
		.leftBtnOne{
			background: url("../img/meeting/icon_prev_03.png") no-repeat center;
		}
		.leftBtnThr{
			background: url("../img/meeting/icon_next_03.png") no-repeat center;
		}
		.fullTime{
			float: left;
			width: 40%;
			margin: 0 auto;
			height: 30px;
			text-align: center;
			line-height: 30px;
			font-size: 14px;
		}
		.colorClass {
			float: right;
			margin-right: 3%;
			margin-top: 5px;
		}
		.colorClass a {
			display: inline-block;
			width: 22px;
			height: 20px;
			vertical-align: middle;
		}
		.spanList{
			width: 100px;
		}
		.one{
			color: #fff;
		}
		.div_ul ul .one:hover{
			color: #fff;
		}
		.layui-layer-dialog{
			top:200px!important;
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
		.tabletd{
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			padding: 0;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
	<%--<link rel="stylesheet" href="/css/base.css">--%>
	<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
	<script src="/lib/layer/layer.js?20201106"></script>
	<script src="/js/base/base.js"></script>
	<script src="/lib/laydate/laydate.js"></script>
	<script src="/lib/layDate-v5.0.9/laydate/laydate.js"></script>
	<script src="/js/jquery/jquery.cookie.js"></script>
	<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="/lib/qrcode.js"></script>
	<script src="/js/jquery/jquery.jqprint-0.3.js"></script>

</head>
<body style="font-family: 微软雅黑;">
<div class="headTop">
	<div class="headImg">
		<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_meetingManagr.png" alt="">
	</div>
	<div class="divTitle">
		<fmt:message code="meet.th.management" />
	</div>
</div>
<div class="main" style="    margin-top: 48px;height:100%">
	<div class="mainLeft" style="height:100%">
		<div class="div_ul"  style="height:100%">
			<ul style="height:100%">
				<%--				<li class="one styleSet" onclick="listByStatus('',1)"><div class="spanList"><fmt:message code="meet.th.PendingMeeting" /></div><div class="spanNum" id="pendingCount"></div></li>--%>
				<%--				<li class="styleSet" onclick="listByStatus('',6)"><div class="spanList">待批周期性会议</div><div class="spanNum" id="cyclePendingCount"></div></li>--%>
				<li class="styleSet" onclick="listByStatus('',2)"><div class="spanList">所有会议</div><div class="spanNum" id="approvedCount"></div></li>
				<li class="styleSet" onclick="listByStatus('',3)"><div class="spanList"><fmt:message code="meet.th.InCession" /></div><div class="spanNum" id="processingCount"></div></li>
				<%--				<li class="styleSet" onclick="listByStatus('',4)"><div class="spanList"><fmt:message code="meet.th.UnauthorizedMeeting" /></div><div class="spanNum" id="notApprovedCount"></div></li>--%>
				<li class="styleSet" onclick="listByStatus('',5)"><div class="spanList"><fmt:message code="meet.th.ClosinSession" /></div><div class="spanNum" id="overCount"></div></li>
				<li class="" id="allMeetingRoon"><span><fmt:message code="meet.th.ConferenceRoomUsage" /></span></li>
			</ul>
		</div>
	</div>

	<div class="mainRight">
		<div class="pagediv meetingManage" style="margin: 0 auto;width: 97%;display: block;" id="showList">
			<table>
				<thead>
				<tr>
					<th style="text-align: center" width="12%"><fmt:message code="meet.th.ConferenceName" /></th>
					<th style="text-align: center" width="12%">会议验证码</th>
					<th style="text-align: center" width="10%"><fmt:message code="sup.th.Applicant" /></th>
					<th style="text-align: center" width="17%"><fmt:message code="sup.th.ApplicationTime" /></th>
					<th style="text-align: center" width="17%"><fmt:message code="sup.th.startTime" /></th>
					<th style="text-align: center" width="17%"><fmt:message code="meet.th.EndTime" /></th>
					<th style="text-align: center" width="9%"><fmt:message code="meet.th.ConferenceRoom" /></th>
					<th style="text-align: center" width="25%"><fmt:message code="notice.th.operation" /></th>
				</tr>
				</thead>
				<tbody>
				</tbody>

			</table>
			<div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%">

			</div>
		</div>
		<div class="usage" style="display: none;">
			<div id="fullCandar">
				<div class="leftBtn">
					<span class="leftBtnOne"></span>
					<span class="leftBtnTwo"><fmt:message code="notice.th.Today" /></span>
					<span class="leftBtnThr"></span>
				</div>
				<div class="fullTime">
					<span class="spanTime"></span>
				</div>
				<div class="colorClass">
					<%--<a href="javascript:;" style="background-color: rgb(58, 135, 173);"></a>
					<span><fmt:message code="meet.th.PendingApproval" /></span>--%>
					<a href="javascript:;" style="background-color: rgb(105, 240, 164);"></a>
					<span>所有会议</span>
					<a href="javascript:;" style="background-color: rgb(255, 136, 124);"></a>
					<span><fmt:message code="meet.th.HaveHand" /></span>
					<%--<a href="javascript:;" style="background-color: rgb(245, 181, 46);"></a>
					<span><fmt:message code="meet.th.unratified" /></span>--%>
					<a href="javascript:;" style="background-color: rgb(219, 173, 255);"></a>
					<span style="margin-right: 24px"><fmt:message code="meet.th.IsOver" /></span>
				</div>
			</div>
			<div class="div_room" style="padding-left: 20px;box-sizing: border-box;"></div>
		</div>
	</div>
</div>
<script>

	var datas;

	//日期补零
	function getNowFormatDate(){
		var day = new Date();
		var Year = 0;
		var Month = 0;
		var Day = 0;
		var CurrentDate = "";
		//初始化时间
		//Year       = day.getYear();//有火狐下2008年显示108的bug
		Year       = day.getFullYear();//ie火狐下都可以
		Month      = day.getMonth()+1;
		Day        = day.getDate();
		CurrentDate += Year + "-";
		if (Month >= 10 )
		{
			CurrentDate += Month + "-";
		}
		else
		{
			CurrentDate += "0" + Month + "-";
		}
		if (Day >= 10 )
		{
			CurrentDate += Day ;
		}
		else
		{
			CurrentDate += "0" + Day ;
		}

		return CurrentDate;
	}

	function transdate(endTime){//转时间戳
		var date=new Date();
		date.setFullYear(endTime.substring(0,4));
		date.setMonth(endTime.substring(5,7)-1);
		date.setDate(endTime.substring(8,10));
		date.setHours(endTime.substring(11,13));
		date.setMinutes(endTime.substring(14,16));
		date.setSeconds(endTime.substring(17,19));
		return Date.parse(date)/1000;
	}

	function getLocalTime(nS) {//转日期格式
		// var DateTimArre=new Date(parseInt(nS) * 1000).toLocaleString().split(/\s/)[0].split('/');
		// var DateTime=DateTimArre.join('-')
		//针对360兼容模式时间问题处理
		var date = new Date(nS * 1000);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
		var Y = date.getFullYear() + '-';
		var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
		var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
		var DateTime=Y+M+D
		return DateTime;
	}

	var myDate =transdate(getNowFormatDate());//初始时间戳

	$('.spanTime').text(getLocalTime(myDate));

	var queryStatus=1;//获取要查询列表的状态
	var cycle;
	$(function () {

		//时间增加按钮
		$('.leftBtnThr').on("click",function(){
			myDate+=86400;
			$('.spanTime').text(getLocalTime(myDate));
			getAllRoom(getLocalTime(myDate));
		})
		//时间减少按钮
		$('.leftBtnOne').on("click",function(){
			myDate-=86400;
			$('.spanTime').text(getLocalTime(myDate));
			getAllRoom(getLocalTime(myDate));
		})

		//各个状态的数量显示
		$.ajax({
			url:'/meeting/queryCountByStatu',
			type:'get',
			dataType:'json',
			success:function(obj){
				var data=obj.object;
				$("#pendingCount").html(data.pendingCount);
				$("#cyclePendingCount").html(data.cyclePendingCount);
				$("#approvedCount").html(data.approvedCount);
				$("#processingCount").html(data.processingCount);
				$("#notApprovedCount").html(data.notApprovedCount);
				$("#overCount").html(data.overCount);
			}
		});

		//点击会议室使用情况
		$('#allMeetingRoon').on("click",function(){
			$(this).addClass('one').siblings().removeClass('one');
			$('.usage').show();
			$('.meetingManage').hide();

			getAllRoom(getLocalTime(myDate));
		})

		$('.leftBtnTwo').on("click",function(){
			myDate =transdate(getNowFormatDate())
			$('.spanTime').text(getLocalTime(myDate));
			getAllRoom(getLocalTime(myDate));
		})

		//默认显示会议室使用情况
		$('#allMeetingRoon').click();
	})

	//设置选中时的样式
	$(".styleSet").on("click",function(){
		$(this).addClass('one').siblings().removeClass('one');
		$('.meetingManage').show();
		$('.usage').hide();
	})

	//点击各个状态后显示的列表
	function listByStatus(cycleNo,status){
		queryStatus=status;
		cycle=cycleNo
		var data;
		if(status<=5){
			data={
				page:1,//当前处于第几页
				pageSize:5,//一页显示几条
				useFlag:true,
				managerId:$.cookie('uid'),
				status:status,
			}
		}else if(status==6){
			data={
				page:1,
				pageSize:5,
				useFlag:true,
				status: 1,
				managerId:$.cookie('uid'),
				cycle:1
			}
		}else if(status==7){
			data={
				page:1,
				pageSize:5,
				useFlag:true,
				status: 1,
				managerId:$.cookie('uid'),
				cycleNo:cycleNo
			}
		}
		var ajaxPageLe={
			data:data,
			page:function () {
				var me=this;
				$.ajax({
					url:'/meeting/meetingManage',
					type:'get',
					dataType:'json',
					data:me.data,
					success:function(obj){
						var data=obj.obj;
						datas=obj.obj;
						var str="";
						for(var i=0;i<data.length;i++) {
							str += '<tr><td style="text-align: center" width="12%" class="tdStyle1" title="' + data[i].meetName + '"><a href="javascript:void(0);" class="meetingDetail" sid="'+data[i].sid+'">' + data[i].meetName + '</a></td>' +
									'<td style="text-align: center" width="10%" class="tdStyle1">' + function () {
										if (data[i].meetCode!=undefined && data[i].meetCode!=''){
											return data[i].meetCode;
										}
										return "无";
									}() + '</td>' +
									'<td style="text-align: center" width="10%" class="tdStyle1">' + data[i].userName + '</td>' +
									'<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].createTime + '</td>' +
									'<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].startTime + '</td>' +
									'<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].endTime + '</td>' +
									'<td style="text-align: center" width="9%" class="tdStyle1" title="'+data[i].meetRoomName+'">' + data[i].meetRoomName + '</td>';
							if(status==1 || status==4 || status==7){
								str+='<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="approve('+data[i].sid+',2)"><fmt:message code="meet.th.Approval" /></a>'+
										'<a href="javascript:;" style="" onclick="approve('+data[i].sid+',4)"><fmt:message code="meet.th.NotApprove" /></a>'+
										'<a href="javascript:;" style="" class="editData" sid="'+data[i].sid+'"><fmt:message code="menuSSetting.th.editMenu" /></a>'+
										'<a href="javascript:;" style="" onclick="delMeeting('+data[i].sid+')"' + '><fmt:message code="global.lang.delete" /></a></td>'+
										'</tr>';
							}
							if(status==2){
								var Content=data[i].videoContent;
								str+='<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="attendState('+data[i].sid+',1)"><fmt:message code="mee.th.Participants" /></a>'+
										'<a href="javascript:;" style="" onclick="attendState('+data[i].sid+',2)"><fmt:message code="meet.th.ReadingStatus" /></a>'+
										'<a href="javascript:;" style="" onclick="endMeeting('+data[i].sid+',5)"><fmt:message code="meet.th.End" /></a>'+
										<%--'<a href="javascript:;" style="" class="editData" sid="'+data[i].sid+'"><fmt:message code="menuSSetting.th.editMenu" /></a>'+--%>
										'<a href="javascript:;" style="" class="attendQR" sid="'+data[i].sid+'">二维码</a>'+
										function (){
											if (data[i].videoContent!=undefined && data[i].videoConfFlag==="1" && data[i].status!=5){
												return '<a href="javascript:;" onclick="GetDataSet('+JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;')+')">参加视频会议</a>';
											}
											return ''
										}()+
										'</td>'+
										'</tr>';
							}
							if(status==3){
								str+='<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="attendState('+data[i].sid+',1)"><fmt:message code="mee.th.Participants" /></a>'+
										'<a href="javascript:;" style="" onclick="attendState('+data[i].sid+',2)"><fmt:message code="meet.th.ReadingStatus" /></a>'+
										'<a href="javascript:;" style="" onclick="endMeeting('+data[i].sid+',5)"><fmt:message code="meet.th.End" /></a>'+
										'<a href="javascript:;" style="" class="attendQR" sid="'+data[i].sid+'">二维码</a>'+
										function (){
											if (data[i].videoContent!=undefined && data[i].videoConfFlag==="1" && data[i].status!=5){
												return '<a href="javascript:;" onclick="GetDataSet('+JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;')+')">参加视频会议</a>';
											}
											return ''
										}()+
										'</td>'+
										'</tr>';
							}
							if(status==5){
								str+='<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="attendState('+data[i].sid+',1)"><fmt:message code="mee.th.Participants" /></a>'+
										'<a href="javascript:;" style="" onclick="attendState('+data[i].sid+',2)"><fmt:message code="meet.th.ReadingStatus" /></a>'+
										'<a href="javascript:;" style="" onclick="delMeeting('+data[i].sid+')"' + '><fmt:message code="global.lang.delete" /></a>'+
										'</tr>';
							}
							if(status==6){
								str+='<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="listByStatus('+data[i].cycleNo+',7)">周期性会议审批</a>'+
										'</tr>';

							}
						}
						$("#showList tbody").html(str);
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

	//批准和不批准会议
	function approve(sid,status){
		if(status==2){//批准会议
			$.layerConfirm({title:'<fmt:message code="meet.th.ApprovalMeeting" />',content:'<fmt:message code="meet.th.AreMeeting" />？',icon:0},function() {
				$.ajax({
					url: '/meeting/updMeetStatusById',
					type: 'get',
					dataType: 'json',
					data: {
						sid: sid,
						status: status
					},
					success: function (obj) {

						if(obj.flag){
							$.layerMsg({content:'<fmt:message code="meet.th.SuccessfulApproval" />！',icon:1},function(){
								//更新列表
								listByStatus(cycle,queryStatus);
								//更新数量
								//各个状态的数量显示
								$.ajax({
									url:'/meeting/queryCountByStatu',
									type:'get',
									dataType:'json',
									success:function(obj){
										var data=obj.object;
										$("#pendingCount").html(data.pendingCount);
										$("#cyclePendingCount").html(data.cyclePendingCount);
										$("#approvedCount").html(data.approvedCount);
										$("#processingCount").html(data.processingCount);
										$("#notApprovedCount").html(data.notApprovedCount);
										$("#overCount").html(data.overCount);
									}
								});
							})
						}else{
							if(obj.msg=="<fmt:message code="meet.th.conferenceRoomOccupied" />") {
								$.layerMsg({content: '"' + obj.msg + '"！', icon: 2}, function () {
								})
							}
						}
					}
				});
			})
		}else{//不批准会议
			layer.prompt({
				formType: 2,
				value: '',
				title: '<fmt:message code="meet.th.NonApproval" />',
				area: ['800px', '350px'] //自定义文本域宽高
			}, function(value, index, elem){
				//alert(value); //得到value
				$.ajax({
					url: '/meeting/updMeetStatusById',
					type: 'post',
					dataType: 'json',
					data: {
						sid: sid,
						status: status,
						reason: value
					},
					success: function (obj) {
						if(obj.flag){
							$.layerMsg({content:'操作成功！',icon:1},function(){
								//更新列表
								listByStatus(cycle,queryStatus)
								//更新数量
								//各个状态的数量显示
								$.ajax({
									url:'/meeting/queryCountByStatu',
									type:'get',
									dataType:'json',
									success:function(obj){
										var data=obj.object;
										$("#pendingCount").html(data.pendingCount);
										$("#cyclePendingCount").html(data.cyclePendingCount);
										$("#approvedCount").html(data.approvedCount);
										$("#processingCount").html(data.processingCount);
										$("#notApprovedCount").html(data.notApprovedCount);
										$("#overCount").html(data.overCount);
									}
								});
							})
						}
					}
				});
				layer.close(index);
			});
		}
		var index = $('ul .one').index();
		if(index == 0){
			$('.styleSet').eq(0).click();
		}else if(index == 3){
			$('.styleSet').eq(3).click();
		}
	}

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
						listByStatus(cycle,queryStatus)
						//更新数量
						//各个状态的数量显示
						$.ajax({
							url:'/meeting/queryCountByStatu',
							type:'get',
							dataType:'json',
							success:function(obj){
								var data=obj.object;
								$("#pendingCount").html(data.pendingCount);
								$("#cyclePendingCount").html(data.cyclePendingCount);
								$("#approvedCount").html(data.approvedCount);
								$("#processingCount").html(data.processingCount);
								$("#notApprovedCount").html(data.notApprovedCount);
								$("#overCount").html(data.overCount);
								var index = $('ul .one').index();
								if(index == 0){
									$('.styleSet').eq(0).click();
								}else if(index == 3){
									$('.styleSet').eq(3).click();
								}else if(index == 4){
									$('.styleSet').eq(4).click();
								}
							}
						});
					})
				}
			});
		})
	}

	//结束会议
	function endMeeting(sid,status){
		$.layerConfirm({title:'<fmt:message code="meet.th.leaveTheChair" />',content:'<fmt:message code="meet.th.EndMeeting" />？',icon:0},function() {
			$.ajax({
				url: '/meeting/updMeetStatusById',
				type: 'get',
				dataType: 'json',
				data: {
					sid: sid,
					status: status
				},
				success: function (obj) {
					if(obj.flag){
						$.layerMsg({content:'<fmt:message code="meet.th.EndSuccess" />！',icon:1},function(){
							//更新列表
							listByStatus(cycle,queryStatus)
							//更新数量
							//各个状态的数量显示
							$.ajax({
								url:'/meeting/queryCountByStatu',
								type:'get',
								dataType:'json',
								success:function(obj){
									var data=obj.object;
									$("#pendingCount").html(data.pendingCount);
									$("#cyclePendingCount").html(data.cyclePendingCount);
									$("#approvedCount").html(data.approvedCount);
									$("#processingCount").html(data.processingCount);
									$("#notApprovedCount").html(data.notApprovedCount);
									$("#overCount").html(data.overCount);
									var index = $('ul .one').index();
									if(index == 1){
										$('.styleSet').eq(1).click();
									}else if(index == 2){
										$('.styleSet').eq(2).click();
									}
								}
							});
						})
					}
				}
			});
		})
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
								'<div class="mainRight attendContent"><div class="pagediv" style="margin: 0 auto;width: 98%;" id="showList">'+
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

	//初始化申请管理员下拉列表(修改弹框)
	function initManager(){
		$.ajax({
			url: '/syspara/getUserName',
			type: 'get',
			dataType: 'json',
			data: {
				paraName:"MEETING_MANAGER_TYPE"
			},
			success: function (obj) {
				var data=obj.object;
				var managerIdArray=data.paraValue.split(",");
				var managerNameArray=data.userName.split(",");
				var str="";
				for(var i=0;i<managerIdArray.length;i++){
					str+='<option value="'+managerIdArray[i]+'">'+managerNameArray[i]+'</option>';
				}
				$(".managerId").html(str);
			}
		});
	}

	//初始化会议室下拉列表(修改弹框)
	function initMeetRoom(){
		$.ajax({
			url: '../../meetingRoom/getAllMeetRoom',
			type: 'get',
			dataType: 'json',
			success: function (obj) {
				var data=obj.obj;
				var str="";
				for(var i=0;i<data.length;i++){
					str+='<option value="'+data[i].sid+'">'+data[i].mrName+'</option>';
				}
				str+="<option value='0'>视频会议</option>";
				$(".meetRoomId").html(str);
			}
		});
	}

	//修改会议
	$('.pagediv').on('click','.editData',function (event){
		var sid=$(this).attr("sid");
		event.stopPropagation();
		layer.open({
			type: 1,
			title:['<fmt:message code="meet.th.Editorial" />', 'background-color:#2b7fe0;color:#fff;'],
			area: ['600px', '500px'],
			shadeClose: true, //点击遮罩关闭
			btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
			content: '<div class="div_table" style="margin-left: 15px;">' +
					'<div class="div_tr"><span class="span_td"><fmt:message code="workflow.th.name" />：</span><span><input type="text" style="width: 180px;" name="typeName" class="inputTd meetName test_null" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="email.th.main" />：</span><span><input type="text" style="width: 180px;" name="typeName" class="inputTd subject test_null" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span><span><div class="inPole"><textarea name="txt" dataid="" class="userName test_null" id="userDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
					'<div class="div_tr"><span class="span_td">联系电话：</span><span><input type="text" style="width: 180px;" name="mobileNo" class="inputTd mobileNo test_null" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span><span><div class="inPole"><textarea name="txt" dataid="" class="recorderName" id="recoderDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span><span><select name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span><span>从</span><span><input type="text" style="width: 140px;" name="typeName" class="inputTd startTime test_null" value=""  /></span><span><fmt:message code="global.lang.to" /></span><span><input type="text" style="width: 140px;" name="typeName" class="endTime test_null" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
					'<div class="div_tr"><span class="span_td">是否是视频会议：</span> '+
					'<span><input style="height:auto" type="radio" name="isVideo" class="isVideo" value="1" >是</span>' +
					'<span><input style="height:auto"  type="radio" checked="true" name="isVideo" class="isVideo" value="0" >否</span>' +
					'</div>' +
					'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span><span><select name="typeName" class="managerId test_null" id="managerId"></select></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.external" />：</span><span><div class="inPole"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="min-width: 220px;min-height:58px;"></textarea></div></span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.internal" />：</span><span><div class="inPole"><textarea name="txt" class="attendee" id="attendeeDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span><span><div class="inPole"><textarea name="txt" id="equipmentId" class="equipmentId" equipmentId="" disabled style="min-width: 220px;min-height:60px;"></textarea></span>' +
					'<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="addEquipment" class="addEquipment"><fmt:message code="global.lang.add" /></a></span>'+
					'<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearEquipment" class="clearEquipment"><fmt:message code="global.lang.empty" /></a></div></span></div>' +'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.WriteSchedule" />：</span><span><input type="checkbox" id="isWriteCalendar" class="isWriteCalendar"></span><span><fmt:message code="meet.th.Yes" /></span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind" class="smsRemind"></span><span>事务通知</span><span><input type="checkbox" id="sms2Remind" class="sms2Remind"></span><span><fmt:message code="meet.th.SMSReminder" /></span><span><fmt:message code="meet.th.Advance" /></span><input type="text" name="resendHour" id="resendHour" class="resendHour" style="width:30px;"><span><fmt:message code="meet.th.hour" /></span><input type="text"class="resendMinute" id="resendMinute" style="width:30px;"><span><fmt:message code="meet.th.Reminder" /></span></div>'+
					'<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span><span><div class="inPole"><textarea name="meetDesc" id="meetDesc" class="meetDesc" value="" style="min-width: 300px;min-height:60px;"></textarea></div></span></div>'+
					'</div>',
			success:function(){
				laydate.render({
					elem: '.startTime'
					,type: 'datetime'
				});
				laydate.render({
					elem: '.endTime'
					,type: 'datetime'
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
				//会议室
				initManager();
				$('#meetRoomId').on("change",function(){
					var opvalue=$(this).val();
					if (opvalue==='0'){
						$("input[name='isVideo']").each(function(index,item){
							$(this).prop("disabled",true);
							if(index===0){
								$(this).prop("checked",true);
							}
						});
					}else{
						initManager($(this).val());
						$("input[name='isVideo']").each(function(){
							$(this).prop("disabled",false);
						});
					}
				});
				//审批管理员
				initMeetRoom();
				$.ajax({
					url:'/meeting/queryMeetingById',
					type:'get',
					dataType:'json',
					data:{
						sid:sid
					},
					success:function(obj){
						var data=obj.object;
						$(".meetName").val(data.meetName);
						$(".subject").val(data.subject);
						$(".userName").val(data.userName);
						$(".userName").attr("dataid",data.uid);
						$(".recorderName").val(data.recorderName);
						$(".recorderName").attr("dataid",data.recorderId);
						$(".startTime").val(data.startTime);
						$(".endTime").val(data.endTime);
						$(".attendeeOut").val(data.attendeeOut);
						$(".attendee").val(data.attendeeName);
						$(".attendee").attr("dataid",data.attendee);
						/*$(".equipmentId").val()*/
						if(data.isWriteCalednar==1){
							$(".isWriteCalendar").attr("checked",true);
						}
						if(data.smsRemind==0){
							$(".smsRemind").attr("checked",true)
						}
						if(data.sms2Remind==0){
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
						$("#managerId").val(data.managerId);

						$(".equipmentId").val(data.equipmentNames);
						$(".equipmentId").attr("equipmentId",data.equipmentIds);
						$('.mobileNo').val(data.mobileNo)
					}
				});

				//点击会议室名称显示会议室详情
				$('.meetRoomDetail').on("click",function (){
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
			yes:function(index){
				var array=$(".test_null");
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

				var recorderId=$(".recorderName").attr("dataid");
				if(recorderId!="" && recorderId.indexOf(",") >= 0){
					recorderId=recorderId.substr(0,recorderId.length-1);
				}
				var uid=$(".userName").attr("dataid");
				if(uid!="" && uid.indexOf(",") >= 0 ){
					uid=uid .substr(0,uid.length-1);
				}

				var paraData={
					sid:sid,
					meetName: $(".meetName").val(),
					subject:$(".subject").val(),
					uid: uid,
					recorderId:recorderId,
					startTime:$(".startTime").val(),
					endTime:$(".endTime").val(),
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
					mobileNo:$('.mobileNo').val(),
					videoConfFlag:$('.isVideo:checked').val()
				}

				$.ajax({
					url: '/meeting/updateMeetingById',
					type: 'get',
					dataType: 'json',
					data: paraData,
					success: function (obj) {
						$.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1},function() {
							//更新列表
							listByStatus(cycle,queryStatus);
						})
						layer.close(index);

					}
				})
			},
		});
		$('#selectUser').on("click",function(){//选人员控件(申请人)
			user_id='userDuser';
			$.popWindow("../common/selectUser?0");
		});
		$('#selectRecorder').on("click",function(){//选人员控件（纪要员）
			user_id='recoderDuser';
			$.popWindow("../common/selectUser?0");
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
		$(".addEquipment").on("click",function(){
			layer.open({
				type: 1,
				title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
				area: ['300px', '500px'],
				shadeClose: true, //点击遮罩关闭
				btn: ['<fmt:message code="menuSSetting.th.menusetsure" />'],
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
					area: ['600px', '500px'],
					shadeClose: true, //点击遮罩关闭
					btn: [ '打印','<fmt:message code="global.lang.close" />'],
					content:  '<div id="table"><div class="table"><table style="margin:auto;" class="detailTable">' +
							'<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>'+data.meetName+'</span></td><tr>'+
							'<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>'+data.subject+'</span></td><tr>'+
							'<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>'+data.userName+'</span></td><tr>'+
							'<tr><td class="tabletd" width="30%"><span class="span_td">联系电话：</span></td><td><span>'+data.mobileNo+'</span></td><tr>'+
							'<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>'+data.recorderName+'</span></td><tr>'+
							'<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span>从 &nbsp;</span><span>'+data.startTime+'</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>'+data.endTime+'</span></td><tr>' +
							'<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>'+data.meetRoomName+'</span></td><tr>'+
							'<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>'+data.managerName+'</span></td><tr>'+
							'<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>'+data.attendeeOut+'</span></td><tr>'+
							'<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>'+data.attendeeName+'</span></td><tr>'+
							'<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>'+data.equipmentNames+'</span></td><tr>'+
							'<tr><td class="tabletd"><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">'+str+'</td><tr>' +
							'<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>'+data.meetDesc+'</span></td><tr>'+
							'</table></div></div>',
					success:function(){
						$('#table td').css({
							"overflow": "hidden",
							"text-overflow": "ellipsis",
							"white-space": "nowrap",
							"padding": 0,
						});
						if(data.status==1||data.status==4){
							$(".layui-layer-btn0").css("display","none")
						}
					},
					yes:function(){
						$('#table').jqprint({
							debug: false,
							importCSS: true,
							printContainer: true,
							operaSupport: false
						});
					}
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

	//获取所有会议室
	function getAllRoom(toData){
		$.ajax({
			type:'get',
			url:'/meetingRoom/getAllMeetRoomInfo',
			dataType:'json',
			success:function(res){
				var data=res.obj;
				var tableStr='';
				if(data.length>0){
					tableStr = "<table class='TableBlock_page' width='100%'  style='margin-top:20px'><tbody id='listTbody'>";
					tableStr = tableStr + "<tr class='TableHeader' id='tbl_header'>"
							+ "<td width='250px' style='text-align: left;padding: 10px;'><fmt:message code="meet.th.ConferenceRoomName-time" /></td>";
					for(var i = 0;i<24 ; i++){
						tableStr = tableStr  + "<td width='28px'style='padding: 10px 0;text-align: left;' id='HOUR_"+i+"'>" + i + "</td>";
					}
					tableStr = tableStr +"</tr>";
					for (var j=0;j<data.length;j++){
						tableStr = tableStr + "<tr class=''>"
								+ "<td width='200px' align='left' class='TableData' style='text-align: left;padding: 0 0 0 10px;'>" + data[j].mrName + "</td>";
						tableStr = tableStr  + "<td width='' align='' colspan='24' name='MEET_ROOM_TD' id='MEET_ROOM_" + data[j].sid  +"' style='position: relative;height: 50px;'></td>";
						tableStr = tableStr + "</tr>";
					}
					tableStr = tableStr + "<tbody></table>";
				}else{
					tableStr='<div style="width: 100%;height: 60px;text-align: center;line-height: 60px;font-size: 16px;border:#ccc 1px solid;"><fmt:message code="meet.th.NoConferenceRoom" /></div>'
				}
				$(".div_room").html(tableStr);
				getMeetRoomTime(toData);
			}
		})
	}

	//显示会议使用时间段
	function getMeetRoomTime(toData){
		$("td[name='MEET_ROOM_TD']").empty();
		var widthTd=$("td[name='MEET_ROOM_TD']").width();
		var presonWidth=parseInt(widthTd/24);
//	    console.log(presonWidth)
		//清空数据

		$.ajax({
			type:'get',
			url:'/meetingRoom/getUserRoomCondition',
			dataType:'json',
			data:{currentDate:toData},
			success:function(res){
				var data=res.obj;
//				console.log(data)
//                if(data.length>0){
				for(var i=0;i<data.length;i++){
					var dataChild=data[i].meetingWithBLOBs;
					var str='';
					if(dataChild.length>0){
//                            console.log(dataChild.length)
						for(var j=0;j<dataChild.length;j++){
							var starTime=dataChild[j].startTime.substr(11,5);  //显示的开始时间
							var endTime=dataChild[j].endTime.substr(11,5);  //显示的结束时间
							var offsetL=parseInt(dataChild[j].startTime.substr(11,2));  //开始时间的小时
//								console.log(offsetL)
							var endFen=dataChild[j].endTime.substr(14,2);   //结束时间的分钟
							var endHour=dataChild[j].endTime.substr(11,2);   //结束时间的小时
							if(endFen>30){
								endHour=parseInt(endHour)+1;  //如果分钟大于30 ，小时自动+1
							}
							var borderC='';
							if(dataChild[j].status == 1){
								borderC='rgb(58, 135, 173)';
							}else if(dataChild[j].status == 2){
								borderC='rgb(105, 240, 164)';
							}else if(dataChild[j].status == 3){
								borderC='rgb(255, 136, 124)';
							}else if(dataChild[j].status == 4){
								borderC='rgb(245, 181, 46)';
							}else if(dataChild[j].status == 5){
								borderC='rgb(219, 173, 255)';
							}
							str+='<div style="width: '+((endHour-offsetL)*37.6-22)+'px;float: left;position: absolute;left: '+(37.6*offsetL)+'px;top: 5px;' +
									'border:'+borderC+' 1px solid;border-left-width: 5px;border-radius: 5px;padding-left: 10px;">' +
									'<div style="text-align: left;">'+starTime+'<br>'+endTime+'</div>' +
									'</div>';
						}
					}
					$('#MEET_ROOM_'+data[i].sid).append(str);
				}
			}
		})
	}

	//时间控件调用
	var start = {
		format: 'YYYY/MM/DD hh:mm',
		/* min: laydate.now(), //设定最小日期为当前日期*/
		/* max: '2099-06-16 23:59:59', //最大日期*/
		istime: true,
		istoday: false,
		choose: function(datas){
			end.min = datas; //开始日选好后，重置结束日的最小日期
			end.start = datas //将结束日的初始值设定为开始日
		}
	};
	var end = {
		format: 'YYYY/MM/DD hh:mm',
		/*min: laydate.now(),*/
		/*max: '2099-06-16 23:59:59',*/
		istime: true,
		istoday: false,
		choose: function(datas){
			start.max = datas; //结束日选好后，重置开始日的最大日期
		}
	};

	//点击二维码后的弹框attendQR
	$('#showList').on('click','.attendQR',function(){
		var meetingId=$(this).attr('sid');
		layer.open({
			type: 1,
			/* skin: 'layui-layer-rim', //加上边框 */
			offset: '80px',
			area: ['650px', '400px'], //宽高
			title: "二维码打卡",
			closeBtn: 1,
			content:'<div class="qrTotal" style="position:relative">' +
					'<div class="qrCenter" style="position:absolute;left:50%;top:50%;margin-left: -122px;margin-top: 40px;">' +
					'<span class="showQRCode" id="showQRCodes"  style="display: inline-block;"></span>' +
					'</div>' +
					'</div>',
			btn: ['<fmt:message code="global.lang.close" />'],
			success: function () {
				var qrcode = new QRCode(document.getElementById("showQRCodes"), {
					width : 250,//设置宽高
					height : 250
				});
				str='{"mark":"SID_MEETING","sid":'+meetingId+'}';
				qrcode.makeCode(str);
			},
			end:function (index) {
				layer.close(index);
			}
		})
	})

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
</script>
</body>
</html>
