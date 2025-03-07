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
	<title>安全检查</title>

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
	<script type="text/javascript" src="/js/planother/planotherUtil.js?222021080915083"></script>

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
		.mtl_info td[data-field="attachName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}

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
			<h2>安全检查</h2>
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
					<input type="text" name="securityNo" placeholder="单据号" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 10px;">
					<input type="text" name="planName" placeholder="检查名称" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 10px;">
					<select class="testTypeNo" name="testTypeNo" ></select>
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
<%--		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="examineTest">执行检查</button>--%>
		<button class="layui-btn layui-btn-sm " lay-event="add">新增</button>
		<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="edit">编辑</button>
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

<script type="text/html" id="toolbarDemoIn">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
		<button class="layui-btn layui-btn-sm" lay-event="choice">选择</button>
	</div>
</script>

<script type="text/html" id="barDemo">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>
<script type="text/html" id="internalBar">
	<a href="javascript:;" class="openFile addRow" style="position:relative;" lay-event="butfile">
		<button type="button"  class="layui-btn layui-btn-xs" style="margin-right:10px;">
			<i class="layui-icon" >&#xe67c;</i>附件上传
		</button>
		<input type="file" multiple id={{"fileupload"+d.LAY_INDEX}} data-url="/upload?module=H5"  name="file">
	</a>
</script>

<script type="text/html" id="toolbarDemoIn2">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="choice">选择</button>
	</div>
</script>

<script type="text/html" id="toolBar">
	<a class="layui-btn layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
</script>


<script>
	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text');
		tipIndex = layer.tips(tip, this);
	}, function () {
		layer.close(tipIndex);
	});


	// 表格显示顺序
	var colShowObj = {
		securityNo: {field: 'securityNo', title: '单据号', sort: true, hide: false},
		projectName:{field:'projectName',title:'项目名称',sort:true,hide:false},
		planName: {field: 'planName', title: '检查名称', sort: true, hide: false},
		testTypeName: {field: 'testTypeName', title: '检查类型'},
		testDeptName: {field: 'testDeptName', title: '检查单位'},
		testLeaderName: {field: 'testLeaderName', title: '检查责任人', sort: true, hide: false},
		inspectionlevel: {field: 'inspectionlevel', title: '检查级别', templet: function (d) {
				var str = ''
				if(dictionaryObj&&dictionaryObj['INSPECTION_LEVEL']&&dictionaryObj['INSPECTION_LEVEL']['object']){
					str = dictionaryObj['INSPECTION_LEVEL']['object'][d.inspectionlevel]
				}
				return str||''
			}},
		createTime: {field: 'createTime', title: '检查日期', sort: true, hide: false},
		currFlowUserName: {field: 'currFlowUserName', title: '当前处理人', sort: false, hide: false},
		auditerStatus: {
			field: 'auditerStatus', title: '审批状态', sort: true, hide: false, templet: function (d) {
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

	var TableUIObj = new TableUI('plb_security_checklist');

	// 获取数据字典数据
	var dictionaryObj = {
		CONTRACT_TYPE: {},
		CBS_UNIT:{},
		TAX_RATE:{},
		INSPECTION_LEVEL:{},
		CHECK_FREQUENCY:{}
	}
	var dictionaryStr = 'CONTRACT_TYPE,CBS_UNIT,TAX_RATE,INSPECTION_LEVEL,CHECK_FREQUENCY';
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

	//选部门控件添加
	// $(document).on('click', '#testDeptName', function () {
	// 	dept_id = "testDeptName";
	// 	$.popWindow("/common/selectDept?0");
	// });
	//选选人控件添加
	// $(document).on('click', '#testLeaderName', function () {
	// 	user_id = "testLeaderName";
	// 	$.popWindow("/projectTarget/selectOwnDeptUser?0");
	// })

	var tableObj = null;

	layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree','treeTable'], function () {
		var form = layui.form,
				laydate = layui.laydate,
				table = layui.table,
				layElement = layui.element,
				soulTable = layui.soulTable,
				eleTree = layui.eleTree;
				treeTable = layui.treeTable;


		TableUIObj.init(colShowObj, function(){
			// $('.no_data').hide();
			// $('.table_box').show();
			// tableInit();
		});

		//渲染检查类型
		var $select1 = $(".testTypeNo");
		var optionStr = '<option value="">请选择检查类型</option>';
		$.ajax({ //查询文档等级
			url: '/Dictonary/selectDictionaryByNo?dictNo=SECURITY_CHECK_TYPE',
			type: 'get',
			dataType: 'json',
			async:false,
			success: function (res) {
				var data=res.data
				if(data!=undefined&&data.length>0){
					for(var i=0;i<data.length;i++){
						optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
					}
				}
			}
		})
		$select1.html(optionStr);

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
				case 'add':
					if (!$('#leftId').attr('projId')) {
						layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
						return false;
					}
					newOrEdit(1);
					break;
				case 'edit':
					if (!$('#leftId').attr('projId')) {
						layer.msg('请选择左侧项目！', {icon: 0, time: 2000});
						return false;
					}
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

					/*   $.get('/plbMtlSettleup/getDataByCondition', {checkliId: checkStatus.data[0].checkliId}, function(res) {
                           if (res.flag){
                               newOrEdit(2, res.data[0]);
                           } else {
                               layer.msg('获取信息失败！', {icon: 0});
                           }
                       });*/
					break;
				case 'del':
					if (checkStatus.data.length == 0) {
						layer.msg('请选择需要删除的数据！', {icon: 0});
						return false
					}
					if (checkStatus.data[0].auditerStatus > 0) {
						layer.msg('该条数据已提交，不可删除！', {icon: 0});
						return false;
					}
					var ids = ''
					checkStatus.data.forEach(function (v) {
						if (!(checkStatus.data[0].auditerStatus > 0)) {
							ids += v.checkliId + ',';
						}
					});
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/workflow/secirityManager/delchecklist', {ids: ids}, function (res) {
							layer.close(index);
							if (res.code=='0') {
								layer.msg('删除成功！', {icon: 1});
								
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
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '57'}, function (res) {
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
								delete approvalData.detailsInfoList;
								approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
								approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
								newWorkFlow(flowData.flowId, function (res) {
									var submitData = {
										checkliId:approvalData.checkliId,
										runId: res.flowRun.runId
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/workflow/secirityManager/addSecurityOrUpdate',
										data: JSON.stringify(submitData),
										dataType: 'json',
										contentType: "application/json;charset=UTF-8",
										type: 'post',
										success: function (res) {
											layer.close(loadIndex);
											if (res.flag) {
												layer.close(index);
												layer.msg('提交成功!', {icon: 1});
												
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
				/*layer.open({
                    type: 2,
                    title: '材料结算详情',
                    area: ['100%', '100%'],
                    btn: ['确定'],
                    btnAlign: 'c',
                    content: '/plbMtlSettleup/getPlbMtlSettlement?type=2&checkliId=' + data.checkliId,
                    yes: function (index) {
                        layer.close(index);
                    }
                });*/
			}
		});

		/**
		 * 加载表格方法
		 */
		function tableInit(projId) {
			var searchObj = getSearchObj();
			searchObj.projectId = projId || '';
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
				url: '/workflow/secirityManager/getSecurityCheck',
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

		// 内部加行按钮
		table.on('toolbar(detailTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					var oldDataArr = inspectionContent(2).dataArr
					oldDataArr.push({});
					table.reload('detailTable', {
						data: oldDataArr
					});
					break;
				case 'choice':
					layer.open({
						type: 1,
						title: '选择安全检查计划',
						btn: ['确定','取消'],
						btnAlign: 'c',
						area: ['90%', '90%'],
						maxmin: true,
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
								url: '/security2Plan/select?delFlag=0&projectId='+$('#leftId').attr('projId'),
								cols: [[
									{checkbox: true},
									{field: 'documentNo', title: '单据号', minWidth: 90},
									{field:'projectName',title:'项目名称',minWidth: 120},
									{field: 'securityKnowledgeName', title: '检查项名称', minWidth: 120},
									{field: 'solutions', title: '检查项描述', minWidth: 160},
									{field: 'personLiableName', title: '责任人', minWidth: 100},
									{field: 'checkFrequency', title: '检查频率', minWidth: 100, templet: function (d) {
										return '<span class="checkFrequency" checkFrequency="'+(d.checkFrequency || '') +'" >' + (d.checkFrequency&&dictionaryObj["CHECK_FREQUENCY"]?dictionaryObj["CHECK_FREQUENCY"].object[d.checkFrequency] : '') + '</span>'
									}},
									{field: 'securityKnowledgeName', title: '检查详细内容',minWidth: 150},
									{field: 'securityPlanBeginDate', title: '计划检查开始日期', minWidth: 140},
									{field: 'securityPlanEndDate', title: '计划检查结束日期', minWidth: 140},
								]],
								height: 'full-500',
								limit:10000000,
								// page: true,
								done:function(res){
									var oldDataArr = inspectionContent().dataArr;
									var _dataa=res.data;

									var indexArr = []
									if(oldDataArr!=undefined&&oldDataArr.length>0){
										for(var i = 0 ; i <_dataa.length;i++){
											for(var n = 0 ; n < oldDataArr.length; n++){
												if((_dataa[i].securityPlanId == oldDataArr[n].securityPlanId)&&indexArr.indexOf(_dataa[i].securityPlanId)<0){
													$('.layui-table tr[data-index=' + i + '] input[type="checkbox"]').next(".layui-form-checkbox").click();
													indexArr.push(_dataa[i].securityPlanId)
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
						yes: function (index,layero) {
							var checkStatus = table.checkStatus('tableDemoIn').data; //获取选中行数据

							//判断是否选择数据
							if (checkStatus.length == 0) {
								layer.msg('请选择一项！', {icon: 0});
								return false
							}

							var ids = ''
							checkStatus.forEach(function(item){
								ids += item.securityPlanId + ','
							})

							$.post('/securityTerm/getByIds', {ids: ids}, function (res) {
								var datas = res.obj

								//遍历表格获取每行数据进行保存
								var dataArr = inspectionContent(2).dataArr;

								datas.forEach(function (item) {
									if(dataArr){
										var _flag = true
										for(var j=0;j<dataArr.length;j++){
											if(dataArr[j].securityPlanId==item.securityPlanId){
												_flag = false
											}
										}
										if(_flag&&item.detailList&&item.detailList.length>0){
											item.detailList.forEach(function (item2) {
												item2.securityDangerDesc = item2.securityDanger
												item2.securityGrade = item2.securityDangerGrade
											})
											dataArr = dataArr.concat((item.detailList))
										}
									}else{
										if(item.detailList&&item.detailList.length>0){
											item.detailList.forEach(function (item2) {
												item2.securityDangerDesc = item2.securityDanger
												item2.securityGrade = item2.securityDangerGrade
											})
											dataArr = dataArr.concat((item.detailList))
										}
									}
								})

								layer.close(index);
								table.reload('detailTable', {
									data: dataArr,
									// height: dataArr&&dataArr.length>5?'full-350':false
								});
							})
						}
					})
					break;
			}
		});
		//触发复选框选择
		table.on('checkbox(tableDemoIn)', function (obj) {
			// console.log(obj.data) //得到当前行数据
			var data = table.checkStatus('tableDemoIn').data;
			var ids = ''
			data.forEach(function(item){
				ids += item.securityPlanId + ','
			})
			$('#downBox').show()
			var loadIndex = layer.load();
			$.post('/securityTerm/getByIds', {ids: ids}, function (res) {
				var datas = res.obj
				var newArr = []
				datas.forEach(function (item) {
					if(item.detailList&&item.detailList.length>0){
						newArr = newArr.concat((item.detailList))
					}
				})
				tableShowDown(newArr)
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
					{field: 'securityKnowledgeName', minWidth:150,title: '检查项名称'},
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
				height: 'full-500',
				limit:10000000,
				// page: true,
				done:function(res){

				}
			});
		}
		// 内部删行操作
		table.on('tool(detailTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;

			if (layEvent === 'del') {
				obj.del();
				if (data.securityContentId) {
					$.get('/workflow/secirityManager/delDetailsInfo', {ids: data.securityContentId}, function (res) {

					});
				}
				var oldDataArr = inspectionContent(2).dataArr

				table.reload('detailTable', {
					data: oldDataArr
				});
			}else if (layEvent == 'chooseCollectionUser') {
				if($tr.find('[name="needRecification"]').attr('needRecification')=='0'&&(!$tr.find('[name="needRecification"]').attr('disabled'))){
					user_id = $tr.find('[name="rectificationPersion"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'chooseCollectionUser2') {
				if($tr.find('[name="needAcceptance"]').attr('needAcceptance')=='0'&&(!$tr.find('[name="needAcceptance"]').attr('disabled'))){
					user_id = $tr.find('[name="acceptancePersion"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}

			}else if (layEvent == 'dateSelection') {
				var $tr2 = $('.mtl_info').find($tr.selector).find('input[name="rectificationPeriod"]');
				$tr2.each(function (index,element) {
					laydate.render({
						elem: element
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
					});
				})
			}else if (layEvent == 'butfile') {
				var $tr1 = $tr.selector
				fileuploadFn( $tr1+' [id^=fileupload]', $( $tr1+' [id^=fileAll]'),1);
			}
		});

		/**
		 * 新增、编辑方法
		 * @param type 类型(1-新增，2-编辑)
		 * @param data 编辑时的信息
		 */
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			var checkliId = '';
			var projId = $('#leftId').attr('projId');
			//$('#leftId').attr('_type',type);
			if (type == 1) {
				title = '新增';
				url = '/workflow/secirityManager/addSecurityOrUpdate';
			} else if (type == 2) {
				title = '编辑';
				url = '/workflow/secirityManager/addSecurityOrUpdate';
				checkliId = data.checkliId;
			}else if(type == '4'){
				title = '查看详情'
			}

			layer.open({
				type: 1,
				title: title,
				area: ['100%', '100%'],
				btn: type != '4'?['保存','提交审批', '取消']:['确定'],
				btnAlign: 'c',
				content: ['<div class="layer_wrap _disabled"><div class="layui-collapse">',
					/* region 基本信息 */
					'<div class="layui-colla-item"><h2 class="layui-colla-title">安全检查</h2>' +
					'<div class="layui-colla-content layui-show order_base_info"><form id="baseForm" class="layui-form" lay-filter="baseForm">',
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">单据号<span field="securityNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" readonly name="securityNo" autocomplete="off" style="background: #e7e7e7"class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" title="项目名称">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">检查名称<span field="planName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="planName" id="planName" autocomplete="off"  class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">检查类型<span field="testTypeNo" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<select id="testTypeNo" name="testTypeNo" ></select>' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">检查单位<span field="testDeptName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="testDeptName" id="testDeptName" autocomplete="off"   class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					'<div class="layui-row">' +
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">检查人<span field="testLeaderName" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="testLeaderName" id="testLeaderName" autocomplete="off"   class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">检查级别<span field="inspectionlevel" class="field_required">*</span></label>' +
					'<div class="layui-input-block form_block">' +
					'<select id="inspectionlevel" name="inspectionlevel" ></select>' +
					'</div>' +
					'</div>' +
					'</div>',
					// '<div class="layui-col-xs6" style="padding: 0 5px">' +
					// '<div class="layui-form-item">' +
					// '<label class="layui-form-label form_label">描述说明</label>' +
					// '<div class="layui-input-block form_block">' +
					// '<input type="text" name="memo" placeholder="请输入内容" autocomplete="off"   class="layui-input">' +
					// '</div>' +
					// '</div>' +
					// '</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">备注</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="remarks" placeholder="请输入内容" autocomplete="off"   class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs6" style="padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">检查日期</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="createTime" readonly class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">附件</label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload" data-url="/upload?module=H5" name="file">' +
					'</a>' +
					// '<div class="progress" id="progress">' +
					// '<div class="bar"></div>\n' +
					// '</div>' +
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
					'  </div>\n',
					/* endregion */
					/* region 检查内容 */
					'<div class="layui-colla-item"><h2 class="layui-colla-title">检查内容</h2>' +
					'<div class="layui-colla-content layui-show mtl_info">' +
					'<table id="detailTable" lay-filter="detailTable"></table>' +
					'</div>' +
					'</div>',
					/* endregion */
					/* region 检查内容 */
					/*'<div class="layui-colla-item"><h2 class="layui-colla-title">检查计划要求</h2>' +
					'<div class="layui-colla-content  contract_list">' +
					'<table id="planTable" lay-filter="planTable"></table>' +
					'</div>' +
					'</div>',*/
					/* endregion */
					'</div></div>'].join(''),
				success: function () {
					//渲染检查类型
					var $select1 = $("#testTypeNo");
					var optionStr = '<option value="">请选择</option>';
					$.ajax({ //查询文档等级
						url: '/Dictonary/selectDictionaryByNo?dictNo=SECURITY_CHECK_TYPE',
						type: 'get',
						dataType: 'json',
						async:false,
						success: function (res) {
							var data=res.data
							if(data!=undefined&&data.length>0){
								for(var i=0;i<data.length;i++){
									optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
								}
							}
						}
					})
					$select1.html(optionStr);
					//渲染检查级别
					var str = '<option value="">请选择</option>'
					if(dictionaryObj&&dictionaryObj['INSPECTION_LEVEL']&&dictionaryObj['INSPECTION_LEVEL']['str']){
						str += dictionaryObj['INSPECTION_LEVEL']['str']
					}
					$('#inspectionlevel').html(str)

					//回显项目名称
					getProjName('#projectName',projId?projId:data.projId)
					fileuploadFn('#fileupload', $('#fileContent'),1);


					var detailsTableData = [];

					// 编辑时显示数据
					if (type == 2||type == 4) {
						form.val("baseForm", data);


						//附件
						if (data.attachmentList && data.attachmentList.length > 0) {
							var fileArr = data.attachmentList;
							$('#fileContent').append(echoAttachment(fileArr));
						}

						detailsTableData = data.detailsInfoList || [];
					} else {
						// 获取自动编号
						getAutoNumber({autoNumberType: 'security'}, function(res) {
							$('input[name="securityNo"]', $('#baseForm')).val(res.obj);
							$('input[name="testDeptName"]', $('#baseForm')).val(res.object.deptName).attr('deptId',res.object.deptId);
							$('input[name="testLeaderName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.object.createUser);
							$('input[name="createTime"]', $('#baseForm')).val(res.object&&res.object.createDate);
						});
						$('.refresh_no_btn').show().on('click', function() {
							getAutoNumber({autoNumberType: 'security'}, function(res) {
								$('input[name="securityNo"]', $('#baseForm')).val(res.obj);
								$('input[name="testDeptName"]', $('#baseForm')).val(res.object.deptName).attr('deptId',res.object.deptId);
								$('input[name="testLeaderName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.object.createUser);
								$('input[name="createTime"]', $('#baseForm')).val(res.object&&res.object.createDate);
							});
						});
					}

					var cols = [
						{type: 'numbers', title: '序号'},
						{
							field: 'securityRegionName', title: '检查区域', minWidth: 166, templet: function (d) {
								return '<input securityContentId="' + (d.securityContentId || '') + '" securityRegionId="'+(d.securityRegionId || '')+'" checkliId="'+(d.checkliId || '')+'" type="text" name="securityRegionName" class="layui-input tips" style="width: 90%;height: 100%;" value="' + (d.securityRegionName || '') + '"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="position: absolute;top: 0;right: 2px;font-size: 25px;cursor: pointer"></i>'
							}
						},
						{
							field: 'securityKnowledgeName', title: '*检查项', minWidth: 160, templet: function (d) {
								return '<input type="text" name="securityKnowledgeName" readonly class="layui-input tips required" names="检查项" style="height: 100%;background: #e7e7e7" value="' + (d.securityKnowledgeName || '') + '">'
							}
						},
						{
							field: 'securityDangerDesc', title: '*检查内容', minWidth: 200, templet: function (d) {
								return '<input type="text" name="securityDangerDesc" securityDangerId="'+(d.securityDangerId || '')+'" securityPlanId="'+(d.securityPlanId || '')+'" securityTermId="'+(d.securityTermId || '')+'"  class="layui-input tips required" names="检查内容" style="width: 90%;height: 100%;" value="' + (d.securityDangerDesc || '') + '">' +
										'<i class="layui-icon layui-icon-add-circle chooseMaterials2" style="position: absolute;top: 0;right: 2px;font-size: 25px;cursor: pointer"></i>'
							}
						},
						{
							field: 'securityGrade', title: '隐患级别', minWidth: 160, templet: function (d) {
								if(d.securityGrade===0||d.securityGrade==="0"){
									return '<span class="securityGrade" securityGrade="'+d.securityGrade+'" >重大隐患</span>'
								}else if(d.securityGrade===1||d.securityGrade==="1"){
									return '<span class="securityGrade" securityGrade="'+d.securityGrade+'">一般隐患</span>'
								}else{
									return '<span class="securityGrade"></span>'
								}
							}
						},
						{
							field: 'checkSituation', title: '*检查情况', minWidth: 200, templet: function (d) {
								return '<input type="text" name="checkSituation" class="layui-input tips required" names="检查情况" style="height: 100%;" value="' + (d.checkSituation || '') + '">'
							}
						},
						{
							field: 'attachName',
							title: '检查照片',
							align: 'center',
							minWidth: 200,
							templet: function (d) {
								var fileArr = d.attachList;
								return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
										'</div>'

							}
						},
						{title: '上传检查照片', align: 'center', toolbar: '#internalBar', minWidth: 200},
						{
							field: 'needRecification', title: '是否需要整改', minWidth: 200, templet: function (d) {
								if(d.needRecification=='1'){
									return '<input type="checkbox"  name="needRecification" needRecification="1" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">'
								}else{
									return '<input type="checkbox" checked="" name="needRecification" needRecification="0" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">'
								}
								//return '<input type="text" name="needRecification" class="layui-input" style="height: 100%;" value="' + (d.needRecification || '') + '">'
							}
						},
						{
							field: 'dangerLocation', title: '隐患位置', minWidth: 200, templet: function (d) {
								return '<input type="text" name="dangerLocation" class="layui-input" style="height: 100%;" value="' + (d.dangerLocation || '') + '">'
							}
						},
						{
							field: 'urls', title: '图纸位置', minWidth: 100, templet: function (d) {
								if(d.securityRegionName){
									if(!d.urls){
										return  '<span class="drawing" id="drawingId'+d.LAY_INDEX+'">未上传</span>'
									}else {
										if((d.regionX!=undefined&&d.regionX!="")&&(d.regionY!=undefined&&d.regionY!="")){
											return  '<a class="drawing" style="cursor: pointer;color: blue" id="drawingId'+d.LAY_INDEX+'" onclick="drawingImg($(this))" style="margin-left: 10px" attrurl="'+d.urls+'" regionX="'+d.regionX+'" regionY="'+d.regionY+'" ><span>已标注</span></a>'
										}else{
											return  '<a class="drawing" style="cursor: pointer;color: blue" id="drawingId'+d.LAY_INDEX+'" onclick="drawingImg($(this))" style="margin-left: 10px" attrurl="'+d.urls+'" ><span>未标注</span></a>'
										}

									}
								}else {
									return  '<span class="drawing" id="drawingId'+d.LAY_INDEX+'"></span>'
								}
							}
						},
						{
							field: 'rectificationPersion', title: '*整改人', minWidth: 120,event: 'chooseCollectionUser', templet: function (d) {
								if(d.needRecification=='1'){
									return '<input type="text" name="rectificationPersion" id="rectificationPersion'+d.LAY_INDEX+'" rectificationPersion="'+(d.rectificationPersion||'')+'" disabled class="layui-input" names="整改人" style="height: 100%;background: #e7e7e7;" value="' + (d.rectificationPersionName || '') + '">'
								}else{
									return '<input type="text" name="rectificationPersion" id="rectificationPersion'+d.LAY_INDEX+'" rectificationPersion="'+(d.rectificationPersion||'')+'" class="layui-input required" names="整改人" style="height: 100%;" value="' + (d.rectificationPersionName || '') + '">'
								}

							}
						},
						{
							field: 'securityDangerMeasures', title: '*整改措施', minWidth: 200, templet: function (d) {
								// return '<span class="securityDangerMeasures">' + (d.securityDangerMeasures || '') + '</span>';
								if(d.needRecification=='1'){
									return '<input type="text" name="securityDangerMeasures" class="layui-input tips" names="整改措施" disabled style="height: 100%;background: #e7e7e7;" value="' + (d.securityDangerMeasures || '') + '">'
								}else{
									return '<input type="text" name="securityDangerMeasures" class="layui-input tips required" names="整改措施" style="height: 100%;" value="' + (d.securityDangerMeasures || '') + '">'
								}
							}
						},
						{
							field: 'rectificationPeriod', title: '*整改期限', minWidth: 130,event: 'dateSelection', templet: function (d) {
								if(d.needRecification=='1'){
									return '<input type="text" name="rectificationPeriod" class="layui-input" disabled names="整改期限" style="height: 100%;background: #e7e7e7;" value="' + (d.rectificationPeriod || '') + '">'
								}else{
									return '<input type="text" name="rectificationPeriod" class="layui-input required" names="整改期限" style="height: 100%;" value="' + (d.rectificationPeriod || '') + '">'
								}

							}
						},
						{
							field: 'needAcceptance', title: '是否需要验收', minWidth: 120, templet: function (d) {
								if(d.needAcceptance=='1'){
									return '<input type="checkbox"  name="needAcceptance" needAcceptance="1" lay-skin="switch" lay-filter="switchTest2" lay-text="是|否">'
								}else{
									return '<input type="checkbox" checked="" name="needAcceptance" needAcceptance="0" lay-skin="switch" lay-filter="switchTest2" lay-text="是|否">'
								}

								//return '<input type="text" name="needAcceptance" class="layui-input" style="height: 100%;" value="' + (d.needAcceptance || '') + '">'
							}
						},
						{
							field: 'acceptancePersion', title: '*验收人', minWidth: 120,event: 'chooseCollectionUser2', templet: function (d) {
								if(d.needAcceptance=='1'){
									return '<input type="text" name="acceptancePersion" id="acceptancePersion'+d.LAY_INDEX+'" acceptancePersion="'+(d.acceptancePersion||'')+'" disabled class="layui-input" names="验收人" style="height: 100%;background: #e7e7e7;" value="' + (d.acceptancePersionName || '') + '">'
								}else{
									return '<input type="text" name="acceptancePersion" id="acceptancePersion'+d.LAY_INDEX+'" acceptancePersion="'+(d.acceptancePersion||'')+'"  class="layui-input required" names="验收人" style="height: 100%;" value="' + (d.acceptancePersionName || '') + '">'
								}

							}
						}
					]
					var cols2 = [
						/*{type: 'numbers', title: '序号'},
						{
							field: 'mtlStockInNo', title: '检查内容', minWidth: 166, templet: function (d) {
								// return '<span class="mtl_info_mtlStockInNo">' + undefind_nullStr(d.mtlStockInNo) + '</span>';
								return '<input securityContentId="' + (d.securityContentId || '') + '" mtlLibId="'+(d.mtlLibId || '')+'" readonly type="text" name="planMtlName" class="layui-input" style="width: 90%;height: 100%;background: #e7e7e7;" value="' + (d.planMtlName || '') + '"><i class="layui-icon layui-icon-add-circle chooseMaterials" style="position: absolute;top: 0;right: 2px;font-size: 25px;cursor: pointer"></i>'
							}
						},
						{
							field: 'wbsName', title: '内容描述', minWidth: 160, templet: function (d) {
								return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.planMtlStandard || '') + '">'
							}
						},
						{
							field: 'rbsName', title: '主要难点', minWidth: 160, templet: function (d) {
								return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.planMtlStandard || '') + '">'
							}
						},
						{
							field: 'cbsName', title: '主要风险', minWidth: 160, templet: function (d) {
								return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.planMtlStandard || '') + '">'
							}
						},
						{
							field: 'mtlName', title: '风险解决措施', minWidth: 200, templet: function (d) {
								return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.planMtlStandard || '') + '">'
							}
						},
						{
							field: 'mtlStandard', title: '责任人', minWidth: 200, templet: function (d) {
								return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.planMtlStandard || '') + '">'
							}
						},
						{
							field: 'mtlValuationUnit', title: '检查频率', minWidth: 200, templet: function (d) {
								return '<input type="text" readonly name="planMtlStandard" class="layui-input" style="height: 100%;background: #e7e7e7;" value="' + (d.planMtlStandard || '') + '">'
							}
						}*/
					]

					//查看详情
					if(type!=4){
						cols.push({align: 'center', toolbar: '#barDemo', title: '操作', minWidth: 100})
					}

					table.render({
						elem: '#detailTable',
						data: detailsTableData,
						toolbar: type==4?false:'#toolbarDemoIn',
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols],
						done:function (res) {
							if(type==4){
								$('.addRow').hide()
							}

							$('.tips').on('mouseenter', function(){
								var content = $(this).val();
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
					table.render({
						elem: '#planTable',
						data: [],
						toolbar: type==4?false:'#toolbarDemoIn2',
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols2],
					});

					//查看详情
					if(type==4){
						$('._disabled').find('input,select').attr('readonly', true);
                        $('._disabled').find('select').attr('disabled', 'disabled');
						$('.mtl_info').find('input').attr('readonly', true);
						$('[name="needRecification"]').attr('disabled', 'disabled');
						$('[name="rectificationPersion"]').attr('disabled', 'disabled');
						$('[name="rectificationPeriod"]').attr('disabled', 'disabled');
						$('[name="needAcceptance"]').attr('disabled', 'disabled');
						$('[name="acceptancePersion"]').attr('disabled', 'disabled');
						$('.file_upload_box').hide()
						$('.deImgs').hide()
						$('.chooseMaterials').hide()
						$('.chooseMaterials2').hide()
					}

					form.on('switch(switchTest)', function (data) {
						var _str=''
						if (data.elem.checked == true) {
							$(data.elem).parents('tr').find('[name="needRecification"]').attr('needRecification','0')
							$(data.elem).parents('tr').find('[name="dangerLocation"]').attr('disabled',false).css("background","")
							$(data.elem).parents('tr').find('[name="rectificationPersion"]').attr('disabled',false).css("background","").addClass('required')
							$(data.elem).parents('tr').find('[name="securityDangerMeasures"]').attr('disabled',false).css("background","").addClass('required')
							$(data.elem).parents('tr').find('[name="rectificationPeriod"]').attr('disabled',false).css("background","").addClass('required')
							$(data.elem).parents('tr').find('[name="needAcceptance"]').attr({disabled:false,needAcceptance:'0'}).css("background","").prop('checked', 'checked');
							$(data.elem).parents('tr').find('[name="acceptancePersion"]').attr('disabled',false).css("background","").addClass('required')
							//_str ='<input type="checkbox" checked="" name="needAcceptance" needAcceptance="0" lay-skin="switch" lay-filter="switchTest2" lay-text="是|否">'
							//$(data.elem).parents('tr').find('[data-field="needAcceptance"] div').html(_str)
							//$('.addRow').show()
							form.render()
						} else {
							$(data.elem).parents('tr').find('[name="needRecification"]').attr('needRecification','1')
							$(data.elem).parents('tr').find('[name="dangerLocation"]').attr('disabled',true).css("background","#e7e7e7").val('')
							$(data.elem).parents('tr').find('[name="rectificationPersion"]').attr('disabled',true).css("background","#e7e7e7").val('').removeAttr('rectificationPersion user_id').removeClass('required')
							$(data.elem).parents('tr').find('[name="securityDangerMeasures"]').attr('disabled',true).css("background","#e7e7e7").val('').removeClass('required')
							$(data.elem).parents('tr').find('[name="rectificationPeriod"]').attr('disabled',true).css("background","#e7e7e7").val('').removeClass('required')
							$(data.elem).parents('tr').find('[name="needAcceptance"]').click().css("background","#e7e7e7").prop('checked', '').attr({disabled:true,needAcceptance:'1'})
							$(data.elem).parents('tr').find('[name="acceptancePersion"]').attr('disabled',true).css("background","#e7e7e7").val('').removeAttr('acceptancePersion user_id').removeClass('required')
							//_str ='<input type="checkbox" name="needAcceptance" needAcceptance="1" disabled lay-skin="switch" lay-filter="switchTest2" lay-text="是|否">'
							//$(data.elem).parents('tr').find('[data-field="needAcceptance"] div').html(_str)
							//$('.addRow').hide()
							//$(data.elem).parents('tr').find('[data-field="attachName"] div').html('')
							$(data.elem).parents('tr').find('[data-field="urls"] div').text('')
							//$(data.elem).parents('tr').find('[id^="fileAll"]').html('')
							form.render()
						}
					});

					form.on('switch(switchTest2)', function (data) {
						var _str=''
						if (data.elem.checked == true) {
							$(data.elem).parents('tr').find('[name="needAcceptance"]').attr('needAcceptance','0')
							$(data.elem).parents('tr').find('[name="acceptancePersion"]').attr('disabled',false).css("background","").addClass('required')
							form.render()
						} else {
							$(data.elem).parents('tr').find('[name="needAcceptance"]').attr('needAcceptance','1')
							$(data.elem).parents('tr').find('[name="acceptancePersion"]').attr('disabled',true).css("background","#e7e7e7").val('').removeAttr('acceptancePersion user_id').removeClass('required')
							form.render()
						}
					});
					layElement.render();
					form.render()
				},
				yes: function (index) {
					if(type!='4'){
						var loadIndex = layer.load();
						var datas = $('#baseForm').serializeArray();
						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value;
						});

						obj.testDeptId=$('#testDeptName').attr('deptId')
						obj.testLeader=$('#testLeaderName').attr('createUser')

						// 附件
						var attachmentId = '';
						var attachmentName = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');

						}
						obj.attachmentId = attachmentId;
						obj.attachmentName = attachmentName;

						obj.projectId=$('#leftId').attr('projId') || ''
						if(type==2){
							obj.checkliId=checkliId
						}
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


						$('.mtl_info').find('.required').each(function(){
							if(!$(this).val()){
								var names = $(this).attr('names');
								layer.msg(names+'不能为空！', {icon: 0, time: 2000});
								requiredFlag = true;
								return false;
							}
						});

						if (requiredFlag) {
							layer.close(loadIndex);
							return false;
						}

						var detailsInfoList = inspectionContent(1).dataArr

						obj.detailsInfoList = detailsInfoList;

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
									
									tableObj.reload();
								} else {
									layer.msg(res.msg, {icon: 2});
								}
							}
						});
					}else {
						layer.close(index);
					}
				},
				btn2: function (index) {
					// 提交前先保存
					var loadIndex = layer.load();
					var datas = $('#baseForm').serializeArray();
					var obj = {}
					datas.forEach(function (item) {
						obj[item.name] = item.value;
					});

					obj.testDeptId=$('#testDeptName').attr('deptId')
					obj.testLeader=$('#testLeaderName').attr('createUser')

					// 附件
					var attachmentId = '';
					var attachmentName = '';
					for (var i = 0; i < $('#fileContent .dech').length; i++) {
						attachmentId += $('#fileContent .dech').eq(i).find('input').val();
						attachmentName += $('#fileContent .dech').eq(i).find('input').attr('filename');
					}
					obj.attachmentId = attachmentId;
					obj.attachmentName = attachmentName;

					obj.projectId=$('#leftId').attr('projId') || ''
					if(type==2){
						obj.checkliId=checkliId
					}
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

					$('.mtl_info').find('.required').each(function(){
						if(!$(this).val()){
							var names = $(this).attr('names');
							layer.msg(names+'不能为空！', {icon: 0, time: 2000});
							requiredFlag = true;
							return false;
						}
					});

					if (requiredFlag) {
						layer.close(loadIndex);
						return false;
					}

					var detailsInfoList = inspectionContent(1).dataArr

					obj.detailsInfoList = detailsInfoList;

					$.ajax({
						url: url,
						data: JSON.stringify(obj),
						dataType: 'json',
						contentType: "application/json;charset=UTF-8",
						type: 'post',
						success: function (res) {
							var approvalData = res.obj;
							delete approvalData.detailsInfoList;
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
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '57'}, function (res) {
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
													checkliId:approvalData.checkliId,
													runId: res.flowRun.runId
													//auditerStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: "/workflow/secirityManager/addSecurityOrUpdate",
													data: JSON.stringify(submitData),
													dataType: 'json',
													contentType: "application/json;charset=UTF-8",
													type: 'post',
													success: function (res) {
														layer.close(loadIndex);
														if (res.flag) {
															layer.closeAll();
															layer.msg('提交成功!', {icon: 1});
															
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

		// 点击选择检查区域
		$(document).on('click', '.chooseMaterials', function () {
			var _this = $(this)
			var insTb = null
			layer.open({
				type: 1,
				title: '检查区域',
				btn: ['确定','取消'],
				btnAlign: 'c',
				area: ['90%', '80%'],
				maxmin: true,
				content: '<div class="wrap_right flow_Table" style="margin: 10px;">\n' +
						'<div style="position: relative">\n' +
						'<div class="table_box">\n' +
						'<table id="demoTreeTb" lay-filter="demoTreeTb"></table>\n' +
						'</div>\n' +
						'</div>\n' +
						'</div>',
				success: function () {
					var searchObj = {}
					searchObj.projectId = $('#leftId').attr('projId') || '';

					insTb=treeTable.render({
						elem: '#demoTreeTb',
						url: '/workflow/secirityManager/getRegionByProject',
						where:searchObj,
						tree: {
							iconIndex: 1,           // 折叠图标显示在第几列
							idName:'regionId',
							childName:"regions"
						},
						cols: [[
							{type: 'radio'},
							{field: 'regionName', title: '区域名称'},
							{field: '', title: '图纸',templet: function (d) {
									if(d.url== undefined||d.url==''){
										return  '<span>未上传</span>'
									}else {
										return  '<a class="preview1" style="cursor: pointer;color: blue"onclick="consult($(this))" style="margin-left: 10px" attrurl="'+d.url+'"><span>已上传</span></a>'
									}}}
						]],
					});
				},
				yes: function (index) {
					var checkStatus = insTb.checkStatus();
					var _str = '';
					if (checkStatus.length > 0) {
						//检查区域和id
						$(_this).parents('tr').find('[name="securityRegionName"]').val(checkStatus[0].longName||'').attr('securityRegionId',checkStatus[0].regionId)
						//图纸位置
						var drawingId = $(_this).parents('tr').find('.drawing').attr('id');
						if(checkStatus[0].url){
							_str = '<a class="drawing" style="cursor: pointer;color: blue" id="'+drawingId+'" onclick="drawingImg($(this))" style="margin-left: 10px" attrurl="'+checkStatus[0].url+'" ><span>未标注</span></a>'
						}else {
							_str = '<span class="drawing" id="'+drawingId+'">未上传</span>'
						}
						$(_this).parents('tr').find('[data-field="urls"] div').html(_str)
						layer.close(index);
					} else {
						layer.msg('请选择一项！', {icon: 0});
					}
				}
			})
		})

		// 点击选择检查内容
		$(document).on('click', '.chooseMaterials2', function () {
			var _this = $(this)
			layer.open({
				type: 2,
				title: '检查内容',
				btn: ['确定','取消'],
				btnAlign: 'c',
				area: ['90%', '80%'],
				maxmin: true,
				content: '/workflow/secirityManager/toStandard?urlType=securityCheck&type=radio',
				success: function () {

				},
				yes: function (index,layero) {
					var childData  = $(layero).find("iframe")[0].contentWindow.getRepairDate3();
					if(childData){
						//检查内容和隐患id
						$(_this).parents('tr').find('[name="securityDangerDesc"]').val(childData.securityDanger||'').attr('securityDangerId',childData.securityDangerId)
						//检查项
						$(_this).parents('tr').find('[name="securityKnowledgeName"]').val(childData.securityKnowledgeName||'')
						//隐患级别
						var _str=''
						if(childData.securityGrade===0||childData.securityGrade==="0"){
							_str = '<span class="securityGrade" securityGrade="'+childData.securityGrade+'" >重大隐患</span>'
						}else if(childData.securityGrade===1||childData.securityGrade==="1"){
							_str = '<span class="securityGrade" securityGrade="'+childData.securityGrade+'">一般隐患</span>'
						}else{
							_str = '<span class="securityGrade"></span>'
						}
						$(_this).parents('tr').find('[data-field="securityGrade"] div').html(_str)

						//整改措施
						$(_this).parents('tr').find('[name="securityDangerMeasures"]').val(childData.securityDangerMeasures||'')
						layer.close(index);
					}else {
						layer.msg('请选择一项！', {icon: 0});
					}

				}
			})
		})

		function inspectionContent(type){
			//遍历表格获取每行数据
			var $trs = $('.mtl_info').find('.layui-table-main tr');
			var dataArr = [];
			$trs.each(function (index) {
				var attachId = '';
				var attachName = '';
				var attachList = [];

				if(type=='1'){//提交保存
					for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
						attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
						attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
					}
				}else if(type=='2'){//加行、删行、选择
					for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
						attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
						attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
						var _obj ={
							attUrl:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('deUrl'),
							attachId:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachId'),
							attachName:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachName'),
                            size:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('size'),
							aid:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring(0,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')),
							ym:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring($('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')+1,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('_'))
						}
						attachList.push(_obj)
					}
				}

				var rectDom=$(this).find('input[name="rectificationPersion"]');
				var rectificationPersion = $(rectDom).attr('user_id')? $(rectDom).attr('user_id'): $(rectDom).attr('rectificationPersion')
				if(rectificationPersion&&rectificationPersion.indexOf(',')!=-1){
					rectificationPersion=rectificationPersion.substring(0,rectificationPersion.lastIndexOf(','))
				}
				var accepDom=$(this).find('input[name="acceptancePersion"]');
				var acceptancePersion = $(accepDom).attr('user_id')? $(accepDom).attr('user_id'): $(accepDom).attr('acceptancePersion')
				if(acceptancePersion&&acceptancePersion.indexOf(',')!=-1){
					acceptancePersion=acceptancePersion.substring(0,acceptancePersion.lastIndexOf(','))
				}
				var dataObj = {
					securityContentId: $(this).find('[name="securityRegionName"]').attr('securityContentId') || '',
					checkliId: $(this).find('[name="securityRegionName"]').attr('checkliId') || '',
					securityRegionId: $(this).find('[name="securityRegionName"]').attr('securityRegionId') || '',
					securityRegionName: $(this).find('[name="securityRegionName"]').val(),
					securityKnowledgeName: $(this).find('[name="securityKnowledgeName"]').val(),
					securityDangerId: $(this).find('[name="securityDanger"]').attr('securityDangerId') || '',

					securityPlanId: $(this).find('[name="securityDangerDesc"]').attr('securityPlanId') || '',
					securityTermId: $(this).find('[name="securityDangerDesc"]').attr('securityTermId') || '',

					securityDangerDesc: $(this).find('[name="securityDangerDesc"]').val() || '',
					securityGrade: $(this).find('.securityGrade').attr('securityGrade'),
					urls: $(this).find('.drawing').attr('attrurl'),
					regionX: $(this).find('.drawing').attr('regionX'),
					regionY: $(this).find('.drawing').attr('regionY'),
					dangerLocation: $(this).find('[name="dangerLocation"]').val(),
					needRecification: $(this).find('[name="needRecification"]').attr('needRecification') || '',
					rectificationPersion:rectificationPersion||'' ,
					rectificationPersionName: $(this).find('input[name="rectificationPersion"]').val(),
					securityDangerMeasures: $(this).find('[name="securityDangerMeasures"]').val(),
					rectificationPeriod: $(this).find('input[name="rectificationPeriod"]').val(),
					needAcceptance: $(this).find('[name="needAcceptance"]').attr('needAcceptance') || '',
					acceptancePersionName: $(this).find('input[name="acceptancePersion"]').val(),
					acceptancePersion: acceptancePersion||'',
					checkSituation: $(this).find('[name="checkSituation"]').val(),
					attachId:attachId,
					attachName:attachName
				}
				if(type=='2'){
					dataObj.attachList = attachList;
				}
				dataArr.push(dataObj);
			});
			return {
				dataArr: dataArr,
			}
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

			if($('.query_module [name="securityNo"]').val()){
				searchObj.securityNo=$('.query_module [name="securityNo"]').val()
			}
			if($('.query_module [name="planName"]').val()){
				searchObj.planName=$('.query_module [name="planName"]').val()
			}
			if($('.query_module [name="testTypeNo"]').val()){
				searchObj.testTypeNo=$('.query_module [name="testTypeNo"]').val()
			}
			if($('.query_module [name="auditerStatus"]').val()||$('.query_module [name="auditerStatus"]').val()==='0'){
				searchObj.auditerStatus=$('.query_module [name="auditerStatus"]').val()
			}

			return searchObj
		}
	});

	var _urlImg = ''
	var drawing_id;

	function drawingImg(_this){
		drawing_id = _this.attr('id');
		var url =''
		if($(_this).attr('attrurl')){
			//url+='urls='+$(_this).attr('attrurl')+'&'
			_urlImg = $(_this).attr('attrurl')
		}
		if($(_this).attr('regionX')){
			url+='regionX='+$(_this).attr('regionX')+'&'
		}
		if($(_this).attr('regionY')){
			url+='regionY='+$(_this).attr('regionY')
		}

		$.popWindow("/workflow/secirityManager/selectDrawing?type=manage&"+url);
	}

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
		
		tableObj.reload()
	}
	//判断undefined
	function undefind_nullStr(value) {
		if(value==undefined || value == "undefined"){
			return ""
		}
		return value
	}
	function getAutoNumber(params, callback) {
		$.get('/planningManage/autoNumber', params, function (res) {
			callback(res);
		});
	}
</script>
</body>
</html>
