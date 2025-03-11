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
	<title>综合情况汇总分析</title>

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

	<script type="text/javascript" src="/js/planbudget/projectCostAnalysis.js"></script>

	

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
			background-image: url("/img/planother/comprehensiveAnalysis_2.png");
			color: white;
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
			text-align: left;
		}

		.eleTree-node-content:hover, .eleTree-node-content.eleTree-node-content-active {
			background-color: #888;
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
			/*margin-left: 230px;*/
			overflow: auto;
		}

		.query_module .layui-input {
			height: 35px;
		}

		.layui-table {
			background-color: transparent;
			color: #ffffff;
		}
		.table_box .layui-table-header tr {
			background-color: #666;
		}
		/*.table_box .layui-table-body tr :hover{*/
		/*	background-color: #1a3a61;*/
		/*}*/
		.table_box .layui-table tbody tr:hover{
			background-color: #1a3a61;
		}
	</style>
</head>
<body>
<div class="container">
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<%--<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">综合情况汇总分析</h2>
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
		</div>--%>
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<div class="layui-col-xs2" style="text-align: center;position:relative;">
					<input type="text" id="ele_Tree" name="ele_Tree" readonly placeholder="请选择项目" autocomplete="off" class="layui-input" style="height: 38px;margin-left: 6px;background-color: #333;color: white">
					<div class="eleTree ele2" lay-filter="data2" style="text-align: left;display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #333;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:5px;width: 100%;"></div>
				</div>
				<div class="layui-col-xs8" style="text-align: center">
					<h2 id="h2_title" style="margin-top: 10px;text-align: center"></h2>
				</div>
				<div class="layui-col-xs1">
					<span id="createDate" style="font-size: 20px;"></span>
				</div>
			</div>
			<div style="position: relative">
				<div class="table_box" style="display: none;">
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="float: left;margin: 10px;width: 48%;">
						<ul class="layui-tab-title">
							<li class="layui-this">整改情况</li>
							<li>隐患类别</li>
						</ul>
						<div class="layui-tab-content">
							<div class="layui-tab-item layui-show">
								<div id="main" style="width: 600px;height:400px;margin: 10px;float:left;"></div>
								<a class="quality" style="color: honeydew;text-decoration: underline;float:right;margin-right: 20px" href="" target="_blank">了解更多</a>
							</div>
							<div class="layui-tab-item">
								<div id="main2" style="width: 600px;height:400px;margin: 10px;float:left;"></div>
								<a class="quality" style="color: honeydew;text-decoration: underline;float:right;margin-right: 20px" href="" target="_blank">了解更多</a>
							</div>
						</div>
					</div>
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief2" style="float: right;margin: 10px;width: 48%;">
						<ul class="layui-tab-title">
							<li class="layui-this">整改情况</li>
							<li>隐患类别</li>
						</ul>
						<div class="layui-tab-content">
							<div class="layui-tab-item layui-show">
								<div id="main3" style="width: 600px;height:400px;margin: 10px;float:left;"></div>
								<a class="security" style="color: honeydew;text-decoration: underline;float:right;margin-right: 20px" href="" target="_blank">了解更多</a>
							</div>
							<div class="layui-tab-item">
								<div id="main4" style="width: 600px;height:400px;margin: 10px;float:left;"></div>
								<a class="security" style="color: honeydew;text-decoration: underline;float:right;margin-right: 20px" href="" target="_blank">了解更多</a>
							</div>
						</div>
					</div>
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief3" style="float: left;margin: 10px;width: 48%;clear: both">
						<ul class="layui-tab-title">
							<li class="layui-this">进度报表</li>
							<li>进度可视化</li>
						</ul>
						<div class="layui-tab-content">
							<div class="layui-tab-item layui-show">
								<div id="main5" style="width: 500px;height:400px;margin: 10px;float:left;"></div>
								<a class="speed" style="color: honeydew;text-decoration: underline;float:right;margin-right: 20px" href="" target="_blank">了解更多</a>
							</div>
							<div class="layui-tab-item">
								<a class="speed" style="color: honeydew;text-decoration: underline;float:right;margin-right: 20px" href="" target="_blank">了解更多</a>
								<div style="float:left;">
									<table class="layui-table" id="docDemo_TabBrief" lay-filter="docDemo_TabBrief" cellspacing="0" cellpadding="0">
										<thead>

										</thead>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief4" style="float: right;margin: 10px;width: 48%;clear: right">
						<ul class="layui-tab-title">
							<li class="layui-this">成本情况</li>
							<li>收入情况</li>
						</ul>
						<div class="layui-tab-content">
							<div class="layui-tab-item layui-show">
								<div id="main7" style="width: 600px;height:400px;margin: 10px;float:left;"></div>
								<a class="cost" style="color: honeydew;text-decoration: underline;float:right;margin-right: 20px" href="" target="_blank">了解更多</a>
							</div>
							<div class="layui-tab-item">
								<div id="main8" style="width: 600px;height:400px;margin: 10px;float:left;"></div>
								<a class="cost" style="color: honeydew;text-decoration: underline;float:right;margin-right: 20px" href="" target="_blank">了解更多</a>
							</div>
						</div>
					</div>
				</div>
				<div class="no_data" style="text-align: center;">
					<div class="no_data_img" style="margin-top:12%;">
						<img style="margin-top: 2%;" src="/img/noData.png">
					</div>
					<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择项目</p>
				</div>
			</div>
		</div>
	</div>
</div>


<script>

	var tableIns = null;
	layui.use(['form', 'laydate', 'table', 'element', 'eleTree', 'layer'], function () {
		var laydate = layui.laydate;
		var form = layui.form;
		var table = layui.table;
		var element = layui.element;
		var eleTree = layui.eleTree;
		var layer = layui.layer;


		var el;
		$("[name='ele_Tree']").on("click",function (e) {
			//debugger
			e.stopPropagation();
			if(!el){
				var loadingIndex = layer.load();
				$.get('/plbOrg/treeListOrg', function (res) {
					layer.close(loadingIndex);
					if (res.flag) {
						eleTree.render({
							elem: '.ele2',
							data: res.data,
							highlightCurrent: true,
							showLine: true,
							defaultExpandAll: false,
							expandOnClickNode: false,
							showCheckbox: false,
							checked: false,
							request: {
								name: 'name',
								children: "plbProjList",
							}
						});
						// tableShow('')
					}
				});
			}
			$(".ele2").slideDown();
		})
		$(document).on("click",function() {
			$(".ele2").slideUp();
		})

		$.get('/generalSituation/getDefaultProj', function (res) {
			if(res.code=='0'){
				var currentData = res.obj
				$('#leftId').attr('projId', currentData.projId);

				$('.quality').attr('href','/workReport/qualityReportAnalysis?showProj=true&analysisType=month&projectId='+currentData.projId)
				$('.security').attr('href','/workReport/securityReportAnalysis?showProj=true&analysisType=month&projectId='+currentData.projId)
				$('.speed').attr('href','/workReport/scheduleAnalysis?showProj=true&analysisType=month&projectId='+currentData.projId)
				$('.cost').attr('href','/budgetReport/budgetReportAnalysis?showProj=true&analysisType=month&projectId='+currentData.projId)

				$("[name='ele_Tree']").val(currentData.projName);
				$('#h2_title').text(currentData.projName+'项目综合情况汇总分析')

				$('.no_data').hide();
				$('.table_box').show();

				table_Show()
			}
		})

		//节点点击事件
		eleTree.on("nodeClick(data2)",function(d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {

				$.post('/generalSituation/setDefaultProj',{projectId:currentData.projId} ,function (res) {

				})

				$('#leftId').attr('projId', currentData.projId);

				$('.quality').attr('href','/workReport/qualityReportAnalysis?showProj=true&analysisType=month&projectId='+currentData.projId)
				$('.security').attr('href','/workReport/securityReportAnalysis?showProj=true&analysisType=month&projectId='+currentData.projId)
				$('.speed').attr('href','/workReport/scheduleAnalysis?showProj=true&analysisType=month&projectId='+currentData.projId)
				$('.cost').attr('href','/budgetReport/budgetReportAnalysis?showProj=true&analysisType=month&projectId='+currentData.projId)

				$("[name='ele_Tree']").val(currentData.projName);
				$('#h2_title').text(currentData.projName+'项目综合情况汇总分析')

				$('.no_data').hide();
				$('.table_box').show();

				table_Show()
			} else {
				$('#h2_title').text()
				$('.table_box').hide();
				$('.no_data').show();
				$("[name='ele_Tree']").val('');
			}
		})



		form.render();
		element.render();


		var myChart = echarts.init(document.getElementById('main'));
		var myChart2 = echarts.init(document.getElementById('main2'));

		var myChart3 = echarts.init(document.getElementById('main3'));
		var myChart4 = echarts.init(document.getElementById('main4'));

		var myChart5 = echarts.init(document.getElementById('main5'));

		var myChart7 = echarts.init(document.getElementById('main7'));
		var myChart8 = echarts.init(document.getElementById('main8'));

		window.onresize = function() {
			myChart.resize();
			myChart2.resize();
			myChart3.resize();
			myChart4.resize();
			myChart5.resize();
			myChart7.resize();
			myChart8.resize();
		};


		function table_Show() {
			var params = {}

			var loadIndex = layer.load();

			params.projectId = $('#leftId').attr('projId')||''
			params.projId = $('#leftId').attr('projId')||''
			// params.beginDate = $('#beginDate').val()||''
			// params.endDate = $('#endDate').val()||''

			//质量情况综合分析-整改情况
			var option;
			option = {
				backgroundColor:'',
				title: [
					{
						text: '质量情况综合分析',
						x: "center", //标题水平方向位置
						textStyle: {
							color: '#ffffff'
						}
					}
				],
				tooltip: {},
				xAxis: {
					type: 'category',
					data: ['检查数量', '隐患数量', '已整改数量', '未整改数量'],
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						},
						interval:0,
						rotate:30
					},
				},
				yAxis: {
					type: 'value',
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						}
					}
				},
				series: [
					{
						// data: [120, 200, 150, 80],
						type: 'bar',
						textStyle: {
							color: '#ffffff'
						}
					}
				]
			};



			//质量情况综合分析-隐患类别
			var option2;

			option2 = {
				backgroundColor:'',
				title: [
					{
						text: '质量情况综合分析',
						x: "center", //标题水平方向位置
						textStyle: {
							color: '#ffffff'
						}
					}
				],
				tooltip: {},
				xAxis: {
					type: 'category',
					// data: ['脚手架', '安全文明', '施工用电', '机械使用'],
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						},
						interval:0,
						rotate:30
					},
				},
				yAxis: {
					type: 'value',
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						}
					}
				},
				series: [
					{
						// data: [120, 200, 150, 80],
						type: 'bar',
						textStyle: {
							color: '#ffffff'
						}
					}
				]
			};

			//安全情况综合分析-整改情况
			var option3;

			option3 = {
				backgroundColor:'',
				title: [
					{
						text: '安全情况综合分析',
						x: "center", //标题水平方向位置
						textStyle: {
							color: '#ffffff'
						}
					}
				],
				tooltip: {},
				xAxis: {
					type: 'category',
					data: ['检查数量', '隐患数量', '已整改数量', '未整改数量'],
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						},
						interval:0,
						rotate:30
					},
				},
				yAxis: {
					type: 'value',
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						}
					}
				},
				series: [
					{
						// data: [120, 200, 150, 80],
						type: 'bar',
						textStyle: {
							color: '#ffffff'
						}
					}
				]
			};


			//安全情况综合分析-隐患类别
			var option4;

			option4 = {
				backgroundColor:'',
				title: [
					{
						text: '安全情况综合分析',
						x: "center", //标题水平方向位置
						textStyle: {
							color: '#ffffff'
						}
					}
				],
				tooltip: {},
				xAxis: {
					type: 'category',
					// data: ['脚手架', '安全文明', '施工用电', '机械使用','机械使用'],
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						},
						interval:0,
						rotate:30
					},
				},
				yAxis: {
					type: 'value',
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						}
					}
				},
				series: [
					{
						// data: [120, 200, 150, 80,80],
						type: 'bar',
						textStyle: {
							color: '#ffffff'
						}
					}
				]
			};

			//进度情况综合分析-进度报表
			var option5;

			option5 = {
				backgroundColor:'',
				title: {
					text: '进度情况综合分析',
					x: "center", //标题水平方向位置
					textStyle: {
						color: '#ffffff'
					}
				},
				grid: {
					right: '4%',
					containLabel: true,
					x:130
				},
				tooltip: {
					trigger: 'axis',
					axisPointer: {
						type: 'shadow'
					}
				},
				legend: {
					y: 'bottom',
					textStyle: {
						color: '#ffffff'
					}
				},
				xAxis: {
					// type: 'value',
					type: 'time',
					/*min:'2021-01-01',
					max:'2021-12-31',*/
					boundaryGap: [0, 0.01],
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						}
					},
				},
				yAxis: {
					type: 'category',
					// data: ['1#楼', '2#楼', '3#楼', '4#楼', '5#楼', '6#楼'],
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						}
					}
				},
				dataset: {
					// source: [
					// 	['product', '实际进度', '最新计划', '初始计划'],
					// 	['桩基础工程', 10, 3.10, 2.28],
					// 	['地下结构工程', 4.15, 4.20, 4.15],
					// 	['地上结构工程', 6.30, 6.30, 6.30],
					// 	['二次结构工程', 8.30, 8.30, 8.30],
					// 	['装饰装修工程', 10.15, 8.30, 10.15]
					// ],
					source: [
						['product', '实际进度', '最新计划', '初始计划'],
						['桩基础工程', '2021-03-10', '2021-03-10', '2021-02-28'],
						['地下结构工程', '2021-04-15', '2021-04-20', '2021-04-15'],
						['地上结构工程', '2021-06-30', '2021-06-30', '2021-06-30'],
						['二次结构工程', '2021-08-30', '2021-08-30', '2021-08-30'],
						['装饰装修工程', '2021-10-15','2021-08-30', '2021-10-15']
					]
				},
				series: [
					{
						// name: '实际进度',
						type: 'bar',
						// data: [2, 5, 8, 15, 18, 24],
						textStyle: {
							color: '#ffffff'
						}
					},
					{
						// name: '最新计划',
						type: 'bar',
						// data: [3, 6, 10, 16, 19, 16],
						textStyle: {
							color: '#ffffff'
						}
					},
					{
						// name: '初始计划',
						type: 'bar',
						// data: [1, 5, 12,12 , 14, 20],
						textStyle: {
							color: '#ffffff'
						}
					}
				]
			};

			//成本情况综合分析-成本情况
			// var option7;
			// option7 = {
			// 	backgroundColor:'',
			// 	legend: {
			// 		y: 'bottom',
			// 		textStyle: {
			// 			color: '#ffffff'
			// 		}
			// 	},
			// 	tooltip: {
			// 		trigger: 'axis',
			// 		axisPointer: {
			// 			type: 'shadow'
			// 		}
			// 	},
			// 	title: {
			// 		text: '成本情况综合分析',
			// 		x: "center", //标题水平方向位置
			// 		textStyle: {
			// 			color: '#ffffff'
			// 		}
			// 	},
			// 	dataset: {
			// 		source: [
			// 			/*['product', '初始管理目标', '最新管理目标', '实际成本'],
			// 			['材料', 2, 3, 1],
			// 			['分包', 5, 6, 5],
			// 			['机械', 8, 10, 12],
			// 			['其他', 15, 16, 14]*/
			// 			["product", "初始管理目标", "最新管理目标", "实际成本"],
			// 			["材料", "140312614.14", "141805843.28", "78797624.27"],
			// 			["分包", "188114734.55", "201123822.91", "99045488.75"],
			// 			["设备", "0", "0", "0"],
			// 			["其他", "57118412.91", "57972000.92", "9593062.36"]
			// 		]
			// 	},
			// 	series: [
			// 		{
			// 			// name: '初始计划',
			// 			type: 'bar',
			// 			textStyle: {
			// 				color: '#ffffff'
			// 			}
			// 			// data: [2, 5, 8, 15]
			// 		},
			// 		{
			// 			// name: '最新计划',
			// 			type: 'bar',
			// 			textStyle: {
			// 				color: '#ffffff'
			// 			}
			// 			// data: [3, 6, 10, 16]
			// 		},
			// 		{
			// 			// name: '实际支出',
			// 			type: 'bar',
			// 			textStyle: {
			// 				color: '#ffffff'
			// 			}
			// 			// data: [1, 5, 12,14]
			// 		}
			// 	],
			//
			// 	xAxis: {
			// 		type: 'category',
			// 		// data: ['材料', '分包', '机械', '其他'],
			// 		axisLabel: {
			// 			show: true,
			// 			textStyle: {
			// 				color: '#ffffff'
			// 			}
			// 		},
			// 	},
			// 	yAxis: {
			// 		type: 'value',
			// 		axisLabel: {
			// 			show: true,
			// 			textStyle: {
			// 				color: '#ffffff'
			// 			}
			// 		}
			// 	}
			// };

			//成本情况综合分析-收入情况
			var option8;
			option8 = {
				backgroundColor:'',
				legend: {
					y: 'bottom',
					textStyle: {
						color: '#ffffff'
					}
				},
				tooltip: {
					trigger: 'axis',
					axisPointer: {
						type: 'shadow'
					}
				},
				title: {
					text: '成本情况综合分析',
					x: "center", //标题水平方向位置
					textStyle: {
						color: '#ffffff'
					}
				},
				series: [
					{
						name: '合同金额',
						type: 'bar',
						data: [2, 5, 8],
						textStyle: {
							color: '#ffffff'
						}
					},
					{
						name: '结算金额',
						type: 'bar',
						data: [3, 6, 10],
						textStyle: {
							color: '#ffffff'
						}
					},
					{
						name: '收款金额',
						type: 'bar',
						data: [1, 5, 12],
						textStyle: {
							color: '#ffffff'
						}
					}
				],

				xAxis: {
					type: 'category',
					data: ['对上收款', '废料收款', '其他收款'],
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						}
					},
				},
				yAxis: {
					type: 'value',
					axisLabel: {
						show: true,
						textStyle: {
							color: '#ffffff'
						}
					}
				}
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
			myChart2.setOption(option2);
			myChart3.setOption(option3);
			myChart4.setOption(option4);
			myChart5.setOption(option5);

			tableShow(params)

			// myChart7.setOption(option7);
			myChart8.setOption(option8);

			$.post('/qualityReport/qualityData',params,function (res) {
				myChart.setOption({
					yAxis: {
						max: res&&res.obj,
					},
					series: {
						data:res&&res.data
					}
				});
			});
			$.post('/securityAnalysis/performanceAnalysis',params,function (res) {
				var xAxisData = []
				var seriesData = []
				if(res.obj&&res.obj.length>2){
					res.obj.pop()
					res.obj.forEach(function(item){
						xAxisData.push(item.knowledgeLastName)
						seriesData.push(item.sum)
					})
				}
				myChart2.setOption({
					xAxis: {
						data:xAxisData
					},
					series: {
						data:seriesData
					}
				});
			});

			$.post('/securityReport/securityData',params,function (res) {
				$('#createDate').text(res.object||'')
				myChart3.setOption({
					yAxis: {
						max: res&&res.obj,
					},
					series: {
						data:res&&res.data
					}
				});
			});
			$.post('/qualityAnalysis/performanceAnalysis',params,function (res) {
				var xAxisData = []
				var seriesData = []
				if(res.obj&&res.obj.length>2){
					res.obj.pop()
					res.obj.forEach(function(item){
						xAxisData.push(item.knowledgeLastName)
						seriesData.push(item.sum)
					})
				}
				myChart4.setOption({
					xAxis: {
						data:xAxisData
					},
					series: {
						data:seriesData
					}
				});
			});

			/*$.post('/scheduleReport/securityData',params,function (res) {
				myChart5.setOption({
					yAxis: {
						max: res&&res.obj,
					},
					dataset: {
						// source: [
						// 	['product', '实际进度', '最新计划', '初始计划'],
						// 	['桩基础工程', 10, 3.10, 2.28],
						// 	['地下结构工程', 4.15, 4.20, 4.15],
						// 	['地上结构工程', 6.30, 6.30, 6.30],
						// 	['二次结构工程', 8.30, 8.30, 8.30],
						// 	['装饰装修工程', 10.15, 8.30, 10.15]
						// ],
						source: res&&res.obj||[]
					}
				});
			});*/

			$.post('/generalSituation/budgetAnalysis',params,function (res) {
				myChart7.setOption({
					backgroundColor:'',
					legend: {
						y: 'bottom',
						textStyle: {
							color: '#ffffff'
						}
					},
					grid: {
						right: '4%',
						containLabel: true,
						x:130
					},
					tooltip: {
						trigger: 'axis',
						axisPointer: {
							type: 'shadow'
						}
					},
					title: {
						text: '成本情况综合分析',
						x: "center", //标题水平方向位置
						textStyle: {
							color: '#ffffff'
						}
					},
					dataset: {
						source: res.data||[]
					},
					series: [
						{
							// name: '初始计划',
							type: 'bar',
							textStyle: {
								color: '#ffffff'
							}
							// data: [2, 5, 8, 15]
						},
						{
							// name: '最新计划',
							type: 'bar',
							textStyle: {
								color: '#ffffff'
							}
							// data: [3, 6, 10, 16]
						},
						{
							// name: '实际支出',
							type: 'bar',
							textStyle: {
								color: '#ffffff'
							}
							// data: [1, 5, 12,14]
						}
					],

					xAxis: {
						type: 'category',
						// data: ['材料', '分包', '机械', '其他'],
						axisLabel: {
							show: true,
							textStyle: {
								color: '#ffffff'
							}
						},
					},
					yAxis: {
						type: 'value',
						axisLabel: {
							show: true,
							textStyle: {
								color: '#ffffff'
							}
						}
					}
				});
			});

			layer.close(loadIndex);
		}

		// 渲染表格 总进度可视化
		function tableShow(params) {
			var paramJson = {}
			params.projectId = $('#leftId').attr('projId')||''
			var flayy = true
			// if($('#beginDate').val()||$('#endDate').val()){
			// 	params.beginDate = $('#beginDate').val()
			// 	params.endDate = $('#endDate').val()
			// 	flayy = false
			// }
			if(flayy){
				params.parentScheduleId = 0
			}
			params.paramJson=JSON.stringify(paramJson)
			params.delFlag="0"
			params.dataFormStr='1'
			$.ajax({
				url:'/scheduleAnalysis/visualTable',
				type: 'post',
				data:params,
				dataType: 'json',
				// async:false,
				success:function(res){
					var tarbarObj = res.obj
					var docDemoTabBriefData = res.data

					$('#docDemo_TabBrief thead').empty()

					//表头
					var _str = ''
					for(var i = 0;i<tarbarObj.length;i++){
						_str += '<th lay-data="{field:\''+tarbarObj[i].filed+'\',align:\'center\',minWidth:110}"  rowspan="2">'+tarbarObj[i].name+'</th>'
					}

					var trOne = '<tr>' + _str +
							'<th lay-data="{field:\'percentComplete\',align:\'center\',minWidth:110}">完成百分比</th>' +
							'<th lay-data="{field:\'scheduleEndDate\',align:\'center\',minWidth:110}">计划时间</th>' +
							'<th lay-data="{field:\'recordDate\',align:\'center\',minWidth:90}">实际时间</th>' +
							'<th lay-data="{field:\'disparityDate\',align:\'center\',minWidth:90}">进度偏差</th>' +
							'</tr>'

					$('#docDemo_TabBrief thead').append(trOne)

					table.init('docDemo_TabBrief', { //转化静态表格
						//url:'/PtyMemberEvaluation/selectPmedByCPId?evaluationPartyId='+1+'&evaluationId='+2,
						data:docDemoTabBriefData,
						height: 'full-300',
						limit:10000000,
						done:function(res,curr,count){
							for(var i=0;i<tarbarObj.length;i++){
								layuiRowspan(tarbarObj[i].filed,1);
							}
						}
					});

				}
			});

			form.render()

		}

	});


</script>
</body>
</html>
