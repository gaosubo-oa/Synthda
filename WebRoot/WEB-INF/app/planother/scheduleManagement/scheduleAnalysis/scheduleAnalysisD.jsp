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
	<title>进度可视化</title>

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
	<script type="text/javascript" src="/js/planbudget/projectCostAnalysis.js?1202108301508"></script>

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
			<h2 style="text-align: center;line-height: 35px;">进度可视化</h2>
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
					<input type="text" name="beginDate" id="beginDate" placeholder="开始时间" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-left: 15px;">
					<input type="text" name="endDate" id="endDate"  placeholder="结束时间"  autocomplete="off" class="layui-input">
				</div>
				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
					<%-- <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
				</div>
				<div class="layui-col-xs1" style="margin-top: 3px;text-align: center;width: 5%;float: right">
					<i class="layui-icon layui-icon-screen-full screen-full" title="全屏" style="font-size: 33px;cursor: pointer;"></i>
				</div>
				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box" style="position: relative;display: none">

					<table class="layui-table" id="docDemoTabBrief" lay-filter="docDemoTabBrief" cellspacing="0" cellpadding="0">
						<thead>
<%--						<tr>--%>
<%--							<th lay-data="{field:'username', width:150}" rowspan="2">检查项</th>--%>
<%--							<th lay-data="{align:'center'}" colspan="3">检查人</th>--%>
<%--							<th lay-data="{field:'amount', width:120}" rowspan="2">汇总统计</th>--%>
<%--						</tr>--%>
<%--						<tr>--%>
<%--							<th lay-data="{field:'province', width:120}">张三</th>--%>
<%--							<th lay-data="{field:'city', width:120}">李四</th>--%>
<%--							<th lay-data="{field:'zone', width:200}">王五</th>--%>
<%--						</tr>--%>
						</thead>
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


<script>

	var tipIndex = null;
	$('.icon_img').hover(function () {
		var tip = $(this).attr('text')
		tipIndex = layer.tips(tip, this)
	}, function () {
		layer.close(tipIndex)
	});

	var tarbarObj = null
	var docDemoTabBriefData = null
	var tarbarObj2 = null
	var docDemoTabBriefData2 = null

	var tableIns = null;
	var tableIns2 = null;

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

	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;

		laydate.render({
			elem: '#beginDate'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
		});

		laydate.render({
			elem: '#endDate'
			, trigger: 'click'
			, format: 'yyyy-MM-dd'
			// , format: 'yyyy-MM-dd HH:mm:ss'
			//,value: new Date()
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
				$('.no_data').hide();
				$('.table_box').show();
				tableShow();
			} else {
				$('.table_box').hide();
				$('.no_data').show();
			}
		});


		// 渲染表格
		function tableShow() {
			var loadIndex = layer.load();

			var params = {}
			params.projectId = $('#leftId').attr('projId')||''
			params.parentScheduleId = 0
			if($('#beginDate').val()){
				params.beginDate = $('#beginDate').val()
			}
			if($('#endDate').val()){
				params.endDate = $('#endDate').val()
			}
			params.delFlag="0"
			params.dataFormStr="2,3"
			$.ajax({
				url:'/scheduleAnalysis/analysisD',
				type: 'post',
				data:params,
				dataType: 'json',
				// async:false,
				success:function(res){
					tarbarObj = res.obj
					docDemoTabBriefData = res.data

					$('#docDemoTabBrief thead').empty()

					//表头
					var _str = ''
					for(var i = 0;i<tarbarObj.length;i++){
						_str += '<th lay-data="{field:\''+tarbarObj[i].filed+'\',align:\'center\',minWidth:150}"  rowspan="2">'+tarbarObj[i].name+'</th>'
					}

					var trOne = '<tr>' + _str +
							// '<th lay-data="{field:\'scheduleName\',align:\'center\',minWidth:150}"  rowspan="2">子工序</th>\n' +
							'<th lay-data="{field:\'one1\',align:\'center\',minWidth:150}"  colspan="4">进度计划推演</th>' +
							'<th lay-data="{field:\'one2\',align:\'center\',minWidth:150}"  colspan="4">进度跟踪判断</th>' +
							'<th lay-data="{field:\'one3\',align:\'center\',minWidth:150}"  rowspan="2">备注</th>' +
							'</tr>' +
							'<tr>' +
							'<th lay-data="{field:\'scheduleBeginDate\',align:\'center\',minWidth:150}" >计划开始时间</th>\n' +
							'<th lay-data="{field:\'scheduleDuration\',align:\'center\',minWidth:150}"  >单工序持续时间</th>' +
							'<th lay-data="{field:\'duration\',align:\'center\',minWidth:150}" >节点累计持续天数</th>' +
							'<th lay-data="{field:\'scheduleEndDate\',align:\'center\',minWidth:150}">节点计划完成绝对时间</th>' +
							'<th lay-data="{field:\'recordDate\',align:\'center\',minWidth:150}">实际开始时间</th>\n' +
							'<th lay-data="{field:\'scheduleCurrDuration\',align:\'center\',minWidth:150}">单工序实际持续时间</th>' +
							'<th lay-data="{field:\'currDuration\',align:\'center\',minWidth:150}">节点累计持续天数</th>' +
							'<th lay-data="{field:\'scheduleCurrEndDate\',align:\'center\',minWidth:150}">节点计划完成绝对时间</th>' +
							'</tr>'

					$('#docDemoTabBrief thead').append(trOne)

					table.init('docDemoTabBrief', { //转化静态表格
						//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
						data:docDemoTabBriefData,
						height: 'full-100',
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


		//点击查询
		$('.searchData').click(function () {
			tableShow()
		});

	});
</script>
</body>
</html>
