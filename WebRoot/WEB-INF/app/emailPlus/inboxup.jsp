<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message code="email.title.inbox" /></title><!-- 收件箱 -->
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="/css/email/inbox.css"/>
	<link rel="stylesheet" type="text/css" href="/css/email/inbox-upright.css"/>

<%--	<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>

	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
	<script src="/js/jquery/jquery.form.min.js"></script>
	<script src="../js/jquery/jquery.cookie.js"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<%--<script src="../js/email/writeMail.js" type="text/javascript" charset="utf-8"></script>--%>
	<%--<script src="../js/email/inbox.js" type="text/javascript" charset="utf-8"></script>--%>
	<style>
		a{text-decoration: none;}
		table{
			/*border-collapse: collapse;*/
			border-color: #ccc;
		}
		.main_left .BTN:hover{background:#c5e9fb;}
		.attachment a{text-decoration: none;}
		.attachment a img{vertical-align: middle;}
		.searchTxt{width:70%;height:30px;padding-left:5px;margin-bottom:5px;}
		.UP_INBOX .tab table .Hover:hover{background-color:#c5e9fb;}
		.Hover img{width:16px;}
		.on_tr{background-color: #c5e9fb !important;}
		.UP_INBOX,.UP_INBOX .tab,.UP_INBOX .tab table{width: 99%;}
		.UP_INBOX .tab table tr{border: 1px solid #c0c0c0;}
		.UP_INBOX .tab table tr th{color: #2F5C8F;font-weight: normal;}
		.UP_INBOX .tab table tr:nth-child(odd){background-color: #fff;}
		.UP_INBOX .tab table tr:nth-child(even){background-color: #F6F7F9;}
		.UP_INBOX .tab table tr th,.UP_INBOX .tab table tr td{padding:10px;}
		.UP_INBOX,.UP_INBOX .tab,.UP_INBOX .tab table tr th.theme{text-align: center}
		.UP_INBOX .tab table .theme_a a{text-decoration: none;text-align: center;display: block;color:#2B7FE0;}
		.M-box3{margin-top:10px;float:right;margin-right: 7px;}
		.M-box3 a{margin: 0 3px;width: 29px;height: 29px;line-height: 29px;font-size: 12px;text-decoration: none;}
		.M-box3 .active{margin: 0px 3px;width: 29px;height: 29px;line-height: 29px;background: #2b7fe0;font-size: 12px;border: 1px solid #2b7fe0;}
		.jump-ipt{margin: 0 3px;width: 29px;height: 29px;line-height: 29px;font-size: 12px;}
		.M-box3 a:hover{background: #2b7fe0;}
		.set_up_ul{font-size: 14px;border: #ccc 1px solid;border-radius: 5px;width: 80%;background-color: #fff;position: absolute;bottom: 42px;margin-left: 5px}
		.set_up_ul ul{list-style: none;}
		.set_up_ul ul li{width: 100%;text-align: center;color: #000;height:25px;line-height:25px;}
		.set_up_ul ul li:hover{background-color: #6ea1d5;color:#fff;cursor: pointer;}
		.RemoveTo_div{font-size: 12px;border: #ccc 1px solid;border-radius: 5px;min-width:160px;background-color: #fff;position: absolute;left:0px;top: 30px;z-index: 9999;}
		.RemoveTo_div ul li{padding: 5px 10px;display:block;clear: both;}
		.RemoveTo_div .RemoveTo_child:hover{background-color: #6ea1d5;color:#fff;cursor: pointer;}
		.allEmail_div{font-size: 12px;border: #ccc 1px solid;border-radius: 5px;min-width:150px;background-color: #fff;position: absolute;left: 18.3%;top: 52px;z-index: 9999;}
		.allEmail_div ul li{padding: 5px 10px;display:block;clear: both;}
		.allEmail_div ul li:hover{background-color: #6ea1d5;color:#fff;cursor: pointer;}
		textarea{width: 230px;height: 50px;margin: 5px;}
		.noEmail_img{width: 163px;height: 162px;margin: 170px auto;}
		.noContent{width: 50px;margin: 200px auto;}
		.main_right table tr td>span>span{
			float: left;
		}
		.page .page_left .write .d_im{
			background: url(../../img/email/icon_normal_01.png) no-repeat;
			background-size:100% 100%;
		}
		.main .main_left ul li .xia img{
			float: none;
			position: absolute;
			margin-right: 0;
			right: 8%;
		}
		.inbox_btn_tim{
			height: 52px;
		}
		.page .page_left .inbox_btn{
			height: 52px;
			line-height: 52px;
		}
		img[src=""],img:not([src]){opacity:0;}
		.up_page_right{overflow-y: hidden}
		/*.main{overflow: hidden}*/
		input{background:none}
		.ul_showtwo{
			background: #6596c8;
		}
		.divUlShow{
			background: #6596c8;
		}
		.div_down{
			background: url(/img/icon_more_dakai_07.png) no-repeat 75% center;
		}
		.main_middle{
			position: absolute;
			float: left;
			width: 8px;
			height: 100%;
			background: #cee7ff;
			left:28%;
			cursor: col-resize;
			z-index: 10;
		}
		#divTbaleText{
			border-collapse: collapse;
		}
		#divTbaleText tr{
			border:#ccc 1px solid;
		}
		#divTbaleText tr th{
			padding: 5px;
		}
		#divTbaleText tr td{
			padding: 5px;
		}
		.backList{
			background-color: #c5e9fb !important;
		}
		.page{
			margin-top: 0px;
		}
	</style>
</head>
<body>
<div class="page">
	<div class="main_right UP_INBOX" style="display:block;">
		<div class="tab">
			<table cellspacing="0" cellpadding="0" style="border-collapse:collapse;">
				<tr class='tr_befor'>
					<th width="6%">
						<input type="checkbox" name="checkbox" id="checkboxAll" value="" style="width:13px;height:13px;" />
					</th>
					<th width="6%"><fmt:message code="notice.th.state" /></th>
					<th width="6%"><fmt:message code="email.th.sign" /></th>
					<th width="16%"><fmt:message code="email.th.sender" /></th>
					<th width="40%" class="theme"><fmt:message code="email.th.main" /></th>
					<th width="16%"><fmt:message code="email.th.time" /></th>
					<th width="10%"><fmt:message code="email.th.file" /></th>
				</tr>
			</table>
		</div>
		<div>
			<div class="M-box3"></div>
		</div>
	</div>
</div>

<script type="text/javascript">
	var param = $.GetRequest();
	var boxStyle = param.boxStyle
	var otherBoxId = param.otherBoxId
	$(function(){
		if (boxStyle == 'inbox') {
			data1={
				"flag":"inbox",
				"page":1,
				"pageSize":10,
				"useFlag":true
			}
		}else{
			data1={
				boxId:otherBoxId,
				page: 1,
				pageSize: 10,
				useFlag: true,
				searchCriteria:'',
				orderByName:'',
			    orderWhere:''
					}
		}
		hengEmailList(data1);

		$('.tab').on('click','.theme_a',function(){
			var atr = $(this).parents('tr').attr('Attr');
			var name = $(this).find('a').text();
//                    if(typeof(qt) == "undefined"){
			$.popWindow('details?id='+atr,'','50px', '50px', '1200px', '600px');
//                    }else{
//                        new QWebChannel(qt.webChannelTransport, function(channel){
//                            var content = channel.objects.interface;
//                            content.xoa_sms('/email/details?id='+atr,name,"web_child_url");
//                        });
//                    }

		})


//				点击全选
		$('#checkboxAll').on('click',function () {
			var state=$(this).prop('checked');
			if(state == true){
				$(this).prop('checked',true);
				$('.Hover').addClass('backList');
				$('.checkboxChild').prop('checked',true);
			}else{
				$(this).prop('checked',false);
				$('.Hover').removeClass('backList');
				$('.checkboxChild').prop('checked',false);
			}
		})



	})

	function hengEmailList(data) {

		HVersion (function(pageCount){
			initPagination(pageCount,data.pageSize);
		});
		function HVersion(cb) {
			if (boxStyle == 'inbox') {
				$.ajax({
					type: 'get',
					url: 'showEmail',
					dataType: 'json',
					data: data,
					success: function (rsp) {
						var data1 = rsp.obj;
						var str = '';
						$('.tab').find('.Hover').remove();
						for (var i = 0; i < data1.length; i++) {
							var sendTime = new Date((data1[i].sendTime) * 1000).Format('yyyy-MM-dd');
							var emailSubject = '';
							if (data1[i].emailList[0].withdrawFlag == undefined || data1[i].emailList[0].withdrawFlag == '0') {
//                                    if(data1[i].subject == '【无主题 】' && data1[i].attachmentName != ''){
								if (data1[i].subject.indexOf('【无主题 】') != -1 && data1[i].attachmentName != '') {
									var qianzhui = data1[i].subject.replace('【无主题 】', '');
									var file = data1[i].attachment[0].attachName;
									var filename = file.split('.');
									emailSubject = qianzhui + filename[0];
								} else {
									emailSubject = data1[i].subject;
								}
//                                    emailSubject= data1[i].subject ;
							} else {
								emailSubject = '已撤回：' + data1[i].subject;
							}
							if (data1[i].emailList[0].readFlag == 1) {
								if (data1[i].attachmentId != '') {
									str += '<tr class="Hover" Attr="' + data1[i].emailList[0].emailId + '" uId="' + data1[i].emailList[0].deleteFlag + '"><td><input type="checkbox" name="checkbox" class="checkboxChild" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">' + returnUserName(data1[i].users) + '</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">' + emailSubject + '</a></td><td>' + sendTime + '</td><td><img src="../img/attachment_icon.png"/></td></tr>';
								} else {
									str += '<tr class="Hover" Attr="' + data1[i].emailList[0].emailId + '" uId="' + data1[i].emailList[0].deleteFlag + '"><td><input type="checkbox" name="checkbox" class="checkboxChild" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">' + returnUserName(data1[i].users) + '</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">' + emailSubject + '</a></td><td>' + sendTime + '</td><td>&nbsp</td></tr>';
								}

							} else if (data1[i].emailList[0].readFlag == 0) {
								if (data1[i].attachmentId != '') {
									str += '<tr class="Hover" Attr="' + data1[i].emailList[0].emailId + '" uId="' + data1[i].emailList[0].deleteFlag + '"><td><input type="checkbox" name="checkbox" class="checkboxChild" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">' + returnUserName(data1[i].users) + '</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">' + emailSubject + '</a></td><td>' + sendTime + '</td><td><img src="../img/attachment_icon.png"/></td></tr>';
								} else {
									str += '<tr class="Hover" Attr="' + data1[i].emailList[0].emailId + '" uId="' + data1[i].emailList[0].deleteFlag + '"><td><input type="checkbox" name="checkbox" class="checkboxChild" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">' + returnUserName(data1[i].users) + '</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">' + emailSubject + '</a></td><td>' + sendTime + '</td><td>&nbsp</td></tr>';
								}
							}
						}
						$('.tr_befor').after(str);
						if (cb) {
							cb(rsp.totleNum);
						}

						$('.tab').on('click', '.Hover', function () {
							var states = $(this).find('.checkboxChild').prop('checked');
							if (states == true) {
								$(this).find('.checkboxChild').prop('checked', true);
								$(this).addClass('backList');
							} else {
								$('#checkboxAll').prop('checked', false);
								$(this).find('.checkboxChild').prop('checked', false);
								$(this).removeClass('backList');
							}
							var child = $(".checkboxChild");
							for (var i = 0; i < child.length; i++) {
								var childstate = $(child[i]).prop("checked");
								if (states != childstate) {
									return
								}
							}
							$('#checkboxAll').prop("checked", states);
						})
						$('#checkboxAll').prop('checked', false);
						//initPagination(rsp.totleNum,data.pageSize);
					}
				});
			}else{
				$.ajax({
					type: 'get',
					url: '/emailPlus/selectBoxEmail',
					dataType: 'json',
					data: data,
					success: function (rsp) {
						var data1 = rsp.obj;
						var str = '';
						$('.tab').find('.Hover').remove();
						for (var i = 0; i < data1.length; i++) {
							var sendTime = new Date((data1[i].sendTime) * 1000).Format('yyyy-MM-dd hh:mm');
							var emailSubject = '';
							if (data1[i].emailList[0].withdrawFlag == undefined || data1[i].emailList[0].withdrawFlag == '0') {
//                                    if(data1[i].subject == '【无主题 】' && data1[i].attachmentName != ''){
								if (data1[i].subject.indexOf('【无主题 】') != -1 && data1[i].attachmentName != '') {
									var qianzhui = data1[i].subject.replace('【无主题 】', '');
									var file = data1[i].attachment[0].attachName;
									var filename = file.split('.');
									emailSubject = qianzhui + filename[0];
								} else {
									emailSubject = data1[i].subject;
								}
//                                    emailSubject= data1[i].subject ;
							} else {
								emailSubject = '已撤回：' + data1[i].subject;
							}
							if (data1[i].emailList[0].readFlag == 1) {
								if (data1[i].attachmentId != '') {
									str += '<tr class="Hover" Attr="' + data1[i].emailList[0].emailId + '" uId="' + data1[i].emailList[0].deleteFlag + '"><td><input type="checkbox" name="checkbox" class="checkboxChild" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">' + returnUserName(data1[i].users) + '</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">' + emailSubject + '</a></td><td>' + sendTime + '</td><td><img src="../img/huixingzhen.png"/></td></tr>';
								} else {
									str += '<tr class="Hover" Attr="' + data1[i].emailList[0].emailId + '" uId="' + data1[i].emailList[0].deleteFlag + '"><td><input type="checkbox" name="checkbox" class="checkboxChild" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_read_2_03.png"/></td><td width="6%"></td><td width="6%">' + returnUserName(data1[i].users) + '</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">' + emailSubject + '</a></td><td>' + sendTime + '</td><td>&nbsp</td></tr>';
								}

							} else if (data1[i].emailList[0].readFlag == 0) {
								if (data1[i].attachmentId != '') {
									str += '<tr class="Hover" Attr="' + data1[i].emailList[0].emailId + '" uId="' + data1[i].emailList[0].deleteFlag + '"><td><input type="checkbox" name="checkbox" class="checkboxChild" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_notread_1_03.png"/></td><td width="6%"></td><td width="6%">' + returnUserName(data1[i].users) + '</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">' + emailSubject + '</a></td><td>' + sendTime + '</td><td><img src="../img/huixingzhen.png"/></td></tr>';
								} else {
									str += '<tr class="Hover" Attr="' + data1[i].emailList[0].emailId + '" uId="' + data1[i].emailList[0].deleteFlag + '"><td><input type="checkbox" name="checkbox" class="checkboxChild" style="width:13px;height:13px;" value="" /></td><td><img src="../img/icon_notread_1_03.png"/></td><td width="6%"></td><td width="6%">' + returnUserName(data1[i].users) + '</td><td class="theme_a" style="text-align:left;"><a href="javascript:;">' + emailSubject + '</a></td><td>' + sendTime + '</td><td>&nbsp</td></tr>';
								}
							}
						}
						$('.tr_befor').after(str);
						if (cb) {
							cb(rsp.totleNum);
						}

						$('.tab').on('click', '.Hover', function () {
							var states = $(this).find('.checkboxChild').prop('checked');
							if (states == true) {
								$(this).find('.checkboxChild').prop('checked', true);
								$(this).addClass('backList');
							} else {
								$('#checkboxAll').prop('checked', false);
								$(this).find('.checkboxChild').prop('checked', false);
								$(this).removeClass('backList');
							}
							var child = $(".checkboxChild");
							for (var i = 0; i < child.length; i++) {
								var childstate = $(child[i]).prop("checked");
								if (states != childstate) {
									return
								}
							}
							$('#checkboxAll').prop("checked", states);
						})
						$('#checkboxAll').prop('checked', false);
						//initPagination(rsp.totleNum,data.pageSize);
					}
				});
			}
		}
		function initPagination(totalData,pageSize){
			$('.M-box3').pagination({
				totalData:totalData, //数据总条数
				showData:pageSize,   //每页条目数
				jump:true,
				coping:true,
				homePage:'<fmt:message code="global.page.first" />',
				endPage:'<fmt:message code="global.page.last" />',
				prevContent:'<fmt:message code="global.page.pre" />',
				nextContent:'<fmt:message code="global.page.next" />',
				jumpBtn:'<fmt:message code="global.page.jump" />',
				callback:function(index){
					data.page = index.getCurrent();
					HVersion();
				}
			});
		}
	}

	<!-- 处理姓名为空处理 /users处理 -->
	function returnUserName(users){
		if(users == undefined || users == ""){
			return "";
		}else{
			return users.userName;
		}
	}
</script>
</body>
</html>