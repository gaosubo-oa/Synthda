<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/2/5
  Time: 9:06
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
	<title>项目预算科目</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?20210527.1"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
	<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
	<script type="text/javascript" src="/js/common/fileupload.js"></script>
	<script type="text/javascript" src="/js/planbudget/common.js?20210527.1"></script>
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

		.refresh_no_btn {
			display: none;
			margin-left: 8%;
			color: #00c4ff !important;
			font-weight: 600;
			cursor: pointer;
		}

		.layui-select-disabled .layui-disabled {
			color: #222 !important;
		}

		.export_moudle {
			display: none;
			position: absolute;
			top: 100%;
			right: 0;
			width: 120px;
			padding: 10px;
			background-color: #fff;
			text-align: left;
			color: #222;
			box-shadow: 0 0px 1px 0px rgb(0 0 0 / 50%);
			opacity: 1 !important;
		}

		.export_moudle > p:hover {
			cursor: pointer;
			color: #1E9FFF;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">项目预算科目</h2>
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
					<input type="text" name="itemNo" placeholder="科目编号" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="itemName" placeholder="科目名称" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="wbsName" placeholder="WBS名称" autocomplete="off" class="layui-input">
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
					<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧子项目</p>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="toolbarHead">
	<div class="layui-btn-container" style="height: 30px;">
		{{#  if(isLast){ }}
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
		{{#  } }}
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
		{{#  if(isLast){ }}
		<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
		<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>
		{{#  } }}
		<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
		<div class="export_moudle">
			<p class="export_btn" type="1">导出所选数据</p>
			<p class="export_btn" type="2">导出当前页数据</p>
			<p class="export_btn" type="3">导出全部数据</p>
		</div>
	</div>
</script>

<script type="text/html" id="toolbarDemoIn">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
	</div>
</script>

<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script type="text/html" id="toolBar">
	{{#  if(isLast){ }}
	<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
	{{#  } }}
	<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
	var user_id = '';

	var isLast = false;

	var tipIndex = null
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text');
		tipIndex = layer.tips(tip, this);
	}, function () {
		layer.close(tipIndex);
	});

	// 表格显示顺序
	var colShowObj = {
		itemNo: {field: 'itemNo', title: '预算科目编号',minWidth:120, sort: true, hide: false},
		projName: {
			field: 'projName', title: '所属项目', minWidth:100,sort: true, hide: false,
		},
		wbsId: {
			field: 'wbsId', title: 'WBS',minWidth:150, hide: false, templet: function (d) {
				if (d.plbProjWbs && d.plbProjWbs.wbsName) {
					return d.plbProjWbs.wbsName;
				} else {
					return '';
				}
			}
		},
		rbsId: {
			field: 'rbsId', minWidth: 150, title: 'RBS', hide: false, templet: function (d) {
				if (d.plbRbs) {
					return d.plbRbs.rbsName || '';
				} else {
					return '';
				}
			}
		},
		cbsId: {
			field: 'cbsId', title: 'CBS',minWidth:100, hide: false, templet: function (d) {
				if (d.plbCbsTypeWithBLOBs && d.plbCbsTypeWithBLOBs.cbsName) {
					return d.plbCbsTypeWithBLOBs.cbsName;
				} else {
					return '';
				}
			}
		},
		itemUnit:{
			field:'itemUnit',minWidth:80,title:'单位',sort:false,hide:false,templet:function (d) {
				return dictionaryObj['CBS_UNIT']['object'][d.itemUnit]||'';
			}
		},
		controlType: {
			field: 'controlType', minWidth: 110, title: '控制类型', sort: true, hide: false, templet: function (d) {
				return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
			}
		},
		approvalStatusOpt: {
			field: 'approvalStatusOpt', title: '状态', minWidth:80,sort: true, hide: false, templet: function (d) {
				if (d.approvalStatusOpt == '1') {
					return '<span style="color: orange">审批中</span>';
				} else if (d.approvalStatusOpt == '2') {
					return '<span style="color: green">批准</span>';
				} else if (d.approvalStatusOpt == '3') {
					return '<span style="color: red">不批准</span>';
				} else {
					return '未提交';
				}
			}
		},
	}


	var TableUIObj = new TableUI('plb_budget_item');

	// 获取数据字典数据
	var dictionaryObj = {
		ITEM_TYPE: {},
		CONTROL_TYPE: {},
		CBS_UNIT: {}
	}
	var dictionaryStr = 'ITEM_TYPE,CONTROL_TYPE,CBS_UNIT';
	$.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
		if (res.flag) {
			for (var dict in dictionaryObj) {
				dictionaryObj[dict] = {object: {}, str: '<option value=""></option>'}
				if (res.object[dict]) {
					res.object[dict].forEach(function (item) {
						dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
						dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
					});
				}
			}
		}
	});

	layui.use(['form', 'laydate', 'table', 'soulTable', 'eleTree', 'xmSelect'], function () {
		var layForm = layui.form,
				laydate = layui.laydate,
				layTable = layui.table,
				soulTable = layui.soulTable,
				eleTree = layui.eleTree,
				xmSelect = layui.xmSelect;

		layForm.render();

		var tableObj = null;

		TableUIObj.init(colShowObj, function () {
			$('.no_data').hide();
			$('.table_box').show();
			tableInit();
		});

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
		 * @param deptName 项目名称
		 */
		function projectLeft(projectName) {
			projectName = projectName ? projectName : '';
			var loadingIndex = layer.load();
			$('.table_box').hide();
			$('.tishi').show();
			$.get('/plbProj/getProjTreeData', {projectName: projectName}, function (res) {
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
							children: "child",
						}
					});
				}
			});
		}

		// 树节点点击事件
		eleTree.on("nodeClick(leftTree)", function (d) {
			var currentData = d.data.currentData;
			if (currentData.wbsId) {
				$('#leftId').attr('projId', currentData.projId);
				$('#leftId').attr('wbsId', currentData.wbsId);
				$('#leftId').attr('wbsName', currentData.name);
				isLast = currentData.child ? false : true;
				$('.no_data').hide();
				$('.table_box').show();
				tableInit(currentData.wbsId);
			} else {
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 监听排序事件
		layTable.on('sort(tableObj)', function (obj) {
			var param = {
				orderbyFields: obj.field,
				orderbyUpdown: obj.type
			}

			TableUIObj.update(param, function () {
				tableInit($('#leftId').attr('wbsId') || '');
			});
		});
		// 监听筛选列
		var checkboxTimer = null;
		layForm.on('checkbox()', function (data) {
			//判断监听的复选框是筛选列下的复选框
			if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
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
		// 普通表格头部工具条事件监听
		layTable.on('toolbar(tableObj)', function (obj) {
			var checkStatus = layTable.checkStatus(obj.config.id);
			switch (obj.event) {
				case 'add':
					if (!$('#leftId').attr('wbsId')) {
						layer.msg('请选择左侧子项目！', {icon: 0, time: 2000});
						return false;
					}
					newOrEdit(1);
					break;
				case 'del':
					if (checkStatus.data.length == 0) {
						layer.msg('请选择需要删除的数据！', {icon: 0});
						return false
					}
					var budgetItemId = ''
					checkStatus.data.forEach(function (v) {
						budgetItemId += v.budgetItemId + ',';
					});
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/plbBudgetItem/delPlbBudgetItem', {budgetItemIds: budgetItemId}, function (res) {
							layer.close(index);
							if (res.flag) {
								layer.msg('删除成功！', {icon: 1});
								tableObj.config.where._ = new Date().getTime();
								tableObj.reload();
							} else {
								layer.msg('删除失败！', {icon: 2});
							}
						});
					});
					break;
				case 'export':
					$('.export_moudle').show();
					break;
				case 'submit':
					var loadIndex = layer.load();
					var projId = $('#leftId').attr('projId') || '';
					// approvalType 后台定义
					$.get('/plbProjBudget/judgeProjectApproval', {projId: projId, approvalType: '11'}, function (res) {
						layer.close(loadIndex);
						if (res.data) {
							layer.msg('该项目已提交！', {icon: 0});
						} else {
							layer.open({
								type: 1,
								title: '选择流程',
								area: ['70%', '80%'],
								btn: ['确定', '取消'],
								btnAlign: 'c',
								content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
								success: function () {
									// 数据字典  FLOW_SETTING
									$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '36'}, function (res) {
										var flowData = []
										$.each(res.data.flowData, function (k, v) {
											flowData.push({
												flowId: k,
												flowName: v
											});
										});
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
									var checkStatus = layTable.checkStatus('flowTable');
									if (checkStatus.data.length > 0) {
										var flowData = checkStatus.data[0];
										// approvalType 数据字典 RELATION_APPROVAL_PAGE
										var urlParameter = 'projId=' + projId + '&approvalType=07'
										newWorkFlow(flowData.flowId, urlParameter, function (res) {
											$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

											$.get('/plbBudgetItem/approval', {
												projId: projId,
												runId: res.flowRun.runId,
												approvalType: '11' // approvalType 后台定义
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
						}
					});
					break;
			}
		});
		layTable.on('tool(tableObj)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'detail') {
				$.get('/plbBudgetItem/getBudgetItemIdById', {budgetItemId: data.budgetItemId}, function (res) {
					if (res.flag) {
						newOrEdit(3, res.data[0]);
					} else {
						layer.msg('获取信息失败！', {icon: 0});
					}
				});
			} else if (layEvent === 'edit') {
				$.get('/plbBudgetItem/getBudgetItemIdById', {budgetItemId: data.budgetItemId}, function(res) {
					if (res.flag) {
						newOrEdit(2, res.data[0]);
					} else {
						layer.msg('信息获取失败！', {icon: 0});
					}
				});
			}
		});

		// 内部加行按钮
		layTable.on('toolbar(contorlTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					// 遍历表格获取每行数据进行保存
					var $tr = $('#contorlTableBox').find('.layui-table-main tr');
					var oldDataArr = []
					$tr.each(function () {
						var oldDataObj = {
							controlId: $(this).find('input[name="controlType"]').attr('controlId') || '',
							controlType: $(this).find('input[name="controlType"]').attr('controlType'),
							configurationUp: $(this).find('input[name="configurationUp"]').val(),
							controlRule: $(this).find('input[name="controlRule"]').val(),
							configurationDown: $(this).find('input[name="configurationDown"]').val(),
							isRemind: $(this).find('input[name="isRemind"]').attr('isRemind'),
							remind: $(this).find('input[name="remind"]').val()
						}
						oldDataArr.push(oldDataObj);
					});
					var addRowData = {};
					oldDataArr.push(addRowData);
					layTable.reload('contorlTable', {
						data: oldDataArr
					});
					break;
			}
		});
		// 内部删行操作
		layTable.on('tool(contorlTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.controlId) {
					$.get('/plbBudgetItem/delPlbBudgetControl', {controlId: data.controlId}, function(res) {
						if (res.flag) {
							layer.msg('删除成功！', {icon: 1, time: 2000});
							obj.del();
							// 遍历表格获取每行数据进行保存
							var $tr = $('#contorlTableBox').find('.layui-table-main tr');
							var oldDataArr = [];
							$tr.each(function () {
								var oldDataObj = {
									controlId: $(this).find('input[name="controlType"]').attr('controlId') || '',
									controlType: $(this).find('input[name="controlType"]').attr('controlType'),
									configurationUp: $(this).find('input[name="configurationUp"]').val(),
									controlRule: $(this).find('input[name="controlRule"]').val(),
									configurationDown: $(this).find('input[name="configurationDown"]').val(),
									isRemind: $(this).find('input[name="isRemind"]').attr('isRemind'),
									remind: $(this).find('input[name="remind"]').val()
								}
								oldDataArr.push(oldDataObj);
							});
							layTable.reload('contorlTable', {
								data: oldDataArr
							});
						} else {
							layer.msg('删除失败！', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功！', {icon: 1, time: 2000});
					obj.del();
					// 遍历表格获取每行数据进行保存
					var $tr = $('#contorlTableBox').find('.layui-table-main tr');
					var oldDataArr = [];
					$tr.each(function () {
						var oldDataObj = {
							controlId: $(this).find('input[name="controlType"]').attr('controlId') || '',
							controlType: $(this).find('input[name="controlType"]').attr('controlType'),
							configurationUp: $(this).find('input[name="configurationUp"]').val(),
							controlRule: $(this).find('input[name="controlRule"]').val(),
							configurationDown: $(this).find('input[name="configurationDown"]').val(),
							isRemind: $(this).find('input[name="isRemind"]').attr('isRemind'),
							remind: $(this).find('input[name="remind"]').val()
						}
						oldDataArr.push(oldDataObj);
					});
					layTable.reload('contorlTable', {
						data: oldDataArr
					});
				}
			} else if (layEvent === 'controlType') {
				layer.open({
					type: 1,
					title: '选择控制类型',
					area: ['400px', '400px'],
					btn: ['确定', '取消'],
					btnAlign: 'c',
					content: '<table id="controlTypeTable" lay-filter="controlTypeTable"></table>',
					success: function () {
						layTable.render({
							elem: '#controlTypeTable',
							data: [
								{controlType: 0, controlTypeStr: '比例控制'},
								{controlType: 1, controlTypeStr: '数值控制'}
							],
							cols: [[
								{type: 'radio', title: '选择'},
								{field: 'controlTypeStr', title: '控制类型'}
							]]
						});
					},
					yes: function (index) {
						var checkStatus = layTable.checkStatus('controlTypeTable');
						if (checkStatus.data.length > 0) {
							$tr.find('input[name="controlType"]').val(checkStatus.data[0].controlTypeStr);
							$tr.find('input[name="controlType"]').attr('controlType', checkStatus.data[0].controlType);
							layer.close(index);
						} else {
							layer.msg('请选择一项！', {icon: 0, time: 2000});
						}
					}
				});
			} else if (layEvent === 'isRemind') {
				layer.open({
					type: 1,
					title: '是否提醒',
					area: ['400px', '400px'],
					btn: ['确定', '取消'],
					btnAlign: 'c',
					content: '<table id="isRemindTable" lay-filter="isRemindTable"></table>',
					success: function () {
						layTable.render({
							elem: '#isRemindTable',
							data: [
								{isRemind: 0, isRemindStr: '否'},
								{isRemind: 1, isRemindStr: '是'},
								{isRemind: 2, isRemindStr: '禁止编制'}
							],
							cols: [[
								{type: 'radio', title: '选择'},
								{field: 'isRemindStr', title: '是否提醒'}
							]]
						});
					},
					yes: function (index) {
						var checkStatus = layTable.checkStatus('isRemindTable');
						if (checkStatus.data.length > 0) {
							$tr.find('input[name="isRemind"]').val(checkStatus.data[0].isRemindStr);
							$tr.find('input[name="isRemind"]').attr('isRemind', checkStatus.data[0].isRemind);
							if(checkStatus.data[0].isRemind == 0){
								$('input[name="remind"]').val("")
								$('input[name="remind"]').attr("readonly","readonly")
							}else {
								$('input[name="remind"]').removeAttr("readonly")
							}
							layer.close(index);
						} else {
							layer.msg('请选择一项！', {icon: 0, time: 2000});
						}
					}
				});
			} else if (layEvent === 'controlRule') {
				layer.open({
					type: 1,
					title: '控制规则',
					area: ['500px', '500px'],
					btn: ['确定', '取消'],
					btnAlign: 'c',
					content: ['<div>',
						'<h3>最小值</h3><table id="configurationUpTable" lay-filter="configurationUpTable"></table>',
						'<h3>最大值</h3><table id="configurationDownTable" lay-filter="configurationDownTable"></table>',
						'</div>'
					].join(''),
					success: function () {
						layTable.render({
							elem: '#configurationUpTable',
							data: [
								{controlRule: 1, controlRuleStr: '<', desc: '小于'},
								{controlRule: 2, controlRuleStr: '<=', desc: '小于或等于'}
							],
							cols: [[
								{type: 'radio', title: '选择'},
								{field: 'controlRuleStr', title: '控制规则'},
								{field: 'desc', title: '规则描述'}
							]]
						});

						layTable.render({
							elem: '#configurationDownTable',
							data: [
								{controlRule: 1, controlRuleStr: '<', desc: '小于'},
								{controlRule: 2, controlRuleStr: '<=', desc: '小于或等于'}
							],
							cols: [[
								{type: 'radio', title: '选择'},
								{field: 'controlRuleStr', title: '控制规则'},
								{field: 'desc', title: '规则描述'}
							]]
						});
					},
					yes: function (index) {
						var checkStatusUp = layTable.checkStatus('configurationUpTable');
						var checkStatusDown = layTable.checkStatus('configurationDownTable');
						if (checkStatusUp.data.length > 0 && checkStatusDown.data.length > 0) {
							var value = checkStatusUp.data[0].controlRuleStr + ',' + checkStatusDown.data[0].controlRuleStr;
							$tr.find('input[name="controlRule"]').val(value);
							layer.close(index);
						} else {
							layer.msg('请选择一项！', {icon: 0, time: 2000});
						}
					}
				});
			}
		});

		/**
		 * 加载表格方法
		 */
		function tableInit(wbsId) {
			var searchObj = getSearchObj();
			searchObj.wbsId = wbsId || '';
			searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
			searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;
			var cols = [{checkbox: true}].concat(TableUIObj.cols);

			cols.push({
				fixed: 'right',
				align: 'center',
				toolbar: '#toolBar',
				title: '操作',
				minWidth: 160
			});

			var option = {
				elem: '#tableObj',
				url: '/plbBudgetItem/getDataByCondition',
				cols: [cols],
				height: 'full-80',
				toolbar: '#toolbarHead',
				defaultToolbar: ['filter'],
				page: {
					limit: TableUIObj.onePageRecoeds,
					limits: [10, 20, 30, 40, 50]
				},
				where: searchObj,
				autoSort: false,
				request: {
					limitName: 'pageSize'
				},
				response: {
					statusName: 'flag',
					statusCode: true,
					msgName: 'msg',
					countName: 'totleNum',
					dataName: 'data'
				},
				done: function () {
					//增加拖拽后回调函数
					soulTable.render(this, function () {
						TableUIObj.dragTable('tableObj');
					});

					if (TableUIObj.onePageRecoeds != this.limit) {
						TableUIObj.update({onePageRecoeds: this.limit});
					}
				}
			}

			if (TableUIObj.orderbyFields) {
				option.initSort = {
					field: TableUIObj.orderbyFields,
					type: TableUIObj.orderbyUpdown
				}
			}

			tableObj = layTable.render(option);
		}

		/**
		 * 新增、编辑方法
		 * @param type 类型(1-新增，2-编辑)
		 * @param data 编辑时的信息
		 */
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			var wbsId = $('#leftId').attr('wbsId');
			var wbsName = $('#leftId').attr('wbsName');
			var projId = $('#leftId').attr('projId');
			var btnArr = ['保存', '取消'];
			if (type == 1) {
				title = '新建';
				url = '/plbBudgetItem/addPlbBudgetItem';
			} else if (type == 2) {
				title = '编辑';
				url = '/plbBudgetItem/updatePlbBudgetItem';
				projId = data.projId;
				wbsId = data.wbsId;
				wbsName = data.plbProjWbs.wbsName;
			} else if (type == 3) {
				title = '查看详情';
				btnArr = [];
				projId = data.projId;
				wbsId = data.wbsId;
				wbsName = data.plbProjWbs.wbsName;
			}

			var cbsSelectTree = null;
			var rbsSelectTree = null;

			layer.open({
				type: 1,
				title: title,
				area: ['80%', '90%'],
				btn: btnArr,
				btnAlign: 'c',
				content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
					'<form class="layui-form" id="baseForm" lay-filter="baseForm">',
					/* region 第一行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">预算科目编号<span field="itemNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly name="itemNo" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第二行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">预算科目名称<span field="itemName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="itemName" readonly style="background-color: #e7e7e7;" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">WBS<span class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly id="wbsId" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第三行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">RBS<span field="rbsId" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">CBS<span field="cbsId" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第四行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">控制类型<span field="controlType" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<select name="controlType"></select>' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">单位<span field="itemUnit" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<select name="itemUnit"></select>' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第五行 */
					/*'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">编制结束时间<span field="endTime" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly id="planEndDate" name="endTime" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">责任人<span field="dutyUser" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="dutyUser" id="dutyUser" readonly style="background-color: #e7e7e7; cursor: pointer;" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',*/
					/* endregion */
					/* region 第五行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">编制时间<span field="beginTime" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly id="planStartDate" name="beginTime" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">关联工作计划</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly name="planIds" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第六行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs12" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">科目说明<!--<span field="itemRemark" class="field_required">*</span>--></label>' +
					'<div class="layui-input-block form_block">' +
					'<textarea name="itemRemark" placeholder="请输入内容" class="layui-textarea"></textarea>' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					'</form>',
					'<div id="contorlTableBox"><table id="contorlTable" lay-filter="contorlTable"></table></div>',
					'</div>'].join(''),
				success: function () {
					if(projId){
						//回显项目名称
						getProjName('#projectName',projId)
					}

					$('select[name="itemType"]').html(dictionaryObj['ITEM_TYPE']['str']);
					$('select[name="controlType"]').html(dictionaryObj['CONTROL_TYPE']['str']);
					$('select[name="itemUnit"]').html(dictionaryObj['CBS_UNIT']['str']);

					if (type == 1) {
						// 获取自动编号
						getAutoNumber({autoNumber: 'plbBudgetItem'}, function(res) {
							$('input[name="itemNo"]', $('#baseForm')).val(res);
						});
						$('.refresh_no_btn').show().on('click', function() {
							getAutoNumber({autoNumber: 'plbBudgetItem'}, function(res) {
								$('input[name="itemNo"]', $('#baseForm')).val(res);
							});
						});
					}

					// 初始化开始时间
					var planStartDateConfig = {
						elem: '#planStartDate',
						done: function (value, date) {
							if (planEndDate.config.min) {
								// 修改开始时间最大选择日期
								planEndDate.config.min = {
									year: date.year || 1900,
									month: date.month - 1 || 0,
									date: date.date || 1,
								}
							} else {
								planEndDateConfig.min = value;
							}
						},
						value: data ? format(data.planStartDate) : new Date(),
						trigger: 'click' //采用click弹出
					}
					if (data && data.planEndDate) {
						planStartDateConfig.max = data.planEndDate;
					}
					var planStartDate = laydate.render(planStartDateConfig);

					// 初始化结束时间
					var planEndDateConfig = {
						elem: '#planEndDate',
						done: function (value, date) {
							if (planStartDate.config.max) {
								// 修改开始时间最大选择日期
								planStartDate.config.max = {
									year: date.year || 2099,
									month: date.month - 1 || 11,
									date: date.date || 31,
								}
							} else {
								planStartDateConfig.max = value;
							}
						},
						value: data ? format(data.planEndDate) : '',
						trigger: 'click' //采用click弹出
					}
					if (data && data.planStartDate) {
						planEndDateConfig.min = data.planStartDate;
					}
					var planEndDate = laydate.render(planEndDateConfig);


					/*RBS开始*/
					rbsSelectTree = xmSelect.render({
						el: '#rbsSelectTree',
						content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
								'<input type="text" style="box-sizing: border-box;" class="layui-input" id="rbsSelect">' +
								'</div>' +
								'<div style="padding-top: 30px;" id="rbsTree" class="eleTree" lay-filter="rbsTree"></div>',
						name: 'rbsId',
						disabled: type == 3,
						prop: {
							name: 'rbsName',
							value: 'rbsId'
						}
					});

					rbsTree()

					var rbsSearchTimer = null;
					$('#rbsSelect').on('input propertychange', function () {
						clearTimeout(rbsSearchTimer);
						rbsSearchTimer = null;
						var val = $(this).val();
						rbsSearchTimer = setTimeout(function () {
							rbsTree(val,'1')
						}, 300);
					});

					function rbsTree(parentId,type){
						var obj = {};
						if(type == '1'){
							obj.rbsName=parentId?parentId:'';
						}else {
							obj.parentId=parentId?parentId:'0';
						}
						// 获取RBS数据
						$.get('/plbRbs/selectAll',obj, function (res) {
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

					// 树节点点击事件
					eleTree.on("nodeClick(rbsTree)", function (d) {
						var currentData = d.data.currentData;
						$('#rbsSelectTree').attr('_cbsId',currentData.rbsId)

						if (!currentData.childList || currentData.childList.length == 0) {
							var obj = {
								rbsName: currentData.rbsName,
								rbsId: currentData.rbsId
							}
							rbsSelectTree.setValue([obj]);

							// 获取项目预算科目名称
							$.get('/plbProjWbs/getLongItemNameByWbsIdAndCbsId', {wbsId: wbsId,rbsId: currentData.rbsId,csbId: currentData.cbsId}, function (res) {
								if (res.flag) {
									$('[name="itemName"]', $('#baseForm')).val(res.data);
								}
							});

							var cbsObj = {
								cbsName: currentData.cbsName,
								cbsId: currentData.cbsId
							}
							cbsSelectTree.setValue([cbsObj]);
							$('[name="controlType"]', $('#baseForm')).val(currentData.controlMode);
							$('[name="itemUnit"]', $('#baseForm')).val(currentData.rbsUnit);
							$('[name="itemRemark"]', $('#baseForm')).val(currentData.remarks);

							layForm.render('select');
						}
					});

					/*RBS结束*/

					var cbsTreeData = []

					// 获取CBS数据
					$.get('/plbCbsType/getAllList', function (res) {
						cbsTreeData = res.data;

						cbsSelectTree = xmSelect.render({
							el: '#cbsSelectTree',
							content: '<div style="position: absolute;top: 0px;width: 100%;background: #fff;z-index: 2;">' +
									'<input type="text" style="box-sizing: border-box;" class="layui-input" id="cbsSelect">' +
									'</div>' +
									'<div style="padding-top: 30px;" id="cbsTree" class="eleTree" lay-filter="cbsTree"></div>',
							name: 'cbsId',
							disabled: type == 3,
							prop: {
								name: 'cbsName',
								value: 'cbsId'
							}
						});

						var cbsSearchTimer = null;
						$('#cbsSelect').on('input propertychange', function () {
							clearTimeout(cbsSearchTimer);
							cbsSearchTimer = null;
							var val = $(this).val();
							cbsSearchTimer = setTimeout(function () {
								var cbsTreeList = deepClone(cbsTreeData);
								filterCbsTree(cbsTreeList, val)
								initCbsTree(cbsTreeList)
							}, 300);
						});

						initCbsTree(cbsTreeData);

						function initCbsTree (cbsTreeData) {
							eleTree.render({
								elem: '#cbsTree',
								data: cbsTreeData,
								highlightCurrent: true,
								showLine: true,
								defaultExpandAll: false,
								accordion: true,
								request: {
									name: 'cbsName',
									children: "childList"
								}
							});
						}

						// 树节点点击事件
						eleTree.on("nodeClick(cbsTree)", function (d) {
							var currentData = d.data.currentData;
							if (!currentData.childList || currentData.childList.length == 0) {
								var obj = {
									cbsName: currentData.cbsName,
									cbsId: currentData.cbsId
								}
								cbsSelectTree.setValue([obj]);

								// 获取项目预算科目名称
								$.get('/plbProjWbs/getLongItemNameByWbsIdAndCbsId', {wbsId: wbsId,rbsId: $('#rbsSelectTree').attr('_cbsId'),csbId: currentData.cbsId}, function (res) {
									if (res.flag) {
										$('[name="itemName"]', $('#baseForm')).val(res.data);
									}
								});

								//$('[name="controlType"]', $('#baseForm')).val(currentData.controlMode);
								//$('[name="itemUnit"]', $('#baseForm')).val(currentData.cbsUnit);
								//$('[name="itemRemark"]', $('#baseForm')).val(currentData.budgetTrait);

								layForm.render('select');
							}
						});

						if (type == 2 || type == 3) {
							layForm.val("baseForm", data);

							$('#dutyUser').val(data.dutyUserName);
							$('#dutyUser').attr('user_id', data.dutyUser);

							$('#wbsId').val(wbsName);

							var rbsObj = {
								rbsName: data.plbRbs.rbsName,
								rbsId: data.plbRbs.rbsId
							}
							rbsSelectTree.setValue([rbsObj]);

							var obj = {
								cbsName: data.plbCbsTypeWithBLOBs.cbsName,
								cbsId: data.plbCbsTypeWithBLOBs.cbsId
							}
							cbsSelectTree.setValue([obj]);
						} else {
							$('#wbsId').val(wbsName);
						}
						layForm.render();
					});

					var plbBudgetControl = []

					if ((type == 2 || type == 3) && data.plbBudgetControl && data.plbBudgetControl.length > 0) {
						plbBudgetControl = data.plbBudgetControl
					}

					if (type == 3) {
						$('#baseForm [name]').attr('disabled', true);
					} else {
						// 选择责任人
						$('#dutyUser').on('click', function(){
							user_id = 'dutyUser';
							$.popWindow('/common/selectUser?0');
						});
					}

					layForm.render();

					layTable.render({
						elem: '#contorlTable',
						data: plbBudgetControl,
						toolbar: type == 3 ? false : '#toolbarDemoIn',
						defaultToolbar: [''],
						limit: 1000,
						cols: [[
							{type: 'numbers', title: '序号'},
							{
								field: 'controlType',
								title: '控制类型',
								width: 200,
								event: type == 3 ? false : 'controlType',
								templet: function (d) {
									var value = ''
									if (d.controlType == '0') {
										value = '比例控制'
									} else if (d.controlType == '1') {
										value = '数值控制'
									}
									return '<input type="text" readonly controlId="' + (d.controlId || '') + '" controlType="' + (d.controlType || '') + '" name="controlType" class="layui-input" style="height: 100%; cursor: pointer;" value="' + value + '">'
								}
							},
							{
								field: 'configurationUp', title: '最小值', minWidth: 100, templet: function (d) {
									var readonly = '';
									if (type == 3) {
										readonly = 'readonly';
									}
									return '<input type="text" ' + readonly + ' name="configurationUp" class="layui-input" style="height: 100%;" value="' + (d.configurationUp || '') + '">'
								}
							},
							{
								field: 'controlRule',
								title: '控制规则',
								minWidth: 100,
								event: type == 3 ? false : 'controlRule',
								templet: function (d) {
									return '<input type="text" readonly name="controlRule" class="layui-input" style="height: 100%; cursor:pointer;" value="' + (d.controlRule || '') + '">'
								}
							},
							{
								field: 'configurationDown', title: '最大值', minWidth: 100, templet: function (d) {
									var readonly = '';
									if (type == 3) {
										readonly = 'readonly';
									}
									return '<input type="text" ' + readonly + ' name="configurationDown" class="layui-input" style="height: 100%;" value="' + (d.configurationDown || '') + '">'
								}
							},
							{
								field: 'isRemind',
								title: '是否提醒',
								width: 200,
								event: type == 3 ? false : 'isRemind',
								templet: function (d) {
									var value = ''
									if (d.isRemind == '0') {
										value = '否';
									} else if (d.isRemind == '1') {
										value = '是'
									} else if (d.isRemind == '2') {
										value = '禁止编制'
									}

									return '<input type="text" readonly isRemind="' + (d.isRemind || '') + '" name="isRemind" class="layui-input" style="height: 100%; cursor: pointer;" value="' + value + '">'
								}
							},
							{
								field: 'remind', title: '超出控制提醒内容', minWidth: 200, templet: function (d) {
									if (d.isRemind == 0) {
										$('input[name="remind"]').val("");
										$('input[name="remind"]').attr("readonly", "readonly");
									} else {
										$('input[name="remind"]').removeAttr("readonly");
									}
									var readonly = '';
									if (type == 3) {
										$('input[name="remind"]').attr("readonly", "readonly");
										readonly = 'readonly';
									}
									return '<input type="text" ' + readonly + ' name="remind" class="layui-input" style="height: 100%;" value="' + (d.remind || '') + '">'
								}
							},
							{align: 'center', toolbar: '#barDemo', hide: type == 3, title: '操作', width: 100}
						]]
					});
				},
				yes: function (index) {
					var loadIndex = layer.load();
					var datas = $('#baseForm').serializeArray();
					var obj = {}
					datas.forEach(function (item) {
						obj[item.name] = item.value;
					});

					// 控制类型数据
					var $tr = $('#contorlTableBox').find('.layui-table-main tr');
					var plbBudgetControl = [];
					$tr.each(function () {
						var plbBudgetControlObj = {
							controlType: $(this).find('input[name="controlType"]').attr('controlType'),
							configurationUp: $(this).find('input[name="configurationUp"]').val(),
							controlRule: $(this).find('input[name="controlRule"]').val(),
							configurationDown: $(this).find('input[name="configurationDown"]').val(),
							isRemind: $(this).find('input[name="isRemind"]').attr('isRemind'),
							remind: $(this).find('input[name="remind"]').val()
						}
						if ($(this).find('input[name="controlType"]').attr('controlId')) {
							plbBudgetControlObj.controlId = $(this).find('input[name="controlType"]').attr('controlId');
						}
						plbBudgetControl.push(plbBudgetControlObj);
					});
					obj.plbBudgetControl = plbBudgetControl;

					// 责任人
					obj.dutyUser = ($('#dutyUser').attr('user_id') || '').replace(/,$/, '');

					// 判断必填项
					var requiredFlag = false;
					$('#baseForm').find('.field_required').each(function(){
						var field = $(this).attr('field');
						if (field && !obj[field] && obj[field] != '0') {
							var fieldName = $(this).parent().text().replace('*', '');
							layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
							requiredFlag = true;
							return false;
						}
					});

					if (requiredFlag) {
						layer.close(loadIndex);
						return false;
					}

					if (type == 2) {
						obj.budgetItemId = data.budgetItemId;
					} else {
						obj.wbsId = wbsId;
						obj.projId = projId;
					}

					$.ajax({
						url: url,
						data: JSON.stringify(obj),
						dataType: 'json',
						contentType: "application/json;charset=UTF-8",
						type: 'post',
						success: function (res) {
							layer.close(loadIndex);
							if (res.flag) {
								layer.msg('保存成功！', {icon: 1});
								layer.close(index);
								tableObj.config.where._ = new Date().getTime();
								tableObj.reload();
							} else {
								layer.msg(res.msg, {icon: 2});
							}
						}
					});
				}
			});
		}

		// 查询
		$('#searchBtn').on('click', function(){
			tableInit($('#leftId').attr('wbsId') || '');
		});

		// 高级查询
		$('#advancedQuery').on('click', function(){
			layer.msg('功能完善中');
		});

		/**
		 * 获取查询条件
		 * @returns {{planNo: (*), planName: (*)}}
		 */
		function getSearchObj() {
			var searchObj = {
				itemNo: $('input[name="itemNo"]', $('.query_module')).val(),
				itemName: $('input[name="itemName"]', $('.query_module')).val(),
				wbsName: $('input[name="wbsName"]', $('.query_module')).val(),
				approvalStatus: $('select[name="approvalStatus"]', $('.query_module')).val()
			}

			return searchObj
		}

		/*region 导出 */
		$(document).on('click', function () {
			$('.export_moudle').hide();
		});
		$(document).on('click', '.export_btn', function () {
			var type = $(this).attr('type');
			if (type == 1) {
				var checkStatus = layTable.checkStatus('tableObj');
				if (checkStatus.data.length == 0) {
					layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
					return false;
				}
				soulTable.export(tableObj, {
					filename: '项目预算科目列表.xlsx',
					checked: true
				});
			} else if (type == 2) {
				soulTable.export(tableObj, {
					filename: '项目预算科目列表.xlsx',
					curPage: true
				});
			} else if (type == 3) {
				console.log(tableObj);
				soulTable.export(tableObj, {
					filename: '项目预算科目列表.xlsx'
				});
			}
		});
		/* endregion */

		function filterCbsTree (data, cbsName, parentArr, parentIndex) {
			if (!!data && data.length > 0) {
				for(var i = 0; i < data.length; i++) {
					if (data[i].cbsName.indexOf(cbsName) == -1) {
						if (data[i].childList && data[i].childList.length > 0) {
							i = filterCbsTree(data[i].childList, cbsName, data, i);
						} else {
							data.splice(i, 1);
							i--;
						}
					}
				}

				if (data.length == 0 && parentArr && parentArr.length > 0 && (parentArr.length == parentIndex || parentArr.length > parentIndex)) {
					parentArr.splice(parentIndex, 1);
					return parentIndex - 1;
				} else {
					return parentIndex || 0;
				}
			}
		}
	});

	/**
	 * 新建流程方法
	 * @param flowId
	 * @param urlParameter
	 * @param cb
	 */
	function newWorkFlow(flowId, urlParameter, cb) {
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
				urlParameter: urlParameter, // 封装所有参数 (内嵌页面)
				approvalType: '07', // 预算关联审批页面【数据字典配置 RELATION_APPROVAL_PAGE】(内嵌页面)
				//approvalData: approvalData, // (tab页面)
				isTabApproval: false // 是否为tab方式打开
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
