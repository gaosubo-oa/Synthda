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
	<title>技术交底</title>

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

		.objectives_Table .layui-table-cell,.objectives_Table .layui-table-box,.objectives_Table .layui-table-body {
			overflow: visible;
		}
		/* 设置下拉框的高度与表格单元格的高度相同 */
		.objectives_Table td .layui-form-select {
			margin-top: -10px;
			margin-left: -15px;
			margin-right: -15px;
		}
		.layui-disabled{
			background: #e7e7e7;
			color: black !important;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">技术交底</h2>
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
					<input type="text" name="documnetNo" placeholder="单据号" autocomplete="off" class="layui-input">
				</div>
<%--				<div class="layui-col-xs2" style="margin-left: 15px;">--%>
<%--					<input type="text" name="finedDept" placeholder="技术名称" autocomplete="off" class="layui-input">--%>
<%--				</div>--%>
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
		<button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
	</div>
</script>

<%--<script type="text/html" id="toolbarPlan2">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="add">选择</button>
	</div>
</script>--%>

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
			documnetNo: {field: 'documnetNo', title: '单据号', minWidth: 90,sort: true, hide: false,templet: function (d) {
					return '<span disclosureId="'+d.disclosureId+'">'+(d.documnetNo||'')+'</span>'
				}},
			projectName:{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
			disclosureName:{field:'disclosureName',title:'技术交底名称',minWidth: 120,sort:true,hide:false},
			technicalName: {field: 'technicalName', title: '技术方案名称', minWidth: 120,sort: true, hide: false,templet: function (d) {
						return '<span>'+(d.technologyScheme&&d.technologyScheme.technicalName||'')+'</span>'
					}},
			schemeType: {field: 'schemeType', title: '方案类型',minWidth: 100, sort: true, hide: false,templet: function (d) {
					if(d.technologyScheme&&d.technologyScheme.schemeType) {
						return '<span>'+((dictionaryObj&&dictionaryObj['SCHEME_TYPE']&&dictionaryObj['SCHEME_TYPE']['object'][d.technologyScheme.schemeType])||'')+'</span>'
					}else {
						return ''
					}
				}},
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
			SCHEME_TYPE:{}
		}
		var dictionaryStr = 'SCHEME_TYPE';
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

		var TableUIObj = new TableUI('plb_other_technology_disclosure');


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
						var disclosureId = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documnetNo"] span').attr('disclosureId')
						var loadIndex = layer.load();
						$.post('/technologyDisclosure/getById', {kayId: disclosureId}, function (res) {
							newOrEdit(1, res.obj)
							layer.close(loadIndex);
						})

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
					if(checkStatus.data[0].auditerStatus != '0'){
						layer.msg('该数据已提交！', {icon: 0, time: 2000});
						return false;
					}
					var disclosureId = ''
					var $trs = $('.table_box .layui-table-body .layui-form-checked').parents('tr').find('[data-field="documnetNo"] span')
					$trs.each(function(){
						disclosureId += $(this).attr('disclosureId') + ','
					})
					// checkStatus.data.forEach(function (v, i) {
					// 	disclosureId += v.disclosureId + ','
					// })
					layer.confirm('确定删除该条数据吗？', function (index) {
						$.post('/technologyDisclosure/del', {ids: disclosureId}, function (res) {
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
					layer.open({
						type: 1,
						title: '选择流程',
						area: ['70%', '80%'],
						btn: ['确定', '取消'],
						btnAlign: 'c',
						content: '<div style="padding: 10px"><table id="flowTable" lay-filter="flowTable"></table></div>',
						success: function () {
							$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '42'}, function (res) {
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
										disclosureId:approvalData.disclosureId,
										runId: res.flowRun.runId,
										//auditerStatus:1
									}
									$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

									$.ajax({
										url: '/technologyDisclosure/updateById',
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
			if(layEvent === 'detail'){
				var disclosureId = $(obj.tr.selector).find('[data-field="documnetNo"] span').attr('disclosureId')
				var loadIndex = layer.load();
				$.post('/technologyDisclosure/getById', {kayId: disclosureId}, function (res) {
					newOrEdit(4, res.obj)
					layer.close(loadIndex);
				})
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
				url: '/technologyDisclosure/select',
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
				title = '新建技术交底';
				url = '/technologyDisclosure/insert';
			} else if (type == '1') {
				title = '编辑技术交底';
				url = '/technologyDisclosure/updateById';
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
				/* region 方案内容 */
				'  <div class="layui-colla-item">\n' +
				'    <h2 class="layui-colla-title">方案内容</h2>\n' +
				'    <div class="layui-colla-content layui-show plan_base_info">' +
				'       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
				/* region 第一行 */
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">单据号<span field="documnetNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="documnetNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
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
				'                       <label class="layui-form-label form_label">技术交底名称<span field="disclosureName" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="disclosureName" id="disclosureName"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">技术方案名称<span field="technicalName" class="field_required">*</span></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="technicalName" id="technicalName" readonly="" autocomplete="off" class="layui-input click_one" style="width: 60%; padding-right: 25px;color: blue;background:#e7e7e7;cursor: pointer;float: left">' +
				'							<a class="layui-btn chooseMtlPlanId2" style="width: 30%; float:right;">选择</a>' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs4" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">方案类型</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       	<select id="scheme_Type" name="schemeType" disabled style="background: #e7e7e7"></select>\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>' ,
					'<div class="layui-row">' +
					'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">方案概述</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					' 							<textarea type="text" name="schemeSummary"  disabled  style="resize: vertical;min-height: 80px;" autocomplete="off" class="layui-input"></textarea>' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'</div>',
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">技术方案附件</label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					/*'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload" data-url="/upload?module=technologyDisclosure" name="file">' +
					'</a>' +*/
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
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">方案主要内容</h2>\n' +
					'    <div class="layui-colla-content layui-show project_detailed_information">' +
					'		<table id="detailedTable" lay-filter="detailedTable"></table>' +
					'    </div>\n' +
					'  </div>\n' +
					'  <div class="layui-colla-item _disabled">\n' +
					'    <h2 class="layui-colla-title">交底主要内容</h2>\n' +
					'    <div class="layui-colla-content layui-show project_objectives">' +
					'		<table id="objectivesTable" lay-filter="objectivesTable"></table>' +
					'    </div>\n' +
					'  </div>\n' +
					/* endregion */
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 30px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">技术交底附件</label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent2" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload2" data-url="/upload?module=technologyDisclosure" name="file">' +
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
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">交底会议纪要</label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent3" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload3" data-url="/upload?module=technologyDisclosure" name="file">' +
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
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">交底签字记录</label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent4" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload4" data-url="/upload?module=technologyDisclosure" name="file">' +
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
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">交底现场照片</label>' +
					'                       <div class="layui-input-block form_block">' +
					'<div class="file_module">' +
					'<div id="fileContent5" class="file_content"></div>' +
					'<div class="file_upload_box">' +
					'<a href="javascript:;" class="open_file">' +
					'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
					'<input type="file" multiple id="fileupload5" data-url="/upload?module=technologyDisclosure" name="file">' +
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
					'</div>'].join(''),
				success: function () {

					//方案类型
					var $select1 = $("#scheme_Type");
					var optionStr = '<option value="">请选择</option>';
					optionStr += dictionaryObj&&dictionaryObj['SCHEME_TYPE']&&dictionaryObj['SCHEME_TYPE']['str']
					$select1.html(optionStr);

					fileuploadFn('#fileupload2', $('#fileContent2'));
					fileuploadFn('#fileupload3', $('#fileContent3'));
					fileuploadFn('#fileupload4', $('#fileContent4'));
					fileuploadFn('#fileupload5', $('#fileContent5'));
					//回显项目名称
					getProjName('#projectName',projectId?projectId:data.projectId)

					//回显数据
					if (type == 1 || type == 4) {
						form.val("formTest", data);
						$('#technicalName').val((data.technologyScheme&&data.technologyScheme.technicalName)||'').attr('technologyId',data.technologyId||'')
						$('[name="schemeType"]').val((data.technologyScheme&&data.technologyScheme.schemeType)||'')
						$('[name="schemeSummary"]').val((data.technologyScheme&&data.technologyScheme.schemeSummary)||'')
						//附件
						if (data.technologyScheme&&data.technologyScheme.attachmentList && data.technologyScheme.attachmentList.length > 0) {
							var fileArr = data.technologyScheme.attachmentList;
							$('#fileContent').append(echoAttachment(fileArr));
						}
						//附件
						if (data.attachmentList2 && data.attachmentList2.length > 0) {
							var fileArr = data.attachmentList2;
							$('#fileContent2').append(echoAttachment(fileArr));
						}
						//附件
						if (data.attachmentList3 && data.attachmentList3.length > 0) {
							var fileArr = data.attachmentList3;
							$('#fileContent3').append(echoAttachment(fileArr));
						}
						//附件
						if (data.attachmentList4 && data.attachmentList4.length > 0) {
							var fileArr = data.attachmentList4;
							$('#fileContent4').append(echoAttachment(fileArr));
						}
						//附件
						if (data.attachmentList5 && data.attachmentList5.length > 0) {
							var fileArr = data.attachmentList5;
							$('#fileContent5').append(echoAttachment(fileArr));
						}
					}else{
						// 获取自动编号
						getAutoNumber({autoNumberType: 'technologyDisclosure'}, function(res) {
							$('input[name="documnetNo"]', $('#baseForm')).val(res.obj);
						});
						$('.refresh_no_btn').show().on('click', function() {
							getAutoNumber({autoNumberType: 'technologyDisclosure'}, function(res) {
								$('input[name="documnetNo"]', $('#baseForm')).val(res.obj);
							});
						});
					}

					//方案主要内容
					var cols = [
						{type: 'numbers', title: '序号'},
						{
							field: 'mainSchemeName', title: '名称', minWidth: 150, templet: function (d) {
								return '<span disclosureId="' + (d.disclosureId || '') + '" mainSchemeId="'+(d.mainSchemeId || '')+'" class="mainSchemeName" >' + (d.mainSchemeName || '') + '</span>'
							}
						},
						{field: 'mainSchemeContent', title: '主要内容', minWidth: 160},
						{field: 'completedUser', title: '完成人', minWidth: 160}
					]
					//交底主要内容
					var cols2 = [
						{type: 'numbers', title: '序号'},
						{
							field: 'mainSchemeName', title: '名称', minWidth: 150, templet: function (d) {
								return '<input disclosureId="' + (d.disclosureId || '') + '" mainSchemeId="'+(d.mainSchemeId || '')+'" type="text" name="mainSchemeName" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeName || '') + '">'
							}
						},
						{
							field: 'mainSchemeContent', title: '主要内容', minWidth: 160, templet: function (d) {
								return '<input type="text" name="mainSchemeContent" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeContent || '') + '">'
							}
						},
						{
							field: 'responsibilityUser', title: '责任人', minWidth: 160, templet: function (d) {
								return '<input type="text" name="responsibilityUser" class="layui-input" style="height: 100%;" value="' + (d.responsibilityUser || '') + '">'
							}
						}
					]
					//查看详情
					if(type!=4){
						// cols.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
						cols2.push({align: 'center', toolbar: '#barPlan', title: '操作', minWidth: 100})
					}
					table.render({
						elem: '#detailedTable',
						data: data&&data.technologyScheme&&data.technologyScheme.schemeDetailList||[],
						height: data&&data.technologyScheme&&data.technologyScheme.schemeDetailList&&data.technologyScheme.schemeDetailList.length>5?'full-350':false,
						// toolbar: type==4?false:'#toolbarPlan',
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols],
					});

					table.render({
						elem: '#objectivesTable',
						data: data&&data.disclosureLists||[],
						height: data&&data.disclosureLists&&data.disclosureLists.length>5?'full-350':false,
						toolbar: type==4?false:'#toolbarPlan',
						defaultToolbar: [''],
						limit: 1000,
						cols: [cols2],
					});

					//查看详情
					if(type==4){
						$('._disabled [name]').attr('disabled', 'disabled');
						$('.refresh_no_btn').hide();
						$('.file_upload_box').hide()
						$('.deImgs').hide();
						$('.chooseMtlPlanId2').hide()
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

						obj.technologyId = $('#technicalName').attr('technologyId')||''

						obj.projectId = $('#leftId').attr('projId');


						if(type == '1'){
							obj.disclosureId= data.disclosureId;
						}

					
						// 附件
						var attachment2Id = '';
						var attachmen2Name = '';
						for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
							attachment2Id += $('#fileContent2 .dech').eq(i).find('input').val();
							attachmen2Name += $('#fileContent2 .dech').eq(i).find("a").eq(0).attr('name');
						}
						obj.attachment2Id = attachment2Id;
						obj.attachmen2Name = attachmen2Name;

						// 附件
						var attachment3Id = '';
						var attachment3Name = '';
						for (var i = 0; i < $('#fileContent3 .dech').length; i++) {
							attachment3Id += $('#fileContent3 .dech').eq(i).find('input').val();
							attachment3Name += $('#fileContent3 .dech').eq(i).find("a").eq(0).attr('name');
						}
						obj.attachment3Id = attachment3Id;
						obj.attachment3Name = attachment3Name;

						// 附件
						var attachment4Id = '';
						var attachment4Name = '';
						for (var i = 0; i < $('#fileContent4 .dech').length; i++) {
							attachment4Id += $('#fileContent4 .dech').eq(i).find('input').val();
							attachment4Name += $('#fileContent4 .dech').eq(i).find("a").eq(0).attr('name');
						}
						obj.attachment4Id = attachment4Id;
						obj.attachment4Name = attachment4Name;

						// 附件
						var attachment5Id = '';
						var attachment5Name = '';
						for (var i = 0; i < $('#fileContent5 .dech').length; i++) {
							attachment5Id += $('#fileContent5 .dech').eq(i).find('input').val();
							attachment5Name += $('#fileContent5 .dech').eq(i).find("a").eq(0).attr('name');
						}
						obj.attachment5Id = attachment5Id;
						obj.attachment5Name = attachment5Name;

						obj.disclosureLists = planningDetailsData().scheduleData

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

					obj.technologyId = $('#technicalName').attr('technologyId')||''

					obj.projectId = $('#leftId').attr('projId');


					if(type == '1'){
						obj.disclosureId= data.disclosureId;
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

					// 附件
					var attachment2Id = '';
					var attachmen2Name = '';
					for (var i = 0; i < $('#fileContent2 .dech').length; i++) {
						attachment2Id += $('#fileContent2 .dech').eq(i).find('input').val();
						attachmen2Name += $('#fileContent2 .dech').eq(i).find("a").eq(0).attr('name');
					}
					obj.attachment2Id = attachment2Id;
					obj.attachmen2Name = attachmen2Name;

					// 附件
					var attachment3Id = '';
					var attachment3Name = '';
					for (var i = 0; i < $('#fileContent3 .dech').length; i++) {
						attachment3Id += $('#fileContent3 .dech').eq(i).find('input').val();
						attachment3Name += $('#fileContent3 .dech').eq(i).find("a").eq(0).attr('name');
					}
					obj.attachment3Id = attachment3Id;
					obj.attachment3Name = attachment3Name;

					// 附件
					var attachment4Id = '';
					var attachment4Name = '';
					for (var i = 0; i < $('#fileContent4 .dech').length; i++) {
						attachment4Id += $('#fileContent4 .dech').eq(i).find('input').val();
						attachment4Name += $('#fileContent4 .dech').eq(i).find("a").eq(0).attr('name');
					}
					obj.attachment4Id = attachment4Id;
					obj.attachment4Name = attachment4Name;

					// 附件
					var attachment5Id = '';
					var attachment5Name = '';
					for (var i = 0; i < $('#fileContent5 .dech').length; i++) {
						attachment5Id += $('#fileContent5 .dech').eq(i).find('input').val();
						attachment5Name += $('#fileContent5 .dech').eq(i).find("a").eq(0).attr('name');
					}
					obj.attachment5Id = attachment5Id;
					obj.attachment5Name = attachment5Name;

					obj.disclosureLists = planningDetailsData().scheduleData

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
										$.get('/plbFlowSetting/getOwnFlowData', {plbDictNo: '42'}, function (res) {
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
													disclosureId:approvalData.disclosureId,
													runId: res.flowRun.runId,
													//manageProjStatus:1
												}
												$.popWindow("/workflow/work/workform?opflag=1&flowId=" + flowData.flowId + '&type=new&flowStep=1&prcsId=1&runId=' + res.flowRun.runId, '<fmt:message code="newWork.th.Quick" />', '0', '0', '1150px', '700px');

												$.ajax({
													url: '/technologyDisclosure/updateById',
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

		// 方案主要内容-加行
		table.on('toolbar(objectivesTable)', function (obj) {
			switch (obj.event) {
				case 'add':
					//遍历表格获取每行数据进行保存
					var dataArr = planningDetailsData().scheduleData;
					dataArr.push({});
					table.reload('objectivesTable', {
						data: dataArr,
						height: dataArr&&dataArr.length>5?'full-350':false,
					});
					break;
			}
		});
		// 方案主要内容-删行
		table.on('tool(objectivesTable)', function (obj) {
			var data = obj.data;
			var layEvent = obj.event;
			var $tr = obj.tr;
			if (layEvent === 'del') {
				if (data.mainSchemeId) {
					$.get('/technologyDisclosure/del', {ids: data.mainSchemeId,type:'schemeList'}, function (res) {
						if (res.flag) {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							obj.del();
							table.reload('objectivesTable', {
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
					table.reload('objectivesTable', {
						data: planningDetailsData().scheduleData,
						height: planningDetailsData().scheduleData&&planningDetailsData().scheduleData.length>5?'full-350':false,
					});
				}
			}
		})


		/**
		 * 获取子表数据
		 */
		function planningDetailsData() {
			//遍历表格获取每行数据
			//交底主要内容
			var $trs = $('.project_objectives').find('.layui-table-main tr');
			var dataArr = [];
			$trs.each(function () {
				var dataObj = {
					disclosureId: $(this).find('input[name="mainSchemeName"]').attr('disclosureId') || '',
					mainSchemeId: $(this).find('input[name="mainSchemeName"]').attr('mainSchemeId') || '',
					mainSchemeName: $(this).find('input[name="mainSchemeName"]').val(),
					mainSchemeContent: $(this).find('input[name="mainSchemeContent"]').val(),
					responsibilityUser: $(this).find('input[name="responsibilityUser"]').val()
				}
				dataArr.push(dataObj);
			});


			return {
				scheduleData: dataArr
			}
		}

		$(document).on('click', '.chooseMtlPlanId2', function() {
			layer.open({
				type: 1,
				title: '选择',
				area: ['80%', '70%'],
				maxmin: true,
				btnAlign:'c',
				btn: ['确定', '取消'],
				content: ['<div class="layui-form" >' +
				//表格数据
				'       <div style="padding: 10px">' +
				'           <table id="Settlement2" lay-filter="SettlementFilter2"></table>' +
				'      </div>' +
				'</div>'].join(''),
				success: function () {
					table.render({
						elem: '#Settlement2',
						url: '/technologyScheme/select',//数据接口
						page:true,
						where: {
							projId: $('#leftId').attr('projId'),
							projectId: $('#leftId').attr('projId'),
							delFlag: '0',
							auditerStatus:'2'
						},
						cols: [[//表头
							{type: 'radio'},
							{field: 'documnetNo', title: '单据号', minWidth: 90,sort: true, hide: false},
							{field:'projectName',title:'项目名称',minWidth: 120,sort:true,hide:false},
							{field: 'technicalName', title: '技术方案名称', minWidth: 120,sort: true, hide: false},
							{field: 'schemeType', title: '方案类型',minWidth: 100, sort: true, hide: false,templet: function (d) {
									if(d.schemeType) {
										return '<span>'+((dictionaryObj&&dictionaryObj['SCHEME_TYPE']&&dictionaryObj['SCHEME_TYPE']['object'][d.schemeType])||'')+'</span>'
									}else {
										return ''
									}
								}}
						]],
						done:function(res){
							var _dataa=res.data;
							var technologyId = $('#technicalName').attr('technologyId')
							if(technologyId){
								for(var i = 0 ; i <_dataa.length;i++){
									if(_dataa[i].technologyId == technologyId){
										$('.layui-table tr[data-index=' + i + '] input[type="radio"]').next(".layui-form-radio").click();
										//form.render('checkbox');
									}
								}
							}

						}
					});
				},
				yes: function (index) {
					var datas =table.checkStatus('Settlement2').data;
					if (datas.length > 0) {
						$('#technicalName').val(datas[0].technicalName).attr('technologyId',datas[0].technologyId)
						$('#baseForm [name="schemeType"]').val(datas[0].schemeType)
						$('#baseForm [name="schemeSummary"]').val(datas[0].schemeSummary)
						//附件
						if (datas[0]&&datas[0].attachmentList && datas[0].attachmentList.length > 0) {
							var fileArr = datas[0].attachmentList;
							$('#baseForm #fileContent').html(echoAttachment(fileArr));
						}
						table.reload('detailedTable', {
							data: datas[0]&&datas[0].schemeDetailList,
							height: datas[0]&&datas[0].schemeDetailList&&datas[0].schemeDetailList.length>5?'full-350':false,
						});
						layer.close(index);
					} else {
						layer.msg('请选择一项！', {icon: 0});
					}
				}
			});
		});

		$(document).on('click', '#technicalName', function() {
			var technologyId = $(this).attr('technologyId')
			if(!technologyId){
				return
			}
			var loadIndex = layer.load();
			$.get('/technologyScheme/getById', {kayId:technologyId}, function (res) {
				var data = res.obj
				layer.open({
					type: 1,
					title: '技术方案详情',
					area: ['100%', '100%'],
					maxmin: true,
					btnAlign:'c',
					btn: ['确定'],
					content: ['<div class="layui-collapse _disabled2">\n' +
					/* region 方案内容 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">方案内容</h2>\n' +
					'    <div class="layui-colla-content layui-show plan_base_info">' +
					'       <form class="layui-form" id="baseForm2" lay-filter="formTest">' +
					/* region 第一行 */
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">单据号<span field="documnetNo" class="field_required">*</span><a title="刷新单据号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="documnetNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="projectName" id="projectName2" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">技术方案名称<span field="technicalName" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="technicalName"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">方案类型<span field="schemeType" class="field_required">*</span></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       	<select class="schemeType" name="schemeType" ></select>\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>' ,
						'<div class="layui-row">' +
						'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">方案概述<span field="schemeSummary" class="field_required">*</span></label>\n' +
						'                       <div class="layui-input-block form_block">\n' +
						' 							<textarea type="text" name="schemeSummary" style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>' +
						'                       </div>\n' +
						'                   </div>' +
						'               </div>' +
						'</div>',
						'           <div class="layui-row">' +
						'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
						'                   <div class="layui-form-item">\n' +
						'                       <label class="layui-form-label form_label">附件<span field="attachmentId" class="field_required">*</span></label>' +
						'                       <div class="layui-input-block form_block">' +
						'<div class="file_module">' +
						'<div id="_fileContent" class="file_content"></div>' +
						'<div class="file_upload_box">' +
						// '<a href="javascript:;" class="open_file">' +
						// '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
						// '<input type="file" multiple id="fileupload" data-url="/upload?module=technologyScheme" name="file">' +
						// '</a>' +
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
						'    <h2 class="layui-colla-title">方案主要内容</h2>\n' +
						'    <div class="layui-colla-content layui-show">' +
						'		<table id="detailed_Table" lay-filter="detailed_Table"></table>' +
						'    </div>\n' +
						'  </div>\n' +
						'  <div class="layui-colla-item">\n' +
						'    <h2 class="layui-colla-title">策划要求</h2>\n' +
						'    <div class="layui-colla-content layui-show objectives_Table">' +
						'		<table id="objectives_Table" lay-filter="objectives_Table"></table>' +
						'    </div>\n' +
						'  </div>\n' +
						/* endregion */
						'</div>'].join(''),
					success: function () {

						//方案类型
						var $select1 = $("baseForm2 .schemeType");
						var optionStr = '<option value="">请选择</option>';
						optionStr += dictionaryObj&&dictionaryObj['SCHEME_TYPE']&&dictionaryObj['SCHEME_TYPE']['str']
						$select1.html(optionStr);

						// fileuploadFn('#fileupload', $('#fileContent'));
						//回显项目名称
						getProjName('#projectName2',$('#leftId').attr('projId'))

						//回显数据
						form.val("formTest", data);
						$('input[name="documnetNo"]', $('#baseForm2')).val(data.documnetNo);
						//附件
						if (data.attachmentList && data.attachmentList.length > 0) {
							var fileArr = data.attachmentList;
							$('#_fileContent').append(echoAttachment(fileArr));
						}

						//方案主要内容
						var cols = [
							{type: 'numbers', title: '序号'},
							{
								field: 'mainSchemeName', title: '名称', minWidth: 150, templet: function (d) {
									return '<input technologyId="' + (d.technologyId || '') + '" mainSchemeId="'+(d.mainSchemeId || '')+'" type="text" name="mainSchemeName" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeName || '') + '">'
								}
							},
							{
								field: 'mainSchemeContent', title: '主要内容', minWidth: 160, templet: function (d) {
									return '<input type="text" name="mainSchemeContent" class="layui-input" style="height: 100%;" value="' + (d.mainSchemeContent || '') + '">'
								}
							},
							{
								field: 'completedUser', title: '完成人', minWidth: 160, templet: function (d) {
									return '<input type="text" name="completedUser" class="layui-input" style="height: 100%;" value="' + (d.completedUser || '') + '">'
								}
							}
						]
						//策划要求
						var cols2 = [
							{type: 'numbers', title: '序号'},
							{
								field: 'technical', title: '技术方案', minWidth: 140, templet: function (d) {
									return '<span technologyId="' + (d.technologyId || '') + '" planAskId="'+(d.planAskId || '')+'" planningTechnologyId="'+(d.planningTechnologyId || '')+'" class="technical">' + (d.technical || '') + '</span>'
								}
							},
							{field: 'technologyScheme', title: '方案描述', minWidth: 140},
							{field: 'importanceLevel', title: '重要级别', minWidth: 140},
							{
								field: 'projectUser', title: '项目责任人', minWidth: 140, templet: function (d) {
									return '<span projectUser="' + (d.projectUser || '') + '" class="projectUser">' + (d.projectUserName || '') + '</span>'
								}
							},
							{
								field: 'companyUser', title: '公司责任人', minWidth: 140, templet: function (d) {
									return '<span companyUser="' + (d.companyUser || '') + '" class="companyUser">' + (d.companyUserName || '') + '</span>'
								}
							},
							{field: 'plannedCompletionTime', title: '计划完成时间', minWidth: 160},
							{field: 'fruitAsk', title: '成果物要求', minWidth: 150},
							{
								field: 'isFinish', title: '是否已完成', minWidth: 150, templet: function (d) {
									return '<select name="isFinish">' +
											'<option value="">请选择</option>' +
											'<option value="0" '+(d.isFinish=='0'?'selected':'')+'>是</option>' +
											'<option value="1" '+(d.isFinish=='1'?'selected':'')+'>否</option>' +
											'</select>'
								}
							}
						]

						table.render({
							elem: '#detailed_Table',
							data: data&&data.schemeDetailList||[],
							height: data&&data.schemeDetailList&&data.schemeDetailList.length>5?'full-350':false,
							defaultToolbar: [''],
							limit: 1000,
							cols: [cols],
						});

						table.render({
							elem: '#objectives_Table',
							data: data&&data.schemeLists||[],
							height: data&&data.schemeLists&&data.schemeLists.length>5?'full-350':false,
							defaultToolbar: [''],
							limit: 1000,
							cols: [cols2],
						});


							$('._disabled2 [name]').attr('disabled', 'disabled');
							$('#baseForm2 .refresh_no_btn').hide();
							$('#baseForm2 .file_upload_box').hide()
							$('#baseForm2 .deImgs').hide();


						element.render();
						form.render();
					},
					yes: function (index) {
						layer.close(index);
					}
				});
				layer.close(loadIndex);
			});

		});


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
