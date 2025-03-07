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
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<title><fmt:message code="meet.th.MyMeeting"/></title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/css/meeting/myMeeting.css">
		<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
		<link rel="stylesheet" href="/lib/laydate/need/laydate.css">
		<link rel="stylesheet" href="/lib/pagination/style/pagination.css">

		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
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
		<script src="../js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
		<script src="/js/jquery/jquery.jqprint-0.3.js"></script>

		<style>
			table tbody tr td:nth-child(1) {
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}

			.btnSpan {
				width: 98px;
			}

			.layui-layer-btn {
				text-align: center !important;
			}

			.table .span_td {
				text-align: right;
			}

			.showQRCode {
				/*	position: absolute;*/
				right: 32px;
				top: 50px;
				z-index: 99999;

			}

			.jump-ipt {
				float: left;
				width: 30px;
				height: 30px;
			}

			.M-box3 .active {
				margin: 0px 3px;
				width: 29px;
				height: 29px;
				line-height: 29px;
				background: #2b7fe0;
				font-size: 12px;
				border: 1px solid #2b7fe0;
				color: #fff;
				text-align: center;
				display: inline-block;
			}

			.M-box3 a {
				margin: 0 3px;
				width: 29px;
				height: 29px;
				line-height: 29px;
				font-size: 12px;
				display: inline-block;
				text-align: center;
				background: #fff;
				border: 1px solid #ebebeb;
				color: #bdbdbd;
				text-decoration: none;
			}

			td {
				height: 55px;
			}
		</style>
		<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
		<script>
			// 更新会议状态
			$.ajax({url:'/meeting/updateStatus', async:false});
		</script>
	</head>
	<body>
		<div class="headTop">
			<div class="headImg">
				<img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_myMeeting.png" alt="">
			</div>
			<div class="divTitle">
				<fmt:message code="meet.th.MyMeeting"/>
			</div>
		</div>
		<div class="main">
			<div class="byDepart">
				<div class="queryConditon">
					<span style="margin-left: 20px;"><fmt:message code="meet.th.ConferenceName"/>：</span>
					<input type="text" name="taskClass" id="meetName">
					<span><fmt:message code="email.th.time"/>：</span>
					<input type="text" name="startTime" id="startTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
					<span style="margin: 0 5px;"><fmt:message code="global.lang.to"/></span>
					<input type="text" name="endTime" id="endTime" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
					<span class="btnSpan" id="query"><fmt:message code="global.lang.query"/></span>
					<span class="btnSpan" id="clearCondition"><fmt:message code="workflow.th.Reset"/></span>
				</div>
				<div class="pagediv" id="already" style="margin: 0 auto;width: 97%;margin-top: 10px;">
					<table>
						<thead>
						<tr>
							<th style="text-align: center" width="15%"><fmt:message code="meet.th.ConferenceName"/></th>
							<th style="text-align: center" width="9%"><fmt:message code="meeting.verificationCode" /></th>
							<th style="text-align: center" width="9%"><fmt:message code="sup.th.Applicant"/></th>
							<th style="text-align: center" width="15%"><fmt:message code="sup.th.startTime"/></th>
							<th style="text-align: center" width="15%"><fmt:message code="meet.th.EndTime"/></th>
							<th style="text-align: center" width="7%"><fmt:message code="doc.th.ConferenceStatus"/></th>
							<th style="text-align: center" width="9%"><fmt:message code="meet.th.ConferenceRoom"/></th>
							<th style="text-align: center" width="30%"><fmt:message code="menuSSetting.th.menuSetting"/></th>
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
			var timer = null;//记录定时器id
			//拉起视频会议客户端
			function GetDataSet(obj) {
				//进行打卡
				$.post('/meeting/readMeeting', {meetingId: obj.sId, attendFlag: 1}, function (res) {
					if (res.flag) {
						//layer.msg('打卡成功');
					}
				});
				var url = "http://127.0.0.1:2900";
				var content = '<?xml version="1.0" encoding="UTF-8" ?>' +
					'<lemeeting>' +
					'<req_type>10001</req_type>' +
					'<login_param>' +
					'-j="' + obj.j + '" -roid=' + obj.roid + ' -rid=' + obj.rid + ' -rp="' + obj.rp + '" -aoid=' + obj.aoid + ' -a="' + obj.a + '" -n="' + obj.n + '" -rmd=1  -ccvt=1 -mpc=100 -mvsc=100 -mipcdc=100 -srf=1 -msfs=4000' +
					'</login_param>' +
					'</lemeeting>';
				var request = null;
				if (window.XMLHttpRequest) {
					request = new XMLHttpRequest();
				} else if (window.ActiveXObject) {
					request = new ActiveXObject("Microsoft.XMLHTTP");
				}
				if (request) {
					// 防止缓存&& DECODE
					request.open("POST", url, false);//true异步false同步
					//定义传输的文件HTTP头信息
					request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
					request.send(content);
				}

			}

			var user_id = '';

			//时间控件调用
			var start = {
				format: 'YYYY/MM/DD hh:mm:ss',
				istime: true,
				istoday: false,
				choose: function (datas) {
					end.min = datas; //开始日选好后，重置结束日的最小日期
					end.start = datas //将结束日的初始值设定为开始日
				}
			};
			$(function () {
				//初始化数据
				init();

				//查询按钮点击事件
				$("#query").on("click",function () {
					// 更新会议状态
					$.ajax({url:'/meeting/updateStatus', async:false});
					var paraData = {
						meetName: $("#meetName").val(),
						startTime: $("#startTime").val(),
						endTime: $("#endTime").val(),
						page: 1,//当前处于第几页
						pageSize: 5,//一页显示几条
						useFlag: true
					}
					$.ajax({
						url: '/meeting/MyMeeting',
						type: 'get',
						dataType: 'json',
						data: paraData,
						success: function (obj) {
							var data = obj.obj;
							if (data.length > 0) {
								var str = "";
								for (var i = 0; i < data.length; i++) {
									str += '<tr>' +
										'<td style="text-align: center" width="15%" title="' + data[i].meetName + '"><a href="javascript:void(0);" class="meetingDetail"  sid="' + data[i].sid + '">' + data[i].meetName + '</a></td>' +
										'<td style="text-align: center" width="9%">' + function () {
											if (data[i].meetCode != undefined && data[i].meetCode != '') {
												return data[i].meetCode;
											}
											return "无";
										}() + '</td>' +
										'<td style="text-align: center" width="9%">' + data[i].userName + '</td>' +
										'<td style="text-align: center" width="15%">' + data[i].startTime + '</td>' +
										'<td style="text-align: center" width="15%">' + data[i].endTime + '</td>' +
										'<td style="text-align: center" width="7%">' + data[i].statusName + '</td>' +
										'<td style="text-align: center" width="9%"><a href="javascript:void(0);" class="meetRoomDetail"  meetRoomId="' + data[i].meetRoomId + '">' + data[i].meetRoomName + '</a></td>' +
										'<td style="text-align: center;position: relative" width="30%">' +
										'<div><a href="javascript:;" class="summaryDetail" sid="' + data[i].sid + '"><fmt:message code="doc.th.ViewConferenceMinutes" /></a>' +
										'<a href="javascript:;" id="entrust"  sid="' + data[i].sid + '">委托</a> </div>';
									if ($.cookie("uid") == data[i].recorderId) {
										str += '<a href="javascript:;" style="display: block;" class="edtiSummary" sid="' + data[i].sid + '"><fmt:message code="doc.th.EditMeetingMinutes" /></a>';
									}
									if ($.cookie("uid") == data[i].uid) {
										str += '<a href="javascript:;" style="" class="attendQR" sid="' + data[i].sid + '"><fmt:message code="doc.th.QRCode" /></a>&nbsp;';
									}
									str += '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a>&nbsp;' +
										'<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a>&nbsp;' +
										function () {
											if (data[i].videoContent != undefined && data[i].videoConfFlag === "1" && data[i].status != 4 && data[i].status != 5) {
												return '<a href="javascript:;" onclick="GetDataSet(' + JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;') + ')">参加视频会议</a> &nbsp;';
											}
											return ''
										}() +
										'<a href="/meeting/outMeetingMsg?sid=' + data[i].sid + '"><fmt:message code="global.lang.report" /></a>&nbsp;' +
										'</td>' +
										'</tr>';
									$("#dbgz_page").show();


								}
								$("#already tbody").html(str);
							} else {
								$("#already tbody").html('');

								$("#dbgz_page").hide();

								$.layerMsg({content: '<fmt:message code="doc.th.NoData" />！', icon: 6});
							}
						}
					});
				})

				//重置按钮点击事件
				$("#clearCondition").on("click",function () {
					$("#meetName").val("");
					$("#startTime").val("");
					$("#endTime").val("");
				})
			})

			//初始化数据函数
			function init(){
				$('.pagediv tbody tr').remove();

				//列表带分页
				var ajaxPageLe = {
					data: {
						page: 1,//当前处于第几页
						pageSize: 5,//一页显示几条
						useFlag: true
						// computationNumber:null
					},
					page: function () {
						var me = this;
						$.ajax({
							url: '/meeting/MyMeeting',
							type: 'get',
							data: me.data,
							dataType: 'json',
							success: function (obj) {
								var data = obj.obj;
								if (data.length > 0) {
									var str = "";
									for (var i = 0; i < data.length; i++) {
										str += '<tr>' +
												'<td style="text-align: center" width="15%" title="' + data[i].meetName + '"><a href="javascript:void(0);" class="meetingDetail"  sid="' + data[i].sid + '">' + data[i].meetName + '</a></td>' +
												'<td style="text-align: center" width="9%">' + function () {
													if (data[i].meetCode != undefined && data[i].meetCode != '') {
														return data[i].meetCode;
													}
													return "无";
												}() + '</td>' +
												'<td style="text-align: center" width="9%">' + data[i].userName + '</td>' +
												'<td style="text-align: center" width="15%">' + data[i].startTime + '</td>' +
												'<td style="text-align: center" width="15%">' + data[i].endTime + '</td>' +
												'<td style="text-align: center" width="7%">' + data[i].statusName + '</td>' +
												'<td style="text-align: center" width="9%"><a href="javascript:void(0);" class="meetRoomDetail"  meetRoomId="' + data[i].meetRoomId + '">' + data[i].meetRoomName + '</a></td>' +
												'<td style="text-align: center;position: relative" width="30%">' +
												'<div><a href="javascript:;"  class="summaryDetail" sid="' + data[i].sid + '"><fmt:message code="doc.th.ViewConferenceMinutes" /></a> ' +
												'<a href="javascript:;" id="entrust"  sid="' + data[i].sid + '">委托</a> </div>';
										if ($.cookie("uid") == data[i].recorderId) {
											str += '<a href="javascript:;" style="display: block;" class="edtiSummary" sid="' + data[i].sid + '"><fmt:message code="doc.th.EditMeetingMinutes" /></a>';
										}
										if (data[i].handwritingSignYn == '1') {
											str += '<a href="javascript:;" style="display: block;" class="handWritingSign" sid="' + data[i].sid + '" onclick="handWriteSign(this, ' + data[i].sid + ')">手写打卡</a>';
										}
										if ($.cookie("uid") == data[i].uid) {
											str += '<a href="javascript:;" style="" class="attendQR" sid="' + data[i].sid + '"><fmt:message code="doc.th.QRCode" /></a>&nbsp;';
										}
										str += '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a> &nbsp;' +
												'<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a> &nbsp;' +
												function () {
													if (data[i].videoContent != undefined && data[i].videoConfFlag === "1" && data[i].status != 4 && data[i].status != 5) {
														return '<a href="javascript:;" onclick="GetDataSet(' + JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;') + ')">参加视频会议</a> &nbsp;';
													}
													return ''
												}() +
												'<a href="/meeting/outMeetingMsg?sid=' + data[i].sid + '"><fmt:message code="global.lang.report" /></a> &nbsp;' +
												'</td>' +
												'</tr>';
									}
									$("#already tbody").html(str);
									me.pageTwo(obj.totleNum, me.data.pageSize, me.data.page)

								} else {
									$.layerMsg({content: '<fmt:message code="doc.th.NoData" />！', icon: 6});
								}
							}
						});

					},
					pageTwo: function (totalData, pageSize, indexs) {
						var mes = this;
						$('#dbgz_page').pagination({
							totalData: totalData,
							showData: pageSize,
							jump: true,
							coping: true,
							homePage: '',
							endPage: '',
							current: indexs || 1,
							callback: function (index) {
								mes.data.page = index.getCurrent();
								mes.page();
							}
						});
					}
				}
				ajaxPageLe.page();
			}

			//参会情况和签阅情况
			function attendState(meetingId, join) {
				if (join == 1) {//参会情况
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
								offset: '80px',
								area: ['800px', '400px'], //宽高
								title: "参会情况",
								closeBtn: 1,
								content:
									'<div class="mainRight attendContent">' +
									'<a href="/meeting/queryAttendConfirm?export=true&meetingId=' + meetingId + '" class="btnSpan" style="float: right;margin: 10px;">导出</a>' +
									'<div class="pagediv" style="margin: 0 auto;width: 97%;" id="showList">' +
									'<table><thead>' +
									'<tr> <th><fmt:message code="workflow.th.Serial" /></th><th><fmt:message code="userDetails.th.name" /></th> <th><fmt:message code="workflow.th.sector" /></th> <th><fmt:message code="userManagement.th.role" /></th><th>打卡状态</th><th>打卡时间</th><th><fmt:message code="hr.th.Explain" /></th></tr>' +
									'</thead>' +
									'<tbody></tbody>' +
									'</table>' +
									'</div></div>'
									,btn:['保存','关闭'],
								success: function () {
									$(".attendContent tbody").html("");
									var str = "";
									for (var i = 0; i < data.length; i++) {
										str += '<tr><td>' + (i + 1) + '</td>' + '<td>' + data[i].attendeeName + '</td>' + '<td>' + data[i].deptName + '</td>' +
											'<td>' + data[i].userPrivName + '</td>' +  '<td>\n' +
												'                <select class="attendFlag" style="width: 100px;\n' +
												'    height: 30px;" name="attendFlag" id="attendFlag">' +
												'<option value="0">未打卡</option>' +
												'<option value="1">已打卡</option>' +
												'<option value="2">迟到</option>' +
												'<option value="3">请假</option>' +
												'<option value="4">缺勤</option>' +
												'</select>\n' +
												'            </td>' + '<td>' + data[i].confirmTime + '</td>' + '<td>' + data[i].remark + '</td>' +
											'</tr>';
									}
									$(".attendContent tbody").html(str);

									for (var j = 0; j < data.length; j++) {
										var attendFlag = data[j].attendFlag
										$(".attendFlag").find('option[value="' + attendFlag + '"]').eq(j).attr('selected', 'selected');
									}
								},yes: function(index, layero){
									var dataa = [];
									$.ajax({
										url: '/meeting/queryAttendConfirm',
										type: 'get',
										dataType: 'json',
										data: {
											meetingId: meetingId
										},
										success: function (obj) {
											for (var j = 0; j < data.length; j++) {
												var meetingId=data[j].meetingId
												var attendeeId=data[j].attendeeId
												var attendFlag1=$(".attendFlag").eq(j).val()
												var data1 = {
													meetingId:meetingId,
													attendeeId:attendeeId,
													attendFlag:attendFlag1
												}
												dataa.push(data1)
											}

											$.ajax({
												url: '/meeting/updateMyMeetingStatus',
												type: 'get',
												dataType: 'json',
												// contentType:"application/json",
												data: {
													strJson:JSON.stringify(dataa)
												},
												success: function (res) {
													console.log(dataa)
													if(res.flag){
														layer.msg('保存成功！', {icon: 1,time:1000}, function () {
															layer.closeAll();
														})
													}else{
														layer.msg('保存失败！', {icon: 0,time:1000}, function () {

														})
													}
												}
											});
										}
									})

								}
							})
						}
					});
				} else {//签阅情况
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
			$('.pagediv').on('click', '.meetingDetail', function (event) {
				$.ajax({
					url: '/meeting/queryMeetingById',
					type: 'get',
					dataType: 'json',
					data: {
						sid: $(this).attr("sid")
					},
					success: function (obj) {
						var data = obj.object;
						var str = '';
						if (data.attachmentList && data.attachmentList.length > 0) {
							for (var i = 0; i < data.attachmentList.length; i++) {
								str += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?' + data.attachmentList[i].attUrl + '">' + data.attachmentList[i].attachName + '</a></div>'
							}
						} else {
							str = '';
						}

						var fileStr = '';
						if (data.agendaList && data.agendaList.length > 0) {
							for (var i = 0; i < data.agendaList.length; i++) {
								fileStr += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?' + data.agendaList[i].attUrl + '">' + data.agendaList[i].attachName + '</a></div>'
							}
						} else {
							fileStr = '';
						}
						layer.open({
							type: 1,
							title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
							area: ['600px', '500px'],
							shadeClose: true, //点击遮罩关闭
							btn: ['打印', '<fmt:message code="global.lang.close" />'],
							content: '<div class="table"><table style="margin:auto;">' +
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
								'<tr><td><span class="span_td">前台会议服务人员：</span></td><td><span>' + (data.serviceUserName || '') + '</span></td><tr>' +
								'<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>' + data.equipmentNames + '</span></td><tr>' +
								'<tr><td><span class="span_td">会议议程附件：</span></td><td><span><div class="inPole">' + fileStr + '</div></span></td><tr>' +
								'<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">' + str + '</div></span></td><tr>' +
								'<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>' + data.meetDesc + '</span></td><tr>' +
								'<tr><td><span class="span_td"><fmt:message code="meet.th.MySignin" />：</span></td><td><span>' + data.myAttend + '</span></td><tr>' +
								'</table></div>',
							success: function () {
								$('.table td').css({
									"overflow": "hidden",
									"text-overflow": "ellipsis",
									"white-space": "nowrap",
									"padding": 0,
									"height": "auto"
								});
								if (data.status == 1 || data.status == 4) {
									$(".layui-layer-btn0").css("display", "none")
								}
							},
							yes: function () {
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
			$('.pagediv').on('click', '.meetRoomDetail', function (event) {
				$.ajax({
					url: '/meetingRoom/getMeetRoomBySid',
					type: 'get',
					dataType: 'json',
					data: {
						sid: $(this).attr("meetRoomId")
					},
					success: function (obj) {
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
				})
			})

			//点击查看会议纪要
			$('.pagediv').on('click', '.summaryDetail', function (event) {
				var sId = $(this).attr("sid");
				event.stopPropagation();
				layer.open({
					type: 1,
					title: ['<fmt:message code="main.meetingsummary" />', 'background-color:#2b7fe0;color:#fff;'],
					area: ['800px', '350px'],
					shadeClose: true, //点击遮罩关闭
					btn: ['<fmt:message code="global.lang.close" />'],
					content: '<div class="table"><table style="width: 80%; margin-left:60px; margin-top: 30px;">' +
						'<tr style="height: 50px;"><td style="width: 100px"><fmt:message code="workflow.th.name" />：</td><td class="data1" style="text-align: center"></td></tr>' +
						'<tr  style="height: 50px;"><td style="width: 100px"><fmt:message code="meet.th.DesignatedReader" />：</td><td class="data2" style="text-align: center"></td></tr>' +
						'<tr  style="height: 50px;"><td style="width: 100px"><fmt:message code="email.th.file" />：</td><td class="data3" style="text-align: center"></td></tr>' +
						'<tr  style="height: 50px;"><td rowspan="3" style="width: 100px"><fmt:message code="meet.th.SummaryContent" />：</td><td class="data4" style="text-align:center;"> </td></tr>' +
						'</table></div>',
					success: function () {
						$.ajax({
							type: 'get',
							url: '/MeetSummary/getMeetSummarydetail',
							dataType: 'json',
							data: {'sid': sId},
							success: function (res) {
								var datas = res.object;
								$('.data1').append(datas.meetName);
								$('.data2').append(datas.readPeopleNames);
								// $('.data3').append(str);
								$('.data4').append(datas.summary);
								if (datas.attachmentList.length > 0) {
									<%--for(var i=0;i<datas.attachmentList.length;i++){--%>
									<%--str+='<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?'+datas.attachmentList[i].attUrl+'">'+datas.attachmentList[i].attachName+'</a></div>'--%>
									<%--}--%>
									$('.data3').append(attachView(datas.attachmentList, '', '4', '0', '1', '0'));
								}

							}
						})
					},
					yes: function (index) {

						layer.close(index);
					},
				});
			});

			//编辑会议纪要
			$('.pagediv').on('click', '.edtiSummary', function (event) {
				var sid = $(this).attr("sid");
				var sId = $(this).attr("sid");
				event.stopPropagation();
				layer.open({
					type: 1,
					title:['<fmt:message code="doc.th.EditMeetingMinutes" />', 'background-color:#2b7fe0;color:#fff;'],
					area: ['600px', '400px'],
					shadeClose: true, //点击遮罩关闭
					btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
					content: '<div class="div_table" style="margin: 30px auto;width: 80%;">' +
							'<div class="div_tr"><span class="span_td" style="text-align: right"><fmt:message code="workflow.th.name" />：</span><span><input type="text" readonly="true"  style="width: 180px; float: none" name="typeName" class="inputTd meetName" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>'+
							'<div class="div_tr"><span class="span_td" style="text-align: right"><fmt:message code="meet.th.DesignatedReader" />：</span><span><div class="inPole" style="float: none;"><textarea  name="txt" class="recorderName" id="recoderDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>'+
							//照片
							'<div class="div_tr photo"><span class="span_td" style="text-align: right">照片：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
							'<form  target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
							'<input type="file" name="file"   class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
							'<a href="javascript:;">' +
							'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
							'</form></div></span></div>'+
							//录像
							'<div class="div_tr video"><span class="span_td" style="text-align: right">录像：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
							'<form  target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
							'<input type="file" name="file"  class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
							'<a href="javascript:;">' +
							'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
							'</form></div></span></div>'+
							//录音
							'<div class="div_tr recording"><span class="span_td" style="text-align: right">录音：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
							'<form  target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
							'<input type="file" name="file"  class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
							'<a href="javascript:;">' +
							'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
							'</form></div></span></div>'+
							//会议纪要
							'<div class="div_tr meeingContent"><span class="span_td" style="text-align: right">会议纪要：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
							'<form  target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
							'<input type="file" name="file"   class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
							'<a href="javascript:;">' +
							'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
							'</form></div></span></div>'+


							'<div class="div_tr otherFile"><span class="span_td" style="text-align: right"><fmt:message code="sup.th.RelatedAccessories" />：</span><span><div class="inPole" style="float: none;"><div class="Attachment"></div>' +
							'<form id="uploadimgform" target="uploadiframe"  action="../upload?module=summary_meet" enctype="multipart/form-data" method="post" >'+
							'<input type="file" name="file" id="uploadinputimg"  class="w-icon5 uploadinputimg" style="position: absolute;opacity: 0;width: 70px;filter: progid:DXImageTransform.Microsoft.Alpha(opacity=0)">' +
							'<a href="javascript:;" id="uploadimg">' +
							'<img style="margin-right:5px;" src="../img/icon_uplod.png"/><fmt:message code="global.th.fileup" /></a>'+
							'</form></div></span></div>'+
							'<div class="div_tr"><span class="span_td" style="text-align: right"><fmt:message code="doc.th.MeetingMinutesContent" />：</span><span><div class="inPole"><textarea name="meetDesc" id="meetDesc" class="meetDesc" value="6868686" style="min-width: 300px;min-height:100px;"></textarea></div></span></div>'+
							'</div>',
					success:function(){
						$.ajax({
							url:'/MeetSummary/getMeetSummarydetail',
							type:'get',
							dataType:'json',
							data:{
								sid:sId
							},
							success:function(obj){
								var data=obj.object;
								var str='';

								//照片
								var str2='';
								if(data.photoList && data.photoList.length>0){
									for(var i=0;i<data.photoList.length;i++){
										str2+='<div class="dech" deUrl="'+data.photoList[i].attUrl+'"><a href="/download?'+data.photoList[i].attUrl+'" NAME="'+data.photoList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.photoList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.photoList[i].aid+'@'+data.photoList[i].ym+'_'+data.photoList[i].attachId+',"></div>';
									}
								}else{
									str2='';
								}
								$('.photo .Attachment').append(str2);

								//录像
								var str3='';
								if(data.videoList && data.videoList.length>0){
									for(var i=0;i<data.videoList.length;i++){
										str3+='<div class="dech" deUrl="'+data.videoList[i].attUrl+'"><a href="/download?'+data.videoList[i].attUrl+'" NAME="'+data.videoList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.videoList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.videoList[i].aid+'@'+data.videoList[i].ym+'_'+data.videoList[i].attachId+',"></div>';
									}
								}else{
									str3='';
								}
								$('.video .Attachment').append(str3);

								//录音
								var str4='';
								if(data.recordList && data.recordList.length>0){
									for(var i=0;i<data.recordList.length;i++){
										str4+='<div class="dech" deUrl="'+data.recordList[i].attUrl+'"><a href="/download?'+data.recordList[i].attUrl+'" NAME="'+data.recordList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.recordList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.recordList[i].aid+'@'+data.recordList[i].ym+'_'+data.recordList[i].attachId+',"></div>';
									}
								}else{
									str4='';
								}
								$('.recording .Attachment').append(str4);

								//会议纪要
								var str5='';
								if(data.summaryAttachmentList && data.summaryAttachmentList.length>0){
									for(var i=0;i<data.summaryAttachmentList.length;i++){
										str5+='<div class="dech" deUrl="'+data.summaryAttachmentList[i].attUrl+'"><a href="/download?'+data.summaryAttachmentList[i].attUrl+'" NAME="'+data.summaryAttachmentList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.summaryAttachmentList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.summaryAttachmentList[i].aid+'@'+data.summaryAttachmentList[i].ym+'_'+data.summaryAttachmentList[i].attachId+',"></div>';
									}
								}else{
									str5='';
								}
								$('.meeingContent .Attachment').append(str5);

								//相关附件
								if(data.attachmentList && data.attachmentList.length>0){
									for(var i=0;i<data.attachmentList.length;i++){
										str+='<div class="dech" deUrl="'+data.attachmentList[i].attUrl+'"><a href="/download?'+data.attachmentList[i].attUrl+'" NAME="'+data.attachmentList[i].attachName+'*"><img style="width:16px;" src="../img/file/cabinet@.png"/>'+data.attachmentList[i].attachName+'</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="'+data.attachmentList[i].aid+'@'+data.attachmentList[i].ym+'_'+data.attachmentList[i].attachId+',"></div>';
									}
								}else{
									str='';
								}
								$('.otherFile .Attachment').append(str);

								$('input[name="typeName"]').val(data.meetName);
								$('#recoderDuser').val(data.readPeopleNames);
								$('#recoderDuser').attr('dataid', data.readPeopleId);
								$('#meetDesc').val(data.summary);


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

						//照片
						var photoId='';
						var photoName='';
						for(var i=0;i<$('.photo .Attachment .inHidden').length;i++){
							photoId += $('.photo .Attachment .inHidden').eq(i).val();
							photoName += $('.photo .Attachment a').eq(i).attr('NAME');
						}

						//录像
						var videoId='';
						var videoName='';
						for(var i=0;i<$('.video .Attachment .inHidden').length;i++){
							videoId += $('.video .Attachment .inHidden').eq(i).val();
							videoName += $('.video .Attachment a').eq(i).attr('NAME');
						}

						//录音
						var recordId='';
						var recordName='';
						for(var i=0;i<$('.recording .Attachment .inHidden').length;i++){
							recordId += $('.recording .Attachment .inHidden').eq(i).val();
							recordName += $('.recording .Attachment a').eq(i).attr('NAME');
						}

						//会议纪要
						var summaryAttachmentId='';
						var summaryAttachmentName='';
						for(var i=0;i<$('.meeingContent .Attachment .inHidden').length;i++){
							summaryAttachmentId += $('.meeingContent .Attachment .inHidden').eq(i).val();
							summaryAttachmentName += $('.meeingContent .Attachment a').eq(i).attr('NAME');
						}

						//相关附件
						var aId='';
						var uId='';
						for(var i=0;i<$('.otherFile .Attachment .inHidden').length;i++){
							aId += $('.otherFile .Attachment .inHidden').eq(i).val();
							uId += $('.otherFile .Attachment a').eq(i).attr('NAME');
						}

						var paraData={
							sid:sId,
							meetName:   $('input[name="typeName"]').val(),
							readPeopleId:     $('#recoderDuser').attr('dataid'),
							summary: $('#meetDesc').val(),
							photoId:photoId,
							photoName:photoName,
							videoId:videoId,
							videoName:videoName,
							recordId:recordId,
							recordName:recordName,
							summaryAttachmentId:summaryAttachmentId,
							summaryAttachmentName:summaryAttachmentName,
							attachmentId:aId,
							attachmentName:uId,
						}

						$.ajax({
							url: '/MeetSummary/editMeetSummarydetail',
							type: 'get',
							dataType: 'json',
							data: paraData,
							success: function (obj) {
								init();
								if(obj.flag){
									$.layerMsg({content:'<fmt:message code="depatement.th.Modifysuccessfully" />！',icon:1});
								}else{
									$.layerMsg({content:'<fmt:message code="depatement.th.modifyfailed" />！',icon:2});
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

				$('#selectRecorder').on("click",function(){//选人员控件（纪要员）
					user_id='recoderDuser';
					$.popWindow("../common/selectUser");
				});
				$('#clearRecoder').on("click",function(){ //清空人员（纪要员）
					$('#recoderDuser').attr('user_id','');
					$('#recoderDuser').attr('dataid','');
					$('#recoderDuser').val('');
				});
				<%--$('#uploadimg').on('click',function(){--%>
				<%--$('#uploadinputimg').on("click",);--%>
				<%--})--%>
				<%--$('#uploadinputimg').on("change",function(e){--%>
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

				$('.uploadinputimg').fileupload({
					dataType:'json',
					done: function (e, data) {
						if(data.result.obj != ''){
							var data = data.result.obj;
							var str = '';
							var str1 = '';
							for (var i = 0; i < data.length; i++) {
								str += '<div class="dech" deUrl="' + data[i].attUrl+ '"><a href="/download?'+encodeURI(data[i].attUrl)+'" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
							}
							$(e.target).parents('.inPole').find('.Attachment').append(str);
						}else{
							//alert('添加附件大小不能为空!');
							layer.alert('添加附件大小不能为空!',{},function(){
								layer.closeAll();
							});
						}
					}
				});
			})

			//委托功能
			$(document).on('click', '#entrust', function () {
				var sid = $(this).attr('sid')
				layer.open({
					type: 1,
					title: '委托',
					area: ['450px', '250px'],
					content: '<form style="margin-top: 20px">' +
						'<div class="layui-inline">\n' +
						'                    <label class="layui-form-label" style="float: left;display: block;padding: 9px 15px;width: 80px;font-weight: 400;line-height: 20px;text-align: right;font-size: 15px"><span style="color: red;">*</span>委托人</label>\n' +
						'                    <div class="layui-input-inline">\n' +
						'                        <textarea  id="transferUser" user_id="" readonly style="background: #e7e7e7;height: 80px;width: 200px" class="layui-textarea"></textarea>\n' +
						'                    <a href="javascript:;" style="color:#1E9FFF;font-size: 15px" class="add">添加</a>\n' +
						'                    <a href="javascript:;" style="color:#1E9FFF;font-size: 15px" class="Execute">清空</a>\n' +
						'                    </div>\n' +
						'                </div>' +
						'</form>',
					btn: ['确认', '返回'],
					success: function (res) {
						$(".add").on("click", function () {
							user_id = "transferUser";
							$.popWindow("/common/selectUser?0");
						});

						$('.Execute').on("click",function () {
							$("#transferUser").val("");
							$("#transferUser").attr('user_id', '');
						});
					},
					yes: function (index) {
						var loadIndex = layer.load();
						if (!$('#transferUser').val()) {
							layer.msg('请选择委托人！', {icon: 0});
							layer.close(loadIndex);
							return false
						}
						if (sid) {
							var datasPer = {
								sid: sid,
								attendee: $('#transferUser').attr('user_id'),
							}
							var url = '/meeting/addAttendee'
							$.ajax({
								url: url,
								dataType: 'json',
								type: 'get',
								data: datasPer,
								success: function (res) {
									layer.close(loadIndex);
									if (res.flag) {
										layer.msg('委托成功！', {icon: 1});
										layer.close(index)
									}
								}
							})
						}
					}
				})
			})

			//附件删除
			function deleteChatment(data, element) {

				layer.confirm('<fmt:message code="menuSSetting.th.isdeleteMenu" />？', {
					btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
					title: "<fmt:message code="notice.th.DeleteAttachment" />"
				}, function () {
					//确定删除，调接口
					$.ajax({
						type: 'get',
						url: '../delete',
						dataType: 'json',
						data: data,
						success: function (res) {

							if (res.flag == true) {
								layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
								element.remove();
							} else {
								layer.msg('<fmt:message code="lang.th.deleSucess" />', {icon: 5});
							}
						}
					});

				}, function (index) {
					layer.close(index);
				});
			}

			/**
			 * 手写签章
			 * @param e
			 * @param sid
			 */
			function handWriteSign(e, sid) {
				console.log(e);
				console.log(sid);
				layer.open({
					type: 1,
					area: ['640px', '460px'],
					title: ['手写签字', 'background-color:#2b7fe0;color:#fff;'],
					btn: ['清屏', '确定', '关闭'],
					close: true,
					content: '<div id="content" style="width:100%;height:100%;background:#eeeeee;"><div id="signatureparent" style="width:100%;height:97%;"><div id="signatureCon" style="width:100%;height:100%;"></div></div></div>',
					success: function () {
						$("#signatureCon").jSignature();
						if (( /(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) ) || /(Android)/i.test(navigator.userAgent)) {
						} else {
							$('canvas').height('355px').attr('height', '355px')
						}
					},
					yes: function (index) {
						$("#signatureCon").jSignature("clear");
					},
					btn2: function (index) {
						var $sigdiv = $("#signatureCon");
						var datapair = $sigdiv.jSignature("getData", "image");
						var src = "data:" + datapair[0] + "," + datapair[1];

						$.ajax({
							url: '/uploadBase64',
							dataType: 'json',
							data: {fileStr: src, module: 'meeting'},
							type: 'post',
							success: function (res) {
								if (res.flag && res.obj.length > 0) {
									console.log('手写成功');
									var signImg = res.obj[0];

									$.post('/MeetSummary/addSign', {
										meetingId: sid,
										signId: signImg.attachId,
										signName: signImg.attachName
									}, function(res) {
										if (res.flag) {
											layer.msg('打卡成功！', {icon: 1});
											layer.close(index);
										} else {
											layer.msg('打卡失败！', {icon: 0});
										}
									});
								}
							}
						});
						return false;
					}
				})
			}

			$(function () {
				//点击二维码后的弹框attendQR
				$('#already').on('click', '.attendQR', function () {
					var meetingId = $(this).attr('sid');
					$.ajax({
						type: 'get',
						url: '/meeting/updateCreateQrcodeTimeBySid',
						dataType: 'json',
						data: {
							sid:meetingId
						},
						success: function (res) {

						}
					});
					var str = "";
					layer.open({
						type: 1,
						/* skin: 'layui-layer-rim', //加上边框 */
						offset: '80px',
						area: ['650px', '400px'], //宽高
						title: "<fmt:message code="event.th.two" />",
						closeBtn: 1,
						content: '<div class="qrTotal"><div class="qrCenter" style="margin-left: 200px;margin-top: 36px;"><span class="showQRCode" id="showQRCode"  style="display: inline-block;"></span></div></div>',
						btn: ['<fmt:message code="global.lang.close" />'],
						success: function () {
							getQrcode(meetingId)
							timer = setInterval(function() {
								getQrcode(meetingId)
							},25000)
						},
						end: function (index) {
							clearInterval(timer);
							timer = null;
							layer.close(index);
						}
					})
				})
			})
			// 生成二维码的方法
			function getQrcode(meetingId) {
				$.ajax({
					type: 'get',
					url: '/meeting/updateCreateQrcodeTimeBySid',
					dataType: 'json',
					data: {
						sid:meetingId
					},
					success: function (res) {
						document.getElementById("showQRCode").innerHTML = "";
						var qrcode = new QRCode(document.getElementById("showQRCode"), {
							width: 250,//设置宽高
							height: 250
						});
						str = '{"mark":"SID_MEETING","sid":' + meetingId + '}';
						qrcode.makeCode(str);
					}
				});

			}
		</script>

		<!-- 手写签字 -->
		<script type="text/javascript" src="../../lib/jSignature-master/src/jSignature.js"></script>
	</body>
</html>
