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
	<title>项目进度情况综合分析</title>

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
	<script type="text/javascript" src="/js/planother/planotherUtil.js?221202108091508"></script>
<%--	<script type="text/javascript" src="/js/planbudget/projectCostAnalysis.js?1202108301508"></script>--%>

	<script src="/js/planother/jsplumb.min.js?202201050935"></script>


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

		._one .layui-table-grid-down{
			display: none;
			opacity: 0;
		}
		/*.transparent_class {
			filter:alpha(opacity=0);
			-moz-opacity:0;
			-khtml-opacity: 0;
			opacity: 0;
		}*/

		#diagramContainer {
			position: relative;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;
		}


		._one td[data-field^="scheduleName"] .layui-table-cell {
			overflow: hidden;
		}
		._one .layui-table-cell {
			height: auto;
			overflow:visible;
			/*text-overflow:inherit;*/
			/*white-space:normal;*/
			word-break: break-word;
		}
		._one .layui-table-header th[data-field^="partyMoney"] div{
			width: 20px;
			padding: 0;
		}
		._one .layui-table-body td[data-field^="partyMoney"] div{
			width: 20px;
			padding: 0;
		}

		.mtl_info td[data-field="attachmentName"] .layui-table-cell{
			height: auto;
			overflow:visible;
			text-overflow:inherit;
			white-space:normal;
			word-break: break-word;
		}

		.mtl_info .dech a{
			display: block;
		}
		.mtl_info .dech a:nth-of-type(2){
			display: none;
		}
		.mtl_info .dech a:nth-of-type(3){
			display: none;
		}
		.mtl_info .dech:hover a{
			display: block;
		}
		/*svg{
			display: none;
		}*/

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
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center;width: 5%;float: right">
					<i class="layui-icon layui-icon-screen-full screen-full" title="全屏" style="font-size: 33px;cursor: pointer;"></i>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box layui-form" style="display: none">
					<div class="layui-row">
						<div class="layui-col-xs6" style="padding: 0 5px;">
							<h3 class="add1" style="line-height: 50px;">月度进度情况说明</h3>
							<textarea type="text" name="memo" readonly style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>
						</div>
						<div class="layui-col-xs6" style="padding: 0 5px;">
							<h3 style="line-height: 50px;">进度修编情况说明</h3>
							<textarea type="text" name="sheduleChangeMemo" readonly style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-xs12 mtl_info" style="padding: 0 5px;">
							<h3 style="line-height: 50px;">当前形象进度</h3>
							<table id="securityTable" lay-filter="securityTable"></table>
						</div>
					</div>
					<div class="layui-row">
						<div class="layui-col-xs12" style="padding: 0 5px;">
							<h3 style="line-height: 50px;">其它补充说明</h3>
							<textarea type="text" name="otherMemo" readonly style="resize: vertical;min-height: 80px" autocomplete="off" class="layui-input"></textarea>
						</div>
					</div>
				   <div class="layui-row">
					   <div class="layui-col-xs12" style="padding: 0 5px;">
						   <div class="layui-form-item">
							   <label class="layui-form-label form_label">附件说明</label>
							   <div class="layui-input-block form_block">
									<div class="file_module">
									<div id="fileContent" class="file_content"></div>
									<div class="file_upload_box">
									<a href="javascript:;" class="open_file">
									<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>
									<input type="file" multiple id="fileupload" data-url="/upload?module=scheduleReport" name="file">
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
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
						<ul class="layui-tab-title _tab">
							<li class="layui-this">本月进度执行情况分析</li>
							<li>本月进度可视化分析</li>
							<li>节点修编情况分析</li>
							<li>下月进度计划安排</li>
						</ul>
						<div class="layui-tab-content">
							<div class="layui-tab-item layui-show _one">
								<div class="layui-row" >
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #000000;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">总进度计划</span>
									</div>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #B5B5B5;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">进度计划分解</span>
									</div>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #966f31;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">初始进度计划</span>
									</div>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #912CEE;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">已完成</span>
									</div>
									<%--<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #EE0000;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">超期未完成</span>
									</div>--%>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #90EE90;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">未完成</span>
									</div>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;float: left;margin: 10px;">
											<img style="width: 100%;display: inline-block;margin-top: -5px" src="/img/planother/diamond-two.png">
										</div>
										<span style="float: left;line-height: 35px">节点计划</span>
									</div>
								</div>
								<div class="layui-row" style="margin: 5px 0;">
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">初始计划</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="oldPlanYn" lay-filter="test1" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">最新计划</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="newPlanYn" checked lay-filter="test2" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">总进度计划</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="masterSchedule" checked lay-filter="test3" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">时间刻度</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="scaleType" checked lay-filter="test4" lay-skin="switch" lay-text="日刻度|周刻度">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">一键修编</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="autoRevision" lay-filter="test5" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">紧前关系</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="isflag" lay-filter="test6" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
								</div>
								<table class="layui-table" id="docDemoTabBrief0" lay-filter="docDemoTabBrief0" cellspacing="0" cellpadding="0">
									<thead id="duration0">

									</thead>
									<tbody>

									</tbody>
								</table>
							</div>
							<div class="layui-tab-item _two">
								<table class="layui-table" id="docDemoTabBrief1" lay-filter="docDemoTabBrief1" cellspacing="0" cellpadding="0">
									<thead>

									</thead>
								</table>
							</div>
							<div class="layui-tab-item">
								<table id="tableIns" lay-filter="tableIns"></table>
							</div>
							<div class="layui-tab-item _one">
								<div class="layui-row" >
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #000000;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">总进度计划</span>
									</div>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #B5B5B5;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">进度计划分解</span>
									</div>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #966f31;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">初始进度计划</span>
									</div>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #912CEE;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">已完成</span>
									</div>
									<%--<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #EE0000;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">超期未完成</span>
									</div>--%>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;background-color: #90EE90;float: left;margin: 10px;"></div>
										<span style="float: left;line-height: 35px">未完成</span>
									</div>
									<div class="layui-col-xs" style="margin-top: 3px;text-align: center">
										<div style="width: 20px;height: 15px;float: left;margin: 10px;">
											<img style="width: 100%;display: inline-block;margin-top: -5px" src="/img/planother/diamond-two.png">
										</div>
										<span style="float: left;line-height: 35px">节点计划</span>
									</div>
								</div>
								<div class="layui-row" style="margin: 5px 0;">
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">初始计划</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="oldPlanYn" lay-filter="test1" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">最新计划</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="newPlanYn" checked lay-filter="test2" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">总进度计划</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="masterSchedule" checked lay-filter="test3" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">时间刻度</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="scaleType" checked lay-filter="test4" lay-skin="switch" lay-text="日刻度|周刻度">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">一键修编</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="autoRevision" lay-filter="test5" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
									<div class="layui-col-xs1" style="margin-top: 3px;margin-left: 15px;text-align: center;width: 15%">
										<span style="float: left;line-height: 40px">紧前关系</span>
										<div style="width: 20px;height: 15px;float: left;margin:auto">
											<input type="checkbox" name="isflag" lay-filter="test6" lay-skin="switch" lay-text="是|否">
										</div>
									</div>
								</div>
								<table class="layui-table" id="docDemoTabBrief3" lay-filter="docDemoTabBrief3" cellspacing="0" cellpadding="0">
									<thead id="duration3">

									</thead>
									<tbody>

									</tbody>
								</table>
							</div>
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
<script type="text/html" id="navbar">
	<div style="position:absolute;top: 10px;right:60px;">
		<a class="layui-btn  layui-btn-xs" lay-event="refresh">刷新</a>
	</div>
</script>

<script>
    // 获取地址栏参数值
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    var projectId = getQueryString("projectId");
    var showProj = getQueryString("showProj");
    var year = getQueryString("year");
    var month = getQueryString("month");

	var week = getQueryString("analysisType");

	if(week){
		$('.week').show()
		$('.month').hide()
		$('.add1').text('周度进度情况说明')
		var tab_html = '<li class="layui-this">本周进度执行情况分析</li>\n' +
				'<li>本周进度可视化分析</li>\n' +
				'<li>节点修编情况分析</li>\n' +
				'<li>下周进度计划安排</li>'

		$('._tab').html(tab_html)
	}


	if(showProj){
		$('.wrap_left').hide()

		$('.no_data').hide();
		$('.table_box').show();
		$('.wrap_right').css('margin-left',0)
	}

    $('#createYear').val(year||'')
    $('[name="createMonth"]').val(month||'')


	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});

	var objData = {}

	var _index = 0


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


	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','treeTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;
		var treeTable = layui.treeTable;

		// 获取数据字典数据
		var dictionaryObj = {
			SCHEDULE_INPORTANCE:{}
		}
		var dictionaryStr = 'SCHEDULE_INPORTANCE';
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

        if(showProj){
            $('#leftId').attr('projId', projectId);

            var para_ms = {}
            para_ms.projectId = $('#leftId').attr('projId')||''
            if($('#createYear').val()){
                para_ms.year = $('#createYear').val()
            }
            if($('[name="createMonth"]').val()){
                para_ms.month = $('[name="createMonth"]').val()
            }

			if(week){
				para_ms.reportType = 'week'
				if($('[name="createWeek"]').val()){
					para_ms.reportWeek = $('[name="createWeek"]').val()
					var arr = ($('[name="createWeek"]').val()).split('-W')
					para_ms.beginDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekStart
					para_ms.endDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekEnd
				}
			}

            var loadIndex = layer.load();
            $.get('/scheduleReport/scheduleAnalysis', para_ms, function (res) {
                layer.close(loadIndex);
				$('#createYear').val(res&&res.obj&&res.obj.year)
				$('[name="createMonth"]').val(res&&res.obj&&res.obj.month)
				$('[name="createWeek"]').val( res&&res.obj&&res.obj.year + '-W' + getWeek(new String(res&&res.obj&&res.obj.year) +'-'+ new String(res&&res.obj&&res.obj.month)+'-'+new String(res&&res.obj&&res.obj.day)))
				form.render();
                objData.data = res.obj
                tableShow(_index);
            });
        }


		laydate.render({
			elem: '#createYear'
			, trigger: 'click'//呼出事件改成click
			, type: 'year'
			// , format: 'yyyy-MM-dd'
		});

		element.on('tab(docDemoTabBrief)', function(data){
			_index = data.index
			tableShow(data.index);
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
				$('#h2_title').text(currentData.projName+'项目进度情况综合分析')
				$('.no_data').hide();
				$('.table_box').show();

				objData = {}

				var para_ms = {}
				para_ms.projectId = $('#leftId').attr('projId')||''
				if($('#createYear').val()){
					para_ms.year = $('#createYear').val()
				}
				if($('[name="createMonth"]').val()){
					para_ms.month = $('[name="createMonth"]').val()
				}

				if(week){
					para_ms.reportType = 'week'
					if($('[name="createWeek"]').val()){
						para_ms.reportWeek = $('[name="createWeek"]').val()
						var arr = ($('[name="createWeek"]').val()).split('-W')
						para_ms.beginDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekStart
						para_ms.endDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekEnd
					}
				}

				var loadIndex = layer.load();
				$.get('/scheduleReport/scheduleAnalysis', para_ms, function (res) {
					layer.close(loadIndex);
					objData.data = res.obj
					$('#createYear').val(res&&res.obj&&res.obj.year)
					$('[name="createMonth"]').val(res&&res.obj&&res.obj.month)
					$('[name="createWeek"]').val( res&&res.obj&&res.obj.year + '-W' + getWeek(new String(res&&res.obj&&res.obj.year) +'-'+ new String(res&&res.obj&&res.obj.month)+'-'+new String(res&&res.obj&&res.obj.day)))
					form.render();
					tableShow(_index);
				});
			} else {
				$('#h2_title').text('')
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		function table_Show() {
			if(objData.photoDetailsList){
				return
			}
			var data = objData.data

			$('[name="memo"]').val(data.scheduleObj&&data.scheduleObj.memo)
			$('[name="sheduleChangeMemo"]').val(data.scheduleObj&&data.scheduleObj.sheduleChangeMemo)
			$('[name="otherMemo"]').val(data.scheduleObj&&data.scheduleObj.otherMemo)
			//附件
			if (data&&data.scheduleObj&&data.scheduleObj.attachmentList && data.scheduleObj.attachmentList.length > 0) {
				var fileArr = data.scheduleObj.attachmentList;
				$('#fileContent').html(echoAttachment(fileArr));
			}
			$('.file_upload_box').hide()
			$('.deImgs').hide();
			objData.photoDetailsList = objData.data.photoDetailsList
			table.render({
				elem: '#securityTable',
				data: data&&data.photoDetailsList||[],
				// data:[],
				height: data&&data.detailsList&&data.detailsList.length>5?'full-500':false,
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
					$('.file_upload_box').hide()
					$('.deImgs').hide();
				}
			});
		}

		// 渲染表格
		//index 页签索引
		//refresh 是否刷新
		function tableShow(index) {
			if(!($('#leftId').attr('projId'))) return

            if(showProj){
                $('#h2_title').text((objData.data&&objData.data.projectName||'')+'项目进度情况综合分析')
            }

			var params = {}
			params.projectId = $('#leftId').attr('projId')||''
			params.projId = $('#leftId').attr('projId')||''
			params.delFlag = '0'
			// if($('#createYear').val()){
			// 	params.createYear = $('#createYear').val()
			// }
			// if($('[name="createMonth"]').val()){
			// 	params.createMonth = $('[name="createMonth"]').val()
			// }
			var loadIndex = layer.load();

			table_Show()

			if(!index){
				index = 0
			}
			if(index==0){//本月进度执行情况分析
				if(objData.docDemoTabBrief0_data){
					layer.close(loadIndex);
					return
				}
				if(objData.data&&objData.data.serchBeginDate){
					params.beginDate = objData.data.serchBeginDate
				}
				if(objData.data&&objData.data.serchEndDate){
					params.endDate = objData.data.serchEndDate
				}

				if(week){
					if($('[name="createWeek"]').val()){
						var arr = ($('[name="createWeek"]').val()).split('-W')
						params.beginDate = getDateOfISOWeek(arr[1],arr[0],-7,0).ISOweekStart
						params.endDate = getDateOfISOWeek(arr[1],arr[0],0,7).ISOweekEnd
					}
				}

				scheduleAnalysisIndex(params,index)
			} else if(index==1){//本月进度可视化分析
				if(objData.docDemoTabBrief1_data){
					layer.close(loadIndex);
					return
				}
				if(week){
					if($('[name="createWeek"]').val()){
						var arr = ($('[name="createWeek"]').val()).split('-W')
						objData.data.serchBeginDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekStart
						objData.data.serchEndDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekEnd
					}
				}
				visualTable(objData.data.serchBeginDate,objData.data.serchEndDate)
			} else if(index==2){//节点修编情况分析
				if(objData.docDemoTabBrief2_data){
					layer.close(loadIndex);
					return
				}
				if(week){
					if($('[name="createWeek"]').val()){
						var arr = ($('[name="createWeek"]').val()).split('-W')
						objData.data.serchBeginDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekStart
						objData.data.serchEndDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekEnd
					}
				}
				revisionFormTwoIndex(objData.data.serchBeginDate,objData.data.serchEndDate)
			}else if(index==3){//下月进度计划安排
				if(objData.docDemoTabBrief3_data){
					layer.close(loadIndex);
					return
				}
				if(objData.data&&objData.data.nextBeginDate){
					params.beginDate = objData.data.nextBeginDate
				}
				if(objData.data&&objData.data.nextEndDate){
					params.endDate = objData.data.nextEndDate
				}
				if(week){
					if($('[name="createWeek"]').val()){
						var arr = ($('[name="createWeek"]').val()).split('-W')
						params.beginDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekStart
						params.endDate = getDateOfISOWeek(arr[1],arr[0],0,14).ISOweekEnd
					}
				}
				scheduleAnalysisIndex(params,index)
			}
			layer.close(loadIndex);
		}


		//点击查询
		$('.searchData').click(function () {
			objData = {}
			var para_ms = {}
			para_ms.projectId = $('#leftId').attr('projId')||''
			if($('#createYear').val()){
				para_ms.year = $('#createYear').val()
			}
			if($('[name="createMonth"]').val()){
				para_ms.month = $('[name="createMonth"]').val()
			}

			if(week){
				para_ms.reportType = 'week'
				if($('[name="createWeek"]').val()){
					para_ms.reportWeek = $('[name="createWeek"]').val()
					var arr = ($('[name="createWeek"]').val()).split('-W')
					para_ms.beginDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekStart
					para_ms.endDate = getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekEnd
				}
			}

			var loadIndex = layer.load();
			$.get('/scheduleReport/scheduleAnalysis', para_ms, function (res) {
				layer.close(loadIndex);
				objData.data = res.obj
				tableShow(_index);
			});
		});

		//本月进度可视化分析
		function visualTable(beginDate,endDate) {
			var loadIndex = layer.load();

			var params = {}
			params.projectId = $('#leftId').attr('projId')||''

			//params.parentScheduleId = 0
			params.delFlag="0"
			params.dataFormStr='2,3'

			if(beginDate){
				params.beginDate=beginDate
			}
			if(endDate){
				params.endDate=endDate
			}


			$.ajax({
				url:'/scheduleAnalysis/visualTable2',
				type: 'post',
				data:params,
				dataType: 'json',
				// async:false,
				success:function(res){
					var tarbarObj = res.obj
					var docDemoTabBriefData = res.data

					objData['docDemoTabBrief'+_index+'_data'] = res.data

					$('#docDemoTabBrief1 thead').empty()

					//表头
					var _str = ''
					for(var i = 0;i<tarbarObj.length;i++){
						_str += '<th lay-data="{field:\''+tarbarObj[i].filed+'\',align:\'center\',minWidth:150}"  rowspan="2">'+tarbarObj[i].name+'</th>'
					}

					var trOne = '<tr>' + _str +
							'<th lay-data="{field:\'percentComplete\',align:\'center\',minWidth:150}">完成百分比</th>' +
							'<th lay-data="{field:\'scheduleEndDate\',align:\'center\',minWidth:150}">计划时间</th>' +
							'<th lay-data="{field:\'recordDate\',align:\'center\',minWidth:150}">实际时间</th>' +
							'<th lay-data="{field:\'disparityDate\',align:\'center\',minWidth:150}">进度偏差</th>' +
							'</tr>'

					$('#docDemoTabBrief1 thead').append(trOne)

					table.init('docDemoTabBrief1', { //转化静态表格
						//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
						data:docDemoTabBriefData,
						defaultToolbar: ['exports'],
						toolbar: '#toolbarDemoIn',
						height: 'full-150',
						limit:10000000,
						done:function(res,curr,count){
							for(var i=0;i<tarbarObj.length;i++){
								layuiRowspan(tarbarObj[i].filed,1);
							}
							//$("input:radio[name^='evaluating']").attr("disabled","disabled");
						}
					});

					layer.close(loadIndex);
				}
			});

			form.render()

		}

		//本月进度执行情况分析
		//下月进度计划安排
		function scheduleAnalysisIndex(params,_index) {
			var headerData = null
			var header = null
			var threeHeader = null


			var loadIndex = layer.load();
			$.ajax({
				url:'/scheduleAnalysis/analysis?dataFormStr=2,3',
				type: 'post',
				data:params,
				dataType: 'json',
				// async:false,
				success:function(res){
					year2Header = res.obj&&res.obj.headerData&&res.obj.headerData.year2Header
					header = res.obj&&res.obj.headerData&&res.obj.headerData.dayHeader
					threeHeader = res.obj&&res.obj.headerData&&res.obj.headerData.threeHeader

					if(!(year2Header&&header&&threeHeader)) {
						$('#duration'+_index).empty()
						layer.close(loadIndex);
						return
					}


					$('#duration'+_index).empty()

					var _tr = '<th lay-data="{field:\'scheduleName\',minWidth:300,templet:\'<div>{{d.scheduleName}}</div>\'}"  rowspan="3">进度名称</th>\n' +
							'<th lay-data="{field:\'planDuration\',align:\'center\',minWidth:90}"  rowspan="3">计划工期</th>\n' +
							'<th lay-data="{field:\'percentComplete\',align:\'center\',minWidth:100}"  rowspan="3">完成百分比</th>'

					//表头
					//
					var tr1 = ''
					for (var x = 0;x<year2Header.length;x++){
						tr1 += '<th lay-data="{field:\''+year2Header[x].name+'\',align:\'center\'}"  colspan="'+year2Header[x].colSpan+'">'+year2Header[x].name+'</th>'
					}
					$('#duration'+_index).append('<tr>'+_tr+tr1+'</tr>')

					//
					var tr2 = ''
					for (var y = 0;y<header.length;y++){
						tr2 += '<th lay-data="{field:\''+header[y].name+'\',align:\'center\',minWidth:50}"  colspan="'+header[y].colSpan+'">'+header[y].value+'</th>'
					}
					$('#duration'+_index).append('<tr>'+tr2+'</tr>')

					var tr3 = ''
					for (var z = 0;z<threeHeader.length;z++){
						tr3 += '<th lay-data="{field:\''+threeHeader[z].name+'\',align:\'center\'}"  colspan="'+threeHeader[z].colSpan+'">'+threeHeader[z].name+'</th>'
					}
					$('#duration'+_index).append('<tr>'+tr3+'</tr>')
				}
			});
			$.ajax({
				// url:'/scheduleAnalysis/analysisData?projectId='+projId,
				url:'/scheduleAnalysis/analysisData?dataFormStr=2,3',
				type: 'post',
				dataType: 'json',
				data:params,
				// async:false,
				success:function(res){
					headerData = res.data
					jsPlumbData = res.obj

					objData['docDemoTabBrief'+_index+'_data'] = res.data

					if(!(headerData&&jsPlumbData)) {
						$('#docDemoTabBrief'+_index).next().remove()
						layer.close(loadIndex);
						return
					}
					//数据
					var strSum='';
					var addd = 1;
					for(var i=0;i<headerData.length;i++){
						var dataObj=headerData[i]&&headerData[i].dayArr
						if(!dataObj){
							continue
						}
						var str='<td>'+headerData[i].scheduleName+'</td><td>'+headerData[i].planDuration+'</td><td>'+headerData[i].percentComplete+'</td>'
						var a1=[];
						for(var j=0;j<dataObj.length;j++){
							for(var k=0;k<dataObj[j]['data'].length;k++){
								if(!a1[k]){
									a1[k]=[]
								}
								if(dataObj[j]['data'][k]['partyMoney']==1){
									var dataId = dataObj[j]['data'][k]['dataId']||''
									a1[k].push('<div style="width: 106%;position: absolute;height: 2px;background-color:'+dataObj[j].color+';height:'+dataObj[j].crude+'px;margin-top: '+(8*j-14)+'px;" id="'+dataId+'"></div>');
								}else {
									if(dataObj[j]['data'][k]['imgFlag']){
										a1[k].push('<img style="width: 100%" src="/img/planother/diamond-two.png">');
									}
								}
							}
						}
						for(var n=0;n<a1.length;n++){
							var str2 = ''
							for(var m=0;m<a1[n].length;m++){
								str2 += a1[n][m]
							}
							str+='<td>'+str2+'</td>'
						}
						strSum+='<tr>'+str+'</tr>'
					}
					$('#docDemoTabBrief'+_index).find('tbody').empty()
					$('#docDemoTabBrief'+_index).find('tbody').append(strSum)

					table.init('docDemoTabBrief'+_index, { //转化静态表格
						//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
						data:headerData,
						height: 'full-150',
						// toolbar: '#toolbarDemo',
						// defaultToolbar: [''],
						limit:10000000,
						done:function(res,curr,count){
							if(week){
								if($('[name="createWeek"]').val()){
									var arr = ($('[name="createWeek"]').val()).split('-W')

									if(_index==0){
										var arrWeek = [
											getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],1,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],2,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],3,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],4,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],5,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],0,0).ISOweekEnd
										]
										arrWeek.forEach(function(item){
											$('#docDemoTabBrief0').next().find('.layui-table-header [data-field="partyMoney'+item+'"] span').css('color','red')
										})
									}else if(_index==3){
										var arrWeek = [
											getDateOfISOWeek(arr[1],arr[0],7,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],1+7,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],2+7,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],3+7,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],4+7,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],5+7,0).ISOweekStart,
											getDateOfISOWeek(arr[1],arr[0],0,7).ISOweekEnd
										]
										arrWeek.forEach(function(item){
											$('#docDemoTabBrief3').next().find('.layui-table-header [data-field="partyMoney'+item+'"] span').css('color','red')
										})
									}

								}
							}


							//$("input:radio[name^='evaluating']").attr("disabled","disabled");
							$('tbody [data-field="scheduleName"] div').on('mouseenter', function(){
								var content = $(this).text();
								if(!content){
									return false
								}
								content = $(this).text().trim()

								this.index = layer.tips('<div style="padding: 10px; font-size: 14px; color: #eee;">'+ content + '</div>', this, {
									time: -1
									,maxWidth: 280
									,tips: [3, '#3A3D49']
								});
							}).on('mouseleave', function(){
								layer.close(this.index);
							});

							$('#duration'+_index).next().empty()

							$('._one .layui-table-body').attr('id','diagramContainer')

							/*jsPlumbData.forEach(function(item){
								jsPlumb.ready(function () {
									jsPlumb.setContainer('diagramContainer')
									jsPlumb.connect({
										source: item[0],
										target: item[1],
										endpoint: 'Dot',
										connector: ['Flowchart'],
										anchor: ['Right', 'Top'],
										endpointStyle: { fill: 'transparent', outlineWidth: 2 },
										overlays: [ ['Arrow', { width: 12, length: 12, location: 0.5 }] ]
									})
								})
								jsPlumb.importDefaults({
									ConnectionsDetachable: false
								})
							})*/

						}
					});

					form.render()


					layer.close(loadIndex);
				}
			});

		}

		//节点修编情况分析
		function revisionFormTwoIndex(beginDate,endDate) {
			var searchObj = {}
			searchObj.projId = $('#leftId').attr('projId')||''
			searchObj.projectId = $('#leftId').attr('projId')||''
			searchObj.delFlag = "0";

			if(beginDate){
				searchObj.beginDate=beginDate
			}
			if(endDate){
				searchObj.endDate=endDate
			}

			treeTable.render({
				elem: '#tableIns',
				url: '/revisionFormTwo/select?dataType=2&dataForm=2',
				where: searchObj,
				height: 'full-150',
				tree: {
					iconIndex: 1,
					idName: 'scheduleId',
					childName: "child"
				},
				cols: [[
					{field: 'documentNo', title: '编号', minWidth: 150},
					{field: 'scheduleName', title: '任务名称', minWidth: 100},
					{field: 'importanceLevel', title: '重要性',minWidth: 120,templet: function (d) {
							if(d.importanceLevel) {
								return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
							}else {
								return ''
							}
						}},
                    {field:'oldScheduleBeginDate',title:'初始进度计划开始时间',minWidth: 150},
                    {field: 'oldScheduleEndDate', title: '初始进度计划完成时间', minWidth: 150},
					{field:'scheduleBeginDate',title:'最新进度计划开始时间',minWidth: 150},
					{field: 'scheduleEndDate', title: '最新进度计划完成时间', minWidth: 150},
					// {field: 'scheduleDuration', title: '持续时间',minWidth: 110},
					// {field:'beforeSchedule',title:'紧前任务',minWidth: 110,templet: function (d) {
					// 		return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
					// 	}},
					// {field: 'nodeScheduleName', title: '节点计划',minWidth: 110},
					{field: 'scheduleUserName', title: '责任人',minWidth: 120},
					{field: 'supervisorUserName', title: '监督人',minWidth: 120},
					// {field: 'revisionTime', title: '修编时间',minWidth: 120},
					// {field: 'revisionUserName', title: '修编人',minWidth: 120},
				]],
				done:function(res){
					objData['docDemoTabBrief'+_index+'_data'] = res
				}
			});

		}

		// 本月进度执行情况分析 刷新
		table.on('toolbar(docDemoTabBrief0)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.docDemoTabBrief0_data = ''
				tableShow(0)
			}
		})
		// 本月进度可视化分析 刷新
		table.on('toolbar(docDemoTabBrief1)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.docDemoTabBrief1_data = ''
				tableShow(1)
			}
		})
		// 节点修编情况分析 刷新
		table.on('toolbar(docDemoTabBrief2)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.docDemoTabBrief2_data = ''
				tableShow(2)
			}
		})

		//下月进度计划安排 刷新
		table.on('toolbar(docDemoTabBrief3)', function (obj) {
			var layEvent = obj.event;
			if(layEvent === 'refresh'){
				objData.docDemoTabBrief3_data = ''
				tableShow(3)
			}
		})

	});

	var execRowspan = function(fieldName,index,flag){
		// 1为不冻结的情况，左侧列为冻结的情况
		let fixedNode = index=="1"?$("._two .layui-table-body")[index - 1]:(index=="3"?$("._two .layui-table-fixed-r"):$("._two .layui-table-fixed-l"));
		// 左侧导航栏不冻结的情况
		let child = $(fixedNode).find("td");
		let childFilterArr = [];
		// 获取data-field属性为fieldName的td
		for(let i = 0; i < child.length; i++){
			if(child[i].getAttribute("data-field") == fieldName){
				childFilterArr.push(child[i]);
			}
		}
		// 获取td的个数和种类
		let childFilterTextObj = {};
		for(let i = 0; i < childFilterArr.length; i++){
			let childText = flag?childFilterArr[i].innerHTML:childFilterArr[i].textContent;
			if(childFilterTextObj[childText] == undefined){
				childFilterTextObj[childText] = 1;
			}else{
				let num = childFilterTextObj[childText];
				childFilterTextObj[childText] = num*1 + 1;
			}
		}
		let canRowspan = true;
		let maxNum;//以前列单元格为基础获取的最大合并数
		let finalNextIndex;//获取其下第一个不合并单元格的index
		let finalNextKey;//获取其下第一个不合并单元格的值
		for(let i = 0; i < childFilterArr.length; i++){
			(maxNum>9000||!maxNum)&&(maxNum = $(childFilterArr[i]).prev().attr("rowspan")&&fieldName!="8"?$(childFilterArr[i]).prev().attr("rowspan"):9999);
			let key = flag?childFilterArr[i].innerHTML:childFilterArr[i].textContent;//获取下一个单元格的值
			let nextIndex = i+1;
			let tdNum = childFilterTextObj[key];
			let curNum = maxNum<tdNum?maxNum:tdNum;
			if(canRowspan){
				for(let j =1;j<=curNum&&(i+j<childFilterArr.length);){//循环获取最终合并数及finalNext的index和key
					finalNextKey = flag?childFilterArr[i+j].innerHTML:childFilterArr[i+j].textContent;
					finalNextIndex = i+j;
					if((key!=finalNextKey&&curNum>1)||maxNum == j){
						canRowspan = true;
						curNum = j;
						break;
					}
					j++;
					if((i+j)==childFilterArr.length){
						finalNextKey=undefined;
						finalNextIndex=i+j;
						break;
					}
				}
				childFilterArr[i].setAttribute("rowspan",curNum);
				if($(childFilterArr[i]).find("div.rowspan").length>0){//设置td内的div.rowspan高度适应合并后的高度
					$(childFilterArr[i]).find("div.rowspan").parent("div.layui-table-cell").addClass("rowspanParent");
					$(childFilterArr[i]).find("div.layui-table-cell")[0].style.height= curNum*38-10 +"px";
				}
				canRowspan = false;
			}else{
				childFilterArr[i].style.display = "none";
			}
			if(--childFilterTextObj[key]==0|--maxNum==0|--curNum==0|(finalNextKey!=undefined&&nextIndex==finalNextIndex)){//||(finalNextKey!=undefined&&key!=finalNextKey)
				canRowspan = true;
			}
		}
	}
	//合并数据表格行
	var layuiRowspan = function(fieldNameTmp,index,flag){
		let fieldName = [];
		if(typeof fieldNameTmp == "string"){
			fieldName.push(fieldNameTmp);
		}else{
			fieldName = fieldName.concat(fieldNameTmp);
		}
		for(let i = 0;i<fieldName.length;i++){
			execRowspan(fieldName[i],index,flag);
		}
	}

	//JS 获取指定日期在当年的第几周
	function getWeek(dt){
		let d1 = new Date(dt);
		let d2 = new Date(dt);
		d2.setMonth(0);
		d2.setDate(1);
		let rq = d1-d2;
		let days = Math.ceil(rq/(24*60*60*1000));
		let num = Math.ceil(days/7);
		if(num<10){
			num = '0'+num
		}
		return num;
	}


	//JS 获取指定周年，返回当前周的周一和周日的日期
	//w 周
	//y 年
	//b 周一的日期推迟多少天
	//a 周日的日期推迟多少天
	function getDateOfISOWeek(w, y,b,a) {
		var simple = new Date(y, 0, 1 + (w - 1) * 7);
		var dow = simple.getDay();
		var ISOweekStart = simple;
		if (dow <= 4)
			ISOweekStart.setDate(simple.getDate() - simple.getDay() + 1);
		else
			ISOweekStart.setDate(simple.getDate() + 8 - simple.getDay());
		console.log(ISOweekStart.getFullYear())
		console.log(ISOweekStart.getMonth() + 1)
		console.log(ISOweekStart.getDate())

		ISOweekStart = ISOweekStart.getTime()+1000*60*60*24*b
		ISOweekStart = new Date(ISOweekStart)
		var ISOweekEnd = ISOweekStart.getTime()+1000*60*60*24*(6+a)
		ISOweekEnd = new Date(ISOweekEnd)

		return {
			ISOweekStart:format(ISOweekStart),
			ISOweekEnd:format(ISOweekEnd)
		}
	}

	function format(data,format) {
		if(!data){
			data = new Date();
		}
		if(!format){
			format = '-'
		}
		var  nstr = "";
		// var now = new Date();
		var nyear = data.getFullYear();
		var nmonth = data.getMonth()+1;
		var nday = data.getDate();
		if(nmonth<10){
			nmonth = "0"+nmonth;
		}
		if(nday<10){
			nday = "0"+nday;
		}
		nstr = nyear+format+nmonth+format+nday;
		return nstr;
	}

</script>
</body>
</html>
