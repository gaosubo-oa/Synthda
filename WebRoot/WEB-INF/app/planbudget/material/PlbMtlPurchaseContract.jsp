<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/1/11
  Time: 10:29
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
		<title>材料采购合同</title>
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
<%--		<script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
		<script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
		<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108311508"></script>
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
			.displayNone{
				display: none;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId">
			<div class="wrapper">
				<div class="wrap_left">
					<h2>材料采购合同</h2>
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
							<input type="text" name="contractNo" placeholder="合同编号" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="contractName" placeholder="合同名称" autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs2" style="margin-left: 15px;">
							<input type="text" name="customerName" placeholder="客商单位名称"  autocomplete="off" class="layui-input">
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
							<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
<%--							<button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>--%>
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
			<div class="layui-btn-container" style="height: 30px;">
				<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新建</button>
				<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="edit">编辑</button>
				<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
				<button class="layui-btn layui-btn-sm" lay-event="entry">附件更新</button>
				<button class="layui-btn layui-btn-sm" lay-event="dayin">打印模板</button>
			</div>
			<div style="position:absolute;top: 10px;right:60px;">
				<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批
				</button>
				<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">
					<img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">
					导入
				</button>
				<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
					<img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">
					导出
				</button>
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

		<script type="text/html" id="plbMtlContrastBar">
			<div class="layui-btn-container" style="height: 30px;">
				<button class="layui-btn layui-btn-sm" lay-event="choosePlbMtlContrast">选择供应商比价</button>
			</div>
		</script>

		<script type="text/html" id="toolBar">
			<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
		</script>

		<script type="text/html" id="contTool">
			<a class="layui-btn layui-btn-xs" lay-event="info">比价详情</a>
		</script>

		<script>
			var materialsTable=null
			//明细表头
			var detailCols = [
				{
					field: 'customerUnit1', title: '供应商1单价', width: 150, hide: true
				},
				{
					field: 'customerUnit2', title: '供应商2单价', width: 150, hide: true
				},
				{
					field: 'customerUnit3', title: '供应商3单价', width: 150, hide: true
				},
				{
					field: 'customerUnit4', title: '供应商4单价', width: 150, hide: true
				},
				{
					field: 'customerUnit5', title: '供应商5单价', width: 150, hide: true
				},
				{
					field: 'customerUnit6', title: '供应商6单价', width: 150, hide: true
				},
				{
					field: 'customerUnit7', title: '供应商7单价', width: 150, hide: true
				},
				{
					field: 'customerUnit8', title: '供应商8单价', width: 150, hide: true
				}
			]
			var dept_id = '';

			var tipIndex = null
			$('.icon_img').hover(function () {
				var tip = $(this).attr('text');
				tipIndex = layer.tips(tip, this);
			}, function () {
				layer.close(tipIndex);
			});

			// 表格显示顺序
			var colShowObj = {
				documentNo:{field:'documentNo',title:'单据号',sort:false,hide:false},
				projName: {field: 'projName', title: '所属项目', sort: false, hide: false},
				contractNo: {field: 'contractNo', title: '合同编号', sort: true, hide: false},
				contractName: {field: 'contractName', title: '合同名称', sort: true, hide: false},
				contractType: {
					field: 'contractType', title: '合同类型', sort: true, hide: false, templet: function (d) {
						return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || '';
					}
				},
				signDate: {
					field: 'signDate', title: '合同签订日期', sort: true, hide: false, templet: function (d) {
						return format(d.signDate);
					}
				},
				contractA: {
					field: 'contractA', title: '甲方', sort: true, hide: false, templet: function (d) {
						return d.contractAName || '';
					}
				},
				customerId: {
					field: 'customerId', title: '乙方', sort: true, hide: false, templet: function (d) {
						return d.customerName || '';
					}
				},
				contractMoney: {
					field: 'contractMoney', title: '合同额', sort: true, hide: false, templet: function (d) {
						return numFormat(d.contractMoney);
					}
				},
				contractPeriod: {
					field: 'contractPeriod', title: '合同有效期', sort: true, hide: false
				},
				currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
				auditerStatus: {
					field: 'auditerStatus', title: '合同状态', sort: true, hide: false, templet: function (d) {
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
			var TableUIObj = new TableUI('plb_mtl_contract');

			// 获取数据字典数据
			var dictionaryObj = {
				CONTRACT_TYPE: {},
				PAYMENT_METHOD: {},
				CBS_UNIT: {},
				CONTRACT_STATUS: {},
				COMPARE_TYPE: {},
				TAX_RATE: {},
				INVOICE_TYPE: {},
				CUSTOMER_NAME: {},
				CONTRACT_CATEGORY:{}
			}
			var dictionaryStr = 'CONTRACT_TYPE,PAYMENT_METHOD,CBS_UNIT,CONTRACT_STATUS,COMPARE_TYPE,TAX_RATE,INVOICE_TYPE,CUSTOMER_NAME,CONTRACT_CATEGORY';
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
				initPage();
			});
			var tableObj = null;
			function initPage() {
				layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree'], function () {
					var layForm = layui.form,
							laydate = layui.laydate,
							layTable = layui.table,
							layElement = layui.element,
							soulTable = layui.soulTable,
							eleTree = layui.eleTree;



					TableUIObj.init(colShowObj, function () {
						// $('.no_data').hide();
						// $('.table_box').show();
						// tableInit();
					});

					layForm.render();

					/* region 修改左侧项目名称 */
					var searchTimer = null
					$('#search_project').on('input propertychange', function () {
						clearTimeout(searchTimer)
						searchTimer = null
						var val = $(this).val()
						searchTimer = setTimeout(function () {
							projectLeft(val)
						}, 300)
					})
					$('.search_icon').on('click', function () {
						projectLeft($('#search_project').val())
					})
					/* endregion */

					projectLeft();

					/**
					 * 左侧项目信息列表
					 * @param projectName 项目名称
					 */
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
								})
							}
						})
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

					// 监听排序事件
					layTable.on('sort(tableObj)', function (obj) {
						var param = {
							orderbyFields: obj.field,
							orderbyUpdown: obj.type
						}

						TableUIObj.update(param, function () {
							tableInit($('#leftId').attr('projId') || '');
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

					function tableInit(projId) {
						var searchObj = getSearchObj();
						searchObj.projId = projId || '';
						searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
						searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

						searchObj.useFlag = true

						var cols = [{checkbox: true}].concat(TableUIObj.cols);

						cols.push({
							fixed: 'right',
							align: 'center',
							toolbar: '#toolBar',
							title: '操作',
							width: 100
						});

						var option = {
							elem: '#tableObj',
							url: '/plbMtlContract/selectAll',
							toolbar: '#toolbarHead',
							cols: [cols],
							defaultToolbar: ['filter'],
							height: 'full-80',
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
								dataName: 'obj'
							},
							done: function () {
								//增加拖拽后回调函数
								soulTable.render(this, function () {
									TableUIObj.dragTable('tableObj')
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

					// 监听筛选列
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

					// 上方按钮显示
					layTable.on('toolbar(tableObj)', function (obj) {
						var checkStatus = layTable.checkStatus(obj.config.id);
						var dataTable=layTable.checkStatus(obj.config.id).data;
						switch (obj.event) {
							case 'add':
								if (!$('#leftId').attr('projId')) {
									layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
									return false;
								}
								newOrEdit(1);
								break;
							case 'edit':
								if (checkStatus.data.length != 1) {
									layer.msg('请选择需要修改的数据！', {icon: 0});
									return false
								}

								if (checkStatus.data[0].auditerStatus != 0) {
									layer.msg('该合同已提交，不可编辑！', {icon: 0});
									return false;
								}

								$.get('/plbMtlContract/queryId', {mtlContractId: checkStatus.data[0].mtlContractId}, function (res) {
									if (res.flag) {
										newOrEdit(2, res.object);
									} else {
										layer.msg('获取数据失败!', {icon: 0});
									}
								});
								break;
							case 'del':
								if (checkStatus.data.length == 0) {
									layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
									return false
								}
								var mtlContractIds = '';
								var isFlay = false;
								checkStatus.data.forEach(function (v) {
									mtlContractIds += v.mtlContractId + ','
									if(v.auditerStatus&&v.auditerStatus!='0'){
										isFlay = true
									}
								});

								if(isFlay){
									layer.msg('已提交不可删除！', {icon: 0});
									return false
								}

								layer.confirm('确定删除选中数据吗？', function (index) {
									$.post('/plbMtlContract/delete', {mtlContractIds: mtlContractIds}, function (res) {
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
									content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
									success: function () {
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '18'}, function (res) {
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
										var checkStatus1 = layTable.checkStatus('flowTable');
										if (checkStatus1.data.length > 0) {
											var flowData = checkStatus1.data[0];
											var approvalData = checkStatus.data[0];
											approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
											approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
											newWorkFlow(flowData.flowId, JSON.stringify(approvalData), function (res) {
												// 报销单保存关联的runId
												var submitData = {
													mtlContractId: checkStatus.data[0].mtlContractId,
													runId: res.flowRun.runId,
													//auditerStatus: '1'
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/plbMtlContract/update',
													data: JSON.stringify(submitData),
													dataType: 'json',
													contentType: "application/json;charset=UTF-8",
													type: 'post',
													success: function (res) {
														layer.close(loadIndex);
														if (res.flag) {
															layer.closeAll();
															layer.msg('提交成功!', {icon: 1});
															tableObj.config.where._ = new Date().getTime();
															tableObj.reload();
														} else {
															layer.msg(res.msg, {icon: 2});
														}
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
							case 'export':
								$('.export_moudle').show();
								break;
							case 'entry':
								if (checkStatus.data.length != 1) {
									layer.msg('请选择需要更新附件的数据！', {icon: 0});
									return false
								}

								if (checkStatus.data[0].auditerStatus != 2) {
									layer.msg('只能更新已批准的数据！', {icon: 0});
									return false;
								}

								$.get('/plbMtlContract/queryId', {mtlContractId: checkStatus.data[0].mtlContractId}, function (res) {
									if (res.flag) {
										newOrEdit(5, res.object);
									} else {
										layer.msg('获取数据失败!', {icon: 0});
									}
								});
								break;
							case 'dayin':
								if (checkStatus.data.length != 1) {
									layer.msg('请选择一条需要打印的数据！', {icon: 0, time: 2000});
									return false;
								}
								if(checkStatus.data[0].auditerStatus != 0){
									var index=layer.load();
									var runId=dataTable[0].runId;
									$.ajax({
										url:'/generateDocx/generateDocxByType?runId='+runId+'&type=mtlContract',
										success:function(res){
											if(res.flag){
												layer.close(index);
												if(res.obj.reportAttachmentList==undefined||res.obj.reportAttachmentList.length<1||res.obj.reportAttachmentList[0]==""){
													layer.msg('查询失败请刷新重试！', {icon: 0, time: 2000});
													return
												}else{
													console.log(res.obj)
													var atturl=res.obj.reportAttachmentList[0].attUrl;
													pdurlss(atturl)
												}
											}else{
												layer.close(index);
											}

										}
									})
								}else{
									layer.msg('未提交审批不可打印！', {icon: 0, time: 2000});
								}
								break;
						}
					});
					layTable.on('tool(tableObj)', function (obj) {
						var data = obj.data;
						var layEvent = obj.event;
						if (layEvent === 'detail') {
							layer.open({
								type: 2,
								title: '材料采购合同详情',
								area: ['100%', '100%'],
								btn: ['确定'],
								btnAlign: 'c',
								content: '/plbMtlContract/mtlPurchaseContract?type=4&mtlContractId=' + data.mtlContractId
							});
						}
					});

					// 内部-购买清单-上方按钮显示
					layTable.on('toolbar(contractDetailsTable)', function (obj) {
						switch (obj.event) {
							case 'add':
								var currentName;
								var currentRbsUnit;
								layer.open({
									type: 1,
									title: '选择材料',
									area: ['70%', '80%'],
									maxmin: true,
									btn: ['确定', '取消'],
									btnAlign: 'c',
									content: ['<div class="container">',
										'<div class="wrapper">',
										'<div class="wrap_left">' +
										'<div class="layui-form">' +
										/*'<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +*/
										'<div class="tree_module" style="top: 48px;">' +
										'<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
										'</div>' +
										'</div>' +
										'</div>',
										'<div class="wrap_right">' +
										'<div class="layui-form">' +
										'<div class="layui-row">' +
										' <div class="layui-col-xs4" style="width: 200px">' +
										'  <div class="layui-form-item" style="margin: 0">' +
										// '  <label class="layui-form-label">材料名称</label>' +
										'    <div class="layui-input-block" style="margin-left: 10px">'+
										'        <input type="text" name="mtlName" id="mtlName" placeholder="材料名称" class="layui-input">' +
										'    </div>'+
										'  </div>'+
										' </div>'+
										' <div class="layui-col-xs4" style="width:200px">' +
										'  <div class="layui-form-item" style="margin: 0">' +
										// '  <label class="layui-form-label">材料规格</label>' +
										'     <div class="layui-input-block" style="margin-left: 10px">'+
										'        <input type="text" name="mtlStandard" id="mtlStandard" placeholder="材料规格" autocomplete="off" class="layui-input">' +
										'     </div>'+
										'  </div>'+
										' </div>'+
										' <div class="layui-col-xs4" style="width: 134px">' +
										'<button type="button" id="searchMtlBtn" class="layui-btn" style="height: 34px;line-height: 34px;margin-top: 2px;margin-left: 7px">查询</button>'+
										' </div>'+
										'</div>',
										// '<div class="layui-form-item" style="margin: 0;">' +
										// '<div class="layui-inline">'+
										// '<label class="layui-form-label">材料名称</label>'+
										// '<div class="layui-input-inline">'+
										// '<input type="text" id="mtlName" autocomplete="off" class="layui-input">'+
										// '</div>'+
										// '</div>'+
										// '<div class="layui-inline">'+
										// '<button type="button" class="layui-btn layui-btn-sm" id="search_mtl">查询</button>'+
										// '</div>'+
										// '</div>' +
										'<div class="layui-row">' +
										'<div class="mtl_table_box">' +
										'<table id="materialsTable" lay-filter="materialsTable"></table>' +
										'</div>' +
										'</div>',
										'</div>' +
										'</div>',
										'</div></div>'].join(''),
									success: function () {
										var mtlNode = null;

										// 获取材料类型
										$.get('/plbDictonary/getTgTypeByDictNo?plbDictNo=MTL_TYPE', function (res) {
											var str = '<option value="">请选择<option>';
											if (res.flag && res.obj.length > 0) {
												res.obj.forEach(function (item) {
													str += '<option value="' + item.plbDictNo + '">' + item.dictName + '<option>';
												});
											}
											$('#mtlTypeTree').html(str);
											layForm.render();
										});

										layForm.on('select(mtlTypeTree)', function (data) {
											loadMtlType(data.value);
										});

										// 树节点点击事件
										eleTree.on("nodeClick(chooseMtlTree)", function (d) {
											mtlNode = d.data.currentData;
											if(mtlNode.rbsUnit){
												currentName=mtlNode.rbsName;
												currentRbsUnit=mtlNode.rbsUnit;
											}
											loadMtlTable(mtlNode.rbsId);
										});

										loadMtlType();

										function loadMtlType(mtlType) {
											mtlType = mtlType ? mtlType : '';
											// 获取左侧树
											//$.get('/plbRbs/selectAll?parentId=0', {mtlType: mtlType}, function (res) {
											//	if (res.flag) {
											var oneData = [{
												isFlag:false,
												rbsName:"材料",
												childList:[],
												rbsId:1
											}]
													eleTree.render({
														elem: '#chooseMtlTree',
														data: oneData,
														highlightCurrent: true,
														showLine: true,
														defaultExpandAll: true,
														lazy: true,
														request: {
															key: 'rbsId',
															name: 'rbsName',
															children: "childList",
														},
														load: function (data, callback) {
															$.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
																callback(res.data);//点击节点回调
															})
														}
													});
												//}
											//});
										}
										$("#searchMtlBtn").click(function(){
											loadMtlTable();
										})
										loadMtlTable();

										function loadMtlTable() {
											var where = {
												mtlName: $('#mtlName').val(),
												mtlStandard: $('#mtlStandard').val()
											}
											if (mtlNode) {
												if (mtlNode.rbsId) {
													where.rbsId = mtlNode.rbsId
												} else {
													where.mtlType = mtlNode.mtlType
												}
											}
											layTable.render({
												elem: '#materialsTable',
												url: '/plbMtlLibrary/queryByParentId',
												where: where,
												page: {
													limit: 10,
													limits: [10, 20, 30]
												},
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
												cols: [[
													{type: 'checkbox', title: '选择'},
													{field: 'mtlNo', title: '材料编码'},
													{field: 'mtlName', title: '材料名称'},
													{
														field: 'mtlStandard', title: '材料规格'
													},
													{
														field: 'mtlValuationUnit', title: '计量单位', templet: function (d) {
															return '<span valuationUnit="'+(d.mtlValuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '')+'</span>';
														}
													},
													{field: 'mtlPriceUnit', title: '指导单价'}
												]]
											});
										}

										$('#search_mtl').on('click', function () {
											loadMtlTable()
										});
									},
									yes: function (index) {

										// 遍历表格获取每行数据进行保存
										var $trs = $('#contractDetailsModule').find('.layui-table-main tr');
										var oldDataArr = []
										$trs.each(function () {
											var oldDataObj = {
												contractListId: $(this).find('input[name="mtlLibId"]').attr('contractListId') || '', // 清单id
												mtlLibId: $(this).find('input[name="mtlLibId"]').attr('mtlLibId') || '', // 材料id
												mtlUnit: $(this).find('.mtlUnit').text(),
												valuationUnit: $(this).find('.valuationUnit').text(),
												mtlName: $(this).find('input[name="mtlLibId"]').val(), // 材料名称
												mtlStandard: $(this).find('.mtlStandard').text(), // 材料规格
												unitPrice: $(this).find('input[name="unitPrice"]').val(), // 含税单价
												taxRate: $(this).find('input[name="taxRate"]').val(), // 税率
												noTaxPrice: $(this).find('.noTaxPrice').text(), // 不含税单价
												amount: $(this).find('input[name="amount"]').val(), // 数量
												noTaxMoney: $(this).find('.noTaxMoney').text(), // 不含税总价
												totalIncludingTax: $(this).find('.totalIncludingTax').text() // 含税总价
											}
											oldDataArr.push(oldDataObj);
										});

										var checkStatus = layTable.checkStatus('materialsTable');
										if (checkStatus.data.length > 0) {
											// 发票类型
											var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();
											var taxRate = 0;
											if (invoiceType == '01') {
												taxRate = checkFloatNum(dictionaryObj['TAX_RATE']['object'][$('[name="taxRate"]', $('#baseForm')).val()] || '');
											}
											var mtlData = checkStatus.data;
											var newArr = [];
											mtlData.forEach(function(item){
												var newObj = {
													mtlLibId: item.mtlLibId,
													mtlName: item.mtlName,
													mtlStandard: item.mtlStandard,
													taxRate: taxRate,
													valuationUnit:item.mtlValuationUnit,
													noTaxPrice: 0,
													noTaxMoney: 0,
													totalIncludingTax: 0
												}
												newArr.push(newObj);
											});

											oldDataArr = oldDataArr.concat(newArr);

											layTable.reload('contractDetailsTable', {
												data: oldDataArr
											});

											layer.close(index);
										} else {
											var _flag=true
											if(currentName !=''&&currentName!=undefined){
												for(var i=0;i<oldDataArr.length;i++){
													if(currentName == oldDataArr[i].mtlName){
														_flag=false
														break;
													}
												}
												if(_flag){
													var newData={
														mtlName:currentName,
														valuationUnit:currentRbsUnit
													}
													oldDataArr.push(newData)
												}
											}
											layer.close(index);
											layTable.reload('contractDetailsTable', {
												data: oldDataArr
											});
										}
									}
								});
								break;
						}
					});
					// 内部-购买清单-删行操作
					layTable.on('tool(contractDetailsTable)', function (obj) {
						var data = obj.data;
						var layEvent = obj.event;
						var $tr = obj.tr;
						if (layEvent === 'del') {
							obj.del();
							if (data.contractListId) {
								$.get('/plbMtlContractList/delete', {contractListId: data.contractListId}, function (res) {
								});
							}
							//遍历表格获取每行数据进行保存
							var $trs = $('#contractDetailsModule').find('.layui-table-main tr');
							var oldDataArr = [];
							$trs.each(function () {
								var oldDataObj = {
									contractListId: $(this).find('input[name="mtlLibId"]').attr('contractListId') || '',
									mtlLibId: $(this).find('input[name="mtlLibId"]').attr('mtlLibId') || '',
									mtlName: $(this).find('input[name="mtlLibId"]').val(),
									mtlUnit: $(this).find('.mtlUnit').text(),
									valuationUnit: $(this).find('.valuationUnit').text(),
									mtlStandard: $(this).find('.mtlStandard').text(),
									unitPrice: $(this).find('input[name="unitPrice"]').val(),
									taxRate: $(this).find('input[name="taxRate"]').val(),
									amount: $(this).find('input[name="amount"]').val(),
									noTaxPrice: $(this).find('.noTaxPrice').text(),
									noTaxMoney: $(this).find('.noTaxMoney').text(),
									totalIncludingTax: $(this).find('.totalIncludingTax').text()
								}
								oldDataArr.push(oldDataObj);
							});
							layTable.reload('contractDetailsTable', {
								data: oldDataArr
							});
							computedContractMoney();
						}
					});

					// 内部-付款结算-上方按钮显示
					layTable.on('toolbar(paymentSettlementTable)', function (obj) {
						switch (obj.event) {
							case 'add':
								//遍历表格获取每行数据进行保存
								var $tr = $('.contract_out').find('.layui-table-main tr');
								var oldDataArr = [];
								$tr.each(function () {
									var oldDataObj = {
										mtlContractOutId: $(this).find('input[name="contractMoney"]').attr('mtlContractOutId') || '',
										contractMoney: $(this).find('input[name="contractMoney"]').val(),
										contractRatio: $(this).find('input[name="contractRatio"]').val(),
										paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
										termOfPayment: $(this).find('input[name="termOfPayment"]').val()
									}
									oldDataArr.push(oldDataObj);
								});
								oldDataArr.push({});
								layTable.reload('paymentSettlementTable', {
									data: oldDataArr
								});
								break;
						}
					});
					// 内部-付款结算-删行操作
					layTable.on('tool(paymentSettlementTable)', function (obj) {
						var data = obj.data;
						var layEvent = obj.event;
						var $tr = obj.tr;
						if (layEvent === 'del') {
							obj.del();
							if (data.mtlContractOutId) {
								$.get('/plbMtlContractOut/delete', {mtlContractOutId: data.mtlContractOutId}, function () {
								});
							}
							//遍历表格获取每行数据进行保存
							var $trs = $('.contract_out').find('.layui-table-main tr');
							var oldDataArr = [];
							$trs.each(function () {
								var oldDataObj = {
									mtlContractOutId: $(this).find('input[name="contractMoney"]').attr('mtlContractOutId') || '',
									contractMoney: $(this).find('input[name="contractMoney"]').val(),
									contractRatio: $(this).find('input[name="contractRatio"]').val(),
									paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
									termOfPayment: $(this).find('input[name="termOfPayment"]').val()
								}
								oldDataArr.push(oldDataObj);
							})
							layTable.reload('paymentSettlementTable', {
								data: oldDataArr
							});
						}
					});

					// 内部-选择供应商比价
					layTable.on('toolbar(plbMtlContrastTable)', function (obj) {
						switch (obj.event) {
							case 'choosePlbMtlContrast':
								layer.open({
									type: 1,
									title: '选择供应商比价',
									area: ['70%', '80%'],
									btn: ['确定', '取消'],
									btnAlign: 'c',
									content: '<div><table id="choosePlbMtlContrastTable" lay-filter="choosePlbMtlContrastTable"></table></div>',
									success: function () {
										layTable.render({
											elem: '#choosePlbMtlContrastTable',
											url: '/plbMtlContrast/selectAll',
											page: true,
											where: {
												projId: $('#leftId').attr('projId'),
												approvalStatus: "2",
												isContract: "contract"
											},
											request: {
												limitName: 'pageSize'
											},
											response: {
												statusName: 'flag',
												statusCode: true,
												msgName: 'msg',
												countName: 'totleNum',
												dataName: 'obj'
											},
											cols: [[
												{type: 'radio'},
												{field: 'contrastNo', title: '比价编号'},
												{field: 'priceComparison', title: '比价事项'},
												{
													field: 'compareTime', title: '比价时间', templet: function (d) {
														return format(d.compareTime);
													}
												},
												{
													field: 'compareType', title: '比价方式', templet: function (d) {
														return dictionaryObj['COMPARE_TYPE']['object'][d.compareType] || ''
													}
												},
												{field: 'remark', title: '备注'}
											]]
										});
									},
									yes: function (index) {
										var checkStatus = layTable.checkStatus('choosePlbMtlContrastTable');

										if (checkStatus.data.length > 0) {
											layTable.reload('plbMtlContrastTable', {
												data: checkStatus.data
											});
											$('#contrastId').attr('contrastId', checkStatus.data[0].contrastId).val(checkStatus.data[0].contrastNo);
											layer.close(index);
										} else {
											layer.msg('请选择一项！', {icon: 0});
										}
									}
								});
								break;
						}
					});

					function newOrEdit(type, data) {
						var title = '';
						var url = '';
						var projId = $('#leftId').attr('projId');
						var mtlContractId = '';
						var displayNone = '';
						if (type == 1) {
							title = '新建材料采购合同';
							url = '/plbMtlContract/insert';
						} else if (type == 2) {
							title = '编辑材料采购合同';
							url = '/plbMtlContract/update';
							projId = data.projId;
							mtlContractId = data.mtlContractId;
						} else if (type == 5) {
							title = '附件更新';
							url = '/plbMtlContract/update';
							projId = data.projId;
							mtlContractId = data.mtlContractId;
							displayNone='displayNone'
						}

						layer.open({
							type: 1,
							title: title,
							area: ['100%', '100%'],
							btn: type != 5?['保存', '提交', '取消']:['保存','取消'],
							btnAlign: 'c',
							content: ['<div class="layer_wrap _disabled"><div class="layui-collapse">',
								/* region 材料计划 */
								'<div class="layui-colla-item"><h2 class="layui-colla-title">材料计划</h2>' +
								'<div class="layui-colla-content layui-show base_info">',
								'<form id="baseForm" class="layui-form" lay-filter="baseForm">',
								/* region 第一行 */
								'<div class="layui-row">' +
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">单据号<span field="documentNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" readonly name="documentNo" autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">合同编号<span field="contractName" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="contractNo" autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">合同名称<span field="contractName" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="contractName" autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">合同类型<span field="contractType" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<select name="contractType"></select>' +
								'</div>' +
								'</div>' +
								'</div>',
								'</div>',
								/* endregion */
								/* region 第二行 */
								'<div class="layui-row">' +
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">甲方<span field="contractA" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="contractA" id="contractA" readonly autocomplete="off" style="cursor: pointer;background: #e7e7e7;" placeholder="请选择" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">乙方<span field="customerId" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="customerId" id="customerId" readonly autocomplete="off" style="cursor: pointer;background: #e7e7e7;" placeholder="请选择" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">含税合同金额(元)<span field="contractMoney" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="number" style="background: #e7e7e7;" readonly name="contractMoney" autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">预付款(元)<span field="paymentPre" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="paymentPre" autocomplete="off" pointFlag="1" class="layui-input input_floatNum">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">税率(%)<span field="taxRate" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<select name="taxRate" lay-filter="taxRate">' +
								'<option value="">请选择</option>' +
								'</select>' +
								'</div>' +
								'</div>' +
								'</div>',
								'</div>',
								/* endregion */
								/* region 第三行 */
								'<div class="layui-row">' +
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">不含税合同价(元)<span field="contractMoneyNotax" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="number" style="background: #e7e7e7;" name="contractMoneyNotax" readonly autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">合同签订日期<span field="signDate" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="signDate" readonly autocomplete="off" class="layui-input" style="cursor: pointer;" id="signDate">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">合同有效期<span field="contractPeriod" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="contractPeriod" autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">质保期<span field="warrantyPeriod" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="warrantyPeriod" autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">质保金(元)<span field="warrantyCash" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="warrantyCash" pointFlag="1" autocomplete="off" class="layui-input input_floatNum">' +
								'</div>' +
								'</div>' +
								'</div>',

								// '<div class="layui-col-xs2 layui_col">' +
								// '<div class="layui-form-item">' +
								// '<label class="layui-form-label form_label">履约金比例<span field="bondRatio" class="field_required">*</span></label>' +
								// '<div class="layui-input-block form_block">' +
								// '<input type="text" name="bondRatio" pointFlag="1" autocomplete="off" class="layui-input input_floatNum">' +
								// '</div>' +
								// '</div>' +
								// '</div>',
								'</div>',
								/* endregion */
								/* region 第四行 */
								'<div class="layui-row">' +
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">发票类型<span field="invoiceType" class="field_required">*</span></label>' +
								'<div class="layui-input-block form_block">' +
								'<select name="invoiceType" lay-filter="invoiceType"></select>' +
								'</div>' +
								'</div>' +
								'</div>',
								'               <div class="layui-col-xs2 layui_col" style="padding: 0 5px;">' +
								'                   <div class="layui-form-item">\n' +
								'                       <label class="layui-form-label form_label">合同类别<span field="contractCategory" class="field_required">*</span></label>\n' +
								'                       <div class="layui-input-block form_block">\n' +
								'                        <select name="contractCategory"><option value="">请选择</option></select>' +
								'                       </div>\n' +
								'                   </div>' +
								'               </div>' +
								'<div class="layui-col-xs2  layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">备注</label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="remark" autocomplete="off" class="layui-input">' +
								'</div>' +
								'</div>' +
								'</div>',
								'</div>',
								/* endregion */
								/* region 第五行 */
								'<div class="layui-tab layui-tab-brief">' +
								'<ul class="layui-tab-title">' +
								'<li class="layui-this">合同内容</li>' +
								'<li>合同范围</li>' +
								'<li>付款方式</li>' +
								'</ul>' +
								'<div class="layui-tab-content">' +
								'<div class="layui-tab-item layui-show">' +
								'<textarea name="contractContent" placeholder="请输入内容" class="layui-textarea"></textarea>' +
								'</div>' +
								'<div class="layui-tab-item">' +
								'<textarea name="contractScope" placeholder="请输入内容" class="layui-textarea"></textarea>' +
								'</div>' +
								'<div class="layui-tab-item">' +
								'<textarea name="paymentType" placeholder="请输入内容" class="layui-textarea"></textarea>' +
								'</div>' +
								'</div>' +
								'</div>' +
								/* endregion */
								/* region 第六行 */
								'<div class="layui-row">' +
								// '<div class="layui-col-xs2 layui_col">' +
								// '<div class="layui-form-item">' +
								// '<label class="layui-form-label form_label">比价附件</label>' +
								// '<div class="layui-input-block form_block">' +
								// '<div class="file_module">' +
								// '<div id="fileContentBJ" class="file_content"></div>' +
								// '<div class="file_upload_box">' +
								// '<a href="javascript:;" class="open_file">' +
								// '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
								// '<input type="file" multiple id="fileuploadBJ" data-url="/upload?module=planbudget" name="file">' +
								// '</a>' +
								// '<div class="progress">' +
								// '<div class="bar"></div>\n' +
								// '</div>' +
								// '<div class="bar_text"></div>' +
								// '</div>' +
								// '</div>' +
								// '</div>' +
								// '</div>' +
								// '</div>',
								'<div class="layui-col-xs2 layui_col">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">合同附件<span field="attachmentId" class="field_required">*</span></label>' +
								'<input id="contrastId" type="hidden" readonly autocomplete="off" class="layui-input">' +
								'<div class="layui-input-block form_block">' +
								'<div class="file_module">' +
								'<div id="fileContent" class="file_content"></div>' +
								'<div class="file_upload_box">' +
								'<a href="javascript:;" class="open_file">' +
								'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
								'<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
								'</a>' +
								'<div class="progress">' +
								'<div class="bar"></div>\n' +
								'</div>' +
								'<div class="bar_text"></div>' +
								'</div>' +
								'</div>' +
								'</div>' +
								'</div>' +
								'</div>',
								// '<div class="layui-col-xs2 layui_col">' +
								// '<div class="layui-form-item">' +
								// '<label class="layui-form-label form_label">材料比价</label>' +
								// '<div class="layui-input-block form_block">' +
								// '<input id="contrastId" type="text" readonly autocomplete="off" class="layui-input">' +
								// '</div>' +
								// '</div>' +
								// '</div>',
								'</div>',
								/* endregion */
								'</form>',
								'</div>',
								'</div>',
								/* endregion */
								/* region 材料明细 */
								'<div class="layui-colla-item"><h2 class="layui-colla-title">材料明细</h2>' +
								'<div class="layui-colla-content layui-show">' +
								'<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;">' +
								'<ul class="layui-tab-title">' +
								'<li class="layui-this">购买清单</li>' +
								'<li>付款结算</li>' +
								'<li>其他约定</li>' +
								'</ul>' +
								'<div class="layui-tab-content">' +
								'<div class="layui-tab-item layui-show contract_list">' +
								'<div id="contractDetailsModule"><table id="contractDetailsTable" lay-filter="contractDetailsTable"></table></div>' +
								'</div>' +
								'<div class="layui-tab-item contract_out">' +
								'<div id="paymentSettlementModule"><table id="paymentSettlementTable" lay-filter="paymentSettlementTable"></table></div>' +
								'</div>' +
								'<div class="layui-tab-item">' +
								'<textarea name="contractOtherContent" placeholder="请输入内容" class="layui-textarea"></textarea>' +
								'</div>' +
								'</div>' +
								'</div>' +
								'</div>' +
								'</div>',
								/* endregion */
								/* region 供应商比价 */
								'<div class="layui-colla-item"><h2 class="layui-colla-title">供应商比价</h2>' +
								'<div class="layui-colla-content layui-show">',
								'<div><table id="plbMtlContrastTable" lay-filter="plbMtlContrastTable"></table>' +
								'</div>',
								'</div>' +
								'</div>',
								/* endregion */
								/* region 其他 */
								'<div class="layui-colla-item"><h2 class="layui-colla-title">其他</h2>' +
								'<div class="layui-colla-content layui-show">',
								'<div class="layui-row">' +
								'<div class="layui-col-xs4" style="padding: 0 5px">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">编制人<span style="margin: 0 20px;">流程定义某节点为编制节点</span>编制时间</label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="createTime" autocomplete="off" readonly class="layui-input" id="createTime">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs4" style="padding: 0 5px">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">审批人<span style="margin: 0 20px;">流程定义某节点为审批节点</span>审批时间</label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="approvalerDate" autocomplete="off" readonly class="layui-input" id="approvalerDate">' +
								'</div>' +
								'</div>' +
								'</div>',
								'<div class="layui-col-xs4" style="padding: 0 5px">' +
								'<div class="layui-form-item">' +
								'<label class="layui-form-label form_label">审核人<span style="margin: 0 20px;">流程定义某节点为审核节点</span>审核时间</label>' +
								'<div class="layui-input-block form_block">' +
								'<input type="text" name="reviewerDate" autocomplete="off" readonly class="layui-input" id="reviewerDate">' +
								'</div>' +
								'</div>' +
								'</div>',
								'</div>',
								'</div>' +
								'</div>',
								/* endregion */
								'</div></div>'].join(''),
							success: function () {
								if(projId){
									//回显项目名称
									getProjName('#projectName',projId)
								}
								// 比价附件
								//fileuploadFn('#fileuploadBJ', $('#fileContentBJ'));
								// 合同附件
								fileuploadFn('#fileupload', $('#fileContent'));

								layElement.render();

								$('.base_info [name="contractType"]').html(dictionaryObj['CONTRACT_TYPE']['str']);
								$('.base_info [name="paymentType"]').html(dictionaryObj['PAYMENT_METHOD']['str']);
								$('.base_info [name="taxRate"]').append(dictionaryObj['TAX_RATE']['str']);
								$('.base_info [name="invoiceType"]').html(dictionaryObj['INVOICE_TYPE']['str']);
								$('[name="contractCategory"]').append(dictionaryObj['CONTRACT_CATEGORY']['str'])

								layForm.render();

								var contractDetailsTableData = [];
								var paymentSettlementTableData = [];
								var plbMtlContrastWithBLOBs = [];

								if (type == 2||type==5) {
									layForm.val("baseForm", data);

									// 比价附件
									//$('#fileContentBJ').html(getFileEleStr(data.attachmentBj, true));

									// 合同附件
									//$('#fileContent').html(getFileEleStr(data.attachments, true));

									if (data.attachments && data.attachments.length > 0) {
										var fileArr = data.attachments;
										$('#fileContent').append(echoAttachment(fileArr));
									}

									// 购买清单列表数据
									contractDetailsTableData = data.plbMtlContractLists || [];
									// 供应商比价列表数据
									if (data.plbMtlContrastWithBLOBs) {
										plbMtlContrastWithBLOBs.push(data.plbMtlContrastWithBLOBs);

										// 供应商比价id
										$('#contrastId').attr('contrastId', data.contrastId).val(data.plbMtlContrastWithBLOBs.contrastNo);
									}

									// 付款结算列表数据
									paymentSettlementTableData = data.plbMtlContractOuts || [];

									//编制时间
									$('[name="createTime"]').val(data.createTime);
									//审核时间
									$('[name="approvalerDate"]').val(data.approvalerDate);
									// 审批时间
									$('[name="reviewerDate"]').val(data.reviewerDate);

									// 其他约定
									$('[name="contractOtherContent"]').val(data.contractOtherContent);
									// 甲方
									$('#contractA').val((data.contractAName || '').replace(/,$/, ''));
									$('#contractA').attr('contractA', data.contractA);
									// 乙方
									$('#customerId').val(data.customerName || '');
									$('#customerId').attr('customerId', data.customerId || '');
								} else if (type == 1) {
									// 获取自动编号
									getAutoNumber({autoNumber: 'plbMtlContract'}, function (res) {
										$('input[name="documentNo"]', $('#baseForm')).val(res);
									});
									$('.refresh_no_btn').show().on('click', function () {
										getAutoNumber({autoNumber: 'plbMtlContract'}, function (res) {
											$('input[name="documentNo"]', $('#baseForm')).val(res);
										});
									});
								}

								var cols = [
									{type: 'numbers', title: '序号'},
									{
										field: 'mtlName', title: '材料名称', width: 200, templet: function (d) {
											if(d.mtlName){
												return '<input type="text" contractListId="' + (d.contractListId || '') + '" mtlLibId="' + (d.mtlLibId || '') + '" readonly name="mtlLibId" class="layui-input mtlLibId mtlName" style="height: 100%;" value="' + (d.mtlName ||"") + '">'
											}else if(d.mtlNameExt){
												return '<input type="text" contractListId="' + (d.contractListId || '') + '" mtlLibId="' + (d.mtlLibId || '') + '" readonly name="mtlLibId" class="layui-input mtlLibId mtlName" style="height: 100%;" value="' + (d.mtlNameExt ||"") + '">'
											}
										}
									},
									{
										field: 'mtlStandard', title: '材料规格', templet: function (d) {
											return '<span class="mtlStandard">' + (d.mtlStandard || '') + '</span>';
										}
									},
									{
										field: 'valuationUnit', title: '计量单位', templet: function (d) {
											// if (d.controlMode!=undefined&&d.controlMode == '01') {
											// 	return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
											// }else{
											// 	return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '')+'</span>';
											// }
											if(d.valuationUnit){
												return '<span class="mtlUnit" mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
											}else if(d.mtlUnit){
												return '<span class="mtlUnit" mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(d.mtlUnit || '')+'</span>';
											}else{
												return '<span class="mtlUnit" mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
											}										}
									},
									{
										field: 'amount', title: '数量', templet: function (d) {
											return '<input type="text" name="amount" pointFlag="1" pointNum="3" handleCallback="afterFloatChange" class="layui-input input_floatNum"  autocomplete="off" style="height: 100%;" value="' + (d.amount || "") + '">'
										}
									},
									{
										field: 'unitPrice', title: '含税单价(元)', templet: function (d) {
											return '<input type="text" name="unitPrice" pointFlag="1" pointNum="3" handleCallback="afterFloatChange" class="layui-input input_floatNum" autocomplete="off" style="height: 100%;" value="' + (d.unitPrice || "") + '">'
										}
									},
									{
										field: 'taxRate', title: '税率(%)', templet: function (d) {
											// 发票类型
											var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();
											//var readonly = invoiceType != '01' ? 'readonly' : '';
											var readonly = 'readonly';
											return '<input type="text" name="taxRate" ' + readonly + ' pointFlag="1" handleCallback="afterFloatChange" class="layui-input input_floatNum" autocomplete="off" style="height: 100%;background: #e7e7e7;" value="' + (d.taxRate || 0) + '">'
										}
									},
									{
										field: 'noTaxPrice', title: '不含税单价(元)', templet: function (d) {
											return '<span class="noTaxPrice">' + (d.noTaxPrice || 0) + '</span>'
										}
									},
									{
										field: 'totalIncludingTax', title: '含税合计(元)', templet: function (d) {
											return '<span class="totalIncludingTax">' + (d.totalIncludingTax || 0) + '</span>'
										}
									},
									{
										field: 'noTaxMoney', title: '不含税合计(元)', templet: function (d) {
											return '<span class="noTaxMoney">' + (d.noTaxMoney || 0) + '</span>'
										}
									},

								]

								var cols2 = [
									{type: 'numbers', title: '序号'},
									{
										field: 'contractMoney', title: '约定付款金额(元)', templet: function (d) {
											return '<input type="text" mtlContractOutId="' + (d.mtlContractOutId || '') + '" pointFlag="1" name="contractMoney" class="layui-input contractMoney input_floatNum" style="height: 100%;" value="' + (d.contractMoney || '') + '">'
										}
									},
									{
										field: 'contractRatio', title: '约定付款比例', templet: function (d) {
											return '<input type="text" name="contractRatio" class="layui-input contractRatio" style="height: 100%" value="' + (d.contractRatio || '') + '">'
										}
									},
									{
										field: 'paymentPeriod', title: '约定付款日期', templet: function (d) {
											return '<input type="text" name="paymentPeriod" readonly class="layui-input paymentPeriod" style="height: 100%;" value="' + (d.paymentPeriod || '') + '">'
										}
									},
									{
										field: 'termOfPayment', title: '付款条件', templet: function (d) {
											return '<input type="text" name="termOfPayment" class="layui-input termOfPayment" style="height: 100%;" value="' + (d.termOfPayment || '') + '">'
										}
									},

								]

								var cols3 = [
									{type: 'numbers', title: '序号'},
									{field: 'contrastNo', title: '比价编号'},
									{field: 'priceComparison', title: '比价事项'},
									{
										field: 'compareTime', title: '比价时间', templet: function (d) {
											return format(d.compareTime);
										}
									},
									{
										field: 'compareType', title: '比价方式', templet: function (d) {
											return dictionaryObj['COMPARE_TYPE']['object'][d.compareType] || ''
										}
									},
									{field: 'remark', title: '备注'},

								]
								if(type!=5){
									cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
									cols2.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
									cols3.push({fixed: 'right', title:'操作', toolbar: '#contTool', width:150})

								}
								// 初始化购买清单列表
								layTable.render({
									elem: '#contractDetailsTable',
									data: contractDetailsTableData,
									toolbar:type!=5?'#toolbarDemoIn':false,
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols]
								});

								// 初始化付款结算列表
								layTable.render({
									elem: '#paymentSettlementTable',
									data: paymentSettlementTableData,
									toolbar: type!=5?'#toolbarDemoIn':false,
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols2],
									done: function (res) {
										var datas = res.data;
										$('.contract_out').find('.paymentPeriod').each(function (i, v) {
											laydate.render({
												elem: v,
												trigger: 'click',
												value: datas[i].paymentPeriod || ''
											});
										});
									}
								});

								// 初始化供应商比价
								layTable.render({
									elem: '#plbMtlContrastTable',
									data: plbMtlContrastWithBLOBs,
									toolbar: type!=5?'#plbMtlContrastBar':false,
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols3]
								});

								if(type==5){
									$('._disabled').find('input,select,textarea').attr('disabled', 'disabled');
									//$('.file_upload_box').hide()
									$('#fileupload').attr('disabled', false);
									layForm.render();
								}

								//监听工具条
								layTable.on('tool(plbMtlContrastTable)', function(obj){
									var data = obj.data;
									if(obj.event === 'info'){ //查看比价详情
										layer.open({
											type: 1,
											title: '材料比价详情',
											area: ['90%', '80%'],
											content: ['<div class="layui-collapse">\n' +
											/* region 材料计划 */
											'  <div class="layui-colla-item">\n' +
											'    <h2 class="layui-colla-title">基本信息</h2>\n' +
											'    <div class="layui-colla-content layui-show plan_base_info">' +
											'       <form class="layui-form" id="baseForm" lay-filter="formTest">',
												/* region 第一行 */
												'           <div class="layui-row">' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">比价编号<span field="contrastNo" class="field_required">*</span></label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="contrastNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">比价事项<span field="priceComparison" class="field_required">*</span></label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="priceComparison" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'           </div>',
												/* endregion */
												/* region 第二行 */
												'           <div class="layui-row">' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">比价时间<span field="compareTime" class="field_required">*</span></label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="compareTime" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">比价方式</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                         <select disabled name="compareType"></select>' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'           </div>',
												/* endregion */
												/* region 第三行 */
												'           <div class="layui-row">' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">供应商1</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="customerId1" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">供应商2</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="customerId2" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'           </div>',
												/* endregion */
												/* region 第四行 */
												'           <div class="layui-row">' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">供应商3</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="customerId3" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">供应商4</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="customerId4" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'           </div>',
												/* endregion */
												/* region 第五行 */
												'           <div class="layui-row">' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">供应商5</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="customerId5" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">供应商6</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="customerId6" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'           </div>',
												/* endregion */
												/* region 第六行 */
												'           <div class="layui-row">' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">供应商7</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="customerId7" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">供应商8</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="customerId8" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'           </div>',
												/* endregion */
												/* region 第七行 */
												'           <div class="layui-row">' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">材料需求计划</label>\n' +
												'                       <div class="layui-input-block form_block">' +
												'                         <input type="text" name="mtlPlanId" readonly autocomplete="off" class="layui-input chooseMtlPlanId" style="background:#e7e7e7;">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">备注</label>\n' +
												'                       <div class="layui-input-block form_block">\n' +
												'                       <input type="text" name="remark" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'           </div>',
												/* endregion */
												/* region 第八行 */
												'           <div class="layui-row">' +
												'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
												'                   <div class="layui-form-item">\n' +
												'                       <label class="layui-form-label form_label">附件</label>' +
												'                       <div class="layui-input-block form_block">' +
												'<div class="file_module">' +
												'<div id="fileContent1" class="file_content"></div>' +
												'</div>' +
												'                       </div>\n' +
												'                   </div>' +
												'               </div>' +
												'           </div>',
												/* endregion */
												'       </form>' +
												'    </div>\n' +
												'  </div>\n',
												/* endregion */
												/* region 出库明细 */
												'  <div class="layui-colla-item">\n' +
												'    <h2 class="layui-colla-title">比价明细</h2>\n' +
												'    <div class="layui-colla-content mtl_info layui-show">' +
												'           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
												'    </div>\n' +
												'  </div>\n',
												/* endregion */
												'</div>'].join(''),
											success: function (){
												$('[name="compareType"]').html(dictionaryObj['COMPARE_TYPE']['str'])
												layForm.render();

												layForm.val("formTest", data);

												//回显供应商信息
												$('[name="customerId1"]').val(data.customerName1);
												$('[name="customerId2"]').val(data.customerName2);
												$('[name="customerId3"]').val(data.customerName3);
												$('[name="customerId4"]').val(data.customerName4);
												$('[name="customerId5"]').val(data.customerName5);
												$('[name="customerId6"]').val(data.customerName6);
												$('[name="customerId7"]').val(data.customerName7);
												$('[name="customerId8"]').val(data.customerName8);

												if(data.mtlPlanId){
													$.get('/plbMtlPlanList/selectAll',{mtlPlanId:data.mtlPlanId},function (res) {
														$('.plan_base_info input[name="mtlPlanId"]').val(res.object.planName);
													})
												}

												// $('#fileContent1').html(getFileEleStr(data.attachments, false));
												//附件
												if (data.attachments && data.attachments.length > 0) {
													var fileArr = data.attachments;
													$('#fileContent1').append(echoAttachment(fileArr));
												}

												//遍历供应商，判断供应商是否显示
												var colsArr = []
												$('.chooseEquivalent').each(function () {
													if ($(this).val()) {
														colsArr.push(false)
													} else {
														colsArr.push(true)
													}
												});
												//回显表格数据
												var showCols = [
													{type: 'numbers', title: '序号'},
													{field: 'planMtlName', title: '材料名称', width: 150,},
													{
														field: 'planMtlStandard', title: '材料规格', width: 100, templet: function (d) {
															return '<span>' + (d.planMtlStandard || '') + '</span>';
														}
													},
													{
														field: 'valuationUnit', title: '计量单位', width: 100, templet: function (d) {
															// if (d.controlMode!=undefined&&d.controlMode == '01') {
															// 	return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
															// }else{
															// 	return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '')+'</span>';
															// }
															return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
														}
													},
												]
												detailCols.forEach(function (item, index) {
													item.hide = colsArr[index]
													showCols.push(item)
												});
												var materialDetailsTableData =  data.plbMtlContrastListWithBLOBs || [];
												loadDetail(showCols, materialDetailsTableData);
											}
										});
									}
								});

								// 初始化供应商比价
								function loadDetail(showCols, materialDetailsTableData) {
									showCols.push(
											{field: 'chooseUnit', title: '选中供应商单价'}
									)
									layTable.render({
										elem: '#materialDetailsTable',
										data: materialDetailsTableData,
										limit: 1000,
										cols: [showCols]
									});
								}

								// 合同签订日期
								laydate.render({
									elem: '#signDate',
									trigger: 'click'
								});
								// 编制时间
								laydate.render({
									elem: '#createTime',
									trigger: 'click',
									format: 'yyyy-MM-dd HH:mm:ss'
								});
								// 审批时间
								laydate.render({
									elem: '#approvalerDate',
									trigger: 'click',
									format: 'yyyy-MM-dd HH:mm:ss'
								});
								// 审核时间
								laydate.render({
									elem: '#reviewerDate',
									trigger: 'click',
									format: 'yyyy-MM-dd HH:mm:ss'
								});

								// 选择甲方
								$('#contractA').on('click', function () {
									chooseCustomer(1, $(this));
								});
								// 选择乙方
								$('#customerId').on('click', function () {
									chooseCustomer(2, $(this));
								});

								// 选择发票类型
								layForm.on('select(invoiceType)', function (data) {
									if (data.value == '01') {
										// 税率可修改
										$('#contractDetailsModule').find('[name="taxRate"]').attr('readonly', false);
									} else {
										// 税率不可修改
										$('#contractDetailsModule').find('[name="taxRate"]').attr('readonly', true);
									}
									computedAmount();

									computedContractMoney();
								});
								// 选择税率
								layForm.on('select(taxRate)', function (data) {
									var invoiceType = $('[name="invoiceType"]', $('#baseForm')).val();

									// 税率
									var taxRate = checkFloatNum(dictionaryObj['TAX_RATE']['object'][data.value] || '');

									$('#contractDetailsModule').find('[name="taxRate"]').val(taxRate);

									if (invoiceType == '01') {
										computedAmount();

										computedContractMoney();
									}
								});

								// 选择客商
								function chooseCustomer(type, $this) {
									var title = '';
									var id = '';
									if (type == 1) {
										title = '选择甲方';
										id = 'contractA';
									} else {
										title = '选择乙方';
										id = 'customerId';
									}
									layer.open({
										type: 1,
										title: title,
										area: ['70%', '80%'],
										maxmin: true,
										btn: ['确定', '取消'],
										btnAlign: 'c',
										content: ['<div class="container">',
											'<div class="wrapper">',
											'<div class="wrap_left" style="border-right: 1px solid #ccc;">' +
											'<div class="layui-form">' +
											'<div class="tree_module" style="top: 0;">' +
											'<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
											'</div>' +
											'</div>' +
											'</div>',
											'<div class="wrap_right" style="padding-left: 10px;">' +
											'<div class="mtl_table_box" style="display: none;">' +
											'       <div class="layui-row inSearchContent">' +
											'             <div class="layui-col-xs4">\n' +
											'                  <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
											'             </div>\n' +
											'             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
											'                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
											'             </div>\n' +
											'       </div>'+
											'<table id="materialsTable" lay-filter="materialsTable"></table>' +
											'</div>' +
											'<div class="mtl_no_data" style="text-align: center;">' +
											'<div class="no_data_img" style="margin-top:12%;">' +
											'<img style="margin-top: 2%;" src="/img/noData.png">' +
											'</div>' +
											'<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧客商类型</p>' +
											'</div>' +
											'</div>',
											'</div></div>'].join(''),
										success: function () {
											// 获取左侧树
											$.get('/PlbCustomerType/treeList', function (res) {
												if (res.flag) {
													eleTree.render({
														elem: '#chooseMtlTree',
														data: res.data,
														highlightCurrent: true,
														showLine: true,
														defaultExpandAll: false,
														request: {
															name: 'typeName',
															children: "child",
														}
													});
												}
											});

											// 树节点点击事件
											eleTree.on("nodeClick(chooseMtlTree)", function (d) {
												$('.mtl_no_data').hide();
												$('.mtl_table_box').show();
												loadMtlTable(d.data.currentData.typeNo);
											});

											function loadMtlTable(merchantType) {
												 materialsTable=layTable.render({
													elem: '#materialsTable',
													url: '/PlbCustomer/getDataByCondition',
													where: {
														merchantType: merchantType
													},
													page: true,
													response: {
														statusName: 'flag',
														statusCode: true,
														msgName: 'msg',
														countName: 'totleNum',
														dataName: 'data'
													},
													cols: [[
														{type: 'radio', title: '选择'},
														{field: 'customerNo', title: '客商编号'},
														{field: 'customerName', title: '客商单位名称'},
														{field: 'customerShortName', title: '客商单位简称'},
													]]
												});
											}
										},
										yes: function (index) {
											var checkStatus = layTable.checkStatus('materialsTable');
											if (checkStatus.data.length > 0) {
												var mtlData = checkStatus.data[0];
												$this.val(mtlData.customerName);
												$this.attr(id, mtlData.customerId);
												layer.close(index);
											} else {
												layer.msg('请选择一项！', {icon: 0});
											}
										}
									});
								}
							},
							yes: function (index) {
								var loadIndex = layer.load();

								var baseData = {}
								if(type!=5){
									baseData = getSaveData(type, false, loadIndex, mtlContractId, projId).dataObj;
								}else {
									// 合同附件
									var attachmentId = '';
									var attachmentName = '';
									for (var i = 0; i < $('#fileContent .dech').length; i++) {
										attachmentId += $('#fileContent .dech').eq(i).find('input').val();
										attachmentName += $('#fileContent a').eq(3*i).attr('name');
									}
									baseData.attachmentId = attachmentId;
									baseData.attachmentName = attachmentName;
									baseData.mtlContractId = mtlContractId;
								}

								$.ajax({
									url: url,
									data: JSON.stringify(baseData),
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
							},
							btn2: function (index) {
								if(type==5){
									layer.close(index);
									return false;
								}

								// 提交前先保存
								var loadIndex = layer.load();

								var baseData = getSaveData(type, true, loadIndex, mtlContractId, projId);

								$.ajax({
									url: url,
									data: JSON.stringify(baseData.dataObj),
									dataType: 'json',
									contentType: "application/json;charset=UTF-8",
									type: 'post',
									success: function (res) {
										layer.close(loadIndex);
										if (res.flag) {
											var resultData = res.data;
											if (type == 1) {
												mtlContractId = res.object;
											}
											layer.open({
												type: 1,
												title: '选择流程',
												area: ['70%', '80%'],
												btn: ['确定', '取消'],
												btnAlign: 'c',
												content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
												success: function () {
													$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '18'}, function (res) {
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
														var approvalData = resultData;
														approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
														approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;

														newWorkFlow(flowData.flowId, JSON.stringify(approvalData), function (res) {
															// 报销单保存关联的runId
															var submitData = {
																mtlContractId: mtlContractId,
																runId: res.flowRun.runId,
																//auditerStatus: '1'
															}
															$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

															$.ajax({
																url: '/plbMtlContract/update',
																data: JSON.stringify(submitData),
																dataType: 'json',
																contentType: "application/json;charset=UTF-8",
																type: 'post',
																success: function (res) {
																	layer.close(loadIndex);
																	if (res.flag) {
																		layer.closeAll();
																		layer.msg('提交成功!', {icon: 1});
																		tableObj.config.where._ = new Date().getTime();
																		tableObj.reload();
																	} else {
																		layer.msg(res.msg, {icon: 2});
																	}
																}
															});
														});
													} else {
														layer.close(loadIndex);
														layer.msg('请选择一项！', {icon: 0});
													}
												}
											});
										} else {
											layer.msg(res.msg, {icon: 2});
										}
									}
								});
								return false;
							}
						});
					}

					// 查询
					$('#searchBtn').on('click', function () {
						tableInit($('#leftId').attr('projId') || '');
					});

					// 高级查询
					$('#advancedQuery').on('click', function () {
						layer.msg('功能完善中')
					});

					//选择分包商内侧查询
					$(document).on('click','.inSearchData',function () {
						var searchParams = {}
						var $seachData = $('.inSearchContent [name]')
						$seachData.each(function () {
							searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
						})
						materialsTable.reload({
							where: searchParams,
							page: {
								curr: 1 //重新从第 1 页开始
							}
						});
					});
					/**
					 * 获取查询条件
					 * @returns {{planNo: (*), planName: (*)}}
					 */
					function getSearchObj() {
						var searchObj = {
							contractNo: $('input[name="contractNo"]', $('.query_module')).val(),
							contractName: $('input[name="contractName"]', $('.query_module')).val(),
							customerName: $('input[name="customerName"]', $('.query_module')).val(),
							auditerStatus: $('input[name="auditerStatus"]', $('.query_module')).val()
						}

						return searchObj
					}

					/**
					 * 获取需要保存的数据
					 * @param saveType (1-新增, 2-编辑)
					 * @param isSubmit (是否提交)
					 * @param loadIndex
					 * @param mtlContractId (采购合同id)
					 */
					function getSaveData(saveType, isSubmit, loadIndex, mtlContractId, projId) {
						//材料计划数据
						var datas = $('#baseForm').serializeArray();
						var dataObj = {}
						datas.forEach(function (item) {
							dataObj[item.name] = item.value;
						});
						// 甲方
						dataObj.contractA = ($('#contractA').attr('contractA') || '').replace(/,$/, '');
						// 乙方
						dataObj.customerId = $('#customerId').attr('customerId') || '';

						//含税合同金额(元)
                        dataObj.contractMoney = retainDecimal($('[name=contractMoney]').val(),2);
                        //预付款(元)
                        dataObj.paymentPre = retainDecimal($('[name=paymentPre]').val(),2);
                        //不含税合同价(元)
                        dataObj.contractMoneyNotax = retainDecimal($('[name=contractMoneyNotax]').val(),2);
                        //质保金(元)
                        dataObj.warrantyCash = retainDecimal($('[name=warrantyCash]').val(),2);

						// 比价附件
						var attachmentIdBj = '';
						var attachmentNameBj = '';
						for (var i = 0; i < $('#fileContentBJ .dech').length; i++) {
							attachmentIdBj += $('#fileContentBJ .dech').eq(i).find('input').val();
							attachmentNameBj += $('#fileContentBJ a').eq(i).attr('name');
						}
						dataObj.attachmentIdBj = attachmentIdBj;
						dataObj.attachmentNameBj = attachmentNameBj;

						// 合同附件
						var attachmentId = '';
						var attachmentName = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName += $('#fileContent a').eq(3*i).attr('name');
						}
						dataObj.attachmentId = attachmentId;
						dataObj.attachmentName = attachmentName;

						var baseObj = JSON.parse(JSON.stringify(dataObj));

						//if (isSubmit) {
							// 判断必填项
							var requiredFlag = false;
							$('#baseForm').find('.field_required').each(function () {
								var field = $(this).attr('field');
								if (field && !dataObj[field] && dataObj[field] != '0') {
									var fieldName = $(this).parent().text().replace('*', '');
									if(field=="attachmentId"){
										if(attachmentId==""){
											layer.msg(fieldName + '不能为空！', {icon: 0, time: 2000});
											requiredFlag = true;
											return false;
										}
									}else if(field=="taxRate"){
										layer.msg("税率" + '不能为空！', {icon: 0, time: 2000});
										requiredFlag = true;
										return false;
									}else{
										layer.msg(fieldName + '不能为空！', {icon: 0, time: 2000});
										requiredFlag = true;
										return false;
									}
								}
							});
							if (requiredFlag) {
								layer.close(loadIndex);
								return false;
							}
						//}

						// 购买清单数据
						var $tr1 = $('#contractDetailsModule').find('.layui-table-main tr');
						var plbMtlContractLists = [];
						$tr1.each(function () {
							var plbMtlContractObj = {
								mtlLibId: $(this).find('input[name="mtlLibId"]').attr('mtlLibId') || '',
								unitPrice: retainDecimal($(this).find('input[name="unitPrice"]').val(),3),
								taxRate: $(this).find('input[name="taxRate"]').val(),
								amount: retainDecimal($(this).find('input[name="amount"]').val(),3),
								noTaxPrice: retainDecimal($(this).find('.noTaxPrice').text(),8),
								mtlNameExt: $(this).find('.mtlNameExt').text(),
								mtlUnit: $(this).find('.mtlUnit').text(),
								valuationUnit: $(this).find('.valuationUnit').text(),
								noTaxMoney: retainDecimal($(this).find('.noTaxMoney').text(),2),
								totalIncludingTax: retainDecimal($(this).find('.totalIncludingTax').text(),2)
							}
							if ($(this).find('input[name="mtlLibId"]').attr('contractListId')) {
								plbMtlContractObj.contractListId = $(this).find('input[name="mtlLibId"]').attr('contractListId');
							}
							plbMtlContractLists.push(plbMtlContractObj);
						});
						dataObj.plbMtlContractLists = plbMtlContractLists;

						// 付款结算数据
						var $tr2 = $('#paymentSettlementModule').find('.layui-table-main tr');
						var plbMtlContractOuts = [];
						$tr2.each(function () {
							var plbMtlContractObj = {
								contractMoney: $(this).find('input[name="contractMoney"]').val(),
								contractRatio: $(this).find('input[name="contractRatio"]').val(),
								paymentPeriod: $(this).find('input[name="paymentPeriod"]').val(),
								termOfPayment: $(this).find('input[name="termOfPayment"]').val()
							}
							if ($(this).find('input[name="contractMoney"]').attr('mtlContractOutId')) {
								plbMtlContractObj.mtlContractOutId = $(this).find('input[name="contractMoney"]').attr('mtlContractOutId');
							}
							plbMtlContractOuts.push(plbMtlContractObj);
						});
						dataObj.plbMtlContractOuts = plbMtlContractOuts;

						// 供应商比价
						dataObj.contrastId = $('#contrastId').attr('contrastId') || '';

						// 其他约定
						dataObj.contractOtherContent = $('[name="contractOtherContent"]').val();

						//编制时间
						dataObj.createTime = $('[name="createTime"]').val();

						//审批时间
						dataObj.approvalerDate = $('[name="approvalerDate"]').val();

						//审核时间
						dataObj.reviewerDate = $('[name="reviewerDate"]').val();

						// 编辑
						if (saveType == 2) {
							dataObj.mtlContractId = mtlContractId;
						} else {
							// 项目ID
							dataObj.projId = projId;
						}

						return {
							dataObj: dataObj,
							baseObj: baseObj
						}
					}

					/*region 导出 */
					$(document).on('click', function () {
						$('.export_moudle').hide();
					});
					$(document).on('click', '.export_btn', function () {
						var type = $(this).attr('type');
						var fileName = '材料采购合同列表.xlsx';
						if (type == 1) {
							var checkStatus = layTable.checkStatus('tableObj');
							if (checkStatus.data.length == 0) {
								layer.msg('请选择需要导出的数据！', {icon: 0, time: 1500});
								return false;
							}
							soulTable.export(tableObj, {
								filename: fileName,
								checked: true
							});
						} else if (type == 2) {
							soulTable.export(tableObj, {
								filename: fileName,
								curPage: true
							});
						} else if (type == 3) {
							soulTable.export(tableObj, {
								filename: fileName
							});
						}
					});
					/* endregion */
				});
			}

			function afterFloatChange(value, ele) {
				var invoiceTypeFlag = $('[name="invoiceType"]', $('#baseForm')).val() == '01';
				var $tr = $(ele).parents('tr');
				computedToal($tr, invoiceTypeFlag);
				computedContractMoney();
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

			/**
			 * 重新计算购买清单数据
			 */
			function computedAmount() {
				var invoiceTypeFlag = $('[name="invoiceType"]', $('#baseForm')).val() == '01';

				var $tr = $('#contractDetailsModule').find('.layui-table-main tr');
				$tr.each(function () {
					var $this = $(this);
					computedToal($this, invoiceTypeFlag);
				});
			}

			/**
			 * 购买清单-计算含税合计和不含税合计
			 * @param $tr
			 * @param invoiceTypeFlag
			 */
			function computedToal($tr, invoiceTypeFlag) {
				// 含税单价
				var unitPrice = checkFloatNum($tr.find('[name="unitPrice"]').val(), 3);

				// 数量
				var amount = checkFloatNum($tr.find('[name="amount"]').val(), 3);

				// 税率
				var taxRate = BigNumber(invoiceTypeFlag ? checkFloatNum($tr.find('[name="taxRate"]').val()) : 0);

				// 含税合计 (含税单价 * 数量)
				var totalIncludingTax = BigNumber(unitPrice).multipliedBy(amount);
				$tr.find('.totalIncludingTax').text(checkFloatNum(totalIncludingTax));

				// 不含税合计 (含税合计 / (1 + 税率))
				var noTaxMoney = checkFloatNum(totalIncludingTax.dividedBy(taxRate.dividedBy(100).plus(1)));
				$tr.find('.noTaxMoney').text(noTaxMoney);

				// 不含税单价 (含税单价 / (1 + 税率))
				var noTaxPrice = checkFloatNum(BigNumber(unitPrice).dividedBy(taxRate.dividedBy(100).plus(1)), 3);
				$tr.find('.noTaxPrice').text(noTaxPrice);
			}

			/**
			 * 计算主表含税合同金额和不含税合同金额
			 */
			function computedContractMoney() {
				var invoiceTypeFlag = $('[name="invoiceType"]', $('#baseForm')).val() == '01';

				// 含税合同金额
				var contractMoney = 0;

				// 税率
				var taxRate = BigNumber(invoiceTypeFlag ? checkFloatNum(dictionaryObj['TAX_RATE']['object'][$('[name="taxRate"]', $('#baseForm')).val()] || '') : 0);

				var $tr = $('#contractDetailsModule').find('.layui-table-main tr');
				$tr.each(function () {
					var totalIncludingTax = checkFloatNum($(this).find('.totalIncludingTax').text());
					contractMoney = BigNumber(contractMoney).plus(totalIncludingTax);
				});

				// 不含税合同金额 (含税合同金额 / (1 + 税率))
				var contractMoneyNotax = checkFloatNum(BigNumber(contractMoney).dividedBy(BigNumber(taxRate).dividedBy(100).plus(1)));

				$('[name="contractMoneyNotax"]', $('#baseForm')).val(contractMoneyNotax);

				$('[name="contractMoney"]', $('#baseForm')).val(contractMoney);
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
				tableObj.reload({
					page: {
						curr: 1 //重新从第 1 页开始
					}
				});
			}
		</script>
	</body>
</html>
