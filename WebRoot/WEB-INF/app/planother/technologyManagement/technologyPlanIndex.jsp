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
	<title>技术方案编制计划</title>

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
		.layui-col-xs4{
			width: 20%;
		}

		.project_detailed_information, .project_detailed_information .layui-table-cell,.project_detailed_information .layui-table-box,.project_detailed_information .layui-table-body {
			overflow: visible;
		}
		/* 设置下拉框的高度与表格单元格的高度相同 */
		.project_detailed_information td .layui-form-select {
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
			<h2 style="text-align: center;line-height: 35px;">技术方案编制计划</h2>
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
				<%--<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="technicalName" placeholder="优化分析名称" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<select name="auditerStatus">
						<option value="">请选择审批状态</option>
						<option value="0">未提交</option>
						<option value="1">审批中</option>
						<option value="2">批准</option>
						<option value="3">不批准</option>
					</select>
				</div>--%>
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
		<button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
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
					return '<span technologyPlanId="'+d.technologyPlanId+'">'+(d.documentNo||'')+'</span>'
				}},
			projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
			technologyName:{field: 'technologyName', title: '方案名称', minWidth: 150},
			technologyDesc:{field:'technologyDesc',title:'方案描述',minWidth: 120,sort:true,hide:false},
			importanceLevel:{field:'importanceLevel',title:'重要级别',minWidth: 120,sort:true,hide:false,templet: function (d) {
					if(d.importanceLevel) {
						return '<span>'+((dictionaryObj&&dictionaryObj['IMPORTANCE_LEVEL']&&dictionaryObj['IMPORTANCE_LEVEL']['object'][d.importanceLevel])||'')+'</span>'
					}else {
						return ''
					}
				}},
			projectUserName:{field:'projectUserName',title:'项目责任人',minWidth: 120,sort:true,hide:false},
			companyUserName:{field:'companyUserName',title:'公司责任人',minWidth: 120,sort:true,hide:false},
			planEndDate:{field:'planEndDate',title:'计划完成时间',minWidth: 120,sort:true,hide:false},
			achieveRequire:{field:'achieveRequire',title:'成果物要求',minWidth: 120,sort:true,hide:false},
			workPlanningName:{field:'workPlanningName',title:'所属策划',minWidth: 120,sort:true,hide:false},
			// createYear: {field: 'createYear', title: '填报年', minWidth: 120,sort: true, hide: false},
			// createMonth: {field: 'createMonth', title: '填报月', minWidth: 120,sort: true, hide: false},
			// createUserName: {field: 'createUserName', title: '填报人', minWidth: 120,sort: true, hide: false},
			// createTime: {field: 'createTime', title: '填报时间', minWidth: 120,sort: true, hide: false},
			/*currFlowUserName: {field: 'currFlowUserName', title: '当前处理人',minWidth: 130, sort: false, hide: false},
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
			}*/
		}

		// 获取数据字典数据
		var dictionaryObj = {
			IMPORTANCE_LEVEL:{}
		}
		var dictionaryStr = 'IMPORTANCE_LEVEL';
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

		var TableUIObj = new TableUI('plb_other_technology_scheme23');


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
					// if (checkStatus.data[0].auditerStatus!=0) {
					// 	layer.msg('已提交不可编辑！', {icon: 0});
					// 	return false
					// }
					if($('#leftId').attr('projId')){
						var technologyPlanId = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span').attr('technologyPlanId')
						var loadIndex = layer.load();
						$.get('/technologySchemePlan/getById', {kayId:technologyPlanId}, function (res) {
							layer.close(loadIndex);
							newOrEdit(1,res.obj)
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
					// var isFlay  = false
					// checkStatus.data.forEach(function (v, i) {
					// 	if(v.auditerStatus&&v.auditerStatus!='0'){
					// 		isFlay = true
					// 	}
					// })
					// if(isFlay){
					// 	layer.msg('已提交不可删除！', {icon: 0});
					// 	return false
					// }
					var technologyPlanId = ''
					var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span')
					$trs.each(function(){
						technologyPlanId += $(this).attr('technologyPlanId') + ','
					})
					// checkStatus.data.forEach(function (v, i) {
					// 	technologyPlanId += v.technologyPlanId + ','
					// })
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/technologySchemePlan/del', {ids: technologyPlanId}, function (res) {
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
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '41'}, function (res) {
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
										technologyPlanId:approvalData.technologyPlanId,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/technologySchemePlan/updateById',
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
			var technologyPlanId = $(obj.tr.selector).find('[data-field="documentNo"] span').attr('technologyPlanId')
			if(layEvent === 'detail'){
				var loadIndex = layer.load();
				$.get('/technologySchemePlan/getById', {kayId:technologyPlanId}, function (res) {
					layer.close(loadIndex);
					newOrEdit(4,res.obj)
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
				url: '/technologySchemePlan/select',
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
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			var projectId = $('#leftId').attr('projId');

			if (type == '0') {
				title = '新建';
				url = '/technologySchemePlan/insert';
			} else if (type == '1') {
				title = '编辑';
				url = '/technologySchemePlan/updateById';
			}else if(type == '4'){
				title = '查看详情'
			}

			layer.open({
				type: 1,
				title: title,
				area: ['100%', '100%'],
				btn: type != '4'?['保存','提交审批', '取消']:['确定'],
				btnAlign: 'c',
				content: ['<div class="layui-collapse _disabled">\n' +
					/* region 方案内容 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">基本内容</h2>\n' +
					'    <div class="layui-colla-content layui-show plan_base_info">' +
					'       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
					/* region 第一行 */
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">单据号<span field="documentNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="documentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">方案名称<span field="technologyName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="technologyName" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">方案描述<!--<span field="technologyDesc" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="technologyDesc" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">重要级别<span field="importanceLevel" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">' +
					' 							<select name="importanceLevel"></select>\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>' ,
					'			<div class="layui-row">' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">项目责任人<span field="projectUserName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="projectUserName" id="projectUserName" readonly autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">公司责任人<span field="companyUserName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">' +
					'                           <input type="text" name="companyUserName" id="companyUserName" readonly autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">计划完成时间<span field="planEndDate" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="planEndDate" readonly autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">成果物要求<!--<span field="achieveRequire" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">' +
					'                           <input type="text" name="achieveRequire" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">所属策划<!--<span field="achieveRequire" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">' +
					'                           <input type="text" name="workPlanningName" placeholder="请选择" autocomplete="off" onclick="workPlan_choice(this)" readonly autocomplete="off" class="layui-input workPlanningName" style="background: #e7e7e7;cursor: pointer">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					/*'  			    <div class="layui-col-xs12" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">备注<span field="memo" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'               <textarea style="width:100%;height 38px;resize: vertical;"  name="memo" autocomplete="off" class="layui-input"></textarea>' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +*/
					'			</div>',
					/* endregion */
					'       </form>' +
					'    </div>\n' +
					'  </div>\n' +
					/* endregion */
					// '  <div class="layui-colla-item">\n' +
					// '    <h2 class="layui-colla-title">技术方案编制计划明细</h2>\n' +
					// '    <div class="layui-colla-content layui-show project_detailed_information">' +
					// '		<table id="detailedTable" lay-filter="detailedTable"></table>' +
					// '    </div>\n' +
					// '  </div>\n' +
					/* endregion */
					'</div>'].join(''),
				success: function () {

					//重要级别
					var $select = '<option value="">请选择重要级别</option>'
					$select += dictionaryObj&&dictionaryObj['IMPORTANCE_LEVEL']&&dictionaryObj['IMPORTANCE_LEVEL']['str']
					$('[name="importanceLevel"]').append($select)

					// 选择项目责任人
					$('#projectUserName').on('click', function(){
						user_id = 'projectUserName';
						$.popWindow('/common/selectUser?0');
					});
					// 选择公司责任人
					$('#companyUserName').on('click', function(){
						user_id = 'companyUserName';
						$.popWindow('/common/selectUser?0');
					});
					//计划完成时间
					laydate.render({
						elem: '[name="planEndDate"]'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						// ,value: new Date()
					});
					//回显项目名称
					getProjName('#projectName',projectId)

					//回显数据
					if (type == 1 || type == 4) {
						form.val("formTest", data);
						// $('input[name="documentNo"]', $('#baseForm')).val(data.documentNo);
						$('#projectUserName').attr('user_id',data.companyUser)
						$('#companyUserName').attr('user_id',data.companyUser)
						$('.workPlanningName').attr('workPlanningId',data.workPlanningId)
					}else{
						// 获取自动编号
						getAutoNumber({autoNumberType: 'technologySchemePlan'}, function(res) {
							$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
							$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
							$('input[name="createTime"]', $('#baseForm')).val(res.object.createTime)
						});
						$('.refresh_no_btn').show().on('click', function() {
							getAutoNumber({autoNumberType: 'technologySchemePlan'}, function(res) {
								$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
								$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
								$('input[name="createTime"]', $('#baseForm')).val(res.object.createTime)
							});
						});
					}



					//查看详情
					if(type==4){
						$('._disabled [name]').attr('disabled', 'disabled');
						$('.refresh_no_btn').hide();

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

						var projectUser = $('#projectUserName').attr('user_id')
						if(projectUser&&projectUser.indexOf(',')!=-1){
							projectUser=projectUser.substring(0,projectUser.lastIndexOf(','))
							obj.projectUser = projectUser
						}
						var companyUser = $('#companyUserName').attr('user_id')
						if(companyUser&&companyUser.indexOf(',')!=-1){
							companyUser=companyUser.substring(0,companyUser.lastIndexOf(','))
							obj.companyUser = companyUser
						}

						obj.workPlanningId = $('.workPlanningName').attr('workPlanningId')

						obj.projectId = $('#leftId').attr('projId');


						if(type == '1'){
							obj.technologyPlanId= data.technologyPlanId;
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
							data:obj,
							// data: JSON.stringify(obj),
							dataType: 'json',
							// contentType: "application/json;charset=UTF-8",
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

					var projectUser = $('#projectUserName').attr('user_id')
					if(projectUser&&projectUser.indexOf(',')!=-1){
						projectUser=projectUser.substring(0,projectUser.lastIndexOf(','))
						obj.projectUser = projectUser
					}
					var companyUser = $('#companyUserName').attr('user_id')
					if(companyUser&&companyUser.indexOf(',')!=-1){
						companyUser=companyUser.substring(0,companyUser.lastIndexOf(','))
						obj.companyUser = companyUser
					}

					obj.workPlanningId = $('.workPlanningName').attr('workPlanningId')


					obj.projectId = $('#leftId').attr('projId');


					if(type == '1'){
						obj.technologyPlanId= data.technologyPlanId;
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
						data:obj,
						// data: JSON.stringify(obj),
						dataType: 'json',
						// contentType: "application/json;charset=UTF-8",
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
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '41'}, function (res) {
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
													technologyPlanId:approvalData.technologyPlanId,
													runId: res.flowRun.runId,
													//manageProjStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/technologySchemePlan/updateById',
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

	function workPlan_choice(_this){
		var projectId = $('#leftId').attr('projId');
		layui.layer.open({
			type: 1,
			title: '选择实施策划',
			area: ['90%', '90%'],
			btn: ['确定','取消'],
			btnAlign: 'c',
			content: '<div style="margin:20px"><table id="detailed_Table" lay-filter="detailed_Table"></table></div>',
			success: function () {

				//检查计划明细
				var cols = [
					{type: 'radio'},
					{field: 'documentNo', title: '单据号', minWidth: 90},
					{field:'projectName',title:'项目名称',minWidth: 120},
					{field: 'workPlanningName', title: '策划名称', minWidth: 120},
					{field: 'createUserName', title: '编制人',minWidth: 120},
					{field: 'createTime', title: '编制时间',minWidth: 120},
					{field: 'memo', title: '备注',minWidth: 120}
				]

				layui.table.render({
					elem: '#detailed_Table',
					url: '/workPlanning/select',
					defaultToolbar: [''],
					where: {
						// projId: projId,
						projectId: projectId,
						delFlag: '0'
					},
					limit: 1000,
					cols: [cols],
					done:function(res){

					}
				});

				layui.form.render();
			},
			yes: function (index) {
				var data = layui.table.checkStatus('detailed_Table').data;
				if(data.length==0){
					layer.msg('请选择一项！', {icon: 0});
					return false
				}
				$(_this).val(data[0].workPlanningName).attr('workPlanningId',data[0].workPlanningId)
				layer.close(index);
			}
		});
	}

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
