<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/10/19
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.*" %>
<%
	Long datetime = new Date().getTime(); // 获取系统时间
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
	<title>日志报表-部门</title>

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script src="../js/jquery/jquery.cookie.js"></script>
	<script type="text/javascript" src="/js/base/base.js?<%=datetime%>"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js?<%=datetime%>"></script>
	<script type="text/javascript" src="/js/echarts.min.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
	<%--		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/excel.js"></script>--%>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>

	<style>
		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
			overflow-x: hidden;
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
		}

		/* 查询表单样式 START */
		.search_module {
			position: relative;
			height: 35px;
		}

		.query_item {
			float: left;
		}

		.search_form input, select {
			height: 35px;
		}

		.search_form .layui-form-label {
			width: 80px;
			height: 35px;
			padding: 0 10px;
			line-height: 35px;
			box-sizing: border-box;
		}

		.search_form .layui-form-item {
			height: 35px;
			margin: 0;
			clear: none;
		}

		.search_form .layui-input-block {
			margin-left: 80px;
		}

		.search_form .query_button_group {
			/*height: 100%;*/
			margin-top: 2px;
		}

		.search_form .query_btn {
			float: right;
			width: 55px;
			margin-right: 20px;
			margin-left: 0;
		}

		/* 查询表单样式 EDN */
	</style>

</head>
<body>
<div class="container">
			<span id="moreOne" style="display: none" tid="743001" url="/StatisticalReport/projectProgressReport">
				项目进展报表
				<h2>项目进展报表</h2>
			</span>
	<span id="moreTwo" style="display: none" tid="743005" url="/StatisticalReport/targetAndTaskReport">
				职能计划报表
				<h2>职能计划报表</h2>
			</span>
	<div class="layui-tab layui-tab-brief" lay-filter="planProgressTab" style="margin: 0;">
		<ul class="layui-tab-title" style="float: left">
			<li class="layui-this">工作计划监控</li>
		</ul>
		<h3 id="deptName" style="line-height: 41px; text-align: center; font-weight: 500; font-size: 20px;"></h3>
		<div class="layui-tab-content" style="position: absolute;top: 40px;right: 0;bottom: 80px;left: 0;">
			<div class="search_module">
				<form class="layui-form clearfix search_form" lay-filter="searchForm">
					<div class="layui-row" style="padding: 5px 0;">
						<div class="layui-form-item query_item layui-col-xs3">
							<label class="layui-form-label">年度:</label>
							<div class="layui-input-block">
								<select name="year" lay-filter="year">

								</select>
							</div>
						</div>
						<div class="layui-form-item query_item layui-col-xs3">
							<label class="layui-form-label">月度:</label>
							<div class="layui-input-block">
								<select name="month">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
						<div class="layui-form-item query_item layui-col-xs3">
							<label class="layui-form-label">关注等级:</label>
							<div class="layui-input-block">
								<div id="controlLevelSelect" class="xm-select-demo"></div>
							</div>
						</div>
						<div class="query_button_group query_item layui-col-xs3">
							<button type="button" class="layui-btn layui-btn-sm more_query" style="margin-left: 10px;" isshow="0">
								<i class="layui-icon layui-icon-down" style="margin: 0;"></i>
							</button>
							<button type="button" id="searchBtn" class="layui-btn layui-btn-sm">查询</button>
							<button type="button" id="resetBtn" class="layui-btn layui-btn-sm">重置</button>
							<button type="button" class="layui-btn layui-btn-sm back_prev">返回上级</button>
						</div>
					</div>
					<div class="layui-row hide_query" style="display: none;padding: 5px 0;">
						<div class="layui-form-item query_item layui-col-xs3">
							<label class="layui-form-label">任务类型:</label>
							<div class="layui-input-block">
								<div id="planType" class="xm-select-demo"></div>
							</div>
						</div>
						<div class="layui-form-item query_item layui-col-xs3">
							<label class="layui-form-label">执行状态:</label>
							<div class="layui-input-block">
								<div id="statusSelect" class="xm-select-demo"></div>
							</div>
						</div>
						<div class="layui-form-item query_item layui-col-xs3">
							<label class="layui-form-label">分配状态:</label>
							<div class="layui-input-block">
								<select name="allocationStatus">
									<option value="">请选择</option>
									<option value="0">未分配</option>
									<option value="1">已分配</option>
								</select>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="content">
				<div class="echarts_module">
					<div class="layui-row" style="margin-top: 30px;">
						<div class="layui-col-xs6">
							<div id="pieShow" style="height: 340px;"></div>
						</div>
						<%--<div class="layui-col-xs6">
							<div id="chartTwo" style="height: 340px;"></div>
						</div>--%>

					</div>
					<%--<div class="layui-row" style="margin-top: 30px;">
						<div class="layui-col-xs6">
							<div id="radarShow" style="height: 340px;"></div>
						</div>
						<div class="layui-col-xs6">
							<div id="chartThree" style="height: 340px;"></div>
						</div>
					</div>--%>
					<div id="chartOne" style="margin: 30px auto;height: 340px;"></div>
				</div>

				<table id="dataTable" lay-filter="dataTable"></table>
			</div>
		</div>
	</div>
</div>

<script>
	var companyName = '';
	$.get('/sys/getSysMessage', function(res){
		if (res.flag && res.object) {
			companyName = res.object.authorizationUnit;
			$('#deptName').text(companyName);
		}
	});

	var bol = true
	var parentDept = $.GetRequest()['deptId'] || '';
	var parentDeptArr = []

	var typeObj = {
		'主项关键任务总数': false,
		'主项关键任务进行中': false,
		'主项关键任务未分配': false,
		'主项关键任务延期数量': false,
		'职能关键任务总数': false,
		'职能关键任务进行中': false,
		'职能关键任务未分配': false,
		'主项关键任务延期数量': false,
		'子任务总数': false,
		'子任务进行中': false,
		'子任务未分配': false,
		'主项关键任务延期数量': false,
	}

	var tableListData = null;

	var nowDateObj = {
		year: new Date().getFullYear(),
		month: new Date().getMonth() + 1
	}
	// 如果为1月，则显示上一年12月
	if (nowDateObj.month == 0) {
		nowDateObj.year -= 1;
		nowDateObj.month = 12;
	}

	var chartOne = echarts.init(document.getElementById('chartOne'));
	var optionOne = {
		tooltip: {
			trigger: 'axis',
			axisPointer: {
				type: 'shadow'//阴影，若需要为直线，则值为'line'
			},
			position: function (point, params, dom, rect, size) {
				// 鼠标在左侧时 tooltip 显示到右侧，鼠标在右侧时 tooltip 显示到左侧。
				if (point[0] < size.viewSize[0] / 2) {
					return [point[0] + 10, '10%'];
				} else {
					return [(point[0] - size.contentSize[0] - 10), '10%'];
				}
			}
		},
		legend: {
			data: [],
			y: 'bottom'
		},
		grid: {
			left: '3%',
			right: '4%',
			bottom: '15%',
			top: '10%',
			containLabel: true
		},
		xAxis: [{
			min: 0,
			axisTick: {
				show: false
			},
			type: 'category',
			data: []
		}],
		yAxis: [
			{
				type: 'value',
				scale: true,
				name: '任务数',
				min: 0,
				boundaryGap: [0.2, 0.2]
			}
		],
		color: ['#0119ff', '#0119ff', '#0119ff', '#19ab7e', '#19ab7e', '#19ab7e', '#e46c0a', '#e46c0a', '#e46c0a', '#4bacc6', '#4bacc6', '#4bacc6'],
		series: []
	};
	chartOne.setOption(optionOne);

	//var chartTwo = echarts.init(document.getElementById('chartTwo'));

	//var chartThree = echarts.init(document.getElementById('chartThree'));

	window.onresize = function () {
		chartOne.resize();
		//chartTwo.resize();
		//chartThree.resize();
		myChartPie.resize();
		//myChartRadar.resize();
	}

	var tgTypeData = [];
	var dictionaryObj = {
		CONTROL_LEVEL: {},
		TG_TYPE: {}
	}
	var dictionaryStr = 'CONTROL_LEVEL,TG_TYPE';
	// 获取数据字典数据
	$.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
		if (res.flag) {
			for (var dict in dictionaryObj) {
				dictionaryObj[dict] = {object: {}, str: '', select: []}
				if (res.object[dict]) {
					res.object[dict].forEach(function (item) {
						dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
						dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
						dictionaryObj[dict]['select'].push({name: item.dictName, value: item.dictNo})
					});
				}
			}
		}
		$.get('/Dictonary/getTgType', function (res) {
			tgTypeData = res.object;
			init();
		});
	});

	function init() {
		//雷达图默认加载前六个
		var planTypeData = ''
		dictionaryObj['TG_TYPE']['select'].forEach(function (item, index) {
			if (index < 6) {
				planTypeData += item.value + ','
			}
		})
		layui.use(['form', 'treeTable', 'xmSelect', 'table', 'soulTable'], function () {
			var form = layui.form,
					soulTable = layui.soulTable,
					xmSelect = layui.xmSelect,
					table = layui.table;

			// 计划期间年度列表
			var allYear = '';
			// 获取计划期间年度列表
			$.get('/planPeroidSetting/selectAllYear', function (res) {
				var nowYearNo = '';
				if (res.object.length > 0) {
					res.object.forEach(function (item) {
						allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>';
						if (!nowYearNo && (nowDateObj.year == item.periodYear)) {
							nowYearNo = item.periodYear;
						}
					});
				}
				$('.search_form [name="year"]').append(allYear);
				if (nowYearNo) {
					$('.search_form [name="year"]').val(nowYearNo);
					getPlanMonth(nowYearNo, function (monthStr) {
						$('.search_form [name="month"]').html(monthStr);
						$('.search_form [name="month"]').val(nowDateObj.month);
						form.render('select');
						$('#searchBtn').trigger('click');
					});
				} else {
					$('#searchBtn').trigger('click');
				}
				form.render('select');
			});

			// 获取月度
			form.on('select(year)', function (data) {
				if (data.value) {
					getPlanMonth(data.value, function (monthStr) {
						$('.search_form [name="month"]').html(monthStr);
						form.render('select');
					});
				} else {
					$('.search_form [name="month"]').html('<option value="">请选择</option>');
					form.render('select');
				}
			});

			if($.cookie("allocationStatus")) {
				$('select[name="allocationStatus"]').val($.cookie("allocationStatus"));
			}

			// 关注等级
			var controlLevelSelect = xmSelect.render({
				el: '#controlLevelSelect',
				toolbar: {
					show: true,
				},
				data: dictionaryObj['CONTROL_LEVEL']['select'],
				name: 'controlLevel',
				model: {
					label: {
						type: 'text',
						//使用字符串拼接的方式
						text: {
							//左边拼接的字符
							left: '',
							//右边拼接的字符
							right: '',
							//中间的分隔符
							separator: '，',
						},
					}
				},
			});
			if($.cookie("controlLevel")) {
				controlLevelSelect.setValue($.cookie("controlLevel").split(','));
			}

			// 任务类型
			var planTypeSelect = xmSelect.render({
				el: '#planType',
				toolbar: {
					show: true,
				},
				data: tgTypeData,
				model: {
					label: {
						type: 'text',
						//使用字符串拼接的方式
						text: {
							//左边拼接的字符
							left: '',
							//右边拼接的字符
							right: '',
							//中间的分隔符
							separator: '，',
						},
					}
				},
				name: 'planType',
				prop: {
					name: 'dictName',
					value: 'dictId',
					children: 'child'
				},
				tree: {
					show: true,
					showFolderIcon: true,
					showLine: true,
					indent: 20,
					expandedKeys: [-3],
				}
			});
			if($.cookie("planType")) {
				planTypeSelect.setValue($.cookie("planType").split(','));
			}

			// 状态
			var statusSelect = xmSelect.render({
				el: '#statusSelect',
				toolbar: {
					show: true,
				},
				name: 'status',
				data: [
					{name: '未开始', value: 0},
					{name: '进行中', value: 1},
					{name: '将到期', value: 2},
					{name: '已延期', value: 4},
					{name: '暂停', value: 7},
					{name: '完成', value: 5},
					{name: '延期完成', value: 6},
					{name: '成果不符', value: 9},
					{name: '关闭', value: 8}
				],
				model: {
					label: {
						type: 'text',
						//使用字符串拼接的方式
						text: {
							//左边拼接的字符
							left: '',
							//右边拼接的字符
							right: '',
							//中间的分隔符
							separator: '，',
						},
					}
				},
			});
			if($.cookie("status")) {
				statusSelect.setValue($.cookie("status").split(','));
			}

			form.render();

			var dataTable = null;

			function initTable(searchData) {
				chartOne.showLoading();
				var loadIndex = layer.load();
				$.get('/StatisticalReport/getDataByUserId', searchData, function (res) {
					chartOne.hideLoading();
					layer.close(loadIndex);
					if (res.flag && res.obj.length > 0) {
						tableListData = res.obj;
						var newData = initTableData(res.obj);

						dataTable = table.render({
							elem: '#dataTable',
							cols: [[
								{
									field: 'deptName',
									title: '部门名称',
									align: 'center',
									event: 'nameLink',
									minWidth: 200,
									rowspan: 3,
									templet: function (d) {
										return '<span style="color: blue;cursor: pointer;text-decoration: underline;">' + d.deptName + '</span>';
									}
								},
								{align: 'center', title: '主项关键任务', align: 'center', colspan: 4},
								{align: 'center', title: '职能关键任务', align: 'center', colspan: 4},
								{align: 'center', title: '子任务', align: 'center', colspan: 4},
								{align: 'center', title: '子任务明细', align: 'center', colspan: newData.itemOtherCount},
							],[
								{field: 'tgProCountSum', title: '总数', minWidth: 100, align: 'center', hide: typeObj['主项关键任务总数'], style: 'background-color: #bff3f3;',rowspan: 2},
								{align: 'center', title: '延期数量', align: 'center', colspan: 3},
								{field: 'tgDeptCountSum', title: '总数', minWidth: 100, align: 'center', hide: typeObj['职能关键任务总数'], style: 'background-color: #f3e5bf;',rowspan: 2},
								{align: 'center', title: '延期数量', align: 'center', colspan: 3},
								{field: 'itemCountSum', title: '总数', minWidth: 100, align: 'center', hide: typeObj['子任务总数'], style: 'background-color: #d1f3bf;',rowspan: 2},
								{align: 'center', title: '延期数量', align: 'center', colspan: 3},
							].concat(newData.itemTypeCols), newData.itemCols],
							data: newData.tableData,
							done: function () {

								soulTable.render(this);

								var $tr = $('.layui-table-header').find('tr');

								var $th1 = $tr.eq(0).find('th');

								var $th2 = $tr.eq(1).find('th');

								var $th3 = $tr.eq(2).find('th');

								$th1.eq(0).css('border-right', '1px solid red');
								$th1.eq(1).css('border-right', '1px solid red');
								$th1.eq(2).css('border-right', '1px solid red');
								$th1.eq(3).css('border-right', '1px solid red');

								$th2.eq(1).css('border-right', '1px solid red');
								$th2.eq(3).css('border-right', '1px solid red');
								$th2.eq(5).css('border-right', '1px solid red');
								$th2.eq(11).css('border-right', '1px solid red');

								$th3.eq(2).css('border-right', '1px solid red');
								$th3.eq(8).css('border-right', '1px solid red');
							}
						});
					} else {
						chartOne.setOption(optionOne, true);
					}
				});
			}

			// echarts-legend点击
			chartOne.on('legendselectchanged', function (e) {
				typeObj[e.name] = !e.selected[e.name]

				var newData = initTableData(tableListData);
				dataTable = table.render({
					elem: '#dataTable',
					cols: [[
						{
							field: 'deptName',
							title: '部门名称',
							align: 'center',
							event: 'nameLink',
							minWidth: 200,
							rowspan: 3,
							templet: function (d) {
								return '<span style="color: blue;cursor: pointer;text-decoration: underline;">' + d.deptName + '</span>';
							}
						},
						{align: 'center', title: '主项关键任务', align: 'center', colspan: 4},
						{align: 'center', title: '职能关键任务', align: 'center', colspan: 4},
						{align: 'center', title: '子任务', align: 'center', colspan: 4},
						{align: 'center', title: '子任务明细', align: 'center', colspan: newData.itemOtherCount},
					],[
						{field: 'tgProCountSum', title: '总数', minWidth: 100, align: 'center', hide: typeObj['主项关键任务总数'], style: 'background-color: #bff3f3;',rowspan: 2},
						{align: 'center', title: '延期数量', align: 'center', colspan: 3},
						{field: 'tgDeptCountSum', title: '总数', minWidth: 100, align: 'center', hide: typeObj['职能关键任务总数'], style: 'background-color: #f3e5bf;',rowspan: 2},
						{align: 'center', title: '延期数量', align: 'center', colspan: 3},
						{field: 'itemCountSum', title: '总数', minWidth: 100, align: 'center', hide: typeObj['子任务总数'], style: 'background-color: #d1f3bf;',rowspan: 2},
						{align: 'center', title: '延期数量', align: 'center', colspan: 3},
					].concat(newData.itemTypeCols), newData.itemCols],
					data: newData.tableData,
					done: function () {
						var $tr = $('.layui-table-header').find('tr');

						var $th1 = $tr.eq(0).find('th');

						var $th2 = $tr.eq(1).find('th');

						var $th3 = $tr.eq(2).find('th');

						$th1.eq(0).css('border-right', '1px solid red');
						$th1.eq(1).css('border-right', '1px solid red');
						$th1.eq(2).css('border-right', '1px solid red');
						$th1.eq(3).css('border-right', '1px solid red');

						if(!$th2.eq(1).hasClass('layui-hide')){
							$th2.eq(1).css('border-right', '1px solid red')
						}else{
							$th2.eq(0).css('border-right', '1px solid red')
						}
						if(!$th2.eq(3).hasClass('layui-hide')){
							$th2.eq(3).css('border-right', '1px solid red')
						}else{
							$th2.eq(2).css('border-right', '1px solid red')
						}
						if(!$th2.eq(5).hasClass('layui-hide')){
							$th2.eq(5).css('border-right', '1px solid red')
						}else{
							$th2.eq(4).css('border-right', '1px solid red')
						}
						soulTable.render(this);

					}
				});
			});

			//监听工具条
			table.on('tool(dataTable)', function (obj) {
				var data = obj.data;
				var layEvent = obj.event;

				if (layEvent === 'nameLink') {
					if (data.haveChild == 1) {
						parentDeptArr.push(parentDept);
						parentDept = data.deptId;
						getDeptName(parentDept);
						$('#searchBtn').trigger('click');
					} else {
						layer.open({
							type: 1,
							title: '',
							area: ['400px', '300px'],
							btn: ['确定', '取消'],
							content: '<form class="layui-form link_form" style="padding: 40px;"><div class="layui-form-item">\n' +
									'    <label class="layui-form-label">跳转至</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="radio" name="jumpLink" value="1" title="项目进展报表" checked>\n' +
									'      <input type="radio" name="jumpLink" value="2" title="职能计划报表">\n' +
									'    </div>\n' +
									'  </div></form>',
							success: function() {
								form.render()
							},
							yes: function (index) {
								var linkVal = $('.link_form').find('[name="jumpLink"]:checked').val()
								var eleId = ''
								var url = ''
								if (linkVal == 1) {
									eleId = 'moreOne';
									url = '/StatisticalReport/projectProgressReport?deptId=' + data.deptId;
								} else {
									eleId = 'moreTwo';
									url = '/StatisticalReport/targetAndTaskReport?deptId=' + data.deptId;
								}
								$('#' + eleId).attr('url', url);
								parent.getMenuOpen($('#' + eleId).get(0));
								layer.close(index)
							}
						})
					}
				}
			});

			// 查询
			$('#searchBtn').click(function () {
				var $selectEle = $('.search_form [name]');

				var searchData = {}

				$selectEle.each(function () {
					var key = $(this).attr('name');
					var value = $(this).val();
					searchData[key] = value;
					// 将查询值保存至cookie中
					$.cookie(key, value,{expires:5, path:"/",});
				});
				searchData.deptId = parentDept;

				var planTypeArr = planTypeSelect.getValue();
				var planType = ''
				planTypeArr.forEach(function (item) {
					planType += item.dictNo + ',';
				});

				searchData.planType = planType;

				initTable(searchData);
				initChart(searchData);
				bol = false
			});

			// 清空查询条件
			$('#resetBtn').click(function () {

				getPlanMonth(nowDateObj.year, function (str) {
					$('[name="month"]').html(str);

					// 重置为本年本月
					$('[name="year"]').val(nowDateObj.year);
					$('[name="month"]').val(nowDateObj.month);

					controlLevelSelect.setValue([]);
					planTypeSelect.setValue([]);
					statusSelect.setValue([]);

					$('[name="allocationStatus"]').val('');

					form.render();
				});

			});

			// 更多查询
			$('.more_query').click(function () {
				var isShow = $(this).attr('isshow');
				if (isShow == 0) {
					$(this).children().removeClass('layui-icon-down').addClass('layui-icon-up');
					$('.hide_query').show();
					$(this).attr('isshow', 1);
					$('.search_module').css('height', '96px')
				} else {
					$(this).children().removeClass('layui-icon-up').addClass('layui-icon-down');
					$('.hide_query').hide();
					$(this).attr('isshow', 0);
					$('.search_module').css('height', '35px')
				}
			});

			// 返回上级
			$('.back_prev').on('click', function () {
				var deptId = '';
				if (parentDeptArr.length > 0) {
					deptId = parentDeptArr.pop();
				}
				parentDept = $.GetRequest()['deptId'] || deptId;

				getDeptName(parentDept);

				$('#searchBtn').trigger('click');
			});

		});
	}

	/**
	 * 获取指定部门名称
	 * @param deptId (部门id)
	 */
	function getDeptName(deptId) {
		if (deptId) {
			// 获取部门信息
			$.get('/department/getDeptById', {deptId: deptId}, function (res) {
				if (res.flag && res.object) {
					$('#deptName').text(res.object.deptName)
				}
			});
		} else {
			$('#deptName').text(companyName);
		}
	}

	/***
	 * 获取计划期间月度
	 * @param year (月度对应年份)
	 * @param cb (回调函数)
	 */
	function getPlanMonth(year, fn) {
		$.get('/planPeroidSetting/showAllSet', {periodYear: year}, function (res) {
			var str = '<option value="">请选择</option>';
			if (res.object.length > 0) {
				res.object.forEach(function (item) {
					str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>'
				});
			}
			if (fn) {
				fn(str);
			}
		});
	}

	/**
	 * 处理数据
	 * @param tableData
	 * @returns {*}
	 */
	function initTableData(tableData) {

		initBar(tableData)

		var newData = {
			tableData: [],
			itemCols: [
				{
					field: 'tgProOutTimeNotAllocationSum',
					title: '未分配',
					minWidth: 100,
					align: 'center',
					hide: typeObj['主项关键任务未分配'],
					style: 'background-color: #bff3f3;'
				},
				{
					field: 'tgProOutTimeInProgress',
					title: '进行中',
					minWidth: 100,
					align: 'center',
					hide: typeObj['主项关键任务进行中'],
					style: 'background-color: #bff3f3;'
				},
				{
					field: 'tgProOutTimeFinishSum',
					title: '完成',
					minWidth: 100,
					align: 'center',
					hide: typeObj['主项关键任务完成'],
					style: 'background-color: #bff3f3;'
				},
				{
					field: 'tgDeptOutTimeNotAllocationSum',
					title: '未分配',
					minWidth: 100,
					align: 'center',
					hide: typeObj['职能关键任务未分配'],
					style: 'background-color: #f3e5bf;'
				},
				{
					field: 'tgDeptOutTimeInProgress',
					title: '进行中',
					minWidth: 100,
					align: 'center',
					hide: typeObj['职能关键任务进行中'],
					style: 'background-color: #f3e5bf;'
				},
				{
					field: 'tgDeptOutTimeFinishSum',
					title: '完成',
					minWidth: 100,
					align: 'center',
					hide: typeObj['职能关键任务完成'],
					style: 'background-color: #f3e5bf;'
				},
				{field: 'itemOutTimeNotAllocationSum', title: '未分配', minWidth: 100, align: 'center', hide: typeObj['子任务未分配'], style: 'background-color: #d1f3bf;'},
				{field: 'itemOutTimeInProgress', title: '进行中', minWidth: 100, align: 'center', hide: typeObj['子任务进行中'], style: 'background-color: #d1f3bf;'},
				{
					field: 'itemOutTimeFinishSum',
					title: '完成',
					minWidth: 100,
					align: 'center',
					hide: typeObj['子任务完成'],
					style: 'background-color: #d1f3bf;'
				}
			],
			itemTypeCols: [],
			itemOtherCount: 0
		}

		tableData.forEach(function (item, index) {
			var obj = {}
			obj.deptId = item.deptId;
			obj.deptName = item.deptName;
			obj.haveChild = item.haveChild;
			obj.deptType = item.deptType;
			// 关键主项任务
			obj.tgProOutTimeNotAllocationSum = item.tarProjCount.outTimeNotAllocationSum;
			obj.tgProOutTimeInProgress = item.tarProjCount.outTimeInProgress;
			obj.tgProCountSum = item.tarProjCount.countSum;
			obj.tgProOutTimeFinishSum = item.tarProjCount.outTimeFinishSum;
			// 关键职能任务
			obj.tgDeptOutTimeNotAllocationSum = item.tarDeptCount.outTimeNotAllocationSum;
			obj.tgDeptOutTimeInProgress = item.tarDeptCount.outTimeInProgress;
			obj.tgDeptCountSum = item.tarDeptCount.countSum;
			obj.tgDeptOutTimeFinishSum = item.tarDeptCount.outTimeFinishSum;
			// 子任务
			obj.itemOutTimeNotAllocationSum = item.itemCount.outTimeNotAllocationSum;
			obj.itemOutTimeInProgress = item.itemCount.outTimeInProgress;
			obj.itemCountSum = item.itemCount.countSum;
			obj.itemOutTimeFinishSum = item.itemCount.outTimeFinishSum;

			// 子任务其他类型
			for (var key in item.itemCount.finishData) {
				newData.itemOtherCount++;
				obj[key] = (item.itemCount.finishData[key] + item.itemCount.inProgressData[key]);
				if (index == 0) {
					var colObj = {field: key, title: key, minWidth: 100, align: 'center', hide: typeObj['子任务总数'],rowspan:2}
					newData.itemTypeCols.push(colObj)
				}
			}

			newData.tableData.push(obj);
		});

		return newData
	}

	/**
	 * 处理柱状图数据
	 * @param tableData
	 * @returns {{xType: [], seriesData: [], legendData: []}}
	 */
	function initBarData(tableData) {
		var baseLegend = ['总数', '进行中', '未分配', '完成'];
		var legendData = [];

		// xType存放的是横坐标
		var xType = [];
		// 创建一个数组，用来装对象传给series.data，因为series.data里面不能直接写for循环
		var seriesData = [];

		//遍历baseLegend，将legend 的data做出来，就是legendData
		for (var i = 0; i < baseLegend.length; i++) {
			legendData.push("主项关键任务" + baseLegend[i]);
			legendData.push("职能关键任务" + baseLegend[i]);
			legendData.push("子任务" + baseLegend[i]);
		}

		var tgProUnallocated = [], tgProInProgress = [], tgProSum = [], tgProOutTime = [],
				tgDeptUnallocated = [], tgDeptInProgress = [], tgDeptSum = [], tgDeptOutTime = [],
				itemUnallocated = [], itemInProgress = [], itemSum = [], itemOutTime = [];

		var dataArray = [];

		for (var i = 0; i < tableData.length; i++) {
			xType.push(tableData[i].deptName);

			tgProUnallocated.push(tableData[i].tarProjCount.outTimeNotAllocationSum);
			tgProInProgress.push(tableData[i].tarProjCount.inProgress);
			tgProSum.push(tableData[i].tarProjCount.sum);
			tgProOutTime.push(tableData[i].tarProjCount.outTime);
			tgDeptUnallocated.push(tableData[i].tarDeptCount.outTimeNotAllocationSum);
			tgDeptInProgress.push(tableData[i].tarDeptCount.inProgress);
			tgDeptSum.push(tableData[i].tarDeptCount.sum);
			tgDeptOutTime.push(tableData[i].tarDeptCount.outTime);
			itemUnallocated.push(tableData[i].itemCount.outTimeNotAllocationSum);
			itemInProgress.push(tableData[i].itemCount.inProgress);
			itemSum.push(tableData[i].itemCount.sum);
			itemOutTime.push(tableData[i].itemCount.outTime);
		}

		dataArray.push(tgProSum, tgDeptSum, itemSum, tgProInProgress, tgDeptInProgress, itemInProgress, tgProUnallocated, tgDeptUnallocated, itemUnallocated, tgProOutTime, tgDeptOutTime, itemOutTime);

		for (var i = 0; i < legendData.length; i++) {
			var obj = {
				barWidth: '20px',
				name: legendData[i],
				data: dataArray[i],
				type: 'bar',
				stack: 'key_' + (i % 3)
			}

			if (i >= 9 && i < 12) {
				obj.label = {
					normal: {
						show: true,
						position: 'top',
						textStyle: {color: '#000'}
					}
				}
				switch (i) {
					case 9:
						obj.label.normal.formatter = function (params) {
							var str = 0
							var j = 0;
							while (j < 10) {
								str += parseInt(dataArray[j][params.dataIndex]);
								j += 3;
							}
							return str
						}
						break;
					case 10:
						obj.label.normal.formatter = function (params) {
							var str = 0
							var j = 1;
							while (j < 11) {
								str += parseInt(dataArray[j][params.dataIndex]);
								j += 3;
							}
							return str
						}
						break;
					case 11:
						obj.label.normal.formatter = function (params) {
							var str = 0
							var j = 2;
							while (j < 12) {
								str += parseInt(dataArray[j][params.dataIndex]);
								j += 3;
							}
							return str
						}
						break;
				}
			}

			seriesData[i] = obj;
		}

		return {
			xType: xType,
			seriesData: seriesData,
			legendData: legendData
		}
	}

	/**
	 * 加载柱状图
	 * @param tableData
	 */
	function initBar(tableData) {
		var barData = initBarData(tableData);

		chartOne.setOption({ //加载数据图表
			xAxis: [{
				min: 0,
				axisTick: {
					show: true,
					alignWithLabel: true
				},
				type: 'category',
				data: barData.xType,
				axisLabel: {
					interval: 0,
					formatter: function (value) {
						var str = "";
						var num = 10; //每行显示字数
						var valLength = value.length; //该项x轴字数
						var rowNum = Math.ceil(valLength / num); // 行数

						if (rowNum > 1) {
							for (var i = 0; i < rowNum; i++) {
								var temp = "";
								var start = i * num;
								var end = start + num;

								temp = value.substring(start, end) + "\n";
								str += temp;
							}
							return str;
						} else {
							return value;
						}
					}
				}
			}],
			series: barData.seriesData,
			legend: {
				left: 50,
				data: barData.legendData,
				y: 'bottom',
				width: '90%'
			}
		});
	}

	/**
	 * 处理折线图数据
	 * @param lineData
	 * @returns {{xType: *, seriesData: *, legendData: *}}
	 */
	function initLineOneData(lineData) {
		var xType = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
		var seriesData = []
		var legendData = []

		for (var i = 0; i < lineData.length; i++) {
			legendData.push(lineData[i].name)
			var seriesObjData = [lineData[i].map['month1'], lineData[i].map['month2'], lineData[i].map['month3'], lineData[i].map['month4'], lineData[i].map['month5'], lineData[i].map['month6'], lineData[i].map['month7'], lineData[i].map['month8'], lineData[i].map['month9'], lineData[i].map['month10'], lineData[i].map['month11'], lineData[i].map['month12']];

			var seriesObj = {
				name: lineData[i].name,
				type: 'line',
				stack: 'key' + i,
				data: seriesObjData
			}

			seriesData.push(seriesObj);
		}

		return {
			xType: xType,
			seriesData: seriesData,
			legendData: legendData
		}
	}

	/**
	 * 处理折线图数据
	 * @param lineData
	 * @returns {{xType: *, seriesData: *, legendData: *}}
	 */
	function intiLineTwoData(lineData) {
		var xType = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
		var seriesData = []
		var legendData = []

		var objData = {}

		for (var i = 0; i < lineData.length; i++) {
			for (var key in lineData[i].map) {
				if (i == 0) {
					legendData.push(key)
					objData[key] = []
				}
				objData[key].push(lineData[i].map[key])
			}
		}

		for (var i = 0; i < legendData.length; i++) {
			var seriesObj = {
				name: legendData[i],
				type: 'line',
				stack: 'key' + i,
				data: objData[legendData[i]]
			}

			seriesData.push(seriesObj);
		}

		return {
			xType: xType,
			seriesData: seriesData,
			legendData: legendData
		}
	}

	// 加载其他图表
	function initChart(searchData) {
		/*chartTwo.showLoading();
		$.get('/StatisticalReport/getAllDataCountByYear', searchData, function (res) {
			chartTwo.hideLoading();
			if (res.flag) {
				var lineData = initLineOneData(res.object);
				chartTwo.setOption({
					title: {
						text: (searchData.year || nowDateObj.year) + '年月份统计图',
						left: 'center',
						textAlign: 'center'
					},
					tooltip: {
						trigger: 'axis'
					},
					legend: {
						y: 'bottom',
						data: lineData.legendData
					},
					grid: {
						left: '3%',
						right: '3%',
						bottom: '10%',
						top: '10%',
						containLabel: true
					},
					xAxis: {
						axisTick: {
							show: true,
							alignWithLabel: true
						},
						type: 'category',
						data: lineData.xType,
						axisLabel: {
							interval: 0
						}
					},
					yAxis: {
						name: '任务数',
						type: 'value'
					},
					series: lineData.seriesData
				}, true);
			}
		});*/

		/*chartThree.showLoading();
		$.get('/StatisticalReport/getAllDataCountByYearPlantype', searchData, function (res) {
			chartThree.hideLoading();
			if (res.flag) {
				var lineData = intiLineTwoData(res.object);

				chartThree.setOption({
					title: {
						text: (searchData.year || nowDateObj.year) + '年任务类型月份统计图',
						left: 'center',
						textAlign: 'center'
					},
					tooltip: {
						trigger: 'axis'
					},
					legend: {
						y: 'bottom',
						data: lineData.legendData
					},
					grid: {
						top: '10%',
						left: '3%',
						right: '3%',
						bottom: '10%',
						containLabel: true
					},
					xAxis: {
						axisTick: {
							show: true,
							alignWithLabel: true
						},
						type: 'category',
						data: lineData.xType,
						axisLabel: {
							interval: 0
						}
					},
					yAxis: {
						name: '任务数',
						type: 'value'
					},
					series: lineData.seriesData
				}, true);
			}
		});*/

		// 加载饼图
		initPie(searchData);

		// 加载雷达图
		//initRadar(searchData);
	}

	/********************************饼图开始**************************************/
	var myChartPie = echarts.init(document.getElementById('pieShow'));

	/**
	 * 加载饼图
	 */
	function initPie(searchData) {
		myChartPie.showLoading();
		searchData = searchData || {}
		$.get('/StatisticalReport/getDataByTemp', searchData, function (res) {
			myChartPie.hideLoading();
			if (res.flag) {
				var data = res.data;
				var legendData = ['未开始', '进行中', '将到期', '已延期', '完成', '延期完成', '其他']
				var pieData = []
				legendData.forEach(function (item) {
					var pieObj = {}
					pieObj.name = item
					pieObj.value = data[item]
					pieData.push(pieObj)
				})

				myChartPie.setOption({
					title: {
						text: (searchData.year || nowDateObj.year) + '年任务数量统计图',
						left: '20%',
						textAlign: 'center'
					},
					tooltip: {
						trigger: 'item',
						formatter: '{a} <br/>{b} : {c} ({d}%)'
					},
					color: ['#7f7f7f', '#19ab7e', '#fad706', '#e46c0a', '#0119ff', '#4bacc6', '#ff0000'],
					legend: {
						orient: 'vertical',
						left: '10%',
						top: '13%',
						bottom: '10',
						data: legendData
					},
					series: [
						{
							name: '状态',
							type: 'pie',
							selectedMode: 'multiple',
							label: {
								show: true,
								position: 'outside',
								formatter: '{b} : {c} ({d}%)'
							},
							radius: '70%',
							center: ['50%', '60%'],
							data: pieData,
							emphasis: {
								itemStyle: {
									shadowBlur: 10,
									shadowOffsetX: 0,
									shadowColor: 'rgba(0, 0, 0, 0.5)'
								}
							}
						}
					]
				});
			}
		});
	}

	/********************************饼图结束**************************************/
	/********************************雷达图开始**************************************/
	//var myChartRadar = echarts.init(document.getElementById('radarShow'));

	/**
	 * 加载雷达图
	 */
	/*function initRadar(searchData) {
		myChartRadar.showLoading();
		$.get('/StatisticalReport/getRadarDataByUserId', searchData, function (res) {
			myChartRadar.hideLoading();
			var data = res.obj
			var optionData = radar(data)
			myChartRadar.setOption({
				title: {
					text: (searchData.year || nowDateObj.year) + '年任务类型统计图',
					left: '20%',
					textAlign: 'center'
				},
				tooltip: {},
				radar: {
					indicator: optionData.indicatorData,
					name: {
						textStyle: {
							color: '#fff',
							backgroundColor: '#999',
							borderRadius: 3,
							padding: [3, 5]
						}
					},
				},
				legend: {
					data: optionData.legendData,
					left: '10%',
					top: '13%',
					bottom: '10',
					orient: 'vertical'
				},
				series: [
					{
						name: '任务类型',
						type: 'radar',
						lineStyle: {
							normal: {
								width: 3
							}
						},
						data: optionData.seriesData,
						symbol: 'circle'
					}
				]
			});
		})
	}*/

	/**
	 * 处理雷达图数据
	 */
	function radar(data) {
		var indicatorData = []
		var seriesData = []
		var legendData = []
		data.forEach(function (item, index) {
			var seriesValue = []

			var name = Object.keys(item)[0]
			legendData.push(name)
			for (var key in item[name]) {
				if (index == 0) {
					indicatorData.push({name: key})
				}
				seriesValue.push(item[name][key])
			}

			var seriesDataItem = {
				name: name,
				value: seriesValue,
				label: {
					normal: {
						show: true
					}
				}
			}

			seriesData.push(seriesDataItem)
		})

		return {
			indicatorData: indicatorData,
			seriesData: seriesData,
			legendData: legendData
		}
	}

	/********************************雷达图结束**************************************/

</script>

</body>
</html>
