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
	<title>总进度实际填报</title>

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
		[data-field="isComplete"] .ew-tree-table-cell-content,
		[data-field="currFlowUserName"] .ew-tree-table-cell-content,
		[data-field="auditerStatus"] .ew-tree-table-cell-content
		{
			min-width: 90px;
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
			<h2 style="text-align: center;line-height: 35px;">总进度实际填报</h2>
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
						<option value="">请选择审批状态</option>
						<option value="0">未提交</option>
						<option value="1">审批中</option>
						<option value="2">批准</option>
						<option value="3">不批准</option>
					</select>
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="isClose">
						<option value="">请选择完成状态</option>
						<option value="01">已完成</option>
						<option value="02">未完成</option>

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
<%--	<div class="layui-btn-container" style="float: left; height: 30px;">--%>
<%--		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>--%>
<%--		<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>--%>
<%--		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>--%>
<%--		<button class="layui-btn layui-btn-sm" lay-event="dayin">打印</button>--%>
<%--	</div>--%>
	<div style="position:absolute;top: 10px;right:60px;">
		<button class="layui-btn layui-btn-sm" lay-event="edit2" style="margin-left:10px;">提交</button>
<%--		<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>--%>
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
{{#  if(!(d.record&&d.record.isComplete&&d.record.isComplete==1)){ }}

	<a class="layui-btn  layui-btn-xs" lay-event="add">填报</a>
{{#  } }}
	<a class="layui-btn  layui-btn-xs" lay-event="detail">查看</a>
{{#  if(!(d.record&&d.record.isComplete&&d.record.isComplete==1)){ }}
	<a class="layui-btn  layui-btn-xs" lay-event="complete">完成</a>
{{#  } }}

</script>

<script type="text/html" id="toolbarDemoIn">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script>
	var form
	var tableIns = null;
	var tableIns2 = null;

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
		{field:'beforeSchedule',title:'紧前工序',minWidth: 110,align:'center',templet: function (d) {
				return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
			}},
		// scheduleType: {field: 'scheduleType', title: '类型',minWidth: 100,templet: function (d) {
		// 		if(d.scheduleType) {
		// 			return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.scheduleType])||'')+'</span>'
		// 		}else {
		// 			return ''
		// 		}
		// 	}},
		{field: 'scheduleUserName', title: '责任人',minWidth: 90,align:'center'},
		{field: 'recordBeginDate', title: '进度开始时间*',minWidth: 120,align:'center',templet: function (d) {
				return '<input type="text" name="recordBeginDate" autocomplete="off" onfocus="clickdata(this)" class="layui-input" '+(d.record&&((d.record.isComplete&&d.record.isComplete==1)||d.record.recordBeginDate)?'disabled':'')+' style="height: 100%;'+(d.record&&((d.record.isComplete&&d.record.isComplete==1)||d.record.recordBeginDate)?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordBeginDate||'') + '">'
			}},
		{field: 'recordDate', title: '进度日期*',minWidth: 120,align:'center',templet: function (d) {
				return '<input type="text" scheduleId="'+(d.scheduleId||'')+'" name="recordDate" autocomplete="off" onfocus="clickdata(this)" class="layui-input" '+(d.record&&d.record.isComplete&&d.record.isComplete==1?'disabled':'')+' style="height: 100%;'+(d.record&&d.record.isComplete&&d.record.isComplete==1?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordDate||'') + '">'
			}},
		{field: 'recordProgress', title: '进展情况',minWidth: 120,align:'center',templet: function (d) {
				return '<input type="text" name="recordProgress" '+(d.record&&d.record.isComplete&&d.record.isComplete==1?'disabled':'')+' class="layui-input" style="height: 100%;'+(d.record&&d.record.isComplete&&d.record.isComplete==1?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.recordProgress||'') + '">'
			}},
		{field: 'percentComplete', title: '完成百分比*',minWidth: 120,align:'center',templet: function (d) {
				return '<input type="number" name="percentComplete" oninput="if(value>100)value=100;if(value<0)value=0" '+(d.record&&d.record.isComplete&&d.record.isComplete==1?'disabled':'')+' class="layui-input" style="height: 100%;'+(d.record&&d.record.isComplete&&d.record.isComplete==1?"background: #e7e7e7":"")+'" value="' + (d.record&&d.record.percentComplete||'') + '">'
			}},
		{field: 'isComplete', title: '实际进度状态',minWidth: 90,align:'center',templet: function (d) {
				if(d.record&&d.record.isComplete){
					if(d.record.isComplete==0){
						return '<span isComplete="0">未完成</span>'
					}else if(d.record.isComplete==1){
						return '<span isComplete="1">完成</span>'
					}
				}else {
					return '<span>未完成</span>'
				}
			}},
        {field: 'createUserName', title: '填报人',minWidth: 90,align:'center'},
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
				// case 'add':
				// 	if($('#leftId').attr('projId')){
				// 		newOrEdit(0);
				// 	}else{
				// 		layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
				// 		return false;
				// 	}
				// 	break;
				// case 'edit':
				// 	if (checkStatus.length != 1) {
				// 		layer.msg('请选择一项！', {icon: 0});
				// 		return false
				// 	}
				// 	if (checkStatus[0].auditerStatus!=0) {
				// 		layer.msg('已提交不可编辑！', {icon: 0});
				// 		return false
				// 	}
				// 	if($('#leftId').attr('projId')){
				// 		newOrEdit(1, checkStatus[0])
				// 	}else{
				// 		layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
				// 		return false;
				// 	}
				// 	break;
				// case 'del':
				// 	if (!checkStatus.length) {
				// 		layer.msg('请至少选择一项！', {icon: 0});
				// 		return false
				// 	}
				// 	var scheduleId = ''
				// 	checkStatus.forEach(function (v, i) {
				// 		scheduleId += v.scheduleId + ','
				// 	})
				// 	layer.confirm('确定删除该条数据吗？', function (index) {
				// 		$.post('/companySchedule/del', {ids: scheduleId}, function (res) {
				// 			if (res.code=='0') {
				// 				layer.msg('删除成功！', {icon: 1});
				// 			} else {
				// 				layer.msg('删除失败！', {icon: 0});
				// 			}
				// 			layer.close(index)
				//
				// 			tableIns.reload()
				// 		})
				// 	});
				// 	break;
				case 'edit2':
					//遍历表格获取每行数据
					var $trs = $('.table_box').find('.layui-table tbody tr [data-type="checkbox"] .layui-form-checked');

					if ($trs.length == 0) {
						layer.msg('请选择需要保存的数据！', {icon: 0, time: 2000});
						return false;
					}

					var dataArr = [];
					// 判断是否完成
					var flay = false
					// 判断必填项
					var requiredFlag = false;
					$trs.parents('tr').each(function (index) {
						var dataObj = {
							recordBeginDate: $(this).find('[name="recordBeginDate"]').val(),
							recordDate: $(this).find('[name="recordDate"]').val(),
							recordProgress: $(this).find('[name="recordProgress"]').val(),
							percentComplete: $(this).find('[name="percentComplete"]').val(),
							dataForm : '2'
						}
						if($(this).find('[name="recordDate"]').attr('scheduleId')){
							dataObj.scheduleId = $(this).find('[name="recordDate"]').attr('scheduleId')
						}
						if(dataObj.percentComplete=='100'&&$(this).find('[data-field="isComplete"] span').attr('isComplete')!=1){
							flay = true
						}
						if(!dataObj.recordBeginDate){
							layer.msg('进度开始时间不能为空！', {icon: 0, time: 2000});
							requiredFlag = true;
							return false;
						}
						if(!dataObj.recordDate){
							layer.msg('进度日期不能为空！', {icon: 0, time: 2000});
							requiredFlag = true;
							return false;
						}
						if(!dataObj.percentComplete){
							layer.msg('完成百分比不能为空！', {icon: 0, time: 2000});
							requiredFlag = true;
							return false;
						}

						dataArr.push(dataObj);
					})
					if (requiredFlag) {
						return false;
					}

					if(flay){
						layer.confirm('是否确认完成？', function (index) {
							var loadIndex = layer.load();
							$.ajax({
								url: '/procedureSchedule/insert?isclose=true',
								data: JSON.stringify(dataArr),
								dataType: 'json',
								contentType: "application/json;charset=UTF-8",
								type: 'post',
								success: function (res) {
									layer.close(loadIndex);
									if (res.code=='0') {
										layer.msg('保存成功！', {icon: 1});
										layer.close(index)
										tableIns.reload();
									} else {
										layer.close(index)
										layer.msg(res.msg, {icon: 7});
									}
								}
							});
						}, function (index) {
								var loadIndex = layer.load();
								$.ajax({
									url: '/procedureSchedule/insert?isclose=true',
									data: JSON.stringify(dataArr),
									dataType: 'json',
									contentType: "application/json;charset=UTF-8",
									type: 'post',
									success: function (res) {
										layer.close(loadIndex);
										if (res.code=='0') {
											layer.msg('保存成功！', {icon: 1});
											layer.close(index)
											tableIns.reload();
										} else {
											layer.close(index)
											layer.msg(res.msg, {icon: 7});
										}
									}
								});
							}
						);
					}else{
						var loadIndex = layer.load();
						$.ajax({
							url: '/procedureSchedule/insert?isclose=true',
							data: JSON.stringify(dataArr),
							dataType: 'json',
							contentType: "application/json;charset=UTF-8",
							type: 'post',
							success: function (res) {
								layer.close(loadIndex);
								if (res.code=='0') {
									layer.msg('保存成功！', {icon: 1});
									tableIns.reload();
								} else {
									layer.msg(res.msg, {icon: 7});
								}
							}
						});
					}

					break;
				case 'submit':
					if (checkStatus.length != 1) {
						layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
						return false;
					}
					if(checkStatus[0].auditerStatus != '0'){
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
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '62'}, function (res) {
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
								var approvalData = tableIns.checkStatus()[0]
								approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
								approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
								newWorkFlow(flowData.flowId, function (res) {
									var submitData = {
										scheduleId:approvalData.scheduleId,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/companySchedule/updateById',
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
			var $tr = obj.tr;
			if (layEvent === 'add') {
				newOrEdit(1,data)
			}else if (layEvent === 'detail') {
				newOrEdit(4,data)
			}else if (layEvent === 'complete') {
				if(!$($tr[0]).find('[name="percentComplete"]').val()){
					layer.msg('请先填报！', {icon: 0, time: 2000});
					return false;
				}
				var obj = {
					scheduleId: $($tr[0]).find('[name="recordDate"]').attr('scheduleId'),
					recordDate: $($tr[0]).find('[name="recordDate"]').val(),
					recordProgress: $($tr[0]).find('[name="recordProgress"]').val(),
					percentComplete: $($tr[0]).find('[name="percentComplete"]').val(),
					isclose: true
				}

				layer.confirm('是否确认完成？', function (index) {
					$.ajax({
						url: '/procedureSchedule/insert?isclose=true',
						data: JSON.stringify([obj]),
						dataType: 'json',
						contentType: "application/json;charset=UTF-8",
						type: 'post',
						success: function (res) {
							if (res.code=='0') {
								layer.msg('完成成功！', {icon: 1});

								tableIns.reload();
							} else {
								layer.msg(res.msg, {icon: 7});
							}
						}
					});
				});

			}
		});

		function tableInit(projId) {
			var searchObj = getSearchObj();
			searchObj.projId = projId ? projId : '';
			searchObj.projectId = projId ? projId : '';
            searchObj.delFlag = '0';
			searchObj.dataForm = '2';

			var cols = [{type: 'checkbox'},].concat(colShowArr);
			cols.push({
				fixed: 'right',
				align: 'center',
				toolbar: '#toolBar',
				title: '操作',
				minWidth: 180
			});

			tableIns = treeTable.render({
				elem: '#tableIns',
				url: '/procedureSchedule/select',
				where: searchObj,
				height: 'full-100',
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
				url = '/procedureSchedule/insert';
				//content = '/companySchedule/companyScheduleView?type=0&projectId='+projectId
			} else if (type == '1') {
				title = '填报';
				url = '/procedureSchedule/insert';
				//content = '/companySchedule/companyScheduleView?type=1&scheduleId='+data.scheduleId
			}else if(type == '4'){
				title = '查看详情'
				//content = '/companySchedule/companyScheduleView?type=4&scheduleId='+data.scheduleId
			}
			layer.open({
				type: 1,
				title: title,
				area: ['80%', '90%'],
				btn: type != '4'?['提交', '取消']:['确定'],
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
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">排序号</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="companySort" style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">任务名称</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="scheduleName" style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
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
				'           </div>' ,
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">上级任务</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="parentScheduleId" style="background: #e7e7e7" autocomplete="off" class="layui-input one_click">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">持续时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="number" name="scheduleDuration" id="scheduleDuration" style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">开始时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="scheduleBeginDate" id="scheduleBeginDate" style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
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
					'           </div>',
					'           <div class="layui-row">' +
					/*'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">间隔时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="number" name="intervalTime" id="intervalTime" style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +*/
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">类型<!--<span field="scheduleType" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <select class="scheduleType" name="scheduleType" ></select>\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">责任人<!--<span field="scheduleUserName" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="scheduleUserName" id="scheduleUserName" style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">监督人<!--<span field="supervisorUserName" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="supervisorUserName" id="supervisorUserName" style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
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
					'           </div>' +
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
					'                       <label class="layui-form-label form_label">紧前任务开始时间<!--<span field="afterScheduleDate" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="schedule_BeginDate2" id="schedule_BeginDate2" disabled style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">紧前任务结束时间<!--<span field="afterScheduleDate" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="schedule_EndDate2" id="schedule_EndDate2" disabled style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'      		 </div>' +
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3 displayNone" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">进展情况<!--<span field="beforeScheduleDate" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="oldrecordProgress" id="oldrecordProgress" style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3 displayNone2" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">完成百分比<!--<span field="afterScheduleId" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="number" name="oldpercentComplete"  id="oldpercentComplete" style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>',
					/* endregion */
					'    </div>\n' +
					'  </div>\n' +
					/* endregion  进展填报 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">进展明细</h2>\n' +
					'    <div class="layui-colla-content layui-show mtl_info">' +
                    '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
                    '<ul class="layui-tab-title">' +
                    '<li class="layui-this">进展填报</li>' +
                    '<li>历史填报</li>' +
                    '</ul>' +
                    '<div class="layui-tab-content">' +
                    '<div class="layui-tab-item layui-show contract_list">' +
                    '<div id="contractDetailsModule">' +
                    '           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">进度开始时间<span field="recordBeginDate" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="recordBeginDate" id="recordBeginDate" autocomplete="off" class="layui-input one_click">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
                    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">进度日期<span field="recordDate" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                           <input type="text" name="recordDate" id="recordDate" autocomplete="off" class="layui-input one_click">' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">进展情况<!--<span field="beforeScheduleDate" class="field_required">*</span>--></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="text" name="recordProgress" id="recordProgress"  autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">完成百分比<span field="percentComplete" class="field_required">*</span></label>\n' +
                    '                       <div class="layui-input-block form_block">\n' +
                    '                       <input type="number" name="percentComplete" oninput="if(value>100)value=100;if(value<0)value=0" id="percentComplete"  autocomplete="off" class="layui-input">\n' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '       </div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">填报时间<!--<span field="createTime" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="createTime" id="createTime" disabled autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'       </div>',
                    /* endregion */
                    '           <div class="layui-row">' +
                    '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
                    '                   <div class="layui-form-item">\n' +
                    '                       <label class="layui-form-label form_label">成果</label>' +
                    '                       <div class="layui-input-block form_block">' +
                    '<div class="file_module">' +
                    '<div id="fileContent" class="file_content"></div>' +
                    '<div class="file_upload_box">' +
                    '<a href="javascript:;" class="open_file">' +
                    '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                    '<input type="file" multiple id="fileupload" data-url="/upload?module=workflow" name="file">' +
                    '</a>' +
                    '<div class="progress" id="progress">' +
                    '<div class="bar"></div>\n' +
                    '</div>' +
                    '<div class="bar_text"></div>' +
                    '</div>' +
                    '</div>' +
                    '                       </div>\n' +
                    '                   </div>' +
                    '               </div>' +
                    '           </div>',
                    /* endregion */
                    '</div>' +
                    '</div>' +
                    '<div class="layui-tab-item contract_out">' +
                    '<div id="paymentSettlementModule">' +
                    '<table id="paymentSettlementTable" lay-filter="paymentSettlementTable"></table>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
					/* endregion */
					'</div>\n' +
					'  </div>' +
					'</div>' +
					'</form>'].join(''),
				success: function () {
					//回显项目名称
					getProjName('#projectName',projectId?projectId:data.projectId)

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

					$('.plan_base_info').find('input,select').attr('disabled', 'disabled');

					fileuploadFn('#fileupload', $('#fileContent'));

					laydate.render({
						elem: '#recordBeginDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						/*, done: function(value, date){
							if(value){
								$('#recordBeginDate').attr('disabled','disabled')
								$('#recordBeginDate').css('background','#e7e7e7')
							}
						}*/
					});
					laydate.render({
						elem: '#recordDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
					});
                    laydate.render({
                        elem: '#createTime'
                        , trigger: 'click'
                        // , format: 'yyyy-MM-dd'
                        , format: 'yyyy-MM-dd HH:mm:ss'
                        ,value: new Date()
                    });

					//回显数据
					if (type == 1 || type == 4) {
						form.val("formTest", data);
						//上级任务
						$('[name="parentScheduleId"]').val(data&&data.parentSchedule ? data.parentSchedule.scheduleName : '');
						// $('[name="parentScheduleId"]').attr('parentScheduleId',data? data.parentScheduleId : '');
						//责任人id
						// $('[name="scheduleUserName"]').attr('user_id',data.scheduleUser)
						//监督人id
						// $('[name="supervisorUserName"]').attr('user_id',data.supervisorUser)

						//紧前任务
						$('[name="beforeScheduleId"]').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleName : '');
						//紧前时间
						$('[name="beforeScheduleDate"]').val(data&&data.beforeSchedule ? data.beforeSchedule.beforeScheduleDate : '');
						//紧前任务的开始时间
						$('#schedule_BeginDate2').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleBeginDate : '');
						//紧前任务的结束时间
						$('#schedule_EndDate2').val(data&&data.beforeSchedule ? data.beforeSchedule.scheduleEndDate : '');

						if(!(data.record&&data.record.recordProgress)){
							$('.displayNone').hide()
						}
						if(!(data.record&&data.record.percentComplete)){
							$('.displayNone2').hide()
						}

						$('#oldrecordProgress').val(data.record&&data.record.recordProgress||'')
						$('#oldpercentComplete').val(data.record&&data.record.percentComplete||'')

						//进度开始时间
						if(data.record&&data.record.recordBeginDate){
							$('#recordBeginDate').css('background','#e7e7e7')
							$('#recordBeginDate').attr('disabled', 'disabled').val(data.record.recordBeginDate)
						}



						//附件
						if (data.attachmentList && data.attachmentList.length > 0) {
							var fileArr = data.attachmentList;
							$('#fileContent').append(echoAttachment(fileArr));
						}


						tableIns2  = table.render({
                            elem: '#paymentSettlementTable',
                            //data: [],
                            url:data&&data.scheduleId?'/procedureSchedule/selectRecordData?delFlag=0&scheduleId='+data.scheduleId:'',
                            defaultToolbar: [''],
							// toolbar: type==4?false:'#toolbarDemoIn',
                            limit: 1000,
                            cols: [[
								// {checkbox: true},
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'recordDate', title: '进度日期', minWidth: 200,
                                },
                                {
                                    field: 'recordProgress', title: '进展情况', minWidth: 200,
                                },
                                {
                                    field: 'percentComplete', title: '完成百分比', minWidth: 200,
                                },
                                {
                                    field: 'createTime', title: '填报时间', minWidth: 200,
                                },
								{
									field: 'attachName',
									title: '附件',
									align: 'center',
									minWidth: 200,
									templet: function (d) {
										var fileArr = d.attachmentList;
										return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
												'</div>'

									}
								}
                            ]],
                            done:function (res) {
                                // if(type==4||type==5){
                                //     $('.addRow').hide()
                                // }
                            }
                        });

						//查看详情
						if(type==4){
							$('._disabled').find('input,select').attr('disabled', 'disabled');
							$('.refresh_no_btn').hide();
							$('.file_upload_box').hide()
							$('.deImgs').hide();
						}
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

						obj.createTime = $('#createTime').val()||''

						obj.recordBeginDate = $('#recordBeginDate').val()||''

						// 附件
						var attachmentId = '';
						var attachmentName = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');

						}
						obj.attachmentId = attachmentId;
						obj.attachmentName = attachmentName;

						// obj.projectId = projectId?projectId:data.projectId;


						if(type == '1'){
							obj.scheduleId= data.scheduleId;
						}

						obj.dataForm = '2'

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
							data: JSON.stringify([obj]),
							dataType: 'json',
							contentType: "application/json;charset=UTF-8",
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

				}
				//,
				<%--btn2:function(index,layero) {--%>
				<%--	if(data!=undefined&&data.auditerStatus != undefined&&data.auditerStatus != '0'){--%>
				<%--		layer.msg('该数据已提交！', {icon: 0, time: 2000});--%>
				<%--		return false;--%>
				<%--	}--%>


				<%--	var datas = $('#baseForm').serializeArray();--%>
				<%--	var obj = {}--%>
				<%--	datas.forEach(function (item) {--%>
				<%--		obj[item.name] = item.value--%>
				<%--	});--%>

				<%--	obj.createTime = $('#createTime').val()||''--%>

				<%--	obj.recordBeginDate = $('#recordBeginDate').val()||''--%>

				<%--	// 附件--%>
				<%--	var attachmentId = '';--%>
				<%--	var attachmentName = '';--%>
				<%--	for (var i = 0; i < $('#fileContent .dech').length; i++) {--%>
				<%--		attachmentId += $('#fileContent .dech').eq(i).find('input').val();--%>
				<%--		attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');--%>

				<%--	}--%>
				<%--	obj.attachmentId = attachmentId;--%>
				<%--	obj.attachmentName = attachmentName;--%>

				<%--	// obj.projectId = projectId?projectId:data.projectId;--%>


				<%--	if(type == '1'){--%>
				<%--		obj.scheduleId= data.scheduleId;--%>
				<%--	}--%>

				<%--	obj.dataForm = '2'--%>

				<%--	// 判断必填项--%>
				<%--	var requiredFlag = false;--%>
				<%--	$('#baseForm').find('.field_required').each(function(){--%>
				<%--		var field = $(this).attr('field');--%>
				<%--		if (!obj[field]) {--%>
				<%--			var fieldName = $(this).parent().text().replace('*', '');--%>
				<%--			layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});--%>
				<%--			requiredFlag = true;--%>
				<%--			return false;--%>
				<%--		}--%>
				<%--	});--%>
				<%--	if (requiredFlag) {--%>
				<%--		return false;--%>
				<%--	}--%>

				<%--	var loadIndex = layer.load();--%>

				<%--	$.ajax({--%>
				<%--		url:url,--%>
				<%--		data: JSON.stringify([obj]),--%>
				<%--		dataType: 'json',--%>
				<%--		contentType: "application/json;charset=UTF-8",--%>
				<%--		type: 'post',--%>
				<%--		success: function (res) {--%>
				<%--			layer.close(loadIndex);--%>
				<%--			if (res.code=='0') {--%>
				<%--				layer.open({--%>
				<%--					type: 1,--%>
				<%--					title: '选择流程',--%>
				<%--					area: ['70%', '80%'],--%>
				<%--					btn: ['确定', '取消'],--%>
				<%--					btnAlign: 'c',--%>
				<%--					content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',--%>
				<%--					success: function () {--%>
				<%--						$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '62'}, function (res) {--%>
				<%--							var flowData = []--%>
				<%--							$.each(res.data.flowData, function (k, v) {--%>
				<%--								flowData.push({--%>
				<%--									flowId: k,--%>
				<%--									flowName: v--%>
				<%--								});--%>
				<%--							});--%>
				<%--							table.render({--%>
				<%--								elem: '#flowTable',--%>
				<%--								data: flowData,--%>
				<%--								cols: [[--%>
				<%--									{type: 'radio'},--%>
				<%--									{field: 'flowName', title: '流程名称'}--%>
				<%--								]]--%>
				<%--							})--%>
				<%--						});--%>
				<%--					},--%>
				<%--					yes: function (index) {--%>
				<%--						var loadIndex = layer.load();--%>
				<%--						var checkStatus = table.checkStatus('flowTable');--%>
				<%--						if (checkStatus.data.length > 0) {--%>
				<%--							var flowData = checkStatus.data[0];--%>
				<%--							var approvalData = res.object;--%>
				<%--							/*delete approvalData.detailList--%>
                <%--                            delete approvalData.manageInfoList*/--%>
				<%--							approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;--%>
				<%--							approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;--%>
				<%--							newWorkFlow(flowData.flowId, function (res) {--%>
				<%--								var submitData = {--%>
				<%--									scheduleId:approvalData.scheduleId,--%>
				<%--									runId: res.flowRun.runId,--%>
				<%--									//manageProjStatus:1--%>
				<%--								}--%>
				<%--								$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');--%>

				<%--								$.ajax({--%>
				<%--									url: '/companySchedule/updateById',--%>
				<%--									data: submitData,--%>
				<%--									dataType: 'json',--%>
				<%--									type: 'post',--%>
				<%--									success: function (res) {--%>
				<%--										layer.close(loadIndex);--%>
				<%--										if (res.code===0||res.code==="0") {--%>
				<%--											layer.close(index);--%>
				<%--											layer.msg('提交成功!', {icon: 1});--%>

				<%--											tableIns.reload()--%>
				<%--										} else {--%>
				<%--											layer.msg(res.msg, {icon: 2});--%>
				<%--										}--%>
				<%--									}--%>
				<%--								});--%>
				<%--							},approvalData);--%>
				<%--						} else {--%>
				<%--							layer.close(loadIndex);--%>
				<%--							layer.msg('请选择一项！', {icon: 0});--%>
				<%--						}--%>
				<%--					}--%>
				<%--				});--%>
				<%--			} else {--%>
				<%--				layer.msg(res.msg || '保存失败!', {icon: 2});--%>
				<%--			}--%>
				<%--		}--%>
				<%--	});--%>
				<%--}--%>
			});
		}

		// 内部删行操作
		table.on('toolbar(paymentSettlementTable)', function (obj) {
			var checkStatus = table.checkStatus(obj.config.id).data;
			var layEvent = obj.event;

			if (layEvent === 'del') {
				// obj.del();
				var ids = ''
				checkStatus.forEach(function (v) {
					ids += v.scheduleRecordId + ',';
				});
				if (ids) {
					$.get('/procedureSchedule/del', {ids: ids}, function (res) {
						if(res.flag){
							layer.msg(res.msg, {icon: 1});
						}else {
							layer.msg(res.msg, {icon: 2});
						}
					});
				}
				tableIns2.reload()
			}
		});


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
				// $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
			})
			tableIns.reload({
				where: searchParams,
				page: {
					curr: 1 //重新从第 1 页开始
				}
			});
		});

	});

	function clickdata(_this){
		layui.laydate.render({
			elem: _this
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
			/*, done: function(value, date){
				if(value&&$(_this).attr('name')=='recordBeginDate'){
					$(_this).attr('disabled','disabled')
					$(_this).css('background','#e7e7e7')
				}
			}*/
		});
	}


	// function getAutoNumber(params, callback) {
	// 	$.get('/planningManage/autoNumber', params, function (res) {
	// 		callback(res);
	// 	});
	// }

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
