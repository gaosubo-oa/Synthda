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
	<title>质量管理统计分析报表</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script src="../js/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
	<script type="text/javascript" src="/js/planother/echarts.min.js?1202108091508"></script>

	<script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>

	

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

	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">质量管理统计分析报表</h2>
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
				<div class="layui-col-xs3">
					<div class="layui-form-item" style="/*width: 25%;*/margin: 10px -30px 10px;">
						<label class="layui-form-label" style="width: 25%;">年度</label>
						<div class="layui-input-inline" style="width: 55%;">
							<select id="superviseType"></select>
						</div>
					</div>
				</div>
<%--				<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">--%>
<%--					<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>--%>
<%--					&lt;%&ndash;                    <button type="button" class="layui-btn layui-btn-sm">高级查询</button>&ndash;%&gt;--%>
<%--				</div>--%>
				<div style="position: absolute;top: -1px;right: 10px;height: 35px;line-height: 35px;">
					<i class="layui-icon layui-icon-read icon_img" style="margin-right: 15px" text="知识库"></i>
					<i class="layui-icon layui-icon-survey icon_img" text="帮助"></i>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box">
					<div id="main" style="width: 90%;height:400px;margin: 30px auto;"></div>
					<div class="table_box" style="display: none;margin: 10px 10px;">
						<p style="text-align: center;font-size: 20px;">
							<strong>隐患级别统计表</strong>
						</p>
						<table id="tableDemo" lay-filter="tableDemo"></table>
					</div>
				</div>
				<div class="no_data" style="text-align: center;display: none">
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

	var tableIns = null;
	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;


		form.render();

		var option;

		option = {
			legend: {
				y: 'bottom'
			},
			tooltip: {},
			title: {
				text: '质量检查统计表',
				x: "center", //标题水平方向位置
			},
			dataset: {
				source: [
					['product', '检查数量', '隐患数量', '已整改数量'],
					['1月', 10, 50, 60],
					['2月', 25, 20, 50],
					['3月', 55, 85, 60],
					['4月', 20, 45, 40],
					['5月', 43, 85, 93],
					['6月', 83, 73, 55],
					['7月', 86, 65, 82],
					['8月', 72, 53, 39],
					['9月', 40, 85, 93],
					['10月', 81, 64, 44],
					['11月', 28, 65, 35],
					['12月', 70, 54, 40],
				]
			},
			xAxis: { type: 'category' },
			yAxis: {},
			// Declare several bar series, each will be mapped
			// to a column of dataset.source by default.
			series: [{ type: 'bar' }, { type: 'bar' }, { type: 'bar' }]
		};



		window.onresize = function() {
			myChart.resize();
		};


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
					// tableShow('')
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
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);

				tableShow(currentData.projId);
			} else {
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 渲染表格
		function tableShow(projId) {

			tableIns = table.render({
				elem: '#tableDemo',
				url: '/workflow/punishment/select',
				cols: [[ //表头
					// {type: 'checkbox'}
					// , {type: 'numbers', title: '序号'}
					{field: 'securityDanger', title: '隐患级别/月份'}
					, {field: 'securityDanger', title: '1月'}
					, {field: 'securityDangerMeasures', title: '2月'}
					, {field: 'securityDanger', title: '3月'}
					, {field: 'securityDangerMeasures', title: '4月'}
					, {field: 'securityDanger', title: '5月'}
					, {field: 'securityDangerMeasures', title: '6月'}
					, {field: 'securityDanger', title: '7月'}
					, {field: 'securityDangerMeasures', title: '8月'}
					, {field: 'securityDanger', title: '9月'}
					, {field: 'securityDangerMeasures', title: '10月'}
					, {field: 'securityDanger', title: '11月'}
					, {field: 'securityDangerMeasures', title: '12月'}
					, {field: 'securityDangerMeasures', title: '总计'}
				]],
				defaultToolbar: ['filter'],
				// height: 'full-80',
				// page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
				// 	layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
				// 			, limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
				// 			, first: false //不显示首页
				// 			, last: false //不显示尾页
				// 	}, //开启分页
				where: {
					projId: projId,
					projectId: projId,
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
				$.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
			})
			tableIns.reload({
				where: searchParams,
				page: {
					curr: 1 //重新从第 1 页开始
				}
			});
		});
	});

	/**
	 * 条形图
	 * 质量检查统计表
	 */
			// 基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('main'));

	// var option = {
	// 	title: {
	// 		text: '质量检查统计表',
	// 		x: "center", //标题水平方向位置
	// 	},
	// 	tooltip: {},
	// 	legend: {
	// 		data: ['检查数量','隐患数量','已整改数量'],
	// 		y: 'bottom',
	// 	},
	// 	xAxis: {
	// 		type: 'category',
	// 		data: ['1月', '2月', '3月', '4月', '5月', '6月','7月', '8月', '9月', '10月', '11月', '12月']
	// 	},
	// 	yAxis: {},
	// 	series: [
	// 		{
	// 			name: '检查数量',
	// 			type: 'bar',
	// 			data: [5, 20, 36, 10, 10, 20,5, 20, 36, 0, 10, 20]
	// 		},
	// 		{
	// 			name: '隐患数量',
	// 			type: 'bar',
	// 			data: [5, 20, 36, 10, 10, 0,5, 20, 36, 10, 100, 20]
	// 		},
	// 		{
	// 			name: '已整改数量',
	// 			type: 'bar',
	// 			data: [5, 20, 36, 10, 10, 20,5, 20, 36, 10, 10, 20]
	// 		},
	// 	]
	// };



</script>
</body>
</html>
