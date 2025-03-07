<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/22
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
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
		<title>工作计划监控</title>
		
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		<script type="text/javascript" src="/js/planCheck/echarts.min.js"></script>
		
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
			
			/* region 查询表单样式 */
			.search_module {
				position: relative;
				/*height: 35px;*/
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
			
			/* endregion */
			
			/* region 顶部图标样式 */
			.icon_box {
				float: left;
				margin-left: 5%;
				padding: 5px 0;
			}
			
			.icon_item {
				float: left;
				line-height: 25px;
				padding: 0 5px;
			}
			
			.icon_img {
				width: 20px;
				height: 20px;
			}
			
			/* endregion */
			
			.chart_item {
				height: 260px;
			}
			
			.chart_title {
				position: absolute;
				top: 85px;
				left: 14px;
				width: 1em;
				height: 60px;
				line-height: 30px;
				font-size: 22px;
				text-align: center;
			}
			
			.chart_count {
				float: left;
				position: relative;
				width: 316px;
				height: 100%;
				padding: 10px 10px 10px 50px;
				box-sizing: border-box;
			}
			
			.count_con {
				height: 100%;
				padding: 10px 30px;
				box-sizing: border-box;
				box-shadow: 0 1px 2px 1px rgba(0, 0, 0, .1);
				border-radius: 4px;
				font-size: 16px;
				line-height: 35px;
			}
			
			.chart_box {
				display: inline-block;
				width: calc(100% - 316px);
			}

			.td_img {
				width: 20px;
			}

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
			<div class="layui-tab layui-tab-brief" style="margin: 0;">
				<ul class="layui-tab-title" style="float: left">
					<li class="layui-this">工作计划监控</li>
				</ul>
				<ul class="icon_box clearfix">
					<li class="icon_item">
						状态图标：
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/not_started.png">
						<span class="icon_tip">未开始</span>
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/underway.png">
						<span class="icon_tip">进行中</span>
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/delay_underway.png">
						<span class="icon_tip">将到期</span>
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/out_underway.png">
						<span class="icon_tip">已延期</span>
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/suspend.png">
						<span class="icon_tip">暂停</span>
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/complete.png">
						<span class="icon_tip">完成</span>
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/delay_complete.png">
						<span class="icon_tip">延期完成</span>
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/result_default.png">
						<span class="icon_tip">成果不符</span>
					</li>
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/closed.png">
						<span class="icon_tip">关闭</span>
					</li>
				</ul>
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
								<div class="layui-form-item query_item layui-col-xs3">
									<label class="layui-form-label">任务类型:</label>
									<div class="layui-input-block">
										<div id="planType" class="xm-select-demo"></div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="content" style="margin-top: 10px;">
						<div class="chart_module">
							<div class="chart_count">
								<p class="chart_title">项目</p>
								<div class="count_con" style="padding: 25px 30px;">
									<p>项目数量：<span class="project_count"></span></p>
									<p>正在执行：<span class="pro_going"></span></p>
									<p>未分配：<span class="pro_no_allocation"></span></p>
									<p>延期数量：<span class="pro_delay"></span></p>
									<p>已完成数量：<span class="pro_finish"></span></p>
								</div>
							</div>
							<div class="layui-row chart_box">
								<div class="layui-col-xs5 layui-col-sm4 chart_item">
									<div id="pieChart" style="height: 100%;"></div>
								</div>
								<div class="layui-col-xs7 layui-col-sm8 chart_item">
									<div id="barChartOne" style="height: 100%;"></div>
								</div>
							</div>
						</div>
						<div class="chart_module">
							<div class="chart_count">
								<p class="chart_title">职能</p>
								<div class="count_con">
									<p>职能关键任务：<span class="dept_count"></span></p>
									<p>子任务：<span class="task_count"></span></p>
									<p>正在执行：<span class="dept_going"></span></p>
									<p>未分配：<span class="dept_no_allocation"></span></p>
									<p>延期数量：<span class="dept_delay"></span></p>
									<p>已完成数量：<span class="dept_finish"></span></p>
								</div>
							</div>
							<div class="layui-row chart_box">
								<div class="layui-col-x6 layui-col-sm5 chart_item">
									<div id="barChartTwo" style="height: 100%;"></div>
								</div>
								<div class="layui-col-xs6 layui-col-sm7 chart_item">
									<div id="barChartThree" style="height: 100%;"></div>
								</div>
							</div>
						</div>
						<div class="chart_module">
							<div id="barChartFour" style="height: 260px;"></div>
						</div>
						<table id="dataTable" lay-filter="dataTable"></table>
					</div>
				</div>
			</div>
		</div>
		
		<script>
            var localStorageKey = 'WPM_';

            var parentDept = $.GetRequest()['deptId'] || '';
            var parentDeptArr = []

            var tableListData = null;
            var typeObj = {
                '项目关键任务未开始': false,
                '项目关键任务进行中': false,
                '项目关键任务已完成': false,
                '职能关键任务未开始': false,
                '职能关键任务进行中': false,
                '职能关键任务已完成': false,
                '子任务未开始': false,
                '子任务进行中': false,
                '子任务已完成': false
            }

            var chartOne = echarts.init(document.getElementById('pieChart'));
            var chartTwo = echarts.init(document.getElementById('barChartOne'));
            var chartThree = echarts.init(document.getElementById('barChartTwo'));
            var chartFour = echarts.init(document.getElementById('barChartThree'));
            var chartFive = echarts.init(document.getElementById('barChartFour'));

            window.onresize = function () {
                chartOne.resize();
                chartTwo.resize();
                chartThree.resize();
                chartFour.resize();
                chartFive.resize();
            }

            // 默认显示上月
            var nowDateObj = {
                year: new Date().getFullYear(),
                month: new Date().getMonth()
            }
            // 如果为1月，则显示上一年12月
            if (nowDateObj.month == 0) {
                nowDateObj.year -= 1;
                nowDateObj.month = 12;
            }

            var TgTypeArr = [];

            var dictionaryObj = {
                CONTROL_LEVEL: {},
                TG_TYPE: {},
                DUTY_TYPE: {},
                TG_GRADE: {},
                PLAN_SYCLE: {},
                PLAN_PHASE: {},
                UNIT: {},
                CGCL_TYPE: {},
	            RENWUJIHUA_TYPE: {}
            }
            var dictionaryStr = 'CONTROL_LEVEL,TG_TYPE,DUTY_TYPE,TG_GRADE,PLAN_SYCLE,PLAN_PHASE,UNIT,CGCL_TYPE,RENWUJIHUA_TYPE';
            // 获取数据字典数据
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: '', select: []}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
                                dictionaryObj[dict]['select'].push({name: item.dictName, value: item.dictNo});
                            });
                        }
                    }
                }
                $.get('/Dictonary/getTgType', function (res) {
                    TgTypeArr = res.object;
                    init();
                });
            });

            // 附件查阅
            $(document).on('click', '.yulan', function () {
                var url = $(this).attr('data-url');
                pdurl($.UrlGetRequest('?' + url), url);
            });

            function init() {
                layui.use(['form', 'xmSelect', 'table'], function () {
                    var layuiForm = layui.form,
                        xmSelect = layui.xmSelect,
                        layuiTable = layui.table;

                    var dataTable = null;

                    if (getLocalStorage("allocationStatus", localStorageKey)) {
                        $('select[name="allocationStatus"]').val(getLocalStorage("allocationStatus", localStorageKey));
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
                    if (getLocalStorage("controlLevel", localStorageKey)) {
                        controlLevelSelect.setValue(getLocalStorage("controlLevel", localStorageKey).split(','));
                    }

                    // 任务类型
                    var planTypeSelect = xmSelect.render({
                        el: '#planType',
                        toolbar: {
                            show: true,
                        },
                        data: TgTypeArr,
                        name: 'planType',
                        tree: {
                            show: true,
                            showFolderIcon: true,
                            showLine: true,
                            indent: 20,
                            expandedKeys: [-3],
                        },
                        prop: {
                            name: 'dictName',
                            value: 'dictId',
                            children: 'child'
                        },
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

                    if (getLocalStorage("planType", localStorageKey)) {
                        planTypeSelect.setValue(getLocalStorage("planType", localStorageKey).split(','));
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
                    if (getLocalStorage("status", localStorageKey)) {
                        statusSelect.setValue(getLocalStorage("status", localStorageKey).split(','));
                    }

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
                                layuiForm.render('select');
                                $('#searchBtn').trigger('click');
                            });
                        } else {
                            $('#searchBtn').trigger('click');
                        }
                        layuiForm.render('select');
                    });
                    // 获取月度
                    layuiForm.on('select(year)', function (data) {
                        if (data.value) {
                            getPlanMonth(data.value, function (monthStr) {
                                $('.search_form [name="month"]').html(monthStr);
                                layuiForm.render('select');
                            });
                        } else {
                            $('.search_form [name="month"]').html('<option value="">请选择</option>');
                            layuiForm.render('select');
                        }
                    });

                    layuiForm.render();

                    // 查询
                    $('#searchBtn').on("click",function () {
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name');
                            var value = $(this).val();
                            searchData[key] = value;
                            // 将查询值保存至本地存储中
                            setLocalStorage(key, value, localStorageKey);
                        });

                        var planTypeArr = planTypeSelect.getValue();
                        var planType = ''
                        planTypeArr.forEach(function(item){
                            planType += item.dictNo + ',';
                        });

                        searchData.planType = planType

                        searchData.deptId = parentDept;

                        initTable(searchData);

                        loadChart(searchData);
                    });

                    // 清空查询条件
                    $('#resetBtn').on("click",function () {
                        getPlanMonth(nowDateObj.year, function (str) {
                            $('[name="month"]').html(str);

                            // 重置为本年本月
                            $('[name="year"]').val(nowDateObj.year);
                            $('[name="month"]').val(nowDateObj.month);

                            controlLevelSelect.setValue([]);
                            planTypeSelect.setValue([]);
                            statusSelect.setValue([]);

                            $('[name="allocationStatus"]').val('');

                            layuiForm.render();
                        });
                    });

                    // 更多查询
                    $('.more_query').on("click",function () {
                        var $this = $(this)
                        var isShow = $this.attr('isshow');
                        if (isShow == 0) {
                            $this.children().removeClass('layui-icon-down').addClass('layui-icon-up');
                            $('.hide_query').slideDown(100, function () {
                                $this.attr('isshow', 1);
                            });
                        } else {
                            $this.children().removeClass('layui-icon-up').addClass('layui-icon-down');
                            $('.hide_query').slideUp(100, function () {
                                $this.attr('isshow', 0);
                            });
                        }
                    });

                    // 返回上级
                    $('.back_prev').on('click', function () {
                        var deptId = '';
                        if (parentDeptArr.length > 0) {
                            deptId = parentDeptArr.pop();
                        }
                        parentDept = $.GetRequest()['deptId'] || deptId;

                        $('#searchBtn').trigger('click');
                    });

                    // echarts-legend点击
                    chartFive.on('legendselectchanged', function (e) {
                        typeObj[e.name] = !e.selected[e.name]

                        var newData = initTableData(tableListData);
                        dataTable = layuiTable.render({
                            elem: '#dataTable',
                            cols: [[
                                {
                                    field: 'deptName',
                                    title: '部门名称',
                                    align: 'center',
                                    event: 'nameLink',
                                    minWidth: 200,
                                    rowspan: 3,
                                    fixed: 'left',
                                    templet: function (d) {
                                        return '<span style="color: blue;cursor: pointer;text-decoration: underline;">' + d.deptName + '</span>';
                                    }
                                },
                                {align: 'center', title: '项目关键任务', align: 'center', colspan: 8},
                                {align: 'center', title: '职能关键任务', align: 'center', colspan: 8},
                                {align: 'center', title: '子任务', align: 'center', colspan: 8}
                            ], [
                                {align: 'center', title: '未开始', align: 'center', colspan: 3},
                                {align: 'center', title: '进行中', align: 'center', colspan: 3},
                                {align: 'center', title: '已完成', align: 'center', colspan: 2},
                                {align: 'center', title: '未开始', align: 'center', colspan: 3},
                                {align: 'center', title: '进行中', align: 'center', colspan: 3},
                                {align: 'center', title: '已完成', align: 'center', colspan: 2},
                                {align: 'center', title: '未开始', align: 'center', colspan: 3},
                                {align: 'center', title: '进行中', align: 'center', colspan: 3},
                                {align: 'center', title: '已完成', align: 'center', colspan: 2}
                            ], newData.itemCols],
                            data: newData.tableData
                        });
                    });

                    function initTable(searchData) {
                        var loadIndex = layer.load();
                        $.get('/StatisticalReport/getWorkPlanPlusFormData', searchData, function (res) {
                            layer.close(loadIndex);
                            if (res.flag && res.data.length > 0) {
                                tableListData = res.data;
                                var newData = initTableData(res.data);
                                initBar(res.data);
                                dataTable = layuiTable.render({
                                    elem: '#dataTable',
                                    cols: [[
                                        {
                                            field: 'deptName',
                                            title: '部门名称',
                                            align: 'center',
                                            event: 'nameLink',
                                            minWidth: 200,
                                            rowspan: 3,
                                            fixed: 'left',
                                            templet: function (d) {
                                                return '<span style="color: blue;cursor: pointer;text-decoration: underline;">' + d.deptName + '</span>';
                                            }
                                        },
                                        {align: 'center', title: '项目关键任务', align: 'center', colspan: 8},
                                        {align: 'center', title: '职能关键任务', align: 'center', colspan: 8},
                                        {align: 'center', title: '子任务', align: 'center', colspan: 8}
                                    ], [
                                        {align: 'center', title: '未开始', align: 'center', colspan: 3},
                                        {align: 'center', title: '进行中', align: 'center', colspan: 3},
                                        {align: 'center', title: '已完成', align: 'center', colspan: 2},
                                        {align: 'center', title: '未开始', align: 'center', colspan: 3},
                                        {align: 'center', title: '进行中', align: 'center', colspan: 3},
                                        {align: 'center', title: '已完成', align: 'center', colspan: 2},
                                        {align: 'center', title: '未开始', align: 'center', colspan: 3},
                                        {align: 'center', title: '进行中', align: 'center', colspan: 3},
                                        {align: 'center', title: '已完成', align: 'center', colspan: 2}
                                    ], newData.itemCols],
                                    data: newData.tableData
                                });
                            } else {
                                chartFive.setOption({}, true);
                            }
                        });
                    }

                    //监听工具条 
                    layuiTable.on('tool(dataTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;

                        if (layEvent === 'nameLink') {
                            if (data.haveChild == 1) {
                                parentDeptArr.push(parentDept);
                                parentDept = data.deptId;
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
                                    success: function () {
                                        layuiForm.render()
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

                    $(document).on('click', '.num_link', function () {
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name');
                            var value = $(this).val();
                            searchData[key] = value;
                            // 将查询值保存至本地存储中
                            setLocalStorage(key, value, localStorageKey);
                        });
                        
                        searchData.typeStatus = $(this).attr('typeStatus')
	                    searchData.deptId = $(this).attr('deptId')
	                    searchData.type = $(this).attr('type')

                        var cols = [[]]

                        if (searchData.type == 'targetProject') {
                            cols = [[
                                {
                                    field: 'taskStatus', title: '状态', width: 100, templet: function (d) {
                                        if (d.taskStatus == '0') {
                                            // '未开始';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/not_started.png"/>';
                                        } else if (d.taskStatus == '1') {
                                            // '进行中';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/underway.png"/>';
                                        } else if (d.taskStatus == '2') {
                                            // '将到期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_underway.png"/>';
                                        } else if (d.taskStatus == '4') {
                                            // '已延期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/out_underway.png"/>';
                                        } else if (d.taskStatus == '7') {
                                            // '暂停';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/suspend.png"/>';
                                        } else if (d.taskStatus == '5') {
                                            // '完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/complete.png"/>';
                                        } else if (d.taskStatus == '6') {
                                            // '延期完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_complete.png"/>';
                                        } else if (d.taskStatus == '9') {
                                            // '成果不符';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/result_default.png"/>';
                                        } else if (d.taskStatus == '8') {
                                            // '关闭';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/closed.png"/>';
                                        } else {
                                            return '';
                                        }
                                    }
                                },
	                            {field: 'projectAbbreviation', title: '项目名称', width: 300},
	                            {field: 'pbagName', title: '子项目名称', width: 300},
                                {
                                    field: 'tgName', title: '关键任务名称', width: 300, templet: function (d) {
                                        return '<span class="target_name_link" style="color: #0a6aa1; cursor: pointer;" tgId="' + d.tgId + '">' + d.tgName + '</span>'
                                    }
                                },
                                {
                                    field: 'planStartDate', title: '计划开始时间', width: 130, templet: function (d) {
                                        return format(d.planStartDate);
                                    }
                                },
                                {
                                    field: 'planEndDate', title: '计划完成时间', width: 130, templet: function (d) {
                                        return format(d.planEndDate);
                                    }
                                },
                                {
                                    field: 'planContinuedDate', title: '计划工期', width: 100, templet: function (d) {
                                        return '<span class="table_planContinuedDate">' + (d.planContinuedDate || '') + '</span>';
                                    }
                                },
                                {field: 'mainCenterDeptName', title: '中心责任部门', width: 130},
                                {
                                    field: 'centerDutyType', title: '中心职责类型', width: 130, templet: function (d) {
                                        return dictionaryObj['DUTY_TYPE']['object'][d.centerDutyType] || ''
                                    }
                                },
                                {field: 'mainAreaDeptName', title: '区域责任部门', width: 130},
                                {
                                    field: 'areaDutyType', title: '区域职责类型', width: 130, templet: function (d) {
                                        return dictionaryObj['DUTY_TYPE']['object'][d.areaDutyType] || ''
                                    }
                                },
                                {field: 'mainProjectDeptName', title: '总承包部责任部门', width: 150},
                                {
                                    field: 'controlLevel', title: '关注等级', width: 100, templet: function (d) {
                                        return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                    }
                                },
                                {
                                    field: 'tgGrade', title: '目标等级', width: 100, templet: function (d) {
                                        return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
                                    }
                                },
                                {
                                    field: 'planSycle', title: '周期类型', width: 100, templet: function (d) {
                                        return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                                    }
                                },
                                {
                                    field: 'tgType', title: '关键任务类型', width: 100, templet: function (d) {
                                        return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                                    }
                                },
                                {
                                    field: 'planStage', title: '计划阶段', width: 100, templet: function (d) {
                                        return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || '';
                                    }
                                },
                                {field: 'designQuantity', title: '设计量', width: 100},
                                {field: 'itemQuantity', title: '工程量', width: 100},
                                {
                                    field: 'itemQuantityNuit', title: '单位', width: 100, templet: function (d) {
                                        return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || '';
                                    }
                                },
                                {
                                    field: 'dutyUserName', title: '中心责任部门责任人', width: 160, templet: function (d) {
                                        if (d.dutyUserName) {
                                            return d.dutyUserName.replace(/,$/, '');
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                                {field: 'mainAreaUserName', title: '区域责任部门责任人', width: 160},
                                {field: 'mainProjectUserName', title: '总承包部责任部门责任人', width: 200},
                                {field: 'resultStandard', title: '完成标准', width: 150},
                                {field: 'riskPoint', title: '风险点', width: 130},
                                {
                                    field: 'resultDict', title: '成果标准模板', width: 150, templet: function (d) {
                                        var resultDictName = '';
                                        if (!!d.resultDict) {
                                            var resultDictList = d.resultDict.split(',');

                                            resultDictList.forEach(function (item) {
                                                resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                            });
                                        }

                                        return resultDictName.replace(/,$/, '');
                                    }
                                },
                                {field: 'difficultPoint', title: '难度点', width: 130},
                                {field: 'tgDesc', title: '关键任务描述', width: 150}
                            ]]
                        } else if (searchData.type == 'targetDept') {
                            cols = [[ //表头
                                {
                                    field: 'taskStatus', title: '状态', width: 100, templet: function (d) {
                                        if (d.taskStatus == '0') {
                                            // '未开始';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/not_started.png"/>';
                                        } else if (d.taskStatus == '1') {
                                            // '进行中';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/underway.png"/>';
                                        } else if (d.taskStatus == '2') {
                                            // '将到期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_underway.png"/>';
                                        } else if (d.taskStatus == '4') {
                                            // '已延期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/out_underway.png"/>';
                                        } else if (d.taskStatus == '7') {
                                            // '暂停';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/suspend.png"/>';
                                        } else if (d.taskStatus == '5') {
                                            // '完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/complete.png"/>';
                                        } else if (d.taskStatus == '6') {
                                            // '延期完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_complete.png"/>';
                                        } else if (d.taskStatus == '9') {
                                            // '成果不符';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/result_default.png"/>';
                                        } else if (d.taskStatus == '8') {
                                            // '关闭';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/closed.png"/>';
                                        } else {
                                            return '';
                                        }
                                    }
                                }
                                , {
                                    field: 'tgName', title: '关键任务名称', event: 'tgDetail', width: 300, templet: function(d){
                                        return '<span class="target_name_link" style="color: #0a6aa1; cursor: pointer;" tgId="'+d.tgId+'">'+d.tgName+'</span>'
		                            }
                                }
                                , {
                                    field: 'controlLevel', title: '关注等级', width: 100, templet: function (d) {
                                        return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                    }
                                }
                                , {
                                    field: 'planSycle', title: '周期类型', width: 100, templet: function (d) {
                                        return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                                    }
                                }
                                , {
                                    field: 'tgType', title: '关键任务类型', width: 100, templet: function (d) {
                                        return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                                    }
                                }
                                , {field: 'dutyUserName', title: '成果提交人', width: 130}
                                , {field: 'mainCenterDeptName', title: '责任部门', width: 200}
                                , {field: 'planContinuedDate', title: '计划工期', width: 100}
                                , {field: 'planStartDate', title: '计划开始时间', width: 130}
                                , {field: 'planEndDate', title: '计划完成时间', width: 130}
                                , {field: 'resultStandard', title: '完成标准', width: 150}
                                , {field: 'riskPoint', title: '风险点', width: 130}
                                , {
                                    field: 'resultDict', title: '成果标准模板', width: 150, templet: function (d) {
                                        var resultDictName = '';
                                        if (!!d.resultDict) {
                                            var resultDictList = d.resultDict.split(',');

                                            resultDictList.forEach(function (item) {
                                                resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                            });
                                        }

                                        return resultDictName.replace(/,$/, '');
                                    }
                                }
                                , {field: 'difficultPoint', title: '难度点', width: 130}
                                , {field: 'tgDesc', title: '关键任务描述', width: 150}
                            ]]
                        } else if (searchData.type == 'item') {
                            cols = [[
                                {
                                    field: 'taskStatus', title: '状态', width: 80, templet: function (d) {
                                        if (d.taskStatus == '0') {
                                            // '未开始';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/not_started.png"/>';
                                        } else if (d.taskStatus == '1') {
                                            // '进行中';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/underway.png"/>';
                                        } else if (d.taskStatus == '2') {
                                            // '将到期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_underway.png"/>';
                                        } else if (d.taskStatus == '4') {
                                            // '已延期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/out_underway.png"/>';
                                        } else if (d.taskStatus == '7') {
                                            // '暂停';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/suspend.png"/>';
                                        } else if (d.taskStatus == '5') {
                                            // '完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/complete.png"/>';
                                        } else if (d.taskStatus == '6') {
                                            // '延期完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_complete.png"/>';
                                        } else if (d.taskStatus == '9') {
                                            // '成果不符';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/result_default.png"/>';
                                        } else if (d.taskStatus == '8') {
                                            // '关闭';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/closed.png"/>';
                                        } else {
                                            return '';
                                        }
                                    }
                                },
                                {
                                    field: 'taskName', title: '子任务名称', width: 300, templet: function(d) {
                                        return '<span class="task_name_link" style="color: #0a6aa1; cursor: pointer;" planItemId="'+d.planItemId+'">'+d.taskName+'</span>'
	                                }
                                },
                                {
                                    field: 'tgId', title: '关联关键任务', width: 150, templet: function (d) {
                                        var tgIds = ''
                                        if (d.tgIds) {
                                            d.tgIds.forEach(function (item) {
                                                tgIds += item.tgName + ','
                                            })
                                            return tgIds.replace(/,$/, '')
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                                {
                                    field: 'planSycle', title: '周期类型', width: 100, templet: function (d) {
                                        return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                                    }
                                },
                                {
                                    field: 'taskType', title: '任务来源', width: 100, templet: function (d) {
                                        return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || ''
                                    }
                                },
                                {field: 'dutyUserName', title: '负责人', width: 90},
                                {field: 'mainCenterDeptName', title: '责任部门', width: 120},
                                {field: 'assistCompanyDeptsName', title: '协助部门', width: 120},
                                {field: 'planContinuedDate', title: '计划工期', width: 80},
                                {
                                    field: 'planStartDate', title: '计划开始时间', width: 120, templet: function (d) {
                                        return format(d.planStartDate)
                                    }
                                },
                                {
                                    field: 'planEndDate', title: '计划结束时间', width: 120, templet: function (d) {
                                        return format(d.planEndDate)
                                    }
                                },
                                {
                                    field: 'resultStandard', title: '完成标准', width: 130
                                },
                                {
                                    field: 'preTask', title: '前置子任务', width: 150, templet: function (d) {
                                        var preTasks = ''
                                        if (d.preTasks) {
                                            d.preTasks.forEach(function (item) {
                                                preTasks += item.workItemName + ','
                                            })
                                            return preTasks.replace(/,$/, '').split(',')
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                                {field: 'riskPoint', title: '风险点', width: 120},
                                {field: 'difficultPoint', title: '难度点', width: 120},
                                {field: 'hardDegree', title: '难度系数', width: 120},
                                {
                                    field: 'planType', title: '任务类型', width: 100, templet: function (d) {
                                        return dictionaryObj['TG_TYPE']['object'][d.planType] || ''
                                    }
                                },
                                {
                                    field: 'taskDesc', title: '子任务描述', width: 120
                                }
                            ]]
                        }

                        layer.open({
                            type: 1,
                            title: '详情',
                            area: ['100%', '100%'],
                            btn: ['关闭'],
                            btnAlign: 'c',
                            content: '<table id="layerTable"></table>',
                            success: function () {
                                layuiTable.render({
                                    elem: '#layerTable',
                                    url: '/StatisticalReport/getWorkPlanPlusFormDataDetail',
                                    page: true,
                                    limit: 30,
                                    where: searchData,
                                    cols: cols,
                                    request: {
                                        limitName: 'pageSize'
                                    },
                                    response: {
                                        statusName: 'flag',
                                        statusCode: true,
                                        dataName: 'data',
	                                    countName: 'totleNum'
                                    }
                                })
                            },
                            yes: function (index) {
                                layer.close(index)
                            }
                        })
                    })

                    //查看关键任务填报详情
                    $(document).on('click', '.target_name_link', function () {
                        var tgId = $(this).attr('tgId')
                        $.ajax({
                            url: '/ProjectDaily/selectProjectDailyByItemId',
                            dataType: 'json',
                            type: 'get',
                            data: {tgId: tgId},
                            success: function (res) {
                                var data = res.data;
                                var targetData = res.object;

                                layer.open({
                                    type: 1,
                                    title: '关键任务和填报详情',
                                    area: ['70%', '90%'],
                                    maxmin: true,
                                    min: function () {
                                        $('.layui-layer-shade').hide()
                                    },
                                    content: '<div id="target_detail" style="margin:10px"></div>',
                                    success: function () {
                                        var dayReport = '';

                                        if (!!targetData) {
                                            var str = ''
                                            if (targetData.deptOrProject == 0) {
                                                str = '<tr>' +
                                                    '<td class="td_title">区域责任人</td>' +
                                                    '<td colspan="1">' + isShowNull(targetData.mainAreaUserName).replace(/,$/, '') + '</td>' +
                                                    '<td class="td_title">区域责任部门</td>' +
                                                    '<td colspan="3">' + isShowNull(targetData.mainAreaDeptName).replace(/,$/, '') + '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">区域实际开始时间</td>' +
                                                    '<td colspan="1">' + format(targetData.areaStartDate) + '</td>' +
                                                    '<td class="td_title">区域实际结束时间</td>' +
                                                    '<td colspan="3">' + format(targetData.areaEndDate) + '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">区域需提交的成果材料</td>' +
                                                    '<td colspan="5">' +
                                                    function () {
                                                        if (!!targetData.attachments5 && targetData.attachments5.length > 0) {
                                                            var str = '';

                                                            targetData.attachments5.forEach(function (item) {
                                                                var attachName = item.attachName;
                                                                var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                                var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                var attachmentUrl = item.attUrl;
                                                                attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                                fileExtension = fileExtension.toLowerCase();

                                                                str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                    '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                        if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                        } else {
                                                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                        }
                                                                    }() +
                                                                    '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                    + '</div>' +
                                                                    '</div>'
                                                            });

                                                            return str;
                                                        } else {
                                                            return '';
                                                        }
                                                    }() +
                                                    '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">区域异常原因</td>' +
                                                    '<td colspan="5">' + isShowNull(targetData.areaUnusualRes) + '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">区域异常原因材料</td>' +
                                                    '<td colspan="5">' +
                                                    function () {
                                                        if (!!targetData.attachments7 && targetData.attachments7.length > 0) {
                                                            var str = '';

                                                            targetData.attachments7.forEach(function (item) {
                                                                var attachName = item.attachName;
                                                                var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                                var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                var attachmentUrl = item.attUrl;
                                                                attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                                fileExtension = fileExtension.toLowerCase();

                                                                str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                    '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                        if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                        } else {
                                                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                        }
                                                                    }() +
                                                                    '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                    + '</div>' +
                                                                    '</div>'
                                                            });

                                                            return str;
                                                        } else {
                                                            return '';
                                                        }
                                                    }() +
                                                    '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">总承包部责任人</td>' +
                                                    '<td colspan="1">' + isShowNull(targetData.mainProjectUserName).replace(/,$/, '') + '</td>' +
                                                    '<td class="td_title">总承包部责任部门</td>' +
                                                    '<td colspan="3">' + isShowNull(targetData.mainProjectDeptName).replace(/,$/, '') + '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">总承包部实际开始时间</td>' +
                                                    '<td colspan="1">' + format(targetData.projectStartDate) + '</td>' +
                                                    '<td class="td_title">总承包部实际结束时间</td>' +
                                                    '<td colspan="3">' + format(targetData.projectEndDate) + '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">总承包部需提交的成果材料</td>' +
                                                    '<td colspan="5">' +
                                                    function () {
                                                        if (!!targetData.attachments6 && targetData.attachments6.length > 0) {
                                                            var str = '';

                                                            targetData.attachments6.forEach(function (item) {
                                                                var attachName = item.attachName;
                                                                var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                                var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                var attachmentUrl = item.attUrl;
                                                                attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                                fileExtension = fileExtension.toLowerCase();

                                                                str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                    '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                        if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                        } else {
                                                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                        }
                                                                    }() +
                                                                    '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                    + '</div>' +
                                                                    '</div>'
                                                            });

                                                            return str;
                                                        } else {
                                                            return '';
                                                        }
                                                    }() +
                                                    '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">总承包部异常原因</td>' +
                                                    '<td colspan="5">' + isShowNull(targetData.projectUnusualRes) + '</td>' +
                                                    '</tr>' +
                                                    '<tr>' +
                                                    '<td class="td_title">总承包部异常原因材料</td>' +
                                                    '<td colspan="5">' +
                                                    function () {
                                                        if (!!targetData.attachments8 && targetData.attachments8.length > 0) {
                                                            var str = '';

                                                            targetData.attachments8.forEach(function (item) {
                                                                var attachName = item.attachName;
                                                                var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                                var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                var attachmentUrl = item.attUrl;
                                                                attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                                fileExtension = fileExtension.toLowerCase();

                                                                str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                    '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                        if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                        } else {
                                                                            return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                        }
                                                                    }() +
                                                                    '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                    + '</div>' +
                                                                    '</div>'
                                                            });

                                                            return str;
                                                        } else {
                                                            return '';
                                                        }
                                                    }() +
                                                    '</td>' +
                                                    '</tr>'
                                            }

                                            dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">关键任务详情</h3><table class="layui-table"><tbody>' +
                                                '<tr>' +
                                                '<td class="td_title">关键任务编号</td>' +
                                                '<td colspan="1">' + isShowNull(targetData.tgNo) + '</td>' +
                                                '<td class="td_title">关键任务名称</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.tgName) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">关注等级</td>' +
                                                '<td colspan="1">' + isShowNull(dictionaryObj['CONTROL_LEVEL']['object'][targetData.controlLevel]) + '</td>' +
                                                '<td class="td_title">周期类型</td>' +
                                                '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][targetData.planSycle]) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">关键任务类型</td>' +
                                                '<td colspan="1">' + isShowNull(dictionaryObj['TG_TYPE']['object'][targetData.tgType]) + '</td>' +
                                                '<td class="td_title">计划阶段</td>' +
                                                '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_PHASE']['object'][targetData.planStage]) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">设计量</td>' +
                                                '<td colspan="1">' + isShowNull(targetData.designQuantity) + '</td>' +
                                                '<td class="td_title">工程量</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.itemQuantity) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">单位</td>' +
                                                '<td colspan="1">' + isShowNull(dictionaryObj['UNIT']['object'][targetData.itemQuantityNuit]) + '</td>' +
                                                '<td class="td_title">完成标准</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.resultStandard) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">计划开始时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.planStartDate) {
                                                        return format(targetData.planStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">计划结束时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.planEndDate) {
                                                        return format(targetData.planEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">计划工期</td>' +
                                                '<td>' + isShowNull(targetData.planContinuedDate) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<tr>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '负责人</td>' +
                                                '<td colspan="1">' + isShowNull(targetData.dutyUserName).replace(/,$/, '') + '</td>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '责任部门</td>' +
                                                '<td colspan="3">' + isShowNull(targetData.mainCenterDeptName).replace(/,$/, '') + '</td>' +
                                                '</tr>' +
                                                '<td class="td_title">实际开始时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.realStartDate) {
                                                        return format(targetData.realStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">实际结束时间</td>' +
                                                '<td>' +
                                                function () {
                                                    if (targetData.realEndDate) {
                                                        return format(targetData.realEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() +
                                                '</td>' +
                                                '<td class="td_title">实际工期</td>' +
                                                '<td>' + isShowNull(targetData.realContinuedDate) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '需提交的成果材料</td>' +
                                                '<td colspan="5">' +
                                                function () {
                                                    if (!!targetData.attachments2 && targetData.attachments2.length > 0) {
                                                        var str = '';

                                                        targetData.attachments2.forEach(function (item) {
                                                            var attachName = item.attachName;
                                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                            var attachmentUrl = item.attUrl;
                                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                            fileExtension = fileExtension.toLowerCase();

                                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    } else {
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    }
                                                                }() +
                                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                + '</div>' +
                                                                '</div>'
                                                        });

                                                        return str;
                                                    } else {
                                                        return '';
                                                    }
                                                }() +
                                                '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '异常原因</td>' +
                                                '<td colspan="5">' + isShowNull(targetData.unusualRes) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">' + (targetData.deptOrProject == 0 ? '中心' : '') + '异常原因材料</td>' +
                                                '<td colspan="5">' +
                                                function () {
                                                    if (!!targetData.attachments3 && targetData.attachments3.length > 0) {
                                                        var str = '';

                                                        targetData.attachments3.forEach(function (item) {
                                                            var attachName = item.attachName;
                                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                            var attachmentUrl = item.attUrl;
                                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                            fileExtension = fileExtension.toLowerCase();

                                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    } else {
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    }
                                                                }() +
                                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                + '</div>' +
                                                                '</div>'
                                                        });

                                                        return str;
                                                    } else {
                                                        return '';
                                                    }
                                                }() +
                                                '</td>' +
                                                '</tr>' + str +
                                                '<tr>' +
                                                '<td class="td_title">难度系数</td>' +
                                                '<td>' + isShowNull(targetData.hardDegree) + '</td>' +
                                                '<td class="td_title">风险点</td>' +
                                                '<td>' + isShowNull(targetData.riskPoint) + '</td>' +
                                                '<td class="td_title">难度点</td>' +
                                                '<td>' + isShowNull(targetData.difficultPoint) + '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">成果标准模板</td>' +
                                                '<td colspan="5">' +
                                                function () {
                                                    var resultDictName = '';
                                                    if (!!targetData.resultDict) {
                                                        var resultDictList = targetData.resultDict.split(',');

                                                        resultDictList.forEach(function (item) {
                                                            resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                                        });
                                                    }
                                                    return resultDictName.replace(/,$/, '');
                                                }() +
                                                '</td>' +
                                                '</tr>' +
                                                '<tr>' +
                                                '<td class="td_title">编制依据附件</td>' +
                                                '<td colspan="5">' +
                                                function () {
                                                    if (!!targetData.attachments4 && targetData.attachments4.length > 0) {
                                                        var str = '';

                                                        targetData.attachments4.forEach(function (item) {
                                                            var attachName = item.attachName;
                                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                            var attachmentUrl = item.attUrl;
                                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                            fileExtension = fileExtension.toLowerCase();

                                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    } else {
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    }
                                                                }() +
                                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                + '</div>' +
                                                                '</div>'
                                                        });

                                                        return str;
                                                    } else {
                                                        return '';
                                                    }
                                                }() +
                                                '</td>' +
                                                '</tr>' +
                                                '</tbody></table>';
                                        }

                                        if (!!data) {
                                            dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">关键任务填报信息</h3>';
                                            for (var i = 0; i < data.length; i++) {
                                                dayReport += '<table class="layui-table" style="margin-bottom: 5px">\n' +
                                                    '  <tbody>\n' +
                                                    '    <tr>\n' +
                                                    '      <td class="td_title">每日填报人</td>\n' +
                                                    '      <td>' + isShowNull(data[i].ctreateUserName) + '</td>\n' +
                                                    '      <td class="td_title">时间</td>\n' +
                                                    '      <td>' + isShowNull(data[i].ctreateTime) + '</td>\n' +
                                                    '    </tr>\n' +
                                                    '    <tr>\n' +
                                                    '      <td class="td_title">增加协作人</td>\n' +
                                                    '      <td>' + isShowNull(data[i].assistUserName) + '</td>\n' +
                                                    '      <td class="td_title">当日完成量</td>\n' +
                                                    '      <td>' + function () {
                                                        if (data[i].assistUserName || data[i].transfer) {
                                                            return '—'
                                                        } else {
                                                            return data[i].tadayProgress + '%'
                                                        }
                                                    }() + '</td>\n' +
                                                    '    </tr>\n' +
                                                    '    <tr>\n' +
                                                    '      <td class="td_title">转办</td>\n' +
                                                    '      <td colspan="3">' + isShowNull(data[i].transfer) + '</td>\n' +
                                                    '    </tr>\n' +
                                                    '    <tr>\n' +
                                                    '      <td class="td_title">进展日志</td>\n' +
                                                    '      <td colspan="3">' + isShowNull(data[i].tadayDesc) + '</td>\n' +
                                                    '    </tr>\n' +
                                                    '  </tbody>\n' +
                                                    '</table>';
                                            }
                                        }

                                        $('#target_detail').html(dayReport);
                                    }
                                })
                            }
                        })
                    });
                    //查看子任务填报详情
                    $(document).on('click', '.task_name_link', function () {
                        var planItemId = $(this).attr('planItemId')
                        $.ajax({
                            url: '/ProjectDaily/selectProjectDailyByItemId',
                            dataType: 'json',
                            type: 'get',
                            data: {planItemId: planItemId},
                            success: function (res) {
                                var taskData = res.object;
                                var data = res.data

                                layer.open({
                                    type: 1,
                                    title: '子任务和填报详情',
                                    area: ['70%', '90%'],
                                    maxmin: true,
                                    min: function () {
                                        $('.layui-layer-shade').hide()
                                    },
                                    content: '<div id="task_detail" style="margin:10px"></div>',
                                    success: function () {
                                        var dayReport = '';

                                        if (!!taskData) {
                                            dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">子任务详情</h3><table class="layui-table">\n' +
                                                '  <tbody>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">编号</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.taskNo) + '</td>\n' +
                                                '      <td class="td_title">上级子任务名称</td>\n' +
                                                '      <td colspan="3" class="topItemDetail"></td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">子任务名称</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.taskName) + '</td>\n' +
                                                '      <td class="td_title">关联关键任务</td>\n' +
                                                '      <td colspan="3">' + function () {
                                                    var tgIds = ''
                                                    if (taskData.tgIds) {
                                                        taskData.tgIds.forEach(function (item) {
                                                            tgIds += item.tgName + ','
                                                        })
                                                        return tgIds.replace(/,$/, '')
                                                    } else {
                                                        return '';
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">周期类型</td>\n' +
                                                '      <td colspan="1">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][taskData.planSycle]) + '</td>\n' +
                                                '      <td class="td_title">子任务类型</td>\n' +
                                                '      <td colspan="3">' + isShowNull(dictionaryObj['RENWUJIHUA_TYPE']['object'][taskData.taskType]) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">负责人</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.dutyUserName.replace(/,$/, '')) + '</td>\n' +
                                                '      <td class="td_title">所属部门</td>\n' +
                                                '      <td colspan="3">' + isShowNull(taskData.mainCenterDeptName.replace(/,$/, '')) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">计划开始时间</td>\n' +
                                                '      <td>' + function () {
                                                    if (taskData.planStartDate) {
                                                        return format(taskData.planStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">计划结束时间</td>\n' +
                                                '      <td>' + function () {
                                                    if (taskData.planEndDate) {
                                                        return format(taskData.planEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">计划工期</td>\n' +
                                                '      <td>' + isShowNull(taskData.planContinuedDate) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">实际开始时间</td>\n' +
                                                '      <td>' + function () {
                                                    if (taskData.realStartDate) {
                                                        return format(taskData.realStartDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">实际结束时间</td>\n' +
                                                '      <td>' + function () {
                                                    if (taskData.realEndDate) {
                                                        return format(taskData.realEndDate)
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">实际工期</td>\n' +
                                                '      <td>' + isShowNull(taskData.realContinuedDate) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">前置子任务</td>\n' +
                                                '      <td colspan="1">' + function () {
                                                    var preTasks = ''
                                                    if (taskData.preTasks) {
                                                        taskData.preTasks.forEach(function (item) {
                                                            preTasks += item.workItemName + ','
                                                        })
                                                        return preTasks.replace(/,$/, '')
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '      <td class="td_title">完成标准</td>\n' +
                                                '      <td colspan="3">' + isShowNull(taskData.resultStandard) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">子任务描述</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.taskDesc) + '</td>\n' +
                                                '      <td class="td_title">协助部门</td>\n' +
                                                '      <td colspan="3">' + function () {
                                                    if (taskData.assistCompanyDeptsName) {
                                                        return isShowNull(taskData.assistCompanyDeptsName.replace(/,$/, ''))
                                                    } else {
                                                        return ''
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '<tr>' +
                                                '<td class="td_title">成果标准模板</td>' +
                                                '<td colspan="5">' +
                                                function () {
                                                    var resultDictName = '';
                                                    if (!!taskData.resultDict) {
                                                        var resultDictList = taskData.resultDict.split(',');

                                                        resultDictList.forEach(function (item) {
                                                            resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                                        });
                                                    }

                                                    return resultDictName.replace(/,$/, '');
                                                }() +
                                                '</td>' +
                                                '</tr>' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">需提交的成果材料</td>\n' +
                                                '      <td colspan="5">' + function () {
                                                    if (!!taskData.attachments2 && taskData.attachments2.length > 0) {
                                                        var str = '';

                                                        taskData.attachments2.forEach(function (item) {
                                                            var attachName = item.attachName;
                                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                            var attachmentUrl = item.attUrl;
                                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                            fileExtension = fileExtension.toLowerCase();

                                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    } else {
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    }
                                                                }() +
                                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                + '</div>' +
                                                                '</div>'
                                                        });

                                                        return str;
                                                    } else {
                                                        return '';
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">异常原因</td>\n' +
                                                '      <td colspan="5">' + isShowNull(taskData.unusualRes) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">异常原因材料</td>\n' +
                                                '      <td colspan="5">' + function () {
                                                    if (!!taskData.attachments3 && taskData.attachments3.length > 0) {
                                                        var str = '';

                                                        taskData.attachments3.forEach(function (item) {
                                                            var attachName = item.attachName;
                                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                            var attachmentUrl = item.attUrl;
                                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                            fileExtension = fileExtension.toLowerCase();

                                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    } else {
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    }
                                                                }() +
                                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                + '</div>' +
                                                                '</div>'
                                                        });

                                                        return str;
                                                    } else {
                                                        return '';
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">难度点</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.difficultPoint) + '</td>\n' +
                                                '      <td class="td_title">风险点</td>\n' +
                                                '      <td colspan="3">' + isShowNull(taskData.riskPoint) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">编制依据附件</td>\n' +
                                                '      <td colspan="5">' + function () {
                                                    if (!!taskData.attachments4 && taskData.attachments4.length > 0) {
                                                        var str = '';

                                                        taskData.attachments4.forEach(function (item) {
                                                            var attachName = item.attachName;
                                                            var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                            var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                            var attachmentUrl = item.attUrl;
                                                            attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                            fileExtension = fileExtension.toLowerCase();

                                                            str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                    if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    } else {
                                                                        return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                    }
                                                                }() +
                                                                '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                + '</div>' +
                                                                '</div>'
                                                        });

                                                        return str;
                                                    } else {
                                                        return '';
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    </tr>\n' +
                                                '  </tbody>\n' +
                                                '</table>';

                                            if (taskData.plcAssistList.length > 0) {
                                                dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">协助子任务信息</h3>';
                                                taskData.plcAssistList.forEach(function (obj) {
                                                    dayReport += '<table class="layui-table" style="margin-bottom: 5px;">\n' +
                                                        '  <tbody>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">协助人</td>\n' +
                                                        '      <td colspan="1">' + isShowNull(obj.assistUserName) + '</td>\n' +
                                                        '      <td class="td_title">协助部门</td>\n' +
                                                        '      <td colspan="3">' + isShowNull(obj.assistDeptName) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">完成状态</td>\n' +
                                                        '      <td colspan="1">' + isShowNull(obj.taskStatus) + '</td>\n' +
                                                        '      <td class="td_title">任务进度</td>\n' +
                                                        '      <td colspan="3">' + isShowNull(obj.taskPrecess) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">计划开始时间</td>\n' +
                                                        '      <td colspan="1">' + format(obj.planStartDate) + '</td>\n' +
                                                        '<td class="td_title">计划完成时间</td>\n' +
                                                        '      <td colspan="3">' + format(obj.planEndDate) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">实际完成时间</td>\n' +
                                                        '      <td colspan="3">' + format(obj.realEndDate) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">最终成果</td>\n' +
                                                        '      <td colspan="5">' + function () {
                                                            if (!!obj.attment1 && obj.attment1.length > 0) {
                                                                var str = '';

                                                                obj.attment1.forEach(function (item) {
                                                                    var attachName = item.attachName;
                                                                    var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                                    var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                    var attachmentUrl = item.attUrl;
                                                                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                                    fileExtension = fileExtension.toLowerCase();

                                                                    str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                        '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                            if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                            } else {
                                                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                            }
                                                                        }() +
                                                                        '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                        + '</div>' +
                                                                        '</div>'
                                                                });

                                                                return str;
                                                            } else {
                                                                return '';
                                                            }
                                                        }() + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">异常支撑材料</td>\n' +
                                                        '      <td colspan="3">' + isShowNull(obj.unusualStuff) + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '    <tr>\n' +
                                                        '      <td class="td_title">最终成果</td>\n' +
                                                        '      <td colspan="5">' + function () {
                                                            if (!!obj.attachments2 && obj.attachments2.length > 0) {
                                                                var str = '';

                                                                obj.attachments2.forEach(function (item) {
                                                                    var attachName = item.attachName;
                                                                    var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                                    var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                                    var attachmentUrl = item.attUrl;
                                                                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                                    fileExtension = fileExtension.toLowerCase();

                                                                    str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                                        '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                            if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                            } else {
                                                                                return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                            }
                                                                        }() +
                                                                        '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                                        + '</div>' +
                                                                        '</div>'
                                                                });

                                                                return str;
                                                            } else {
                                                                return '';
                                                            }
                                                        }() + '</td>\n' +
                                                        '    </tr>\n' +
                                                        '  </tbody>\n' +
                                                        '</table>'
                                                })
                                            }
                                        }

                                        dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">子任务填报信息</h3>';
                                        for (var i = 0; i < data.length; i++) {
                                            dayReport += '<table class="layui-table" style="margin-bottom: 5px;">\n' +
                                                '  <tbody>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">每日填报人</td>\n' +
                                                '      <td>' + isShowNull(data[i].ctreateUserName) + '</td>\n' +
                                                '      <td class="td_title">时间</td>\n' +
                                                '      <td>' + isShowNull(data[i].ctreateTime) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">增加协作人</td>\n' +
                                                '      <td>' + isShowNull(data[i].assistUserName) + '</td>\n' +
                                                '      <td class="td_title">当日完成量</td>\n' +
                                                '      <td>' + function () {
                                                    if (data[i].assistUserName || data[i].transfer) {
                                                        return '—'
                                                    } else {
                                                        return data[i].tadayProgress + '%'
                                                    }
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">转办</td>\n' +
                                                '      <td colspan="3">' + isShowNull(data[i].transfer) + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">进展日志</td>\n' +
                                                '      <td colspan="3">' + isShowNull(data[i].tadayDesc) + '</td>\n' +
                                                '    </tr>\n' +
                                                '  </tbody>\n' +
                                                '</table>'
                                        }
                                        $('#task_detail').append(dayReport)
                                    }
                                })
                            }
                        })
                    });
                })
            }

            function loadChart(searchData) {
                searchData = !!searchData ? searchData : {}
                // 项目统计数量
                $.get('/StatisticalReport/getWorkPlanPlusProjectCount', searchData, function (res) {
                    if (res.flag) {
                        $('.project_count').text(res.data.projectSum)
                        $('.pro_going').text(res.data.ingExecutedSum)
                        $('.pro_no_allocation').text(res.data.noAllocationSum)
                        $('.pro_delay').text(res.data.delaySum)
                        $('.pro_finish').text(res.data.finishSum)
                    }
                })
                // 职能统计数量
                $.get('/StatisticalReport/getWorkPlanPlusFunctionCount', searchData, function (res) {
                    if (res.flag) {
                        $('.dept_count').text(res.data.targetTaskSum)
                        $('.task_count').text(res.data.itemSum)
                        $('.dept_going').text(res.data.ingExecutedSum)
                        $('.dept_no_allocation').text(res.data.noAllocationSum)
                        $('.dept_delay').text(res.data.delaySum)
                        $('.dept_finish').text(res.data.finishSum)
                    }
                })
                // 项目计划 饼状图
                $.get('/StatisticalReport/getWorkPlanPlusProjectPlan', searchData, function (res) {
                    if (res.flag) {
                        chartOne.setOption({
                            title: {
                                show: true,
                                text: '项目计划',
                                left: 'center'
                            },
                            color: ['#A5A5A5', '#FFC000', '#70AD47', '#4472C4'],
                            tooltip: {
                                trigger: 'item',
                                formatter: '{a} <br/>{b} : {c} ({d}%)'
                            },
                            legend: {
                                orient: 'vertical',
                                left: 'left',
                                top: 45,
                                data: ['编制', '审批', '执行', '完成']
                            },
                            series: [
                                {
                                    name: '项目计划',
                                    type: 'pie',
                                    radius: '55%',
                                    center: ['60%', '50%'],
                                    label: {
                                        show: true,
                                        formatter: '{b}：{c}'
                                    },
                                    emphasis: {
                                        itemStyle: {
                                            shadowBlur: 10,
                                            shadowOffsetX: 0,
                                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                                        }
                                    },
                                    data: [
                                        {
                                            name: '编制',
                                            value: res.data.writeSum
                                        },
                                        {
                                            name: '审批',
                                            value: res.data.approve
                                        },
                                        {
                                            name: '执行',
                                            value: res.data.executedSum
                                        },
                                        {
                                            name: '完成',
                                            value: res.data.finishSum
                                        }
                                    ]
                                }
                            ]
                        }, true)
                    } else {
                        chartOne.setOption({}, true)
                    }
                })
                // 计划阶段 柱状图
                $.get('/StatisticalReport/getWorkPlanPlusPlanStage', searchData, function (res) {
                    if (res.flag) {
                        var xAxisData = []
                        var onGoingArr = []
                        var willExpireArr = []
                        var delayArr = []
                        var noAllocationArr = []
                        res.data.forEach(function (item) {
                            xAxisData.push(item.name)
                            onGoingArr.push(item.ingSum)
                            willExpireArr.push(item.willExpireSum)
                            delayArr.push(item.delaySum)
                            noAllocationArr.push(item.noAllocationSum)
                        })
                        chartTwo.setOption({
                            grid: {
                                top: 30
                            },
                            title: {
                                show: true,
                                text: '计划阶段',
                                left: 'center'
                            },
                            color: ['#5B9BD5', '#ED7D31', '#A5A5A5', '#FFC000'],
                            tooltip: {
                                trigger: 'axis'
                            },
                            legend: {
                                bottom: 10,
                                data: ['未分配', '进行中', '将到期', '已延期']
                            },
                            calculable: true,
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xAxisData
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value'
                                }
                            ],
                            series: [
                                {
                                    name: '未分配',
                                    type: 'bar',
                                    data: noAllocationArr,
                                    markLine: {
                                        data: [
                                            {type: 'average', name: '平均值'}
                                        ]
                                    }
                                },
                                {
                                    name: '进行中',
                                    type: 'bar',
                                    data: onGoingArr,
                                    markLine: {
                                        data: [
                                            {type: 'average', name: '平均值'}
                                        ]
                                    }
                                },
                                {
                                    name: '将到期',
                                    type: 'bar',
                                    data: willExpireArr,
                                    markLine: {
                                        data: [
                                            {type: 'average', name: '平均值'}
                                        ]
                                    }
                                },
                                {
                                    name: '已延期',
                                    type: 'bar',
                                    data: delayArr,
                                    markLine: {
                                        data: [
                                            {type: 'average', name: '平均值'}
                                        ]
                                    }
                                }
                            ]
                        }, true)
                    } else {
                        chartTwo.setOption({}, true)
                    }
                })
                // 当月计划执行情况
                $.get('/StatisticalReport/getWorkPlanPlusCurrentPlanExecute', searchData, function (res) {
                    if (res.flag) {
                        var xAxisData = [],
                            noStartArr = [],
                            ingExecutedArr = [],
                            willExpireArr = [],
                            delayArr = [],
                            delayFinishArr = [],
                            finishArr = [];
                        res.data.forEach(function (item) {
                            xAxisData.push(item.name)
                            noStartArr.push(item.noStartSum)
                            ingExecutedArr.push(item.ingExecutedSum)
                            willExpireArr.push(item.willExpireSum)
                            delayArr.push(item.delaySum)
                            delayFinishArr.push(item.delayFinishSum)
                            finishArr.push(item.FinishSum)
                        })
                        chartThree.setOption({
                            grid: {
                                top: 30,
                                bottom: 70
                            },
                            title: {
                                show: true,
                                text: '当月执行情况',
                                left: 'center'
                            },
                            color: ['#5B9BD5', '#ED7D31', '#A5A5A5', '#FFC000', '#4472C4', '#70AD47'],
                            tooltip: {
                                trigger: 'axis'
                            },
                            legend: {
                                type: 'scroll',
                                bottom: 10,
                                data: ['未开始', '进行中', '将到期', '已延期', '延期完成', '完成']
                            },
                            calculable: true,
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xAxisData,
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 20
                                    }
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value'
                                }
                            ],
                            series: [
                                {
                                    name: '未开始',
                                    barWidth: '20px',
                                    data: noStartArr,
                                    type: 'bar',
                                    stack: 'key_1'
                                },
                                {
                                    name: '进行中',
                                    type: 'bar',
                                    barWidth: '20px',
                                    data: ingExecutedArr,
                                    stack: 'key_1'
                                },
                                {
                                    name: '将到期',
                                    type: 'bar',
                                    barWidth: '20px',
                                    data: willExpireArr,
                                    stack: 'key_1'
                                },
                                {
                                    name: '已延期',
                                    type: 'bar',
                                    barWidth: '20px',
                                    data: delayArr,
                                    stack: 'key_1'
                                },
                                {
                                    name: '延期完成',
                                    type: 'bar',
                                    barWidth: '20px',
                                    data: delayFinishArr,
                                    stack: 'key_1'
                                },
                                {
                                    name: '完成',
                                    type: 'bar',
                                    barWidth: '20px',
                                    data: finishArr,
                                    stack: 'key_1'
                                }
                            ]
                        }, true)
                    } else {
                        chartThree.setOption({}, true)
                    }
                })
                // 上月计划完成情况
                $.get('/StatisticalReport/getWorkPlanPlusLastPlanFinish', searchData, function (res) {
                    if (res.flag) {
                        var xAxisData = [],
                            delayFinishArr = [],
                            finishArr = [];
                        res.data.forEach(function (item) {
                            xAxisData.push(item.name)
                            delayFinishArr.push(item.delayfinishSum)
                            finishArr.push(item.finishSum)
                        })
                        chartFour.setOption({
                            grid: {
                                top: 30,
                                bottom: 70
                            },
                            title: {
                                show: true,
                                text: '上月计划完成情况',
                                left: 'center'
                            },
                            color: ['#5B9BD5', '#ED7D31'],
                            tooltip: {
                                trigger: 'axis'
                            },
                            legend: {
                                bottom: 10,
                                data: ['完成', '延期完成']
                            },
                            calculable: true,
                            xAxis: [
                                {
                                    type: 'category',
                                    data: xAxisData,
                                    axisLabel: {
                                        interval: 0,
                                        rotate: 20
                                    }
                                }
                            ],
                            yAxis: [
                                {
                                    type: 'value'
                                }
                            ],
                            series: [
                                {
                                    name: '完成',
                                    type: 'bar',
                                    barWidth: '20px',
                                    data: finishArr,
                                    stack: 'key_1'
                                },
                                {
                                    name: '延期完成',
                                    type: 'bar',
                                    barWidth: '20px',
                                    data: delayFinishArr,
                                    stack: 'key_1'
                                }
                            ]
                        }, true)
                    } else {
                        chartFour.setOption({}, true)
                    }
                })
            }

            /**
             * 处理柱状图数据
             * @param tableData
             * @returns {{xType: [], seriesData: [], legendData: []}}
             */
            function initBarData(tableData) {
                var baseLegend = ['未开始', '进行中', '已完成'];
                var legendData = [];

                // xType存放的是横坐标
                var xType = [];
                // 创建一个数组，用来装对象传给series.data，因为series.data里面不能直接写for循环
                var seriesData = [];

                //遍历baseLegend，将legend 的data做出来，就是legendData
                for (var i = 0; i < baseLegend.length; i++) {
                    legendData.push("项目关键任务" + baseLegend[i]);
                    legendData.push("职能关键任务" + baseLegend[i]);
                    legendData.push("子任务" + baseLegend[i]);
                }

                var tgProNotStarted = [], tgProOngoing = [], tgProCompleted = [],
                    tgDeptNotStarted = [], tgDeptOngoing = [], tgDeptCompleted = [],
                    itemNotStarted = [], itemOngoing = [], itemCompleted = [];

                var dataArray = [];

                for (var i = 0; i < tableData.length; i++) {
                    xType.push(tableData[i].deptName);

                    tgProNotStarted.push(parseInt(tableData[i].tarProjCount.allocationSum) + parseInt(tableData[i].tarProjCount.noAllocationSum) + parseInt(tableData[i].tarProjCount.outTimeNotAllocationSum));
                    tgProOngoing.push(parseInt(tableData[i].tarProjCount.normalInProgressSum) + parseInt(tableData[i].tarProjCount.willExpireSum) + parseInt(tableData[i].tarProjCount.delaySum));
                    tgProCompleted.push(parseInt(tableData[i].tarProjCount.delayFinishSum) + parseInt(tableData[i].tarProjCount.normalFinishSum));

                    tgDeptNotStarted.push(parseInt(tableData[i].tarDeptCount.allocationSum) + parseInt(tableData[i].tarDeptCount.noAllocationSum) + parseInt(tableData[i].tarDeptCount.outTimeNotAllocationSum));
                    tgDeptOngoing.push(parseInt(tableData[i].tarDeptCount.normalInProgressSum) + parseInt(tableData[i].tarDeptCount.willExpireSum) + parseInt(tableData[i].tarDeptCount.delaySum));
                    tgDeptCompleted.push(parseInt(tableData[i].tarDeptCount.delayFinishSum) + parseInt(tableData[i].tarDeptCount.normalFinishSum));

                    itemNotStarted.push(parseInt(tableData[i].itemCount.allocationSum) + parseInt(tableData[i].itemCount.noAllocationSum) + parseInt(tableData[i].itemCount.outTimeNotAllocationSum));
                    itemOngoing.push(parseInt(tableData[i].itemCount.normalInProgressSum) + parseInt(tableData[i].itemCount.willExpireSum) + parseInt(tableData[i].itemCount.delaySum));
                    itemCompleted.push(parseInt(tableData[i].itemCount.delayFinishSum) + parseInt(tableData[i].itemCount.normalFinishSum));
                }

                dataArray.push(tgProNotStarted, tgDeptNotStarted, itemNotStarted, tgProOngoing, tgDeptOngoing, itemOngoing, tgProCompleted, tgDeptCompleted, itemCompleted);

                for (var i = 0; i < legendData.length; i++) {
                    var obj = {
                        barWidth: '20px',
                        name: legendData[i],
                        data: dataArray[i],
                        type: 'bar',
                        stack: 'key_' + (i % 3)
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

                chartFive.setOption({
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
                        type: 'scroll',
                        left: 'center',
                        data: barData.legendData,
                        y: 'bottom',
                        width: '80%'
                    },
                    grid: {
                        top: 30,
                        right: '5%',
                        bottom: '15%',
                        left: '5%',
                        containLabel: true
                    },
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
                    series: barData.seriesData
                });
            }

            /**
             * 处理数据
             * @param tableData
             * @returns {*}
             */
            function initTableData(tableData) {

                var newData = {
                    tableData: [],
                    itemCols: [
                        {
                            field: 'tgProAllocation',
                            title: '已分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['项目关键任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="allocation" deptId="' + d.deptId + '" type="targetProject">' + d.tgProAllocation + '</span>';
                            }
                        },
                        {
                            field: 'tgProUnliquidated',
                            title: '未分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['项目关键任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="noAllocation" deptId="' + d.deptId + '" type="targetProject">' + d.tgProUnliquidated + '</span>';
                            }
                        },
                        {
                            field: 'tgProExtensionUnliquidated',
                            title: '延期未分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['项目关键任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="outTimeNotAllocation" deptId="' + d.deptId + '" type="targetProject">' + d.tgProExtensionUnliquidated + '</span>';
                            }
                        },
                        {
                            field: 'tgProNormal',
                            title: '正常进行',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['项目关键任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="normalInProgress" deptId="' + d.deptId + '" type="targetProject">' + d.tgProNormal + '</span>';
                            }
                        },
                        {
                            field: 'tgProDue',
                            title: '将到期',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['项目关键任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="willExpire" deptId="' + d.deptId + '" type="targetProject">' + d.tgProDue + '</span>';
                            }
                        },
                        {
                            field: 'tgProDeferred',
                            title: '已延期',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['项目关键任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="delay" deptId="' + d.deptId + '" type="targetProject">' + d.tgProDeferred + '</span>';
                            }
                        },
                        {
                            field: 'tgProExtensionCompletion',
                            title: '延期完成',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['项目关键任务已完成'],
                            style: 'background-color: #d1f3bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="delayFinish" deptId="' + d.deptId + '" type="targetProject">' + d.tgProExtensionCompletion + '</span>';
                            }
                        },
                        {
                            field: 'tgProNormalCompletion',
                            title: '正常完成',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['项目关键任务已完成'],
                            style: 'background-color: #d1f3bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="normalFinish" deptId="' + d.deptId + '" type="targetProject">' + d.tgProNormalCompletion + '</span>';
                            }
                        },
                        {
                            field: 'tgDeptAllocation',
                            title: '已分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['职能关键任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="allocation" deptId="' + d.deptId + '" type="targetDept">' + d.tgDeptAllocation + '</span>';
                            }
                        },
                        {
                            field: 'tgDeptUnliquidated',
                            title: '未分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['职能关键任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="noAllocation" deptId="' + d.deptId + '" type="targetDept">' + d.tgDeptUnliquidated + '</span>';
                            }
                        },
                        {
                            field: 'tgDeptExtensionUnliquidated',
                            title: '延期未分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['职能关键任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="outTimeNotAllocation" deptId="' + d.deptId + '" type="targetDept">' + d.tgDeptExtensionUnliquidated + '</span>';
                            }
                        },
                        {
                            field: 'tgDeptNormal',
                            title: '正常进行',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['职能关键任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="normalInProgress" deptId="' + d.deptId + '" type="targetDept">' + d.tgDeptNormal + '</span>';
                            }
                        },
                        {
                            field: 'tgDeptDue',
                            title: '将到期',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['职能关键任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="willExpire" deptId="' + d.deptId + '" type="targetDept">' + d.tgDeptDue + '</span>';
                            }
                        },
                        {
                            field: 'tgDeptDeferred',
                            title: '已延期',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['职能关键任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="delay" deptId="' + d.deptId + '" type="targetDept">' + d.tgDeptDeferred + '</span>';
                            }
                        },
                        {
                            field: 'tgDeptExtensionCompletion',
                            title: '延期完成',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['职能关键任务已完成'],
                            style: 'background-color: #d1f3bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="delayFinish" deptId="' + d.deptId + '" type="targetDept">' + d.tgDeptExtensionCompletion + '</span>';
                            }
                        },
                        {
                            field: 'tgDeptNormalCompletion',
                            title: '正常完成',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['职能关键任务已完成'],
                            style: 'background-color: #d1f3bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="normalFinish" deptId="' + d.deptId + '" type="targetDept">' + d.tgDeptNormalCompletion + '</span>';
                            }
                        },
                        {
                            field: 'itemAllocation',
                            title: '已分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['子任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="allocation" deptId="' + d.deptId + '" type="item">' + d.itemAllocation + '</span>';
                            }
                        },
                        {
                            field: 'itemUnliquidated',
                            title: '未分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['子任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="noAllocation" deptId="' + d.deptId + '" type="item">' + d.itemUnliquidated + '</span>';
                            }
                        },
                        {
                            field: 'itemExtensionUnliquidated',
                            title: '延期未分配',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['子任务未开始'],
                            style: 'background-color: #bff3f3;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="outTimeNotAllocation" deptId="' + d.deptId + '" type="item">' + d.itemExtensionUnliquidated + '</span>';
                            }
                        },
                        {
                            field: 'itemNormal',
                            title: '正常进行',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['子任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="normalInProgress" deptId="' + d.deptId + '" type="item">' + d.itemNormal + '</span>';
                            }
                        },
                        {
                            field: 'itemDue',
                            title: '将到期',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['子任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="willExpire" deptId="' + d.deptId + '" type="item">' + d.itemDue + '</span>';
                            }
                        },
                        {
                            field: 'itemDeferred',
                            title: '已延期',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['子任务进行中'],
                            style: 'background-color: #f3e5bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="delay" deptId="' + d.deptId + '" type="item">' + d.itemDeferred + '</span>';
                            }
                        },
                        {
                            field: 'itemExtensionCompletion',
                            title: '延期完成',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['子任务已完成'],
                            style: 'background-color: #d1f3bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="delayFinish" deptId="' + d.deptId + '" type="item">' + d.itemExtensionCompletion + '</span>';
                            }
                        },
                        {
                            field: 'itemNormalCompletion',
                            title: '正常完成',
                            minWidth: 100,
                            align: 'center',
                            hide: typeObj['子任务已完成'],
                            style: 'background-color: #d1f3bf;',
                            templet: function (d) {
                                return '<span class="num_link" style="cursor: pointer;" typeStatus="normalFinish" deptId="' + d.deptId + '" type="item">' + d.itemNormalCompletion + '</span>';
                            }
                        }
                    ]
                }

                tableData.forEach(function (item) {
                    var obj = {}
                    obj.deptId = item.deptId;
                    obj.deptName = item.deptName;
                    obj.haveChild = item.haveChild;
                    obj.deptType = item.deptType;

                    // 项目关键任务
                    obj.tgProAllocation = item.tarProjCount.allocationSum; // 已分配
                    obj.tgProUnliquidated = item.tarProjCount.noAllocationSum; // 未分配
                    obj.tgProExtensionUnliquidated = item.tarProjCount.outTimeNotAllocationSum; // 延期未分配
                    obj.tgProNormal = item.tarProjCount.normalInProgressSum; // 正常进行
                    obj.tgProDue = item.tarProjCount.willExpireSum; // 将到期
                    obj.tgProDeferred = item.tarProjCount.delaySum; // 已延期
                    obj.tgProExtensionCompletion = item.tarProjCount.delayFinishSum; // 延期完成
                    obj.tgProNormalCompletion = item.tarProjCount.normalFinishSum; // 正常完成

                    // 职能关键任务
                    obj.tgDeptAllocation = item.tarDeptCount.allocationSum; // 已分配
                    obj.tgDeptUnliquidated = item.tarDeptCount.noAllocationSum; // 未分配
                    obj.tgDeptExtensionUnliquidated = item.tarDeptCount.outTimeNotAllocationSum; // 延期未分配
                    obj.tgDeptNormal = item.tarDeptCount.normalInProgressSum; // 正常进行
                    obj.tgDeptDue = item.tarDeptCount.willExpireSum; // 将到期
                    obj.tgDeptDeferred = item.tarDeptCount.delaySum; // 已延期
                    obj.tgDeptExtensionCompletion = item.tarDeptCount.delayFinishSum; // 延期完成
                    obj.tgDeptNormalCompletion = item.tarDeptCount.normalFinishSum; // 正常完成

                    // 子任务
                    obj.itemAllocation = item.itemCount.allocationSum; // 已分配
                    obj.itemUnliquidated = item.itemCount.noAllocationSum; // 未分配
                    obj.itemExtensionUnliquidated = item.itemCount.outTimeNotAllocationSum; // 延期未分配
                    obj.itemNormal = item.itemCount.normalInProgressSum; // 正常进行
                    obj.itemDue = item.itemCount.willExpireSum; // 将到期
                    obj.itemDeferred = item.itemCount.delaySum; // 已延期
                    obj.itemExtensionCompletion = item.itemCount.delayFinishSum; // 延期完成
                    obj.itemNormalCompletion = item.itemCount.normalFinishSum; // 正常完成

                    newData.tableData.push(obj);
                });

                return newData
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
                            str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>';
                        });
                    }
                    if (fn) {
                        fn(str);
                    }
                });
            }

            /**
             * 设置本地存储
             * @param key (键)
             * @param value (值)
             * @param salt (前缀)
             */
            function setLocalStorage(key, value, salt) {
                localStorage.setItem(salt + key, value);
            }

            /**
             * 获取本地存储
             * @param key (键)
             * @param salt (前缀)
             * @returns {string | string}
             */
            function getLocalStorage(key, salt) {
                var value = localStorage.getItem(salt + key) || '';
                return value;
            }

            /**
             * 移除本地存储
             * @param key (键)
             * @param salt (前缀)
             */
            function removeLocalStorage(key, salt) {
                localStorage.removeItem(salt + key);
            }

            //将毫秒数转为yyyy-MM-dd格式时间
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

             /**
             * 判断是否显示空
             * @param data
             */
            function isShowNull(data) {
                if (!!data) {
                    return data;
                } else {
                    return '';
                }
            }

            /**
             * 将毫秒数转为(yyyy-MM-dd)格式时间
             * @param t (时间戳)
             * @returns {string}
             */
            function formatDate(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }
		</script>
	</body>
</html>
