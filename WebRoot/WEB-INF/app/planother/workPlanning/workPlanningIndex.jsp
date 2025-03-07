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
	<title>项目实施策划</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
	<script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
	<script src="../js/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="/js/planother/planotherUtil.js?21202108301508"></script>

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

		/* region 左侧样式 */
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

		/* endregion */

		/* region 右侧样式 */
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

		/* endregion */

		/* region 上传附件样式 */
		.file_upload_box {
			position: relative;
			height: 22px;
			overflow: hidden;
		}

		.open_file {
			float: left;
			position: relative;
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

		/*选中行样式*/
		.selectTr {
			background: #009688 !important;
			color: #fff !important;
		}

		.refresh_no_btn {
			display: none;
			margin-left: 2%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}
		.layui-col{
			width: 20%;
		}
		/*.quality_planning, .quality_planning .layui-table-cell,.quality_planning .layui-table-box,.quality_planning .layui-table-body {
			overflow: visible;
		}
		!* 设置下拉框的高度与表格单元格的高度相同 *!
		.quality_planning td .layui-form-select {
			margin-top: -10px;
			margin-left: -15px;
			margin-right: -15px;
		}
		.security_planning, .security_planning .layui-table-cell,.security_planning .layui-table-box,.security_planning .layui-table-body {
			overflow: visible;
		}
		!* 设置下拉框的高度与表格单元格的高度相同 *!
		.security_planning td .layui-form-select {
			margin-top: -10px;
			margin-left: -15px;
			margin-right: -15px;
		}*/

		#downBox2 td[data-field="attachmentName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}
		.openFile input[type=file]{
			position: absolute;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			width: 100%;
			height: 18px;
			z-index: 99;
			opacity: 0;
		}
		.optimization_scheme td[data-field="attachmentName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}
		.secondary_operation td[data-field="attachmentName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}

		.project_detailed td[data-field="attachmentName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}

		.project_detailed .dech a{
			display: block;
		}
		.project_detailed .dech a:nth-of-type(2){
			display: none;
		}
		.project_detailed .dech a:nth-of-type(3){
			display: none;
		}
		.project_detailed .dech:hover a{
			display: block;
		}

		.project_detailed .layui-table-body{
			overflow-x: hidden !important;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">项目实施策划</h2>
			<div class="left_form">
				<div class="search_icon">
					<i class="layui-icon layui-icon-search"></i>
				</div>
				<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off"
					   class="layui-input"/>
			</div>
			<div class="tree_module">
				<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
			</div>
		</div>
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2">
					<input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="workPlanningName" placeholder="策划名称" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="auditerStatus">
						<option value="">请选择审批状态</option>
						<option value="0">未提交</option>
						<option value="1">审批中</option>
						<option value="2">批准</option>
						<option value="3">不批准</option>
					</select>
				</div>
				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
					<%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
				</div>
				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box" style="display: none">
					<table id="tableDemo" lay-filter="tableDemo"></table>
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

<script type="text/html" id="toolbarDemo">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
		<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
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

<script type="text/html" id="detailBarDemo">
	<a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script type="text/html" id="toolbarHead">
	<div class="layui-btn-container" style="float: left; height: 30px;">
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
	</div>
</script>

<script type="text/html" id="toolBar">
	<a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script type="text/html" id="toolbarPlan">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
	</div>
</script>

<script type="text/html" id="toolbarPlan2">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="choice">选择</button>
	</div>
</script>


<script type="text/html" id="barPlan">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script>
	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});
	
	var scheduleTableData = []
	var costTableData = []


	var tableIns = null;
	var table_Ins = null;
	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable','treeTable','xmSelect'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;
		var soulTable = layui.soulTable;
		var treeTable = layui.treeTable;
		var xmSelect = layui.xmSelect;


		form.render();
		//表格显示顺序
		var colShowObj = {
			documentNo: {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false,templet: function (d) {
					return '<span workPlanningId="'+d.workPlanningId+'">'+d.documentNo+'</span>'
				}},
			projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
			workPlanningName: {field: 'workPlanningName', title: '策划名称', minWidth: 120,sort: true, hide: false},
			createUserName: {field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
			createTime: {field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
			memo: {field: 'memo', title: '备注',minWidth: 120, sort: true, hide: false},
			currFlowUserName: {field: 'currFlowUserName', title: '当前处理人',minWidth: 130, sort: false, hide: false},
			auditerStatus: {
				field: 'auditerStatus',
				title: '审核状态',
				minWidth: 120,
				sort: true,
				hide: false,
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
		}

		// 获取数据字典数据
		var dictionaryObj = {
			CONTROL_TYPE:{},
			CBS_UNIT:{},
			CHECK_FREQUENCY:{},
			IMPORTANCE_LEVEL:{},
			OPTIMIZATION_CATEGORY:{},
			OPTIMIZATION_TYPE:{},
			BUSINESS_CATEGORY:{},
			BUSINESS_TYPE:{},
			SCHEDULE_INPORTANCE:{}
		}
		var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT,CHECK_FREQUENCY,IMPORTANCE_LEVEL,OPTIMIZATION_CATEGORY,OPTIMIZATION_TYPE,BUSINESS_CATEGORY,BUSINESS_TYPE,SCHEDULE_INPORTANCE';
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

		var TableUIObj = new TableUI('plb_other_work_planning');

		$(document).on('mouseenter', '.tips', function() {
			var content = $(this).val()||$(this).text();
			if(!content){
				return false
			}

			this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
				time: -1
				,maxWidth: 280
				,tips: [3, '#3A3D49']
			});
		}).on('mouseleave', '.tips', function() {
			layer.close(this.index);
		});;

		// 初始化左侧项目
		projectLeft();
		// 上方按钮显示
		table.on('toolbar(tableDemo)', function (obj) {
			var checkStatus = table.checkStatus(obj.config.id);
			var dataTable=table.checkStatus(obj.config.id).data;
			switch (obj.event) {
				case 'add':
					if($('#leftId').attr('projId')){
						newOrEdit(0);
					}else{
						layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
						return false;
					}
					break;
				case 'edit':
					if (checkStatus.data.length != 1) {
						layer.msg('请选择一项！', {icon: 0});
						return false
					}
					if (checkStatus.data[0].auditerStatus!=0) {
						layer.msg('已提交不可编辑！', {icon: 0});
						return false
					}
					if($('#leftId').attr('projId')){
						var workPlanningId = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span').attr('workPlanningId')
						newOrEdit(1, workPlanningId)
					}else{
						layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
						return false;
					}
					break;
				case 'del':
					if (!checkStatus.data.length) {
						layer.msg('请至少选择一项！', {icon: 0});
						return false
					}
					var isFlay  = false
					checkStatus.data.forEach(function (v, i) {
						if(v.auditerStatus&&v.auditerStatus!='0'){
							isFlay = true
						}
					})
					if(isFlay){
						layer.msg('已提交不可删除！', {icon: 0});
						return false
					}
					var workPlanningId = ''
					var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span')
					$trs.each(function(){
						workPlanningId += $(this).attr('workPlanningId') + ','
					})
					// checkStatus.data.forEach(function (v, i) {
					// 	workPlanningId += v.workPlanningId + ','
					// })
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/workPlanning/del', {ids: workPlanningId}, function (res) {
							if (res.code=='0') {
								layer.msg('删除成功！', {icon: 1});
							} else {
								layer.msg('删除失败！', {icon: 0});
							}
							layer.close(index)
							tableIns.config.where._ = new Date().getTime();
							tableIns.reload()
						})
					});
					break;
				case 'submit':
					if (checkStatus.data.length != 1) {
						layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
						return false;
					}
					if(checkStatus.data[0].auditerStatus != '0'){
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
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '39'}, function (res) {
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
								var approvalData = table.checkStatus(obj.config.id).data[0]

								// delete approvalData.securityWithBLOBsList
								// delete approvalData.qualityWithBLOBsList

								approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
								approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
								newWorkFlow(flowData.flowId, function (res) {
									var submitData = {
										workPlanningId:approvalData.workPlanningId,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/workPlanning/updateById',
										data: JSON.stringify(submitData),
										dataType: 'json',
										contentType: "application/json;charset=UTF-8",
										type: 'post',
										success: function (res) {
											layer.close(loadIndex);
											if (res.code=='0') {
												layer.close(index);
												layer.msg('提交成功!', {icon: 1});
												tableIns.config.where._ = new Date().getTime();
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
			}
		});
		table.on('tool(tableDemo)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;

			var workPlanningId = $(obj.tr.selector).find('[data-field="documentNo"] span').attr('workPlanningId')
			if(layEvent === 'detail'){
				newOrEdit(4,workPlanningId)
			}
		});
		// 监听排序事件
		table.on('sort(tableDemo)', function (obj) {
			var param = {
				orderbyFields: obj.field,
				orderbyUpdown: obj.type
			}

			TableUIObj.update(param, function () {
				tableShow($('#leftId').attr('projId'))
			})
		});



		// 监听筛选列
		form.on('checkbox()', function (data) {
			//判断监听的复选框是筛选列下的复选框
			if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
				setTimeout(function () {
					var $parent = $(data.elem).parent().parent()
					var arr = []
					$parent.find('input[type="checkbox"]').each(function () {
						var obj = {
							showFields: $(this).attr('name'),
							isShow: !$(this).prop('checked')
						}
						arr.push(obj)
					})
					var param = {showFields: JSON.stringify(arr)}
					TableUIObj.update(param)
				}, 1000)
			}
		});

		var searchTimer = null
		$('#search_project').on('input propertychange', function () {
			clearTimeout(searchTimer)
			searchTimer = null
			var val = $(this).val()
			searchTimer = setTimeout(function () {
				projectLeft(val)
			}, 300)
		});
		$('.search_icon').on('click', function () {
			projectLeft($('#search_project').val())
		});

		//左侧项目信息列表
		function projectLeft(projectName) {
			projectName = projectName ? projectName : ''
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
					TableUIObj.init(colShowObj,function () {
						// tableShow('')
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
				tableShow(currentData.projId);
			} else {
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 渲染表格
		function tableShow(projId) {
			var cols = [{checkbox: true}].concat(TableUIObj.cols)

			cols.push({
				fixed: 'right',
				align: 'center',
				toolbar: '#detailBarDemo',
				title: '操作',
				width: 100
			})

			tableIns = table.render({
				elem: '#tableDemo',
				url: '/workPlanning/select',
				toolbar: '#toolbarDemo',
				cols: [cols],
				defaultToolbar: ['filter'],
				// height: 'full-80',
				page: {
					limit: TableUIObj.onePageRecoeds,
					limits: [10, 20, 30, 40, 50]
				},
				where: {
					// projId: projId,
					projectId: projId,
					delFlag: '0'
					//orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
					//orderbyUpdown: TableUIObj.orderbyUpdown
				},
				autoSort: false,
				// parseData: function (res) { //res 即为原始返回的数据
				//     return {
				//         "code": 0, //解析接口状态
				//         "data": res.data, //解析数据列表
				//         "count": res.totleNum, //解析数据长度
				//     };
				// },
				/*request: {
                    limitName: 'pageSize' //每页数据量的参数名，默认：limit
                },*/
				done: function (res) {
					//增加拖拽后回调函数
					soulTable.render(this, function () {
						TableUIObj.dragTable('tableDemo')
					})

					if (TableUIObj.onePageRecoeds != this.limit) {
						TableUIObj.update({onePageRecoeds: this.limit})
					}
				},
				initSort: {
					field: TableUIObj.orderbyFields,
					type: TableUIObj.orderbyUpdown
				}
			});
		}

		// 新建/编辑
		function newOrEdit(type, manegePlanningId) {
			var title = '';
			var url = '';
			var projectId = $('#leftId').attr('projId');
			var data = null
			var _url = ''
			var _obj = {}
			_obj.projectId = projectId
			if (type == '0') {
				title = '新建';
				url = '/workPlanning/insert';

				_url = '/planningManage/autoNumber'
				_obj.autoNumberType = 'workPlanning'
			} else if (type == '1') {

				title = '编辑';
				url = '/workPlanning/updateById';

				//回显
				_url = '/workPlanning/getById'
				_obj.kayId = manegePlanningId
			}else if(type == '4'){
				title = '查看详情'

				_url = '/workPlanning/getById'
				_obj.kayId = manegePlanningId
			}
			layer.open({
				type: 1,
				title: title,
				area: ['100%', '100%'],
				btn: type != '4'?['保存','提交审批', '取消']:['确定'],
				btnAlign: 'c',
				content: ['<div class="layui-collapse _disabled">\n' +
				/* region 策划内容 */
				'  <div class="layui-colla-item">\n' +
				'    <h2 class="layui-colla-title">策划内容</h2>\n' +
				'    <div class="layui-colla-content layui-show plan_base_info">' +
				'       <form class="layui-form" id="baseForm" lay-filter="baseForm">' +
				/* region 第一行 */
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">单据号<span field="documentNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="documentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">策划名称<span field="workPlanningName" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="workPlanningName" id="workPlanningName" placeholder="请选择" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">备注<!--<span field="memo" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="memo"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>' ,
					/* region 第二行 */
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">附件<span field="attachmentId" class="field_required">*</span></label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload" data-url="/upload?module=workPlanning" name="file">' +
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
					'       </form>' +
					'    </div>\n' +
					'  </div>\n' +
					/* endregion */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">项目目标</h2>\n' +
					'    <div class="layui-colla-content layui-show project_objectives">' +
					'		<table id="objectivesTable" lay-filter="objectivesTable"></table>' +
					'       <div class="layui-row">' +
					'       <div class="layui-col-xs12" style=" padding: 0 5px">' +
					'       <div class="layui-form-item">' +
					'       <label class="layui-form-label form_label">策划描述</label>' +
					'       <div class="layui-input-block form_block">' +
					'       <textarea type="text" name="workPlanningDesc" id="workPlanningDesc" style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>' +
					'       </div>' +
					'       </div>' +
					'       </div>',
					'       </div>',
					'    </div>\n' +
					'  </div>\n' +
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">策划明细</h2>\n' +
					'    <div class="layui-colla-content layui-show planning_details">' +
					'    	<div class="layui-tab layui-tab-brief">\n' +
					'    	  <ul class="layui-tab-title">\n' +
					'    	    <li class="layui-this">进度策划</li>\n' +
					'    	    <li>质量策划</li>\n' +
					'    	    <li>安全策划</li>\n' +
					'    	    <li>成本策划</li>\n' +
					'    	    <li>技术策划</li>\n' +
					'    	    <li>优化计划</li>\n' +
					// '    	    <li>经营计划</li>\n' +
					'    	  </ul>\n' +
					'    	  <div class="layui-tab-content">\n' +
					'    	    <div class="layui-tab-item layui-show schedule_planning">' +
					'				<table id="scheduleTable" lay-filter="scheduleTable"></table>' +
					'			</div>\n' +
					'    	    <div class="layui-tab-item quality_planning">' +
					'				<table id="qualityTable" lay-filter="qualityTable"></table>' +
					'			</div>\n' +
					'    	    <div class="layui-tab-item security_planning">' +
					'				<table id="securityTable" lay-filter="securityTable"></table>' +
					'			</div>\n' +
					'    	    <div class="layui-tab-item cost_planning">' +
					'				<table id="costTable" lay-filter="costTable"></table>' +
					'			</div>\n' +
					'    	    <div class="layui-tab-item skill_planning">' +
					'				<table id="skillTable" lay-filter="skillTable"></table>' +
					'			</div>\n' +
					'    	    <div class="layui-tab-item optimization_scheme">' +
					'				<table id="optimizationTable" lay-filter="optimizationTable"></table>' +
					'			</div>\n' +
					// '    	    <div class="layui-tab-item secondary_operation">' +
					// '				<table id="secondaryTable" lay-filter="secondaryTable"></table>' +
					// '			</div>\n' +
					'    	  </div>\n' +
					'    	</div>' +
					'    </div>\n' +
					'  </div>\n' +
					/* endregion */
					'</div>'].join(''),
				success: function () {
					var objectivesTableData = []

					fileuploadFn('#fileupload', $('#fileContent'));
					//回显项目名称
					getProjName('#projectName',projectId)

					var loadIndex = layer.load();
					$.ajax({
						url: _url,
						data: _obj,
						dataType: 'json',
						type: 'post',
						// async:false ,
						success: function (res) {
							if (res.flag) {
								if (type == 1 || type == 4) {
									data = res.obj

									form.val("baseForm", data);
									//附件
									if (data.attachmentList && data.attachmentList.length > 0) {
										var fileArr = data.attachmentList;
										$('#fileContent').append(echoAttachment(fileArr));
									}

									//查看详情
									if(type==4){
										$('.refresh_no_btn').hide();
										$('.file_upload_box').hide()
										$('.deImgs').hide();
									}

									$('#workPlanningDesc').val(data&&data.workPlanningDesc||'')

									objectivesTableData = data&&data.plbProjTargetWithBLOBList||[]

								}else{
									// 获取自动编号
									$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
									objectivesTableData = res.data||[]
								}

								//项目目标
								var cols = [
									{type: 'numbers', title: '序号'},
									{field: 'targetNature', title: '目标性质', minWidth: 150},
									{field: 'targetContent', title: '主要内容', minWidth: 160},
									{field: 'targetExplain', title: '目标说明', minWidth: 160}
								]

								table.render({
									elem: '#objectivesTable',
									data: objectivesTableData,
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols]
								});

								//策划明细子表
								//进度策划
								var cols2 = [
									{type: 'checkbox'},
									{
										field: 'scheduleName', title: '任务名称', minWidth: 150, templet: function (d) {
											return '<span class="scheduleName" workPlanningId="' + (d.workPlanningId || '') + '" planningShceduleId="'+(d.planningShceduleId || '')+'" scheduleId="'+(d.scheduleId || '')+'">' + (d.scheduleName || '') + '</span>'
										}
									},
									{field: 'scheduleBeginDate', title: '计划开始时间', minWidth: 160},
									{field: 'scheduleEndDate', title: '计划完成时间', minWidth: 160},
									{field: 'scheduleUserName', title: '责任人', minWidth: 160, templet: function (d) {
											return '<span class="scheduleUserName" scheduleUser="'+(d.scheduleUser || '')+'">' + (d.scheduleUserName || '') + '</span>'
										}},
									{field: 'supervisorUserName', title: '监督人', minWidth: 160, templet: function (d) {
											return '<span class="supervisorUserName"  supervisorUser="'+(d.supervisorUser || '')+'">' + (d.supervisorUserName || '') + '</span>'
										}},
									{field: 'memo', title: '说明', minWidth: 160, templet: function (d) {
											return '<span class="memo tips">' + (d.memo || '') + '</span>'
										}}
								]
								//质量策划
								var cols3 = [
									{type: 'numbers', title: '序号'},
									{field: 'securityKnowledgeName', title: '检查项名称', minWidth: 160, templet: function (d) {
											return '<span class="tips">' + (d.securityKnowledgeName || '') + '</span>'
										}},
									// {field: 'mainDifficulties', title: '主要难点', minWidth: 160},
									// {field: 'mainRisk', title: '主要风险', minWidth: 160},
									// {field: 'riskSolutions', title: '风险解决措施', minWidth: 160},
									{field: 'personLiableName', title: '责任人', minWidth: 160},
									{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
											return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
										}},
									{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
											return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
										}},
									{field: 'solutions', title: '检查项描述', minWidth: 160, templet: function (d) {
											return '<span class="tips">' + (d.solutions || '') + '</span>'
										}},
									{field: 'securityKnowledgeName', title: '检查详细内容',minWidth: 150, templet: function (d) {
											return '<span workPlanningId="' + (d.workPlanningId || '') + '" securityPlanId="'+(d.securityPlanId || '')+'"   securityTermId="'+(d.securityTermId || '')+'" personLiable="'+(d.personLiable || '')+'" class="securityKnowledgeName chooseMaterials"  style="cursor: pointer;color: blue;">' + (d.securityKnowledgeName || '') + '</span>'
										}}
								]
								//安全策划
								var cols4 = [
									{type: 'numbers', title: '序号'},
									{field: 'securityKnowledgeName', title: '检查项名称', minWidth: 160, templet: function (d) {
											return '<span class="tips">' + (d.securityKnowledgeName || '') + '</span>'
										}},
									// {field: 'mainDifficulties', title: '主要难点', minWidth: 160},
									// {field: 'mainRisk', title: '主要风险', minWidth: 160},
									// {field: 'riskSolutions', title: '风险解决措施', minWidth: 160},
									{field: 'personLiableName', title: '责任人', minWidth: 160},
									{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
											return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
										}},
									{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
											return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
										}},
									{field: 'solutions', title: '检查项描述', minWidth: 160, templet: function (d) {
											return '<span class="tips">' + (d.solutions || '') + '</span>'
										}},
									{field: 'securityKnowledgeName', title: '检查详细内容',minWidth: 150, templet: function (d) {
											return '<span workPlanningId="' + (d.workPlanningId || '') + '" securityPlanId="'+(d.securityPlanId || '')+'"   securityTermId="'+(d.securityTermId || '')+'" personLiable="'+(d.personLiable || '')+'" class="securityKnowledgeName chooseMaterials2"  style="cursor: pointer;color: blue;">' + (d.securityKnowledgeName || '') + '</span>'
										}}
								]
								//成本策划
								var cols5 = [
									{type: 'numbers', title: '序号'},
									{
										field: 'wbsName', title: 'WBS',width:200, templet: function(d) {
											var str = ''
											if (d.plbProjWbs) {
												str = d.plbProjWbs.wbsName;
											}
											return '<span class="wbsName" workPlanningId="' + (d.workPlanningId || '') + '" planningBudgetId="'+(d.planningBudgetId || '')+'" projBudgetId="'+(d.projBudgetId || '')+'">'+(str||d.wbsName||'')+'</span>';
										}
									},
									{
										field: 'rbsLongName', title: 'RBS',width:200, templet: function (d) {
											var str = '';
											if (d.plbRbs) {
												str = d.plbRbs.rbsLongName;
											}
											return '<span class="rbsLongName">'+(str||d.rbsLongName||'')+'</span>';
										}
									},
									{
										field: 'cbsName', title: 'CBS',width:200, templet: function (d) {
											var str = '';
											if (d.plbCbsTypeWithBLOBs) {
												str = d.plbCbsTypeWithBLOBs.cbsName;
											}
											return '<span class="cbsName">'+(str||d.cbsName||'')+'</span>';
										}
									},
									{
										field: 'controlType', title: '控制类型', width:100,templet: function (d) {
											return '<span class="controlType" controlType="'+(d.controlType||'')+'">'+(dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '')+'</span>';
										}
									},
									{
										field: 'itemUnit', title: '单位',width:100,templet: function (d) {
											var str = '';
											// if (d.plbCbsTypeWithBLOBs) {
												str = dictionaryObj['CBS_UNIT']['object'][d.itemUnit] || '';
											// }
											return '<span class="itemUnit" itemUnit="'+(d.itemUnit||'')+'">'+str+'</span>';
										}
									},
                                    {field: 'incomeTarNum', title: '收入目标数量',width:120},
                                    {field: 'incomeTarPrice', title: '收入目标单价',width:120},
                                    {field: 'incomeTarAmount', title: '收入目标总价',width:120},
                                    {field: 'optTarNum', title: '优化目标数量',width:120},
                                    {field: 'optTarPrice', title: '优化目标单价',width:120},
                                    {field: 'optTarAmount', title: '优化目标总价',width:120},
									{field: 'manageTarNum', title: '管理目标数量',width:120},
									{field: 'manageTarPrice', title: '管理目标单价',width:120},
									{field: 'manageTarAmount', title: '管理目标总价',width:120},
									{field: 'optTarExplain', title: '优化说明',width:120, templet: function (d) {
										return '<span class="tips">' + (d.optTarExplain || '') + '</span>'
									}}
								]
								//技术策划
								var cols6 = [
									{type: 'numbers', title: '序号'},
									{field: 'technologyName', title: '方案名称', minWidth: 150},
									{field: 'technologyDesc', title: '方案描述', minWidth: 160, templet: function (d) {
											return '<span class="tips">' + (d.technologyDesc || '') + '</span>'
										}},
									{
										field: 'importanceLevel', title: '重要级别', minWidth: 160, templet: function (d) {
											if (d.importanceLevel) {
												return '<span importanceLevel="'+(d.importanceLevel||'')+'">' + ((dictionaryObj && dictionaryObj['IMPORTANCE_LEVEL'] && dictionaryObj['IMPORTANCE_LEVEL']['object'][d.importanceLevel]) || '') + '</span>'
											} else {
												return ''
											}
										}
									},
									{
										field: 'projectUserName', title: '项目责任人', minWidth: 160, templet: function (d) {
											return '<span user_id="'+(d.projectUser||'')+'" >' + (d.projectUserName || '') + '</span>'
										}
									},
									{
										field: 'companyUserName', title: '公司责任人', minWidth: 160, templet: function (d) {
											return '<span user_id="'+(d.companyUser||'')+'" >' + (d.companyUserName || '') + '</span>'
										}
									},
									{field: 'planEndDate', title: '计划完成时间', minWidth: 160},
									{field: 'achieveRequire', title: '成果物要求', minWidth: 160, templet: function (d) {
											return '<span class="tips">' + (d.achieveRequire || '') + '</span>'
										}},
									{
										field: 'businessName', title: '技术路线', minWidth: 160, event: 'roadmap',templet: function (d) {
											return '<input type="text" name="businessName" workPlanningId="' + (d.workPlanningId || '') + '" planningTechnologyId="'+(d.planningTechnologyId || '')+'" technologyPlanId="'+(d.technologyPlanId || '')+'" planingTechnologyId="' + (d.planingTechnologyId || '') + '"  readonly class="layui-input" style="height: 100%;" value="' + (d.businessName || '') + '">'
										}
									}
								]
								//优化计划
								var cols7 = [
									{type: 'numbers', title: '序号'},
									{
										field: 'optimizationName', title: '优化名称', minWidth: 150, templet: function (d) {
											return '<span class="optimizationName" workPlanningId="' + (d.workPlanningId || '') + '" planningOptimizaId="'+(d.planningOptimizaId || '')+'" optimizationId="'+(d.optimizationId || '')+'">'+(d.optimizationName || '')+'</span>'
										}
									},
									{field: 'schemeDesc', title: '优化描述', minWidth: 160, templet: function (d) {
											return '<span class="tips">' + (d.schemeDesc || '') + '</span>'
										}},
									{field:'schemeCategory',title:'优化类别',minWidth: 120,sort:true,hide:false,templet: function (d) {
										if(d.schemeCategory) {
											return '<span schemeCategory="'+(d.schemeCategory||'')+'">'+((dictionaryObj&&dictionaryObj['OPTIMIZATION_CATEGORY']&&dictionaryObj['OPTIMIZATION_CATEGORY']['object'][d.schemeCategory])||'')+'</span>'
										}else {
											return ''
										}
									}},
									{field:'schemeType',title:'优化类型',minWidth: 120,sort:true,hide:false,templet: function (d) {
										if(d.schemeType) {
											return '<span schemeType="'+(d.schemeType||'')+'">'+((dictionaryObj&&dictionaryObj['OPTIMIZATION_TYPE']&&dictionaryObj['OPTIMIZATION_TYPE']['object'][d.schemeType])||'')+'</span>'
										}else {
											return ''
										}
									}},
									// {field: 'mainSchemeContent', title: '主要内容', minWidth: 160},

									{field: 'chargeUserName', title: '责任人', minWidth: 160},
									{field: 'superviseUserName', title: '监督人', minWidth: 160},
									/*{
										field: 'attachmentName',
										title: '附件',
										align: 'center',
										minWidth: 200,
										templet: function (d) {
											var fileArr = d.attachmentList;
											return '<div id="file_All'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
													'</div>'

										}
									}*/
								]
								//经营计划
								var cols8 = [
									{type: 'numbers', title: '序号'},
									{
										field: 'businessName', title: '二次经营名称', minWidth: 150, templet: function (d) {
											return '<span class="businessName" workPlanningId="' + (d.workPlanningId || '') + '" planningOptimizaId="'+(d.planningOptimizaId || '')+'" businessId="'+(d.businessId || '')+'">'+(d.businessName || '')+'</span>'
										}
									},
									{field: 'schemeDesc', title: '经营描述', minWidth: 160, templet: function (d) {
											return '<span class="tips">' + (d.schemeDesc || '') + '</span>'
										}},
									{field:'schemeCategory',title:'经营类别',minWidth: 120,sort:true,hide:false,templet: function (d) {
										if(d.schemeCategory) {
											return '<span schemeCategory="'+(d.schemeCategory||'')+'">'+((dictionaryObj&&dictionaryObj['BUSINESS_CATEGORY']&&dictionaryObj['BUSINESS_CATEGORY']['object'][d.schemeCategory])||'')+'</span>'
										}else {
											return ''
										}
									}},
									{field:'schemeType',title:'经营类型',minWidth: 120,sort:true,hide:false,templet: function (d) {
										if(d.schemeType) {
											return '<span schemeType="'+(d.schemeType||'')+'">'+((dictionaryObj&&dictionaryObj['BUSINESS_TYPE']&&dictionaryObj['BUSINESS_TYPE']['object'][d.schemeType])||'')+'</span>'
										}else {
											return ''
										}
									}},
									// {field: 'mainSchemeContent', title: '主要内容', minWidth: 160},

									{field: 'chargeUserName', title: '责任人', minWidth: 160},
									{field: 'superviseUserName', title: '监督人', minWidth: 160},
									/*{
										field: 'attachmentName',
										title: '附件',
										align: 'center',
										minWidth: 200,
										templet: function (d) {
											var fileArr = d.attachmentList;
											return '<div id="file_All2'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
													'</div>'

										}
									}*/
								]
								//查看详情
								if(type!=4){
									cols2.push({align: 'center', toolbar: '#toolBar', title: '操作', minWidth: 200})
									cols3.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
									cols4.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
									cols5.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
									cols6.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
									cols7.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
									cols8.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
								}
								table_Ins = treeTable.render({
									elem: '#scheduleTable',
									// data: data&&data.scheduleList||[],
									url: '/companySchedule/select',
									where:{projectId:projectId,delFlag:'0',dataForm : "2"},
									// toolbar: type==4?false:'#toolbarHead',
									// defaultToolbar: [''],
									limit: 1000,
									height: 'full-350',
									cols: [cols2],
									tree: {
										iconIndex: 1,
										idName: 'scheduleId',
										childName: "child"
									},
									done:function(res){
										scheduleTableData = res.data
									}
								});

								table.render({
									elem: '#qualityTable',
									data: data&&data.qualityList||[],
									height: data&&data.qualityList&&data.qualityList.length>5?'full-350':false,
									toolbar: type==4?false:'#toolbarPlan2',
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols3]
								});
								table.render({
									elem: '#securityTable',
									data: data&&data.securityList||[],
									height: data&&data.securityList&&data.securityList.length>5?'full-350':false,
									toolbar: type==4?false:'#toolbarPlan2',
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols4],
								});

								table.render({
									elem: '#costTable',
									data: data&&data.budgetList||[],
									height: data&&data.budgetList&&data.budgetList.length>5?'full-350':false,
									toolbar: type==4?false:'#toolbarPlan2',
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols5],
									done:function(res){
										costTableData = res.data
									}
								});
								table.render({
									elem: '#skillTable',
									data: data&&data.technologyList||[],
									height: data&&data.technologyList&&data.technologyList.length>5?'full-350':false,
									toolbar: type==4?false:'#toolbarPlan2',
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols6],
								});
								table.render({
									elem: '#optimizationTable',
									data: data&&data.optimizationList||[],
									height: data&&data.optimizationList&&data.optimizationList.length>5?'full-350':false,
									toolbar: type==4?false:'#toolbarPlan2',
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols7],
									done:function(res) {
										$('.optimization_scheme .deImgs').hide()
									}
								});

								table.render({
									elem: '#secondaryTable',
									data: data&&data.businessList||[],
									height: data&&data.businessList&&data.businessList.length>5?'full-350':false,
									toolbar: type==4?false:'#toolbarPlan2',
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols8],
									done:function(res) {
										$('.secondary_operation .deImgs').hide()
									}
								});
							}
							//查看详情
							if(type==4){
								$('._disabled [name]').attr('disabled', 'disabled');
								$('._disabled [name]').attr('readonly', true);
								form.render();
							}
							layer.close(loadIndex);
						}
					});



					element.render();
					form.render();
				},
				yes: function (index) {
					if(type!='4'){
						var datas = $('#baseForm').serializeArray();
						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value
						});

						if($('#workPlanningName').attr('securityDangerId')){
							obj.securityDangerId = $('#workPlanningName').attr('securityDangerId')
						}
						obj.workPlanningDesc = $('#workPlanningDesc').val()

						obj.projectId = $('#leftId').attr('projId');


						if(type == '1'){
							obj.workPlanningId= data.workPlanningId;
						}

						// 附件
						var attachmentId = '';
						var attachmentName = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
						}
						obj.attachmentId = attachmentId;
						obj.attachmentName = attachmentName;

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

						// obj.scheduleList = planningDetailsData().scheduleData;
						obj.qualityList = planningDetailsData().qualityData;
						obj.securityList = planningDetailsData().securityData;
						obj.budgetList = planningDetailsData().costData;
						obj.technologyList = planningDetailsData().skillData;
						obj.optimizationList = planningDetailsData().optimizationData;
						// obj.businessList = planningDetailsData().secondaryData;

						var loadIndex = layer.load();

						$.ajax({
							url: url,
							data: JSON.stringify(obj),
							dataType: 'json',
							contentType: "application/json;charset=UTF-8",
							type: 'post',
							success: function (res) {
								layer.close(loadIndex);
								if (res.code=='0') {
									layer.msg('保存成功！', {icon: 1});
									layer.close(index);
									tableIns.config.where._ = new Date().getTime();
									tableIns.reload();
								} else {
									layer.msg(res.msg, {icon: 7});
								}
							}
						});
					}else {
						layer.close(index);
					}

				},btn2:function(){
					if(data!=undefined&&data.auditerStatus != undefined&&data.auditerStatus != '0'){
						layer.msg('该数据已提交！', {icon: 0, time: 2000});
						return false;
					}


					var datas = $('#baseForm').serializeArray();
					var obj = {}
					datas.forEach(function (item) {
						obj[item.name] = item.value
					});

					if($('#workPlanningName').attr('securityDangerId')){
						obj.securityDangerId = $('#workPlanningName').attr('securityDangerId')
					}
					obj.workPlanningDesc = $('#workPlanningDesc').val()

					obj.projectId = $('#leftId').attr('projId');


					if(type == '1'){
						obj.workPlanningId= data.workPlanningId;
					}

					// 附件
					var attachmentId = '';
					var attachmentName = '';
					for (var i = 0; i < $('#fileContent .dech').length; i++) {
						attachmentId += $('#fileContent .dech').eq(i).find('input').val();
						attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
					}
					obj.attachmentId = attachmentId;
					obj.attachmentName = attachmentName;

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

					// obj.scheduleList = planningDetailsData().scheduleData;
					obj.qualityList = planningDetailsData().qualityData;
					obj.securityList = planningDetailsData().securityData;
					obj.budgetList = planningDetailsData().costData;
					obj.technologyList = planningDetailsData().skillData;
					obj.optimizationList = planningDetailsData().optimizationData;
					// obj.businessList = planningDetailsData().secondaryData;

					var loadIndex = layer.load();

					$.ajax({
						url: url,
						data: JSON.stringify(obj),
						dataType: 'json',
						contentType: "application/json;charset=UTF-8",
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
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '39'}, function (res) {
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
											var approvalData = res.obj;
											/*delete approvalData.detailList
                                            delete approvalData.manageInfoList*/
											approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
											approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
											newWorkFlow(flowData.flowId, function (res) {
												var submitData = {
													workPlanningId:approvalData.workPlanningId,
													runId: res.flowRun.runId,
													//manageProjStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/workPlanning/updateById',
													data: JSON.stringify(submitData),
										dataType: 'json',
										contentType: "application/json;charset=UTF-8",
													type: 'post',
													success: function (res) {
														layer.close(loadIndex);
														if (res.code===0||res.code==="0") {
															layer.close(index);
															layer.msg('提交成功!', {icon: 1});
															tableIns.config.where._ = new Date().getTime();
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

		//选择策划名称
		$(document).on('click', '#workPlanningName', function () {
			layer.open({
				type: 2,
				title: '选择策划名称',
				area: ['90%', '90%'],
				btn: ['确定','取消'],
				btnAlign: 'c',
				content: '/workPlanningKnow/workPlanningKnowIndex?type=radio',
				success: function () {

				},
				yes: function (index,layero) {
					var datas  = $(layero).find("iframe")[0].contentWindow.getRepairDate1();
					if(!datas.securityDangerId){
						layer.msg('请选择一项！', {icon: 0});
						return false
					}
					$('#workPlanningName').val(datas.workPlanningName).attr('securityDangerId',datas.securityDangerId)
					layer.close(index);
				}
			});
		})

		// 进度策划-选择
		treeTable.on('toolbar(scheduleTable)', function (obj) {
			var checkStatus = table_Ins.checkStatus();
			switch (obj.event) {
				case 'del':
					if (!checkStatus.length) {
						layer.msg('请至少选择一项！', {icon: 0});
						return false
					}
					// if (checkStatus[0].auditerStatus!=0) {
					// 	layer.msg('已提交不可删除！', {icon: 0});
					// 	return false
					// }
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

							table_Ins.reload()
						})
					});
					break;
			}
		});
		// 进度策划-行内
		treeTable.on('tool(scheduleTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'detail') {
				newSchedule(4,data)
			}
		})

		// 质量策划-选择
		table.on('toolbar(qualityTable)', function (obj) {
			switch (obj.event) {
				case 'choice':
					layer.open({
						type: 1,
						title: '选择质量检查项',
						area: ['80%', '80%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: ['<div class="layui-form" style="padding:0px 10px">' +
						'<div class="query_module layui-form layui-row" style="padding:10px">\n' +
						'                <div class="layui-col-xs2">\n' +
						'                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +
						/*'                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
						'                    <input type="text" name="securityPlanName" id="" placeholder="检查计划名称" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +*/
						'                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
						'                    <button type="button" class="layui-btn layui-btn-sm InSearch_Data">查询</button>\n' +
						'                </div>\n' +
						'</div>' +
						'<div>' +
						'     <table id="table_DemoIn" lay-filter="table_DemoIn"></table>\n' +
						'     <div id="down_Box">\n' +
						'         <table id="table_DemoInDown" lay-filter="table_DemoInDown"></table>\n' +
						'      </div>' +
						'</div>' +
						'</div>'].join(''),
						success: function () {
							var table_DemoIn=table.render({
								elem: '#table_DemoIn',
								url: '/qualityTerm/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
								cols: [[
									{checkbox: true},
									{field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
									// {field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
									{field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120,sort: true, hide: false},
									{field: 'personLiableName', title: '检查人', minWidth: 120,sort: true, hide: false},
									{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
											return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
										}},
									{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
											return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
										}},
									{field: 'solutions', title: '检查项描述', minWidth: 160}
								]],
								// height: 'full-430',
								page: true,
								done:function(res){
									var oldDataArr = planningDetailsData().qualityData;
									var _dataa=res.data;
									if(oldDataArr!=undefined&&oldDataArr.length>0){
										for(var i = 0 ; i <_dataa.length;i++){
											for(var n = 0 ; n < oldDataArr.length; n++){
												if(_dataa[i].securityTermId == oldDataArr[n].securityTermId){
													$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
													//form.render('checkbox');
												}
											}
										}
									}

								}
							});
							$('.InSearch_Data').click(function(){
								var documentNo=$('[name="documentNo"]').val();
								// var securityPlanName=$('[name="securityPlanName"]').val();
								table_DemoIn.reload({
									where:{
										documentNo:documentNo,
										// securityPlanName:securityPlanName
									}
								})
							})
						},
						yes: function (index) {

							var checkStatus = table.checkStatus('table_DemoIn'); //获取选中行状态
							var datas = checkStatus.data;  //获取选中行数据

							//判断是否选择数据
							if (datas.length == 0) {
								layer.msg('请选择一项！', {icon: 0});
								return false
							}

							//遍历表格获取每行数据进行保存
							var dataArr = planningDetailsData().qualityData;

							datas.forEach(function (item) {
								if(dataArr){
									var _flag = true
									for(var j=0;j<dataArr.length;j++){
										if(dataArr[j].securityTermId==item.securityTermId){
											_flag = false
										}
									}
									if(_flag){
										dataArr.push(item)
									}
								}else{
									dataArr.push(item)
								}
							})
							table.reload('qualityTable', {
								data: dataArr,
								height: dataArr&&dataArr.length>5?'full-350':false
							});
							layer.close(index)
						},
					})
					break;
			}
		});
		//监听行单击事件
		table.on('row(table_DemoIn)', function (obj) {
			// console.log(obj.data) //得到当前行数据
			var data = obj.data
			$('#down_Box').show()
			// obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')

			var loadIndex = layer.load();
			$.post('/qualityTerm/getById', {kayId: data.securityTermId}, function (res) {
				tableShow_Down(res.obj&&res.obj.detailList)
				layer.close(loadIndex);
			})
		});

		//质量检查计划明细表
		function tableShow_Down(data) {
			table.render({
				elem: '#table_DemoInDown',
				data: data||[],
				cellMinWidth:150,
				cols: [[
					{type: 'numbers', title: '序号'},
					{field: 'securityDanger', minWidth:150,title: '质量控制要点'},
					{field: 'securityDangerMeasures', minWidth:150,title: '特征描述'},
					{
						field: 'attachmentName',
						title: '特征图片',
						align: 'center',
						minWidth: 200,
						templet: function (d) {
							var fileArr = d.attachmentList;
							return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
									'</div>'

						}
					},
					{field: 'securityDangerGrade',minWidth:100, title: '重大问题',templet:function(d){
							if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
								if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
									return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">重大隐患</span>';
								}else{
									return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">一般隐患</span>';
								}
							}else{
								return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index ||  d.LAY_INDEX || '')+'"></span>';
							}
						}
					}
				]],
				// height: 'full-430',
				page: true,
				done:function(res){

				}
			});
		}

		//质量 检查详细内容
		$(document).on('click', '.chooseMaterials', function () {
			var loadIndex = layer.load();
				$.post('/qualityTerm/getById', {kayId: $(this).attr('securityTermId')}, function (res) {
				new_Edit(res.obj)
				layer.close(loadIndex);
			})
		})

		// 质量策划-删行
		table.on('tool(qualityTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.securityPlanId) {
					$.get('/workPlanning/del', {ids: data.securityPlanId, type: "quality"}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('qualityTable', {
								data: planningDetailsData().qualityData,
								height: planningDetailsData().qualityData && planningDetailsData().qualityData.length > 5 ? 'full-350' : false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('qualityTable', {
						data: planningDetailsData().qualityData,
						height: planningDetailsData().qualityData && planningDetailsData().qualityData.length > 5 ? 'full-350' : false
					});
				}
			}
		})

		// 安全策划-选择
		table.on('toolbar(securityTable)', function (obj) {
			switch (obj.event) {
				case 'choice':
					layer.open({
						type: 1,
						title: '选择安全检查项',
						area: ['80%', '80%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: ['<div class="layui-form" style="padding:0px 10px">' +
						'<div class="query_module layui-form layui-row" style="padding:10px">\n' +
						'                <div class="layui-col-xs2">\n' +
						'                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +
						// '                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
						// '                    <input type="text" name="securityPlanName" id="" placeholder="检查计划名称" autocomplete="off" class="layui-input">\n' +
						// '                </div>\n' +
						'                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
						'                    <button type="button" class="layui-btn layui-btn-sm InSearchData">查询</button>\n' +
						'                </div>\n' +
						'</div>' +
						'<div>' +
						'     <table id="tableDemoIn" lay-filter="tableDemoIn"></table>\n' +
						'     <div id="downBox">\n' +
						'         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
						'      </div>' +
						'</div>' +
						'</div>'].join(''),
						success: function () {
							var tableDemoIn=table.render({
								elem: '#tableDemoIn',
								url: '/securityTerm/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
								cols: [[
									{checkbox: true},
									{field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
									// {field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
									{field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120,sort: true, hide: false},
									{field: 'personLiableName', title: '检查人', minWidth: 120,sort: true, hide: false},
									{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
											return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
										}},
									{field: 'importance', title: '重要性', minWidth: 100, templet: function (d) {
											return '<span class="importance" importance="'+(d.importance || '') +'" >' + (d.importance&&dictionaryObj["SCHEDULE_INPORTANCE"]?dictionaryObj["SCHEDULE_INPORTANCE"].object[d.importance] : '') + '</span>'
										}},
									{field: 'solutions', title: '检查项描述', minWidth: 160}
								]],
								// height: 'full-430',
								page: true,
								done:function(res){
									var oldDataArr = planningDetailsData().securityData;
									var _dataa=res.data;
									if(oldDataArr!=undefined&&oldDataArr.length>0){
										for(var i = 0 ; i <_dataa.length;i++){
											for(var n = 0 ; n < oldDataArr.length; n++){
												if(_dataa[i].securityTermId == oldDataArr[n].securityTermId){
													$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
													//form.render('checkbox');
												}
											}
										}
									}

								}
							});
							$('.InSearchData').click(function(){
								var documentNo=$('[name="documentNo"]').val();
								// var securityPlanName=$('[name="securityPlanName"]').val();
								tableDemoIn.reload({
									where:{
										documentNo:documentNo,
										// securityPlanName:securityPlanName
									}
								})
							})
						},
						yes: function (index) {

							var checkStatus = table.checkStatus('tableDemoIn'); //获取选中行状态
							var datas = checkStatus.data;  //获取选中行数据

							//判断是否选择数据
							if (datas.length == 0) {
								layer.msg('请选择一项！', {icon: 0});
								return false
							}

							//遍历表格获取每行数据进行保存
							var dataArr = planningDetailsData().securityData;

							datas.forEach(function (item) {
								if(dataArr){
									var _flag = true
									for(var j=0;j<dataArr.length;j++){
										if(dataArr[j].securityTermId==item.securityTermId){
											_flag = false
										}
									}
									if(_flag){
										dataArr.push(item)
									}
								}else{
									dataArr.push(item)
								}
							})
							table.reload('securityTable', {
								data: dataArr,
								height: dataArr&&dataArr.length>5?'full-350':false
							});
							layer.close(index)
						},
					})
					break;
			}
		});

		//监听行单击事件
		table.on('row(tableDemoIn)', function (obj) {
			// console.log(obj.data) //得到当前行数据
			var data = obj.data
			$('#downBox').show()
			// obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
			var loadIndex = layer.load();
			$.post('/securityTerm/getById', {kayId: data.securityTermId}, function (res) {
				tableShowDown(res.obj&&res.obj.detailList)
				layer.close(loadIndex);
			})
		});

		//安全检查计划明细表
		function tableShowDown(data) {
			table.render({
				elem: '#tableDemoInDown',
				data: data,
				cellMinWidth:150,
				cols: [[
					{type: 'numbers', title: '序号'},
					{field: 'securityDanger', minWidth:150,title: '检查内容'},
					{field: 'securityDangerMeasures', minWidth:150,title: '整改措施'},
					{field: 'securityDangerGrade',minWidth:100, title: '隐患级别',templet:function(d){
							if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
								if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
									return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">重大隐患</span>';
								}else{
									return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">一般隐患</span>';
								}
							}else{
								return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index ||  d.LAY_INDEX || '')+'"></span>';
							}
						}
					}
				]],
				// height: 'full-430',
				page: true,
				done:function(res){

				}
			});
		}

		//安全 检查详细内容
		$(document).on('click', '.chooseMaterials2', function () {
			var loadIndex = layer.load();
			$.post('/securityTerm/getById', {kayId: $(this).attr('securityTermId')}, function (res) {
				new_Edit2(res.obj)
				layer.close(loadIndex);
			})
		})

		// 安全策划-删行
		table.on('tool(securityTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.securityPlanId) {
					$.get('/workPlanning/del', {ids: data.securityPlanId,type:"security"}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('securityTable', {
								data: planningDetailsData().securityData,
								height: planningDetailsData().securityData&&planningDetailsData().securityData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('securityTable', {
						data: planningDetailsData().securityData,
						height: planningDetailsData().securityData&&planningDetailsData().securityData.length>5?'full-350':false
					});
				}
			}
		})

		// 成本策划-选择
		table.on('toolbar(costTable)', function (obj) {
			switch (obj.event) {
				case 'choice':
					//新数据
					var wbsSelectTree = null;
					var cbsSelectTree = null;
					var rbsSelectTree =null;
					var _this = $(this);
					layer.open({
						type: 1,
						title: '管理目标选择',
						area: ['80%', '80%'],
						maxmin: true,
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: ['<div class="layui-form" id="objectives">' +
						//下拉选择
						'           <div class="layui-row" style="margin-top: 10px">' +
						// '               <div class="layui-col-xs2">' +
						// '                   <div class="layui-form-item">\n' +
						// '                       <label class="layui-form-label" style="width:85px">预算科目编号</label>\n' +
						// '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
						// '                          <input type="text" name="itemNo"  autocomplete="off" class="layui-input">'+
						// '                       </div>\n' +
						// '                   </div>' +
						// '               </div>' +
						// '               <div class="layui-col-xs2">' +
						// '                   <div class="layui-form-item">\n' +
						// '                       <label class="layui-form-label" style="width:85px">预算科目名称</label>\n' +
						// '                       <div class="layui-input-block" style="margin-left: 115px">\n' +
						// '                          <input type="text" name="itemName"  autocomplete="off" class="layui-input">'+
						// '                       </div>\n' +
						// '                   </div>' +
						// '               </div>' +
						'               <div class="layui-col-xs3">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label">WBS</label>\n' +
						'                       <div class="layui-input-block">\n' +
						'<div id="wbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'               <div class="layui-col-xs3">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label">RBS</label>\n' +
						'                       <div class="layui-input-block">\n' +
						'<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' ,
							'               <div class="layui-col-xs3">' +
							'                   <div class="layui-form-item">\n' +
							'                       <label class="layui-form-label">CBS</label>\n' +
							'                       <div class="layui-input-block">\n' +
							'<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
							'                       </div>\n' +
							'                   </div>' +
							'               </div>' +
							'               <div class="layui-col-xs2">' +
							'<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 0 0 10px;">搜索<i class="layui-icon layui-icon-search" style="margin: 0 0 0 3px;"></i></button>' +
							'               </div>' +
							'           </div>' +
							//表格数据
							'       <div style="padding: 10px">' +
							'           <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>' +
							'      </div>' +
							'</div>'].join(''),
						success: function () {
							// 获取WBS数据
							$.get('/plbProjWbs/getWbsTreeByProjId',{projId:$('#leftId').attr('projId')}, function (res) {
								wbsSelectTree = xmSelect.render({
									el: '#wbsSelectTree',
									content: '<div id="wbsTree" class="eleTree" lay-filter="wbsTree"></div>',
									name: 'wbsName',
									prop: {
										name: 'wbsName',
										value: 'id'
									}
								});

								eleTree.render({
									elem: '#wbsTree',
									data: res.obj,
									highlightCurrent: true,
									showLine: true,
									defaultExpandAll: false,
									request: {
										name: 'wbsName',
										children: "child"
									}
								});

								// 树节点点击事件
								eleTree.on("nodeClick(wbsTree)", function (d) {
									var currentData = d.data.currentData;
									var obj = {
										wbsName: currentData.wbsName,
										id: currentData.id
									}
									wbsSelectTree.setValue([obj]);
								});
							});

							// 获取CBS数据
							$.get('/plbCbsType/getAllList', function (res) {
								cbsSelectTree = xmSelect.render({
									el: '#cbsSelectTree',
									content: '<div id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
									name: 'cbsName',
									prop: {
										name: 'cbsName',
										value: 'cbsId'
									}
								});

								eleTree.render({
									elem: '#cbsTree',
									data: res.data,
									highlightCurrent: true,
									showLine: true,
									defaultExpandAll: false,
									request: {
										name: 'cbsName',
										children: "childList"
									}
								});

								// 树节点点击事件
								eleTree.on("nodeClick(cbsTree)", function (d) {
									var currentData = d.data.currentData;
									var obj = {
										cbsName: currentData.cbsName,
										cbsId: currentData.cbsId
									}
									cbsSelectTree.setValue([obj]);
								});
							});
							//获取RBS数据
							rbsSelectTree = xmSelect.render({
								el: '#rbsSelectTree',
								content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search rbsSearch" style="width: 80%;margin: 5px"><div id="rbsTree" class="eleTree" lay-filter="rbsTree"></div>',
								name: 'rbsName',
								prop: {
									name: 'rbsName',
									value: 'rbsId'
								}
							});
							rbsData();
							// 树节点点击事件
							eleTree.on("nodeClick(rbsTree)", function (d) {
								var currentData = d.data.currentData;
								var obj = {
									rbsName: currentData.rbsName,
									rbsId: currentData.rbsId
								}
								rbsSelectTree.setValue([obj]);
							});
							var searchTimerRBS = null
							$('.rbsSearch').on('input propertychange', function () {
								clearTimeout(searchTimerRBS)
								searchTimerRBS = null
								var val = $(this).val()
								searchTimerRBS = setTimeout(function () {
									rbsData(val,'1')
								}, 300)
							});
							function rbsData(parentId,type){
								var obj = {};
								// obj.rbsTyep = 'subcontract'
								if(type == '1'){
									obj.rbsName=parentId?parentId:'';
								}else {
									obj.parentId=parentId?parentId:'0';
								}
								// 获取RBS数据
								$.get('/manageProject/getProjRbsByProjId',obj, function (res) {
									var rbsTreeData = res.data || [];

									eleTree.render({
										elem: '#rbsTree',
										data: rbsTreeData,
										highlightCurrent: true,
										showLine: true,
										defaultExpandAll: false,
										accordion: true,
										lazy: true,
										request: {
											name: 'rbsName',
											children: "childList"
										},
										load: function (data, callback) {
											$.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
												callback(res.data);//点击节点回调
											})
										}
									});

								});
							}
							laodTable();

							$('.search_mtl').on('click', function(){
								var cbsId = cbsSelectTree.getValue('valueStr');
								var wbsId = wbsSelectTree.getValue('valueStr');
								var rbsId = rbsSelectTree.getValue('valueStr');
								// var itemNo = $('[name="itemNo"]').val();
								// var itemName =$('[name="itemName"]').val();

								laodTable(wbsId,rbsId,cbsId);
							});

							// 加载表格
							function laodTable(wbsId,rbsId,cbsId) {
								table.render({
									elem: '#managementBudgetTable',
									url: '/manageProject/getBudgetByProjId',
									where: {
										projId: $('#leftId').attr('projId'),
										wbsId: wbsId || '',
										cbsId: cbsId || '',
										rbsId: rbsId || '',
										// itemNo: itemNo || '',
										// itemName: itemName || '',
										// rbsTyep:'subcontract'
									},
									page: true,
									limit: 20,
									request: {
										limitName: 'pageSize'
									},
									response: {
										statusName: 'flag',
										statusCode: true,
										msgName: 'msg',
										countName: 'count',
										dataName: 'data'
									},
									cols: [[
										{type: 'checkbox'},
										{
											field: 'wbsName', title: 'WBS',minWidth:100, templet: function(d) {
												var str = '';
												if (d.plbProjWbs) {
													str = d.plbProjWbs.wbsName;
												}
												return str;
											}
										},
										{
											field: 'rbsName', title: 'RBS',minWidth:200, templet: function(d) {
												var str = '';
												if (d.plbRbs) {
													str = d.plbRbs.rbsLongName;
												}
												return str;
											}
										},
										{
											field: 'cbsName', title: 'CBS',minWidth:100, templet: function (d) {
												var str = '';
												if (d.plbCbsTypeWithBLOBs) {
													str = d.plbCbsTypeWithBLOBs.cbsName;
												}
												return str;
											}
										},
										{
											field: 'controlType', title: '控制类型', minWidth:120,templet: function (d) {
												return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
											}
										},
										{
											field: 'rbsUnit', title: '单位',minWidth:120, templet: function (d) {
												var str = '';
												if (d.plbRbs) {
													// str = dictionaryObj['CBS_UNIT']['object'][d.plbRbs.rbsUnit] || '';
													str = dictionaryObj['CBS_UNIT']['object'][d.itemUnit] || '';
												}
												return str;
											}
										},
                                        {field: 'incomeTarNum', title: '收入目标数量',width:120},
                                        {field: 'incomeTarPrice', title: '收入目标单价',width:120},
                                        {field: 'incomeTarAmount', title: '收入目标总价',width:120},
                                        {field: 'optTarNum', title: '优化目标数量',width:120},
                                        {field: 'optTarPrice', title: '优化目标单价',width:120},
                                        {field: 'optTarAmount', title: '优化目标总价',width:120},
                                        {field: 'manageTarNum', title: '管理目标数量',width:120},
                                        {field: 'manageTarPrice', title: '管理目标单价',width:120},
                                        {field: 'manageTarAmount', title: '管理目标总价',width:120},
										// {field: 'addupNeedAmount', title: '已提需求计划数量',minWidth:170},
										// {field: 'monQuata', title: '',minWidth:170},
										{field: 'accumulatedSignedContractAmount', title: '累计已签合同金额',minWidth:170},
										//{field: 'addupNeedMoney', title: '累计已提需求计划金额',minWidth:170},
										//{field: 'manageSurplusMoney', title: '管理目标金额余额',minWidth:150},
									]],
									done:function(res){
										var _dataa=res.data;
										if(costTableData!=undefined&&costTableData.length>0){
											for(var i = 0 ; i <_dataa.length;i++){
												for(var n = 0 ; n < costTableData.length; n++){
													if(_dataa[i].projBudgetId == costTableData[n].projBudgetId){
														$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
														//form.render('checkbox');
													}
												}
											}
										}

									}
								});
							}
						},
						yes: function (index) {
							var datas = table.checkStatus('managementBudgetTable').data;
							if (datas.length > 0) {
								//遍历表格获取每行数据进行保存
								var dataArr = planningDetailsData().costData;

								datas.forEach(function (item) {
									if(dataArr){
										var _flag = true
										for(var j=0;j<dataArr.length;j++){
											if(dataArr[j].projBudgetId==item.projBudgetId){
												_flag = false
											}
										}
										if(_flag){
											dataArr.push(item)
										}
									}else{
										dataArr.push(item)
									}
								})
								table.reload('costTable', {
									data: dataArr,
									height: dataArr&&dataArr.length>5?'full-350':false
								});
								layer.close(index);
							} else {
								layer.msg('请选择一项！', {icon: 0});
							}
						}
					});
					break;
			}
		});
		// 成本策划-删行
		table.on('tool(costTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.planningBudgetId) {
					$.get('/workPlanning/del', {ids: data.planningBudgetId,type:"budget"}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('costTable', {
								data: planningDetailsData().costData,
								height: planningDetailsData().costData&&planningDetailsData().costData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('costTable', {
						data: planningDetailsData().costData,
						height: planningDetailsData().costData&&planningDetailsData().costData.length>5?'full-350':false
					});
				}
			}
		})

		// 技术策划-选择
		table.on('toolbar(skillTable)', function (obj) {
			switch (obj.event) {
				case 'choice':
					layer.open({
						type: 1,
						title: '选择技术方案编制计划',
						area: ['80%', '80%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: ['<div class="layui-form" style="padding:0px 10px">' +
						'<div class="query_module layui-form layui-row" style="padding:10px">\n' +
						'                <div class="layui-col-xs2">\n' +
						'                    <input type="text" name="documnetNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +
						/*'                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
						'                    <input type="text" name="optimizationName" id="" placeholder="优化名称" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +*/
						'                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
						'                    <button type="button" class="layui-btn layui-btn-sm InSearch_Data3">查询</button>\n' +
						'                </div>\n' +
						'</div>' +
						'<div>' +
						'     <table id="table_DemoIn3" lay-filter="table_DemoIn3"></table>\n' +
						'</div>' +
						'</div>'].join(''),
						success: function () {
							var table_DemoIn3=table.render({
								elem: '#table_DemoIn3',
								url: '/technologySchemePlan/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
								cols: [[
									{checkbox: true},
									// {field: 'documnetNo', title: '单据号', minWidth: 90,sort: true, hide: false},
									// {field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
									{field: 'technologyName', title: '方案名称', minWidth: 150},
									{field:'technologyDesc',title:'方案描述',minWidth: 120,sort:true,hide:false},
									{field:'importanceLevel',title:'重要级别',minWidth: 120,sort:true,hide:false,templet: function (d) {
										if(d.importanceLevel) {
											return '<span>'+((dictionaryObj&&dictionaryObj['IMPORTANCE_LEVEL']&&dictionaryObj['IMPORTANCE_LEVEL']['object'][d.importanceLevel])||'')+'</span>'
										}else {
											return ''
										}
									}},
									{field:'projectUserName',title:'项目责任人',minWidth: 120,sort:true,hide:false},
									{field:'companyUserName',title:'公司责任人',minWidth: 120,sort:true,hide:false},
									{field:'planEndDate',title:'计划完成时间',minWidth: 120,sort:true,hide:false},
									{field:'achieveRequire',title:'成果物要求',minWidth: 120,sort:true,hide:false},
								]],
								// height: 'full-430',
								page: true,
								done:function(res){
									var oldDataArr = planningDetailsData().skillData;
									var _dataa=res.data;
									if(oldDataArr!=undefined&&oldDataArr.length>0){
										for(var i = 0 ; i <_dataa.length;i++){
											for(var n = 0 ; n < oldDataArr.length; n++){
												if(_dataa[i].technologyPlanId == oldDataArr[n].technologyPlanId){
													$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
													//form.render('checkbox');
												}
											}
										}
									}

								}
							});
							$('.InSearch_Data3').click(function(){
								var documnetNo=$('[name="documnetNo"]').val();
								// var optimizationName=$('[name="optimizationName"]').val();
								table_DemoIn3.reload({
									where:{
										documnetNo:documnetNo,
										// optimizationName:optimizationName
									}
								})
							})
						},
						yes: function (index) {

							var checkStatus = table.checkStatus('table_DemoIn3'); //获取选中行状态
							var datas = checkStatus.data;  //获取选中行数据

							//判断是否选择数据
							if (datas.length == 0) {
								layer.msg('请选择至少一项！', {icon: 0});
								return false
							}

							//遍历表格获取每行数据进行保存
							var dataArr = planningDetailsData().skillData;

							datas.forEach(function (item) {
								if(dataArr){
									var _flag = true
									for(var j=0;j<dataArr.length;j++){
										if(dataArr[j].technologyPlanId==item.technologyPlanId){
											_flag = false
										}
									}
									if(_flag){
										dataArr.push(item)
									}
								}else{
									dataArr.push(item)
								}
							})
							table.reload('skillTable', {
								data: dataArr,
								height: dataArr&&dataArr.length>5?'full-350':false
							});

							layer.close(index)
						}
					})
					break;
			}
		});
		// 技术策划-删行
		table.on('tool(skillTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.planningTechnologyId) {
					$.get('/workPlanning/del', {ids: data.planningTechnologyId,type:"technology"}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('skillTable', {
								data: planningDetailsData().skillData,
								height: planningDetailsData().skillData&&planningDetailsData().skillData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('skillTable', {
						data: planningDetailsData().skillData,
						height: planningDetailsData().skillData&&planningDetailsData().skillData.length>5?'full-350':false
					});
				}
			}
			else if (layEvent == 'chooseCollectionUser') {
				if(!$tr.find('[name="projectUserName"]').attr('disabled')){
					user_id = $tr.find('[name="projectUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}
			else if (layEvent == 'chooseCollectionUser2') {
				if(!$tr.find('[name="companyUserName"]').attr('disabled')){
					user_id = $tr.find('[name="companyUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}
			else if (layEvent == 'dateSelection') {
				var $tr2 = $('.skill_planning').find($tr.selector).find('input[name="planEndDate"]');
				$tr2.each(function (index,element) {
					laydate.render({
						elem: element
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
					});
				})
			}
			else if (layEvent == 'roadmap') {
				var _this = this
				if($(_this).find('[name="businessName"]').attr('disabled')) return
				layer.open({
					type: 1,
					title: '选择管理策划',
					area: ['80%', '80%'],
					btn: ['确定', '取消'],
					btnAlign: 'c',
					content: ['<div class="layui-form" style="padding:0px 10px">' +
					'<div class="query_module layui-form layui-row" style="padding:10px">\n' +
					'                <div class="layui-col-xs2">\n' +
					'                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
					'                </div>\n' +
					'                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
					'                    <input type="text" name="managePlanningName" id="" placeholder="策划名称" autocomplete="off" class="layui-input">\n' +
					'                </div>\n' +
					'                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
					'                    <button type="button" class="layui-btn layui-btn-sm InSearchData2">查询</button>\n' +
					'                </div>\n' +
					'</div>' +
					'<div>' +
					'     <table id="tableDemoIn2" lay-filter="tableDemoIn2"></table>\n' +
					'     <div id="downBox2">\n' +
					'         <table id="tableDemoInDown2" lay-filter="tableDemoInDown2"></table>\n' +
					'      </div>' +
					'</div>' +
					'</div>'].join(''),
					success: function () {
						var tableDemoIn2=table.render({
							elem: '#tableDemoIn2',
							url: '/managePlanning/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
							cols: [[
								{field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
								{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
								{field: 'managePlanningName', title: '策划名称', minWidth: 120,sort: true, hide: false},
								{field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
								{field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
								{field: 'managePlanningExplain', title: '策划说明',minWidth: 120, sort: true, hide: false}
							]],
							// height: 'full-430',
							page: true
						});
						$('.InSearchData2').click(function(){
							var documentNo=$('[name="documentNo"]').val();
							var managePlanningName=$('[name="managePlanningName"]').val();
							tableDemoIn2.reload({
								where:{
									documentNo:documentNo,
									managePlanningName:managePlanningName
								}
							})
						})
					},
					yes: function (index) {

						var checkStatus = table.checkStatus('tableDemoInDown2'); //获取选中行状态
						var datas = checkStatus.data[0];  //获取选中行数据

						//判断是否选择数据
						if (datas.length == 0) {
							layer.msg('请选择一项！', {icon: 0});
							return false
						}
						$(_this).find('[name="businessName"]').val(datas.businessName).attr('planingTechnologyId',datas.planingTechnologyId)
						layer.close(index)
					}
				})
			}
		})
		//监听行单击事件
		table.on('row(tableDemoIn2)', function (obj) {
			// console.log(obj.data) //得到当前行数据
			var data = obj.data
			$('#downBox2').show()
			obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
			var _data = data&&data.planningTechnologyList||[]
			tableShowDown2(_data)
		});

		//安全检查计划明细表
		function tableShowDown2(data) {
			table.render({
				elem: '#tableDemoInDown2',
				data: data,
				cellMinWidth:150,
				cols: [[
					{type: 'radio'},
					{field: 'businessName', title: '技术名称',minWidth: 150},
					{field: 'mainSchemeContent', title: '主要内容',minWidth: 150},
					{field: 'schemeDesc', title: '描述说明',minWidth: 150},
					{field: 'chargeUserName', title: '责任人',minWidth: 150},
					{field: 'superviseUserName', title: '监督人',minWidth: 150},
					{
						field: 'attachmentName',
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
				// height: 'full-430',
				page: true,
				done:function(res){
					$('#downBox2 .deImgs').hide()
					var oldDataArr = planningDetailsData().skillData;
					var _dataa=res.data;
					if(oldDataArr!=undefined&&oldDataArr.length>0){
						for(var i = 0 ; i <_dataa.length;i++){
							for(var n = 0 ; n < oldDataArr.length; n++){
								if(_dataa[i].planingTechnologyId == oldDataArr[n].planingTechnologyId){
									$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
									//form.render('checkbox');
								}
							}
						}
					}

				}
			});
		}
		// 优化计划-选择
		table.on('toolbar(optimizationTable)', function (obj) {
			switch (obj.event) {
				case 'choice':
					layer.open({
						type: 1,
						title: '选择优化计划',
						area: ['80%', '80%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: ['<div class="layui-form" style="padding:0px 10px">' +
						'<div class="query_module layui-form layui-row" style="padding:10px">\n' +
						'                <div class="layui-col-xs2">\n' +
						'                    <input type="text" name="documnetNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +
						'                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
						'                    <input type="text" name="optimizationName" id="" placeholder="优化名称" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +
						'                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
						'                    <button type="button" class="layui-btn layui-btn-sm InSearchData3">查询</button>\n' +
						'                </div>\n' +
						'</div>' +
						'<div>' +
						'     <table id="tableDemoIn3" lay-filter="tableDemoIn3"></table>\n' +
						'</div>' +
						'</div>'].join(''),
						success: function () {
							var tableDemoIn3=table.render({
								elem: '#tableDemoIn3',
								url: '/optimizationScheme/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
								cols: [[
									{checkbox: true},
									{field: 'documnetNo', title: '单据号', minWidth: 90,sort: true, hide: false},
									{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
									{field: 'optimizationName', title: '优化名称', minWidth: 120,sort: true, hide: false},
									{field: 'schemeDesc', title: '优化描述',minWidth: 120, sort: true, hide: false},
									{field:'schemeCategory',title:'优化类别',minWidth: 120,sort:true,hide:false,templet: function (d) {
											if(d.schemeCategory) {
												return '<span>'+((dictionaryObj&&dictionaryObj['OPTIMIZATION_CATEGORY']&&dictionaryObj['OPTIMIZATION_CATEGORY']['object'][d.schemeCategory])||'')+'</span>'
											}else {
												return ''
											}
										}},
									{field:'schemeType',title:'优化类型',minWidth: 120,sort:true,hide:false,templet: function (d) {
											if(d.schemeType) {
												return '<span>'+((dictionaryObj&&dictionaryObj['OPTIMIZATION_TYPE']&&dictionaryObj['OPTIMIZATION_TYPE']['object'][d.schemeType])||'')+'</span>'
											}else {
												return ''
											}
										}},
									// {field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
									// {field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
									// {field: 'mainSchemeContent', title: '主要内容',minWidth: 120, sort: true, hide: false},

									{field: 'chargeUserName', title: '责任人',minWidth: 120, sort: true, hide: false},
									{field: 'superviseUserName', title: '监督人',minWidth: 120, sort: true, hide: false}
								]],
								// height: 'full-430',
								page: true,
								done:function(res){
									var oldDataArr = planningDetailsData().optimizationData;
									var _dataa=res.data;
									if(oldDataArr!=undefined&&oldDataArr.length>0){
										for(var i = 0 ; i <_dataa.length;i++){
											for(var n = 0 ; n < oldDataArr.length; n++){
												if(_dataa[i].optimizationId == oldDataArr[n].optimizationId){
													$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
													//form.render('checkbox');
												}
											}
										}
									}

								}
							});
							$('.InSearchData3').click(function(){
								var documnetNo=$('[name="documnetNo"]').val();
								var optimizationName=$('[name="optimizationName"]').val();
								tableDemoIn3.reload({
									where:{
										documnetNo:documnetNo,
										optimizationName:optimizationName
									}
								})
							})
						},
						yes: function (index) {

							var checkStatus = table.checkStatus('tableDemoIn3'); //获取选中行状态
							var datas = checkStatus.data;  //获取选中行数据

							//判断是否选择数据
							if (datas.length == 0) {
								layer.msg('请选择至少一项！', {icon: 0});
								return false
							}

							//遍历表格获取每行数据进行保存
							var dataArr = planningDetailsData().optimizationData;

							datas.forEach(function (item) {
								if(dataArr){
									var _flag = true
									for(var j=0;j<dataArr.length;j++){
										if(dataArr[j].optimizationId==item.optimizationId){
											_flag = false
										}
									}
									if(_flag){
										dataArr.push(item)
									}
								}else{
									dataArr.push(item)
								}
							})
							table.reload('optimizationTable', {
								data: dataArr,
								height: dataArr&&dataArr.length>5?'full-350':false
							});
							
							layer.close(index)
						}
					})
					break;
			}
		});
		// 优化计划-删行
		table.on('tool(optimizationTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.planningOptimizaId) {
					$.get('/workPlanning/del', {ids: data.planningOptimizaId,type:"optimization"}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('optimizationTable', {
								data: planningDetailsData().optimizationData,
								height: planningDetailsData().optimizationData&&planningDetailsData().optimizationData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('optimizationTable', {
						data: planningDetailsData().optimizationData,
						height: planningDetailsData().optimizationData&&planningDetailsData().optimizationData.length>5?'full-350':false
					});
				}
			}
		})
		// 经营计划-选择
		table.on('toolbar(secondaryTable)', function (obj) {
			switch (obj.event) {
				case 'choice':
					layer.open({
						type: 1,
						title: '选择经营计划',
						area: ['80%', '80%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: ['<div class="layui-form" style="padding:0px 10px">' +
						'<div class="query_module layui-form layui-row" style="padding:10px">\n' +
						'                <div class="layui-col-xs2">\n' +
						'                    <input type="text" name="documnetNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +
						'                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
						'                    <input type="text" name="businessName" id="" placeholder="经营名称" autocomplete="off" class="layui-input">\n' +
						'                </div>\n' +
						'                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
						'                    <button type="button" class="layui-btn layui-btn-sm InSearchData4">查询</button>\n' +
						'                </div>\n' +
						'</div>' +
						'<div>' +
						'     <table id="tableDemoIn4" lay-filter="tableDemoIn4"></table>\n' +
						'</div>' +
						'</div>'].join(''),
						success: function () {
							var tableDemoIn4=table.render({
								elem: '#tableDemoIn4',
								url: '/businessScheme/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
								cols: [[
									{checkbox: true},
									{field: 'documnetNo', title: '单据号', minWidth: 90,sort: true, hide: false},
									{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
									{field: 'businessName', title: '优化名称', minWidth: 120,sort: true, hide: false},
									{field: 'schemeDesc', title: '经营描述',minWidth: 120, sort: true, hide: false},
									{field:'schemeCategory',title:'经营类别',minWidth: 120,sort:true,hide:false,templet: function (d) {
											if(d.schemeCategory) {
												return '<span>'+((dictionaryObj&&dictionaryObj['BUSINESS_CATEGORY']&&dictionaryObj['BUSINESS_CATEGORY']['object'][d.schemeCategory])||'')+'</span>'
											}else {
												return ''
											}
										}},
									{field:'schemeType',title:'经营类型',minWidth: 120,sort:true,hide:false,templet: function (d) {
											if(d.schemeType) {
												return '<span>'+((dictionaryObj&&dictionaryObj['BUSINESS_TYPE']&&dictionaryObj['BUSINESS_TYPE']['object'][d.schemeType])||'')+'</span>'
											}else {
												return ''
											}
										}},
									// {field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
									// {field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
									// {field: 'mainSchemeContent', title: '主要内容',minWidth: 120, sort: true, hide: false},

									{field: 'chargeUserName', title: '责任人',minWidth: 120, sort: true, hide: false},
									{field: 'superviseUserName', title: '监督人',minWidth: 120, sort: true, hide: false}
								]],
								// height: 'full-430',
								page: true,
								done:function(res){
									var oldDataArr = planningDetailsData().secondaryData;
									var _dataa=res.data;
									if(oldDataArr!=undefined&&oldDataArr.length>0){
										for(var i = 0 ; i <_dataa.length;i++){
											for(var n = 0 ; n < oldDataArr.length; n++){
												if(_dataa[i].businessId == oldDataArr[n].businessId){
													$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
													//form.render('checkbox');
												}
											}
										}
									}

								}
							});
							$('.InSearchData4').click(function(){
								var documnetNo=$('[name="documnetNo"]').val();
								var businessName=$('[name="businessName"]').val();
								tableDemoIn3.reload({
									where:{
										documnetNo:documnetNo,
										businessName:businessName
									}
								})
							})
						},
						yes: function (index) {

							var checkStatus = table.checkStatus('tableDemoIn4'); //获取选中行状态
							var datas = checkStatus.data;  //获取选中行数据

							//判断是否选择数据
							if (datas.length == 0) {
								layer.msg('请选择至少一项！', {icon: 0});
								return false
							}

							//遍历表格获取每行数据进行保存
							var dataArr = planningDetailsData().secondaryData;

							datas.forEach(function (item) {
								if(dataArr){
									var _flag = true
									for(var j=0;j<dataArr.length;j++){
										if(dataArr[j].businessId==item.businessId){
											_flag = false
										}
									}
									if(_flag){
										dataArr.push(item)
									}
								}else{
									dataArr.push(item)
								}
							})
							table.reload('secondaryTable', {
								data: dataArr,
								height: dataArr&&dataArr.length>5?'full-350':false
							});

							layer.close(index)
						}
					})
					break;
			}
		});
		// 经营计划-删行
		table.on('tool(secondaryTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.planningBusinessId) {
					$.get('/workPlanning/del', {ids: data.planningBusinessId,type:"business"}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('secondaryTable', {
								data: planningDetailsData().secondaryData,
								height: planningDetailsData().secondaryData&&planningDetailsData().secondaryData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('secondaryTable', {
						data: planningDetailsData().secondaryData,
						height: planningDetailsData().secondaryData&&planningDetailsData().secondaryData.length>5?'full-350':false
					});
				}
			}
		})

		/**
		 * 获取实施策划明细子表数据
		 */
		function planningDetailsData() {
			//进度策划
			//遍历表格获取每行数据
			// var $trs = $('.schedule_planning').find('.layui-table-main tr');
			// var dataArr = [];
			// $trs.each(function () {
			// 	var dataObj = {
			// 		workPlanningId: $(this).find('.scheduleName').attr('workPlanningId') || '',
			// 		planningShceduleId: $(this).find('.scheduleName').attr('planningShceduleId') || '',
			// 		scheduleId: $(this).find('.scheduleName').attr('scheduleId') || '',
			// 		scheduleName: $(this).find('.scheduleName').text(),
			// 		scheduleBeginDate: $(this).find('[data-field="scheduleBeginDate"] div').text(),
			// 		scheduleEndDate: $(this).find('[data-field="scheduleEndDate"] div').text(),
			// 		scheduleUserName: $(this).find('.scheduleUserName').text(),
			// 		scheduleUser: $(this).find('.scheduleUserName').attr('scheduleUser'),
			// 		supervisorUserName: $(this).find('.scheduleUserName').text(),
			// 		supervisorUser: $(this).find('.supervisorUserName').attr('supervisorUser'),
			// 		memo: $(this).find('[data-field="memo"] div').text()
			// 	}
			// 	dataArr.push(dataObj);
			// });

			//质量策划
			var $trs2 = $('.quality_planning').find('.layui-table-main tr');
			var dataArr2 = [];
			$trs2.each(function () {
				var dataObj = {
					// inspectionContent:$(this).find('[data-field="inspectionContent"] div').text(),
					// mainDifficulties: $(this).find('[data-field="mainDifficulties"] div').text(),
					// mainRisk: $(this).find('[data-field="mainRisk"] div').text(),
					// riskSolutions: $(this).find('[data-field="riskSolutions"] div').text(),
					personLiableName: $(this).find('[data-field="personLiableName"] div').text(),
					checkFrequency: $(this).find('.checkFrequency').attr('checkFrequency'),
					importance: $(this).find('.importance').attr('importance'),
					solutions: $(this).find('[data-field="solutions"] span').text(),

					personLiable: $(this).find('.securityKnowledgeName').attr('personLiable') || '',
					securityKnowledgeName: $(this).find('.securityKnowledgeName').text(),
					securityTermId: $(this).find('.securityKnowledgeName').attr('securityTermId') || '',
					workPlanningId: $(this).find('.securityKnowledgeName').attr('workPlanningId') || '',
					securityPlanId: $(this).find('.securityKnowledgeName').attr('securityPlanId') || '',
				}
				dataArr2.push(dataObj);
			});

			//安全策划
			var $trs3 = $('.security_planning').find('.layui-table-main tr');
			var dataArr3 = [];
			$trs3.each(function () {
				var dataObj = {
					// inspectionContent:$(this).find('[data-field="inspectionContent"] div').text(),
					// mainDifficulties: $(this).find('[data-field="mainDifficulties"] div').text(),
					// mainRisk: $(this).find('[data-field="mainRisk"] div').text(),
					// riskSolutions: $(this).find('[data-field="riskSolutions"] div').text(),
					personLiableName: $(this).find('[data-field="personLiableName"] div').text(),
					checkFrequency: $(this).find('.checkFrequency').attr('checkFrequency'),
					importance: $(this).find('.importance').attr('importance'),
					solutions: $(this).find('[data-field="solutions"] span').text(),

					personLiable: $(this).find('.securityKnowledgeName').attr('personLiable') || '',
					securityKnowledgeName: $(this).find('.securityKnowledgeName').text(),
					securityTermId: $(this).find('.securityKnowledgeName').attr('securityTermId') || '',
					workPlanningId: $(this).find('.securityKnowledgeName').attr('workPlanningId') || '',
					securityPlanId: $(this).find('.securityKnowledgeName').attr('securityPlanId') || '',
				}
				dataArr3.push(dataObj);
			});

			//成本策划
			var $trs4 = $('.cost_planning').find('.layui-table-main tr');
			var dataArr4 = [];
			$trs4.each(function () {
				var dataObj = {
					workPlanningId: $(this).find('.wbsName').attr('workPlanningId') || '',
					planningBudgetId: $(this).find('.wbsName').attr('planningBudgetId') || '',
					projBudgetId: $(this).find('.wbsName').attr('projBudgetId') || '',
					wbsName: $(this).find('.wbsName').text(),
					rbsLongName: $(this).find('.rbsLongName').text(),
					cbsName: $(this).find('.cbsName').text(),
					controlType: $(this).find('.controlType').attr('controlType'),
					itemUnit: $(this).find('.itemUnit').attr('itemUnit'),
                    incomeTarNum: $(this).find('[data-field="incomeTarNum"] div').text(),
                    incomeTarPrice: $(this).find('[data-field="incomeTarPrice"] div').text(),
                    incomeTarAmount: $(this).find('[data-field="incomeTarAmount"] div').text(),
					optTarNum: $(this).find('[data-field="optTarNum"] div').text(),
					optTarPrice: $(this).find('[data-field="optTarPrice"] div').text(),
					optTarAmount: $(this).find('[data-field="optTarAmount"] div').text(),
                    manageTarNum: $(this).find('[data-field="manageTarNum"] div').text(),
                    manageTarPrice: $(this).find('[data-field="manageTarPrice"] div').text(),
                    manageTarAmount: $(this).find('[data-field="manageTarAmount"] div').text(),
					optTarExplain: $(this).find('[data-field="optTarExplain span"]').text()
				}
				dataArr4.push(dataObj);
			});

			//技术策划
			var $trs5 = $('.skill_planning').find('.layui-table-main tr');
			var dataArr5 = [];
			$trs5.each(function () {
				/*var schDom=$(this).find('input[name="projectUserName"]');
				var scheduleUser = $(schDom).attr('user_id')||''
				if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
					scheduleUser=scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
				}
				var supDom=$(this).find('input[name="companyUserName"]');
				var supervisor = $(supDom).attr('user_id')||''
				if(supervisor&&supervisor.indexOf(',')!=-1){
					supervisor=supervisor.substring(0,supervisor.lastIndexOf(','))
				}*/
				var dataObj = {
					technologyName: $(this).find('[data-field="technologyName"] div').text(),
					technologyDesc: $(this).find('[data-field="technologyDesc"] span').text(),
					importanceLevel: $(this).find('[data-field="importanceLevel"] span').attr('importanceLevel'),
					projectUserName: $(this).find('[data-field="projectUserName"] span').text(),
					projectUser: $(this).find('[data-field="projectUserName"] span').attr('user_id'),
					companyUserName: $(this).find('[data-field="companyUserName"] span').text(),
					companyUser: $(this).find('[data-field="companyUserName"] span').attr('user_id'),
					planEndDate: $(this).find('[data-field="planEndDate"] div').text(),
					achieveRequire: $(this).find('[data-field="achieveRequire"] span').text(),
					businessName: $(this).find('input[name="businessName"]').val(),
					workPlanningId: $(this).find('input[name="businessName"]').attr('workPlanningId') || '',
					planningTechnologyId: $(this).find('input[name="businessName"]').attr('planningTechnologyId') || '',
					planingTechnologyId: $(this).find('input[name="businessName"]').attr('planingTechnologyId') || '',
					technologyPlanId: $(this).find('input[name="businessName"]').attr('technologyPlanId') || ''
				}
				dataArr5.push(dataObj);
			});

			//优化计划
			var $trs6 = $('.optimization_scheme').find('.layui-table-main tr');
			var dataArr6 = [];
			$trs6.each(function (index) {
				var attachList = [];

				for (var i = 0; i < $('#file_All'+(index+1)+' .dech').length; i++) {
					var _obj ={
						attUrl:$('#file_All'+(index+1)+' .dech').eq(i).find('input').attr('deUrl'),
						attachId:$('#file_All'+(index+1)+' .dech').eq(i).find('input').attr('attachId'),
						attachName:$('#file_All'+(index+1)+' .dech').eq(i).find('input').attr('attachName'),
						aid:$('#file_All'+(index+1)+' .dech').eq(i).find('input').val().substring(0,$('#file_All'+(index+1)+' .dech .inHidden').val().indexOf('@')),
						ym:$('#file_All'+(index+1)+' .dech').eq(i).find('input').val().substring($('#file_All'+(index+1)+' .dech .inHidden').val().indexOf('@')+1,$('#file_All'+(index+1)+' .dech .inHidden').val().indexOf('_'))
					}
					attachList.push(_obj)
				}


				var dataObj = {
					workPlanningId: $(this).find('.optimizationName').attr('workPlanningId') || '',
					planningOptimizaId: $(this).find('.optimizationName').attr('planningOptimizaId') || '',
					optimizationId: $(this).find('.optimizationName').attr('optimizationId') || '',
					optimizationName: $(this).find('.optimizationName').text(),
					mainSchemeContent: $(this).find('[data-field="mainSchemeContent"] div').text(),
					schemeDesc: $(this).find('[data-field="schemeDesc"] span').text(),
					chargeUserName: $(this).find('[data-field="chargeUserName"] div').text(),
					superviseUserName: $(this).find('[data-field="superviseUserName"] div').text(),

					schemeCategory: $(this).find('[data-field="schemeCategory"] span').attr('schemeCategory'),
					schemeType: $(this).find('[data-field="schemeType"] span').attr('schemeType'),

					attachmentList:attachList
				}
				dataArr6.push(dataObj);
			});

			//经营计划
			var $trs7 = $('.secondary_operation').find('.layui-table-main tr');
			var dataArr7 = [];
			$trs7.each(function (index) {
				var attachList = [];

				for (var i = 0; i < $('#file_All2'+(index+1)+' .dech').length; i++) {
					var _obj ={
						attUrl:$('#file_All2'+(index+1)+' .dech').eq(i).find('input').attr('deUrl'),
						attachId:$('#file_All2'+(index+1)+' .dech').eq(i).find('input').attr('attachId'),
						attachName:$('#file_All2'+(index+1)+' .dech').eq(i).find('input').attr('attachName'),
						aid:$('#file_All2'+(index+1)+' .dech').eq(i).find('input').val().substring(0,$('#file_All2'+(index+1)+' .dech .inHidden').val().indexOf('@')),
						ym:$('#file_All2'+(index+1)+' .dech').eq(i).find('input').val().substring($('#file_All2'+(index+1)+' .dech .inHidden').val().indexOf('@')+1,$('#file_All2'+(index+1)+' .dech .inHidden').val().indexOf('_'))
					}
					attachList.push(_obj)
				}


				var dataObj = {
					workPlanningId: $(this).find('.businessName').attr('workPlanningId') || '',
					planningOptimizaId: $(this).find('.businessName').attr('planningOptimizaId') || '',
					businessId: $(this).find('.businessName').attr('businessId') || '',
					businessName: $(this).find('.businessName').text(),
					mainSchemeContent: $(this).find('[data-field="mainSchemeContent"] div').text(),
					schemeDesc: $(this).find('[data-field="schemeDesc"] span').text(),
					chargeUserName: $(this).find('[data-field="chargeUserName"] div').text(),
					superviseUserName: $(this).find('[data-field="superviseUserName"] div').text(),

					schemeCategory: $(this).find('[data-field="schemeCategory"] span').attr('schemeCategory'),
					schemeType: $(this).find('[data-field="schemeType"] span').attr('schemeType'),

					attachmentList:attachList
				}
				dataArr7.push(dataObj);
			});

			return {
				// scheduleData: dataArr,
				qualityData: dataArr2,
				securityData: dataArr3,
				costData: dataArr4,
				skillData: dataArr5,
				optimizationData: dataArr6,
				secondaryData: dataArr7,
			}
		}
		//质量 检查详细内容
		function new_Edit(data) {
			var projectId = $('#leftId').attr('projId');
			layer.open({
				type: 1,
				title: '检查详细内容',
				area: ['90%', '90%'],
				btn: ['确定'],
				btnAlign: 'c',
				content: '<div class="project_detailed" style="margin:20px"><table id="detailed_Table" lay-filter="detailed_Table"></table></div>',
				success: function () {

					//检查计划明细
					var cols = [
						// {type: 'radio'},
						{type: 'numbers', title: '序号'},
						{field: 'securityDanger', minWidth:150,title: '质量控制要点'},
						{field: 'securityDangerMeasures', minWidth:150,title: '特征描述'},
						{
							field: 'attachmentName',
							title: '特征图片',
							align: 'center',
							minWidth: 200,
							templet: function (d) {
								var fileArr = d.attachmentList;
								return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
										'</div>'

							}
						},
						{field: 'securityDangerGrade',minWidth:100, title: '重大问题',templet:function(d){
								if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
									if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
										return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">重大隐患</span>';
									}else{
										return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">一般隐患</span>';
									}
								}else{
									return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index ||  d.LAY_INDEX || '')+'"></span>';
								}
							}
						}
					]

					table.render({
						elem: '#detailed_Table',
						data: data&&data.detailList||[],
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols],
						done:function(res){
							$('.project_detailed .deImgs').hide();
							$('.layui-table-body [data-field="securityDanger"] div,.layui-table-body [data-field="securityDangerMeasures"] div').on('mouseenter', function(){
								var content = $(this).text();
								if(!content){
									return false
								}

								this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
									time: -1
									,maxWidth: 280
									,tips: [3, '#3A3D49']
								});
							}).on('mouseleave', function(){
								layer.close(this.index);
							});
						}
					});

					form.render();
				},
				yes: function (index) {
					layer.close(index);
				}
			});
		}
		//安全 检查详细内容
		function new_Edit2(data) {
			var projectId = $('#leftId').attr('projId');
			layer.open({
				type: 1,
				title: '检查详细内容',
				area: ['90%', '90%'],
				btn: ['确定'],
				btnAlign: 'c',
				content: '<div style="margin:20px"><table id="detailed_Table" lay-filter="detailed_Table"></table></div>',
				success: function () {

					//检查计划明细
					var cols = [
						// {type: 'radio'},
						{type: 'numbers', title: '序号'},
						{field: 'securityDanger', minWidth:150,title: '检查内容'},
						{field: 'securityDangerMeasures', minWidth:150,title: '整改措施'},
						{field: 'securityDangerGrade',minWidth:100, title: '隐患级别',templet:function(d){
								if(d.securityDangerGrade!=undefined&&d.securityDangerGrade!=""){
									if(d.securityDangerGrade===0||d.securityDangerGrade==="0"){
										return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">重大隐患</span>';
									}else{
										return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index || d.LAY_INDEX || '')+'">一般隐患</span>';
									}
								}else{
									return '<span securityDangerGrade="'+(d.securityDangerGrade || '')+'" securityTermId="'+(d.securityTermId || '')+'" securityTermDetailId="'+(d.securityTermDetailId || '')+'" securityDangerId="'+(d.securityDangerId || '')+'" securityDangerTypeId="'+(d.securityDangerTypeId || '')+'" index="'+(d.index ||  d.LAY_INDEX || '')+'"></span>';
								}
							}
						}
					]

					table.render({
						elem: '#detailed_Table',
						data: data&&data.detailList||[],
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols],
						done:function(res){
							$('.layui-table-body [data-field="securityDanger"] div,.layui-table-body [data-field="securityDangerMeasures"] div').on('mouseenter', function(){
								var content = $(this).text();
								if(!content){
									return false
								}

								this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
									time: -1
									,maxWidth: 280
									,tips: [3, '#3A3D49']
								});
							}).on('mouseleave', function(){
								layer.close(this.index);
							});
						}
					});

					form.render();
				},
				yes: function (index) {
					layer.close(index);
				}
			});
		}

		// 进度计划 新建/编辑
		function newSchedule(type, data) {
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
					var $select1 = $(".scheduleType");
					var optionStr = '<option value="">请选择</option>';
					optionStr += dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['str']
					$select1.html(optionStr);

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
							var scheduleEndDate = ''
							//console.log(dateParse(value))
							//紧前时间
							if(value&&schedule_EndDate){
								beforeScheduleDate = getDays(schedule_EndDate,value)-1
								$('#beforeScheduleDate').val(beforeScheduleDate)
							}
							//结束时间
							if(value&&scheduleDuration){
								scheduleEndDate = getNewDay(value,scheduleDuration,-1)
								$('#scheduleEndDate').val(scheduleEndDate)
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

						obj.dataForm = '2'

						if(type == '1'){
							obj.scheduleId= data.scheduleId;
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

				}

			});
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
							{field: 'documentNo', title: '编号', minWidth:250,sort: true, hide: false},
							// {field:'companySort',title:'排序号',minWidth: 100,sort:true,hide:false},
							{field: 'scheduleName', title: '任务名称', minWidth: 200,sort: true, hide: false},
							{field:'scheduleBeginDate',title:'计划开始时间',minWidth: 130,sort:true,hide:false,templet: function (d) {
									if(d.dataForm=='1'){
										return '<span></span>'
									}else {
										return '<span>'+(d.scheduleBeginDate||'')+'</span>'
									}
								}},
							{field: 'scheduleEndDate', title: '计划完成时间', minWidth: 130,sort: true, hide: false},
							{field: 'scheduleDuration', title: '持续时间',minWidth: 110, sort: true, hide: false},
							{field:'beforeSchedule',title:'紧前任务',minWidth: 110,sort:false,hide:false,templet: function (d) {
									return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
								}},
							{field: 'scheduleType', title: '类型',minWidth: 100, sort: true, hide: false,templet: function (d) {
									if(d.scheduleType) {
										return '<span>'+((dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['object'][d.scheduleType])||'')+'</span>'
									}else {
										return ''
									}
								}},
							{field: 'scheduleUserName', title: '责任人',minWidth: 100, sort: true, hide: false},
							{field: 'supervisorUserName', title: '监督人',minWidth: 100, sort: true, hide: false},
							{field: 'importanceLevel', title: '重要性',minWidth: 100, sort: true, hide: false,templet: function (d) {
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


		//点击查询
		$('.searchData').click(function () {
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


		/**
		 * 新建流程方法
		 * @param flowId
		 * @param urlParameter
		 * @param cb
		 */
		function newWorkFlow(flowId, cb,approvalData) {
			$.ajax({
				url: '/workflow/work/workfastAdd',
				type: 'post',
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

	});
	/**
	 * 获取自动编号接口
	 * @param params (参数{autoNumber: 数据库表名, costType: 报销单类型})
	 * @param callback (回调函数)
	 */
	// function getAutoNumber(params, callback) {
	// 	$.ajaxSettings.async = false;
	// 	var loadIndex = layer.load();
	// 	$.get('/planningManage/autoNumber', params, function (res) {
	// 		layer.close(loadIndex);
	// 		callback(res);
	// 	});
	// 	$.ajaxSettings.async = true;
	// }


	function openRold(){ //流程转交下一步后会调用此方法
		//刷新表格
		tableIns.config.where._ = new Date().getTime();
		tableIns.reload();
	}
</script>
</body>
</html>
