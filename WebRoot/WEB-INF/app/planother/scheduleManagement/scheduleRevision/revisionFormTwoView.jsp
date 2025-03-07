<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/14
  Time: 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>进度计划修编预览</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<script type="text/javascript" src="/js/common/fileupload.js"></script>
	<script type="text/javascript" src="/js/planbudget/common.js?20210413.1"></script>
	<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>

	<style>
		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
		}

		/*伪元素是行内元素 正常浏览器清除浮动方法*/
		.clearfix:after {
			content: "";
			display: block;
			height: 0;
			clear: both;
			visibility: hidden;
		}

		.clearfix {
			*zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
		}

		.container {
			position: relative;
			width: 100%;
			height: 100%;
			padding: 15px 0 10px;
			box-sizing: border-box;
		}

		.wrapper {
			position: relative;
			width: 100%;
			height: 100%;
			padding: 0 8px;
			box-sizing: border-box;
		}

		.wrap_left {
			position: relative;
			float: left;
			width: 230px;
			height: 100%;
			padding-right: 10px;
			box-sizing: border-box;
		}

		.wrap_left h2 {
			line-height: 35px;
			text-align: center;
		}

		.wrap_left .left_form {
			position: relative;
			overflow: hidden;
		}

		.left_form .layui-input {
			height: 35px;
			margin: 10px 0;
			padding-right: 25px;
		}

		.tree_module {
			position: absolute;
			top: 90px;
			right: 10px;
			bottom: 0;
			left: 0;
			overflow: auto;
			box-sizing: border-box;
		}

		.eleTree-node-content {
			overflow: hidden;
			word-break: break-all;
			white-space: nowrap;
			text-overflow: ellipsis;
		}

		.search_icon {
			position: absolute;
			top: 10px;
			right: 0;
			height: 35px;
			width: 25px;
			padding-top: 8px;
			text-align: center;
			cursor: pointer;
			box-sizing: border-box;
		}

		.search_icon:hover {
			color: #0aa3e3;
		}

		.wrap_right {
			position: relative;
			height: 100%;
			margin-left: 230px;
			overflow: auto;
		}

		.query_module .layui-input {
			height: 35px;
		}

		/* region 图标样式 */
		.icon_img {
			font-size: 25px;
			cursor: pointer;
		}

		.icon_img:hover {
			color: #0aa3e3;
		}
		/* endregion */

		.form_label {
			float: none;
			padding: 9px 0;
			text-align: left;
			width: auto;
		}

		.form_block {
			margin: 0;
		}

		.field_required {
			color: red;
			font-size: 16px;
		}

		.layer_wrap .layui_col {
			width: 20% !important;
			padding: 0 5px;
		}

		/* region 上传附件样式 */
		.file_upload_box {
			position: relative;
			height: 22px;
			overflow: hidden;
		}
		.open_file {
			float: left;
			position:relative;
		}
		.open_file input[type=file] {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			z-index: 2;
			opacity: 0;
		}

		.progress {
			float: left;
			width: 200px;
			margin-left: 10px;
			margin-top: 2px;
		}

		.bar {
			width: 0%;
			height: 18px;
			background: green;
		}

		.bar_text {
			float: left;
			margin-left: 10px;
		}
		/* endregion */

		.refresh_no_btn, .refresh_sort_btn {
			display: none;
			margin-left: 8%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}
		/*选中行样式*/
		.selectTr {
			background: #009688 !important;
		}
		.red-color{
			color: red;
		}

	</style>
</head>
<body>

<div class="container table_box">
	<input type="hidden" id="leftId" class="layui-input">
	<table id="tableIns" lay-filter="tableIns"></table>
	<div id="downBox" style="display: none;float:left;width: 49%">

	</div>
	<div id="downBox2" style="display: none;float:right;margin-left: 10px;width: 49%">

	</div>
</div>


<script type="text/html" id="toolbarHead">
	<div class="layui-btn-container display" style="float: left; height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="edit">修编</button>
	</div>
</script>

<script type="text/html" id="toolBar">
	<a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>


<script>
	// 获取地址栏参数值
	function getQueryString(name){
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if(r!=null)return  unescape(r[2]); return null;
	}

	var runId = getQueryString("runId");
	var _disabled = getQueryString('disabled');
	var isNew = getQueryString("isNew")||'';
	var urlObj = {}
	if(isNew=='OneOld'){
		$('.wrap_left h2').text('初始节点计划修编')
		urlObj.select='/revisionFormOldTwo/select?dataType=1&dataForm=1'
		urlObj.getdata='/revisionFormOldTwo/getChange?'
		urlObj.updataUrl='/revisionFormOldTwo/update?dataType=1'
		urlObj.plbDictNo = '81'
	}else if(isNew=='OneNew'){
		$('.wrap_left h2').text('最新节点计划修编')
		urlObj.select='/revisionFormTwo/select?dataType=1&dataForm=1'
		urlObj.getdata='/revisionFormTwo/getChange?'
		urlObj.updataUrl='/revisionFormTwo/update?dataType=1'
		urlObj.plbDictNo = '82'
	}else if(isNew=='TwoOld'){
		$('.wrap_left h2').text('初始总进度计划修编')
		urlObj.select='/revisionFormOldTwo/select?dataType=2&dataForm=2'
		urlObj.getdata='/revisionFormOldTwo/getChange?'
		urlObj.updataUrl='/revisionFormOldTwo/update?dataType=2'
		urlObj.plbDictNo = '83'
	}else if(isNew=='TwoNew'){
		$('.wrap_left h2').text('最新总进度计划修编')
		urlObj.select='/revisionFormTwo/select?dataType=2&dataForm=2'
		urlObj.getdata='/revisionFormTwo/getChange?'
		urlObj.updataUrl='/revisionFormTwo/update?dataType=2'
		urlObj.plbDictNo = '84'
	}
	if('0'!=_disabled){
		type = 4
	}else {
		type = 1
	}


	var _data = null

	var tableIns = null;

	// 表格显示顺序
	var colShowObj = null

	if(isNew=='OneOld'||isNew=='OneNew'){
		colShowObj = {
			documentNo: {field: 'documentNo', title: '编号', minWidth: 150,templet: function (d) {
					return '<span class="documentNo" scheduleId="'+d.scheduleId+'">'+(d.documentNo||'')+'</span>'
				}},
			// companySort:{field:'companySort',title:'排序号',minWidth: 100},
			scheduleName: {field: 'scheduleName', title: '任务名称', minWidth: 100},
			scheduleEndDate: {field: 'scheduleEndDate', title: '完成时间', minWidth: 130},
			scheduleGrade: {field: 'scheduleGrade', title: '节点等级',minWidth: 100,templet: function (d) {
					if(d.scheduleGrade) {
						return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_GRADE']&&dictionaryObj['SCHEDULE_GRADE']['object'][d.scheduleGrade])||'')+'</span>'
					}else {
						return ''
					}
				}},
			scheduleUserName: {field: 'scheduleUserName', title: '责任人',minWidth: 120},
			supervisorUserName: {field: 'supervisorUserName', title: '监督人',minWidth: 120},
			importanceLevel: {field: 'importanceLevel', title: '重要性',minWidth: 120,templet: function (d) {
					if(d.importanceLevel) {
						return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
					}else {
						return ''
					}
				}},
			revisionTime: {field: 'revisionTime', title: '修编时间',minWidth: 120},
			revisionUserName: {field: ' revisionUserName', title: '修编人',minWidth: 120}
		}
	}else if(isNew=='TwoOld'||isNew=='TwoNew'){
		colShowObj = {
			documentNo: {field: 'documentNo', title: '编号', minWidth: 250,templet: function (d) {
					return '<span class="documentNo" scheduleId="'+d.scheduleId+'" parentScheduleId="'+d.parentScheduleId+'">'+(d.documentNo||'')+'</span>'
				}},
			// companySort:{field:'companySort',title:'排序号',minWidth: 100},
			scheduleName: {field: 'scheduleName', title: '任务名称', minWidth: 100},
			scheduleBeginDate:{field:'scheduleBeginDate',title:'计划开始时间',minWidth: 130},
			scheduleEndDate: {field: 'scheduleEndDate', title: '计划完成时间', minWidth: 130},
			scheduleDuration: {field: 'scheduleDuration', title: '持续时间',minWidth: 110},
			beforeSchedule:{field:'beforeSchedule',title:'紧前任务',minWidth: 110hide:false,templet: function (d) {
					return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
				}},
			nodeScheduleName: {field: 'nodeScheduleName', title: '节点计划',minWidth: 110},
			// scheduleType: {field: 'scheduleType', title: '类型',minWidth: 100,templet: function (d) {
			// 		if(d.scheduleType) {
			// 			return '<span>'+((dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['object'][d.scheduleType])||'')+'</span>'
			// 		}else {
			// 			return ''
			// 		}
			// 	}},
			scheduleUserName: {field: 'scheduleUserName', title: '责任人',minWidth: 120},
			supervisorUserName: {field: 'supervisorUserName', title: '监督人',minWidth: 120},
			importanceLevel: {field: 'importanceLevel', title: '重要性',minWidth: 120,templet: function (d) {
					if(d.importanceLevel) {
						return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
					}else {
						return ''
					}
				}},
			revisionTime: {field: 'revisionTime', title: '修编时间',minWidth: 120},
			revisionUserName: {field: ' revisionUserName', title: '修编人',minWidth: 120}
		}
	}

	//选选人控件添加
	//监督人
	$(document).on('click', '#scheduleUserName', function () {
		user_id = "scheduleUserName";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})
	//责任人
	$(document).on('click', '#supervisorUserName', function () {
		user_id = "supervisorUserName";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})

	//监督人
	$(document).on('click', '#schedule_UserName', function () {
		user_id = "schedule_UserName";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})
	//责任人
	$(document).on('click', '#supervisor_UserName', function () {
		user_id = "supervisor_UserName";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})


	var TableUIObj = new TableUI('plb_other_schedule');

	// 获取数据字典数据
	var dictionaryObj = {
		PROGRESS_TYPE: {},
		SCHEDULE_INPORTANCE:{},
		SCHEDULE_GRADE:{}
	}
	var dictionaryStr = 'PROGRESS_TYPE,SCHEDULE_INPORTANCE,SCHEDULE_GRADE';
	$.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
		if (res.flag) {
			for (var dict in dictionaryObj) {
				dictionaryObj[dict] = {object: {}, str: ''}
				if (res.object[dict]) {
					res.object[dict].forEach(function (item) {
						dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
						dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
					});
				}
			}
		}
		$('#downBox').html(newDom('1'))
		$('#downBox2').html(newDom('2'))
		initPage();
	});

	function initPage() {
		layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','treeTable'], function () {
			var laydate = layui.laydate;
			var form = layui.form;
			var table = layui.table;
			var element = layui.element;
			var eleTree = layui.eleTree;
			var layer = layui.layer;
			var treeTable = layui.treeTable;


			if(!runId){
				layer.msg("信息获取失败！")
			}

			TableUIObj.init(colShowObj, function () {
				tableInit(runId)
			});

			form.render();

			// 监听列表头部按钮事件
			treeTable.on('toolbar(tableIns)', function (obj) {
				var checkStatus = tableIns.checkStatus();
				switch (obj.event) {
					case 'edit':
						if (checkStatus.length != 1) {
							layer.msg('请选择一项！', {icon: 0});
							return false
						}
						if (checkStatus[0].auditerStatus==1) {
							layer.msg('已提交不可编辑！', {icon: 0});
							return false
						}
						if(checkStatus[0].projectId){
							var scheduleId = $('.table_box .ew-tree-table-box tbody .layui-form-checked').parents('tr').find('.documentNo').attr('scheduleId')
							var loadIndex = layer.load();
							$.get(urlObj.getdata, {scheduleId:scheduleId}, function (res) {
								layer.close(loadIndex);
								if(isNew=='OneOld'||isNew=='OneNew'){
									new_Edit(1,res.obj)
								}else if(isNew=='TwoOld'||isNew=='TwoNew'){
									newOrEdit(1,res.obj,res.object&&res.object.scheduleEndDate)
								}
							});
							// newOrEdit(1, checkStatus[0])
						}else{
							layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
							return false;
						}
						break;
				}
			});
			treeTable.on('tool(tableIns)', function (obj) {
				var data = obj.data;
				var layEvent = obj.event;
				if (layEvent === 'detail') {
					var scheduleId = $(obj.tr[0]).find('.documentNo').attr('scheduleId')
					var loadIndex = layer.load();
					$.get(urlObj.getdata, {scheduleId:scheduleId}, function (res) {
						layer.close(loadIndex);
						if(isNew=='OneOld'||isNew=='OneNew'){
							new_Edit(4,res.obj)
						}else if(isNew=='TwoOld'||isNew=='TwoNew'){
							newOrEdit(4,res.obj)
						}
					});
					// newOrEdit(4,data)
				}
			});


			function tableInit(runId) {
				var cols = [{type: 'checkbox'},].concat(TableUIObj.cols);

				cols.push({
					fixed: 'right',
					align: 'center',
					toolbar: '#toolBar',
					title: '操作',
					minWidth: 200
				});

				tableIns = treeTable.render({
					elem: '#tableIns',
					url: '/revisionFormTwo/getByRunId?runId='+runId,
					// height: 'full-100',
					toolbar: '#toolbarHead',
					defaultToolbar: ['filter'],
					// page: {
					// 	limit: TableUIObj.onePageRecoeds,
					// 	limits: [10, 20, 30, 40, 50]
					// },
					tree: {
						iconIndex: 1,
						idName: 'scheduleId',
						childName: "child"
					},
					cols: cols,
					// parseData: function (res) { //res 即为原始返回的数据
					// 	return {
					// 		"code": 0, //解析接口状态
					// 		"data": res.data //解析数据列表
					// 	};
					// },
					// initSort: {
					// 	field: TableUIObj.orderbyFields,
					// 	type: TableUIObj.orderbyUpdown
					// },
					done: function (res) {
						_data = res
						if('0'!=_disabled){
							$('.display').hide()
						}
					}
				});
			}

			//监听行单击事件
			treeTable.on('row(tableIns)', function (obj) {
				// console.log(obj.data) //得到当前行数据
				var treedata = obj.data

				$('#baseForm2 .red-color').removeClass('red-color')

				$('#downBox').show()
				$('#downBox2').show()
				obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')

				var data = null
				var data2 = null
				$.post(urlObj.getdata,{scheduleId:treedata.scheduleId}, function (res) {
					if (res.code == '0') {
						data = res.object
						data2 = res.obj
					}

					if(isNew=='OneOld'||isNew=='OneNew'){
						//回显项目名称
						getProjName(' [name="projectName"]',data.projectId)

						//节点等级
						var $select1 = $(".scheduleGrade");
						var optionStr = '<option value="">请选择</option>';
						optionStr += dictionaryObj&&dictionaryObj['SCHEDULE_GRADE']&&dictionaryObj['SCHEDULE_GRADE']['str']
						$select1.html(optionStr);

						//重要性
						var $select2 = $(".importanceLevel");
						var optionStr2 = '<option value="">请选择</option>';
						optionStr2 += dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['str']
						$select2.html(optionStr2);

						if(data){
							form.val("baseForm1", data);
							//责任人id
							$('baseForm1 [name="scheduleUserName"]').attr('user_id',data.scheduleUser)
							//监督人id
							$('baseForm1 [name="supervisorUserName"]').attr('user_id',data.supervisorUser)
						}

						if(data2){
							form.val("baseForm2", data2);
							//责任人id
							$('baseForm2 [name="scheduleUserName"]').attr('user_id',data2.scheduleUser)
							//监督人id
							$('baseForm2 [name="supervisorUserName"]').attr('user_id',data2.supervisorUser)
						}

					}else if(isNew=='TwoOld'||isNew=='TwoNew'){
						//回显项目名称
						getProjName(' [name="projectName"]',data.projectId)

						//类型
						var $select1 = $(".scheduleType");
						var optionStr = '<option value="">请选择</option>';
						optionStr += dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['str']
						$select1.html(optionStr);

						//重要性
						var $select2 = $(".importanceLevel");
						var optionStr2 = '<option value="">请选择</option>';
						optionStr2 += dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['str']
						$select2.html(optionStr2);


						//回显数据
						if(data){
							//修编前
							form.val("baseForm1", data);
							//上级任务
							$('#baseForm1 [name="parentScheduleId"]').val(data&&data.parentSchedule ? data.parentSchedule.scheduleName : '');
							$('#baseForm1 [name="parentScheduleId"]').attr('parentScheduleId',data? data.parentScheduleId : '');
							//上级任务开始时间
							$('#baseForm1 #schedule_BeginDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleBeginDate : '');
							//上级任务结束时间
							$('#baseForm1 #schedule_EndDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleEndDate : '');
							//责任人id
							$('#baseForm1 [name="scheduleUserName"]').attr('user_id',data.scheduleUser)
							//监督人id
							$('#baseForm1 [name="supervisorUserName"]').attr('user_id',data.supervisorUser)

							//紧前任务
							$('#baseForm1 [name="beforeScheduleId"]').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleName : '');
							//紧前任务的开始时间
							$('#baseForm1 #schedule_BeginDate2').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleBeginDate : '');
							//紧前任务的结束时间
							$('#baseForm1 #schedule_EndDate2').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleEndDate : '');
						}


						if(data2){
							//修编后
							form.val("baseForm2", data2);
							//上级任务
							$('#baseForm2 [name="parentScheduleId"]').val(data2&&data2.parentSchedule ? data2.parentSchedule.scheduleName : '');
							$('#baseForm2 [name="parentScheduleId"]').attr('parentScheduleId',data2? data2.parentScheduleId : '');
							//上级任务开始时间
							$('#baseForm2 #schedule_BeginDate').val(data2&&data2.parentSchedule ? data2.parentSchedule.scheduleBeginDate : '');
							//上级任务结束时间
							$('#baseForm2 #schedule_EndDate').val(data2&&data2.parentSchedule ? data2.parentSchedule.scheduleEndDate : '');
							//责任人id
							$('#baseForm2 [name="scheduleUserName"]').attr('user_id',data2.scheduleUser)
							//监督人id
							$('#baseForm2 [name="supervisorUserName"]').attr('user_id',data2.supervisorUser)

							//紧前任务
							$('#baseForm2 [name="beforeScheduleId"]').val(data2&&data2.beforeSchedule ? data2.beforeSchedule.scheduleName : '');
							//紧前任务的开始时间
							$('#baseForm2 #schedule_BeginDate2').val(data2&&data2.beforeSchedule ? data2.beforeSchedule.scheduleBeginDate : '');
							//紧前任务的结束时间
							$('#baseForm2 #schedule_EndDate2').val(data2&&data2.beforeSchedule ? data2.beforeSchedule.scheduleEndDate : '');
						}
					}

					//查看详情
					$('#baseForm1').find('[name]').attr('disabled', 'disabled');
					$('#baseForm2').find('[name]').attr('disabled', 'disabled');
					if(res.data){
						res.data.forEach(function(item){
							if(item=='importanceLevel'){
								$('#baseForm2 [name='+item+']').parent().find('input').addClass('red-color')
							}else {
								$('#baseForm2 [name='+item+']').addClass('red-color')
							}
							$('#baseForm2 [name='+item+']').parent().parent().find('label').addClass('red-color')
						})
					}


					element.render();
					form.render()
				})


			});

			// 新建/编辑(节点计划修编 )
			function new_Edit(type, data) {
				var title = '';
				var url = '';
				//var content = ''
				$('#leftId').attr('projId',data.projectId)
				var projectId = data.projectId;
				if (type == '0') {
					title = '新增';
					url = '/companySchedule/insert';
					//content = '/companySchedule/companyScheduleView?type=0&projectId='+projectId
				} else if (type == '1') {
					title = '修编';
					url = urlObj.updataUrl;
					//content = '/companySchedule/companyScheduleView?type=1&scheduleId='+data.scheduleId
				}else if(type == '4'){
					title = '查看详情'
					//content = '/companySchedule/companyScheduleView?type=4&scheduleId='+data.scheduleId
				}
				layer.open({
					type: 1,
					title: title,
					area: ['80%', '90%'],
					btn: type != '4'?['保存','取消']:['确定'],
					btnAlign: 'c',
					content: ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
					'<div class="layui-collapse">\n' +
					/* region 进度信息 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">进度信息</h2>\n' +
					'    <div class="layui-colla-content layui-show plan_base_info">' +
					/* region 第一行 */
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">编号</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="documentNo" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					/*'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">排序号</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="companySort"  autocomplete="off" class="layui-input">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +*/
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">任务名称</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="scheduleName"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">项目名称</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="projectName" id="projectName2" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">完成时间<!--<span field="scheduleEndDate" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="scheduleEndDate" id="scheduleEnd_Date"  autocomplete="off" class="layui-input" >\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>' ,
						'           <div class="layui-row">' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">节点等级<!--<span field="scheduleGrade" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <select class="scheduleGrade" name="scheduleGrade" ></select>\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">责任人<!--<span field="scheduleUserName" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="scheduleUserName" id="schedule_UserName" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">监督人<!--<span field="supervisorUserName" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="supervisorUserName" id="supervisor_UserName" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">重要性<!--<span field="importanceLevel" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <select class="importanceLevel" name="importanceLevel" ></select>\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'           </div>',
						'           <div class="layui-row">' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">备注<!--<span field="memo" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="memo" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">修编人</label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="revisionUserName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">修编时间</label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="revisionTime" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'           </div>' +
						/* endregion */
						'    </div>\n' +
						'  </div>\n' +
						'</div>' +
						'</form>'].join(''),
					success: function () {
						//回显项目名称
						getProjName('#projectName2',projectId?projectId:data.projectId)

						//节点等级
						var $select1 = $("#baseForm .scheduleGrade");
						var optionStr = '<option value="">请选择</option>';
						optionStr += dictionaryObj&&dictionaryObj['SCHEDULE_GRADE']&&dictionaryObj['SCHEDULE_GRADE']['str']
						$select1.html(optionStr);

						//重要性
						var $select2 = $("#baseForm .importanceLevel");
						var optionStr2 = '<option value="">请选择</option>';
						optionStr2 += dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['str']
						$select2.html(optionStr2);

						laydate.render({
							elem: '#scheduleEnd_Date'
							, trigger: 'click'
							, format: 'yyyy-MM-dd'
							// , format: 'yyyy-MM-dd HH:mm:ss'
							//,value: new Date()
						});

						//回显数据
						if (type == 1 || type == 4) {
							form.val("formTest", data);
							//责任人id
							$('#baseForm [name="scheduleUserName"]').attr('user_id',data.scheduleUser)
							//监督人id
							$('#baseForm [name="supervisorUserName"]').attr('user_id',data.supervisorUser)

							//查看详情
							if(type==4){
								$('._disabled').find('input,select').attr('disabled', 'disabled');
								$('#baseForm .refresh_no_btn').hide();
								// $('.file_upload_box').hide()
								// $('.deImgs').hide();
							}
						}else {
							// 获取自动编号
							getAutoNumber({autoNumberType: 'scheduleCompany'}, function(res) {
								$('#baseForm input[name="documentNo"]').val(res.obj);
								$('#baseForm input[name="companySort"]').val(res.object.sort);
								$('#baseForm input[name="scheduleUserName"]').val(res.object.createUserName).attr('user_id',res.object.createUser);
							});
						}
						element.render();
						form.render()
					},
					yes: function (index,layero) {
						if(type!='4'){
							var datas = $('#baseForm').serializeArray();
							var obj = {}
							datas.forEach(function (item) {
								obj[item.name] = item.value
							});

							//责任人id
							var scheduleUser = $('#baseForm input[name="scheduleUserName"]').attr('user_id')
							if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
								scheduleUser = scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
							}
							obj.scheduleUser = scheduleUser || '';

							//监督人id
							var supervisorUser = $('#baseForm input[name="supervisorUserName"]').attr('user_id')
							if(supervisorUser&&supervisorUser.indexOf(',')!=-1){
								supervisorUser = supervisorUser.substring(0,supervisorUser.lastIndexOf(','))
							}
							obj.supervisorUser = supervisorUser || '';


							obj.projectId = projectId?projectId:data.projectId;

							obj.dataForm = '1'

							if(type == '1'){
								obj.scheduleId= data.scheduleId;
								obj.scheduleNewId= data.scheduleNewId;
							}


							// 判断必填项
							// var requiredFlag = false;
							// $('#baseForm').find('.field_required').each(function(){
							// 	var field = $(this).attr('field');
							// 	if (!obj[field]) {
							// 		var fieldName = $(this).parent().text().replace('*', '');
							// 		layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
							// 		requiredFlag = true;
							// 		return false;
							// 	}
							// });
							// if (requiredFlag) {
							// 	return false;
							// }
							var loadIndex = layer.load();

							$.ajax({
								url: url,
								data: obj,
								dataType: 'json',
								type: 'post',
								success: function (res) {
									layer.close(loadIndex);
									if (res.code=='0') {
										layer.msg('保存成功！', {icon: 1});
										layer.close(index);

										tableIns.reload();
										$('#downBox').hide()
										$('#downBox2').hide()
									} else {
										layer.msg(res.msg, {icon: 7});
									}
								}
							});
						}else {
							layer.close(index);
						}

					}
				});
			}

			// 新建/编辑(总进度计划修编 )
			function newOrEdit(type, data,endtime) {
				var title = '';
				var url = '';
				//var content = ''
				$('#leftId').attr('projId',data.projectId)
				var projectId = data.projectId;
				if (type == '0') {
					title = '新增';
					url = '/companySchedule/insert';
					//content = '/companySchedule/companyScheduleView?type=0&projectId='+projectId
				} else if (type == '1') {
					title = '修编';
					url = urlObj.updataUrl;
					//content = '/companySchedule/companyScheduleView?type=1&scheduleId='+data.scheduleId
				}else if(type == '4'){
					title = '查看详情'
					//content = '/companySchedule/companyScheduleView?type=4&scheduleId='+data.scheduleId
				}
				layer.open({
					type: 1,
					title: title,
					area: ['80%', '90%'],
					btn: type != '4'?['保存', '取消']:['确定'],
					btnAlign: 'c',
					content: ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
					'<div class="layui-collapse">\n' +
					/* region 任务信息 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">任务信息</h2>\n' +
					'    <div class="layui-colla-content layui-show plan_base_info">' +
					/* region 第一行 */
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">编号</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="documentNo" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					/*'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">排序号</label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="companySort"  autocomplete="off" class="layui-input">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +*/
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">任务名称</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="scheduleName"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">项目名称</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">重要性<!--<span field="importanceLevel" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <select class="importanceLevel" name="importanceLevel" ></select>\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					// '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					// '                   <div class="layui-form-item">\n' +
					// '                       <label class="layui-form-label form_label">类型<!--<span field="scheduleType" class="field_required">*</span>--></label>\n' +
					// '                       <div class="layui-input-block form_block">\n' +
					// '                       <select class="scheduleType" name="scheduleType" ></select>\n' +
					// '                       </div>\n' +
					// '                   </div>' +
					// '               </div>' +
					'           </div>' ,
						'           <div class="layui-row">' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">持续时间</label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                           <input type="number" name="scheduleDuration" id="scheduleDuration"  autocomplete="off" class="layui-input">' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">开始时间</label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                           <input type="text" name="scheduleBeginDate" id="scheduleBeginDate" autocomplete="off" class="layui-input">' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">结束时间<!--<span field="scheduleEndDate" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="scheduleEndDate" id="scheduleEndDate"  autocomplete="off" class="layui-input" >\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">责任人<!--<span field="scheduleUserName" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="scheduleUserName" id="scheduleUserName" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'           </div>',
						'           <div class="layui-row">' +

						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">监督人<!--<span field="supervisorUserName" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="supervisorUserName" id="supervisorUserName" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">修编人</label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="revisionUserName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">修编时间</label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="revisionTime" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'           </div>' +
						/* endregion */
						'    </div>\n' +
						'  </div>\n' +
						/* endregion  关联任务 */
						'  <div class="layui-colla-item">\n' +
						'    <h2 class="layui-colla-title">关联任务</h2>\n' +
						'    <div class="layui-colla-content layui-show mtl_info">' +
						'           <div class="layui-row">' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">紧前任务<!--<span field="beforeScheduleId" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                           <input type="text" name="beforeScheduleId" autocomplete="off" class="layui-input one_click">' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">紧前时间<!--<span field="beforeScheduleDate" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="number" name="beforeScheduleDate" id="beforeScheduleDate"  autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">紧前开始时间<!--<span field="afterScheduleDate" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="schedule_BeginDate2" id="schedule_BeginDate2" disabled style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">紧前结束时间<!--<span field="afterScheduleDate" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                       <input type="text" name="schedule_EndDate2" id="schedule_EndDate2" disabled style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'      		 </div>',
						'		</div>\n' +
						'  </div>' +
						/* endregion  常规任务 */
						'  <div class="layui-colla-item">\n' +
						'    <h2 class="layui-colla-title">上级任务</h2>\n' +
						'    <div class="layui-colla-content layui-show three_info">' +
						'           <div class="layui-row">' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">上级任务<!--<span field="parentScheduleId" class="field_required">*</span>--></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                           <input type="text" name="parentScheduleId" autocomplete="off" class="layui-input one_click">' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">上级任务开始时间</label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                           <input type="text"  id="schedule_BeginDate" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">上级任务结束时间</label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						'                           <input type="text"  id="schedule_EndDate" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +

						'      		 </div>',
						'		</div>\n' +
						'  </div>' +
						/* endregion */
						'</div>' +
						'</form>'].join(''),
					success: function () {

						//回显项目名称
						getProjName('#projectName',projectId?projectId:data.projectId)

						//类型
						var $select1 = $("#baseForm .scheduleType");
						var optionStr = '<option value="">请选择</option>';
						optionStr += dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['str']
						$select1.html(optionStr);

						//重要性
						var $select2 = $("#baseForm .importanceLevel");
						var optionStr2 = '<option value="">请选择</option>';
						optionStr2 += dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['str']
						$select2.html(optionStr2);

						laydate.render({
						elem: '#scheduleBeginDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						, done: function(value, date){ //监听日期被切换
							//紧前任务的结束时间
							var schedule_EndDate = $('#schedule_EndDate2').val()
							var beforeScheduleDate = ''
							//持续时间
							var scheduleDuration = $('#scheduleDuration').val()
							var scheduleEndDate = $('#scheduleEndDate').val()||''
							//console.log(dateParse(value))
							//反算紧前时间
							if(value&&schedule_EndDate){
								beforeScheduleDate = getDays(schedule_EndDate,value)-1
								$('#beforeScheduleDate').val(beforeScheduleDate)
							}
							//反算结束时间
							if(value&&scheduleDuration){
								scheduleEndDate = getNewDay(value,scheduleDuration,-1)
								$('#scheduleEndDate').val(scheduleEndDate)
							}

							//反算持续时间
							if(value&&scheduleEndDate){
								scheduleDuration = getDays(scheduleEndDate,value)+1
								$('#scheduleDuration').val(scheduleDuration)
							}
						}
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
					});
					laydate.render({
						elem: '#scheduleEndDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
						, done: function(value, date) { //监听日期被切换
							//持续时间
							var scheduleDuration = $('#scheduleDuration').val()
							//开始时间
							var scheduleBeginDate = $('#scheduleBeginDate').val()||''
							//反算开始时间
							if(value&&scheduleDuration){
								scheduleBeginDate = getNewDay(value,-scheduleDuration,1)
								$('#scheduleBeginDate').val(scheduleBeginDate)
							}
							//反算持续时间
							if(value&&scheduleBeginDate){
								scheduleDuration = getDays(scheduleBeginDate,value)+1
								$('#scheduleDuration').val(scheduleDuration)
							}

							//紧前任务的结束时间
							var schedule_EndDate = $('#schedule_EndDate2').val()
							var beforeScheduleDate = ''
							//反算紧前时间
							if(value&&schedule_EndDate){
								beforeScheduleDate = getDays(schedule_EndDate,$('#scheduleBeginDate').val())-1
								$('#beforeScheduleDate').val(beforeScheduleDate)
							}
						}
					});

						laydate.render({
							elem: '#afterScheduleDate'
							, trigger: 'click'
							, format: 'yyyy-MM-dd'
							// , format: 'yyyy-MM-dd HH:mm:ss'
							//,value: new Date()
						});
						form.on('select(test1)', function(data){
							if(data.value){
								$('#afterScheduleDate').attr('disabled',false).css("background","")
							}else {
								$('#afterScheduleDate').attr('disabled',true).css("background","#e7e7e7").val('')
							}
						});
						//回显数据
						if (type == 1 || type == 4) {
							form.val("formTest", data);
							//上级任务
							$('#baseForm [name="parentScheduleId"]').val(data&&data.parentSchedule ? data.parentSchedule.scheduleName : '');
							$('#baseForm [name="parentScheduleId"]').attr('parentScheduleId',data? data.parentScheduleId : '');
							//上级任务开始时间
							$('#schedule_BeginDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleBeginDate : '');
							//上级任务结束时间
							$('#schedule_EndDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleEndDate : '');
							//责任人id
							$('#baseForm [name="scheduleUserName"]').attr('user_id',data.scheduleUser)
							//监督人id
							$('#baseForm [name="supervisorUserName"]').attr('user_id',data.supervisorUser)

							//紧前任务
							$('#baseForm [name="beforeScheduleId"]').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleName : '');
							//紧前任务的开始时间
							$('#schedule_BeginDate2').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleBeginDate : '');
							//紧前任务的结束时间
							$('#schedule_EndDate2').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleEndDate : '');
							//查看详情
							if(type==4){
								$('._disabled').find('input,select').attr('disabled', 'disabled');
								$('.refresh_no_btn').hide();
								// $('.file_upload_box').hide()
								// $('.deImgs').hide();
							}
						}else {
							// 获取自动编号
							getAutoNumber({autoNumberType: 'scheduleCompany'}, function(res) {
								$('#baseForm input[name="documentNo"]').val(res.obj);
								$('#baseForm input[name="companySort"]').val(res.object.sort);
								$('#baseForm input[name="scheduleUserName"]').val(res.object.createUserName).attr('user_id',res.object.createUser);
							});
						}
						if(data&&data.beforeSchedule&&data.beforeSchedule.scheduleName){
							$('#beforeScheduleDate').attr('disabled',false).css("background","")
						}else {
							$('#beforeScheduleDate').attr('disabled',true).css("background","#e7e7e7").val('')
						}
						element.render();
						form.render()
					},
					yes: function (index,layero) {
						if(type!='4'){
							var datas = $('#baseForm').serializeArray();
							var obj = {}
							datas.forEach(function (item) {
								obj[item.name] = item.value
							});

							//上级任务
							obj.parentScheduleId = $('#baseForm [name="parentScheduleId"]').attr('parentScheduleId')||'0'

							//责任人id
							var scheduleUser = $('#baseForm input[name="scheduleUserName"]').attr('user_id')
							if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
								scheduleUser = scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
							}
							obj.scheduleUser = scheduleUser || '';

							//监督人id
							var supervisorUser = $('#baseForm input[name="supervisorUserName"]').attr('user_id')
							if(supervisorUser&&supervisorUser.indexOf(',')!=-1){
								supervisorUser = supervisorUser.substring(0,supervisorUser.lastIndexOf(','))
							}
							obj.supervisorUser = supervisorUser || '';

							//紧前任务
							obj.beforeScheduleId = $('#baseForm [name="beforeScheduleId"]').attr('beforeScheduleId')||''

							obj.projectId = projectId?projectId:data.projectId;

							obj.dataForm = '2'

							if(type == '1'){
								obj.scheduleId= data.scheduleId;
								obj.scheduleNewId= data.scheduleNewId;
							}

							//总进度计划选了上一级 开始时间在上一级的时间范围内
							//上一级 开始时
							var schedule_BeginDate = $('#schedule_BeginDate').val()||''
							//上一级 结束时间
							var schedule_EndDate = $('#schedule_EndDate').val()||''
							//此任务 开始时间
							var scheduleBeginDate = obj.scheduleBeginDate||''
							//此任务 结束时间
							var scheduleEndDate = obj.scheduleEndDate||''

							var _flay = true
							if(schedule_BeginDate&&schedule_EndDate){
								if(scheduleBeginDate&&scheduleEndDate){
									if(dateParse(schedule_BeginDate)<=(dateParse(scheduleBeginDate)&&dateParse(scheduleEndDate))&&(dateParse(scheduleBeginDate)&&dateParse(scheduleEndDate))<=dateParse(schedule_EndDate)){
										_flay = false
									}
								}else if(schedule_EndDate){
									if(dateParse(scheduleEndDate)<=dateParse(schedule_EndDate)){
										_flay = false
									}
								}else if(scheduleBeginDate){
									if(dateParse(schedule_BeginDate)<=dateParse(scheduleBeginDate)){
										_flay = false
									}
								}
							}else {
								if(schedule_BeginDate){
									if(dateParse(schedule_BeginDate)<=(dateParse(scheduleBeginDate)||dateParse(scheduleEndDate))){
										_flay = false
									}
								}else if(schedule_EndDate){
									if(dateParse(schedule_EndDate)>=(dateParse(scheduleBeginDate)||dateParse(scheduleEndDate))){
										_flay = false
									}
								}
							}
							if($('#baseForm [name="parentScheduleId"]').val()&&_flay){
								layer.msg('开始时间结束时间要在上一级的时间范围内！', {icon: 0, time: 2000});
								return
							}

							// 判断必填项
							var requiredFlag = false;
							$('#baseForm').find('.field_required').each(function(){
								var field = $(this).attr('field');
								if (!obj[field]) {
									var fieldName = $(this).parent().text().replace('*', '');
									layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
									requiredFlag = true;
									return false;
								}
							});
							if (requiredFlag) {
								return false;
							}

							if(obj.scheduleEndDate!=endtime){
								layer.confirm('是否同步修编所有紧前工序？', function (index2) {
									obj.beforeFlag=true
									var loadIndex = layer.load();
									$.ajax({
										url: url,
										data: obj,
										dataType: 'json',
										type: 'post',
										success: function (res) {
											layer.close(loadIndex);
											if (res.code=='0') {
												var _data = res.object
												layer.msg('保存成功！', {icon: 1});
												layer.close(index2)
												layer.close(index);

												tableIns.reload();
												$('#downBox').hide()
												$('#downBox2').hide()

											} else {
												layer.msg(res.msg, {icon: 7});
											}
										}
									});
								},function (index2) {
									obj.beforeFlag=false
									var loadIndex = layer.load();
									$.ajax({
										url: url,
										data: obj,
										dataType: 'json',
										type: 'post',
										success: function (res) {
											layer.close(loadIndex);
											if (res.code=='0') {
												var _data = res.object
												layer.msg('保存成功！', {icon: 1});
												layer.close(index2)
												layer.close(index);

												tableIns.reload();
												$('#downBox').hide()
												$('#downBox2').hide()

											} else {
												layer.msg(res.msg, {icon: 7});
											}
										}
									});
								});
							}else {
								obj.beforeFlag=false
								var loadIndex = layer.load();
								$.ajax({
									url: url,
									data: obj,
									dataType: 'json',
									type: 'post',
									success: function (res) {
										layer.close(loadIndex);
										if (res.code=='0') {
											var _data = res.object
											layer.msg('保存成功！', {icon: 1});
											layer.close(index);

											tableIns.reload();
											$('#downBox').hide()
											$('#downBox2').hide()

										} else {
											layer.msg(res.msg, {icon: 7});
										}
									}
								});
							}
						}else {
							layer.close(index);
						}

					}
				});
			}


			//监听紧前时间
			$(document).on('input propertychange', '#beforeScheduleDate', function () {
				var scheduleEndDate = $('#schedule_EndDate2').val()
				if(!scheduleEndDate){
					return false
				}
				var beforeScheduleDate = $(this).val()
				$('#scheduleBeginDate').val(getNewDay(scheduleEndDate,beforeScheduleDate,1))

				var scheduleDuration = $('#scheduleDuration').val()
				var scheduleBeginDate = $('#scheduleBeginDate').val()
				var scheduleEndDate = ''
				if(scheduleDuration&&scheduleBeginDate){
					scheduleEndDate = getNewDay(scheduleBeginDate,scheduleDuration,-1)
					$('#scheduleEndDate').val(scheduleEndDate)
				}
			})


			//监听持续时间
			$(document).on('input propertychange', '#scheduleDuration', function () {
				var scheduleDuration = $('#scheduleDuration').val()
				var scheduleBeginDate = $('#scheduleBeginDate').val()
				var scheduleEndDate = ''
				if(scheduleDuration&&scheduleBeginDate){
					scheduleEndDate = getNewDay(scheduleBeginDate,scheduleDuration,-1)
					$('#scheduleEndDate').val(scheduleEndDate)
				}
			})
			//监听紧前任务
			$(document).on('input blur', '[name="beforeScheduleId"]', function () {
				if($(this).val()){
					$('#beforeScheduleDate').attr('disabled',false).css("background","")
				}else {
					$('#beforeScheduleDate').attr('disabled',true).css("background","#e7e7e7").val('')
				}
			})


			//日期加上天数得到新的日期
			//dateTemp 需要参加计算的日期，days要添加的天数，返回新的日期，日期格式：YYYY-MM-DD
			//differ 相差几天
			function getNewDay(dateTemp, days,differ) {
				days = Number(days) + Number(differ)
				var dateTemp = dateTemp.split("-");
				var nDate = new Date(dateTemp[1] + '-' + dateTemp[2] + '-' + dateTemp[0]); //转换为MM-DD-YYYY格式
				var millSeconds = Math.abs(nDate) + (days * 24 * 60 * 60 * 1000);
				var rDate = new Date(millSeconds);
				var year = rDate.getFullYear();
				var month = rDate.getMonth() + 1;
				if (month < 10) month = "0" + month;
				var date = rDate.getDate();
				if (date < 10) date = "0" + date;
				return (year + "-" + month + "-" + date);
			}

			/**
			 * 日期解析，字符串转日期
			 * @param dateString 可以为2017-02-16，2017/02/16，2017.02.16
			 * @returns {Date} 返回对应的日期
			 */
			function dateParse(dateString){
				var SEPARATOR_BAR = "-";
				var SEPARATOR_SLASH = "/";
				var SEPARATOR_DOT = ".";
				var dateArray;
				if(dateString.indexOf(SEPARATOR_BAR) > -1){
					dateArray = dateString.split(SEPARATOR_BAR);
				}else if(dateString.indexOf(SEPARATOR_SLASH) > -1){
					dateArray = dateString.split(SEPARATOR_SLASH);
				}else{
					dateArray = dateString.split(SEPARATOR_DOT);
				}
				return new Date(dateArray[0], dateArray[1]-1, dateArray[2]).getTime();
			};
			//根据2个日期计算相差天数
			function getDays(strDateStart,strDateEnd){
				var strSeparator = "-"; //日期分隔符
				var oDate1;
				var oDate2;
				var iDays;
				oDate1= strDateStart.split(strSeparator);
				oDate2= strDateEnd.split(strSeparator);
				var strDateS = new Date(oDate1[0], oDate1[1]-1, oDate1[2]);
				var strDateE = new Date(oDate2[0], oDate2[1]-1, oDate2[2]);
				iDays = parseInt(Math.abs(strDateS - strDateE ) / 1000 / 60 / 60 /24)//把相差的毫秒数转换为天数
				return iDays ;
			}

			$(document).on('click', '.one_click', function () {
				var _this = this
				var _name = $(_this).attr('name')
				choiceNode(_name)

			});
			function choiceNode(type,data,dom){
				var whereObj = {
					projId: $('#leftId').attr('projId')||'',
					projectId: $('#leftId').attr('projId')||'',
					delFlag: '0',
				}
				if(type=='insert'){
					whereObj.dataFormStr ='1'
					whereObj.insertNodeFlag="insertNodeFlag"
				}else if(type=='beforeScheduleId'){
					whereObj.dataFormStr ='1,2'
				}else {
					whereObj.dataFormStr ='2'
				}
				var Settlement2 = null

				layer.open({
					type: 1,
					title: '选择',
					area: ['80%', '70%'],
					maxmin: true,
					btnAlign:'c',
					btn: ['确定', '取消'],
					content: ['<div class="layui-form" >' +
					//表格数据
					'       <div style="padding: 10px">' +
					'           <table id="Settlement2" lay-filter="SettlementFilter2"></table>' +
					'      </div>' +
					'</div>'].join(''),
					success: function () {
						Settlement2 = treeTable.render({
							elem: '#Settlement2',
							url: '/companySchedule/select',//数据接口
							page:true,
							where:whereObj,
							tree: {
								iconIndex: 1,
								idName: 'scheduleId',
								childName: "child"
							},
							cols: [[//表头
								{type: 'radio'},
								{field: 'documentNo', title: '编号', minWidth:250},
								// {field:'companySort',title:'排序号',minWidth: 100},
								{field: 'scheduleName', title: '任务名称', minWidth: 200},
								{field:'scheduleBeginDate',title:'计划开始时间',minWidth: 130,templet: function (d) {
										if(d.dataForm=='1'){
											return '<span></span>'
										}else {
											return '<span>'+(d.scheduleBeginDate||'')+'</span>'
										}
									}},
								{field: 'scheduleEndDate', title: '计划完成时间', minWidth: 130},
								{field: 'scheduleDuration', title: '持续时间',minWidth: 110},
								{field:'beforeSchedule',title:'紧前任务',minWidth: 110,templet: function (d) {
										return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
									}},
								{field: 'scheduleType', title: '类型',minWidth: 100,templet: function (d) {
										if(d.scheduleType) {
											return '<span>'+((dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['object'][d.scheduleType])||'')+'</span>'
										}else {
											return ''
										}
									}},
								{field: 'scheduleUserName', title: '责任人',minWidth: 100},
								{field: 'supervisorUserName', title: '监督人',minWidth: 100},
								{field: 'importanceLevel', title: '重要性',minWidth: 100,templet: function (d) {
										if(d.importanceLevel) {
											return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
										}else {
											return ''
										}
									}}
							]],
							request: {
								pageName: 'page' //页码的参数名称，默认：page
								,limitName: 'pageSize' //每页数据量的参数名，默认：limit
							},
							done:function(res){
								var _dataa=res;
								var _parentScheduleId='';
								if(type=='beforeScheduleId'){
									_parentScheduleId=$('[name="beforeScheduleId"]').attr('beforeScheduleId');
								}else if(type=='parentScheduleId'){
									_parentScheduleId=$('[name="parentScheduleId"]').attr('parentScheduleId')
								}
								if(_parentScheduleId!=undefined){
									for(var i = 0 ; i <_dataa.length;i++){
										if(_dataa[i].scheduleId == _parentScheduleId){
											$('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
											//form.render('checkbox');
										}
									}
								}

							}
						});
					},
					yes: function (index) {
						var datas = Settlement2.checkStatus()[0];
						if(type=='parentScheduleId'){
							//上级任务
							$('[name="parentScheduleId"]').val(datas? datas.scheduleName : '');
							$('[name="parentScheduleId"]').attr('parentScheduleId',datas? datas.scheduleId : '');
							$('#schedule_BeginDate').val(datas&&datas.dataForm!='1'? datas.scheduleBeginDate : '');
							$('#schedule_EndDate').val(datas? datas.scheduleEndDate : '');

							layer.close(index);
						}else if(type=='beforeScheduleId'){
							//紧前任务
							$('[name="beforeScheduleId"]').focus();
							$('[name="beforeScheduleId"]').val(datas? datas.scheduleName : '');
							$('[name="beforeScheduleId"]').attr('beforeScheduleId',datas? datas.scheduleId : '');
							$('#schedule_BeginDate2').val(datas&&datas.dataForm!='1'? datas.scheduleBeginDate : '');
							$('#schedule_EndDate2').val(datas? datas.scheduleEndDate : '');
							$('[name="beforeScheduleId"]').blur();

							//紧前任务的结束时间
							var schedule_EndDate = $('#schedule_EndDate2').val()
							//开始时间
							var scheduleBeginDate = $('#scheduleBeginDate').val()
							var beforeScheduleDate = ''
							//紧前时间
							if(scheduleBeginDate&&schedule_EndDate){
								beforeScheduleDate = getDays(schedule_EndDate,scheduleBeginDate)-1
								$('#beforeScheduleDate').val(beforeScheduleDate)
							}

							layer.close(index);
						}else if(type=='insert'){
							$.post('/companySchedule/updateById', {scheduleId: data,nodeScheduleId:datas.scheduleId}, function (res) {
								if (res.code=='0') {
									$(dom).find('[data-field="nodeScheduleName"] .ew-tree-table-cell-content').text(datas.scheduleName||'')
									layer.msg('插入成功！', {icon: 1});
									layer.close(index);
								} else {
									layer.msg('插入失败！', {icon: 0});
								}

								// tableIns.reload()
							})
						}
					}
				});
			}
		})
	}

	function newDom(type){
		var olstr = '修编后'
		if(type=='1'||type=='3'){
			olstr = '修编前'
		}
		var str = ''

		if(isNew=='OneOld'||isNew=='OneNew'){
			str = ['<fieldset class="layui-elem-field">\n' +
			'  <legend class="leg_end">'+olstr+'</legend>\n' +
			'  <div class="layui-field-box">\n' +
			'<form class="layui-form _disabled" id="baseForm'+type+'" lay-filter="baseForm'+type+'">' +
			'<div class="layui-collapse">\n' +
			/* region 进度信息 */
			'  <div class="layui-colla-item">\n' +
			'    <h2 class="layui-colla-title">进度信息</h2>\n' +
			'    <div class="layui-colla-content layui-show plan_base_info">' +
			/* region 第一行 */
			'           <div class="layui-row">' +
			'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">编号</label>\n' +
			'                       <div class="layui-input-block form_block">\n' +
			'                           <input type="text" name="documentNo" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			/*'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">排序号</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                           <input type="text" name="companySort"  autocomplete="off" class="layui-input">' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +*/
			'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">任务名称</label>\n' +
			'                       <div class="layui-input-block form_block">\n' +
			'                           <input type="text" name="scheduleName"  autocomplete="off" class="layui-input">' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">项目名称</label>\n' +
			'                       <div class="layui-input-block form_block">\n' +
			'                           <input type="text" name="projectName"  readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">完成时间<!--<span field="scheduleEndDate" class="field_required">*</span>--></label>\n' +
			'                       <div class="layui-input-block form_block">\n' +
			'                       <input type="text" name="scheduleEndDate"  autocomplete="off" class="layui-input" >\n' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			'           </div>' ,
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">节点等级<!--<span field="scheduleGrade" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <select class="scheduleGrade" name="scheduleGrade" ></select>\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">责任人<!--<span field="scheduleUserName" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="scheduleUserName" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">监督人<!--<span field="supervisorUserName" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="supervisorUserName"  autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">重要性<!--<span field="importanceLevel" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <select class="importanceLevel" name="importanceLevel" ></select>\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>',
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">备注<!--<span field="memo" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="memo" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">修编人</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="revisionUserName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">修编时间</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="revisionTime" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>' +
				/* endregion */
				'    </div>\n' +
				'  </div>\n' +
				'</div>' +
				'</form>'+
				'  </div>\n' +
				'</fieldset>'].join('')
		}else if(isNew=='TwoOld'||isNew=='TwoNew'){
			str = ['<fieldset class="layui-elem-field">\n' +
			'  <legend class="leg_end">'+olstr+'</legend>\n' +
			'  <div class="layui-field-box">\n' +
			'<form class="layui-form _disabled" id="baseForm'+type+'" lay-filter="baseForm'+type+'">' +
			'<div class="layui-collapse">\n' +
			/* region 任务信息 */
			'  <div class="layui-colla-item">\n' +
			'    <h2 class="layui-colla-title">任务信息</h2>\n' +
			'    <div class="layui-colla-content layui-show plan_base_info">' +
			/* region 第一行 */
			'           <div class="layui-row">' +
			'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">编号</label>\n' +
			'                       <div class="layui-input-block form_block">\n' +
			'                           <input type="text" name="documentNo" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			/*'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">排序号</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                           <input type="text" name="companySort"  autocomplete="off" class="layui-input">' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +*/
			'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">任务名称</label>\n' +
			'                       <div class="layui-input-block form_block">\n' +
			'                           <input type="text" name="scheduleName"  autocomplete="off" class="layui-input">' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">项目名称</label>\n' +
			'                       <div class="layui-input-block form_block">\n' +
			'                           <input type="text" name="projectName"  readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			'                   <div class="layui-form-item">\n' +
			'                       <label class="layui-form-label form_label">重要性<!--<span field="importanceLevel" class="field_required">*</span>--></label>\n' +
			'                       <div class="layui-input-block form_block">\n' +
			'                       <select class="importanceLevel" name="importanceLevel" ></select>\n' +
			'                       </div>\n' +
			'                   </div>' +
			'               </div>' +
			// '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
			// '                   <div class="layui-form-item">\n' +
			// '                       <label class="layui-form-label form_label">类型<!--<span field="scheduleType" class="field_required">*</span>--></label>\n' +
			// '                       <div class="layui-input-block form_block">\n' +
			// '                       <select class="scheduleType" name="scheduleType" ></select>\n' +
			// '                       </div>\n' +
			// '                   </div>' +
			// '               </div>' +
			'           </div>' ,
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">持续时间</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="number" name="scheduleDuration" id="scheduleDuration'+type+'"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">开始时间</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="scheduleBeginDate" id="scheduleBeginDate'+type+'" autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">结束时间<!--<span field="scheduleEndDate" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="scheduleEndDate" id="scheduleEndDate'+type+'"  autocomplete="off" class="layui-input" >\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">责任人<!--<span field="scheduleUserName" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="scheduleUserName" id="scheduleUserName'+type+'" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>',
				'           <div class="layui-row">' +

				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">监督人<!--<span field="supervisorUserName" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="supervisorUserName" id="supervisorUserName'+type+'" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">修编人</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="revisionUserName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">修编时间</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="revisionTime" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>' +
				/* endregion */
				'    </div>\n' +
				'  </div>\n' +
				/* endregion  关联任务 */
				'  <div class="layui-colla-item">\n' +
				'    <h2 class="layui-colla-title">关联任务</h2>\n' +
				'    <div class="layui-colla-content layui-show mtl_info">' +
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">紧前任务<!--<span field="beforeScheduleId" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="beforeScheduleId" autocomplete="off" class="layui-input one_click">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">紧前时间<!--<span field="beforeScheduleDate" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="number" name="beforeScheduleDate" id="beforeScheduleDate'+type+'"  autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">紧前开始时间<!--<span field="afterScheduleDate" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="schedule_BeginDate2" id="schedule_BeginDate2'+type+'" disabled style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">紧前结束时间<!--<span field="afterScheduleDate" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="schedule_EndDate2" id="schedule_EndDate2'+type+'" disabled style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'      		 </div>',
				'		</div>\n' +
				'  </div>' +
				/* endregion  常规任务 */
				'  <div class="layui-colla-item">\n' +
				'    <h2 class="layui-colla-title">上级任务</h2>\n' +
				'    <div class="layui-colla-content layui-show three_info">' +
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">上级任务<!--<span field="parentScheduleId" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="parentScheduleId" autocomplete="off" class="layui-input one_click">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">上级任务开始时间</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text"  id="schedule_BeginDate'+type+'" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">上级任务结束时间</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text"  id="schedule_EndDate'+type+'" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +

				'      		 </div>',
				'		</div>\n' +
				'  </div>' +
				/* endregion */
				'</div>' +
				'</form>'+
				'  </div>\n' +
				'</fieldset>'].join('')
		}



		return str
	}


</script>
</body>
</html>
