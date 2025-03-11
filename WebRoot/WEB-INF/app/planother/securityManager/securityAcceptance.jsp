<%--
  Created by IntelliJ IDEA.
  User: 王秋彤
  Date: 2021/9/13
  Time: 9:44
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
	<title>安全验收</title>

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
	<%--        <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
	<script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
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
		.layui-col-xs6{
			width: 20%;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId">
	<div class="wrapper">
		<div class="wrap_left">
			<h2>安全验收</h2>
			<div class="left_form">
				<div class="search_icon">
					<i class="layui-icon layui-icon-search"></i>
				</div>
				<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input" />
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
				<div class="layui-col-xs2" style="margin-left: 10px;">
					<input type="text" name="acceptanceTime" placeholder="验收时间" autocomplete="off" class="layui-input acceptanceTime">
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
<%--					<button type="button" class="layui-btn layui-btn-sm" id="advancedQuery">高级查询</button>--%>
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
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="examineTest">执行验收</button>
<%--		<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="edit">编辑</button>--%>
<%--		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del">删除</button>--%>
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
		<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-left:10px;">提交审批</button>
		<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>
		<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
	</div>
</script>

<script type="text/html" id="toolBar">
	<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
	var securityInfoDate;


	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text');
		tipIndex = layer.tips(tip, this);
	}, function () {
		layer.close(tipIndex);
	});


	// 表格显示顺序
	var colShowObj = {
		documentNo: {field: 'documentNo', title: '单据号', minWidth: 100,sort: true, hide: false},
		projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
		planName: {field: 'planName', title: '检查计划名称',minWidth: 120, sort: true, hide: false,templet: function (d) {
				return '<span>'+(d.checklist.planName||'')+'</span>'
			}},
		securityKnowledgeName: {field: 'securityKnowledgeName', title: '检查项',minWidth: 120, sort: true, hide: false,templet: function (d) {
				return '<span>'+(d.detailsInfo.securityKnowledgeName||'')+'</span>'
			}},
		securityDangerDesc: {field: 'securityDangerDesc', title: '检查内容',minWidth: 120, sort: true, hide: false,templet: function (d) {
				return '<span>'+(d.detailsInfo.securityDangerDesc||'')+'</span>'
			}},
		securityGrade: {field: 'securityGrade', title: '隐患级别',minWidth: 120, sort: true, hide: false, templet: function (d) {
				if(d.detailsInfo.securityGrade==0){
					return '<span class="securityGrade" securityGrade="'+d.detailsInfo.securityGrade+'" >重大隐患</span>'
				}else if(d.detailsInfo.securityGrade==1){
					return '<span class="securityGrade" securityGrade="'+d.detailsInfo.securityGrade+'">一般隐患</span>'
				}else{
					return '<span class="securityGrade"></span>'
				}
			}},
		acceptanceUser: {field: 'acceptanceUser',minWidth: 120, title: '验收人', sort: true, hide: false},
		acceptanceTime: {field: 'acceptanceTime', minWidth: 120,title: '验收时间', sort: true, hide: false},
		currFlowUserName: {field: 'currFlowUserName', minWidth: 140,title: '当前处理人', sort: false, hide: false},
		acceptanceFlag: {field: 'acceptanceFlag', minWidth: 120,title: '验收状态',templet: function (d) {
				if(d.acceptanceFlag&&d.acceptanceFlag==0){
					return  '<span>未验收</span>'
				}else if(d.acceptanceFlag&&d.acceptanceFlag==1){
					return  '<span>已验收</span>'
				}else if(d.acceptanceFlag&&d.acceptanceFlag==10){
					return  '<span>已退回</span>'
				}else{
					return  '<span></span>'
				}
			}},
		auditerStatus: {
			field: 'auditerStatus', title: '审批状态', sort: true,minWidth: 120, hide: false, templet: function (d) {
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

	var TableUIObj = new TableUI('plb_security_acceptance');

	// 获取数据字典数据
	var dictionaryObj = {
		CONTRACT_TYPE: {},
		CBS_UNIT:{},
		TAX_RATE:{}
	}
	var dictionaryStr = 'CONTRACT_TYPE,CBS_UNIT,TAX_RATE';
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

	var tableObj = null;

	layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree'], function () {
		var form = layui.form,
				laydate = layui.laydate,
				table = layui.table,
				layElement = layui.element,
				soulTable = layui.soulTable,
				eleTree = layui.eleTree;


		TableUIObj.init(colShowObj, function(){
			// $('.no_data').hide();
			// $('.table_box').show();
			// tableInit();
		});

		laydate.render({
			elem: '.acceptanceTime'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});

		form.render();

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
				//$('#leftId').attr('projName', currentData.projAbbreviation);
				$('.no_data').hide();
				$('.table_box').show();
				tableInit(currentData.projId);
			} else {
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 监听排序事件
		table.on('sort(tableObj)', function (obj) {
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
		form.on('checkbox()', function (data) {
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
		table.on('toolbar(tableObj)', function (obj) {
			var checkStatus = table.checkStatus(obj.config.id);
			var dataTable=table.checkStatus(obj.config.id).data;
			switch (obj.event) {
				// case 'add':
				// 	if (!$('#leftId').attr('projId')) {
				// 		layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
				// 		return false;
				// 	}
				// 	newOrEdit(1);
				// 	break;
				case 'examineTest':
					if (checkStatus.data.length != 1) {
						layer.msg('请选择一项！', {icon: 0});
						return false
					}

					if (checkStatus.data[0].auditerStatus > 0) {
						layer.msg('该条数据已提交，不可编辑！', {icon: 0});
						return false;
					}

					if($('#leftId').attr('projId')){
						newOrEdit(2, checkStatus.data[0]);
					}else{
						layer.msg('请选择左侧项目！', {icon: 0, time: 1500});
						return false;
					}
					break;
				// case 'del':
				// 	if (checkStatus.data.length == 0) {
				// 		layer.msg('请选择需要删除的数据！', {icon: 0});
				// 		return false
				// 	}
				// 	var acceptanceIds = ''
				// 	checkStatus.data.forEach(function (v) {
				// 		if (!(checkStatus.data[0].auditerStatus > 0)) {
				// 			acceptanceIds += v.acceptanceId + ',';
				// 		}
				// 	});
				// 	layer.confirm('确定删除该条数据吗？', function (index) {
				// 		$.post('/plbMtlSettleup/delPlbMtlSettleup', {acceptanceIds: acceptanceIds}, function (res) {
				// 			layer.close(index);
				// 			if (res.flag) {
				// 				layer.msg('删除成功！', {icon: 1});
				// 				tableObj.config.where._ = new Date().getTime();
				// 				tableObj.reload();
				// 			} else {
				// 				layer.msg('删除失败！', {icon: 2});
				// 			}
				// 		});
				// 	});
				// 	break;
				case 'submit':
					if (checkStatus.data.length != 1) {
						layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
						return false;
					}
					if(checkStatus.data[0].auditerStatus&&checkStatus.data[0].auditerStatus != '0'){
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
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '59'}, function (res) {
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
								delete approvalData.checklist;
								delete approvalData.detailsInfo;
								delete approvalData.acceptanceAttachmentList;
								approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
								approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
								newWorkFlow(flowData.flowId, function (res) {
									var submitData = {
										acceptanceId:approvalData.acceptanceId,
										runId: res.flowRun.runId
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/workflow/acceptanceManager/updateById',
										data: submitData,
										dataType: 'json',
										//contentType: "application/json;charset=UTF-8",
										type: 'post',
										success: function (res) {
											layer.close(loadIndex);
											if (res.flag) {
												layer.close(index);
												layer.msg('提交成功!', {icon: 1});
												tableObj.config.where._ = new Date().getTime();
												tableObj.reload()
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
		table.on('tool(tableObj)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'detail') {
				newOrEdit(4,data)
			}
		});

		/**
		 * 加载表格方法
		 */
		function tableInit(projId) {
			var searchObj = getSearchObj();
			searchObj.projectId = projId || '';
			searchObj.lockUser = 'true';
			// searchObj.isRecification = false;
			// searchObj.recificationStatus ='1,2,3';
			// searchObj.acceptanceFlag ='0,1';
			/*searchObj.orderbyFields = upperFieldMatch(TableUIObj.orderbyFields);
			searchObj.orderbyUpdown = TableUIObj.orderbyUpdown;*/

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
				url: '/workflow/acceptanceManager/select',
				toolbar: '#toolbarHead',
				cols: [cols],
				defaultToolbar: ['filter'],
				//height: 'full-80',
				page: {
					limit: TableUIObj.onePageRecoeds,
					limits: [10, 20, 30, 40, 50]
				},
				where: searchObj,
				autoSort: false,
				/*request: {
					limitName: 'pageSize'
				},
				response: {
					statusName: 'flag',
					statusCode: true,
					msgName: 'msg',
					countName: 'totleNum',
					dataName: 'data'
				},*/
				done: function () {
					//增加拖拽后回调函数
					soulTable.render(this, function () {
						TableUIObj.dragTable('tableObj')
					})

					if (TableUIObj.onePageRecoeds != this.limit) {
						TableUIObj.update({onePageRecoeds: this.limit})
					}
				}
			}

			if (TableUIObj.orderbyFields) {
				option.initSort = {
					field: TableUIObj.orderbyFields,
					type: TableUIObj.orderbyUpdown
				}
			}

			tableObj = table.render(option);
		}

		/**
		 * 新增、编辑方法
		 * @param type 类型(1-新增，2-编辑)
		 * @param data 编辑时的信息
		 */
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			var acceptanceId = '';
			var content ='/workflow/secirityManager/addRectification?urlType=acceptance'
			var projId = $('#leftId').attr('projId');
			//$('#leftId').attr('_type',type);
			if (type == 1) {
				title = '新增';
				url = '/workflow/acceptanceManager/insert';
			} else if (type == 2) {
				title = '安全验收';
				//url = '/workflow/acceptanceManager/updateById?acceptanceFlag=1&acceptanceId='+data.acceptanceId,
				url = '/workflow/acceptanceManager/updateById'
				securityInfoDate=data;
			}else if(type == '4'){
				title = '安全验收查看详情'
				content = '/workflow/secirityManager/addRectification?urlType=acceptance&type=4'
				securityInfoDate=data;

			}

			layer.open({
				type: 2,
				title: title,
				area: ['100%', '100%'],
				btn: type != '4'?['保存','提交审批', '取消']:['确定'],
				btnAlign: 'c',
				content:content,
				success: function () {

				},
				yes: function (index,layero) {
					var childData  = $(layero).find("iframe")[0].contentWindow.getDate1();
					if(type!='4'){
						var _flay = false
						if(childData){
							// if(!childData.acceptanceDesc){
							// 	_flay = true
							// 	layer.msg('验收描述不能为空！', {icon: 0, time: 2000});
							// }
							if(!childData.acceptanceUser){
								_flay = true
								layer.msg('验收人不能为空！', {icon: 0, time: 2000});
							}
							if(!childData.acceptanceTime){
								_flay = true
								layer.msg('验收时间不能为空！', {icon: 0, time: 2000});
							}
							if(!childData.acceptanceResult){
								_flay = true
								layer.msg('验收结果不能为空！', {icon: 0, time: 2000});
							}
							if(!childData.acceptanceAttachmentId){
								_flay = true
								layer.msg('验收照片不能为空！', {icon: 0, time: 2000});
							}
						}
						if(_flay){
							return false
						}
						var loadIndex = layer.load();
						$.ajax({
							url:url,
							dataType:"json",
							data:childData,
							type:"post",
							success:function(res){
								layer.close(loadIndex);
								//console.log(res);
								if(res.code==="0"||res.code===0){
									layer.close(index)
									tableObj.reload()
								}
							}
						})
					}else {
						layer.close(index)
					}
				},
				btn2: function (index,layero) {
					// 提交前先保存

					var childData  = $(layero).find("iframe")[0].contentWindow.getDate1();
					var _flay = false
					if(childData){
						// if(!childData.acceptanceDesc){
						// 	_flay = true
						// 	layer.msg('验收描述不能为空！', {icon: 0, time: 2000});
						// }
						if(!childData.acceptanceUser){
							_flay = true
							layer.msg('验收人不能为空！', {icon: 0, time: 2000});
						}
						if(!childData.acceptanceTime){
							_flay = true
							layer.msg('验收时间不能为空！', {icon: 0, time: 2000});
						}
						if(!childData.acceptanceResult){
							_flay = true
							layer.msg('验收结果不能为空！', {icon: 0, time: 2000});
						}
						if(!childData.acceptanceAttachmentId){
							_flay = true
							layer.msg('验收照片不能为空！', {icon: 0, time: 2000});
						}
					}
					if(_flay){
						return false
					}
					var loadIndex = layer.load();
					$.ajax({
						url: url,
						data:childData,
						dataType: 'json',
						//contentType: "application/json;charset=UTF-8",
						type: 'post',
						success: function (res) {
							var approvalData = res.object;
							delete approvalData.checklist;
							delete approvalData.detailsInfo;
							delete approvalData.acceptanceAttachmentList;
							approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
							approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
							layer.close(loadIndex);
							if (res.flag) {
								layer.close(index);
								layer.open({
									type: 1,
									title: '选择流程',
									area: ['70%', '80%'],
									btn: ['确定', '取消'],
									btnAlign: 'c',
									content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
									success: function () {
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '59'}, function (res) {
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
									yes: function (_index) {
										var checkStatus = table.checkStatus('flowTable');
										if (checkStatus.data.length > 0) {
											var flowData = checkStatus.data[0];
											newWorkFlow(flowData.flowId, function (res) {
												var submitData = {
													acceptanceId:approvalData.acceptanceId,
													runId: res.flowRun.runId
													//auditerStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: "/workflow/acceptanceManager/updateById",
													data: submitData,
													dataType: 'json',
													//contentType: "application/json;charset=UTF-8",
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
											},approvalData);
										} else {
											layer.close(loadIndex);
											layer.msg('请选择一项！', {icon: 0});
										}
									}
								});
							} else {
								layer.msg('保存失败！', {icon: 2});
							}

						}
					});
					return false;
				}
			});
		}


		// 查询
		$('#searchBtn').on('click', function(){
			tableInit($('#leftId').attr('projId') || '');
		});

		// 高级查询
		$('#advancedQuery').on('click', function(){
			layer.msg('功能完善中')
		});

		/**
		 * 获取查询条件
		 * @returns {{planNo: (*), planName: (*)}}
		 */
		function getSearchObj() {
			var searchObj = {}

			if($('.query_module [name="documentNo"]').val()){
				searchObj.documentNo=$('.query_module [name="documentNo"]').val()
			}
			if($('.query_module [name="acceptanceTime"]').val()){
				searchObj.acceptanceTime=$('.query_module [name="acceptanceTime"]').val()
			}
			if($('.query_module [name="auditerStatus"]').val()||$('.query_module [name="auditerStatus"]').val()==='0'){
				searchObj.auditerStatus=$('.query_module [name="auditerStatus"]').val()
			}

			return searchObj
		}
	});

	/**
	 * 新建流程方法
	 * @param flowId
	 * @param approvalData
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
		tableObj.config.where._ = new Date().getTime();
		tableObj.reload()
	}
	//判断undefined
	function undefind_nullStr(value) {
		if(value==undefined || value == "undefined"){
			return ""
		}
		return value
	}
</script>
</body>
</html>
