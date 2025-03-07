<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<!--<![endif]-->
<head>
<title><fmt:message code="notice.title.notify" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<link rel="stylesheet" type="text/css" href="../lib/laydate.css" />
<link rel="stylesheet" type="text/css"
	href="../lib/pagination/style/pagination.css" />
<link rel="stylesheet" type="text/css" href="../css/notice/notify.css" />
<link rel="stylesheet" type="text/css" href="../css/base.css" />
<script src="../js/xoajq/xoajq1.js" type="text/javascript"
	charset="utf-8"></script>
<script src="../lib/laydate.js" type="text/javascript" charset="utf-8"></script>
<script src="../lib/pagination/js/jquery.pagination.min.js"
	type="text/javascript" charset="utf-8"></script>
<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
<style type="text/css">
#noticeQuery {
	width: 100%;
}

#noticeQuery table tr td {
	padding: 5px 5px;
	border-color: #ccc;
}

.TableBlock {
	background-color: #fff;
	border-color: #aaa;
}

.inPole {
	font-size: 14px;
}

textarea {
	min-width: 65%;
	min-height: 35px;
	margin: 5px 5px;
}

.inPole a {
	display: inline-block;
	padding: 3px 5px;
	text-decoration: none;
}

.add_img .addImg {
	display: inline-block;
	width: 20px;
	height: 10px;
	overflow: hidden;
	position: relative;
}

.add_img .addImg img {
	height: 100%;
}

.add_img .addImg .addIcon {
	position: absolute;
	top: 0;
	left: 0;
}

.add_img .addImg .clearIcon {
	position: absolute;
	top: 0;
	left: -20px;
}

#noRead {
	width: 100%;
}

#noRead .title {
	font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
	font-size: 18px;
}

#noRead span {
	display: block;
	width: 50%;
	margin: 20px auto;
	padding: 20px 20px;
	font-size: 25px;
	text-align: center;
	background-color: #6fb4fa;
	color: #fff;
}

.title {
	font-size: 16px;
	color: #124164;
	font-weight: bold;
	margin-top: 20px;
	margin-left: 20px;
	display: inline-block;
}

.laydate-icon {
	width: 150px;
}

.BigInput {
	width: 352px;
	height: 20px;
}

.BigButton {
	width: 40px;
	height: 25px;
	border-radius: 3px;
	line-height: 25px;
	text-align: center;
}

.Btn {
	width: 120px;
	margin: 0 auto;
}

.divBtn {
	width: 50px;
	margin: 5px auto;
}

.iBtn {
	width: 100%;
	height: 30px;
	text-align: center;
	line-height: 30px;
}
</style>
<script type="text/javascript">
	$(function() {
		var data1 = {
			"typeId" : '',
			"sendTime" : '',
			"page" : 1,
			"pageSize" : 10,
			"useFlag" : true
		};

		initNotice();

		function initNotice() {

			$
					.ajax({
						type : 'get',
						url : 'notifyManage',
						dataType : 'json',
						data : data1,
						success : function(rsp) {
							//alert(data1.typeId);
							var data = rsp.obj;
							var str = '';
							for ( var i = 0; i < data.length; i++) {
								$('.TableLine1').remove();
								str += '<tr class="TableLine1"><td nowrap align="center">'
										+ data[i].name
										+ '</td><td nowrap align="center">'
										+ data[i].typeName
										+ '</td><td nowrap align="left"><a href="javascript:;" noticeId="'+data[i].notifyId+'" class="windowOpen">'
										+ data[i].subject
										+ '</a></td><td nowrap align="center">'
										+ data[i].toId
										+ '</td><td nowrap align="center">'
										+ data[i].sendTime
										+ '<input type="hidden" id="'+data[i].notifyId+'"></td></tr>';

							}
							$('.TableHeader').after(str);

							$('.M-box3')
									.pagination(
											{
												pageCount : 1,
												jump : true,
												coping : true,
												homePage : '<fmt:message code="global.page.first" />',
												endPage : '<fmt:message code="global.page.last" />',
												prevContent : '<fmt:message code="global.page.pre" />',
												nextContent : '<fmt:message code="global.page.next" />',
												jumpBtn : '<fmt:message code="global.page.jump" />'
											});
						}
					});
		}
		//条件查询
		$('#but').click(function() {

			data1.typeId = $('#noticetype option:checked').val();
			data1.sendTime = $('#test').val();
			//alert(data1.typeId);
			initNotice();
		})

		$('.TableList').on('click', '.windowOpen', function() {
			var nid = $(this).attr('noticeId');
			$.popWindow('detail?nid=' + nid,'<fmt:message code="notice.th.queryDetail"/>','0','100','1200px','700px');
		})
		//查询
		$('.muJump ul li').click(
				function() {
					var index = $(this).index();
					$('.muJump ul li').removeClass('jumpOn');
					$(this).addClass('jumpOn');
					$('.content>div').eq(index).show().siblings().hide();

					if ($('.content>div').eq(0).css('display') == 'block') {
						$.ajax({
							type : 'get',
							url : 'unreadNotify',
							dataType : 'json',
							data : data1,
							success : function(rsp) {
								var data = rsp.flag;
								//alert(data);
								if (data == false) {
									var timer = setTimeout(function() {
										$('.content>div').eq(1).show();
										$('.content>div').eq(0).hide();
										$('.muJump ul li').eq(1).addClass(
												'jumpOn').siblings()
												.removeClass('jumpOn');
										clearTimeout(timer);
									}, 2000);

								} else {
									alert('<fmt:message code="global.lang.havedata" />');
								}
							}
						});
					}

				});

	});
</script>
</head>

<body class="bodycolor">
	<div class="muJump">
		<ul>
			<li><a href="javascript:;"><fmt:message
						code="notice.title.unreadannouncement" /> </a></li>
			<li class="jumpOn"><a href="javascript:;"><fmt:message
						code="notice.title.notify" /> </a></li>
			<li><a href="javascript:;"><fmt:message
						code="notice.title.announcementquery" /> </a></li>
		</ul>
	</div>
	<div class="content">
		<!-- 未读公告 -->
		<div id="noRead" style="display: none;">
			<!-- <table border="0" width="95%" cellspacing="0" cellpadding="3" class="small" align="center">
			<tr>
				<td>
					<div class="title"><fmt:message code="notice.title.unreadannouncement" /></div>
					<select name="TYPE" class="BigSelect" onChange="change_type(this.value);">
		          	<option value="0" selected><fmt:message code="notice.type.alltype" /></option>
		         	<option value="01"><fmt:message code="notice.type.Decision" /></option>
					<option value="02"><fmt:message code="notice.type.notice" /></option>
					<option value="03"><fmt:message code="notice.type.Bulletin" /></option>
					<option value="04"><fmt:message code="notice.type.other" /></option>
		          	<option value="05"><fmt:message code="notice.type.notype" /></option>
			       </select>
				</td>
				
			</tr>
			
		</table> -->
			<span><fmt:message code="notice.alert.nodatealert" /> </span>
		</div>
		<!-- 公告通知 start -->
		<div id="notify" style="overflow-y: scroll;display:block;">
			<table border="0" width="95%" cellspacing="0" cellpadding="3"
				class="small" align="center">
				<tr>
					<td class="Big"><img src="../img/notify_open.gif"
						align="absmiddle"> <span class="big3"><fmt:message
								code="notice.title.notify" /> </span>&nbsp; <select name="TYPE"
						id="noticetype" class="BigSelect">
							<option value="" selected>
								<fmt:message code="notice.type.alltype" />
							</option>
							<option value="01">
								<fmt:message code="notice.type.Decision" />
							</option>
							<option value="02">
								<fmt:message code="notice.type.notice" />
							</option>
							<option value="03">
								<fmt:message code="notice.type.Bulletin" />
							</option>
							<option value="04">
								<fmt:message code="notice.type.other" />
							</option>
							<!-- <option value="05"><fmt:message code="notice.type.notype" /></option> -->
					</select> <span><fmt:message code="notice.title.Releasedate" />:</span> <input
						id="test" name="SEND_TIME" class="laydate-icon"> <input
						type="button" id="but"
						value="<fmt:message code="global.lang.ok" />" />
					</td>

					<td align="right" valign="bottom" class="small1">
						<div class="M-box3"></div>
					</td>
				</tr>
			</table>
			<table class="TableList" width="95%" align="center" cellspacing="0"
				cellpadding="0">
				<tr class="TableHeader">
					<!--  <th nowrap align="center">选择</th> -->
					<th nowrap align="center"><fmt:message
							code="notice.th.publisher" /></th>
					<th nowrap align="center"><fmt:message code="notice.th.type" />
					</th>
					<th nowrap align="center"><fmt:message code="notice.th.title" />
					</th>

					<th nowrap align="center" style="cursor:pointer;"><u><fmt:message code="notice.th.releasescope" /></u>

					</th>
					<th nowrap align="center"><fmt:message
							code="notice.th.createTime" /> <img border=0
						src="../img/arrow_down.gif" width="11" height="10">
					</th>
					<!--  <th nowrap align="center"><fmt:message code="notice.th.operation" /></th> -->
				</tr>
			</table>
		</div>
		<!-- end -->

		<!-- 公告查询 -->
		<div id="noticeQuery" style="display: none;">
			<div class="title">
				<fmt:message code="notice.title.announcementquery" />
			</div>
			<table class="TableBlock" width="50%" align="center" border="1"
				style="margin: 20px auto;">
				<form enctype="multipart/form-data" name="form1"></form>
				<tbody>
					<tr>
						<td nowrap="" class="TableData"><fmt:message
								code="notice.th.publisher" />：</td>
						<td class="TableData">
							<div class="inPole">
								<textarea name="txt" disabled></textarea>
								<span class="add_img"> <span class="addImg"> <img
										src="../img/org_select1.png" class="addIcon" /> </span> <a
									href="javascript:;" class="Add"></a> </span> <span class="add_img">
									<span class="addImg"> <img src="../img/org_select2.png"
										class="clearIcon" /> </span> <a href="javascript:;" class="clear"><fmt:message code="global.lang.delete" /></a>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td nowrap="" class="TableData" width="100"><fmt:message code="notice.th.format" />：</td>
						<td class="TableData"><select name="FORMAT" class="BigSelect">
								<option value="0" selected=""><fmt:message code="notice.th.all" /></option>
								<option value="1"><fmt:message code="notice.format.Commonformat" /></option>
								<option value="2"><fmt:message code="notice.format.MHTformat" /></option>
								<!--<option value="2">超级链接</option>-->	
						</select>
						</td>
					</tr>
					<tr>
						<td nowrap="" class="TableData"><fmt:message code="notice.th.type" />：</td>
						<td class="TableData"><select name="TYPE_ID"
							class="BigSelect">
								<option value="" selected=""><fmt:message code="notice.th.all" /></option>
		          <option value="01"><fmt:message code="notice.type.Decision" /></option>
				  <option value="02"><fmt:message code="notice.type.notice" /></option>
				  <option value="03"><fmt:message code="notice.type.Bulletin" /></option>
				  <option value="04"><fmt:message code="notice.type.other" /></option>
						</select>&nbsp;</td>
					</tr>
					<tr>
						<td nowrap="" class="TableData" width="100"><fmt:message
								code="notice.th.title" />：</td>
						<td class="TableData"><input type="text" name="SUBJECT"
							size="33" maxlength="100" class="BigInput" value="">
						</td>
					</tr>
					<tr>
						<td nowrap="" class="TableData" width="100"><fmt:message
								code="notice.title.Releasedate" />：</td>
						<td class="TableData"><input class="laydate-icon" id="start">
							&nbsp;至&nbsp; <input class="laydate-icon" id="end">
						</td>
					</tr>
					<tr>
						<td nowrap="" class="TableData" width="100"><fmt:message code="notice.th.content" />：</td>
						<td class="TableData"><input type="text" name="CONTENT"
							size="33" maxlength="200" class="BigInput" value="">
						</td>
					</tr>
					<tr align="center" class="TableControl">
						<td colspan="2" nowrap="">
							<div class="Btn">
								<input type="submit" value="<fmt:message code="global.lang.ok" />" class="BigButton"
									style="cursor: pointer;">&nbsp;&nbsp; <input
									type="reset" value="<fmt:message code="global.lang.refillings" />" class="BigButton"
									style="cursor: pointer;">&nbsp;&nbsp;
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- end -->

		<!-- 查询列表  -->
		<div id="queryList" style="overflow-y: scroll;display:none;">
			<table border="0" width="95%" cellspacing="0" cellpadding="3"
				class="small" align="center">
				<tr>
					<td class="Big"><img src="../img/notify_open.gif"
						align="absmiddle"> <span class="big3"><fmt:message code="notice.th.queryEnd" /></span>
					</td>

					<td align="right" valign="bottom" class="small1">
						<div class="M-box3"></div>
					</td>
				</tr>
			</table>
			<table class="TableList" width="95%" align="center" cellspacing="0"
				cellpadding="0">
				<tr class="TableHead">
					<!--  <th nowrap align="center">选择</th> -->
					<th nowrap align="center"><fmt:message
							code="notice.th.publisher" /></th>
					<th nowrap align="center"><fmt:message code="notice.th.type" />
					</th>
					<th nowrap align="center"><fmt:message code="notice.th.title" />
					</th>

					<th nowrap align="center" style="cursor:pointer;"><u><fmt:message code="notice.th.releasescope" /></u>

					</th>
					<th nowrap align="center"><fmt:message
							code="notice.th.createTime" /> <img border=0
						src="../img/arrow_down.gif" width="11" height="10">
					</th>
				</tr>
				<tr>
					<td colspan="5">
						<div class="divBtn">
							<input type="button" name="iBtn" class="iBtn" id="iBtn"
								value="<fmt:message code="notice.th.return" />" style="cursor: pointer;">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<script type="text/javascript">
		//时间控件调用
		laydate({
			elem : '#test', //目标元素。
			format : 'YYYY-MM-DD hh:mm:ss', //日期格式
			istime : true, //显示时、分、秒
		});

		//时间控件调用
		var start = {
			elem : '#start',
			format : 'YYYY/MM/DD hh:mm:ss',
			/* min: laydate.now(), //设定最小日期为当前日期*/
			/* max: '2099-06-16 23:59:59', //最大日期*/
			istime : true,
			istoday : false,
			choose : function(datas) {
				end.min = datas; //开始日选好后，重置结束日的最小日期
				end.start = datas; //将结束日的初始值设定为开始日
			}
		};
		var end = {
			elem : '#end',
			format : 'YYYY/MM/DD hh:mm:ss',
			/*min: laydate.now(),*/
			/*max: '2099-06-16 23:59:59',*/
			istime : true,
			istoday : false,
			choose : function(datas) {
				start.max = datas; //结束日选好后，重置开始日的最大日期
			}
		};
		laydate(start);
		laydate(end);

		$(function() {

			$('input[type="submit"]')
					.click(
							function() {
								//alert('123');
								var typeId = $(
										'select[name="TYPE_ID"] option:checked')
										.val();
								var forMat = $(
										'select[name="FORMAT"] option:checked')
										.val();
								var subject = $('input[name="SUBJECT"]').val();
								var content = $('input[name="CONTENT"]').val();
								var data = {
									'typeId' : typeId,
									'subject' : subject,
									'content' : content,
									'format' : forMat,
									"page" : 1,
									"pageSize" : 5,
									"useFlag" : true
								};
								//alert(data.typeId)
								$
										.ajax({
											type : "get",
											url : "notifyList",
											dataType : 'json',
											data : data,
											success : function(rsp) {
												var data = rsp.obj;
												var str = '';
												$('#noticeQuery').css(
														'display', 'none');
												$('#queryList').css('display',
														'block');
												for ( var i = 0; i < data.length; i++) {
													$('.TableLiney').remove();
													str += '<tr class="TableLiney"><td nowrap align="center">'
															+ data[i].name
															+ '</td><td nowrap align="center">'
															+ data[i].typeName
															+ '</td><td nowrap align="left"><a href="javascript:;" noticeId="'+data[i].notifyId+'" class="windowOpen">'
															+ data[i].subject
															+ '</a></td><td nowrap align="center">'
															+ data[i].toId
															+ '</td><td nowrap align="center">'
															+ data[i].sendTime
															+ '<input type="hidden" id="'+data[i].notifyId+'"></td></tr>';

												}
												$('.TableHead').after(str);

											}
										});

							});

			$('input[type="reset"]').click(function() {
				$('textarea').val('');
				$('select[name="FORMAT"]').get(0).selectedIndex = 0;
				$('select[name="TYPE_ID"]').get(0).selectedIndex = 0;
				$('.BigInput').val('');
				$('#start').val('');
				$('#end').val('');
			});

			$('#iBtn').click(function() {
				$('#queryList').css('display', 'none');
				$('#noticeQuery').css('display', 'block');
				$('.TableLiney').remove();
			})

		});
	</script>

</body>
</html>
