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
	<title>项目管理策划</title>

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
	<script type="text/javascript" src="/js/planother/planotherUtil.js?202202108301508"></script>

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

		.technology_roadmap td[data-field="attachmentName"] .layui-table-cell{
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

		.optimization_scheme, .optimization_scheme .layui-table-cell,.optimization_scheme .layui-table-box,.optimization_scheme .layui-table-body ,
		.secondary_operation, .secondary_operation .layui-table-cell,.secondary_operation .layui-table-box,.secondary_operation .layui-table-body,
		.implementation_planning, .implementation_planning .layui-table-cell,.implementation_planning .layui-table-box,.implementation_planning .layui-table-body
		{
			overflow: visible;
		}
		/* 设置下拉框的高度与表格单元格的高度相同 */
		.optimization_scheme td .layui-form-select,
		.secondary_operation td .layui-form-select,
		.implementation_planning td .layui-form-select
		{
			margin-top: -10px;
			margin-left: -15px;
			margin-right: -15px;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">项目管理策划</h2>
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
					<input type="text" name="managePlanningName" placeholder="策划名称" autocomplete="off" class="layui-input">
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

<script type="text/html" id="toolbarPlan">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" type="button" lay-event="add">加行</button>
	</div>
</script>

<script type="text/html" id="barPlan">
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script type="text/html" id="internalBar">
	<a href="javascript:;" class="openFile addRow" style="position:relative;" lay-event="butfile">
		<button type="button"  class="layui-btn layui-btn-xs" style="margin-right:10px;">
			<i class="layui-icon" >&#xe67c;</i>附件上传
		</button>
		<input type="file" multiple id={{"fileupload"+d.LAY_INDEX}} data-url="/upload?module=managementPlanning"  name="file">
	</a>
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
				return '<span managePlanningId="'+d.managePlanningId+'">'+d.documentNo+'</span>'
				}},
			projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
			managePlanningName: {field: 'managePlanningName', title: '策划名称', minWidth: 120,sort: true, hide: false},
			createUserName: {field: 'createUserName', title: '编制人',minWidth: 120, sort: true, hide: false},
			createTime: {field: 'createTime', title: '编制时间',minWidth: 120, sort: true, hide: false},
			managePlanningExplain: {field: 'managePlanningExplain', title: '策划说明',minWidth: 120, sort: true, hide: false},
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
			IMPORTANCE_LEVEL:{},
			OPTIMIZATION_CATEGORY:{},
			OPTIMIZATION_TYPE:{},
			BUSINESS_CATEGORY:{},
			BUSINESS_TYPE:{}
		}
		var dictionaryStr = 'CONTROL_TYPE,CBS_UNIT,IMPORTANCE_LEVEL,OPTIMIZATION_CATEGORY,OPTIMIZATION_TYPE,BUSINESS_CATEGORY,BUSINESS_TYPE';
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

		var TableUIObj = new TableUI('plb_other_manage_planning');


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
						var managePlanningId = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span').attr('managePlanningId')
						newOrEdit(1, managePlanningId)
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
					var managePlanningId = ''
					var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span')
					$trs.each(function(){
						managePlanningId += $(this).attr('managePlanningId') + ','
					})
					// checkStatus.data.forEach(function (v, i) {
					// 	managePlanningId += v.managePlanningId + ','
					// })
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/managePlanning/del', {ids: managePlanningId}, function (res) {
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
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '56'}, function (res) {
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
								delete approvalData.securityWithBLOBsList
								delete approvalData.qualityWithBLOBsList
								approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
								approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
								newWorkFlow(flowData.flowId, function (res) {
									var submitData = {
										managePlanningId:approvalData.managePlanningId,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/managePlanning/updateById',
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

			var managePlanningId = $(obj.tr.selector).find('[data-field="documentNo"] span').attr('managePlanningId')
			if(layEvent === 'detail'){
				newOrEdit(4,managePlanningId)
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
				url: '/managePlanning/select',
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
		function newOrEdit(type, managePlanningId) {
			var title = '';
			var url = '';
			var projectId = $('#leftId').attr('projId');
			var _obj = {}
            _obj.projectId = projectId
			var data = null
			if (type == '0') {
				title = '新建';
				url = '/managePlanning/insert';
			} else if (type == '1') {
				title = '编辑';
				url = '/managePlanning/updateById';

                _obj.managePlanningId = managePlanningId
			}else if(type == '4'){
				title = '查看详情'

                _obj.managePlanningId = managePlanningId
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
					'                       <label class="layui-form-label form_label">策划名称<span field="managePlanningName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="managePlanningName"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3 layui-col" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">策划说明<!--<span field="managePlanningExplain" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="managePlanningExplain"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>' ,
					/* region 第二行 */
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">附件<span field="attachId" class="field_required">*</span></label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload" data-url="/upload?module=managementPlanning" name="file">' +
					'</a>' +
					/*'<div class="progress" id="progress">' +
					'<div class="bar"></div>\n' +
					'</div>' +*/
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
					/* region 项目基础信息 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">项目基础信息</h2>\n' +
					'    <div class="layui-colla-content layui-show project_basic_information">' +
					'		<form class="layui-form" id="baseForm2" lay-filter="baseForm2">' +
					/* region 第一行 */
					'<div class="layui-row">' +
					'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">总用地面积</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text"  name="areaCovered" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">总建筑面积</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="builtupArea" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">单体建筑数量</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="buildingsNumber" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">建筑结构</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="buildingStructure" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'<div class="layui-col-xs3" style="width: 20%; padding: 0 5px">' +
					'<div class="layui-form-item">' +
					'<label class="layui-form-label form_label">补充说明</label>' +
					'<div class="layui-input-block form_block">' +
					'<input type="text" name="remark" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'</div>' +
					'</div>' +
					'</div>',
					'</div>',
					/* endregion */
					'		</form>' +
					'    </div>\n' +
					'  </div>\n' +
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">项目详细信息</h2>\n' +
					'    <div class="layui-colla-content layui-show project_detailed_information">' +
					'		<table id="detailedTable" lay-filter="detailedTable"></table>' +
					'    </div>\n' +
					'  </div>\n' +
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">项目目标</h2>\n' +
					'    <div class="layui-colla-content layui-show project_objectives">' +
					'		<table id="objectivesTable" lay-filter="objectivesTable"></table>' +
					'    </div>\n' +
					'  </div>\n' +
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">组织架构</h2>\n' +
					'    <div class="layui-colla-content layui-show organizational_structure">' +
					'		<table id="structureTable" lay-filter="structureTable"></table>' +
					'       <div class="layui-row">' +
					'       <div class="layui-col-xs12" style=" padding: 0 5px">' +
					'       <div class="layui-form-item">' +
					'       <label class="layui-form-label form_label">策划描述</label>' +
					'       <div class="layui-input-block form_block">' +
					'       <textarea type="text" name="managePlanningDesc" id="managePlanningDesc" style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>' +
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
					'    	    <li>优化计划</li>\n' +
					'    	    <li>经营计划</li>\n' +
					'    	    <li>技术路线</li>\n' +
					'    	    <li>实施策划</li>\n' +
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
					'    	    <div class="layui-tab-item optimization_scheme">' +
					'				<table id="optimizationTable" lay-filter="optimizationTable"></table>' +
					'			</div>\n' +
					'    	    <div class="layui-tab-item secondary_operation">' +
					'				<table id="secondaryTable" lay-filter="secondaryTable"></table>' +
					'			</div>\n' +
					'    	    <div class="layui-tab-item technology_roadmap">' +
					'				<table id="roadmapTable" lay-filter="roadmapTable"></table>' +
					'			</div>\n' +
					'    	    <div class="layui-tab-item implementation_planning">' +
					'				<table id="implementationTable" lay-filter="implementationTable"></table>' +
					'			</div>\n' +
					'    	  </div>\n' +
					'    	</div>' +
					'    </div>\n' +
					'  </div>\n' +
					/* endregion */
					'</div>'].join(''),
				success: function () {
					fileuploadFn('#fileupload', $('#fileContent'));

                    //回显项目名称
                    getProjName('#projectName',projectId&&projectId)
                    var loadIndex = layer.load();
                    $.ajax({
                        url: '/managePlanning/getProjInfo',
                        data: _obj,
                        dataType: 'json',
                        type: 'post',
                        // async:false ,
                        success: function (res) {
                            if (res.flag) {
                                data = res.obj
                                if (type == 1 || type == 4) {
                                    form.val("baseForm", data.managePlanning);
                                    form.val("baseForm2", data.projWithBLOBs);
                                    //附件
                                    if (data.managePlanning&&data.managePlanning.attachmentList && data.managePlanning.attachmentList.length > 0) {
                                        var fileArr = data.managePlanning.attachmentList;
                                        $('#fileContent').append(echoAttachment(fileArr));
                                    }
									//查看详情
									if(type==4){
										$('.refresh_no_btn').hide();
										$('.file_upload_box').hide()
										$('.deImgs').hide();
									}

                                    $('#managePlanningDesc').val(data&&data.managePlanning&&data.managePlanning.managePlanningDesc||'')

                                }else{
                                    // 单据号
                                    $('input[name="documentNo"]', $('#baseForm')).val(res.obj.autoNumber);
                                    form.val("baseForm2", data.projWithBLOBs);
                                }
                            }

                            //项目详细信息
                            var cols = [
                                {type: 'numbers', title: '序号'},
                                {field: 'buildingNumber', title: '楼号', minWidth: 100},
                                {field: 'buildingHeight', title: '高度', minWidth: 100},
                                {field: 'layersNumber', title: '层数', minWidth: 80},
                                {field: 'builtupArea', title: '建筑面积', minWidth: 120},
                                {field: 'onGroundArea', title: '地上面积', minWidth: 120},
                                {field: 'undergroundArea', title: '地下面积', minWidth: 120},
                                {field: 'manufacturingCost', title: '造价', minWidth: 100},
                                {field: 'memo', title: '备注', minWidth: 200}
                            ]
                            //项目目标
                            var cols2 = [
                                {type: 'numbers', title: '序号'},
                                {field: 'targetNature', title: '目标性质', minWidth: 150},
                                {field: 'targetContent', title: '主要内容', minWidth: 160},
                                {field: 'targetExplain', title: '目标说明', minWidth: 160}
                            ]
                            //组织架构
                            var cols3 = [
                                {type: 'numbers', title: '序号'},
                                {field: 'deptName', title: '部门', minWidth: 150},
                                {field: 'privName', title: '岗位', minWidth: 160},
								{field: 'userName', title: '姓名', minWidth: 120},
								{field: 'mobileNo', title: '电话', minWidth: 120},
                                {field: 'jobDuty', title: '岗位职责', minWidth: 160}
                            ]

                            table.render({
                                elem: '#detailedTable',
                                data: data&&data.projWithBLOBs&&data.projWithBLOBs.projLists||[],
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols],
                            });

                            table.render({
                                elem: '#objectivesTable',
                                data: data&&data.projWithBLOBs&&data.projWithBLOBs.plbProjTargetWithBLOBList||[],
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols2],
                            });

                            table.render({
                                elem: '#structureTable',
                                data: data&&data.orgList||[],
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols3],
                            });

                            //策划明细子表
                            //进度策划
                            var cols4 = [
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'scheduleName', title: '节点名称', minWidth: 150, templet: function (d) {
                                        return '<input managePlanningId="' + (d.managePlanningId || '') + '" scheduleId="'+(d.scheduleId || '')+'" type="text" name="scheduleName" class="layui-input" style="height: 100%;" value="' + (d.scheduleName || '') + '">'
                                    }
                                },
                                {
                                    field: 'scheduleEndDate', title: '计划完成时间', minWidth: 160,event: 'dateSelection', templet: function (d) {
                                        return '<input type="text" name="scheduleEndDate" class="layui-input" style="height: 100%;" value="' + (d.scheduleEndDate || '') + '">'
                                    }
                                },
                                {
                                    field: 'scheduleUserName', title: '责任人', minWidth: 160, event: 'chooseCollectionUser',templet: function (d) {
                                        return '<input type="text" name="scheduleUserName" id="scheduleUserName'+d.LAY_INDEX+'" user_id="'+(d.scheduleUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.scheduleUserName || '') + '">'
                                    }
                                },
                                {
                                    field: 'supervisorUserName', title: '监督人', minWidth: 160,event: 'chooseCollectionUser2', templet: function (d) {
                                        return '<input type="text" name="supervisorUserName" id="supervisorUserName'+d.LAY_INDEX+'" user_id="'+(d.supervisorUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.supervisorUserName || '') + '">'
                                    }
                                },
                                {
                                    field: 'memo', title: '说明', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="memo" class="layui-input" style="height: 100%;" value="' + (d.memo || '') + '">'
                                    }
                                }
                            ]
                            //质量策划
                            var cols5 = [
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'mainRisks', title: '主要重难点及风险', minWidth: 150, templet: function (d) {
                                        return '<input managePlanningId="' + (d.managePlanningId || '') + '" planingQualityId="'+(d.planingQualityId || '')+'" type="text" name="mainRisks" class="layui-input tips" style="height: 100%;" value="' + (d.mainRisks || '') + '">'
                                    }
                                },
                                {
                                    field: 'contentDesc', title: '内容描述', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="contentDesc" class="layui-input tips" style="height: 100%;" value="' + (d.contentDesc || '') + '">'
                                    }
                                },
                                {
                                    field: 'solutions', title: '解决措施', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="solutions" class="layui-input tips" style="height: 100%;" value="' + (d.solutions || '') + '">'
                                    }
                                },
                                {
                                    field: 'projectUserName', title: '项目责任人', minWidth: 160,event: 'chooseCollectionUser', templet: function (d) {
                                        return '<input type="text" name="projectUserName" id="projectUserName'+d.LAY_INDEX+'" user_id="'+(d.projectUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.projectUserName || '') + '">'
                                    }
                                },
                                {
                                    field: 'companyUserName', title: '公司责任人', minWidth: 160,event: 'chooseCollectionUser2', templet: function (d) {
                                        return '<input type="text" name="companyUserName" id="companyUserName'+d.LAY_INDEX+'" user_id="'+(d.companyUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.companyUserName || '') + '">'
                                    }
                                }
                            ]
                            //安全策划
                            var cols6 = [
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'mainRisks', title: '主要重难点及风险', minWidth: 150, templet: function (d) {
                                        return '<input managePlanningId="' + (d.managePlanningId || '') + '" planingSecurityId="'+(d.planingSecurityId || '')+'" type="text" name="mainRisks" class="layui-input tips" style="height: 100%;" value="' + (d.mainRisks || '') + '">'
                                    }
                                },
                                {
                                    field: 'contentDesc', title: '内容描述', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="contentDesc" class="layui-input tips" style="height: 100%;" value="' + (d.contentDesc || '') + '">'
                                    }
                                },
                                {
                                    field: 'solutions', title: '解决措施', minWidth: 160, templet: function (d) {
                                        return '<input type="text" name="solutions" class="layui-input tips" style="height: 100%;" value="' + (d.solutions || '') + '">'
                                    }
                                },
                                {
                                    field: 'projectUserName', title: '项目责任人', minWidth: 160, event: 'chooseCollectionUser',templet: function (d) {
                                        return '<input type="text" name="projectUserName" id="projectUser_Name'+d.LAY_INDEX+'" user_id="'+(d.projectUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.projectUserName || '') + '">'
                                    }
                                },
                                {
                                    field: 'companyUserName', title: '公司责任人', minWidth: 160, event: 'chooseCollectionUser2',templet: function (d) {
                                        return '<input type="text" name="companyUserName" id="companyUser_Name'+d.LAY_INDEX+'" user_id="'+(d.companyUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.companyUserName || '') + '">'
                                    }
                                }
                            ]
                            //查看详情
                            if(type!=4){
                                cols4.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                                cols5.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                                cols6.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
                            }
                            table.render({
                                elem: '#scheduleTable',
                                data: data&&data.scheduleData||[],
                                toolbar: type==4?false:'#toolbarPlan',
                                height: data&&data.scheduleData&&data.scheduleData.length>5?'full-350':false,
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols4],
								done:function(res){
									if(type==4){
										$('._disabled [name]').attr('disabled', 'disabled');
										$('._disabled [name]').attr('readonly', true);
										form.render();
									}
								}
                            });

                            table.render({
                                elem: '#qualityTable',
                                data: data&&data.managePlanning&&data.managePlanning.qualityWithBLOBsList||[],
								height: data&&data.managePlanning&&data.managePlanning.qualityWithBLOBsList&&data.managePlanning.qualityWithBLOBsList.length>5?'full-350':false,
                                toolbar: type==4?false:'#toolbarPlan',
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols5],
								done:function(res){
									if(type==4){
										$('._disabled [name]').attr('disabled', 'disabled');
										$('._disabled [name]').attr('readonly', true);
										form.render();
									}
								}
                            });
                            table.render({
                                elem: '#securityTable',
                                data: data&&data.managePlanning&&data.managePlanning.securityWithBLOBsList||[],
								height: data&&data.managePlanning&&data.managePlanning.securityWithBLOBsList&&data.managePlanning.securityWithBLOBsList .length>5?'full-350':false,
                                toolbar: type==4?false:'#toolbarPlan',
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols6],
								done:function(res){
									if(type==4){
										$('._disabled [name]').attr('disabled', 'disabled');
										$('._disabled [name]').attr('readonly', true);
										form.render();
									}
								}
                            });
                            //成本策划
                            var cols7 = [
                                {type: 'numbers', title: '序号'},
                                {
                                    field: 'wbsName', title: 'WBS',width:200, templet: function(d) {
                                        var str = '';
                                        if (d.plbProjWbs) {
                                            str = d.plbProjWbs.wbsName;
                                        }
                                        return str;
                                    }
                                },
                                {
                                    field: 'rbsLongName', title: 'RBS',width:200, templet: function (d) {
                                        var str = '';
                                        if (d.plbRbs) {
                                            str = d.plbRbs.rbsLongName;
                                        }
                                        return str;
                                    }
                                },
                                {
                                    field: 'cbsName', title: 'CBS',width:200, templet: function (d) {
                                        var str = '';
                                        if (d.plbCbsTypeWithBLOBs) {
                                            str = d.plbCbsTypeWithBLOBs.cbsName;
                                        }
                                        return str;
                                    }
                                },
                                {
                                    field: 'controlType', title: '控制类型', width:100,templet: function (d) {
                                        return dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '';
                                    }
                                },
                                {
                                    field: 'itemUnit', title: '单位',width:100,templet: function (d) {
                                        var str = '';
                                        if (d.plbCbsTypeWithBLOBs) {
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
                                {field: 'manageTarAmount', title: '管理目标总价',width:120}
                            ]

                            table.render({
                                elem: '#costTable',
                                data: data&&data.projBudgetData||[],
								height: data&&data.projBudgetData&&data.projBudgetData .length>5?'full-350':false,
                                defaultToolbar: [''],
                                limit: 1000,
                                cols: [cols7],
								done:function(res){
									if(type==4){
										$('._disabled [name]').attr('disabled', 'disabled');
										$('._disabled [name]').attr('readonly', true);
										form.render();
									}
								}
                            });

							//优化计划
							var cols8 = [
								{type: 'numbers', title: '序号'},
								/*{field: 'optimizationName', title: '优化名称', minWidth: 150},
								{field: 'mainSchemeContent', title: '主要内容', minWidth: 160},
								{field: 'schemeDesc', title: '描述说明', minWidth: 160},
								{field: 'chargeUserName', title: '责任人', minWidth: 160},
								{field: 'superviseUserName', title: '监督人', minWidth: 160}*/
								{
									field: 'optimizationName', title: '优化名称', minWidth: 150, templet: function (d) {
										return '<input managePlanningId="' + (d.managePlanningId || '') + '" optimizationId="'+(d.optimizationId || '')+'" type="text" name="optimizationName" class="layui-input" style="height: 100%;" value="' + (d.optimizationName || '') + '">'
									}
								},
								// {
								// 	field: 'mainSchemeContent', title: '主要内容', minWidth: 160, templet: function (d) {
								// 		return '<input type="text" name="mainSchemeContent" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeContent || '') + '">'
								// 	}
								// },
								{
									field: 'schemeDesc', title: '优化描述', minWidth: 160, templet: function (d) {
										return '<input type="text" name="schemeDesc" class="layui-input tips" style="height: 100%;" value="' + (d.schemeDesc || '') + '">'
									}
								},
								{
									field: 'schemeCategory', title: '优化类别', minWidth: 160, templet: function (d) {
										var optionStr = '<option value="">请选择</option>';
										if(dictionaryObj.OPTIMIZATION_CATEGORY.object){
											for (index in dictionaryObj.OPTIMIZATION_CATEGORY.object){
												if(d.schemeCategory!=undefined&&index==d.schemeCategory){
													optionStr += '<option value="'+index+'" selected>'+dictionaryObj.OPTIMIZATION_CATEGORY.object[index]+'</option>';
												}else{
													optionStr += '<option value="'+index+'" >'+dictionaryObj.OPTIMIZATION_CATEGORY.object[index]+'</option>';
												}
											}
											return '<select name="schemeCategory" class="layui-input" style="height: 100%;"  value="' + (d.schemeCategory || '') + '">'+optionStr+'</select>'
										}else {
											return '';
										}
									}
								},
								{
									field: 'schemeType', title: '优化类型', minWidth: 160, templet: function (d) {
										var optionStr = '<option value="">请选择</option>';
										if(dictionaryObj.OPTIMIZATION_TYPE.object){
											for (index in dictionaryObj.OPTIMIZATION_TYPE.object){
												if(d.schemeType!=undefined&&index==d.schemeType){
													optionStr += '<option value="'+index+'" selected>'+dictionaryObj.OPTIMIZATION_TYPE.object[index]+'</option>';
												}else{
													optionStr += '<option value="'+index+'" >'+dictionaryObj.OPTIMIZATION_TYPE.object[index]+'</option>';
												}
											}
											return '<select name="schemeType" class="layui-input" style="height: 100%;"  value="' + (d.schemeType || '') + '">'+optionStr+'</select>'
										}else {
											return '';
										}
									}
								},

								{
									field: 'chargeUserName', title: '责任人', minWidth: 160, event: 'chooseCollectionUser',templet: function (d) {
										return '<input type="text" name="chargeUserName" id="charge_User_Name'+d.LAY_INDEX+'" user_id="'+(d.chargeUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.chargeUserName || '') + '">'
									}
								},
								{
									field: 'superviseUserName', title: '监督人', minWidth: 160, event: 'chooseCollectionUser2',templet: function (d) {
										return '<input type="text" name="superviseUserName" id="supervise_User_Name'+d.LAY_INDEX+'" user_id="'+(d.superviseUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.superviseUserName || '') + '">'
									}
								}
							]
							//经营计划
							var cols9 = [
								{type: 'numbers', title: '序号'},
								/*{field: 'businessName', title: '经营名称', minWidth: 150},
								{field: 'mainSchemeContent', title: '主要内容', minWidth: 160},
								{field: 'schemeDesc', title: '描述说明', minWidth: 160},
								{field: 'chargeUserName', title: '责任人', minWidth: 160},
								{field: 'superviseUserName', title: '监督人', minWidth: 160}*/
								{
									field: 'businessName', title: '经营名称', minWidth: 150, templet: function (d) {
										return '<input managePlanningId="' + (d.managePlanningId || '') + '" businessId="'+(d.businessId || '')+'" type="text" name="businessName" class="layui-input" style="height: 100%;" value="' + (d.businessName || '') + '">'
									}
								},
								{
									field: 'schemeDesc', title: '经营描述', minWidth: 160, templet: function (d) {
										return '<input type="text" name="schemeDesc" class="layui-input tips" style="height: 100%;" value="' + (d.schemeDesc || '') + '">'
									}
								},
								/*{
									field: 'mainSchemeContent', title: '主要内容', minWidth: 160, templet: function (d) {
										return '<input type="text" name="mainSchemeContent" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeContent || '') + '">'
									}
								},*/
								{
									field: 'schemeCategory', title: '经营类别', minWidth: 160, templet: function (d) {
										var optionStr = '<option value="">请选择</option>';
										if(dictionaryObj.BUSINESS_CATEGORY.object){
											for (index in dictionaryObj.BUSINESS_CATEGORY.object){
												if(d.schemeCategory!=undefined&&index==d.schemeCategory){
													optionStr += '<option value="'+index+'" selected>'+dictionaryObj.BUSINESS_CATEGORY.object[index]+'</option>';
												}else{
													optionStr += '<option value="'+index+'" >'+dictionaryObj.BUSINESS_CATEGORY.object[index]+'</option>';
												}
											}
											return '<select name="schemeCategory" class="layui-input" style="height: 100%;"  value="' + (d.schemeCategory || '') + '">'+optionStr+'</select>'
										}else {
											return '';
										}
									}
								},
								{
									field: 'schemeType', title: '经营类型', minWidth: 160, templet: function (d) {
										var optionStr = '<option value="">请选择</option>';
										if(dictionaryObj.BUSINESS_TYPE.object){
											for (index in dictionaryObj.BUSINESS_TYPE.object){
												if(d.schemeType!=undefined&&index==d.schemeType){
													optionStr += '<option value="'+index+'" selected>'+dictionaryObj.BUSINESS_TYPE.object[index]+'</option>';
												}else{
													optionStr += '<option value="'+index+'" >'+dictionaryObj.BUSINESS_TYPE.object[index]+'</option>';
												}
											}
											return '<select name="schemeType" class="layui-input" style="height: 100%;"  value="' + (d.schemeType || '') + '">'+optionStr+'</select>'
										}else {
											return '';
										}
									}
								},

								{
									field: 'chargeUserName', title: '责任人', minWidth: 160, event: 'chooseCollectionUser',templet: function (d) {
										return '<input type="text" name="chargeUserName" id="charge_User_Name2'+d.LAY_INDEX+'" user_id="'+(d.chargeUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.chargeUserName || '') + '">'
									}
								},
								{
									field: 'superviseUserName', title: '监督人', minWidth: 160, event: 'chooseCollectionUser2',templet: function (d) {
										return '<input type="text" name="superviseUserName" id="supervise_User_Name2'+d.LAY_INDEX+'" user_id="'+(d.superviseUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.superviseUserName || '') + '">'
									}
								}
							]

							if (type == 1 || type == 4) {
								table.render({
									elem: '#optimizationTable',
									toolbar: type==4?false:'#toolbarPlan',
									url: '/optimizationScheme/select',
									where: {
										projectId: projectId,
										delFlag: '0',
										managePlanningId:managePlanningId
									},
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols8],
									done:function(res){
										if(type==4){
											$('._disabled [name]').attr('disabled', 'disabled');
											$('._disabled [name]').attr('readonly', true);
											form.render();
										}
									}
								});

								table.render({
									elem: '#secondaryTable',
									toolbar: type==4?false:'#toolbarPlan',
									url: '/businessScheme/select',
									where: {
										projectId: projectId,
										delFlag: '0',
										managePlanningId:managePlanningId
									},
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols9],
									done:function(res){
										if(type==4){
											$('._disabled [name]').attr('disabled', 'disabled');
											$('._disabled [name]').attr('readonly', true);
											form.render();
										}
									}
								});
							}else {
								table.render({
									elem: '#optimizationTable',
									toolbar: type==4?false:'#toolbarPlan',
									data:[],
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols8],
									done:function(res){
										if(type==4){
											$('._disabled [name]').attr('disabled', 'disabled');
											$('._disabled [name]').attr('readonly', true);
											form.render();
										}
									}
								});

								table.render({
									elem: '#secondaryTable',
									toolbar: type==4?false:'#toolbarPlan',
									data:[],
									defaultToolbar: [''],
									limit: 1000,
									cols: [cols9],
									done:function(res){
										if(type==4){
											$('._disabled [name]').attr('disabled', 'disabled');
											$('._disabled [name]').attr('readonly', true);
											form.render();
										}
									}
								});
							}


							//技术路线
							var cols10 = [
								{type: 'numbers', title: '序号'},
								{
									field: 'businessName', title: '技术名称', minWidth: 150, templet: function (d) {
										return '<input managePlanningId="' + (d.managePlanningId || '') + '" planingTechnologyId="'+(d.planingTechnologyId || '')+'" type="text" name="businessName" class="layui-input" style="height: 100%;" value="' + (d.businessName || '') + '">'
									}
								},
								{
									field: 'mainSchemeContent', title: '主要内容', minWidth: 160, templet: function (d) {
										return '<input type="text" name="mainSchemeContent" class="layui-input tips" style="height: 100%;" value="' + (d.mainSchemeContent || '') + '">'
									}
								},
								{
									field: 'schemeDesc', title: '描述说明', minWidth: 160, templet: function (d) {
										return '<input type="text" name="schemeDesc" class="layui-input tips" style="height: 100%;" value="' + (d.schemeDesc || '') + '">'
									}
								},
								{
									field: 'chargeUserName', title: '责任人', minWidth: 160, event: 'chooseCollectionUser',templet: function (d) {
										return '<input type="text" name="chargeUserName" id="chargeUser_Name'+d.LAY_INDEX+'" user_id="'+(d.chargeUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.chargeUserName || '') + '">'
									}
								},
								{
									field: 'superviseUserName', title: '监督人', minWidth: 160, event: 'chooseCollectionUser2',templet: function (d) {
										return '<input type="text" name="superviseUserName" id="superviseUser_Name'+d.LAY_INDEX+'" user_id="'+(d.superviseUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.superviseUserName || '') + '">'
									}
								},
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
							]
							//实施策划内容
							var cols11 = [
								{type: 'numbers', title: '序号'},
								{
									field: 'technologyName', title: '策划名称', minWidth: 150, templet: function (d) {
										return '<input managePlanningId="' + (d.managePlanningId || '') + '" technologyPlanDetailId="'+(d.technologyPlanDetailId || '')+'"  type="text" name="technologyName" class="layui-input" style="height: 100%;" value="' + (d.technologyName || '') + '">'
									}
								},
								{
									field: 'technologyDesc', title: '策划描述', minWidth: 160, event: 'dateSelection',templet: function (d) {
										return '<input type="text" name="technologyDesc" class="layui-input tips" style="height: 100%;" value="' + (d.technologyDesc || '') + '">'
									}
								},
								{
									field: 'importanceLevel', title: '重要级别', minWidth: 160, templet: function (d) {
										var optionStr = '<option value="">请选择</option>';
										if(dictionaryObj.IMPORTANCE_LEVEL.object){
											for (index in dictionaryObj.IMPORTANCE_LEVEL.object){
												if(d.importanceLevel!=undefined&&index==d.importanceLevel){
													optionStr += '<option value="'+index+'" selected>'+dictionaryObj.IMPORTANCE_LEVEL.object[index]+'</option>';
												}else{
													optionStr += '<option value="'+index+'" >'+dictionaryObj.IMPORTANCE_LEVEL.object[index]+'</option>';
												}
											}
											return '<select name="importanceLevel" class="layui-input" style="height: 100%;"  value="' + (d.importanceLevel || '') + '">'+optionStr+'</select>'
										}else {
											return '';
										}
									}
								},
								{
									field: 'projectUserName', title: '项目责任人', minWidth: 160, event: 'chooseCollectionUser',templet: function (d) {
										return '<input type="text" name="projectUserName" readonly id="personLiable_Name'+d.LAY_INDEX+'" user_id="'+(d.projectUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.projectUserName || '') + '">'
									}
								},
								{
									field: 'companyUserName', title: '公司责任人', minWidth: 160, event: 'chooseCollectionUser2',templet: function (d) {
										return '<input type="text" name="companyUserName" readonly id="company_User_Name'+d.LAY_INDEX+'" user_id="'+(d.companyUser||'')+'" class="layui-input" style="height: 100%;" value="' + (d.companyUserName || '') + '">'
									}
								},
								{
									field: 'planEndDate', title: '计划完成时间',event: 'dateSelection', minWidth: 160, templet: function (d) {
										return '<input type="text" name="planEndDate" class="layui-input" style="height: 100%;" value="' + (d.planEndDate || '') + '">'
									}
								},
								{
									field: 'achieveRequire', title: '成果物要求', minWidth: 160, templet: function (d) {
										return '<input type="text" name="achieveRequire" class="layui-input tips" style="height: 100%;" value="' + (d.achieveRequire || '') + '">'
									}
								}
							]
							//查看详情
							if(type!=4){
								cols8.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
								cols9.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
								cols10.push({title: '上传附件', align: 'center', toolbar: '#internalBar', minWidth: 200})
								cols10.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
								cols11.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
							}
							table.render({
								elem: '#roadmapTable',
								data: data&&data.managePlanning&&data.managePlanning.planningTechnologyList||[],
								height: data&&data.managePlanning&&data.managePlanning.planningTechnologyList&&data.managePlanning.planningTechnologyList .length>5?'full-350':false,
								toolbar: type==4?false:'#toolbarPlan',
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols10],
								done:function(res){
									if(type==4){
										$('.deImgs').hide()
										$('._disabled [name]').attr('disabled', 'disabled');
										$('._disabled [name]').attr('readonly', true);
										form.render();
									}
								}
							});

							table.render({
								elem: '#implementationTable',
								data: data&&data.managePlanning&&data.managePlanning.technologyPlanList||[],
								height: data&&data.managePlanning&&data.managePlanning.technologyPlanList&&data.managePlanning.technologyPlanList .length>5?'full-350':false,
								toolbar: type==4?false:'#toolbarPlan',
								defaultToolbar: [''],
								limit: 1000,
								cols: [cols11],
								done:function(res){
									if(type==4){
										$('._disabled [name]').attr('disabled', 'disabled');
										$('._disabled [name]').attr('readonly', true);
										form.render();
									}
								}
							});

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

						obj.managePlanningDesc = $('#managePlanningDesc').val()

						obj.projectId = $('#leftId').attr('projId');


						if(type == '1'){
							obj.managePlanningId= data.managePlanning.managePlanningId;
						}

						// 附件
						var attachmentId = '';
						var attachmentName = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
						}
						obj.attachId = attachmentId;
						obj.attachName = attachmentName;

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

						obj.scheduleData = planningDetailsData().scheduleData;
						obj.qualityWithBLOBsList = planningDetailsData().qualityData;
						obj.securityWithBLOBsList = planningDetailsData().securityData;
						obj.planningTechnologyList = planningDetailsData(1).roadmapData;
						obj.technologyPlanList = planningDetailsData().implementationData;

						obj.optSchemeList = planningDetailsData().optimizationData;
						obj.businessSchemeList = planningDetailsData().secondaryData;

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

					obj.managePlanningDesc = $('#managePlanningDesc').val()

					obj.projectId = $('#leftId').attr('projId');


					if(type == '1'){
						obj.managePlanningId= data.managePlanning.managePlanningId;
					}

					// 附件
					var attachmentId = '';
					var attachmentName = '';
					for (var i = 0; i < $('#fileContent .dech').length; i++) {
						attachmentId += $('#fileContent .dech').eq(i).find('input').val();
						attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
					}
					obj.attachId = attachmentId;
					obj.attachName = attachmentName;

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

					obj.scheduleData = planningDetailsData().scheduleData;
					obj.qualityWithBLOBsList = planningDetailsData().qualityData;
					obj.securityWithBLOBsList = planningDetailsData().securityData;
					obj.planningTechnologyList = planningDetailsData(1).roadmapData;
					obj.technologyPlanList = planningDetailsData().implementationData;

					obj.optSchemeList = planningDetailsData().optimizationData;
					obj.businessSchemeList = planningDetailsData().secondaryData;

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
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '56'}, function (res) {
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
											var approvalData = res.object;
											delete approvalData.securityWithBLOBsList
											delete approvalData.qualityWithBLOBsList
											approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
											approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
											newWorkFlow(flowData.flowId, function (res) {
												var submitData = {
													managePlanningId:approvalData.managePlanningId,
													runId: res.flowRun.runId,
													//manageProjStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/managePlanning/updateById',
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

		// 进度策划-加行
		table.on('toolbar(scheduleTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().scheduleData;
					dataArr.push({});
					table.reload('scheduleTable', {
						url:'',
						data: dataArr,
                        height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 进度策划-删行
		table.on('tool(scheduleTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.scheduleId) {
					$.get('/managePlanning/delSchedule', {ids: data.scheduleId}, function (res) {
						if (res.code=='0') {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('scheduleTable', {
								url:'',
								data: planningDetailsData().scheduleData,
                                height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false,
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('scheduleTable', {
						url:'',
						data: planningDetailsData().scheduleData,
                        height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
					});
				}
			}else if (layEvent == 'dateSelection') {
				var $tr2 = $('.schedule_planning').find($tr.selector).find('input[name="scheduleEndDate"]');
				$tr2.each(function (index,element) {
					laydate.render({
						elem: element
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
					});
				})
			}else if (layEvent == 'chooseCollectionUser') {
				if(!$tr.find('[name="scheduleUserName"]').attr('disabled')){
					user_id = $tr.find('[name="scheduleUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'chooseCollectionUser2') {
				if(!$tr.find('[name="supervisorUserName"]').attr('disabled')){
					user_id = $tr.find('[name="supervisorUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}
		})

		// 质量策划-加行
		table.on('toolbar(qualityTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().qualityData;
					dataArr.push({});
					table.reload('qualityTable', {
						url:'',
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 质量策划-删行
		table.on('tool(qualityTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.planingQualityId) {
					$.get('/managePlanning/delQuality', {ids: data.planingQualityId}, function (res) {
						if (res.code=='0') {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('qualityTable', {
								url:'',
								data: planningDetailsData().qualityData,
								height: planningDetailsData().qualityData&&planningDetailsData().qualityData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('qualityTable', {
						url:'',
						data: planningDetailsData().qualityData,
						height: planningDetailsData().qualityData&&planningDetailsData().qualityData.length>5?'full-350':false
					});
				}
			}else if (layEvent == 'chooseCollectionUser') {
				if(!$tr.find('[name="projectUserName"]').attr('disabled')){
					user_id = $tr.find('[name="projectUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'chooseCollectionUser2') {
				if(!$tr.find('[name="companyUserName"]').attr('disabled')){
					user_id = $tr.find('[name="companyUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}
		})

		// 安全策划-加行
		table.on('toolbar(securityTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().securityData;
					dataArr.push({});
					table.reload('securityTable', {
						url:'',
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 安全策划-删行
		table.on('tool(securityTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.planingSecurityId) {
					$.get('/managePlanning/delSecurity', {ids: data.planingSecurityId}, function (res) {
						if (res.code=='0') {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('securityTable', {
								url:'',
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
						url:'',
						data: planningDetailsData().securityData,
						height: planningDetailsData().securityData&&planningDetailsData().securityData.length>5?'full-350':false
					});
				}
			}else if (layEvent == 'chooseCollectionUser') {
				if(!$tr.find('[name="projectUserName"]').attr('disabled')){
					user_id = $tr.find('[name="projectUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'chooseCollectionUser2') {
				if(!$tr.find('[name="companyUserName"]').attr('disabled')){
					user_id = $tr.find('[name="companyUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}
		})

		// 技术路线-加行
		table.on('toolbar(roadmapTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData(2).roadmapData;
					dataArr.push({});
					table.reload('roadmapTable', {
						url:'',
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 技术路线-删行
		table.on('tool(roadmapTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.planingTechnologyId) {
					$.get('/managePlanning/delPlanningTechnology', {ids: data.planingTechnologyId}, function (res) {
						if (res.code=='0') {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('roadmapTable', {
								url:'',
								data: planningDetailsData(2).roadmapData,
								height: planningDetailsData(2).roadmapData&&planningDetailsData(2).roadmapData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('roadmapTable', {
						url:'',
						data: planningDetailsData(2).roadmapData,
						height: planningDetailsData(2).roadmapData&&planningDetailsData(2).roadmapData.length>5?'full-350':false
					});
				}
			}else if (layEvent == 'chooseCollectionUser') {
				if(!$tr.find('[name="chargeUserName"]').attr('disabled')){
					user_id = $tr.find('[name="chargeUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'chooseCollectionUser2') {
				if(!$tr.find('[name="superviseUserName"]').attr('disabled')){
					user_id = $tr.find('[name="superviseUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'butfile') {
				var $tr1 = $tr.selector
				fileuploadFn( $tr1+' [id^=fileupload]', $( $tr1+' [id^=fileAll]'));
			}
		})

		// 实施策划明细-加行
		table.on('toolbar(implementationTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().implementationData;
					dataArr.push({});
					table.reload('implementationTable', {
						url:'',
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 实施策划明细-删行
		table.on('tool(implementationTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.businessReportIdDetailId) {
					$.get('/businessReport/delDetails', {ids: data.businessReportIdDetailId}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('implementationTable', {
								url:'',
								data: planningDetailsData().implementationData,
								height: planningDetailsData().implementationData&&planningDetailsData().implementationData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('implementationTable', {
						url:'',
						data: planningDetailsData().implementationData,
						height: planningDetailsData().implementationData&&planningDetailsData().implementationData.length>5?'full-350':false
					});
				}
			}else if (layEvent == 'dateSelection') {
				var $tr = $('.implementation_planning').find($tr.selector).find('input[name="planEndDate"]');
				$tr.each(function (index,element) {
					laydate.render({
						elem: element
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						// ,value: new Date()
					});
				})
			}else if (layEvent == 'chooseCollectionUser') {
				if(!$tr.find('[name="projectUserName"]').attr('disabled')){
					user_id = $tr.find('[name="projectUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'chooseCollectionUser2') {
				if(!$tr.find('[name="companyUserName"]').attr('disabled')){
					user_id = $tr.find('[name="companyUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}
		})

		// 优化计划-加行
		table.on('toolbar(optimizationTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().optimizationData;
					dataArr.push({});
					table.reload('optimizationTable', {
						url:'',
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 优化计划-删行
		table.on('tool(optimizationTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.optimizationId) {
					$.get('/optimizationScheme/del', {ids: data.optimizationId}, function (res) {
						if (res.code=='0') {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('optimizationTable', {
								url:'',
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
						url:'',
						data: planningDetailsData().optimizationData,
						height: planningDetailsData().optimizationData&&planningDetailsData().optimizationData.length>5?'full-350':false
					});
				}
			}else if (layEvent == 'chooseCollectionUser') {
				if(!$tr.find('[name="chargeUserName"]').attr('disabled')){
					user_id = $tr.find('[name="chargeUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'chooseCollectionUser2') {
				if(!$tr.find('[name="superviseUserName"]').attr('disabled')){
					user_id = $tr.find('[name="superviseUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}
		})

		// 经营计划-加行
		table.on('toolbar(secondaryTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().secondaryData;
					dataArr.push({});
					table.reload('secondaryTable', {
						url:'',
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 经营计划-删行
		table.on('tool(secondaryTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.businessId) {
					$.get('/businessScheme/del', {ids: data.businessId}, function (res) {
						if (res.code=='0') {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('secondaryTable', {
								url:'',
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
						url:'',
						data: planningDetailsData().secondaryData,
						height: planningDetailsData().secondaryData&&planningDetailsData().secondaryData.length>5?'full-350':false
					});
				}
			}else if (layEvent == 'chooseCollectionUser') {
				if(!$tr.find('[name="chargeUserName"]').attr('disabled')){
					user_id = $tr.find('[name="chargeUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}else if (layEvent == 'chooseCollectionUser2') {
				if(!$tr.find('[name="superviseUserName"]').attr('disabled')){
					user_id = $tr.find('[name="superviseUserName"]').attr('id');
					$.popWindow('/common/selectUser?0');
				}
			}
		})

		/**
		 * 获取策划明细子表数据
		 *
		 * type 技术路线 用到
		 *
		 */
		function planningDetailsData(type) {
			//进度策划
			//遍历表格获取每行数据
			var $trs = $('.schedule_planning').find('.layui-table-main tr');
			var dataArr = [];
			$trs.each(function () {
				var schDom=$(this).find('input[name="scheduleUserName"]');
				var scheduleUser = $(schDom).attr('user_id')||''
				if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
					scheduleUser=scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
				}
				var supDom=$(this).find('input[name="supervisorUserName"]');
				var supervisor = $(supDom).attr('user_id')||''
				if(supervisor&&supervisor.indexOf(',')!=-1){
					supervisor=supervisor.substring(0,supervisor.lastIndexOf(','))
				}
				var dataObj = {
					managePlanningId: $(this).find('input[name="scheduleName"]').attr('managePlanningId') || '',
					scheduleId: $(this).find('input[name="scheduleName"]').attr('scheduleId') || '',
					scheduleName: $(this).find('input[name="scheduleName"]').val(),
					scheduleEndDate: $(this).find('input[name="scheduleEndDate"]').val(),
					scheduleUserName: $(this).find('input[name="scheduleUserName"]').val(),
					scheduleUser: scheduleUser,
					supervisorUserName: $(this).find('input[name="supervisorUserName"]').val(),
					supervisorUser: supervisor,
					memo: $(this).find('input[name="memo"]').val()
				}
				dataArr.push(dataObj);
			});

			//质量策划
			var $trs2 = $('.quality_planning').find('.layui-table-main tr');
			var dataArr2 = [];
			$trs2.each(function () {
				var schDom=$(this).find('input[name="projectUserName"]');
				var scheduleUser = $(schDom).attr('user_id')||''
				if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
					scheduleUser=scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
				}
				var supDom=$(this).find('input[name="companyUserName"]');
				var supervisor = $(supDom).attr('user_id')||''
				if(supervisor&&supervisor.indexOf(',')!=-1){
					supervisor=supervisor.substring(0,supervisor.lastIndexOf(','))
				}
				var dataObj = {
					managePlanningId: $(this).find('input[name="mainRisks"]').attr('managePlanningId') || '',
					planingQualityId: $(this).find('input[name="mainRisks"]').attr('planingQualityId') || '',
					mainRisks: $(this).find('input[name="mainRisks"]').val(),
					contentDesc: $(this).find('input[name="contentDesc"]').val(),
					solutions: $(this).find('input[name="solutions"]').val(),
					projectUserName: $(this).find('input[name="projectUserName"]').val(),
					projectUser: scheduleUser,
					companyUserName: $(this).find('input[name="companyUserName"]').val(),
					companyUser: supervisor,
				}
				dataArr2.push(dataObj);
			});

			//安全策划
			var $trs3 = $('.security_planning').find('.layui-table-main tr');
			var dataArr3 = [];
			$trs3.each(function () {
				var schDom=$(this).find('input[name="projectUserName"]');
				var scheduleUser = $(schDom).attr('user_id')||''
				if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
					scheduleUser=scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
				}
				var supDom=$(this).find('input[name="companyUserName"]');
				var supervisor = $(supDom).attr('user_id')||''
				if(supervisor&&supervisor.indexOf(',')!=-1){
					supervisor=supervisor.substring(0,supervisor.lastIndexOf(','))
				}
				var dataObj = {
					managePlanningId: $(this).find('input[name="mainRisks"]').attr('managePlanningId') || '',
					planingSecurityId: $(this).find('input[name="mainRisks"]').attr('planingSecurityId') || '',
					mainRisks: $(this).find('input[name="mainRisks"]').val(),
					contentDesc: $(this).find('input[name="contentDesc"]').val(),
					solutions: $(this).find('input[name="solutions"]').val(),
					projectUserName: $(this).find('input[name="projectUserName"]').val(),
					projectUser: scheduleUser,
					companyUserName: $(this).find('input[name="companyUserName"]').val(),
					companyUser: supervisor,
				}
				dataArr3.push(dataObj);
			});

			//技术路线
			var $trs4 = $('.technology_roadmap').find('.layui-table-main tr');
			var dataArr4 = [];
			$trs4.each(function (index) {
				var attachId = '';
				var attachName = '';
				var attachList = [];

				if(type=='1'){//提交保存
					for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
						attachId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
						attachName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
					}
				}else if(type=='2'){//加行、删行
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

				var chargeUserDom=$(this).find('input[name="chargeUserName"]');
				var chargeUser = $(chargeUserDom).attr('user_id')
				if(chargeUser&&chargeUser.indexOf(',')!=-1){
					chargeUser=chargeUser.substring(0,chargeUser.lastIndexOf(','))
				}
				var superviseUserDom=$(this).find('input[name="superviseUserName"]');
				var superviseUser = $(superviseUserDom).attr('user_id')
				if(superviseUser&&superviseUser.indexOf(',')!=-1){
					superviseUser=superviseUser.substring(0,superviseUser.lastIndexOf(','))
				}
				var dataObj = {
					managePlanningId: $(this).find('[name="businessName"]').attr('managePlanningId') || '',
					planingTechnologyId: $(this).find('[name="businessName"]').attr('planingTechnologyId') || '',
					businessName: $(this).find('[name="businessName"]').val(),
					mainSchemeContent: $(this).find('[name="mainSchemeContent"]').val(),
					schemeDesc: $(this).find('[name="schemeDesc"]').val(),
					chargeUser:chargeUser||'' ,
					chargeUserName: $(this).find('input[name="chargeUserName"]').val(),
					superviseUser: superviseUser||'',
					superviseUserName: $(this).find('input[name="superviseUserName"]').val(),
					attachmentId:attachId,
					attachmentName:attachName
				}
				if(type=='2'){
					dataObj.attachmentList = attachList;
				}
				dataArr4.push(dataObj);
			});

			//实施策划
			var $trs5 = $('.implementation_planning').find('.layui-table-main tr');
			var dataArr5 = [];
			$trs5.each(function () {

				var projectUserDom=$(this).find('input[name="projectUserName"]');
				var projectUser = $(projectUserDom).attr('user_id')
				if(projectUser&&projectUser.indexOf(',')!=-1){
					projectUser=projectUser.substring(0,projectUser.lastIndexOf(','))
				}
				var companyUserDom=$(this).find('input[name="companyUserName"]');
				var companyUser = $(companyUserDom).attr('user_id')
				if(companyUser&&companyUser.indexOf(',')!=-1){
					companyUser=companyUser.substring(0,companyUser.lastIndexOf(','))
				}
				
				var dataObj = {
					managePlanningId: $(this).find('input[name="technologyName"]').attr('managePlanningId') || '',
					technologyPlanDetailId: $(this).find('input[name="technologyName"]').attr('technologyPlanDetailId') || '',
					technologyName: $(this).find('input[name="technologyName"]').val(),
					technologyDesc: $(this).find('input[name="technologyDesc"]').val(),
					importanceLevel: $(this).find('[name="importanceLevel"]').val(),
					projectUser:projectUser||'' ,
					projectUserName: $(this).find('input[name="projectUserName"]').val(),
					companyUser: companyUser||'',
					companyUserName: $(this).find('input[name="companyUserName"]').val(),
					planEndDate: $(this).find('input[name="planEndDate"]').val(),
					achieveRequire: $(this).find('input[name="achieveRequire"]').val()
				}
				dataArr5.push(dataObj);
			});

			//优化计划
			var $trs6 = $('.optimization_scheme').find('.layui-table-main tr');
			var dataArr6 = [];
			$trs6.each(function (index) {
				var chargeUserDom=$(this).find('input[name="chargeUserName"]');
				var chargeUser = $(chargeUserDom).attr('user_id')
				if(chargeUser&&chargeUser.indexOf(',')!=-1){
					chargeUser=chargeUser.substring(0,chargeUser.lastIndexOf(','))
				}
				var superviseUserDom=$(this).find('input[name="superviseUserName"]');
				var superviseUser = $(superviseUserDom).attr('user_id')
				if(superviseUser&&superviseUser.indexOf(',')!=-1){
					superviseUser=superviseUser.substring(0,superviseUser.lastIndexOf(','))
				}
				var dataObj = {
					managePlanningId: $(this).find('[name="optimizationName"]').attr('managePlanningId') || '',
					optimizationId: $(this).find('[name="optimizationName"]').attr('optimizationId') || '',
					optimizationName: $(this).find('[name="optimizationName"]').val(),
					mainSchemeContent: $(this).find('[name="mainSchemeContent"]').val(),
					schemeDesc: $(this).find('[name="schemeDesc"]').val(),
					chargeUser:chargeUser||'' ,
					chargeUserName: $(this).find('input[name="chargeUserName"]').val(),
					superviseUser: superviseUser||'',
					superviseUserName: $(this).find('input[name="superviseUserName"]').val(),

					schemeCategory: $(this).find('[name="schemeCategory"]').val(),
					schemeType: $(this).find('[name="schemeType"]').val(),
				}
				dataArr6.push(dataObj);
			});

			//经营计划
			var $trs7 = $('.secondary_operation').find('.layui-table-main tr');
			var dataArr7 = [];
			$trs7.each(function (index) {
				var chargeUserDom=$(this).find('input[name="chargeUserName"]');
				var chargeUser = $(chargeUserDom).attr('user_id')
				if(chargeUser&&chargeUser.indexOf(',')!=-1){
					chargeUser=chargeUser.substring(0,chargeUser.lastIndexOf(','))
				}
				var superviseUserDom=$(this).find('input[name="superviseUserName"]');
				var superviseUser = $(superviseUserDom).attr('user_id')
				if(superviseUser&&superviseUser.indexOf(',')!=-1){
					superviseUser=superviseUser.substring(0,superviseUser.lastIndexOf(','))
				}
				var dataObj = {
					managePlanningId: $(this).find('[name="businessName"]').attr('managePlanningId') || '',
					businessId: $(this).find('[name="businessName"]').attr('businessId') || '',
					businessName: $(this).find('[name="businessName"]').val(),
					mainSchemeContent: $(this).find('[name="mainSchemeContent"]').val(),
					schemeDesc: $(this).find('[name="schemeDesc"]').val(),
					chargeUser:chargeUser||'' ,
					chargeUserName: $(this).find('input[name="chargeUserName"]').val(),
					superviseUser: superviseUser||'',
					superviseUserName: $(this).find('input[name="superviseUserName"]').val(),

					schemeCategory: $(this).find('[name="schemeCategory"]').val(),
					schemeType: $(this).find('[name="schemeType"]').val(),
				}
				dataArr7.push(dataObj);
			});


			return {
				scheduleData: dataArr,
				qualityData: dataArr2,
				securityData: dataArr3,
				roadmapData: dataArr4,
				implementationData: dataArr5,
				optimizationData: dataArr6,
				secondaryData: dataArr7
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
		$.ajaxSettings.async = false;
		var loadIndex = layer.load();
		$.get('/managePlanning/getProjInfo', params, function (res) {
			layer.close(loadIndex);
			callback(res);

		});
		$.ajaxSettings.async = true;
	}


	function openRold(){ //流程转交下一步后会调用此方法
		//刷新表格
		tableIns.config.where._ = new Date().getTime();
		tableIns.reload();
	}
</script>
</body>
</html>
