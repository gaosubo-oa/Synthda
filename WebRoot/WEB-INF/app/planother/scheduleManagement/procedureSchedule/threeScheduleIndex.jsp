<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/10/18
  Time: 16:38
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
	<title>进度计划分解</title>

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

		[data-field="scheduleBeginDate"] .ew-tree-table-cell-content,
		[data-field="scheduleEndDate"] .ew-tree-table-cell-content,
		[data-field="scheduleUserName"] .ew-tree-table-cell-content,
		[data-field="supervisorUserName"] .ew-tree-table-cell-content,
		[data-field="currFlowUserName"] .ew-tree-table-cell-content,
		[data-field="auditerStatus"] .ew-tree-table-cell-content
		{
			min-width: 90px;
			/*width: 90px;*/
			padding: 0 !important;
		}
		[data-field="importanceLevel"] .ew-tree-table-cell-content
		{
			min-width: 50px;
			/*width: 90px;*/
			padding: 0 !important;
		}
		[data-field="scheduleDuration"] .ew-tree-table-cell-content
		{
			min-width: 60px;
			/*width: 90px;*/
			padding: 0 !important;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">进度计划分解</h2>
			<div class="left_form">
				<div class="search_icon">
					<i class="layui-icon layui-icon-search"></i>
				</div>
				<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input"/>
			</div>
			<div class="tree_module">
				<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
			</div>
		</div>
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2">
					<input type="text" name="wbsNo" placeholder="子项目编码" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="wbsName" placeholder="子项目名称/简称" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="approvalStatus">
						<option value="">请选择</option>
						<option value="0">未提交</option>
						<option value="1">审批中</option>
						<option value="2">批准</option>
						<option value="3">不批准</option>
					</select>
				</div>
				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
				</div>
				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box" style="display: none">
					<table id="tableIns" lay-filter="tableIns"></table>
				</div>
				<div class="no_data" style="text-align: center;">
					<div class="no_data_img" style="margin-top:12%;">
						<img style="margin-top: 2%;" src="/img/noData.png">
					</div>
					<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧项目</p>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="toolbarHead">
	<div class="layui-btn-container" style="float: left; height: 30px;">
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
		<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
		<button class="layui-btn layui-btn-sm layui-btn" lay-event="choice">模板选择</button>
<%--		<button class="layui-btn layui-btn-sm" lay-event="dayin">打印</button>--%>
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
		<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
		<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>
		<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
		<%--<div class="export_moudle">
            <p class="export_btn" type="1">导出所选数据</p>
            <p class="export_btn" type="2">导出当前页数据</p>
            <p class="export_btn" type="3">导出全部数据</p>
        </div>--%>
	</div>
</script>

<script type="text/html" id="toolBar">
	{{#  if(d.upFlag == 'upFlag'){ }}
	<a class="layui-btn  layui-btn-xs" lay-event="moveup">上移</a>
	{{#  } }}
	{{#  if(d.downFlag == 'downFlag'){ }}
	<a class="layui-btn  layui-btn-xs" lay-event="movedown">下移</a>
	{{#  } }}
	<a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
	var form
	var tableIns = null;

	var tipIndex = null
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text');
		tipIndex = layer.tips(tip, this);
	}, function () {
		layer.close(tipIndex);
	});

	// 表格显示顺序
	var colShowArr = [
		{field: 'documentNo', title: '编号', minWidth: 120,align:'center'},
		// companySort:{field:'companySort',title:'排序号',minWidth: 100},
		{field: 'scheduleName', title: '任务名称', minWidth: 200,align:'center'},
		{field:'scheduleBeginDate',title:'计划开始时间',minWidth: 90,align:'center'},
		{field: 'scheduleEndDate', title: '计划完成时间', minWidth: 90,align:'center'},
		{field: 'scheduleDuration', title: '持续时间',minWidth: 60,align:'center'},
		{field:'beforeSchedule',title:'紧前任务',minWidth: 110,align:'center',templet: function (d) {
				return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
			}},
		// scheduleType: {field: 'scheduleType', title: '类型',minWidth: 100,templet: function (d) {
		// 		if(d.scheduleType) {
		// 			return '<span>'+((dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['object'][d.scheduleType])||'')+'</span>'
		// 		}else {
		// 			return ''
		// 		}
		// 	}},
		{field: 'scheduleUserName', title: '责任人',minWidth: 90,align:'center'},
		{field: 'supervisorUserName', title: '监督人',minWidth: 90,align:'center'},
		{field: 'importanceLevel', title: '重要性',minWidth: 50,align:'center',templet: function (d) {
				if(d.importanceLevel) {
					return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
				}else {
					return ''
				}
			}},
		{field: 'currFlowUserName', title: '当前处理人',minWidth: 90,align:'center'},
		{
			field: 'auditerStatus',
			title: '审核状态',
			minWidth: 90,
			align:'center',
			templet: function (d) {
				var str = '';
				switch (d.auditerStatus) {
					case '0':
						str = '未提交';
						break;
					case '1':
						var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
						str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
						break;
					case '2':
						var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
						str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
						break;
					case '3':
						var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
						str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
						break;
				}
				return str;
			}
		}
	]

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


	// 获取数据字典数据
	var dictionaryObj = {
		PROGRESS_TYPE: {},
		SCHEDULE_INPORTANCE:{}
	}
	var dictionaryStr = 'PROGRESS_TYPE,SCHEDULE_INPORTANCE';
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
	});

	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','treeTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;
		var treeTable = layui.treeTable;



		form.render();

		/* region 修改左侧项目名称 */
		var searchTimer = null;
		$('#search_project').on('input propertychange', function () {
			clearTimeout(searchTimer);
			searchTimer = null;
			var val = $(this).val();
			searchTimer = setTimeout(function () {
				projectLeft(val);
			}, 300);
		});
		$('.search_icon').on('click', function () {
			projectLeft($('#search_project').val());
		});
		/* endregion */

		projectLeft();

		/**
		 * 左侧项目信息列表
		 * @param projectName 项目名称
		 */
		function projectLeft(projectName) {
			projectName = projectName ? projectName : '';
			var loadingIndex = layer.load();
			$.get('/plbOrg/treeListOrg', {projectName: projectName}, function (res) {
				layer.close(loadingIndex);
				if (res.flag) {
					eleTree.render({
						elem: '#leftTree',
						data: res.data,
						highlightCurrent: true,
						showLine: true,
						defaultExpandAll: false,
						request: {
							name: 'name',
							children: "plbProjList",
						}
					});
				}
			});
		}

		// 树节点点击事件
		eleTree.on("nodeClick(leftTree)", function (d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {
				$('#leftId').attr('projId', currentData.projId);
				$('.no_data').hide();
				$('.table_box').show();
				tableInit(currentData.projId);
			} else {
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 监听筛选列
		var checkboxTimer = null;
		form.on('checkbox()', function (data) {
			//判断监听的复选框是筛选列下的复选框
			if ($(data.elem).attr('lay-filter') == 'ew_tb_toggle_colstableObj') {
				checkboxTimer = null;
				clearTimeout(checkboxTimer);
				setTimeout(function () {
					var $parent = $(data.elem).parent().parent();
					var arr = [];
					$parent.find('input[type="checkbox"]').each(function () {
						var obj = {
							showFields: $(this).attr('name'),
							isShow: !$(this).prop('checked')
						}
						arr.push(obj);
					});
				}, 1000);
			}
		});

		// 监听列表头部按钮事件
		treeTable.on('toolbar(tableIns)', function (obj) {
			var checkStatus = tableIns.checkStatus();
			switch (obj.event) {
				case 'add':
					if($('#leftId').attr('projId')){
						newOrEdit(0,checkStatus[0]);
					}else{
						layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
						return false;
					}
					break;
				case 'edit':
					if (checkStatus.length != 1) {
						layer.msg('请选择一项！', {icon: 0});
						return false
					}
					if (checkStatus[0].auditerStatus!=0) {
						layer.msg('已提交不可编辑！', {icon: 0});
						return false
					}
                    if (checkStatus[0].dataForm=='2') {
                        layer.msg('总进度计划不可编辑！', {icon: 0});
                        return false
                    }
					if($('#leftId').attr('projId')){
						newOrEdit(1, checkStatus[0])
					}else{
						layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
						return false;
					}
					break;
				case 'del':
					if (!checkStatus.length) {
						layer.msg('请至少选择一项！', {icon: 0});
						return false
					}
                    if (checkStatus[0].auditerStatus!=0) {
						layer.msg('已提交不可删除！', {icon: 0});
						return false
					}
                    if (checkStatus[0].dataForm=='2') {
                        layer.msg('总进度计划不可删除！', {icon: 0});
                        return false
                    }
					var scheduleId = ''
					checkStatus.forEach(function (v, i) {
						scheduleId += v.scheduleId + ','
					})
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/companySchedule/del', {ids: scheduleId}, function (res) {
							if (res.code=='0') {
								layer.msg('删除成功！', {icon: 1});
							} else {
								layer.msg('删除失败！', {icon: 0});
							}
							layer.close(index)
							
							tableIns.reload()
						})
					});
					break;
				case 'choice':
					layer.open({
						type: 2,
						title: '模板选择',
						btn: ['确定','取消'],
						btnAlign: 'c',
						area: ['100%', '100%'],
						maxmin: true,
						content: '/projectSchedule/projectSchedule?type=model',
						success: function () {

						},
						yes: function (index,layero) {
							var childData  = $(layero).find("iframe")[0].contentWindow.getRepairDate();
							if(childData){
								if(childData.datas){
									$.ajax({
										url:'/companySchedule/importByTemplte?dataForm=3&projectId='+$('#leftId').attr('projId'),
										dataType:'json',
										type:'post',
										data: JSON.stringify(childData.datas),
										contentType: "application/json;charset=UTF-8",
										success:function(res){
											if(res.code===0||res.code==="0"){
												//layer.msg("更新成功",{icon:1});
												layer.msg(res.msg,{icon:1});
												tableIns.reload()
												layer.close(index)
											}else{
												//layer.msg("更新成功",{icon:1});
												layer.msg(res.msg,{icon:0});
											}
										}
									})
								}else {
									childData.dataForm = '3'
									childData.projectId = $('#leftId').attr('projId')||''
									$.ajax({
										url:'/companySchedule/importByTemplteType',
										dataType:'json',
										type:'post',
										data:childData,
										success:function(res){
											if(res.code===0||res.code==="0"){
												//layer.msg("更新成功",{icon:1});
												layer.msg(res.msg,{icon:1});
												tableIns.reload()
												layer.close(index)
											}else{
												//layer.msg("更新成功",{icon:1});
												layer.msg(res.msg,{icon:0});
											}
										}
									})
								}
							}else {
								layer.msg('请选择一项！', {icon: 0});
							}

						}
					})
					break;
				case 'submit':
					if (checkStatus.length == 0) {
						layer.msg('请选择需要提交的数据！', {icon: 0, time: 2000});
						return false;
					}
					var flag = false
					checkStatus.forEach(function(item){
						if(item.auditerStatus != '0'){
							flag = true
							return false;
						}
					})

					if(flag){
						layer.msg('该数据已提交！', {icon: 0, time: 2000});
						return false;
					}
					layer.open({
						type: 1,
						title: '选择流程',
						area: ['70%', '80%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
						success: function () {
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '79'}, function (res) {
								var flowData = []
								$.each(res.data.flowData, function (k, v) {
									flowData.push({
										flowId: k,
										flowName: v
									});
								});
								table.render({
									elem: '#flowTable',
									data: flowData,
									cols: [[
										{type: 'radio'},
										{field: 'flowName', title: '流程名称'}
									]]
								})
							});
						},
						yes: function (index) {
							var loadIndex = layer.load();
							var checkStatus = table.checkStatus('flowTable');
							if (checkStatus.data.length > 0) {
								var flowData = checkStatus.data[0];
								var approvalData = tableIns.checkStatus()
								var scheduleIds=''
								approvalData.forEach(function (item) {
									item.projectName=item.projName==undefined?item.projectName:item.projName;
									item.projectName=item.projectName==undefined?item.projName:item.projectName;
									scheduleIds += item.scheduleId+','
								})

								newWorkFlow(flowData.flowId, function (res) {
									var submitData = {
										scheduleIds:scheduleIds,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/companySchedule/updateRunId',
										data: submitData,
										dataType: 'json',
										type: 'post',
										success: function (res) {
											layer.close(loadIndex);
											if (res.code=='0') {
												layer.close(index);
												layer.msg('提交成功!', {icon: 1});
												
												tableIns.reload()
											} else {
												layer.msg(res.msg, {icon: 2});
											}
										}
									});
								},approvalData);
							} else {
								layer.close(loadIndex);
								layer.msg('请选择一项！', {icon: 0});
							}
						}
					});
					break;
				case 'import'://导入
					layer.msg("功能正在开发中");
					break;
				case 'export'://导出
					layer.msg("功能正在开发中");
					break;
					// case 'dayin':
					// 	if (checkStatus.length != 1) {
					// 		layer.msg('请选择一条需要打印的数据！', {icon: 0, time: 2000});
					// 		return false;
					// 	}
					// 	if(checkStatus[0].auditerStatus != 0){
					// 		var index=layer.load();
					// 		var runId=dataTable[0].runId;
					// 		$.ajax({
					// 			url:'/generateDocx/generateDocxByType?runId='+runId+'&type=securityPunishment',
					// 			success:function(res){
					// 				if(res.flag){
					// 					layer.close(index);
					// 					if(res.obj.reportAttachmentList==undefined||res.obj.reportAttachmentList.length<1||res.obj.reportAttachmentList[0]==""){
					// 						layer.msg('查询失败请刷新重试！', {icon: 0, time: 2000});
					// 						return
					// 					}else{
					// 						var atturl=res.obj.reportAttachmentList[0].attUrl;
					// 						pdurlss(atturl)
					// 					}
					// 				}else{
					// 					layer.close(index);
					// 				}
					//
					// 			}
					// 		})
					// 	}else{
					// 		layer.msg('未提交审批不可打印！', {icon: 0, time: 2000});
					// 	}
					// 	break;
			}
		});
		treeTable.on('tool(tableIns)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'moveup') {
				$.post('/companySchedule/moveSort', {schduleId: data.scheduleId,type:"up",projectId:$('#leftId').attr('projId')}, function (res) {
					if (res.code=='0') {
						layer.msg('上移成功！', {icon: 1});
					} else {
						layer.msg('上移失败！', {icon: 0});
					}
					tableIns.reload()
				})
			}else if (layEvent === 'movedown') {
				$.post('/companySchedule/moveSort', {schduleId: data.scheduleId,type:"down",projectId:$('#leftId').attr('projId')}, function (res) {
					if (res.code=='0') {
						layer.msg('下移成功！', {icon: 1});
					} else {
						layer.msg('下移失败！', {icon: 0});
					}
					tableIns.reload()
				})
			}else if (layEvent === 'detail') {
				newOrEdit(4,data)
			}
		});

		function tableInit(projId) {
			var searchObj = getSearchObj();
			searchObj.projId = projId ? projId : '';
			searchObj.projectId = projId ? projId : '';
			searchObj.delFlag = "0";
			searchObj.dataFormStr = "2,3";

			var cols = [{type: 'checkbox'},].concat(colShowArr);

			cols.push({
				fixed: 'right',
				align: 'center',
				toolbar: '#toolBar',
				title: '操作',
				minWidth: 200
			});

			tableIns = treeTable.render({
				elem: '#tableIns',
				url: '/companySchedule/select',
				where: searchObj,
				toolbar: '#toolbarHead',
				height: 'full-100',
				defaultToolbar: ['filter'],
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
			});
		}

		// 新建/编辑
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			//var content = ''
			var projectId = $('#leftId').attr('projId');
			if (type == '0') {
				title = '新增';
				url = '/companySchedule/insert';
				//content = '/companySchedule/companyScheduleView?type=0&projectId='+projectId
			} else if (type == '1') {
				title = '编辑';
				url = '/companySchedule/updateById';
				//content = '/companySchedule/companyScheduleView?type=1&scheduleId='+data.scheduleId
			}else if(type == '4'){
				title = '查看详情'
				//content = '/companySchedule/companyScheduleView?type=4&scheduleId='+data.scheduleId
			}
			layer.open({
				type: 1,
				title: title,
				area: ['80%', '90%'],
				btn: type != '4'?['保存','提交审批', '取消']:['确定'],
				btnAlign: 'c',
				content:  ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
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
				'                       <label class="layui-form-label form_label">任务名称<span field="scheduleName" class="field_required">*</span></label>\n' +
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
				'                       <label class="layui-form-label form_label">重要性<span field="importanceLevel" class="field_required">*</span></label>\n' +
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
					'                       <label class="layui-form-label form_label">持续时间<span field="scheduleDuration" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="number" name="scheduleDuration" id="scheduleDuration"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">开始时间<span field="scheduleBeginDate" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="scheduleBeginDate" id="scheduleBeginDate" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">结束时间<!--<span field="scheduleEndDate" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="scheduleEndDate" id="scheduleEndDate" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" >\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">责任人<span field="scheduleUserName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="scheduleUserName" id="scheduleUserName" autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>',
					'           <div class="layui-row">' +

					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">监督人<span field="supervisorUserName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="supervisorUserName" id="supervisorUserName" autocomplete="off" class="layui-input">\n' +
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
					'                       <label class="layui-form-label form_label">上级任务<span field="parentScheduleId" class="field_required">*</span></label>\n' +
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
					/*var $select1 = $(".scheduleType");
					var optionStr = '<option value="">请选择</option>';
					optionStr += dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['str']
					$select1.html(optionStr);*/

					//重要性
					var $select2 = $(".importanceLevel");
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
					/*laydate.render({
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
					});*/

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
						$('[name="parentScheduleId"]').val(data&&data.parentSchedule ? data.parentSchedule.scheduleName : '');
						$('[name="parentScheduleId"]').attr('parentScheduleId',data? data.parentScheduleId : '');
						//上级任务开始时间
						$('#schedule_BeginDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleBeginDate : '');
						//上级任务结束时间
						$('#schedule_EndDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleEndDate : '');
						//责任人id
						$('[name="scheduleUserName"]').attr('user_id',data.scheduleUser)
						//监督人id
						$('[name="supervisorUserName"]').attr('user_id',data.supervisorUser)

						//紧前任务
						$('[name="beforeScheduleId"]').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleName : '');
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
							// $('#baseForm input[name="scheduleUserName"]').val(res.object.createUserName).attr('user_id',res.object.createUser);

						});
                        if(data&&data.scheduleId){
                            //上级任务
                            $('[name="parentScheduleId"]').val(data ? data.scheduleName : '');
                            $('[name="parentScheduleId"]').attr('parentScheduleId',data? data.scheduleId : '');
                            //上级任务开始时间
                            $('#schedule_BeginDate').val(data ? data.scheduleBeginDate : '');
                            //上级任务结束时间
                            $('#schedule_EndDate').val(data ? data.scheduleEndDate : '');
                        }
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
						obj.parentScheduleId = $('[name="parentScheduleId"]').attr('parentScheduleId')||'0'

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
						obj.beforeScheduleId = $('[name="beforeScheduleId"]').attr('beforeScheduleId')||''

						obj.projectId = projectId?projectId:data.projectId;

						obj.dataForm = '3'

						if(type == '1'){
							obj.scheduleId= data.scheduleId;
						}

						//进度计划分解选了上一级 开始时间在上一级的时间范围内
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
							if(dateParse(schedule_BeginDate)<=(dateParse(scheduleBeginDate)&&dateParse(scheduleEndDate))&&(dateParse(scheduleBeginDate)&&dateParse(scheduleEndDate))<=dateParse(schedule_EndDate)){
								_flay = false
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
						if($('[name="parentScheduleId"]').val()&&_flay){
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
								} else {
									layer.msg(res.msg, {icon: 7});
								}
							}
						});
					}else {
						layer.close(index);
					}

				},btn2:function(index,layero) {
					if(data!=undefined&&data.auditerStatus != undefined&&data.auditerStatus != '0'){
						layer.msg('该数据已提交！', {icon: 0, time: 2000});
						return false;
					}


					var datas = $('#baseForm').serializeArray();
					var obj = {}
					datas.forEach(function (item) {
						obj[item.name] = item.value
					});

					//上级任务
					obj.parentScheduleId = $('[name="parentScheduleId"]').attr('parentScheduleId')||'0'

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
					obj.beforeScheduleId = $('[name="beforeScheduleId"]').attr('beforeScheduleId')||''

					obj.projectId = projectId?projectId:data.projectId;

					obj.dataForm = '3'

					if(type == '1'){
						obj.scheduleId= data.scheduleId;
					}

					//进度计划分解选了上一级 开始时间在上一级的时间范围内
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
						if(dateParse(schedule_BeginDate)<=(dateParse(scheduleBeginDate)&&dateParse(scheduleEndDate))&&(dateParse(scheduleBeginDate)&&dateParse(scheduleEndDate))<=dateParse(schedule_EndDate)){
							_flay = false
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
					if($('[name="parentScheduleId"]').val()&&_flay){
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
					var loadIndex = layer.load();

					$.ajax({
						url:url,
						data: obj,
						dataType: 'json',
						type: 'post',
						success: function (res) {
							layer.close(loadIndex);
							if (res.code=='0') {
								layer.open({
									type: 1,
									title: '选择流程',
									area: ['70%', '80%'],
									btn: ['确定', '取消'],
									btnAlign: 'c',
									content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
									success: function () {
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '79'}, function (res) {
											var flowData = []
											$.each(res.data.flowData, function (k, v) {
												flowData.push({
													flowId: k,
													flowName: v
												});
											});
											table.render({
												elem: '#flowTable',
												data: flowData,
												cols: [[
													{type: 'radio'},
													{field: 'flowName', title: '流程名称'}
												]]
											})
										});
									},
									yes: function (index) {
										var loadIndex = layer.load();
										var checkStatus = table.checkStatus('flowTable');
										if (checkStatus.data.length > 0) {
											var flowData = checkStatus.data[0];
											var approvalData = res.object;
											/*delete approvalData.detailList
                                            delete approvalData.manageInfoList*/
											approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
											approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
											newWorkFlow(flowData.flowId, function (res) {
												var submitData = {
													scheduleIds:approvalData.scheduleId,
													runId: res.flowRun.runId,
													//manageProjStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/companySchedule/updateRunId',
													data: submitData,
													dataType: 'json',
													type: 'post',
													success: function (res) {
														layer.close(loadIndex);
														if (res.code===0||res.code==="0") {
															layer.close(index);
															layer.msg('提交成功!', {icon: 1});
															
															tableIns.reload()
														} else {
															layer.msg(res.msg, {icon: 2});
														}
													}
												});
											},approvalData);
										} else {
											layer.close(loadIndex);
											layer.msg('请选择一项！', {icon: 0});
										}
									}
								});
							} else {
								layer.msg(res.msg || '保存失败!', {icon: 2});
							}
						}
					});
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

		/**
		 * 获取查询条件
		 * @returns {}
		 */
		function getSearchObj() {
			var searchObj = {
				// wbsNo: $('input[name="wbsNo"]', $('.query_module')).val(),
				// wbsName: $('input[name="wbsName"]', $('.query_module')).val(),
				// approvalStatus: $('select[name="approvalStatus"]', $('.query_module')).val(),
			}
			return searchObj
		}

		// 查询
		$('#searchBtn').on('click', function () {
			var searchParams = {}
			var $seachData = $('.query_module [name]')
			$seachData.each(function () {
				searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
				// 将查询值保存至cookie中
				$.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
			})
			tableIns.reload({
				where: searchParams,
				page: {
					curr: 1 //重新从第 1 页开始
				}
			});
		});

		$(document).on('click', '.one_click', function () {
			var _this = this
			var _name = $(_this).attr('name')
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
						where: {
							projId: $('#leftId').attr('projId')||'',
							projectId: $('#leftId').attr('projId')||'',
							delFlag: '0',
							dataFormStr: "2,3"
						},
						tree: {
							iconIndex: 1,
							idName: 'scheduleId',
							childName: "child"
						},
						cols: [[//表头
							{type: 'radio'},
							{field: 'documentNo', title: '编号', minWidth:150},
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
							// {field: 'scheduleType', title: '类型',minWidth: 100,templet: function (d) {
							// 		if(d.scheduleType) {
							// 			return '<span>'+((dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['object'][d.scheduleType])||'')+'</span>'
							// 		}else {
							// 			return ''
							// 		}
							// 	}},
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
							var _parentScheduleId=$(_this).attr('parentScheduleId');
							if(_name=='beforeScheduleId'){
								_parentScheduleId=$(_this).attr('beforeScheduleId');
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
					if(_name!='beforeScheduleId'){
						//上级任务
						$(_this).val(datas? datas.scheduleName : '');
						$(_this).attr('parentScheduleId',datas? datas.scheduleId : '');
						$('#schedule_BeginDate').val(datas&&datas.dataForm!='1'? datas.scheduleBeginDate : '');
						$('#schedule_EndDate').val(datas? datas.scheduleEndDate : '');
					}else {
						//紧前任务
						$(_this).focus();
						$(_this).val(datas? datas.scheduleName : '');
						$(_this).attr('beforeScheduleId',datas? datas.scheduleId : '');
						$('#schedule_BeginDate2').val(datas&&datas.dataForm!='1'? datas.scheduleBeginDate : '');
						$('#schedule_EndDate2').val(datas? datas.scheduleEndDate : '');
						$(_this).blur();

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

					}

					layer.close(index);
				}
			});
		});
	});

	function getAutoNumber(params, callback) {
		$.get('/planningManage/autoNumber', params, function (res) {
			callback(res);
		});
	}

	/**
	 * 新建流程方法
	 * @param flowId
	 * @param urlParameter
	 * @param cb
	 */
	function newWorkFlow(flowId, cb,approvalData) {
		$.ajax({
			url: '/workflow/work/workfastAdd',
			type: 'get',
			dataType: 'json',
			data: {
				flowId: flowId,
				prcsId: 1,
				flowStep: 1,
				runId: '',
				preView: 0,
				isBudgetFlow: true,
				approvalData:JSON.stringify(approvalData),
				isTabApproval:true,
			},
			async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不安全的
			success: function (res) {
				if (res.flag == true) {
					var data = res.object;
					cb(data);
				}
			}
		});
	}


	//数据列表点击审批状态查看流程功能
	$(document).on('click', '.preview_flow', function() {
		var flowId = $(this).attr('flowId'),
				runId = $(this).attr('runId');
		if (flowId && runId) {
			$.popWindow("/workflow/work/workformPreView?flowId=" + flowId + '&flowStep=&prcsId=&runId=' + runId);
		}
	});




	function openRold(){ //流程转交下一步后会调用此方法
		//刷新表格
		
		tableIns.reload();
	}
	//打印模板
	function pdurlss(that,workNum) { //附件预览点击调取
		var attrUrl=that.split('&FILESIZE')[0];
		var url = attrUrl;
		if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1&&attrUrl.indexOf('isOld=1') == -1){
			var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
			var atturl2 = '';
			if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
				for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
					atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
				}
				url = atturl1 + atturl2;
			}else{
				url = atturl1;
			}
		}
		var type = UrlGetRequest('?'+attrUrl)||'docx';
		type = type.toLowerCase();
		if(type == 'pdf'){
			//$.popWindow('/common/pdfPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
			$.popWindow("/common/PDFBrowser?"+url,PreviewPage,'0','0','1200px','600px');
		}else if(type == 'png' || type == 'jpg' ||  type == 'txt'){
			$.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
		}else if(type == 'doc'||type == 'docx'||type == 'xls'||type == 'xlsx'||type == 'ppt'||type == 'pptx'){
			$.ajax({
				type:'get',
				url:'/syspara/selectTheSysPara?paraName=DOCUMENT_PREVIEW_OPEN',
				dataType:'json',
				success:function (res) {
					if(res.flag){
						documentPreviewOpen = res.object[0].paraValue;
						if(documentPreviewOpen == 1){
							$.ajax({
								type:'get',
								url:'/sysTasks/getOfficePreviewSetting',
								dataType:'json',
								success:function (res) {
									if(res.flag){
										var strOfficeApps = res.object.previewUrl;//在线预览服务地址

										$.ajax({
											url:'/onlyOfficeCode',
											dataType: 'json',
											type: 'post',
											success:function(res){
												if(res.flag){
													var code = res.obj;
													$.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
												}
											}
										})
									}
								}
							})
						}else if(documentPreviewOpen == 2){
							if(type == 'xls'||type == 'xlsx'){
								$.popWindow('/common/excelPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
							}else if(type == 'ppt'||type == 'pptx'){
								$.popWindow('/common/pptPreview?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
							}else{
								$.popWindow('/common/officereader?'+url.split('&COMPANY=')[0],'','0','0','1200px','600px');
							}
						}else if(documentPreviewOpen == 3){
							$.popWindow("/wps/info?"+ url +"&permission=read",'','0','0','1200px','600px');
						}else if(documentPreviewOpen == 4){
							$.popWindow("/common/onlyoffice?"+ url +"&edit=false",'','0','0','1200px','600px');
						}
					}
				}
			})
		} else{
			$.ajax({
				type:'get',
				url:'/sysTasks/getOfficePreviewSetting',
				dataType:'json',
				success:function (res) {
					if(res.flag){
						var strOfficeApps = res.object.previewUrl;//在线预览服务地址
						if(strOfficeApps == ''){
							strOfficeApps = 'https://owa-box.vips100.com';
						}

						$.ajax({
							url:'/onlyOfficeCode',
							dataType: 'json',
							type: 'post',
							success:function(res){
								if(res.flag){
									var code = res.obj;
									$.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/onlyOfficeDownload'+ encodeURIComponent('?'+url + '&code='+ code),'','0','0','1200px','600px');
								}
							}
						})


					}
				}
			})
		}
	}
</script>
</body>
</html>
