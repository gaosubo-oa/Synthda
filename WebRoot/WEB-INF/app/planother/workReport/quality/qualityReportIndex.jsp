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
	<title>质量月报 </title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

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
	<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>

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
			<h2 style="text-align: center;line-height: 35px;">质量月报 </h2>
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
<%--				<div class="layui-col-xs2" style="margin-left: 15px;">--%>
<%--					<input type="text" name="optimizationName" placeholder="优化名称" autocomplete="off" class="layui-input">--%>
<%--				</div>--%>
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

<script type="text/html" id="barPlan">
	<div class="layui-btn-container" style="height: 30px;">
		<a class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</a>
	</div>
</script>

<script type="text/html" id="toolbarPlan">
	<div class="layui-btn-container" style="height: 30px;">
		<a class="layui-btn layui-btn-sm" lay-event="choice">选择</a>
	</div>
</script>

<script>

	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});
	

	var tableIns = null;
	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;
		var soulTable = layui.soulTable;


		form.render();
		//表格显示顺序
		var colShowObj = {
			documentNo: {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false,templet: function (d) {
					return '<span securityReportId="'+d.securityReportId+'">'+(d.documentNo||'')+'</span>'
				}},
			projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
			createYear: {field: 'createYear', title: '填报年', minWidth: 120,sort: true, hide: false},
			createMonth: {field: 'createMonth', title: '填报月', minWidth: 120,sort: true, hide: false},
			createUserName: {field: 'createUserName', title: '填报人', minWidth: 120,sort: true, hide: false},
			memo: {field: 'memo', title: '月度质量情况说明', minWidth: 120,sort: true, hide: false},
			// currFlowUserName: {field: 'currFlowUserName', title: '当前处理人',minWidth: 130, sort: false, hide: false},
			// auditerStatus: {
			// 	field: 'auditerStatus',
			// 	title: '审核状态',
			// 	minWidth: 120,
			// 	sort: true,
			// 	hide: false,
			// 	templet: function (d) {
			// 		var str = '';
			// 		switch (d.auditerStatus) {
			// 			case '0':
			// 				str = '未提交';
			// 				break;
			// 			case '1':
			// 				var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
			// 				str = '<span class="preview_flow" style="color: orange;cursor: pointer;text-decoration: underline;" ' + flowStr + '>审批中</span>';
			// 				break;
			// 			case '2':
			// 				var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
			// 				str = '<span class="preview_flow" style="color: green;cursor: pointer;text-decoration: underline;" ' + flowStr + '>批准</span>';
			// 				break;
			// 			case '3':
			// 				var flowStr = d.flowRun ? 'flowId="' + (d.flowRun.flowId || '') + '" runId="' + (d.flowRun.runId || '') + '"' : '';
			// 				str = '<span class="preview_flow" style="color: red;cursor: pointer;text-decoration: underline;" ' + flowStr + '>不批准</span>';
			// 				break;
			// 		}
			// 		return str;
			// 	}
			// }
		}

		var dictionaryObj = {
			CHECK_FREQUENCY:{}
		}
		var dictionaryStr = 'CHECK_FREQUENCY';
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

		var TableUIObj = new TableUI('plb_other_optimization_scheme');


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
						var securityReportId = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span').attr('securityReportId')
						var loadIndex = layer.load();
						$.get('/qualityReport/getById', {kayId:securityReportId}, function (res) {

							newOrEdit(1,res.obj)
							layer.close(loadIndex);
						});
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
					var securityReportId = ''
					var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span')
					$trs.each(function(){
						securityReportId += $(this).attr('securityReportId') + ','
					})
					// checkStatus.data.forEach(function (v, i) {
					// 	securityReportId += v.securityReportId + ','
					// })
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/qualityReport/del', {ids: securityReportId}, function (res) {
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
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '68'}, function (res) {
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
								approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
								approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
								newWorkFlow(flowData.flowId, function (res) {
									var submitData = {
										securityReportId:approvalData.securityReportId,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/qualityReport/updateById',
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
			var securityReportId = $(obj.tr.selector).find('[data-field="documentNo"] span').attr('securityReportId')
			if(layEvent === 'detail'){
				var loadIndex = layer.load();
				$.get('/qualityReport/getById', {kayId:securityReportId}, function (res) {

					newOrEdit(4,res.obj)
					layer.close(loadIndex);
				});
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
				url: '/qualityReport/select',
				toolbar: '#toolbarDemo',
				cols: [cols],
				defaultToolbar: ['filter'],
				// height: 'full-80',
				page: {
					limit: TableUIObj.onePageRecoeds,
					limits: [10, 20, 30, 40, 50]
				},
				where: {
					projId: projId,
					projectId: projId,
					delFlag: '0'
					//orderbyFields: upperFieldMatch(TableUIObj.orderbyFields),
					//orderbyUpdown: TableUIObj.orderbyUpdown
				},
				autoSort: false,
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
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			var projectId = $('#leftId').attr('projId');
			if (type == '0') {
				title = '新建质量月报 ';
				url = '/qualityReport/insert';
			} else if (type == '1') {
				title = '编辑质量月报 ';
				url = '/qualityReport/updateById';
			}else if(type == '4'){
				title = '查看详情'
			}

			var _securityReportId = null

			layer.open({
				type: 1,
				title: title,
				area: ['100%', '100%'],
				btn: type != '4'?['保存','提交审批', '取消']:['确定'],
				btnAlign: 'c',
				content: ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
					'<div class="layui-collapse">\n' +
					/* region 基本内容 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">基本内容</h2>\n' +
					'    <div class="layui-colla-content layui-show plan_base_info">' +
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
					'                       <label class="layui-form-label form_label">填报年<span field="createYear" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="createYear" id="createYear"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">填报月<span field="createMonth" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					' 							<select name="createMonth" id="createMonth" lay-filter="test">' +
					' 								 <option value="">请选择月份</option>\n' +
					' 								 <option value="1">1月</option>\n' +
					'                                <option value="2">2月</option>\n' +
					'                                <option value="3">3月</option>\n' +
					'                                <option value="4">4月</option>\n' +
					'                                <option value="5">5月</option>\n' +
					'                                <option value="6">6月</option>\n' +
					'                                <option value="7">7月</option>\n' +
					'                                <option value="8">8月</option>\n' +
					'                                <option value="9">9月</option>\n' +
					'                                <option value="10">10月</option>\n' +
					'                                <option value="11">11月</option>\n' +
					'                                <option value="12">12月</option>' +
					'  							</select>' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">填报人<span field="createUserName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="createUserName" readonly autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>' ,
					'  			<div class="layui-row">' +
					'  			    <div class="layui-col-xs12" style="padding: 0 5px;">' +
					'  			        <div class="layui-form-item">\n' +
					'  			            <label class="layui-form-label form_label">月度质量情况说明<span field="memo" class="field_required">*</span></label>\n' +
					'  			            <div class="layui-input-block form_block">\n' +
					'  			 				<textarea type="text" name="memo" style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>' +
					'  			            </div>\n' +
					'  			        </div>' +
					'  			    </div>' +
					'  			</div>',
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
					'<input type="file" multiple id="fileupload" data-url="/upload?module=qualityReport" name="file">' +
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
					'    </div>\n' +
					'  </div>\n' +
					/* endregion */
					/*'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">下月检查计划安排</h2>\n' +
					'    <div class="layui-colla-content layui-show security_planning">' +
					'		<table id="securityTable" lay-filter="securityTable"></table>' +
					'    </div>\n' +
					'  </div>\n' +*/
					/* endregion */
					'</div>'+
					'</form>'].join(''),
				success: function () {

					var cols = [
						{type: 'numbers', title: '序号'},
						{field: 'securityKnowledgeName', title: '检查项名称', minWidth: 160},
						/*{field: 'mainDifficulties', title: '主要难点', minWidth: 160},
                        {field: 'mainRisk', title: '主要风险', minWidth: 160},
                        {field: 'riskSolutions', title: '风险解决措施', minWidth: 160},*/
						{field: 'personLiableName', title: '责任人', minWidth: 160},
						{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
								return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
							}},
						{field: 'solutions', title: '检查项描述', minWidth: 160},
						{field: 'securityKnowledgeName', title: '检查详细内容',minWidth: 150, templet: function (d) {
								return '<span securityTermId="'+(d.securityTermId || '')+'" class="securityKnowledgeName chooseMaterials"  style="cursor: pointer;color: blue;">' + (d.securityKnowledgeName || '') + '</span>'
							}}
					]
					laydate.render({
						elem: '#createYear'
						, trigger: 'click'//呼出事件改成click
						, type: 'year'
						// , format: 'yyyy-MM-dd'
						, done: function(value){
							if(value&&$('#createMonth').val()){
								$.ajax({
									url: '/qualityReport/select',
									type: 'post',
									dataType: 'json',
									data:{
										delFlag: '0',
										createYear:value,
										createMonth:$('#createMonth').val(),
										projectId:projectId?projectId:data.projectId
									},
									success: function (res) {
										if(res&&res.data&&res.data.length>0){

											_securityReportId = res.data[0].securityReportId

											layer.msg('本月已填报，请直接编辑！', {icon: 0, time: 2000});

											form.val("formTest", res.data[0]);
											//附件
											/*if (data.attachmentList && data.attachmentList.length > 0) {
												var fileArr = data.attachmentList;
												$('#fileContent').append(echoAttachment(fileArr));
											}*/
										}else{
											var _createMonth = $('#createMonth').val()
											$("#baseForm")[0].reset()
											// $('#fileContent').empty()

											$('#createYear').val(value)
											$('#createMonth').val(_createMonth)
											// 获取自动编号
											getAutoNumber({autoNumberType: 'securityReport'}, function(res) {
												$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
												$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
											});
											$('.refresh_no_btn').show().on('click', function() {
												getAutoNumber({autoNumberType: 'securityReport'}, function(res) {
													$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
													$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
												});
											});
											getProjName('#projectName',projectId?projectId:data.projectId)
										}

									}
								})

								/*$.get('/qualityCycleAnalysis/getQualityPlan',
										{
											year:value,
											month:$('#createMonth').val(),
											projectId:projectId?projectId:data.projectId
										},
										function (res) {

											table.render({
												elem: '#securityTable',
												data: res&&res.obj&&res.obj.beforeSecurityDetailsList||[],
												height: res&&res.obj&&res.obj.beforeSecurityDetailsList&&res.obj.beforeSecurityDetailsList.length>5?'full-350':false,
												// toolbar: type==4?false:'#toolbarPlan',
												defaultToolbar: [''],
												limit: 1000,
												cols: [cols],
											});
										});*/

							}
						}
					});

					form.on('select(test)', function(data){
						console.log(data.value); //得到被选中的值
						var _value = data.value
						if($('#createYear').val()&&data.value){
							$.ajax({
								url: '/qualityReport/select',
								type: 'post',
								dataType: 'json',
								data:{
									delFlag: '0',
									createYear:$('#createYear').val(),
									createMonth:data.value,
									projectId:projectId?projectId:data.projectId
								},
								success: function (res) {
									if(res&&res.data&&res.data.length>0){

										_securityReportId = res.data[0].securityReportId

										layer.msg('本月已填报，请直接编辑！', {icon: 0, time: 2000});

										form.val("formTest", res.data[0]);
										//附件
										if (data.attachmentList && data.attachmentList.length > 0) {
											var fileArr = data.attachmentList;
											$('#fileContent').append(echoAttachment(fileArr));
										}
									}else{
										var _createYear = $('#createYear').val()
										$("#baseForm")[0].reset()
										// $('#fileContent').empty()
										$('#createYear').val(_createYear)
										$('#createMonth').val(_value)
										// 获取自动编号
										getAutoNumber({autoNumberType: 'securityReport'}, function(res) {
											$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
											$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
										});
										$('.refresh_no_btn').show().on('click', function() {
											getAutoNumber({autoNumberType: 'securityReport'}, function(res) {
												$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
												$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
											});
										});
										getProjName('#projectName',projectId?projectId:data.projectId)
									}

								}
							})

							/*$.get('/qualityCycleAnalysis/getQualityPlan',
									{
										year:$('#createYear').val(),
										month:data.value,
										projectId:projectId?projectId:data.projectId
									},
									function (res) {

										table.render({
											elem: '#securityTable',
											data: res&&res.obj&&res.obj.beforeSecurityDetailsList||[],
											height: res&&res.obj&&res.obj.beforeSecurityDetailsList&&res.obj.beforeSecurityDetailsList.length>5?'full-350':false,
											// toolbar: type==4?false:'#toolbarPlan',
											defaultToolbar: [''],
											limit: 1000,
											cols: [cols],
										});
									});*/

						}
					});

					fileuploadFn('#fileupload', $('#fileContent'));
					//回显项目名称
					getProjName('#projectName',projectId?projectId:data.projectId)

					//回显数据
					if (type == 1 || type == 4) {
						form.val("formTest", data);

						//附件
						if (data.attachmentList && data.attachmentList.length > 0) {
							var fileArr = data.attachmentList;
							$('#fileContent').append(echoAttachment(fileArr));
						}

						/*$.get('/qualityCycleAnalysis/getQualityPlan',
								{
									year:data.createYear,
									month:data.createMonth,
									projectId:projectId?projectId:data.projectId
								},
								function (res) {

									table.render({
										elem: '#securityTable',
										data: res&&res.obj&&res.obj.beforeSecurityDetailsList||[],
										height: res&&res.obj&&res.obj.beforeSecurityDetailsList&&res.obj.beforeSecurityDetailsList.length>5?'full-350':false,
										// toolbar: type==4?false:'#toolbarPlan',
										defaultToolbar: [''],
										limit: 1000,
										cols: [cols],
									});
								});*/
					}else{
						// 获取自动编号
						getAutoNumber({autoNumberType: 'qualityReport'}, function(res) {
								$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
								$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
							});
						$('.refresh_no_btn').show().on('click', function() {
							getAutoNumber({autoNumberType: 'qualityReport'}, function(res) {
								$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
								$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
							});
						});
					}


					//查看详情
					if(type==4){
						$('._disabled [name]').attr('disabled', 'disabled');
						$('.refresh_no_btn').hide();
						// $('.file_upload_box').hide()
						// $('.deImgs').hide();
					}

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

						obj.createUser = $('input[name="createUserName"]').attr('createUser');

						// 附件
						var attachmentId = '';
						var attachmentName = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
						}
						obj.attachmentId = attachmentId;
						obj.attachmentName = attachmentName;

						obj.projectId = $('#leftId').attr('projId');


						if(type == '1'||_securityReportId){
							obj.securityReportId= data.securityReportId||_securityReportId;
							url = '/qualityReport/updateById';
						}

						// obj.detailsList = planningDetailsData().securityData;

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


					obj.createUser = $('input[name="createUserName"]').attr('createUser');

					// 附件
					var attachmentId = '';
					var attachmentName = '';
					for (var i = 0; i < $('#fileContent .dech').length; i++) {
						attachmentId += $('#fileContent .dech').eq(i).find('input').val();
						attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
					}
					obj.attachmentId = attachmentId;
					obj.attachmentName = attachmentName;

					obj.projectId = $('#leftId').attr('projId');


					if(type == '1'||_securityReportId){
						obj.securityReportId= data.securityReportId||_securityReportId;
						url = '/qualityReport/updateById';
					}


					// obj.detailsList = planningDetailsData().securityData;

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
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '68'}, function (res) {
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
													securityReportId:approvalData.securityReportId,
													runId: res.flowRun.runId,
													//manageProjStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/qualityReport/updateById',
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
		//质量 检查详细内容
		$(document).on('click', '.chooseMaterials', function () {
			var loadIndex = layer.load();
			$.post('/qualityTerm/getById', {kayId: $(this).attr('securityTermId')}, function (res) {
				new_Edit(res.obj)
				layer.close(loadIndex);
			})
		})

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
							$('.deImgs').hide();
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

		// 质量策划-选择
		// table.on('toolbar(securityTable)', function (obj) {
		// 	switch (obj.event) {
		// 		case 'choice':
		// 			layer.open({
		// 				type: 1,
		// 				title: '选择质量检查计划',
		// 				area: ['80%', '80%'],
		// 				btn: ['确定', '取消'],
		// 				btnAlign: 'c',
		// 				content: ['<div class="layui-form" style="padding:0px 10px">' +
		// 				'<div class="query_module layui-form layui-row" style="padding:10px">\n' +
		// 				'                <div class="layui-col-xs2">\n' +
		// 				'                    <input type="text" name="documentNo" placeholder="单据号" autocomplete="off" class="layui-input">\n' +
		// 				'                </div>\n' +
		// 				'                <div class="layui-col-xs2" style="margin-left: 10px">\n' +
		// 				'                    <input type="text" name="securityPlanName" id="" placeholder="检查计划名称" autocomplete="off" class="layui-input">\n' +
		// 				'                </div>\n' +
		// 				'                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
		// 				'                    <button type="button" class="layui-btn layui-btn-sm InSearchData">查询</button>\n' +
		// 				'                </div>\n' +
		// 				'</div>' +
		// 				'<div>' +
		// 				'     <table id="tableDemoIn" lay-filter="tableDemoIn"></table>\n' +
		// 				'     <div id="downBox">\n' +
		// 				'         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
		// 				'      </div>' +
		// 				'</div>' +
		// 				'</div>'].join(''),
		// 				success: function () {
		// 					var tableDemoIn=table.render({
		// 						elem: '#tableDemoIn',
		// 						url: '/qualityPlan/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
		// 						cols: [[
		// 							{field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
		// 							{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
		// 							{field: 'securityPlanName', title: '检查计划名称', minWidth: 120,sort: true, hide: false},
		// 							// {field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
		// 							// {field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
		// 							{field: 'planMemo', title: '计划描述',minWidth: 120, sort: true, hide: false}
		// 						]],
		// 						// height: 'full-430',
		// 						page: true
		// 					});
		// 					$('.InSearchData').click(function(){
		// 						var documentNo=$('[name="documentNo"]').val();
		// 						var securityPlanName=$('[name="securityPlanName"]').val();
		// 						tableDemoIn.reload({
		// 							where:{
		// 								documentNo:documentNo,
		// 								securityPlanName:securityPlanName
		// 							}
		// 						})
		// 					})
		// 				},
		// 				yes: function (index) {
		//
		// 					var checkStatus = table.checkStatus('tableDemoInDown'); //获取选中行状态
		// 					var datas = checkStatus.data;  //获取选中行数据
		//
		// 					//判断是否选择数据
		// 					if (datas.length == 0) {
		// 						layer.msg('请选择一项！', {icon: 0});
		// 						return false
		// 					}
		//
		// 					//遍历表格获取每行数据进行保存
		// 					var dataArr = planningDetailsData().securityData;
		//
		// 					datas.forEach(function (item) {
		// 						if(dataArr){
		// 							var _flag = true
		// 							for(var j=0;j<dataArr.length;j++){
		// 								if(dataArr[j].securityPlanDetailsId==item.securityPlanDetailsId){
		// 									_flag = false
		// 								}
		// 							}
		// 							if(_flag){
		// 								dataArr.push(item)
		// 							}
		// 						}else{
		// 							dataArr.push(item)
		// 						}
		// 					})
		// 					table.reload('securityTable', {
		// 						data: dataArr,
		// 						height: dataArr&&dataArr.length>5?'full-350':false
		// 					});
		// 					layer.close(index)
		// 				},
		// 			})
		// 			break;
		// 	}
		// });

		//监听行单击事件
		/*table.on('row(tableDemoIn)', function (obj) {
			// console.log(obj.data) //得到当前行数据
			var data = obj.data
			$('#downBox').show()
			obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
			tableShowDown(data.details)
		});

		//质量检查计划明细表
		function tableShowDown(data) {
			table.render({
				elem: '#tableDemoInDown',
				data: data,
				cellMinWidth:150,
				cols: [[
					{type: 'checkbox'},
					{field: 'securityPlanName', title: '检查名称',minWidth: 150},
					{field: 'inspectionContent', title: '检查内容',minWidth: 150},
					{field: 'mainDifficulties', title: '主要难点',minWidth: 150},
					{field: 'mainRisk', title: '主要风险',minWidth: 150},
					{field: 'riskSolutions', title: '风险解决措施',minWidth: 150},
					{field: 'personLiableName', title: '责任人',minWidth: 150},
					// {field: 'checkFrequency', title: '检查频率',minWidth: 150},
					// {field: 'templteName', title: '检查详细内容',minWidth: 150}
				]],
				// height: 'full-430',
				page: true,
				done:function(res){
					var oldDataArr = planningDetailsData().securityData;
					var _dataa=res.data;
					if(oldDataArr!=undefined&&oldDataArr.length>0){
						for(var i = 0 ; i <_dataa.length;i++){
							for(var n = 0 ; n < oldDataArr.length; n++){
								if(_dataa[i].securityPlanDetailsId == oldDataArr[n].securityPlanDetailsId){
									$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
									//form.render('checkbox');
								}
							}
						}
					}

				}
			});
		}

		// 质量策划-删行
		table.on('tool(securityTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.securityReportListId) {
					$.get('/qualityReport/delDetails', {ids: data.securityReportListId}, function (res) {
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
		})*/

		/**
		 * 获取实施策划明细子表数据
		 */
		function planningDetailsData() {
			//质量策划
			var $trs = $('.security_planning').find('.layui-table-main tr');
			var dataArr = [];
			$trs.each(function () {
				var dataObj = {
					securityReportId: $(this).find('.securityPlanName').attr('securityReportId') || '',
					securityReportListId: $(this).find('.securityPlanName').attr('securityReportListId') || '',
					securityPlanDetailsId: $(this).find('.securityPlanName').attr('securityPlanDetailsId') || '',
					securityPlanName: $(this).find('.securityPlanName').text(),
					inspectionContent:$(this).find('[data-field="inspectionContent"] div').text(),
					mainDifficulties: $(this).find('[data-field="mainDifficulties"] div').text(),
					mainRisk: $(this).find('[data-field="mainRisk"] div').text(),
					riskSolutions: $(this).find('[data-field="riskSolutions"] div').text(),
					personLiableName: $(this).find('[data-field="personLiableName"] div').text(),
					// checkFrequency: $(this).find('.checkFrequency').attr('checkFrequency'),
					// templteName: $(this).find('[data-field="templteName"] div').text()
				}
				dataArr.push(dataObj);
			});


			return {
				securityData: dataArr,
			}
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
				async: false,//同步请求,这里使用ajax必须使用同步方式请求，因为浏览器认为这种打开在ajax后新页面是不质量的
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
	function getAutoNumber(params, callback) {
		$.get('/planningManage/autoNumber', params, function (res) {
			callback(res);
		});
	}


	function openRold(){ //流程转交下一步后会调用此方法
		//刷新表格
		tableIns.config.where._ = new Date().getTime();
		tableIns.reload();
	}
</script>
</body>
</html>
