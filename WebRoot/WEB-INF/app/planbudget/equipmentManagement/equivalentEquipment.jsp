<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/3/16
  Time: 9:46
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
		<title>设备比价</title>

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
		<script type="text/javascript" src="/js/planbudget/common.js?20210604.1"></script>

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
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId" class="layui-input">
			<div class="wrapper">
				<div class="wrap_left">
					<h2 style="text-align: center;line-height: 35px;">设备比价</h2>
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
							<input type="text" name="equipmentNo" placeholder="比价编号" autocomplete="off" class="layui-input">
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
							<button type="button" class="layui-btn layui-btn-sm">高级查询</button>
						</div>
						<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
							<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
							<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
						</div>
					</div>
					<div style="position: relative">
						<div class="table_box">
							<table id="tableObj" lay-filter="tableObj"></table>
						</div>
						<div class="no_data" style="text-align:center;display:none">
							<div class="no_data_img" style="margin-top:12%;">
								<img style="margin-top: 2%;" src="/img/noData.png">
							</div>
							<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧部门</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script type="text/html" id="toolbarHead">
			<div class="layui-btn-container" style="height: 30px;">
				<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">新增</button>
				<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
				<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>
			</div>
			<div style="position:absolute;top: 10px;right:60px;">
				<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">
					<img src="/img/planCheck/导入.png" style="width: 20px;height: 20px;margin-top: -4px;">导入
				</button>
				<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">
					<img src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出
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
                <button class="layui-btn layui-btn-sm" lay-event="selectPlbMtl">选择材料需求计划</button>
                <button class="layui-btn layui-btn-sm" lay-event="selectMtl">选择材料</button>
            </div>
        </script>

		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
		</script>

		<script type="text/html" id="toolBar">
			<a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="detail">查看详情</a>
		</script>

		<script>
			var tipIndex = null
			$('.icon_img').hover(function () {
				var tip = $(this).attr('text');
				tipIndex = layer.tips(tip, this);
			}, function () {
				layer.close(tipIndex);
			});

			// 表格显示顺序
			var colShowObj = {
				equipmentNo: {field: 'equipmentNo', title: '比价编号', sort: true, hide: false},
				priceComparison: {field: 'priceComparison', title: '比价事项', hide: false},
				projName: {field: 'projName', title: '所属项目', sort: true, hide: false},
				compareTime: {
					field: 'compareTime', title: '比价时间', sort: true, hide: false, templet: function (d) {
						return format(d.compareTime);
					}
				},
				compareType: {
					field: 'compareType', title: '比价方式', sort: true, hide: false, templet: function (d) {
						return dictionaryObj['COMPARE_TYPE']['object'][d.compareType] || '';
					}
				},
				approvalStatus: {
					field: 'approvalStatus',
					title: '审核状态',
					sort: true,
					hide: false,
					templet: function (d) {
						if (d.approvalStatus == '1') {
							return '<span style="color: orange">审批中</span>';
						} else if (d.approvalStatus == '2') {
							return '<span style="color: green">批准</span>';
						} else if (d.approvalStatus == '3') {
							return '<span style="color: red">不批准</span>';
						} else {
							return '未提交';
						}
					}
				},
				remark: {field: 'remark', title: '备注', hide: false},
				attachmentName: {field: 'attachmentName', title: '附件', hide: false}
			}

			var TableUIObj = new TableUI('plb_mtl_equipment');

			var dictionaryObj = {
				COMPARE_TYPE: {}
			}
			var dictionaryStr = 'COMPARE_TYPE';
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

			layui.use(['form', 'laydate', 'table', 'soulTable', 'eleTree', 'element'], function () {
				var layForm = layui.form,
						laydate = layui.laydate,
						layTable = layui.table,
						eleTree = layui.eleTree,
						element = layui.element,
						soulTable = layui.soulTable;

				var table = layui.table;
				layForm.render();

				var tableObj = null;

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
								defaultExpandAll: true,
								request: {
									name: 'name',
									children: "plbProjList",
								}
							});
							TableUIObj.init(colShowObj, function () {
								tableShow();
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

				// 内部加行按钮
				layTable.on('toolbar(equipmentListTable)', function (obj) {
					switch (obj.event) {
						case 'add':
							//遍历表格获取每行数据进行保存
							var $tr = $('.mtl_info_detail').find('.layui-table-main tr');
							var oldDataArr = [];
							$tr.each(function () {
								var oldDataObj = {
									equipmentListId: $(this).find('input[name="budgetItemName"]').attr('equipmentListId') || '',
									budgetItemId: $(this).find('input[name="budgetItemName"]').attr('budgetItemId') || '',
									projBudgetId: $(this).find('input[name="budgetItemName"]').attr('projBudgetId') || '',
									budgetItemName: $(this).find('input[name="budgetItemName"]').val(),
									customerId1: $(this).find('input[name="customerName1"]').attr('customerId') || '',
									customerName1: $(this).find('input[name="customerName1"]').val(),
									customerUnit1: $(this).find('input[name="customerUnit1"]').val(),
									customerId2: $(this).find('input[name="customerName2"]').attr('customerId') || '',
									customerName2: $(this).find('input[name="customerName2"]').val(),
									customerUnit2: $(this).find('input[name="customerUnit2"]').val(),
									customerId3: $(this).find('input[name="customerName3"]').attr('customerId') || '',
									customerName3: $(this).find('input[name="customerName3"]').val(),
									customerUnit3: $(this).find('input[name="customerUnit3"]').val(),
									customerId4: $(this).find('input[name="customerName4"]').attr('customerId') || '',
									customerName4: $(this).find('input[name="customerName4"]').val(),
									customerUnit4: $(this).find('input[name="customerUnit4"]').val(),
									customerId5: $(this).find('input[name="customerName5"]').attr('customerId') || '',
									customerName5: $(this).find('input[name="customerName5"]').val(),
									customerUnit5: $(this).find('input[name="customerUnit5"]').val(),
									chooseCustomerId: $(this).find('input[name="chooseCustomerName"]').attr('customerId') || '',
									chooseCustomerName: $(this).find('input[name="chooseCustomerName"]').val(),
									chooseUnit: $(this).find('input[name="chooseUnit"]').val()
								}
								oldDataArr.push(oldDataObj);
							});
							oldDataArr.push({});
							table.reload('equipmentListTable', {
								data: oldDataArr
							});
							break;
					}
				});
				// 内部删行操作
				table.on('tool(equipmentListTable)', function (obj) {
					var data = obj.data;
					var layEvent = obj.event;
					if (layEvent === 'del') {
						obj.del();
						if (data.equipmentListId) {
							$.get('/plbMtlEquipment/delete', {equipmentListIds: data.equipmentListId}, function (res) {

							});
						}
						//遍历表格获取每行数据进行保存
						var $tr = $('.mtl_info_detail').find('.layui-table-main tr');
						var oldDataArr = [];
						$tr.each(function () {
							var oldDataObj = {
								equipmentListId: $(this).find('input[name="budgetItemName"]').attr('equipmentListId') || '',
								budgetItemId: $(this).find('input[name="budgetItemName"]').attr('budgetItemId') || '',
								projBudgetId: $(this).find('input[name="budgetItemName"]').attr('projBudgetId') || '',
								budgetItemName: $(this).find('input[name="budgetItemName"]').val(),
								customerId1: $(this).find('input[name="customerName1"]').attr('customerId') || '',
								customerName1: $(this).find('input[name="customerName1"]').val(),
								customerUnit1: $(this).find('input[name="customerUnit1"]').val(),
								customerId2: $(this).find('input[name="customerName2"]').attr('customerId') || '',
								customerName2: $(this).find('input[name="customerName2"]').val(),
								customerUnit2: $(this).find('input[name="customerUnit2"]').val(),
								customerId3: $(this).find('input[name="customerName3"]').attr('customerId') || '',
								customerName3: $(this).find('input[name="customerName3"]').val(),
								customerUnit3: $(this).find('input[name="customerUnit3"]').val(),
								customerId4: $(this).find('input[name="customerName4"]').attr('customerId') || '',
								customerName4: $(this).find('input[name="customerName4"]').val(),
								customerUnit4: $(this).find('input[name="customerUnit4"]').val(),
								customerId5: $(this).find('input[name="customerName5"]').attr('customerId') || '',
								customerName5: $(this).find('input[name="customerName5"]').val(),
								customerUnit5: $(this).find('input[name="customerUnit5"]').val(),
								chooseCustomerId: $(this).find('input[name="chooseCustomerName"]').attr('customerId') || '',
								chooseCustomerName: $(this).find('input[name="chooseCustomerName"]').val(),
								chooseUnit: $(this).find('input[name="chooseUnit"]').val()
							}
							oldDataArr.push(oldDataObj);
						});
						table.reload('equipmentListTable', {
							data: oldDataArr
						});
					} else if (layEvent === 'chooseMaterials') {
						var $tr = obj.tr;
						layer.open({
							type: 1,
							title: '选择',
							area: ['70%', '60%'],
							btnAlign: 'c',
							btn: ['确定', '取消'],
							content: '<div class="layui-form"><div><table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table></div></div>',
							success: function () {
								table.render({
									elem: '#mtlPlanIdTable',
									url: '/plbProjBudget/queryAll',
									where: {projId: $('#leftId').attr('projId')},
									page: true,
									cols: [[
										{type: 'radio', title: '选择'},
										{field: 'budgetItemName', title: '预算名称', width: 200,},
										{field: 'cbsName', title: 'CBS',},
										{
											field: 'manageTarAmount', title: '管理目标金额',
										}
									]],
									parseData: function (res) {
										return {
											"code": 0,
											"count": res.totleNum,
											"data": res.data
										}
									}
								});
							},
							yes: function (index) {
								var checkStatus = table.checkStatus('mtlPlanIdTable');
								if (checkStatus.data.length > 0) {
									var chooseData = checkStatus.data[0];
									$tr.find('[name="budgetItemName"]').val(chooseData.budgetItemName);
									$tr.find('[name="budgetItemName"]').attr('budgetItemId', chooseData.budgetItemId);
									$tr.find('[name="budgetItemName"]').attr('projBudgetId', chooseData.projBudgetId);
									layer.close(index);
								} else {
									layer.msg('请选择一项！', {icon: 0, time: 2000});
								}
							}
						});
					}
				});

				// 监听排序事件
				layTable.on('sort(tableObj)', function (obj) {
					var param = {
						orderbyFields: obj.field,
						orderbyUpdown: obj.type
					}

					TableUIObj.update(param, function () {
						tableShow($('#leftId').attr('projId'));
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

				// 监听列表头部按钮事件
				layTable.on('toolbar(tableObj)', function (obj) {
					var checkStatus = layTable.checkStatus(obj.config.id);
					switch (obj.event) {
						case 'add': // 新增
							if (!$('#leftId').attr('projId')) {
								layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
								return false;
							}
							addOrEdit(1);
							break;
						case 'edit': // 编辑
							if (checkStatus.data.length != 1) {
								layer.msg('请选择一条需要编辑的数据！', {icon: 0, time: 1500});
								return false;
							}

							if (checkStatus.data[0].approvalStatus > 0) {
								layer.msg('该条数据已提交，不可编辑！', {icon: 0});
								return false;
							}

							// 设备比价信息
							$.get('/plbMtlEquipment/queryId', {equipmentId: checkStatus.data[0].equipmentId}, function (res) {
								if (res.flag) {
									addOrEdit(2, res.object);
								} else {
									layer.msg('获取信息失败！', {icon: 0});
								}
							});
							break;
						case 'del': // 删除
							if (checkStatus.data.length == 0) {
								layer.msg('请选择需要删除的数据！', {icon: 0, time: 1500});
								return false;
							}

							var equipmentIds = '';

							checkStatus.data.forEach(function (item) {
								if (!(checkStatus.data[0].approvalStatus > 0)) {
									equipmentIds += item.equipmentId + ',';
								}
							});

							layer.confirm('确定删除该条数据吗？', function (index) {
								$.post('/plbMtlEquipment/delete', {equipmentIds: equipmentIds}, function (res) {
									layer.close(index)
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
						case 'import': // 导入
							layer.msg('导入');
							break;
						case 'export': // 导出
							$('.export_moudle').show();
							break;
					}
				});
				layTable.on('tool(tableObj)', function (obj) {
					var data = obj.data;
					var layEvent = obj.event;
					if (layEvent === 'detail') {
						layer.open({
							type: 2,
							title: '设备比价详情',
							area: ['100%', '100%'],
							content: '/plbMtlEquipment/equivalentEquipmentPreview?type=2&equipmentId=' + data.equipmentId
						});
					}
				});

				/**
				 * 加载表格方法
				 */
				function tableShow(projId) {
					var searchObj = getSearchObj();
					searchObj.projId = projId || '';
					searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
					searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;

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
						url: '/plbMtlEquipment/selectAll',
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
				function addOrEdit(type, data) {
					var title = '';
					var url = '';
					var equipmentId = '';
					var projId = $('#leftId').attr('projId');
					if (type == 1) {
						title = '新增设备比价';
						url = '/plbMtlEquipment/insert';
					} else if (type == 2) {
						title = '编辑设备比价';
						url = '/plbMtlEquipment/update';
						equipmentId = data.equipmentId;
						projId = data.projId;
					}

					layer.open({
						type: 1,
						title: title,
						area: ['100%', '100%'],
						btn: ['保存', '提交', '取消'],
						btnAlign: 'c',
						content: ['<div class="layui-collapse">',
							'<div class="layui-colla-item">',
							'<h2 class="layui-colla-title">设备比价详情</h2>',
							'<div class="layui-colla-content layui-show">',
							'<form class="layui-form" id="baseForm" lay-filter="baseForm">',
							/* region 第一行 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">比价编号<span field="mtlLeasecontractNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="equipmentNo" autocomplete="off" class="layui-input chen"  style="background: #e7e7e7" title="比价编号">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">比价事项<span class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" name="priceComparison" autocomplete="off" class="layui-input chen" title="比价事项">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">比价时间<span class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="compareTime" id="compareTime" autocomplete="off" class="layui-input chen" title="比价时间">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">比价方式<span class="field_required">*</span></label>' +
							'<div class="layui-input-block form_block">' +
							'<select name="compareType"></select>' +
							'</div>' +
							'</div>' +
							'</div>',
							'</div>',
							/* endregion */
							/* region 第二行 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">分包商1</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerId1" customer="1" autocomplete="off" class="layui-input choose_customer" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">分包商2</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerId2" customer="2" autocomplete="off" class="layui-input choose_customer" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">分包商3</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerId3" customer="3" autocomplete="off" class="layui-input choose_customer" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">分包商4</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerId4" customer="4" autocomplete="off" class="layui-input choose_customer" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'</div>',
							/* endregion */
							/* region 第三行 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">分包商5</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerId5" customer="5" autocomplete="off" class="layui-input choose_customer" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">分包商6</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerId6" customer="6" autocomplete="off" class="layui-input choose_customer" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">分包商7</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerId7" customer="7" autocomplete="off" class="layui-input choose_customer" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">分包商8</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="customerId8" customer="8" autocomplete="off" class="layui-input choose_customer" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'</div>',
							/* endregion */
							/* region 第四行 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs3" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">材料需求计划</label>' +
							'<div class="layui-input-block form_block">' +
							'<input type="text" readonly name="mtlPlanId" autocomplete="off" class="layui-input choose_mtlPlanId" style="background-color: #e7e7e7; cursor: pointer;">' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="layui-col-xs9" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">备注</label>' +
							'<div class="layui-input-block form_block">' +
							'<textarea name="remark" placeholder="请输入内容" class="layui-textarea"></textarea>' +
							'</div>' +
							'</div>' +
							'</div>',
							'</div>',
							/* endregion */
							'</form>',
							/* region 附件 */
							'<div class="layui-row">' +
							'<div class="layui-col-xs12" style="padding: 0 5px">' +
							'<div class="layui-form-item">' +
							'<label class="layui-form-label form_label">附件<span class="field_required">*</span></label>' +
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
							'</div>',
							/* endregion */
							'</div></div>',
							'<div class="layui-colla-item">',
							'<h2 class="layui-colla-title">设备比价明细</h2>',
							'<div class="layui-colla-content mtl_info_detail layui-show">',
							'<table id="equipmentListTable" lay-filter="equipmentListTable"></table>',
							'</div></div>',
							'</div>'].join(''),
						success: function () {
							element.render();

							fileuploadFn('#fileupload', $('#fileContent'));

							$('select[name="compareType"]').html(dictionaryObj['COMPARE_TYPE']['str']);

							// 初始化时间控件
							laydate.render({
								elem: '#compareTime',
								trigger: 'click',
								value: data ? format(data.compareTime) : ''
							});

							// 设备明细列表数据
							var equipmentList = [];

							if (type == 2) {
								layForm.val("baseForm", data);

								$('input[name="customerId1"]', $('#baseForm')).attr('customerId', data.customerId1 || '').val(data.customerName1 || '');
								$('input[name="customerId2"]', $('#baseForm')).attr('customerId', data.customerId2 || '').val(data.customerName2 || '');
								$('input[name="customerId3"]', $('#baseForm')).attr('customerId', data.customerId3 || '').val(data.customerName3 || '');
								$('input[name="customerId4"]', $('#baseForm')).attr('customerId', data.customerId4 || '').val(data.customerName4 || '');
								$('input[name="customerId5"]', $('#baseForm')).attr('customerId', data.customerId5 || '').val(data.customerName5 || '');
								$('input[name="customerId6"]', $('#baseForm')).attr('customerId', data.customerId6 || '').val(data.customerName6 || '');
								$('input[name="customerId7"]', $('#baseForm')).attr('customerId', data.customerId7 || '').val(data.customerName7 || '');
								$('input[name="customerId8"]', $('#baseForm')).attr('customerId', data.customerId8 || '').val(data.customerName8 || '');

								$('input[name="mtlPlanId"]', $('#baseForm')).attr('mtlPlanId', data.mtlPlanId);
								$.get('/plbMtlPlanList/selectAll', {mtlPlanId: data.mtlPlanId}, function (res) {
									$('.plan_base_info input[name="mtlPlanId"]').val(res.object.planName);
									$('.plan_base_info input[name="mtlPlanId"]').data('data', res.object.listWithBLOBs);
								});

								$('#fileContent').html(getFileEleStr(data.attachments, true));

								equipmentList = data.plbMtlEquipmentListList;
							} else {
								// 获取自动编号
								getAutoNumber({autoNumber: 'plbMtlEquipment'}, function (res) {
									$('input[name="equipmentNo"]', $('#baseForm')).val(res);
								});
								$('.refresh_no_btn').show().on('click', function () {
									getAutoNumber({autoNumber: 'plbMtlEquipment'}, function (res) {
										$('input[name="equipmentNo"]', $('#baseForm')).val(res);
									});
								});
							}

							layForm.render();

							loadEquipmentListTable(equipmentList, getEquipmentListCols());

							// 选择分包商
							$('.choose_customer').on('click', function () {
								var $this = $(this);
								layer.open({
									type: 1,
									title: '选择分包商',
									area: ['100%', '100%'],
									btn: ['确定', '取消'],
									btnAlign: 'c',
									content: ['<div class="container" style="padding: 0;">',
										'<div class="wrapper">',
										'<div class="wrap_left">' +
										'<div class="layui-form">' +
										'<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
										'<div class="tree_module" style="top: 10px;">' +
										'<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
										'</div>' +
										'</div>' +
										'</div>',
										'<div class="wrap_right">' +
										'<div class="mtl_table_box" style="display: none;">' +
										'<table id="materialsTable" lay-filter="materialsTable"></table>' +
										'</div>' +
										'<div class="mtl_no_data" style="text-align: center;">' +
										'<div class="no_data_img">' +
										'<img style="margin-top: 12%;" src="/img/noData.png">' +
										'</div>' +
										'<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
										'</div>' +
										'</div>',
										'</div></div>'
									].join(''),
									success: function () {
										// 树节点点击事件
										eleTree.on("nodeClick(chooseMtlTree)", function (d) {
											$('.mtl_no_data').hide();
											$('.mtl_table_box').show();
											loadMtlTable(d.data.currentData.typeNo);
										});

										loadMtlType();

										function loadMtlType(typeNo) {
											typeNo = typeNo ? typeNo : '';
											// 获取左侧树
											$.get('/PlbCustomerType/treeList', function (res) {
												if (res.flag) {
													eleTree.render({
														elem: '#chooseMtlTree',
														data: res.data,
														highlightCurrent: true,
														showLine: true,
														defaultExpandAll: true,
														request: {
															name: "typeName",
															key: "typeNo",
															parentId: 'parentTypeId',
															isLeaf: "isLeaf",
															children: 'child'
														}
													});
												}
											});
										}

										function loadMtlTable(typeNo) {
											table.render({
												elem: '#materialsTable',
												url: '/PlbCustomer/getDataByCondition',
												where: {
													merchantType: typeNo,
													useFlag: true
												},
												height: 'full-150',
												page: true,
												limit: 10,
												toolbar: false,
												cols: [[
													{type: 'radio'},
													{field: 'customerNo', title: '客商编号', width: 200},
													{field: 'customerName', title: '客商单位名称'},
													{field: 'customerShortName', title: '客商单位简称'},
													{field: 'customerOrgCode', title: '组织机构代码'},
													{field: 'taxNumber', title: '税务登记号'},
													{field: 'accountNumber', title: '开户行账户'}
												]],
												parseData: function (res) {
													return {
														"code": 0,
														"data": res.data,
														"count": res.totleNum,
													}
												},
												request: {
													pageName: 'page',
													limitName: 'pageSize'
												}
											});
										}
									},
									yes: function (index) {
										var checkStatus = table.checkStatus('materialsTable');
										if (checkStatus.data.length > 0) {
											var mtlData = checkStatus.data[0];
											var customerId = mtlData.customerId;
											$this.attr("customerId", customerId);
											$this.val(mtlData.customerName);
											layer.close(index);
										} else {
											layer.msg('请选择一项！', {icon: 0});
										}
									}
								});
							});

							// 选择材料需求计划
							$('.choose_mtlPlanId').on('click', function () {
								var inSearchTable = null;
								layer.open({
									type: 1,
									title: '选择材料需求计划',
									area: ['90%', '90%'],
									btnAlign: 'c',
									btn: ['确定', '取消'],
									content: ['<div class="layui-form" style="padding: 8px">' +
									//查询
									'       <div class="layui-row inSearchContent">' +
									'             <div class="layui-col-xs3">\n' +
									'                  <input type="text" name="planNo" placeholder="计划单编号" autocomplete="off" class="layui-input">\n' +
									'             </div>\n' +
									'             <div class="layui-col-xs3" style="margin-left: 15px;">\n' +
									'                   <input type="text" name="planName" placeholder="计划名称" autocomplete="off" class="layui-input">\n' +
									'             </div>\n' +
									'             <div class="layui-col-xs3" style="margin-left: 15px;">\n' +
									'                   <input type="text" name="createUser" id="createUser" placeholder="编制人" readonly style="background: #e7e7e7; cursor: pointer;" autocomplete="off" class="layui-input">\n' +
									'             </div>\n' +
									'             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
									'                   <button type="button" class="layui-btn layui-btn-sm" id="inSearchData">查询</button>\n' +
									'             </div>\n' +
									'       </div>' +
									//表格数据
									'       <div>' +
									'           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
									'      </div>' +
									'</div>'].join(''),
									success: function () {
										inSearchTable = table.render({
											elem: '#mtlPlanIdTable',
											url: '/plbMtlPlan/queryMtlPlan',
											where: {
												projId: $('#leftId').attr('projId'),
											},
											page: {
												limit: 20,
												limits: [10, 20, 30, 50]
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
												{type: 'radio', title: '选择'},
												{field: 'planNo', title: '计划单编号'},
												{field: 'planName', title: '计划名称'},
												{
													field: 'createTime', title: '编制时间', templet: function (d) {
														return format(d.createTime);
													}
												},
												{field: 'createUser', title: '编制人'}
											]]
										});

										// 选择编制人
										$('#createUser').on('click', function () {
											user_id = 'createUser';
											$.popWindow("/common/selectUser");
										});

										// 材料需求计划查询
										$('#inSearchData').on('click', function () {
											var searchParams = {
												planNo: $('.inSearchContent input[name="planNo"]').val(),
												planName: $('.inSearchContent input[name="planName"]').val(),
												createUser: ($('#createUser').attr('user_id') || '').replace(/,$/, '')
											}

											inSearchTable.reload({
												where: searchParams,
												page: {
													curr: 1
												}
											});
										});
									},
									yes: function (index) {
										var checkStatus = table.checkStatus('mtlPlanIdTable')
										if (checkStatus.data.length > 0) {
											var chooseData = checkStatus.data[0];
											$('input[name="mtlPlanId"]', $('#baseForm')).val(chooseData.planName);
											$('input[name="mtlPlanId"]', $('#baseForm')).attr('mtlPlanId', chooseData.mtlPlanId);
											$('input[name="mtlPlanId"]', $('#baseForm')).data('data', chooseData.listWithBLOBs);
											layer.close(index);
										} else {
											layer.msg('请选择一项！', {icon: 0, time: 2000});
										}
									}
								});
							});
						},
						yes: function (index) {
							var loadIndex = layer.load();
							var obj = getSaveData(type, false, loadIndex, equipmentId, projId).dataObj;
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
										layer.msg('保存失败！', {icon: 2});
									}
								}
							});
						},
						btn2: function () {
							// 提交前先保存
							var loadIndex = layer.load();
							var baseData = getSaveData(type, true, loadIndex, equipmentId, projId);

							if (baseData) {
								$.ajax({
									url: url,
									data: JSON.stringify(baseData.dataObj),
									dataType: 'json',
									contentType: "application/json;charset=UTF-8",
									type: 'post',
									success: function (res) {
										layer.close(loadIndex);
										if (res.flag) {
											if (type == 1) {
												equipmentId = res.object;
											}
											layer.open({
												type: 1,
												title: '选择流程',
												area: ['70%', '80%'],
												btn: ['确定', '取消'],
												btnAlign: 'c',
												content: '<div><table id="flowTable" lay-filter="flowTable"></table></div>',
												success: function () {
													$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '34'}, function (res) {
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

														newWorkFlow(flowData.flowId, JSON.stringify(baseData.baseObj), function (res) {
															var submitData = {
																equipmentId: equipmentId,
																runId: res.flowRun.runId,
																approvalStatus: '1'
															}
															$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

															$.ajax({
																url: '/plbMtlEquipment/update',
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
							}
							return false;
						}
					});
				}

				/**
				 * 获取需要保存的数据
				 * @param saveType (1-新增, 2-编辑)
				 * @param isSubmit (是否提交)
				 * @param loadIndex
				 * @param equipmentId
				 * @param projId
				 * @returns {boolean|{dataObj: {}, baseObj: {}}}
				 */
				function getSaveData(saveType, isSubmit, loadIndex, equipmentId, projId) {

					if (isSubmit) {
						//必填项提示
						for (var i = 0; i < $('.chen').length; i++) {
							if ($('.chen').eq(i).val() == '') {
								layer.msg($('.chen').eq(i).attr('title') + '为必填项！', {icon: 0});
								layer.close(loadIndex);
								return false;
							}
						}
					}

					// 设备比价数据
					var baseData = $('#baseForm').serializeArray();
					var dataObj = {}
					baseData.forEach(function (item) {
						dataObj[item.name] = item.value;
					});
					// 分包商
					dataObj.customerId1 = $('input[name="customerId1"]', $('#baseForm')).attr('customerId') || '';
					dataObj.customerId2 = $('input[name="customerId2"]', $('#baseForm')).attr('customerId') || '';
					dataObj.customerId3 = $('input[name="customerId3"]', $('#baseForm')).attr('customerId') || '';
					dataObj.customerId4 = $('input[name="customerId4"]', $('#baseForm')).attr('customerId') || '';
					dataObj.customerId5 = $('input[name="customerId5"]', $('#baseForm')).attr('customerId') || '';
					dataObj.customerId6 = $('input[name="customerId6"]', $('#baseForm')).attr('customerId') || '';
					dataObj.customerId7 = $('input[name="customerId7"]', $('#baseForm')).attr('customerId') || '';
					dataObj.customerId8 = $('input[name="customerId8"]', $('#baseForm')).attr('customerId') || '';
					// 材料需求计划
					dataObj.mtlPlanId = $('input[name="mtlPlanId"]', $('#baseForm')).attr('mtlPlanId') || '';

					// 附件
					var attachmentId = '';
					var attachmentName = '';
					for (var i = 0; i < $('#fileContent .dech').length; i++) {
						attachmentId += $('#fileContent .dech').eq(i).find('input').val();
						attachmentName += $('#fileContent a').eq(i).attr('name');
					}
					dataObj.attachmentId = attachmentId;
					dataObj.attachmentName = attachmentName;

					var baseObj = JSON.parse(JSON.stringify(dataObj));

					//明细数据
					var $tr = $('.mtl_info_detail').find('.layui-table-main tr');
					var materialDetailsArr = [];
					$tr.each(function () {
						var materialDetailsObj = {
							budgetItemId: $(this).find('input[name="budgetItemName"]').attr('budgetItemId') || '',
							projBudgetId: $(this).find('input[name="budgetItemName"]').attr('projBudgetId') || '',
							customerId1: $(this).find('input[name="customerName1"]').attr('customerId') || '',
							customerUnit1: $(this).find('input[name="customerUnit1"]').val(),
							customerId2: $(this).find('input[name="customerName2"]').attr('customerId') || '',
							customerUnit2: $(this).find('input[name="customerUnit2"]').val(),
							customerId3: $(this).find('input[name="customerName3"]').attr('customerId') || '',
							customerUnit3: $(this).find('input[name="customerUnit3"]').val(),
							customerId4: $(this).find('input[name="customerName4"]').attr('customerId') || '',
							customerUnit4: $(this).find('input[name="customerUnit4"]').val(),
							customerId5: $(this).find('input[name="customerName5"]').attr('customerId') || '',
							customerUnit5: $(this).find('input[name="customerUnit5"]').val(),
							chooseCustomerId: $(this).find('input[name="chooseCustomerName"]').attr('customerId') || '',
							chooseUnit: $(this).find('input[name="chooseUnit"]').val()
						}
						if ($(this).find('input[name="budgetItemName"]').attr('equipmentListId')) {
							materialDetailsObj.equipmentListId = $(this).find('input[name="budgetItemName"]').attr('equipmentListId');
						}
						materialDetailsArr.push(materialDetailsObj);
					});
					dataObj.plbMtlEquipmentListList = materialDetailsArr;

					if (saveType == 2) {
						dataObj.equipmentId = equipmentId;
					} else {
						// 新建时保存项目id
						dataObj.projId = projId;
					}

					return {
						dataObj: dataObj,
						baseObj: baseObj
					}
				}

				// 查询
				$('#searchBtn').on('click', function () {
					tableShow($('#leftId').attr('projId'));
				});

				/**
				 * 获取查询条件
				 * @returns {{planNo: (*), planName: (*)}}
				 */
				function getSearchObj() {
					var searchObj = {
						equipmentNo: $('input[name="equipmentNo"]', $('.query_module')).val()
					}

					return searchObj
				}

				/*region 导出 */
				$(document).on('click', function () {
					$('.export_moudle').hide();
				});
				$(document).on('click', '.export_btn', function () {
					var type = $(this).attr('type');
					var fileName = '设备比价列表.xlsx';
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

				/**
				 * 加载比价明细列表
				 * @param equipmentList 明细数据
				 * @param customerCols 分包商列
				 */
				function loadEquipmentListTable(equipmentList, customerCols) {
					customerCols = customerCols || [];
					layTable.render({
						elem: '#equipmentListTable',
						data: equipmentList,
						toolbar: '#toolbarDemoIn',
						defaultToolbar: [''],
						cellMinWidth: 200,
						limit: 1000,
						cols: [[
							{type: 'numbers', title: '序号'},
							{
								field: 'planMtlName',
								title: '材料名称',
								minWidth: 160,
								templet: function (d) {
									return '<span>' + isShowNull(d.planMtlName) + '</span>'
								}
							},
							{
								field: 'planMtlStandard',
								title: '材料规格',
								minWidth: 160,
								templet: function (d) {
									return '<span>' + isShowNull(d.planMtlStandard) + '</span>'
								}
							}
						].concat(customerCols, [{
							field: 'chooseUnit',
							title: '选中分包商单价',
							minWidth: 200,
							templet: function (d) {
								return '<span>' + isShowNull(d.chooseUnit) + '</span>'
							}
						},
							{fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100}])]
					});
				}

				/**
				 * 获取比价明细分包商列
				 * @returns {*[]}
				 */
				function getEquipmentListCols() {
					var cols = []

					$('.choose_customer').each(function () {
						var $this = $(this);
						if ($this.attr('customerId')) {
							var customer = $this.attr('customer');
							var unitName = 'customerUnit' + customer
							var obj = {
								field: unitName,
								title: '分包商' + customer,
								minWidth: 160,
								templet: function (d) {
									return '<input type="text" name="' + unitName + '" pointFlag="1" class="layui-input input_floatNum">' + isShowNull(d[unitName]) + '</input>'
								}
							}
							cols.push(obj);
						}
					});

					return cols;
				}
			});

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
		</script>
	</body>
</html>
