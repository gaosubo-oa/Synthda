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
	<title>预算成本分析汇总</title>

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
	<script type="text/javascript" src="/js/planbudget/projectCostAnalysis.js"></script>
	<style>
		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
		}
		/*.layui-table-header,.layui-table-header,.layui-table-box,.layui-table-body,.layui-table-main{*/
		/*	overflow: visible;*/
		/*}*/
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
        /*.layui-table-box{*/
        /*    overflow: scroll;*/
        /*}*/
        /*.layui-table-header{*/
        /*    overflow: initial;*/
        /*}*/

		.layui-col-xs3{
			width: 20%;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">预算成本分析汇总报表</h2>
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
			<div class="query_module table_box layui-form layui-row" style="position: relative;display: none">

				<div class="layui-col-xs3" style="margin-left: 15px;">
					<%--            <input type="text" name="wbsName" placeholder="子项目名称/简称" autocomplete="off" class="layui-input">--%>
					<div class="layui-form-item">
						<label class="layui-form-label">RBS</label>
						<div class="layui-input-block">
							<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>
						</div>
					</div>

				</div>
<%--				<div class="layui-col-xs3" style="margin-left: 15px;">--%>
<%--					<select name="controlType">--%>

<%--					</select>--%>
<%--				</div>--%>

				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm" id="searchBtn">查询</button>
<%--					<button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>--%>
					<button type="button" class="layui-btn layui-btn-sm" id="export">导出</button>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center;width: 5%;float: right">
					<i class="layui-icon layui-icon-screen-full screen-full" title="全屏" style="font-size: 33px;cursor: pointer;"></i>
				</div>
				<%--<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>--%>
			</div>
			<div style="position: relative;top: 10px">
				<div class="table_box"  >
<%--                    lay-data="{ width:100%,url:'', page: true,limit: 6, limits:[6]}"--%>
					<table id="tableObj" lay-filter="parse-table-demo" class="layui-table"  style="display: none" >
                       <thead>
					   <tr>
<%--						   <th id="th1" lay-data="{field:'wbsOne',minWidth:100,align:'center'}" colspan="3">合同收入</th>--%>
						   <th id="th1" lay-data="{field:'yvsuan',minWidth:100,align:'center'}" colspan="3">预算目标</th>
						   <th lay-data="{field:'youhua',minWidth:100,align:'center'}" colspan="2">优化目标</th>
						   <th lay-data="{field:'guanli',minWidth:100,align:'center'}" colspan="3">管理目标</th>
						   <th lay-data="{field:'taxMoney',minWidth:100}" rowspan="2">实际成本</th>
						   <th lay-data="{field:'manageTarAmount4',minWidth:120}" rowspan="2">管理目标余额</th>
					   </tr>
					   <tr>
<%--						   <th lay-data="{field:'contract1',minWidth:100,align:'center'}">初始值</th>--%>
<%--						   <th lay-data="{field:'contract2',minWidth:100,align:'center'}">变更值</th>--%>
<%--						   <th lay-data="{field:'contract3',minWidth:100,align:'center'}">变更后值</th>--%>
						   <th lay-data="{field:'incomeTarAmount1',minWidth:100,align:'center'}">初始值</th>
						   <th lay-data="{field:'incomeTarAmount2',minWidth:100,align:'center'}">变更值</th>
						   <th lay-data="{field:'incomeTarAmount3',minWidth:100,align:'center'}">变更后值</th>
						   <th lay-data="{field:'optTarAmount1',minWidth:100,align:'center'}">初始值</th>
						   <th lay-data="{field:'optTarAmount2',minWidth:100,align:'center'}">变更后值</th>
						   <th lay-data="{field:'manageTarAmount1',minWidth:100,align:'center'}">初始值</th>
						   <th lay-data="{field:'manageTarAmount2',minWidth:100,align:'center'}">变更值</th>
						   <th lay-data="{field:'manageTarAmount3',minWidth:100,align:'center'}">变更后值</th>
					   </tr>
					   </thead>
                    </table>
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

<%--<script type="text/html" id="toolbarHead">--%>
<%--	<div class="layui-btn-container" style="float: left; height: 30px;">--%>
<%--		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="add">分解子项目</button>--%>
<%--		<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>--%>
<%--		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>--%>
<%--	</div>--%>
<%--	<div style="position:absolute;top: 10px;right:60px;">--%>
<%--		<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>--%>
<%--		<button class="layui-btn layui-btn-sm" lay-event="importPlan" style="margin-left:10px;">导入子项计划</button>--%>
<%--		<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入公司级WBS</button>--%>
<%--	</div>--%>
<%--</script>--%>

<script type="text/html" id="toolBar">
	<a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script type="text/html" id="toolbarDemoIn">
	<div class="layui-btn-container" style="height: 30px;">
		<%--        <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>--%>
		<%--        <button class="layui-btn layui-btn-sm" lay-event="choice">模板选择</button>--%>
	</div>
</script>

<script>
	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}
	var _rbsId = getUrlParam('rbId');


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
		},
		dutyDept: {
			field: 'dutyDept', title: '责任部门', sort: true, hide: false, templet: function (d) {
				return isShowNull(d.dutyDeptName);
			}
		},
		dutyUser: {
			field: 'dutyUser', title: '责任人', sort: true, hide: false, templet: function (d) {
				return isShowNull(d.dutyUserName).replace(/,$/, '');
			}
		},
		dutyUserTel: {
			field: 'dutyUserTel', title: '责任人电话', sort: false, hide: false
		},
		buildUnit: {
			field: 'buildUnit', title: '建设单位', sort: true, hide: false, templet: function (d) {
				return isShowNull(d.buildUnitName);
			}
		}
	}

	var TableUIObj = new TableUI('plb_proj_wbs');

	// 获取数据字典数据
	var dictionaryObj = {
		WBS_LEVEL: {},
		PBAG_NATURE: {},
		PBAG_TYPE: {},
		CUSTOMER_UNIT: {},
		CONTROL_MODE:{}
	}
	var dictionaryStr = 'WBS_LEVEL,PBAG_NATURE,PBAG_TYPE,CUSTOMER_UNIT,CONTROL_MODE';
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
		// var str = dictionaryObj&&dictionaryObj['CONTROL_MODE']&&dictionaryObj['CONTROL_MODE']['str']
		// $('[name=controlType]').html('<option value="">请选择控制方式</option>'+str||'')
		// layui.form.render()

	});

	var tableObj = null;

	var animateFlag = true
	$(".screen-full").click(function(){
		$(".wrap_left").animate({
			width:'toggle'
		});
		$(".wrap_right").animate({
			marginLeft:'0'
		},function(){
			// $('#searchBtn').click()
		});
		if(animateFlag){
			$(this).removeClass("layui-icon-screen-full").addClass('layui-icon-screen-restore').attr('title','退出全屏');

		}else {
			$(this).removeClass("layui-icon-screen-restore").addClass('layui-icon-screen-full').attr('title','全屏');
		}

		animateFlag = !animateFlag
	});

	layui.use(['form', 'laydate', 'eleTree', 'xmSelect', 'treeTable', 'table'], function () {
		var layForm = layui.form,
				laydate = layui.laydate,
				eleTree = layui.eleTree,
				treeTable = layui.treeTable,
				layTable = layui.table,
				xmSelect = layui.xmSelect;




		// TableUIObj.init(colShowObj, function () {
		// 	$('.no_data').hide();
		// 	$('.table_box').show();
		// 	tableInit();
		// });

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
		    $("#tableObj").css("display","block");
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
				case 'add': // 新增
					if (!$('#leftId').attr('projId')) {
						layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
						return false;
					}
					addOrEdit(1);
					break;
				case 'edit': // 编辑
					if (checkStatus.length != 1) {
						layer.msg('请选择一条需要编辑的数据！', {icon: 0, time: 1500});
						return false;
					}
					if (checkStatus[0].approvalStatus > 0) {
						layer.msg('该项目已提交！', {icon: 0});
						return false;
					}
					$.get('/plbProjWbs/getDataByWbsId', {wbsId: checkStatus[0].wbsId}, function (res) {
						if (res.flag) {
							addOrEdit(2, res.data);
						} else {
							layer.msg('获取信息失败！', {icon: 0});
						}
					});
					break;
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
				case 'importPlan': // 导入子项计划
					var projId = $('#leftId').attr('projId')
					if (!projId) {
						layer.msg('请选择左侧项目');
						break;
					}
					layer.open({
						type: 1,
						title: '选择子项目信息',
						area: ['100%', '100%'],
						maxmin: true,
						btn: ['确定导入', '取消导入'],
						btnAlign: 'c',
						content: ['<div class="container">',
							'<div class="wrapper">',
							'<div class="wrap_left" style="border-right: 1px solid #ccc;">' +
							// '<ul style="margin-top: 10px;"></ul>' +
							'<div class="layui-form">' +
							'<div class="tree_module" style="top: 0;">' +
							'<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
							'</div>' +
							'</div>' +
							'</div>',
							'<div class="wrap_right" style="padding-left: 10px;">' +
							'<div class="mtl_table_box" style="display: none;">' +
							'<table id="materialsTable" lay-filter="materialsTable"></table>' +
							'</div>' +
							'<div class="mtl_no_data" style="text-align: center;">' +
							'<div class="no_data_img" style="margin-top:12%;">' +
							'<img style="margin-top: 2%;" src="/img/noData.png">' +
							'</div>' +
							'<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧科目类型模板</p>' +
							'</div>' +
							'</div>',
							'</div></div>'].join(''),
						success: function () {
							// 获取左侧树
							function projectLeft() {
								$.get('/ProjectInfo/selectProPlus', function (res) {
									if (res.flag) {
										eleTree.render({
											elem: '#chooseMtlTree',
											data: res.data,
											highlightCurrent: true,
											showLine: true,
											request: {
												name: "projectAbbreviation", // 显示的内容
											}
										});
									}
								})
							}

							projectLeft()

							// 树节点点击事件
							eleTree.on("nodeClick(chooseMtlTree)", function (d) {
								//只有机构下能添加项目，部门下不能添加项目，开启权限可以添加项目
								if (d.data.currentData.projectId) {
									var projectId = d.data.currentData.projectId
									$('.mtl_no_data').hide();
									$('.mtl_table_box').show();
									treeTableShow(projectId)
									$('#leftId').attr('projId', d.data.currentData.projId)
								}
							});

							// 渲染树形表格
							function treeTableShow(projectId, projectIds) {
								projectIds = !!projectIds ? projectIds : '';
								insTb = treeTable.render({
									elem: '#materialsTable',
									url: '/plcProjectBag/selectByProjectId?projectId=' + projectId + '&projectIds=' + projectIds + '&_=' + new Date().getTime(),
									tree: {
										iconIndex: 1,           // 折叠图标显示在第几列
										idName: 'ids',
										childName: "bags"
									},
									cols: [[
										{type: 'checkbox'},
										{field: 'bagNumber', title: '子项目编号', width: 200,},
										{
											field: 'pbagName', title: '子项目名称', width: 400, templet: function (d) {
												return '<span style="color:blue;cursor: pointer" class="pbagName pbagDetail" ids="' + d.ids + '" pbagId="' + d.pbagId + '" >' + d.pbagName + '</span>'
											}
										},
										{
											field: 'auditerStatus', title: '审批状态', width: 120, templet: function (d) {
												if (d.auditerStatus == 0) {
													return '待审批'
												} else if (d.auditerStatus == 1) {
													return '已批准'
												} else if (d.auditerStatus == 2) {
													return '未批准,请修改后重新提交'
												} else {
													return ''
												}
											}
										},
										{
											field: 'pbagNature', title: '子项目性质', width: 150, templet: function (d) {
												return dictionaryObj['PBAG_NATURE']['object'][d.pbagNature] || ''
											}
										},
										{field: 'pbagContent', title: '施工内容', width: 200,},
										{
											field: 'pbagClass', title: '子项目分类', width: 120, templet: function (d) {
												if (d.pbagClassList) {
													var pbagClassList = d.pbagClassList
													var pbagClassName = ''
													pbagClassList.forEach(function (item) {
														pbagClassName += item.dictName + ','
													})
													return pbagClassName
												} else {
													return ''
												}
											}
										},
										{
											field: 'pbagType', title: '子项目类型', width: 120, templet: function (d) {
												return dictionaryObj['PBAG_TYPE']['object'][d.pbagType] || ''
											}
										},
										/*  {field: 'costType', title: '成本类型',templet: function(d){
                                                  return  dictionaryObj['COST_TYPE']['object'][d.costType] || ''
                                              }},*/
										{field: 'dutyUserName', title: '责任人'},
										// {field: 'dutyUserTel', title: '责任人电话'},
										// {field: 'dutyDept', title: '责任部门'},
										{
											field: 'planBeginDate', title: '计划开始时间', width: 150, templet: function (d) {
												return format(d.planBeginDate)
											}
										},
										{
											field: 'planEndDate', title: '计划结束时间', width: 150, templet: function (d) {
												return format(d.planEndDate)
											}
										},
										/* {field: 'realBeginDate', title: '实际开始时间'},
                                         {field: 'realEndDate', title: '实际完成时间'},*/
										// {field: 'acceptStandard', title: '验收标准'},
										{
											field: 'budgetYn', title: '是否预算控制', width: 130, templet: function (d) {
												return isUndefined(d.budgetYn)
											}
										},
										{field: 'pbagLevel', title: '子项目层级', width: 120,},
										{
											field: 'buildUnit', title: '施工单位', width: 120, templet: function (d) {
												return dictionaryObj['CUSTOMER_UNIT']['object'][d.buildUnit] || ''
											}
										},
										{
											field: 'designUnit', title: '设计单位', width: 120, templet: function (d) {
												if (d.designUnitList) {
													var designUnitList = d.designUnitList
													var designUnitName = ''
													designUnitList.forEach(function (item) {
														designUnitName += item.dictName + ','
													})
													return designUnitName
												} else {
													return ''
												}
											}
										},
										{
											field: 'purchaseUnitUser', title: '采购单位', width: 120, templet: function (d) {
												return dictionaryObj['CUSTOMER_UNIT']['object'][d.purchaseUnitUser] || ''
											}
										},
										// {field: 'truePeriod', title: '实际工期'},
										{field: 'planPeriod', title: '计划工期'},
										// {field: 'pbagTarget', title: '子项目关键任务'},
										{
											field: 'isNewChild', title: '是否开放下级子项目', width: 160, templet: function (d) {
												return isUndefined(d.isNewChild)
											}
										},
										{
											field: 'isNewItem', title: '是否新建子任务', width: 120, templet: function (d) {
												return isUndefined(d.isNewItem)
											}
										},
										{
											field: 'isNewTarget', title: '是否新建关键任务', width: 120, templet: function (d) {
												return isUndefined(d.isNewTarget)
											}
										},
										/*  {field: 'isinitializtion', title: '是否初始化',width:120,templet: function(d){
                                                  return  isUndefined(d.isinitializtion)
                                              }},*/
									]],
									height: 'full-150',
									parseData: function (res) { //res 即为原始返回的数据
										return {
											"code": 0, //解析接口状态
											"data": res.obj //解析数据列表
										};
									}
								});
							}
						},
						yes: function (index) {
							var checkStatus = insTb.checkStatus();
							var projId = $('#leftId').attr('projId')
							if (checkStatus.length > 0) {
								var list = []
								for (var i = 0; i < checkStatus.length; i++) {
									var pbagId = '';

									var bags = [];
									var obj = {}
									pbagId = checkStatus[i].pbagId;
									if (checkStatus[i].bags) {
										for (var j = 0; j < checkStatus[i].bags.length; j++) {
											var bagsId = '';
											bagsId = checkStatus[i].bags[j].pbagId;
											var objs = {
												pbagId: bagsId
											}
											bags.push(objs)
										}
										obj = {
											pbagId: pbagId,
											bags: bags
										}
									} else {
										obj = {
											pbagId: pbagId
										}
									}
									list.push(obj)
								}
								$.ajax({
									url: "/plbProjWbs/importByPlanCheck",
									type: "post",
									contentType: 'application/json',
									data: JSON.stringify({"list": list, "projId": projId}),
									success: function () {
										//请求成功时处理
										layer.close(index)
										layer.msg('导入成功！', {icon: 1});
										tableObj.reload();
									},
									error: function () {
										//请求出错处理
										layer.msg('导入失败！', {icon: 2});
									}
								})
							} else {
								layer.msg('请选择一项！', {icon: 0});
							}
						}
					});
					break;
				case 'import': // 导入公司级WBS
					layer.msg('功能完善中');
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

		// 导出
		$('#export').on('click', function () {
			var projIdd = $('#leftId').attr('projId');
			if(!projIdd){
				layer.msg("请选择左侧项目")
			}else{
				//导出
				window.location.href='/projectCostAnalysis/getCbsWbsByProj?projId='+projIdd+'&rbsId='+rbsSelectTree.getValue('valueStr')+'&export=export';
			}
		});

		treeTable.on('tool(tableObj)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'detail') {
				$.get('/plbProjWbs/getDataByWbsId', {wbsId: data.wbsId}, function (res) {
					if (res.flag) {
						addOrEdit(3, res.data);
					} else {
						layer.msg('获取信息失败！', {icon: 0});
					}
				});
			}
		});
		var wbsHtm;
		var rbsHtm;
		var cbsHtm;
		function tableInit(projId) {
			$(".th").remove();
			$.ajax({
				url:'/projectCostAnalysis/getWbsCbsLayerNum?projId='+projId+'',
				datatype:'json',
				type:'get',
				async:false,
				success:function(res){
					var wbsNum=res.obj.wbsLayerNum;
					var cbsNum=res.obj.cbsLayerNum;
					var rbsNum=res.obj.rbsLayerNum;
					wbsHtm="";
					rbsHtm="";
					cbsHtm="";
					var htm = "minWidth:100";
					//WBS
					if(wbsNum==0||wbsNum=="0"){

					}else if(wbsNum==1||wbsNum=="1"){
						wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS末级</th>'

					}else if(wbsNum==2||wbsNum=="2"){
						for(var i=0;i<wbsNum;i++){
							if(i==1){
								break;
							}
							wbsHtm+='<th class="th" lay-data="{field:\'wbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">WBS'+getNum(i+1)+'级</th>'
						}
						wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS末级</th>'
					}else if(wbsNum>2){
						for(var i=0;i<wbsNum;i++){
							if(i>1){
								break;
							}
							wbsHtm+='<th class="th" lay-data="{field:\'wbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">WBS'+getNum(i+1)+'级</th>'
						}
						wbsHtm+='<th class="th" lay-data="{field:\'wbs'+wbsNum+'\',align:\'center\','+htm+'}" rowspan="2">WBS末级</th>'
					}
					//RBS
					if(rbsNum==0||rbsNum=="0"){

					}else if(rbsNum==1||rbsNum=="1"){
						rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS末级</th>'

					}else if(rbsNum==2||rbsNum=="2"){
						for(var i=0;i<rbsNum;i++){
							if(i==1){
								break;
							}
							rbsHtm+='<th class="th" lay-data="{field:\'rbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">RBS'+getNum(i+1)+'级</th>'
						}
						rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS末级</th>'
					}else if(rbsNum>2){
						for(var i=0;i<rbsNum;i++){
							if(i>1){
								break;
							}
							rbsHtm+='<th class="th" lay-data="{field:\'rbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">RBS'+getNum(i+1)+'级</th>'
						}
						rbsHtm+='<th class="th" lay-data="{field:\'rbs'+rbsNum+'\',align:\'center\','+htm+'}" rowspan="2">RBS末级</th>'
					}


					//CBS
					if(cbsNum==0||cbsNum=="0"){

					}else if(cbsNum==1||cbsNum=="1"){
						cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS末级</th>'

					}else if(cbsNum==2||cbsNum=="2"){
						for(var i=0;i<cbsNum;i++){
							if(i==1){
								break;
							}
							cbsHtm+='<th class="th" lay-data="{field:\'cbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">CBS'+getNum(i+1)+'级</th>'
						}
						cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS末级</th>'
					}else if(cbsNum>2){
						for(var i=0;i<cbsNum;i++){
							if(i>1){
								break;
							}
							cbsHtm+='<th class="th" lay-data="{field:\'cbs'+(i+1)+'\',align:\'center\','+htm+'}" rowspan="2">CBS'+getNum(i+1)+'级</th>'
						}
						cbsHtm+='<th class="th" lay-data="{field:\'cbs'+cbsNum+'\',align:\'center\','+htm+'}" rowspan="2">CBS末级</th>'
					}
					$("#th1").before(wbsHtm,rbsHtm,cbsHtm);
					layTable.init('parse-table-demo', { //转化静态表格
						url:'/projectCostAnalysis/getCbsWbsByProj?projId='+projId+'&rbsId='+rbsSelectTree.getValue('valueStr'),
						toolbar: '#toolbarDemoIn', //开启头部工具栏，并为其绑定左侧模板
						defaultToolbar: ['filter'],
						height: 'full-150',
						done:function(res,curr,count){
							// layuiRowspan('sum',1);
							// $(".layui-table-tool").css("width",$(".layui-table-view").find("table").width())
						}
					});


				}
			})
		}

		/**
		 * 新增、编辑方法
		 * @param type 类型(1-新增，2-编辑)
		 * @param data 编辑时的信息
		 */
		function addOrEdit(type, data) {
			var title = '';
			var url = '';
			var btnArr = ['保存', '取消'];
			var projId = $('#leftId').attr('projId');
			var decomposeLevel = $('#leftId').attr('decomposeLevel');
			if (type == 1) {
				title = '分解子项目';
				url = '/plbProjWbs/addPlbProjWbs';
			} else if (type == 2) {
				title = '编辑子项目';
				url = '/plbProjWbs/updatePlbProjWbs';
				projId = data.projId;
				decomposeLevel = data.decomposeLevel || 1;
			} else if (type == 3) {
				title = '查看详情';
				projId = data.projId;
				decomposeLevel = data.decomposeLevel || 1;
				btnArr = [];
			}

			var parentWbsId = null;

			layer.open({
				type: 1,
				title: title,
				area: ['70%', '90%'],
				btn: btnArr,
				btnAlign: 'c',
				content: ['<div class="layer_wrap" style="padding: 10px 15px;">',
					'<form class="layui-form" id="baseForm" lay-filter="baseForm">',
					/* region 第一行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">排序号<span field="sortNo" class="field_required">*</span><a title="刷新排序号" class="refresh_sort_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly name="sortNo" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">子项目编号<span field="wbsNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="wbsNo" readonly autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第二行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">子项目名称<span field="wbsName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="wbsName" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">上级子项目</label>' +
					'<div class="layui-input-block form_block">' +
					'<div id="parentWbsId" class="xm-select-demo"></div>' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第三行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">子项目层级<span field="wbsLevel" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<select disabled name="wbsLevel"></select>' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">责任部门<span field="dutyDept" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly id="dutyDept" name="dutyDept" autocomplete="off" style="background-color: #e7e7e7; cursor: pointer;" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第三行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">责任人<span field="dutyUser" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly id="dutyUser" name="dutyUser" autocomplete="off" style="background-color: #e7e7e7; cursor: pointer;" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">责任人电话<span field="dutyUserTel" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="dutyUserTel" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第三行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">建设单位<span field="buildUnit" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly id="buildUnit" name="buildUnit" autocomplete="off" style="background-color: #e7e7e7; cursor: pointer;" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					/* region 第四行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">计划开始时间<span field="planStartDate" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly id="planStartDate" name="planStartDate" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">计划结束时间<span field="planEndDate" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly id="planEndDate" name="planEndDate" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs12" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">子项目内容<span field="pbagContent" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<textarea name="pbagContent" placeholder="请输入内容" class="layui-textarea"></textarea>' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					'</form>',
					'</div>'].join(''),
				success: function () {
					$('select[name="wbsLevel"]').html(dictionaryObj['WBS_LEVEL']['str']);

					// 获取点前项目下所有子项目
					$.get('/plbProjWbs/getPlbProjWbsByProjId', {projId: projId}, function (res) {
						if (res.flag) {
							var treeData = res.data;
							if (type == 2 || type == 3) {
								filterTreeData(treeData, data.wbsId, decomposeLevel);
							} else {
								filterTreeData(treeData, '', decomposeLevel);
							}
							parentWbsId = xmSelect.render({
								el: '#parentWbsId',
								radio: true,
								clickClose: true,
								disabled: type == 3,
								name: 'parentWbsId',
								prop: {
									name: 'wbsName',
									value: 'wbsId',
									children: 'child'
								},
								tree: {
									show: true,
									strict: false,
									expandedKeys: [-1]
								},
								data: treeData,
								on: function (data) {
									var checkData = data.arr[0];
									var parentWbsLevel = checkData ? checkData.wbsLevel : 0;
									var wbsLevel = parseInt(parentWbsLevel) + 1;
									if (wbsLevel < 10) {
										wbsLevel = '0' + wbsLevel;
									}
									$('[name="wbsLevel"]', $('#baseForm')).val(wbsLevel);
									layForm.render('select');
								}
							});

							if (type == 2 || type == 3) {
								parentWbsId.setValue([data.parentWbsId]);
							}
						}
					});

					// 项目开始时间
					var contractStartDate = $('#leftId').attr('contractStartDate') || '';
					// 项目结束时间
					var contractEndDate = $('#leftId').attr('contractEndDate') || '';

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
						value: data ? format(data.planStartDate) : '',
						trigger: 'click' //采用click弹出
					}

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

					if (contractStartDate) {
						planStartDateConfig.min = checkFloatNum(contractStartDate);
						planEndDateConfig.min = checkFloatNum(contractStartDate);
					}

					if (contractEndDate) {
						planStartDateConfig.max = checkFloatNum(contractEndDate);
						planEndDateConfig.max = checkFloatNum(contractEndDate);
					}

					if (data) {
						if (data.planEndDate) {
							planStartDateConfig.max = data.planEndDate;
						}
						if (data.planStartDate) {
							planEndDateConfig.min = data.planStartDate;
						}
					}

					var planStartDate = laydate.render(planStartDateConfig);

					var planEndDate = laydate.render(planEndDateConfig);

					if (type == 2 || type == 3) {
						layForm.val("baseForm", data);
						$('#dutyUser').val(data.dutyUserName);
						$('#dutyUser').attr('user_id', data.dutyUser);
						$('#dutyDept').val(data.dutyDeptName);
						$('#dutyDept').attr('deptid', data.dutyDept);
						$('#buildUnit').val(data.buildUnitName);
						$('#buildUnit').attr('buildUnit', data.buildUnit);
					} else if (type == 1) {
						// 获取自动编号
						getAutoNumber({autoNumber: 'plbProjWbs'}, function (res) {
							$('input[name="wbsNo"]', $('#baseForm')).val(res);
						});
						$('.refresh_no_btn').show().on('click', function () {
							getAutoNumber({autoNumber: 'plbProjWbs'}, function (res) {
								$('input[name="wbsNo"]', $('#baseForm')).val(res);
							});
						});
						// 获取排序号
						getSortNumber({sotrNumber: 'plbProjWbs'}, function(res) {
							$('input[name="sortNo"]', $('#baseForm')).val(res.data);
						});
						$('.refresh_sort_btn').show().on('click', function() {
							getSortNumber({sotrNumber: 'plbProjWbs'}, function(res) {
								$('input[name="sortNo"]', $('#baseForm')).val(res.data);
							});
						});
					}

					if (type == 3) {
						$('#baseForm [name]').attr('disabled', true);
					} else {
						// 选择责任部门
						$('#dutyDept').on('click', function () {
							dept_id = 'dutyDept';
							$.popWindow('/common/selectDept?0');
						});
						// 选择责任人
						$('#dutyUser').on('click', function () {
							user_id = 'dutyUser';
							$.popWindow('/common/selectUser?0');
						});

						// 选择建设单位
						$('#buildUnit').on('click', function () {
							var $this = $(this);
							layer.open({
								type: 1,
								title: '选择建设单位',
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
									'<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧类型</p>' +
									'</div>' +
									'</div>',
									'</div></div>'
								].join(''),
								success: function () {
									// 树节点点击事件
									eleTree.on("nodeClick(chooseMtlTree)", function (d) {
										var currentData = d.data.currentData;
										if (currentData.typeNo) {
											$('.mtl_no_data').hide();
											$('.mtl_table_box').show();
											loadMtlTable(currentData.typeNo);
										} else {
											$('.mtl_table_box').hide();
											$('.mtl_no_data').show();
										}
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
													defaultExpandAll: false,
													request: {
														name: "typeName",
														key: "typeNo",
														parentId: 'parentTypeId',
														isLeaf: "isLeaf",
														children: 'child',
													}
												});
											}
										});
									}

									function loadMtlTable(typeNo) {
										layTable.render({
											elem: '#materialsTable',
											url: '/PlbCustomer/getDataByCondition',
											where: {
												merchantType: typeNo,
												useFlag: true
											},
											page: true,
											limit: 50,
											toolbar: false,
											cols: [[ //表头
												{type: 'radio', title: '选择'},
												{field: 'customerNo', title: '客商编号'},
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
											},
										});
									}
								},
								yes: function (index) {
									var checkStatus = layTable.checkStatus('materialsTable');
									if (checkStatus.data.length > 0) {
										var mtlData = checkStatus.data[0];
										$this.attr("buildUnit", mtlData.customerId);
										$this.val(mtlData.customerName);
										layer.close(index);
									} else {
										layer.msg('请选择一项！', {icon: 0});
									}
								}
							});
						});
					}

					layForm.render();
				},
				yes: function (index) {
					var loadIndex = layer.load();

					var datas = $('#baseForm').serializeArray();
					var obj = {}
					datas.forEach(function (item) {
						obj[item.name] = item.value
					});

					// 子项目层级
					obj.wbsLevel = $('[name="wbsLevel"]', $('#baseForm')).val();

					obj.dutyUser = ($('#dutyUser').attr('user_id') || '').replace(/,$/, '');
					obj.dutyDept = ($('#dutyDept').attr('deptid') || '').replace(/,$/, '');
					obj.buildUnit = $('#buildUnit').attr('buildUnit') || '';

					obj.parentWbsId = obj.parentWbsId || 0;

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
						obj.wbsId = data.wbsId;
					} else {
						obj.projId = projId;
					}

					$.post(url, obj, function (res) {
						layer.close(loadIndex);
						if (res.flag) {
							layer.msg('保存成功！', {icon: 1});
							layer.close(index);
							tableObj.options.where._ = new Date().getTime();
							tableObj.reload();
						} else {
							layer.msg(res.msg, {icon: 2});
						}
					});
				}
			});
		}

		//搜索功能
		var rbsSelectTree =null;


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
		rbsData(_rbsId);
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
			if(type == '1'){
				if(parentId){
					obj.rbsName=parentId;
				}else {
					obj.parentId='1';
				}

			}else {
				obj.parentId=parentId?parentId:'1';
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
				controlType: $('input[name="controlType"]', $('.query_module')).val(),
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

	function getNum(i){
		switch(i){
			case 1:
				return "一"
			     break;
			case 2:
				return "二"
				break;
			case 3:
				return "三"
				break;
			case 4:
				return "四"
				break;
			case 5:
				return "五"
				break;
			case 6:
				return "六"
				break;
			case 7:
				return "七"
				break;
			case 8:
				return "八"
				break;
			case 9:
				return "九"
				break;
			case 10:
				return "十"
				break;
		}

	}

</script>
</body>
</html>
