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
	<title>优化分析</title>

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

		.optimized_implementation td[data-field="attachmentName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}


	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">优化分析填报</h2>
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

<script type="text/html" id="internalBar">
	<a href="javascript:;" class="openFile addRow" style="position:relative;" lay-event="butfile">
		<button type="button"  class="layui-btn layui-btn-xs" style="margin-right:10px;">
			<i class="layui-icon" >&#xe67c;</i>附件上传
		</button>
		<input type="file" multiple id={{"fileupload"+d.LAY_INDEX}} data-url="/upload?module=reportOptimiza"  name="file">
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
					return '<span reportOptId="'+d.reportOptId+'">'+(d.documentNo||'')+'</span>'
				}},
			projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
			createYear: {field: 'createYear', title: '填报年', minWidth: 120,sort: true, hide: false},
			createMonth: {field: 'createMonth', title: '填报月', minWidth: 120,sort: true, hide: false},
			createUserName: {field: 'createUserName', title: '填报人', minWidth: 120,sort: true, hide: false},
			createDate: {field: 'createDate', title: '填报时间', minWidth: 120,sort: true, hide: false},
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

		var TableUIObj = new TableUI('plb_other_technology_scheme2');


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
						var reportOptId = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span').attr('reportOptId')
						var loadIndex = layer.load();
						$.get('/optimizationReport/getById', {kayId:reportOptId}, function (res) {
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
					var reportOptId = ''
					var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documentNo"] span')
					$trs.each(function(){
						reportOptId += $(this).attr('reportOptId') + ','
					})
					// checkStatus.data.forEach(function (v, i) {
					// 	reportOptId += v.reportOptId + ','
					// })
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/optimizationReport/del', {ids: reportOptId}, function (res) {
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
										reportOptId:approvalData.reportOptId,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/optimizationReport/updateById',
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
			var reportOptId = $(obj.tr.selector).find('[data-field="documentNo"] span').attr('reportOptId')
			if(layEvent === 'detail'){
				var loadIndex = layer.load();
				$.get('/optimizationReport/getById', {kayId:reportOptId}, function (res) {
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
				url: '/optimizationReport/select',
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
			var optimization_analysis_data =[]
			var _index = 0

			var title = '';
			var url = '';
			var projectId = $('#leftId').attr('projId');

			if (type == '0') {
				title = '新建优化分析';
				url = '/optimizationReport/insert';
			} else if (type == '1') {
				title = '编辑优化分析';
				url = '/optimizationReport/updateById';
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
				'                       <label class="layui-form-label form_label">填报年<span field="createYear" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="createYear" id="createYear"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">填报月<span field="createMonth" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				' 							<select name="createMonth">' +
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
				'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">填报人<span field="createUserName" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="createUserName" readonly autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>' ,
					'			<div class="layui-row">' +
					'  			    <div class="layui-col-xs4" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">填报时间<span field="createDate" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="createDate" readonly autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'  			    <div class="layui-col-xs4" style="padding: 0 5px;width: 80%">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">优化分析说明<span field="memo" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="memo"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'			</div>',
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
					'<input type="file" multiple id="fileupload" data-url="/upload?module=reportOptimiza" name="file">' +
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
					'  </div>\n' +
					/* endregion */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">优化分析</h2>\n' +
					'    <div class="layui-colla-content layui-show">' +
					'     	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">\n' +
					'     	  <ul class="layui-tab-title">\n' +
					'     	    <li class="layui-this">土建（计划内）</li>\n' +
					'     	    <li>土建（计划外）</li>\n' +
					'     	    <li>安装（计划内）</li>\n' +
					'     	    <li>安装（计划外）</li>\n' +
					'     	  </ul>\n' +
					'     	  <div class="layui-tab-content">' +
					' 			 <div class="layui-tab-item layui-show optimization_analysis">' +
					'				<table id="analysisTable" lay-filter="analysisTable"></table>' +
					'			 </div>' +
					' 		   </div>\n' +
					'     	</div>   ' +
					'    </div>\n' +
					/* endregion */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">优化落实</h2>\n' +
					'    <div class="layui-colla-content layui-show optimized_implementation">' +
					'		<table id="implementationTable" lay-filter="implementationTable"></table>' +
					'    </div>\n' +
					'  </div>\n' +
					/* endregion */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">下月优化方案计划</h2>\n' +
					'    <div class="layui-colla-content layui-show project_detailed_information">' +
					'		<table id="detailedTable" lay-filter="detailedTable"></table>' +
					'    </div>\n' +
					'  </div>\n' +
					/* endregion */
					'  </div>\n' +
					'</div>'].join(''),
				success: function () {

					laydate.render({
						elem: '#createYear'
						, trigger: 'click'//呼出事件改成click
						, type: 'year'
						// , format: 'yyyy-MM-dd'
					});


					fileuploadFn('#fileupload', $('#fileContent'));
					//回显项目名称
					getProjName('#projectName',projectId)

					element.on('tab(docDemoTabBrief)', function(data){
						console.log(data.index)
						optimization_analysis_data[(_index)] = planningDetailsData().analysisData||[]
						_index = data.index
						var dataArr = optimization_analysis_data[data.index]||[]
						table.reload('analysisTable', {
							data: dataArr,
							height: dataArr&&dataArr.length>5?'full-350':false
						});
					});

					//回显数据
					if (type == 1 || type == 4) {
						form.val("formTest", data);
						$('input[name="documentNo"]', $('#baseForm')).val(data.documentNo);
						//附件
						if (data.attachmentList && data.attachmentList.length > 0) {
							var fileArr = data.attachmentList;
							$('#fileContent').append(echoAttachment(fileArr));
						}
						optimization_analysis_data[0]=data.detailList1||[]
						optimization_analysis_data[1]=data.detailList2||[]
						optimization_analysis_data[2]=data.detailList3||[]
						optimization_analysis_data[3]=data.detailList4||[]

					}else{
						// 获取自动编号
						getAutoNumber({autoNumberType: 'reportOptimiza'}, function(res) {
							$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
							$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
							$('input[name="createDate"]', $('#baseForm')).val(res.object.createTime)
						});
						$('.refresh_no_btn').show().on('click', function() {
							getAutoNumber({autoNumberType: 'reportOptimiza'}, function(res) {
								$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
								$('input[name="createUserName"]', $('#baseForm')).val(res.object.createUserName).attr('createUser',res.obj.createUser);
								$('input[name="createDate"]', $('#baseForm')).val(res.object.createTime)
							});
						});
					}
					//优化分析
					var cols1 = [
						{type: 'numbers', title: '序号'},
						{
							field: 'optimizationKnowName', title: '优化分项名称', minWidth: 150, templet: function (d) {
								return '<input reportOptId="' + (d.reportOptId || '') + '" reportOptDetailId="'+(d.reportOptDetailId || '')+'" optimizationKnowId="'+(d.optimizationKnowId || '')+'" placeholder="请选择" readonly type="text" name="optimizationKnowName" class="layui-input" style="height: 100%;" value="' + (d.optimizationKnowName || '') + '">'
							}
						},
						{
							field: 'oldPractice', title: '原图做法', minWidth: 160, templet: function (d) {
								return '<input type="text" name="oldPractice" class="layui-input" style="height: 100%;" value="' + (d.oldPractice || '') + '">'
							}
						},
						{
							field: 'oldAmount', title: '原图金额', minWidth: 160, templet: function (d) {
								return '<input type="text" name="oldAmount" class="layui-input" style="height: 100%;" value="' + (d.oldAmount || '') + '">'
							}
						},
						{
							field: 'newPractice', title: '优化后做法', minWidth: 160, templet: function (d) {
								return '<input type="text" name="newPractice" class="layui-input" style="height: 100%;" value="' + (d.newPractice || '') + '">'
							}
						},
						{
							field: 'newAmount', title: '优化后金额', minWidth: 160, templet: function (d) {
								return '<input type="text" name="newAmount" class="layui-input" style="height: 100%;" value="' + (d.newAmount || '') + '">'
							}
						},
						{
							field: 'estAmount', title: '预计优化金额', minWidth: 160, templet: function (d) {
								return '<input type="text" name="estAmount" class="layui-input" style="height: 100%;" value="' + (d.estAmount || '') + '">'
							}
						},
						{
							field: 'actualPractice', title: '实际做法', minWidth: 160, templet: function (d) {
								return '<input type="text" name="actualPractice" class="layui-input" style="height: 100%;" value="' + (d.actualPractice || '') + '">'
							}
						},
						{
							field: 'actualAmount', title: '实际优化金额', minWidth: 160, templet: function (d) {
								return '<input type="text" name="actualAmount" class="layui-input" style="height: 100%;" value="' + (d.actualAmount || '') + '">'
							}
						},
						{
							field: 'implementFlag', title: '是否落实', minWidth: 100, templet: function (d) {
								if(d.implementFlag=='1'){
									return '<input type="checkbox"  name="implementFlag" implementFlag="1" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">'
								}else{
									return '<input type="checkbox" checked="" name="implementFlag" implementFlag="0" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">'
								}
							}
						},
					]
					//优化落实
					var cols2 = [
						{type: 'numbers', title: '序号'},
						{
							field: 'implementaMatters', title: '优化落实事项', minWidth: 150, templet: function (d) {
								return '<input reportOptId="' + (d.reportOptId || '') + '" reportOptListId="'+(d.reportOptListId || '')+'"  placeholder="请选择" type="text" name="implementaMatters" class="layui-input" style="height: 100%;" value="' + (d.implementaMatters || '') + '">'
							}
						},
						{
							field: 'implementaDate', title: '落实时间', minWidth: 160, event: 'dateSelection',templet: function (d) {
								return '<input type="text" name="implementaDate" class="layui-input" style="height: 100%;" value="' + (d.implementaDate || '') + '">'
							}
						},
						{
							field: 'explain', title: '说明', minWidth: 160, templet: function (d) {
								return '<input type="text" name="explain" class="layui-input" style="height: 100%;" value="' + (d.explain || '') + '">'
							}
						},
						{
							field: 'attachmentName',
							title: '相关照片',
							align: 'center',
							minWidth: 200,
							templet: function (d) {
								var fileArr = d.attachmentList;
								return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
										'</div>'

							}
						}
					]

					//下月优化方案计划
					var cols3 = [
						{type: 'numbers', title: '序号'},
						{
							field: 'optimizationKnowName', title: '优化分项名称', minWidth: 150, templet: function (d) {
								return '<input reportOptId="' + (d.reportOptId || '') + '" reportOptNextId="'+(d.reportOptNextId || '')+'" optimizationKnowId="'+(d.optimizationKnowId || '')+'" placeholder="请选择" readonly type="text" name="optimizationKnowName" class="layui-input" style="height: 100%;" value="' + (d.optimizationKnowName || '') + '">'
							}
						},
						{
							field: 'oldPractice', title: '原图做法', minWidth: 160, templet: function (d) {
								return '<input type="text" name="oldPractice" class="layui-input" style="height: 100%;" value="' + (d.oldPractice || '') + '">'
							}
						},
						{
							field: 'oldAmount', title: '原图金额', minWidth: 160, templet: function (d) {
								return '<input type="text" name="oldAmount" class="layui-input" style="height: 100%;" value="' + (d.oldAmount || '') + '">'
							}
						},
						{
							field: 'newPractice', title: '优化后做法', minWidth: 160, templet: function (d) {
								return '<input type="text" name="newPractice" class="layui-input" style="height: 100%;" value="' + (d.newPractice || '') + '">'
							}
						},
						{
							field: 'newAmount', title: '优化后金额', minWidth: 160, templet: function (d) {
								return '<input type="text" name="newAmount" class="layui-input" style="height: 100%;" value="' + (d.newAmount || '') + '">'
							}
						},
						{
							field: 'estAmount', title: '预计优化金额', minWidth: 160, templet: function (d) {
								return '<input type="text" name="estAmount" class="layui-input" style="height: 100%;" value="' + (d.estAmount || '') + '">'
							}
						}
					]
					//查看详情
					if(type!=4){
						cols1.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
						cols2.push({title: '上传相关照片', align: 'center', toolbar: '#internalBar', minWidth: 200})
						cols2.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
						cols3.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
					}
					table.render({
						elem: '#analysisTable',
						data: data&&data.detailList1||[],
						height: data&&data.detailList1&&data.detailList1.length>5?'full-350':false,
						toolbar: type==4?false:'#toolbarPlan',
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols1],
					});
					table.render({
						elem: '#implementationTable',
						data: data&&data.listList||[],
						height: data&&data.listList&&data.listList.length>5?'full-350':false,
						toolbar: type==4?false:'#toolbarPlan',
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols2],
					});
					table.render({
						elem: '#detailedTable',
						data: data&&data.nextplanList||[],
						height: data&&data.nextplanList&&data.nextplanList.length>5?'full-350':false,
						toolbar: type==4?false:'#toolbarPlan',
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols3],
					});


					//查看详情
					if(type==4){
						$('._disabled [name]').attr('disabled', 'disabled');
						$('.refresh_no_btn').hide();
						$('.file_upload_box').hide()
						$('.deImgs').hide();
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

						obj.projectId = $('#leftId').attr('projId');


						if(type == '1'){
							obj.reportOptId= data.reportOptId;
						}

						// 附件
						var attachmentId = '';
						var attachmentName = '';
						for (var i = 0; i < $('#fileContent .dech').length; i++) {
							attachmentId += $('#fileContent .dech').eq(i).find('input').val();
							attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
						}
						obj.attachmentId = attachmentId;
						obj.attachmentName = attachmentName;

						//保存当前tab数据
						optimization_analysis_data[(_index)] = planningDetailsData().analysisData||[]

						obj.detailList1 = optimization_analysis_data[0];
						obj.detailList2 = optimization_analysis_data[1];
						obj.detailList3 = optimization_analysis_data[2];
						obj.detailList4 = optimization_analysis_data[3];

						obj.listList = planningDetailsData(1).implementationData;
						obj.nextplanList = planningDetailsData().scheduleData;


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


					var datas = $('#baseForm').serializeArray();
					var obj = {}
					datas.forEach(function (item) {
						obj[item.name] = item.value
					});

					obj.projectId = $('#leftId').attr('projId');


					if(type == '1'){
						obj.reportOptId= data.reportOptId;
					}

					// 附件
					var attachmentId = '';
					var attachmentName = '';
					for (var i = 0; i < $('#fileContent .dech').length; i++) {
						attachmentId += $('#fileContent .dech').eq(i).find('input').val();
						attachmentName += $('#fileContent .dech').eq(i).find("a").eq(0).attr('name');
					}
					obj.attachmentId = attachmentId;
					obj.attachmentName = attachmentName;

					optimization_analysis_data[(_index)] = planningDetailsData().analysisData||[]

					obj.detailList1 = optimization_analysis_data[0];
					obj.detailList2 = optimization_analysis_data[1];
					obj.detailList3 = optimization_analysis_data[2];
					obj.detailList4 = optimization_analysis_data[3];

					obj.listList = planningDetailsData(1).implementationData;
					obj.nextplanList = planningDetailsData().scheduleData;

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
													reportOptId:approvalData.reportOptId,
													runId: res.flowRun.runId,
													//manageProjStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/optimizationReport/updateById',
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

		$(document).on('click', '[name="optimizationKnowName"]', function () {
			var _this = this
			layer.open({
				type: 1,
				title: '选择',
				area: ['40%', '60%'],
				btn: ['确定', '取消'],
				btnAlign: 'c',
				content: '<div class="container" style="padding: 15px;">\n' +
						'\t<table id="tableDemo2" lay-filter="tableDemo2"></table>\n' +
						'</div>\n',
				success: function () {
					table.render({
						elem: '#tableDemo2',
						url: '/businessKnowledge/select',
						cols: [[
							{type: 'radio'},
							{field: 'documnetNo', title: '单据号', minWidth: 90, sort: true, hide: false},
							{field: 'optimizationKnowName', title: '优化分项', minWidth: 120, sort: true, hide: false}
						]],
						defaultToolbar: ['filter'],
						// height: 'full-80',
						where: {
							delFlag: '0'
						}
					});
				},
				yes: function (index) {
					var dataTable = table.checkStatus('tableDemo2').data;

					if (dataTable.length != 1) {
						layer.msg('请选择一条需要提交的数据！', {icon: 0, time: 2000});
						return false;
					}

					$(_this).val(dataTable[0].optimizationKnowName||'').attr('optimizationKnowId',dataTable[0].optimizationKnowId||'')
					layer.close(index);
				}
			});
		})

		// 优化分析-加行
		table.on('toolbar(analysisTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().analysisData;
					dataArr.push({});
					table.reload('analysisTable', {
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 优化分析-删行
		table.on('tool(analysisTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.reportOptDetailId) {
					$.get('/optimizationReport/delDetails', {ids: data.reportOptDetailId,type:'detail'}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('analysisTable', {
								data: planningDetailsData().analysisData,
								height: planningDetailsData().analysisData&&planningDetailsData().analysisData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('analysisTable', {
						data: planningDetailsData().analysisData,
						height: planningDetailsData().analysisData&&planningDetailsData().analysisData.length>5?'full-350':false
					});
				}
			}
		})

		// 优化落实-加行
		table.on('toolbar(implementationTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData(2).implementationData;
					dataArr.push({});
					table.reload('implementationTable', {
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 优化落实-删行
		table.on('tool(implementationTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.reportOptListId) {
					$.get('/optimizationReport/delDetails', {ids: data.reportOptListId,type:'list'}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('implementationTable', {
								data: planningDetailsData(2).implementationData,
								height: planningDetailsData(2).implementationData&&planningDetailsData(2).implementationData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('implementationTable', {
						data: planningDetailsData(2).implementationData,
						height: planningDetailsData(2).implementationData&&planningDetailsData(2).implementationData.length>5?'full-350':false
					});
				}
			}else if (layEvent == 'dateSelection') {
				var $tr = $('.optimized_implementation').find($tr.selector).find('input[name="implementaDate"]');
				$tr.each(function (index,element) {
					laydate.render({
						elem: element
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						// ,value: new Date()
					});
				})
			}else if (layEvent == 'butfile') {
				var $tr1 = $tr.selector
				fileuploadFn( $tr1+' [id^=fileupload]', $( $tr1+' [id^=fileAll]'),1);
			}
		})

		// 下月优化方案计划-加行
		table.on('toolbar(detailedTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().scheduleData;
					dataArr.push({});
					table.reload('detailedTable', {
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false
					});
					break;
			}
		});
		// 下月优化方案计划-删行
		table.on('tool(detailedTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.reportOptNextId) {
					$.get('/optimizationReport/delDetails', {ids: data.reportOptNextId,type:'nextPlan'}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('detailedTable', {
								data: planningDetailsData().scheduleData,
								height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
							});
						} else {
							layer.msg('删除失败!', {icon: 2, time: 2000});
						}
					});
				} else {
					layer.msg('删除成功!', {icon: 1, time: 2000});
					obj.del();
					table.reload('detailedTable', {
						data: planningDetailsData().scheduleData,
						height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false
					});
				}
			}
		})


		/**
		 * 获取子表数据
		 */
		function planningDetailsData(type) {
			//遍历表格获取每行数据
			//优化分析
			var $trs1 = $('.optimization_analysis').find('.layui-table-main tr');
			var dataArr1 = [];
			$trs1.each(function () {
				var dataObj = {
					reportOptId: $(this).find('input[name="optimizationKnowName"]').attr('reportOptId') || '',
					reportOptDetailId: $(this).find('input[name="optimizationKnowName"]').attr('reportOptDetailId') || '',
					optimizationKnowId: $(this).find('input[name="optimizationKnowName"]').attr('optimizationKnowId') || '',
					optimizationKnowName: $(this).find('input[name="optimizationKnowName"]').val(),
					oldPractice: $(this).find('input[name="oldPractice"]').val(),
					oldAmount: $(this).find('input[name="oldAmount"]').val(),
					newPractice: $(this).find('input[name="newPractice"]').val(),
					newAmount: $(this).find('input[name="newAmount"]').val(),
					estAmount: $(this).find('input[name="estAmount"]').val(),
					actualPractice: $(this).find('input[name="actualPractice"]').val(),
					actualAmount: $(this).find('input[name="actualAmount"]').val(),
					implementFlag: $(this).find('[name="implementFlag"]').prop('checked')? 0:1
				}
				dataArr1.push(dataObj);
			});
			//优化落实
			var $trs2 = $('.optimized_implementation').find('.layui-table-main tr');
			var dataArr2 = [];
			$trs2.each(function (index) {
				var attachmentId = '';
				var attachmentName = '';
				var attachmentList = [];

				if(type=='1'){//提交保存
					for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
						attachmentId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
						attachmentName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
					}
				}else if(type=='2'){//加行、删行、选择
					for (var i = 0; i < $('#fileAll'+(index+1)+' .dech').length; i++) {
						attachmentId += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').val();
						attachmentName += $('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('filename');
						var _obj ={
							attUrl:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('deUrl'),
							attachId:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachId'),
							attachName:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('attachName'),
							size:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').attr('size'),
							aid:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring(0,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')),
							ym:$('#fileAll'+(index+1)+' .dech').eq(i).find('input').val().substring($('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('@')+1,$('#fileAll'+(index+1)+' .dech .inHidden').val().indexOf('_'))
						}
						attachmentList.push(_obj)
					}
				}
				var dataObj = {
					reportOptId: $(this).find('[name="implementaMatters"]').attr('reportOptId') || '',
					reportOptListId: $(this).find('[name="implementaMatters"]').attr('reportOptListId') || '',
					filePosition: $(this).find('[name="implementaMatters"]').val(),
					implementaDate: $(this).find('[name="implementaDate"]').val(),
					explain: $(this).find('[name="explain"]').val(),
					attachmentId:attachmentId,
					attachmentName:attachmentName
				}
				if(type=='2'){
					dataObj.attachmentList = attachmentList;
				}
				dataArr2.push(dataObj);
			});
			//下月优化方案计划
			var $trs3 = $('.project_detailed_information').find('.layui-table-main tr');
			var dataArr3 = [];
			$trs3.each(function () {
				var dataObj = {
					reportOptId: $(this).find('input[name="optimizationKnowName"]').attr('reportOptId') || '',
					reportOptNextId: $(this).find('input[name="optimizationKnowName"]').attr('reportOptNextId') || '',
					optimizationKnowId: $(this).find('input[name="optimizationKnowName"]').attr('optimizationKnowId') || '',
					optimizationKnowName: $(this).find('input[name="optimizationKnowName"]').val(),
					oldPractice: $(this).find('input[name="oldPractice"]').val(),
					oldAmount: $(this).find('input[name="oldAmount"]').val(),
					newPractice: $(this).find('input[name="newPractice"]').val(),
					newAmount: $(this).find('input[name="newAmount"]').val(),
					estAmount: $(this).find('input[name="estAmount"]').val()
				}
				dataArr3.push(dataObj);
			});

			return {
				analysisData:dataArr1,
				implementationData:dataArr2,
				scheduleData: dataArr3
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
