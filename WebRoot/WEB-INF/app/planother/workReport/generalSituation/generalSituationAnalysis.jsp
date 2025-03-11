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
	<title>项目总体情况分析</title>

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


		.layui-col{
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

		.mtl_info2 td[data-field="attachmentName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}

		.mtl_info2 .dech a{
			display: block;
		}
		.mtl_info2 .dech a:nth-of-type(2){
			display: none;
		}
		.mtl_info2 .dech a:nth-of-type(3){
			display: none;
		}
		.mtl_info2 .dech:hover a{
			display: block;
		}

	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">项目总体情况分析</h2>
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
					<input type="week" name="reportWeek" id="reportWeek" placeholder="请选择周" autocomplete="off" class="layui-input">
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
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center;width: 5%;float: right">
					<i class="layui-icon layui-icon-screen-full screen-full" title="全屏" style="font-size: 33px;cursor: pointer;"></i>
				</div>
				<%--				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">--%>
				<%--					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>--%>
				<%--					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>--%>
				<%--				</div>--%>
			</div>
			<div style="position: relative">
				<div class="table_box " style="display: none">

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
<script type="text/html" id="navbar">
	<div style="position:absolute;top: 10px;right:60px;">
		<a class="layui-btn  layui-btn-xs" lay-event="refresh">刷新</a>
	</div>
</script>
<script type="text/html" id="toolbarDemo">
	<div style="height: 30px;color: #666">
		<span>安全检查分析报表</span>
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
		<a class="layui-btn  layui-btn-xs" lay-event="refresh">刷新</a>
	</div>
</script>
<script type="text/html" id="toolbarDemo2">
	<div style="height: 30px;color: #666">
		<span>安全整改分析报表</span>
	</div>
	<div style="position:absolute;top: 10px;right:60px;">
		<a class="layui-btn  layui-btn-xs" lay-event="refresh">刷新</a>
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


	var _html = ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
		'<div class="layui-collapse" style="margin: 20px;border: none;">\n' +
		'  			<div class="layui-row">' +
		'  			    <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'  			        <div class="layui-form-item">\n' +
		'  			            <label class="layui-form-label form_label _one">本月完成情况概述</label>\n' +
		'  			            <div class="layui-input-block form_block mtl_info">\n' +
		'							<table id="securityTable" lay-filter="securityTable"></table>' +
		'  			            </div>\n' +
		'  			        </div>' +
		'  			    </div>' +
		'  			</div>',

		'  			<div class="layui-row">' +
		'  			    <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'  			        <div class="layui-form-item">\n' +
		'  			            <label class="layui-form-label form_label">当前形象进度</label>\n' +
		'  			            <div class="layui-input-block form_block mtl_info2">\n' +
		'							<table id="scheduleTable" lay-filter="scheduleTable"></table>' +
		'  			            </div>\n' +
		'  			        </div>' +
		'  			    </div>' +
		'  			</div>',

		'  			<div class="layui-row">' +
		'  			    <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'  			        <div class="layui-form-item">\n' +
		'  			            <label class="layui-form-label form_label _two">本月计划修编情况</label>\n' +
		'  			            <div class="layui-input-block form_block">\n' +
		'  			 				<textarea type="text" name="scheduleUpdateMemo" style="resize: vertical;min-height: 120px" autocomplete="off" class="layui-input"></textarea>' +
		'  			            </div>\n' +
		'  			        </div>' +
		'  			    </div>' +
		'  			</div>',
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
		'<input type="file" multiple id="fileupload" data-url="/upload?module=reportGeneral" name="file">' +
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

		'  			<div class="layui-row">' +
		'  			    <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'  			        <div class="layui-form-item">\n' +
		'  			            <label class="layui-form-label form_label _three">下月总体计划安排</label>\n' +
		'  			            <div class="layui-input-block form_block">\n' +
		'  			 				<textarea type="text" name="nextMonthPlan" style="resize: vertical;min-height: 120px" autocomplete="off" class="layui-input"></textarea>' +
		'  			            </div>\n' +
		'  			        </div>' +
		'  			    </div>' +
		'  			</div>',
		'           <div class="layui-row">' +
		'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">附件</label>' +
		'                       <div class="layui-input-block form_block">' +
		'<div class="file_module">' +
		'<div id="fileContent2" class="file_content"></div>' +
		'<div class="file_upload_box">' +
		'<a href="javascript:;" class="open_file">' +
		'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
		'<input type="file" multiple id="fileupload2" data-url="/upload?module=reportGeneral" name="file">' +
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

		'  			<div class="layui-row">' +
		'  			    <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'  			        <div class="layui-form-item">\n' +
		'  			            <label class="layui-form-label form_label">其他补充说明</label>\n' +
		'  			            <div class="layui-input-block form_block">\n' +
		'  			 				<textarea type="text" name="otherMemo" style="resize: vertical;min-height: 120px" autocomplete="off" class="layui-input"></textarea>' +
		'  			            </div>\n' +
		'  			        </div>' +
		'  			    </div>' +
		'  			</div>',
		'           <div class="layui-row">' +
		'               <div class="layui-col-xs12" style="padding: 0 5px;">' +
		'                   <div class="layui-form-item">\n' +
		'                       <label class="layui-form-label form_label">附件</label>' +
		'                       <div class="layui-input-block form_block">' +
		'<div class="file_module">' +
		'<div id="fileContent3" class="file_content"></div>' +
		'<div class="file_upload_box">' +
		'<a href="javascript:;" class="open_file">' +
		'<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
		'<input type="file" multiple id="fileupload3" data-url="/upload?module=reportGeneral" name="file">' +
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
		'</div>'+
		'</form>'].join('')


	// 获取地址栏参数值
	function getQueryString(name){
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if(r!=null)return  unescape(r[2]); return null;
	}
	var week = getQueryString("analysisType");


	var animateFlag = true
	$(".screen-full").click(function(){
		$(".wrap_left").animate({
			width:'toggle'
		});
		$(".wrap_right").animate({
			marginLeft:'0'
		},function(){
			$('.searchData').click()
		});
		if(animateFlag){
			$(this).removeClass("layui-icon-screen-full").addClass('layui-icon-screen-restore').attr('title','退出全屏');

		}else {
			$(this).removeClass("layui-icon-screen-restore").addClass('layui-icon-screen-full').attr('title','全屏');
		}

		animateFlag = !animateFlag
	});

	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;

		$('.table_box').html(_html)

		if(week){
			$('.week').show()
			$('.month').hide()
			$('._one').text('本周完成情况概述')
			$('._two').text('本周计划修编情况')
			$('._three').text('下周总体计划安排')
		}

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
				$('#h2_title').text(currentData.projName+'项目总体情况分析')
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
				if(week){
					params.reportWeek = $('[name="reportWeek"]').val()
					params.reportType = 'week'
				}

				var loadIndex = layer.load();
				$.get('/generalSituation/generalAnalysis', params, function (res) {
					layer.close(loadIndex);
					$('#createYear').val(res&&res.obj&&res.obj.year)
					$('[name="createMonth"]').val(res&&res.obj&&res.obj.month)
					$('[name="reportWeek"]').val(res&&res.obj&&res.obj.reportWeek)
					form.render();
					tableShow(res.obj);
				});
			} else {
				$('#h2_title').text('')
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		function tableShow(data){
			//本月完成情况概述
			table.render({
				elem: '#securityTable',
				data: data&&data.generalDetailsList||[],
				defaultToolbar: [''],
				limit: 1000,
				cols: [[
					{type: 'numbers', title: '序号'},
					{field: 'generalSituationName', title: '要素', width: 120, templet: function (d) {
							if(d.url){
								return '<a style="color: blue;text-decoration: underline;" href="'+d.url+'" target="_blank">'+(d.generalSituationName||'')+'</a>'
							}else{
								return d.generalSituationName||''
							}
						}},
					{
						field: 'needRecification', title: '是否可控', width: 120, templet: function (d) {
							if(d.needRecification=='1'){
								return '<input type="checkbox"  name="needRecification" needRecification="1" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">'
							}else{
								return '<input type="checkbox" checked="" name="needRecification" needRecification="0" lay-skin="switch" lay-filter="switchTest" lay-text="是|否">'
							}
						}
					},
					{field: 'memo', title: '说明', minWidth: 400}
				]],
				done:function (res) {

				}
			});

			//当前形象进度
			table.render({
				elem: '#scheduleTable',
				data: data&&data.photoDetailsList||[],
				// data:[],
				// height: data&&data.detailsList&&data.detailsList.length>5?'full-350':false,
				defaultToolbar: [''],
				limit: 1000,
				cols: [[
					{type: 'numbers', title: '序号'},
					{
						field: 'attachmentName',
						title: '现场照片',
						align: 'center',
						minWidth: 200,
						templet: function (d) {
							var fileArr = d.attachmentList;
							return '<div id="fileAll'+d.LAY_INDEX+'"> ' +echoAttachment(fileArr)+
									'</div>'

						}
					},
					{field: 'filePosition', title: '图片说明', minWidth: 200},
					{field: 'memo', title: '备注', minWidth: 200}
				]],
				done:function (res) {

				}
			});

			//其他
			$('[name="scheduleUpdateMemo"]').val((data.generalObj&&data.generalObj.scheduleUpdateMemo)||'')

			$('[name="nextMonthPlan"]').val((data.generalObj&&data.generalObj.nextMonthPlan)||'')

			$('[name="otherMemo"]').val((data.generalObj&&data.generalObj.otherMemo)||'')

			var data = data.generalObj
			//附件
			$('#fileContent,#fileContent2,#fileContent3').html('');
			if (data&&data.attachmentList && data.attachmentList.length > 0) {
				var fileArr = data.attachmentList;
				$('#fileContent').html(echoAttachment(fileArr));
			}
			//附件
			if (data&&data.attachmentList2 && data.attachmentList2.length > 0) {
				var fileArr2 = data.attachmentList2;
				$('#fileContent2').html(echoAttachment(fileArr2));
			}
			//附件
			if (data&&data.attachmentList3 && data.attachmentList3.length > 0) {
				var fileArr3 = data.attachmentList3;
				$('#fileContent3').html(echoAttachment(fileArr3));
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

			if(week){
				params.reportWeek = $('[name="reportWeek"]').val()
				params.reportType = 'week'
			}

			var loadIndex = layer.load();
			$.get('/generalSituation/generalAnalysis', params, function (res) {
				layer.close(loadIndex);
				$('#createYear').val(res&&res.obj&&res.obj.year)
				$('[name="createMonth"]').val(res&&res.obj&&res.obj.month)
				$('[name="reportWeek"]').val(res&&res.obj&&res.obj.reportWeek)
				form.render();
				tableShow(res.obj);
			});
		});


	});

</script>
</body>
</html>
