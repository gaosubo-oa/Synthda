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
	<title>质量罚款</title>

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
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">质量罚款</h2>
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
					<input type="text" name="finedDept" placeholder="被罚单位" autocomplete="off" class="layui-input">
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
		<button class="layui-btn layui-btn-sm" lay-event="dayin">质量处罚单</button>
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

<script>

	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});

	//选部门控件添加
	$(document).on('click', '#punishmentDeptName', function () {
		dept_id = "punishmentDeptName";
		$.popWindow("/common/selectDept?0");
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
			documentNo: {field: 'documentNo', title: '单据号', minWidth: 90,sort: true, hide: false},
			projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
			finedDept: {field: 'finedDept', title: '被罚单位', minWidth: 120,sort: true, hide: false},
			punishmentUser:{field:'punishmentUser',title:'被罚人',minWidth: 90,sort:false,hide:false},
			punishmentDate: {field: 'punishmentDate', title: '罚款日期',minWidth: 120, sort: true, hide: false},
			punishmentMoney: {field: 'punishmentMoney', title: '罚款金额',minWidth: 120, sort: true, hide: false},
			punishmentReason: {field: 'punishmentReason', title: '罚款原因',minWidth: 120, sort: true, hide: false},
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

		var TableUIObj = new TableUI('plb_security_punishment');


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
						newOrEdit(1, checkStatus.data[0])
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
					var securityPunishmentId = ''
					checkStatus.data.forEach(function (v, i) {
						securityPunishmentId += v.securityPunishmentId + ','
					})
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/workflow/qualityPunishment/del', {ids: securityPunishmentId}, function (res) {
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
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '80'}, function (res) {
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
										securityPunishmentId:approvalData.securityPunishmentId,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/workflow/qualityPunishment/updateById',
										data: submitData,
										dataType: 'json',
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
				case 'dayin':
					if (checkStatus.data.length != 1) {
						layer.msg('请选择一条需要打印的数据！', {icon: 0, time: 2000});
						return false;
					}
					if(checkStatus.data[0].auditerStatus != 0){
						var index=layer.load();
						var runId=dataTable[0].runId;
						$.ajax({
							url:'/generateDocx/generateDocxByType?runId='+runId+'&type=qualityPunishment',
							success:function(res){
								if(res.flag){
									layer.close(index);
									if(res.obj.reportAttachmentList==undefined||res.obj.reportAttachmentList.length<1||res.obj.reportAttachmentList[0]==""){
										layer.msg('查询失败请刷新重试！', {icon: 0, time: 2000});
										return
									}else{
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
		table.on('tool(tableDemo)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			if(layEvent === 'detail'){
				newOrEdit(4,data)
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
				url: '/workflow/qualityPunishment/select',
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
				url = '/workflow/qualityPunishment/insert';
			} else if (type == '1') {
				title = '编辑';
				url = '/workflow/qualityPunishment/updateById';
			}else if(type == '4'){
				title = '查看详情'
			}
			layer.open({
				type: 1,
				title: title,
				area: ['100%', '100%'],
				btn: type != '4'?['保存','提交审批', '取消']:['确定'],
				btnAlign: 'c',
				content: ['<div class="layui-collapse">\n' +
				/* region 材料计划 */
				'  <div class="layui-colla-item">\n' +
				'    <h2 class="layui-colla-title">基本信息</h2>\n' +
				'    <div class="layui-colla-content layui-show plan_base_info">' +
				'       <form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
				/* region 第一行 */
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">单据号<span field="documentNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="documentNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">被罚单位<span field="finedDept" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="finedDept"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">被罚人<!--<span field="punishmentUser" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="punishmentUser"  autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>' ,
					'<div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">罚款日期<span field="punishmentDate" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="punishmentDate" id="punishmentDate" autocomplete="off" class="layui-input" >\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">罚款金额（元）<span field="punishmentMoney" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="number" name="punishmentMoney" id="punishmentMoney"  autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">罚款金额（大写）<span field="punishmentMoneyUpstr" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="punishmentMoneyUpstr" id="punishmentMoneyUpstr" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input" >\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">罚款单位<span field="punishmentDeptName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="punishmentDeptName" id="punishmentDeptName"  autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'</div>',
					'<div class="layui-row">' +
					'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">罚款原因<span field="punishmentReason" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					' 							<textarea type="text" name="punishmentReason" style="resize: vertical;" autocomplete="off" class="layui-input"></textarea>' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs6" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">处罚依据</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					' 							<textarea type="text" name="punishmentBasis" id="punishmentBasis" readonly style="resize: vertical;" autocomplete="off" class="layui-input"></textarea>' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'</div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">附件照片<span field="attachmentId" class="field_required">*</span></label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload" data-url="/upload?module=securityPunishment" name="file">' +
					'</a>' +
					'<div class="progress" id="progress">' +
					'<div class="bar"></div>\n' +
					'</div>' +
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
					'</div>'].join(''),
				success: function () {

					fileuploadFn('#fileupload', $('#fileContent'));
					//回显项目名称
					getProjName('#projectName',projectId?projectId:data.projectId)

					laydate.render({
						elem: '#punishmentDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
					});
					//回显数据
					if (type == 1 || type == 4) {
						form.val("formTest", data);
						$('[name="punishmentDeptName"]').attr('deptid',data.punishmentDept)


						//附件
						if (data.attachList && data.attachList.length > 0) {
							var fileArr = data.attachList;
							$('#fileContent').append(echoAttachment(fileArr));
						}

						laydate.render({
							elem: 'input[name="punishmentDate"]' //指定元素
							//,trigger: 'click' //采用click弹出
							,format: 'yyyy-MM-dd'
							,value:data.payDate?new Date(data.payDate):''
						});

						//查看详情
						if(type==4){
							$('._disabled').find('input,textarea').attr('disabled', 'disabled');
							$('.refresh_no_btn').hide();
							$('.file_upload_box').hide()
							$('.deImgs').hide();
						}
					}else{
						// 获取自动编号
						getAutoNumber({autoNumberType: 'qualityPunishment'}, function(res) {
							$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
							$('#baseForm input[name="punishmentDeptName"]').attr('deptid',res.object.deptId).val(res.object.deptName)
						});
						$('.refresh_no_btn').show().on('click', function() {
							getAutoNumber({autoNumberType: 'qualityPunishment'}, function(res) {
								$('input[name="documentNo"]', $('#baseForm')).val(res.obj);
								$('#baseForm input[name="punishmentDeptName"]').attr('deptid',res.object.deptId).val(res.object.deptName)
							});
						});
					}


					form.render();
				},
				yes: function (index) {
					if(type!='4'){
						var datas = $('#baseForm').serializeArray();
						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value
						});
						//罚款单位id
						var punishmentDept = $('#baseForm input[name="punishmentDeptName"]').attr('deptid')
						if(punishmentDept&&punishmentDept.indexOf(',')!=-1){
							punishmentDept = punishmentDept.substring(0,punishmentDept.lastIndexOf(','))
						}
						obj.punishmentDept = punishmentDept || '';

						obj.projectId = $('#leftId').attr('projId');


						if(type == '1'){
							obj.securityPunishmentId= data.securityPunishmentId;
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
							data: obj,
							dataType: 'json',
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
					var punishmentDept = $('#baseForm input[name="punishmentDeptName"]').attr('deptid')
					if(punishmentDept&&punishmentDept.indexOf(',')!=-1){
						punishmentDept = punishmentDept.substring(0,punishmentDept.lastIndexOf(','))
					}
					obj.punishmentDept = punishmentDept || '';

					obj.projectId = $('#leftId').attr('projId');


					if(type == '1'){
						obj.securityPunishmentId= data.securityPunishmentId;
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
						url:url,
						data: obj,
						dataType: 'json',
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
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '80'}, function (res) {
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
											/*delete approvalData.detailList
                                            delete approvalData.manageInfoList*/
											approvalData.projectName=approvalData.projName==undefined?approvalData.projectName:approvalData.projName;
											approvalData.projectName=approvalData.projectName==undefined?approvalData.projName:approvalData.projectName;
											newWorkFlow(flowData.flowId, function (res) {
												var submitData = {
													securityPunishmentId:approvalData.securityPunishmentId,
													runId: res.flowRun.runId,
													//manageProjStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/workflow/qualityPunishment/updateById',
													data: submitData,
													dataType: 'json',
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

		// 点击选择质量罚款依据库
		$(document).on('click', '#punishmentBasis', function () {
			var _this = $(this)
			layer.open({
				type: 2,
				title: '质量罚款依据库',
				btn: ['确定','取消'],
				btnAlign: 'c',
				area: ['90%', '80%'],
				maxmin: true,
				content: '/qualityPunishmentBasis/getPunishmentBasisIndex?urlType=qualityPunishment&type=radio',
				success: function () {

				},
				yes: function (index,layero) {
					var childData  = $(layero).find("iframe")[0].contentWindow.getRepairDate3();
					if(childData){
						//违章行为
						var _securityDanger = childData.securityDanger||''
						//处罚标准
						var _securityDangerMeasures = childData.securityDangerMeasures||''
						$(_this).val(_securityDanger+'-'+_securityDangerMeasures)
						$('#punishmentMoney').val(childData.punishmentMoney||'')
						if(childData.punishmentMoney){
							$('#punishmentMoneyUpstr').val(number_chinese(childData.punishmentMoney))||''
						}

						layer.close(index);
					}else {
						layer.msg('请选择一项！', {icon: 0});
					}

				}
			})
		})


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


		$(document).on('input propertychange', '#punishmentMoney', function () {
			var punishmentMoney = $('#punishmentMoney').val()||''
			$('#punishmentMoneyUpstr').val(number_chinese(punishmentMoney))||''
		})


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


	//数字转化为中文大写
	function number_chinese(str) {
		var num = parseFloat(str);
		var strOutput = "",
				strUnit = '仟佰拾亿仟佰拾万仟佰拾元角分';
		num += "00";
		var intPos = num.indexOf('.');
		if (intPos >= 0){
			num = num.substring(0, intPos) + num.substr(intPos + 1, 2);
		}
		strUnit = strUnit.substr(strUnit.length - num.length);
		for (var i=0; i < num.length; i++){
			strOutput += '零壹贰叁肆伍陆柒捌玖'.substr(num.substr(i,1),1) + strUnit.substr(i,1);
		}
		return strOutput.replace(/零角零分$/, '整').replace(/零[仟佰拾]/g, '零').replace(/零{2,}/g, '零').replace(/零([亿|万])/g, '$1').replace(/零+元/, '元').replace(/亿零{0,3}万/, '亿').replace(/^元/, "零元")

	}

	function openRold(){ //流程转交下一步后会调用此方法
		//刷新表格
		tableIns.config.where._ = new Date().getTime();
		tableIns.reload();
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
</script>
</body>
</html>
