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
			<h2 style="text-align: center;line-height: 35px;">进度情况综合分析</h2>
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
				<div class="layui-col-xs6" style="text-align: center">
					<h2 id="h2_title" style="margin-top: 10px;text-align: center"></h2>
				</div>
				<div class="layui-col-xs2 week" style="display: none">
					<input type="week" name="createWeek" id="createWeek" placeholder="请选择周" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2 month" >
					<input type="text" name="createYear" id="createYear" placeholder="请选择年" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2 month" style="margin-left: 15px;">
					<select name="createMonth" id="createMonth">
						<option value="">请选择月</option>
						<option value="1">1月</option>
						<option value="2">2月</option>
						<option value="3">3月</option>
						<option value="4">4月</option>
						<option value="5">5月</option>
						<option value="6">6月</option>
						<option value="7">7月</option>
						<option value="8">8月</option>
						<option value="9">9月</option>
						<option value="10">10月</option>
						<option value="11">11月</option>
						<option value="12">12月</option>
					</select>
				</div>
				<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box layui-form" style="display: none">
					<div class="layui-row">
						<div class="layui-col-xs3" style="padding: 0 5px;width: 20%">
							<h3 style="line-height: 50px;">项目名称</h3>
							<input type="text" name="projectName" id="projectName" readonly  autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px;width: 20%">
							<h3 style="line-height: 50px;">填报年</h3>
							<input type="text" name="createYear" readonly autocomplete="off" class="layui-input">
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px;width: 20%">
							<h3 style="line-height: 50px;">填报月</h3>
	 							<select name="createMonth" disabled>
	 								 <option value="">请选择月份</option>
	 								 <option value="1">1月</option>
	                                <option value="2">2月</option>
	                                <option value="3">3月</option>
	                                <option value="4">4月</option>
	                                <option value="5">5月</option>
	                                <option value="6">6月</option>
	                                <option value="7">7月</option>
	                                <option value="8">8月</option>
	                                <option value="9">9月</option>
	                                <option value="10">10月</option>
	                                <option value="11">11月</option>
	                                <option value="12">12月</option>
	  							</select>
						</div>
						<div class="layui-col-xs3" style="padding: 0 5px;width: 40%">
							<h3 style="line-height: 50px;">优化分析说明</h3>
							<input type="text" name="memo" readonly autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-xs12" style="padding: 0 5px;">
							<div class="layui-form-item">
								<label class="layui-form-label form_label">附件</label>
								<div class="layui-input-block form_block">
									<div class="file_module">
										<div id="fileContent" class="file_content"></div>
										<div class="file_upload_box">
											<a href="javascript:;" class="open_file">
												<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
												<input type="file" multiple id="fileupload" data-url="/upload?module=reportOptimiza" name="file">
											</a>
											<div class="progress" id="progress">
												<div class="bar"></div>
											</div>
											<div class="bar_text"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-xs12" style="padding: 0 5px;">
							<h3 style="line-height: 50px;">优化方案</h3>
							<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
							  <ul class="layui-tab-title">
								<li class="layui-this">土建（计划内）</li>
								<li>土建（计划外）</li>
								<li>安装（计划内）</li>
								<li>安装（计划外）</li>
							  </ul>
							  <div class="layui-tab-content">
								 <div class="layui-tab-item layui-show optimization_analysis">
									<table id="analysisTable" lay-filter="analysisTable"></table>
								 </div>
							   </div>
							</div>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-xs12 mtl_info" style="padding: 0 5px;">
							<h3 style="line-height: 50px;">优化落实</h3>
							<table id="implementationTable" lay-filter="implementationTable"></table>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-xs12" style="padding: 0 5px;">
							<h3 style="line-height: 50px;">下月优化方案计划</h3>
							<table id="detailedTable" lay-filter="detailedTable"></table>
						</div>
					</div>
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



	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;


		laydate.render({
			elem: '#createYear'
			, trigger: 'click'//呼出事件改成click
			, type: 'year'
			// , format: 'yyyy-MM-dd'
		});


		form.render();

		// 初始化左侧项目
		projectLeft();


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
				}
			});
		}

		// 树节点点击事件
		eleTree.on("nodeClick(leftTree)", function (d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {
				$('#leftId').attr('projId', currentData.projId);
				$('#h2_title').text(currentData.projName+'优化分析')
				$('.no_data').hide();
				$('.table_box').show();

				var params = {}
				params.projectId = $('#leftId').attr('projId')||''
				if($('#createYear').val()){
					params.year = $('#createYear').val()
				}
				if($('[name="createMonth"]').val()){
					params.month = $('[name="createMonth"]').val()
				}

				var loadIndex = layer.load();
				$.get('/optimizationReport/optimizaAnalysis', params, function (res) {
					layer.close(loadIndex);
					$('#createYear').val(res&&res.obj&&res.obj.year)
					$('[name="createMonth"]').val(res&&res.obj&&res.obj.month)
					form.render();
					tableShow(res.obj);
				});
			} else {
				$('#h2_title').text('')
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		element.on('tab(docDemoTabBrief)', function(data){
			console.log(data.index)
			table.reload('analysisTable', {
				where: {type: '0' + (data.index+1)}
			});
		});

		function tableShow(data){
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
			table.render({
				elem: '#analysisTable',
				// data: data&&data.detailList1||[],
				url:'/optimizationReport/optimizaDetailAnalysis?projectId='+ $('#leftId').attr('projId')||data.projectId,
				// height: data&&data.detailList1&&data.detailList1.length>5?'full-350':false,
				where:{type:'01'},
				defaultToolbar: [''],
				limit: 1000,
				cols: [cols1],
			});
			table.render({
				elem: '#implementationTable',
				data: data&&data.listList||[],
				height: data&&data.listList&&data.listList.length>5?'full-350':false,
				defaultToolbar: [''],
				limit: 1000,
				cols: [cols2],
			});
			table.render({
				elem: '#detailedTable',
				data: data&&data.nextplanList||[],
				height: data&&data.nextplanList&&data.nextplanList.length>5?'full-350':false,
				defaultToolbar: [''],
				limit: 1000,
				cols: [cols3],
			});

			//其他
			// $('[name="scheduleUpdateMemo"]').val((data.generalObj&&data.generalObj.scheduleUpdateMemo)||'')
			//
			// $('[name="nextMonthPlan"]').val((data.generalObj&&data.generalObj.nextMonthPlan)||'')
			//
			$('[name="memo"]').val(data&&data.memo||'')
			//
			// var data = data.generalObj
			//附件
			if (data.attachmentList && data.attachmentList.length > 0) {
				var fileArr = data.attachmentList;
				$('#fileContent').html(echoAttachment(fileArr));
			}

			$('._disabled [name]').attr('disabled', 'disabled');
			$('.file_upload_box').hide()
			$('.deImgs').hide();

			form.render();
		}



		//点击查询
		$('.searchData').click(function () {
			var params = {}
			params.projectId = $('#leftId').attr('projId')||''
			if($('#createYear').val()){
				params.year = $('#createYear').val()
			}
			if($('[name="createMonth"]').val()){
				params.month = $('[name="createMonth"]').val()
			}

			var loadIndex = layer.load();
			$.get('/generalSituation/generalAnalysis', params, function (res) {
				layer.close(loadIndex);
				$('#createYear').val(res&&res.obj&&res.obj.year)
				$('[name="createMonth"]').val(res&&res.obj&&res.obj.month)
				form.render();
				tableShow(res.obj);
			});
		});


	});

</script>
</body>
</html>
