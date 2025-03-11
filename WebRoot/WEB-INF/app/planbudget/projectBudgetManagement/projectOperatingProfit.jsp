<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/3
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
	<title>项目经营利润</title>

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
<%--	<script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
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
		#baseForm .layui-col-xs6{
			width: 25%;
		}
		#baseForm .layui-form-label {
			width: auto;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">项目经营利润</h2>
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
					<button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>
				</div>
				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box" style="display: none">
					<table id="tableObj" lay-filter="tableObj"></table>
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
		<%--<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">分解子项目</button>--%>
		<%--				<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>--%>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
	</div>
	<%--<div style="position:absolute;top: 10px;right:60px;">
		<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
	</div>--%>
</script>

<script type="text/html" id="toolBar">
	{{#  if(!d.child|| d.child.length<1){ }}
	<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
	<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
	{{#  } }}

</script>

<script>
	var user_id = '';
	var dept_id = '';
	var projectIds = '';
	var form
	var insTb
	var tipIndex = null
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text');
		tipIndex = layer.tips(tip, this);
	}, function () {
		layer.close(tipIndex);
	});

	// 表格显示顺序
	var colShowObj = {
		wbsNo: {field: 'wbsNo', title: '子项目编码', sort: true, hide: false},
		wbsName: {field: 'wbsName', title: '子项目名称', sort: true, hide: false},
		projName: {field: 'projName', title: '所属项目', sort: true, hide: false},
		approvalStatus: {
			field: 'approvalStatus',
			title: '审批状态',
			sort: true,
			hide: false,
			templet: function (d) {
				if (d.approvalStatus == 1) {
					return '<span style="color: orange">审批中</span>';
				} else if (d.approvalStatus == 2) {
					return '<span style="color: green">批准</span>';
				} else if (d.approvalStatus == 3) {
					return '<span style="color: red">不批准</span>';
				} else {
					return '未提交';
				}
			}
		},
		wbsLevel: {
			field: 'wbsLevel', title: '子项目层级', sort: true, hide: false, templet: function (d) {
				return dictionaryObj['WBS_LEVEL']['object'][d.wbsLevel] || '';
			}
		}
		// dutyDept: {
		//     field: 'dutyDept', title: '责任部门', sort: true, hide: false, templet: function (d) {
		//         return isShowNull(d.dutyDeptName);
		//     }
		// },
		// dutyUser: {
		//     field: 'dutyUser', title: '责任人', sort: true, hide: false, templet: function (d) {
		//         return isShowNull(d.dutyUserName).replace(/,$/, '');
		//     }
		// },
		// dutyUserTel: {
		//     field: 'dutyUserTel', title: '责任人电话', sort: false, hide: false
		// },
		// buildUnit: {
		//     field: 'buildUnit', title: '建设单位', sort: true, hide: false, templet: function (d) {
		//     	return isShowNull(d.buildUnitName);
		// 	}
		// }
	}

	var TableUIObj = new TableUI('plb_proj_wbs');

	// 获取数据字典数据
	var dictionaryObj = {
		WBS_LEVEL: {},
		PBAG_NATURE: {},
		PBAG_TYPE: {},
		CUSTOMER_UNIT: {},
	}
	var dictionaryStr = 'WBS_LEVEL,PBAG_NATURE,PBAG_TYPE,CUSTOMER_UNIT';
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

	layui.use(['form', 'laydate', 'eleTree', 'xmSelect', 'treeTable', 'table'], function () {
		var layForm = layui.form,
				laydate = layui.laydate,
				eleTree = layui.eleTree,
				treeTable = layui.treeTable,
				layTable = layui.table,
				xmSelect = layui.xmSelect;

		var tableObj = null;

		TableUIObj.init(colShowObj, function () {
			$('.no_data').hide();
			$('.table_box').show();
			tableInit();
		});

		layForm.render();

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
				$('#leftId').attr('decomposeLevel', currentData.decomposeLevel);
				$('#leftId').attr('contractStartDate', currentData.contractStartDate || '');
				$('#leftId').attr('contractEndDate', currentData.contractEndDate || '');
				$('.no_data').hide();
				$('.table_box').show();
				tableInit(currentData.projId);
			} else {
				$('#leftId').attr('projId', '');
				$('#leftId').attr('decomposeLevel', '');
				$('#leftId').attr('contractStartDate', '');
				$('#leftId').attr('contractEndDate', '');
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 监听筛选列
		var checkboxTimer = null;
		layForm.on('checkbox()', function (data) {
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
					var param = {showFields: JSON.stringify(arr)}
					TableUIObj.update(param);
				}, 1000);
			}
		});

		// 监听排序事件
		treeTable.on('sort(tableObj)', function (obj) {
			var param = {
				orderbyFields: obj.field,
				orderbyUpdown: obj.type
			}

			TableUIObj.update(param, function () {
				tableInit($('#leftId').attr('projId') || '');
			})
		});
		// 监听列表头部按钮事件
		treeTable.on('toolbar(tableObj)', function (obj) {
			var checkStatus = tableObj.checkStatus();
			switch (obj.event) {
				/*case 'add': // 新增
					if (!$('#leftId').attr('projId')) {
						layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
						return false;
					}
					addOrEdit(1);
					break;*/
				case 'del': // 删除
					layer.msg('删除');
					if (checkStatus.length == 0) {
						layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
						return false;
					}

					var wbsIds = '';

					checkStatus.forEach(function (item) {
						if (!(item.approvalStatus > 0)) {
							wbsIds += item.wbsId + ',';
						}
					});
					layer.confirm('确定删除选中数据吗？', function (index) {
						$.get('/plbProjWbs/deleteByWbsIds', {wbsIds: wbsIds}, function (res) {
							layer.close(index)
							if (res.flag) {
								layer.msg('删除成功！', {icon: 1});
								tableObj.options.where._ = new Date().getTime();
								tableObj.reload();
							} else {
								layer.msg('删除失败！', {icon: 2});
							}
						});
					});
					break;
				case 'submit': // 提交审批
					if (checkStatus.length != 1) {
						layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 1500});
						return false;
					}
					if (checkStatus[0].approvalStatus > 0) {
						layer.msg('不可重复提交！', {icon: 0});
						return false;
					}
					var wbsData = checkStatus[0];
					layer.open({
						type: 1,
						title: '选择流程',
						area: ['70%', '80%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
						success: function () {
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '35'}, function (res) {
								var flowData = []
								if (res.data && res.data.flowData) {
									$.each(res.data.flowData, function (k, v) {
										flowData.push({
											flowId: k,
											flowName: v
										});
									});
								}
								layTable.render({
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
							var checkFlow = layTable.checkStatus('flowTable');
							if (checkFlow.data.length > 0) {
								var flowData = checkFlow.data[0];
								newWorkFlow(flowData.flowId, JSON.stringify(wbsData), function (res) {
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.get('/plbProjWbs/updatePlbProjWbs', {
										wbsId: wbsData.wbsId,
										runId: res.flowRun.runId,
										approvalStatus: '1'
									}, function (res) {
										layer.closeAll();
										if (res.flag) {
											layer.msg('提交审批成功！', {icon: 1});
											tableObj.config.where._ = new Date().getTime();
											tableObj.reload();
										} else {
											layer.msg('提交审批失败！', {icon: 2});
										}
									});
								});
							} else {
								layer.close(loadIndex);
								layer.msg('请选择一项！', {icon: 0});
							}
						}
					});
					break;
			}
		});
		treeTable.on('tool(tableObj)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'detail') {
				$.get('/managerObjectives/getByWbsId', {wbsId: data.wbsId,projId:$('#leftId').attr('projId')}, function (res) {
					if (res.code=='0') {
						addOrEdit(3, res.obj);
					} else {
						layer.msg('获取信息失败！', {icon: 0});
					}
				});
			} else if (layEvent === 'edit') {
				$.get('/managerObjectives/getByWbsId', {wbsId: data.wbsId,projId:$('#leftId').attr('projId')}, function (res) {
					if (res.code=='0') {
						addOrEdit(2, res.obj,data.wbsId);
					} else {
						layer.msg('获取信息失败！', {icon: 0});
					}
				});
			}
		});

		function tableInit(projId) {
			var searchObj = getSearchObj();
			searchObj.projId = !!projId ? projId : '';
			searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
			searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

			var cols = [{type: 'checkbox'},].concat(TableUIObj.cols);

			cols.push({
				fixed: 'right',
				align: 'center',
				toolbar: '#toolBar',
				title: '操作',
				width: 140
			});

			tableObj = treeTable.render({
				elem: '#tableObj',
				url: '/plbProjWbs/getPlbProjWbsByProjId',
				where: searchObj,
				toolbar: '#toolbarHead',
				defaultToolbar: ['filter'],
				tree: {
					iconIndex: 1,
					idName: 'wbsId',
					childName: "child"
				},
				cols: cols,
				height: 'full-80',
				parseData: function (res) { //res 即为原始返回的数据
					return {
						"code": 0, //解析接口状态
						"data": res.data //解析数据列表
					};
				},
				initSort: {
					field: TableUIObj.orderbyFields,
					type: TableUIObj.orderbyUpdown
				}
			});
		}

		/**
		 * 新增、编辑方法
		 * @param type 类型(1-新增，2-编辑)
		 * @param data 编辑时的信息
		 */
		function addOrEdit(type, data,wbsId) {
			var title = '';
			var url = '';
			var btnArr = ['保存', '取消'];
			var projId = $('#leftId').attr('projId');
			 if (type == 2) {
				title = '编辑';
				url = '/managerObjectives/updateByWbsId';
			} else if (type == 3) {
				title = '查看详情';
				btnArr = ['确定'];
			}


			layer.open({
				type: 1,
				title: title,
				area: ['90%', '90%'],
				btn: btnArr,
				btnAlign: 'c',
				content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
					'<form class="layui-form" id="baseForm" lay-filter="baseForm">',
					/* region 第一行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label ">预算编号<span field="manageObjectivesNo" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly name="manageObjectivesNo" style="background-color: #e7e7e7;" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label ">项目名称<span field="projectName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly name="projectName" id="projectName" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label ">预算名称<span field="manageObjectivesName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly name="manageObjectivesName" style="background-color: #e7e7e7;" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label">编制日期<span field="writeDate" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="writeDate"  autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第二行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label ">经营目标收入金额</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="objectivesIncomeAmount" autocomplete="off"  class="layui-input ">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label ">经营目标利润金额</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text"  name="objectivesProfitAmount" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label ">经营目标说明</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="manageObjectivesRemarks" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label">备注</label>' +
					'<div class="layui-input-block form_block">' +
					'<textarea name="memo" placeholder="请输入内容" class="layui-textarea" style="height: 38px;min-height: 38px"></textarea>' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第三行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs12" style="padding: 0 5px;">' +
					'<div class="layui-form-item">\n' +
					'<label class="layui-form-label form_label">经营目标附件</label>' +
					'<div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload" data-url="/upload?module=manageObjectvies " name="file">' +
					'</a>' +
					'<div class="progress" id="progress">' +
					'<div class="bar"></div>\n' +
					'</div>' +
					'<div class="bar_text"></div>' +
					'</div>' +
					'</div>' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					'</form>',
					'</div>'].join(''),
				success: function () {
					if(projId){
						//回显项目名称
						getProjName('#projectName',projId)
					}
					fileuploadFn('#fileupload', $('#fileContent'));
					if(type=='2'||type=='3'){
						layForm.val("baseForm", data);

						if (data.attachmentList && data.attachmentList.length > 0) {
							var fileArr = data.attachmentList;
							var str = '';
							for (var i = 0; i < fileArr.length; i++) {
								var fileExtension = fileArr[i].attachName.substring(fileArr[i].attachName.lastIndexOf(".") + 1, fileArr[i].attachName.length);//截取附件文件后缀
								var attName = encodeURI(fileArr[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
								var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
								var deUrl = fileArr[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + fileArr[i].size;

								/*str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';*/
								str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + fileArr[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img  src="/img/attachment_icon.png"/>' + fileArr[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',">' +
										'<a fileExtension="'+fileExtension+'" onclick="pdurls($(this))"   href="javascript:;"  style="padding-left: 5px"><img src="/img/attachmentIcon/icon_skim.png" style="padding: 0 5px;">查阅</a>' +
										'<a style="padding-left: 5px" href="/download?'+encodeURI(deUrl)+'" ><img src="/img/attachmentIcon/icon_down.png"  style="padding: 0 5px;">下载</a><input type="hidden" class="inHidden" value="' + fileArr[i].aid + '@' + fileArr[i].ym + '_' + fileArr[i].attachId + ',"></div>';
							}
							$('#fileContent').append(str);
						}
						//查看详情
						if(type=='3'){
							$('#baseForm input,textarea').attr('disabled', 'disabled');
							$('.file_upload_box').hide()
							$('.deImgs').hide()
						}
					}
					laydate.render({
						elem: 'input[name="writeDate"]' //指定元素
						,trigger: 'click' //采用click弹出
						,format: 'yyyy-MM-dd'
					});


					layForm.render();
				},
				yes: function (index) {
					if(type=='2'){
						var loadIndex = layer.load();

						var datas = $('#baseForm').serializeArray();
						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value
						});

						// 附件
						var attachmentId = '';
						var attachmentName = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName += $('#fileContent a').eq(i).attr('name');
						}
						obj.attachmentId = attachmentId;
						obj.attachmentName = attachmentName;


						// 判断必填项
						var requiredFlag = false;
						$('.layer_wrap').find('.field_required').each(function () {
							var field = $(this).attr('field');
							if (!obj[field] && obj[field] != '0') {
								var fieldName = $(this).parent().text().replace('*', '');
								layer.msg(fieldName + '不能为空！', {icon: 0, time: 2000});
								requiredFlag = true;
								return false;
							}
						});

						if (requiredFlag) {
							layer.close(loadIndex);
							return false;
						}

						if (type == 2) {
							obj.wbsId = wbsId;
						} else {
							obj.projId = projId;
						}

						$.ajax({
							url: url,
							data: JSON.stringify(obj),
							dataType: 'json',
							type: 'post',
							contentType: "application/json;charset=UTF-8",
							success: function (res) {
								layer.close(loadIndex);
								if (res.code=='0') {
									layer.msg('保存成功！', {icon: 1});
									layer.close(index);
									/*tableObj.options.where._ = new Date().getTime();
									tableObj.reload();*/
								} else {
									layer.msg(res.msg, {icon: 2});
								}
							}
						});
					}else {
						layer.close(index);
					}

				}
			});
		}

		// 查询
		$('#searchBtn').on('click', function () {
			tableInit($('#leftId').attr('projId') || '');
		});

		/**
		 * 获取查询条件
		 * @returns {}
		 */
		function getSearchObj() {
			var searchObj = {
				wbsNo: $('input[name="wbsNo"]', $('.query_module')).val(),
				wbsName: $('input[name="wbsName"]', $('.query_module')).val(),
				approvalStatus: $('select[name="approvalStatus"]', $('.query_module')).val(),
			}

			return searchObj
		}

		// 高级查询
		$('#advancedQuery').on('click', function () {
			layer.msg('功能完善中')
		});
	});

	/**
	 * 利用引用类型特性过滤树结构指定id和层级节点及其子节点
	 * @param data (树形数据)
	 * @param filterId (过滤的ID)
	 * @returns {[]}
	 */
	function filterTreeData(data, filterId, wbsLevel) {
		if (!!data && data.length > 0) {
			for (var i = 0; i < data.length; i++) {
				if ((!!filterId ? filterId != data[i].wbsId : true) && parseInt(wbsLevel) > parseInt(data[i].wbsLevel)) {
					if (data[i].child && data[i].child.length > 0) {
						filterTreeData(data[i].child, filterId, wbsLevel);
					}
				} else {
					data.splice(i, 1);
					i--;
				}
			}
		}
	}

	//判断是否该为空
	function isUndefined(data) {
		if(data==1){
			return '是'
		}else if(data==0){
			return '否'
		}else{
			return ''
		}
	}

	/**
	 * 选人控件完成回调
	 * @param userId
	 */
	function archives (userId) {
		userId = userId.replace(/,$/, '');
		$.get('/user/findUserByuserId', {userId: userId}, function (res) {
			if (res.flag) {
				$('#baseForm [name="dutyUserTel"]').val(res.object.mobilNo);
			}
		});
	}

	/**
	 * 新建流程方法
	 * @param flowId
	 * @param approvalData
	 * @param cb
	 */
	function newWorkFlow(flowId, approvalData, cb) {
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
				isBudgetFlow: true, // 是否为预算审批流
				// urlParameter: urlParameter, // 封装所有参数 (内嵌页面)
				// approvalType: '05', // 预算关联审批页面【数据字典配置】(内嵌页面)
				approvalData: approvalData, // (tab页面)
				isTabApproval: true // 是否为tab方式打开
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
</script>
</body>
</html>
