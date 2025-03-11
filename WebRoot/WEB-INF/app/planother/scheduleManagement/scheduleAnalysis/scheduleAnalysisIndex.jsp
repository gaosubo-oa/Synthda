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
	<title>进度报表</title>

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

	<script src="/js/planother/jsplumb.min.js?202201050935"></script>

	<style>
		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
		}

		body {
			position: relative;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;
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

		.layui-table-grid-down{
			display: none;
			opacity: 0;
		}
		.transparent_class {
			filter:alpha(opacity=0);
			-moz-opacity:0;
			-khtml-opacity: 0;
			opacity: 0;
		}

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

        svg{
            display: none;
        }

	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">进度报表</h2>
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
			<div class="query_module layui-form" style="position: relative;">
				<div class="layui-row" >
					<div class="layui-col-xs1" style="margin-left: 15px;">
						<input type="text" name="beginDate"  placeholder="开始时间" autocomplete="off" class="layui-input">
					</div>
					<div class="layui-col-xs1" style="margin-left: 15px;">
						<input type="text" name="endDate"  placeholder="结束时间"  autocomplete="off" class="layui-input">
					</div>
					<div class="layui-col-xs1" style="text-align: center">
						<button type="button" id="myBtn" class="layui-btn layui-btn-disabled searchData" style="height: 35px">查询</button>
						<%--                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
					</div>
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
					<div class="layui-col-xs1" style="margin-top: 3px;text-align: center;width: 5%;float: right">
						<i class="layui-icon layui-icon-screen-full screen-full" title="全屏" style="font-size: 33px;cursor: pointer;"></i>
					</div>
					<%--<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
						<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
						<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
					</div>--%>
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
			</div>

			<div style="position: relative;margin-top: -10px;">
				<div class="table_box _one" style="display: none;position: relative;">
<%--					<table id="tableDemo" lay-filter="tableDemo"></table>--%>
					  <table class="layui-table" id="docDemoTabBrief3" lay-filter="docDemoTabBrief3" cellspacing="0" cellpadding="0">
						 <thead id="duration">
<%--						     <tr>--%>
<%--	                               <th lay-data="{type:'numbers',align:'center'}"  rowspan="3">编号</th>--%>
<%--								<th lay-data="{field:'scheduleName',align:'center'}"  rowspan="3">进度名称</th>--%>
<%--								<th lay-data="{field:'planDuration',align:'center'}"  rowspan="3">计划工期</th>--%>
<%--								<th lay-data="{field:'percentComplete',align:'center'}"  rowspan="3">已完成百分比</th>--%>
<%--								<th lay-data="{field:'partyMoney',align:'center',width:50}"  colspan="30">2021-02</th>--%>
<%--	                               <th lay-data="{field:'ganizationLife',align:'center',width:100}"  colspan="4">2</th>--%>
<%--	                               <th lay-data="{field:'pioneerModel',align:'center',width:100}"  colspan="4">3</th>--%>
<%--	                               <th lay-data="{field:'styleRecognition',align:'center',width:100}"  colspan="4">4</th>--%>
<%--	                               <th lay-data="{field:'observeParty',align:'center',width:100}"  colspan="4">5</th>--%>
<%--	                               <th lay-data="{field:'completeTask',align:'center',width:100}"  colspan="4">6</th>--%>
<%--	                               <th lay-data="{field:'overallEvaluation',align:'center',width:100}"  colspan="4">7</th>--%>
<%--	                         </tr>--%>
<%--	                         <tr class="vertical-text">--%>
<%--	                             <th lay-data="{field:'partyMoney1',align:'center',minWidth:50}"  colspan="1">1</th>--%>
<%--	                             <th lay-data="{field:'partyMoney2',align:'center',minWidth:50}"  colspan="1">2</th>--%>
<%--	                             <th lay-data="{field:'partyMoney3',align:'center',minWidth:50}"  colspan="1">3</th>--%>
<%--	                             <th lay-data="{field:'partyMoney4',align:'center',minWidth:50}"  colspan="1">4</th>--%>
<%--	                             <th lay-data="{field:'partyMoney5',align:'center',minWidth:50}"  colspan="1">5</th>--%>
<%--	                             <th lay-data="{field:'partyMoney6',align:'center',minWidth:50}"  colspan="1">6</th>--%>
<%--	                             <th lay-data="{field:'partyMoney7',align:'center',minWidth:50}"  colspan="1">7</th>--%>
<%--	                             <th lay-data="{field:'partyMoney8',align:'center',minWidth:50}"  colspan="1">8</th>--%>
<%--	                             <th lay-data="{field:'partyMoney9',align:'center',minWidth:50}"  colspan="1">9</th>--%>
<%--	                             <th lay-data="{field:'partyMoney10',align:'center',minWidth:50}"  colspan="1">10</th>--%>
<%--	                             <th lay-data="{field:'partyMoney11',align:'center',minWidth:50}"  colspan="1">11</th>--%>
<%--	                             <th lay-data="{field:'partyMoney12',align:'center',minWidth:50}"  colspan="1">12</th>--%>
<%--	                             <th lay-data="{field:'partyMoney13',align:'center',minWidth:50}"  colspan="1">13</th>--%>
<%--	                             <th lay-data="{field:'partyMoney14',align:'center',minWidth:50}"  colspan="1">14</th>--%>
<%--	                             <th lay-data="{field:'partyMoney15',align:'center',minWidth:50}"  colspan="1">15</th>--%>
<%--	                             <th lay-data="{field:'partyMoney16',align:'center',minWidth:50}"  colspan="1">16</th>--%>
<%--	                             <th lay-data="{field:'partyMoney17',align:'center',minWidth:50}"  colspan="1">17</th>--%>
<%--	                             <th lay-data="{field:'partyMoney18',align:'center',minWidth:50}"  colspan="1">18</th>--%>
<%--	                             <th lay-data="{field:'partyMoney19',align:'center',minWidth:50}"  colspan="1">19</th>--%>
<%--	                             <th lay-data="{field:'partyMoney20',align:'center',minWidth:50}"  colspan="1">20</th>--%>
<%--	                             <th lay-data="{field:'partyMoney21',align:'center',minWidth:50}"  colspan="1">21</th>--%>
<%--	                             <th lay-data="{field:'partyMoney22',align:'center',minWidth:50}"  colspan="1">22</th>--%>
<%--	                             <th lay-data="{field:'partyMoney23',align:'center',minWidth:50}"  colspan="1">23</th>--%>
<%--	                             <th lay-data="{field:'partyMoney24',align:'center',minWidth:50}"  colspan="1">24</th>--%>
<%--	                             <th lay-data="{field:'partyMoney25',align:'center',minWidth:50}"  colspan="1">25</th>--%>
<%--	                             <th lay-data="{field:'partyMoney26',align:'center',minWidth:50}"  colspan="1">26</th>--%>
<%--	                             <th lay-data="{field:'partyMoney27',align:'center',minWidth:50}"  colspan="1">27</th>--%>
<%--						     </tr>--%>
<%--	                      	 <tr class="vertical-text">--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">3</th>--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">6</th>--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">9</th>--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">12</th>--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">15</th>--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">18</th>--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">21</th>--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">24</th>--%>
<%--	                             <th lay-data="{field:'partyMoney',align:'center',minWidth:50}"  colspan="3">27</th>--%>
<%--							 </tr>--%>
	                     </thead>
						  <tbody>

						  </tbody>
	                 </table>
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
	<div class="layui-row" style="position: relative">
		<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
			<div style="width: 50px;height: 20px;background-color:#B5B5B5;float:left;"></div>
			计划时间
		</div>
	</div>
</script>

<script>

	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});

	$('[name="beginDate"]').val(getMonthBeforeFormatAndDay(0,'-',1))
	$('[name="endDate"]').val(getMonthBeforeFormatAndDay(2,'-',1))

	var tableIns = null;
	var timer = null



	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer','soulTable'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;
		var soulTable = layui.soulTable;

		var animateFlag = true
		$(".screen-full").click(function(){
			$(".wrap_left").animate({
				width:'toggle'
			});
			$(".wrap_right").animate({
				marginLeft:'0'
			},function(){
				// $('.searchData').click()
				tableShow2()
			});
			if(animateFlag){
				$(this).removeClass("layui-icon-screen-full").addClass('layui-icon-screen-restore').attr('title','退出全屏');

			}else {
				$(this).removeClass("layui-icon-screen-restore").addClass('layui-icon-screen-full').attr('title','全屏');
			}

			animateFlag = !animateFlag
		});

		form.render();

		laydate.render({
			elem: '[name="beginDate"]'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			// ,value: new Date()
		});

		laydate.render({
			elem: '[name="endDate"]'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});



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
				$('.no_data').hide();
				$('.table_box').show();
				$('#myBtn').removeClass('layui-btn-disabled')
				tableShow(currentData.projId);
				// if($('[name="beginDate"]').val()&&$('[name="endDate"]').val()){
				// 	tableShow(currentData.projId);
				// }else {
				// 	layer.msg('请填写开始时间和结束时间！', {icon: 0});
				// }
			} else {
				$('.table_box').hide();
				$('.no_data').show();
                $('#myBtn').addClass('layui-btn-disabled')
			}
		});

		form.on('switch(test1)', function(data){
			console.log(data.elem.checked); //开关是否开启，true或者false
		});
		form.on('switch(test2)', function(data){
			console.log(data.elem.checked); //开关是否开启，true或者false
		});
		form.on('switch(test3)', function(data){
			console.log(data.elem.checked); //开关是否开启，true或者false
		});
		form.on('switch(test4)', function(data){
			console.log(data.elem.checked); //开关是否开启，true或者false
		});
		form.on('switch(test5)', function(data){
			console.log(data.elem.checked); //开关是否开启，true或者false
		});
        form.on('switch(test6)', function(data){
            console.log(data.elem.checked); //开关是否开启，true或者false
            if(data.elem.checked){
                $('svg').show()
            }else {
                $('svg').hide()
            }
        });

		var headerData = null
		var jsPlumbData = null
		// 渲染表格
		function tableShow(projId) {
			var header = null
			var threeHeader = null

			var parmasStr = ''
			if($('[name="beginDate"]').val()){
				parmasStr += '&beginDate=' + $('[name="beginDate"]').val()
			}else {
				layer.msg('请填写结束时间！', {icon: 0});
				return
			}
			if($('[name="endDate"]').val()){
				parmasStr += '&endDate=' + $('[name="endDate"]').val()
			}else {
				layer.msg('请填写结束时间！', {icon: 0});
				return;
			}



			var loadIndex = layer.load();
			$.ajax({
				url:'/scheduleAnalysis/analysis?dataFormStr=2,3&delFlag=0&projectId='+projId+parmasStr,
				type: 'post',
				dataType: 'json',
				// async:false,
				success:function(res){
					year2Header = res.obj&&res.obj.headerData&&res.obj.headerData.year2Header
					header = res.obj&&res.obj.headerData&&res.obj.headerData.dayHeader
					threeHeader = res.obj&&res.obj.headerData&&res.obj.headerData.threeHeader

					if(!(year2Header&&header&&threeHeader)) {
						layer.close(loadIndex);
						return
					}


					$('#duration').empty()

					var _tr = '<th lay-data="{field:\'scheduleName\',minWidth:150,templet:\'<div>{{d.scheduleName}}</div>\'}"  rowspan="3">进度名称</th>\n' +
							'<th lay-data="{field:\'planDuration\',align:\'center\',minWidth:90}"  rowspan="3">计划工期</th>\n' +
							'<th lay-data="{field:\'percentComplete\',align:\'center\',minWidth:100}"  rowspan="3">完成百分比</th>'

					//表头
					//
					var tr1 = ''
					for (var x = 0;x<year2Header.length;x++){
						tr1 += '<th lay-data="{field:\''+year2Header[x].name+'\',align:\'center\'}"  colspan="'+year2Header[x].colSpan+'">'+year2Header[x].name+'</th>'
					}
					$('#duration').append('<tr>'+_tr+tr1+'</tr>')

					//
					var tr2 = ''
					for (var y = 0;y<header.length;y++){
						tr2 += '<th lay-data="{field:\''+header[y].name+'\',align:\'center\',minWidth:50}"  colspan="'+header[y].colSpan+'">'+header[y].value+'</th>'
					}
					$('#duration').append('<tr>'+tr2+'</tr>')

					var tr3 = ''
					for (var z = 0;z<threeHeader.length;z++){
						tr3 += '<th lay-data="{field:\''+threeHeader[z].name+'\',align:\'center\'}"  colspan="'+threeHeader[z].colSpan+'">'+threeHeader[z].name+'</th>'
					}
					$('#duration').append('<tr>'+tr3+'</tr>')
				}
			});
            $.ajax({
                // url:'/scheduleAnalysis/analysisData?projectId='+projId,
				url:'/scheduleAnalysis/analysisData?dataFormStr=2,3&projectId='+projId+parmasStr+"&delFlag=0",
				type: 'post',
                dataType: 'json',
				// async:false,
                success:function(res){
					headerData = res.data
					jsPlumbData = res.obj

					if(!(headerData&&jsPlumbData)) {
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
									a1[k].push('<div style="width: 21px;position: absolute;height: 2px;background-color:'+dataObj[j].color+';height:'+dataObj[j].crude+'px;margin-top: '+(8*j-14)+'px;" id="'+dataId+'"></div>');
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
					$('#docDemoTabBrief3').find('tbody').empty()
					$('#docDemoTabBrief3').find('tbody').append(strSum)

					table.init('docDemoTabBrief3', { //转化静态表格
						//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
						data:headerData,
						height: 'full-150',
						// toolbar: '#toolbarDemo',
						// defaultToolbar: [''],
						limit:10000000,
						// page:true,
						// parseData: function(res){ //res 即为原始返回的数据
						// 	return {
						// 		"code": 0, //解析接口状态
						// 		"msg": res.msg, //解析提示文本
						// 		//"count": res.totleNum, //解析数据长度
						// 		//后端没返,这样写肯出问题
						// 		"count": res.obj.length,
						// 		"data": res.obj, //解析数据列表
						// 	};
						// },
						done:function(res,curr,count){
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

							$('#duration').next().empty()

							$('._one .layui-table-body').attr('id','diagramContainer')

							jsPlumbData.forEach(function(item){
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
							})

						}
					});

					form.render()


					layer.close(loadIndex);
                }
            });

		}

		function tableShow2(){
			var loadIndex = layer.load();
			table.init('docDemoTabBrief3', { //转化静态表格
				data:headerData,
				height: 'full-150',
				limit:10000000,
				done:function(res,curr,count){
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

					$('#duration').next().empty()

					$('._one .layui-table-body').attr('id','diagramContainer')

					jsPlumbData.forEach(function(item){
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
					})

				}
			});

			form.render()
			layer.close(loadIndex);
		}

		// function newOrEdit(){
		// 	layer.open({
		// 		type: 1,
		// 		title: '请选择日期间隔',
		// 		area: ['50%', '50%'],
		// 		btn: ['确定'],
		// 		btnAlign: 'c',
		// 		content: '<div class="layui-form layui-row" style="width: 50%;margin: 50px auto">\n' +
		// 				'<input type="text" name="begin_Date" placeholder="开始时间" autocomplete="off" class="layui-input">\n' +
		// 				'<input type="text" name="end_Date"  placeholder="结束时间"  autocomplete="off" class="layui-input">\n' +
		// 				'</div>',
		// 		success: function () {
		// 			laydate.render({
		// 				elem: '[name="begin_Date"]'
		// 				, trigger: 'click'
		// 				, format: 'yyyy-MM-dd'
		// 				// , format: 'yyyy-MM-dd HH:mm:ss'
		// 				//,value: new Date()
		// 			});
		//
		// 			laydate.render({
		// 				elem: '[name="end_Date"]'
		// 				, trigger: 'click'
		// 				, format: 'yyyy-MM-dd'
		// 				// , format: 'yyyy-MM-dd HH:mm:ss'
		// 				//,value: new Date()
		// 			});
		//
		// 			form.render();
		// 		},
		// 		yes: function (index) {
		// 			$('[name="beginDate"]').val($('[name="begin_Date"]').val())
		// 			$('[name="endDate"]').val($('[name="end_Date"]').val())
		// 			layer.close(index);
		//
		// 		},
		// 		end:function(){
		// 			tableShow($('#leftId').attr('projId'))
		// 		}
		// 	});
		// }



		//点击查询
		$('.searchData').click(function () {
		    if($('#myBtn').attr('class').indexOf('layui-btn-disabled')<0){
                tableShow($('#leftId').attr('projId'))
            }

			// var searchParams = {}
			// var $seachData = $('.query_module [name]')
			// $seachData.each(function () {
			// 	searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
			// 	// 将查询值保存至cookie中
			// 	// $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
			// })
			// tableIns.reload({
			// 	where: searchParams,
			// 	page: {
			// 		curr: 1 //重新从第 1 页开始
			// 	}
			// });
		});

	});


	//求自然月日期
	function getMonthBeforeFormatAndDay(num, format, day) {
		var date = new Date();
		date.setMonth(date.getMonth() + (num*1), 1);
		//读取日期自动会减一，所以要加一
		var mo = date.getMonth() + 1;
		//小月
		if (mo == 4 || mo == 6 || mo == 9 || mo == 11) {
			if (day > 30) {
				day = 30
			}
		}
		//2月
		else if (mo == 2) {
			if (isLeapYear(date.getFullYear())) {
				if (day > 29) {
					day = 29
				} else {
					day = 28
				}
			}
			if (day > 28) {
				day = 28
			}
		}
		//大月
		else {
			if (day > 31) {
				day = 31
			}
		}

		if(day>0&&day<10){
			day = '0'+day
		}

		retureValue = date.format('yyyy' + format + 'MM' + format + day);

		return retureValue;
	}

	//JS判断闰年代码
	function isLeapYear(Year) {
		if (((Year % 4) == 0) && ((Year % 100) != 0) || ((Year % 400) == 0)) {
			return (true);
		} else { return (false); }
	}

	//日期格式化
	Date.prototype.format = function (format) {
		var o = {
			"M+": this.getMonth() + 1, // month
			"d+": this.getDate(), // day
			"h+": this.getHours(), // hour
			"m+": this.getMinutes(), // minute
			"s+": this.getSeconds(), // second
			"q+": Math.floor((this.getMonth() + 3) / 3), // quarter
			"S": this.getMilliseconds()
			// millisecond
		}

		if (/(y+)/.test(format))
			format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		for (var k in o)
			if (new RegExp("(" + k + ")").test(format))
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		return format;
	}

</script>
</body>
</html>
