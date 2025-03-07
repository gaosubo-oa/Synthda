<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/8/10
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	Long datetime = new Date().getTime(); // 获取系统时间
%>
<!DOCTYPE html>
<html>
	<head>
		<title>计划子任务报表</title>
		
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/js/base/base.js?<%=datetime%>"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js?<%=datetime%>"></script>
		<script type="text/javascript" src="/js/echarts.min.js"></script>
		
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
				height: 100%;
				margin-top: 2px;
			}
			
			.search_form .query_btn {
				float: right;
				width: 55px;
				margin-right: 20px;
				margin-left: 0;
			}
			
			/* 查询表单样式 EDN */
			
			/* 表格头部工具按钮样式 START */
			
			.layui-table-tool {
				height: 38px;
				min-height: 38px !important;
				padding: 3px 15px !important;
			}
			
			.layui-table-tool-temp {
				padding-right: 0;
			}
			
			/* 表格头部工具按钮样式 END */
			
			.td_img {
				width: 20px;
			}
			
			.td_title {
				min-width: 160px;
				width: 15%;
				text-align: right;
				color: #000;
				background-color: #e7e7e7;
			}
			
			.td_content {
				width: 35%;
			}
			
			.divShow {
				position: relative;
			}
			
			.operationDiv {
				display: none;
				position: absolute;
				top: -40px;
				left: 5px;
				border-radius: 5px;
				background: #fff;
				box-shadow: 0 0 3px 1px rgba(0, 0, 0, .3);
			}
			
			.divShow:hover .operationDiv {
				display: block;
			}
		
		</style>
	
	</head>
	<body>
		<div class="container">
			<div class="search_module">
				<form class="layui-form clearfix search_form" lay-filter="searchForm">
					<div class="layui-form-item query_item">
						<label class="layui-form-label">子任务类型:</label>
						<div class="layui-input-block">
							<select name="taskType">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item query_item">
						<label class="layui-form-label">年度:</label>
						<div class="layui-input-block">
							<select name="planYear" lay-filter="planYear">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item query_item">
						<label class="layui-form-label">月度:</label>
						<div class="layui-input-block">
							<select name="planMonth">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item query_item">
						<label class="layui-form-label">责任人:</label>
						<div class="layui-input-block">
							<input type="text" id="dutyUser" readonly placeholder="请选择" style="cursor: pointer; background-color: #e7e7e7;" autocomplete="off"
							       class="layui-input">
						</div>
					</div>
					<div class="layui-form-item query_item">
						<label class="layui-form-label">所属部门:</label>
						<div class="layui-input-block">
							<input type="text" id="itemBelongDepts" readonly placeholder="请选择" style="cursor: pointer; background-color: #e7e7e7;"
							       autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item query_item">
						<label class="layui-form-label">状态:</label>
						<div class="layui-input-block">
							<div id="taskStatusSelect" class="xm-select-demo"></div>
						</div>
					</div>
					<div class="query_button_group query_item">
						<button type="reset" id="resetBtn" class="layui-btn layui-btn-sm query_btn" style="margin-right: 0;">重置</button>
						<button type="button" id="searchBtn" class="layui-btn layui-btn-sm query_btn">查询</button>
					</div>
				</form>
			</div>
			
			<div class="content">
				<div id="container" style="margin: 10px auto;height: 340px;"></div>
				<table id="planTaskTable" lay-filter="planTaskTable"></table>
			</div>
		</div>
		
		<script type="text/html" id="planTaskBar">
			<div class="clearfix">
				<a class="layui-btn layui-btn-sm pie_chart" style="float: right;margin-left: 10px;" lay-event="pieChart">图表<i class="layui-icon layui-icon-up"></i></a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="projectDetail">甘特图</a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="projectDetail">网络图</a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="projectDetail">导出</a>
			</div>
		</script>
		
		<script type="text/javascript">
			
			var nowDateObj = {
			    year: new Date().getFullYear(),
				month: new Date().getMonth()
			}
			// 如果为1月，则显示上一年12月
            if (nowDateObj.month == 0) {
                nowDateObj.year -= 1;
                nowDateObj.month = 12;
            }

            // 获取当前登录人信息
            $.get('/getLoginUser', function (res) {
                if (res.flag && res.object) {
                    $('#itemBelongDepts').val(res.object.deptName);
                    $('#itemBelongDepts').attr('deptid', res.object.deptId);
                }
            });
			
            var myChart = echarts.init(document.getElementById('container'));

            var pieUserData = {}

            var option = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                legend: {
                    top: '10',
                    data: ['未开始', '进行中', '将到期', '已延期', '完成', '延期完成', '其他', '难度系数'],
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'category',
                        data: [],
                    }
                ],
                yAxis: [
                    {
                        type: 'value',
                        scale: true,
                        name: '总难度系数',
                        // max: 1200,
                        min: 0,
                        boundaryGap: [0.2, 0.2]
                    },
                    {
                        type: 'value',
                        scale: true,
                        name: '总子任务数',
                        // max: 30,
                        min: 0,
                        boundaryGap: [0.2, 0.2]
                    }
                ],
                series: [
                    {
                        name: '未开始',
                        type: 'bar',
                        stack: 'bar',
                        barWidth: '50px',
                        yAxisIndex: 1,
                        data: []
                    },
                    {
                        name: '进行中',
                        type: 'bar',
                        stack: 'bar',
                        barWidth: '50px',
                        yAxisIndex: 1,
                        data: []
                    },
                    {
                        name: '将到期',
                        type: 'bar',
                        stack: 'bar',
                        barWidth: '50px',
                        yAxisIndex: 1,
                        data: []
                    },
                    {
                        name: '已延期',
                        type: 'bar',
                        stack: 'bar',
                        barWidth: '50px',
                        yAxisIndex: 1,
                        data: []
                    },
                    {
                        name: '完成',
                        type: 'bar',
                        stack: 'bar',
                        barWidth: '50px',
                        yAxisIndex: 1,
                        data: []
                    },
                    {
                        name: '延期完成',
                        type: 'bar',
                        stack: 'bar',
                        barWidth: '50px',
                        yAxisIndex: 1,
                        data: []
                    },
                    {
                        name: '其他',
                        type: 'bar',
                        stack: 'bar',
                        barWidth: '50px',
                        yAxisIndex: 1,
                        data: []
                    },
                    {
                        name: '难度系数',
                        type: 'line',
                        stack: 'line',
                        data: []
                    },
                ]
            };
            myChart.setOption(option);

            // loadPieModule();

            resizeQuery();

            window.onresize = function () {
                resizeQuery();
                myChart.resize();
            }

            var user_id = '';
            var dept_id = '';

            var dictionaryObj = {
                UNIT: {},
                CONTROL_LEVEL: {},
                RENWUJIHUA_TYPE: {},
                PLAN_SYCLE: {},
                PLAN_PHASE: {},
                CGCL_TYPE: {},
				TG_TYPE: {},
            }
            var dictionaryStr = 'UNIT,CONTROL_LEVEL,RENWUJIHUA_TYPE,PLAN_SYCLE,PLAN_PHASE,CGCL_TYPE,TG_TYPE';
            // 获取数据字典数据
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: ''}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
                            });
                        }
                    }
                }
                init();
            });

            function init() {
                layui.use(['form', 'table', 'xmSelect'], function () {
                    var form = layui.form,
                        table = layui.table,
                        xmSelect = layui.xmSelect;

                    myChart.on('click', function (params) {
                        if (pieUserData[params.name]) {

                            $('#dutyUser').val(params.name);
                            $('#dutyUser').attr('user_id', pieUserData[params.name]);

                            var $selectEle = $('.search_form [name]');

                            var searchData = {}

                            $selectEle.each(function () {
                                var key = $(this).attr('name');
                                var value = $(this).val();
                                searchData[key] = value;
                            });

                            // 状态
                            searchData.taskStatus = taskStatusSelect.getValue('valueStr');

                            // 责任人
                            searchData.dutyUser = ($('#dutyUser').attr('user_id') || '').replace(/,$/, '');
                            // 所属部门
                            searchData.itemBelongDepts = ($('#itemBelongDepts').attr('deptid') || '').replace(/,$/, '');

                            planTaskTable.reload({
                                where: searchData
                            });
                        }
                    });

                    var taskStatusSelect = xmSelect.render({
                        el: '#taskStatusSelect',
                        toolbar: {
                            show: true,
                        },
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

                    $('.search_form select[name="taskType"]').append(dictionaryObj['RENWUJIHUA_TYPE'].str);

                    // 选择成果提交人
                    $('#dutyUser').click(function () {
                        user_id = 'dutyUser';
                        $.popWindow('/common/selectUser');
                    });

                    // 选择所属部门
                    $('#itemBelongDepts').click(function () {
                        dept_id = 'itemBelongDepts';
                        $.popWindow('/common/selectDept');
                    });

                    // 查询
                    $('#searchBtn').click(function () {
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name');
                            var value = $(this).val();
                            searchData[key] = value;
                        });

                        // 状态
                        searchData.taskStatus = taskStatusSelect.getValue('valueStr');

                        // 责任人
                        searchData.dutyUser = ($('#dutyUser').attr('user_id') || '').replace(/,$/, '');
                        // 所属部门
                        searchData.itemBelongDepts = ($('#itemBelongDepts').attr('deptid') || '').replace(/,$/, '');

                        loadPieModule(searchData);

                        planTaskTable = table.render({
                            elem: '#planTaskTable',
                            url: '/plcPlan/selectDeptItemReport',
                            toolbar: '#planTaskBar',
                            defaultToolbar: [''],
                            page: true,
                            height: 'full-430',
                            limit: 50,
                            cols: [[
                                {
                                    field: 'taskStatus', title: '状态', width: 60, align: 'center', templet: function (d) {
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
                                // {field: 'taskNo', title: '编码', minWidth: 200, align: 'left'},
                                {
                                    field: 'taskName', title: '子任务名称', minWidth: 400, align: 'left', templet: function (d) {
                                        return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="task_name_link" planItemId="' + d.planItemId + '">' + d.taskName + '</a>';
                                    }
                                },
                                // {
                                //     field: 'taskStatus', title: '状态', minWidth: 120, align: 'center', templet: function (d) {
                                //         if (d.taskStatus == '1') {
                                //             return '未开始';
                                //         } else if (d.taskStatus == '2') {
                                //             return '进行中';
                                //         } else if (d.taskStatus == '3') {
                                //             return '将到期';
                                //         } else if (d.taskStatus == '4') {
                                //             return '已延期';
                                //         } else if (d.taskStatus == '5') {
                                //             return '暂停';
                                //         } else if (d.taskStatus == '6') {
                                //             return '完成';
                                //         } else if (d.taskStatus == '7') {
                                //             return '延期完成';
                                //         } else if (d.taskStatus == '8') {
                                //             return '成果不符';
                                //         } else if (d.taskStatus == '9') {
                                //             return '关闭';
                                //         } else {
                                //             return '';
                                //         }
                                //     }
                                // },
                                {field: 'itemBelongDeptName', title: '所属部门', minWidth: 150, align: 'center'},
                                {field: 'dutyUserName', title: '责任人', minWidth: 120, align: 'center'},
                                {
                                    field: 'planStartDate', title: '计划开始时间', minWidth: 150, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.planStartDate) {
                                            str = formatDate(d.planStartDate);
                                        }

                                        return str;
                                    }
                                },
                                {
                                    field: 'planEndDate', title: '计划结束时间', minWidth: 150, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.planEndDate) {
                                            str = formatDate(d.planEndDate);
                                        }

                                        return str;
                                    }
                                },
                                {field: 'planContinuedDate', title: '计划工期', minWidth: 150, align: 'center'},
                                {
                                    field: 'realStartDate', title: '实际开始时间', minWidth: 150, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.realStartDate) {
                                            str = formatDate(d.realStartDate);
                                        }

                                        return str;
                                    }
                                },
                                {
                                    field: 'realEndDate', title: '实际结束时间', minWidth: 150, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.realEndDate) {
                                            str = formatDate(d.realEndDate);
                                        }

                                        return str;
                                    }
                                },
                                {field: 'realContinuedDate', title: '实际工期', minWidth: 150, align: 'center'},
                                {field: 'resultStandard', title: '完成标准', minWidth: 300, align: 'left'}
                            ]],
	                        where: searchData,
                            request: {
                                pageName: 'page',
                                limitName: 'pageSize'
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                dataName: 'data'
                            }
                        });
                    });

                    // 清空查询条件
                    $('#resetBtn').click(function () {
                        // 清空状态
                        taskStatusSelect.setValue([]);
                        // 重置月度下拉框
                        $('[name="planMonth"]').html('<option value="">请选择</option>');
                        // 责任人
                        $('#dutyUser').val('');
                        $('#dutyUser').attr('user_id', '');
                        // 所属部门
                        $('#itemBelongDepts').val('');
                        $('#itemBelongDepts').attr('deptid', '');

                        form.render('select');
                    });

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
                        $('.search_form [name="planYear"]').append(allYear);
                        if (nowYearNo) {
                            $('.search_form [name="planYear"]').val(nowYearNo);
                            getPlanMonth(nowYearNo, function (monthStr) {
                                $('.search_form [name="planMonth"]').html(monthStr);
                                $('.search_form [name="planMonth"]').val(nowDateObj.month);
                                form.render('select');
                                $('#searchBtn').trigger('click');
                            });
                        } else {
                            $('#searchBtn').trigger('click');
                        }
                        form.render('select');
                    });

                    // 获取月度
                    form.on('select(planYear)', function (data) {
                        if (data.value) {
                            getPlanMonth(data.value, function (monthStr) {
                                $('.search_form [name="planMonth"]').html(monthStr);
                                form.render('select');
                            });
                        } else {
                            $('.search_form [name="planMonth"]').html('<option value="">请选择</option>');
                            form.render('select');
                        }
                    });

                    form.render();

                    var planTaskTable = null;
                    
                    table.on('toolbar(planTaskTable)', function (obj) {
                        switch (obj.event) {
                            case 'pieChart':
                                if ($('#container').is(':hidden')) {
                                    planTaskTable.reload({
                                        height: 'full-430'
                                    });
                                    $('.pie_chart').find('.layui-icon').removeClass('layui-icon-down').addClass('layui-icon-up');
                                } else {
                                    planTaskTable.reload({
                                        height: 'full-80'
                                    });
                                    $('.pie_chart').find('.layui-icon').removeClass('layui-icon-up').addClass('layui-icon-down');
                                }
                                $('#container').slideToggle(100, function () {
                                    myChart.resize();
                                });
                                break;
                        }
                    });

                    // 查看子任务详情
                    $(document).on('click', '.task_name_link', function () {
                        var planItemId = $(this).attr('planItemId');
                        $.get('/ProjectDaily/selectProjectDailyByItemId', {planItemId: planItemId}, function (res) {
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
                        });
                    });

					//点击关键任务展示详情
					$(document).on('click','.tgName',function () {
						var tgId = $(this).attr('tgId');
						$.get('/ProjectDaily/selectProjectDailyByItemId', {tgId: tgId}, function (res) {
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
                        });
					})

                });
            }
			
            /***
             * 获取计划期间月度
             * @param planYear (月度对应年份)
             * @param cb (回调函数)
             */
            function getPlanMonth(planYear, fn) {
                $.get('/planPeroidSetting/showAllSet', {periodYear: planYear}, function (res) {
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
             * 将毫秒数转为(yyyy年MM月dd日)格式时间
             * @param t (时间戳)
             * @returns {string}
             */
            function formatDate(t) {
                if (t) {
                    return new Date(t).Format("yyyy年MM月dd日");
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

            // 重置查询区域布局
            function resizeQuery() {
                var queryWidth = $('.search_form ').width();
                $('.query_item').width((queryWidth - 20) / 7);
            }

            // 初始化数据
            function initPieData(data) {
                var userArr = []
                var data_0 = [], data_1 = [], data_2 = [], data_4 = [], data_5 = [], data_6 = [], data_9 = [], line_arr = [];
                data.forEach(function (item) {
                    pieUserData[item.userName] = item.userId;
                    userArr.push(item.userName);
                    line_arr.push(item.hardDegree);
                    var otherCount = 0;
                    for (var key in item.map) {
                        if (key == '0') {
                            // title = '未开始'
                            data_0.push(item.map[key]);
                        } else if (key == '1') {
                            // title = '进行中'
                            data_1.push(item.map[key]);
                        } else if (key == '2') {
                            // title = '将到期'
                            data_2.push(item.map[key]);
                        } else if (key == '4') {
                            // title = '已延期'
                            data_4.push(item.map[key]);
                        } else if (key == '5') {
                            // title = '完成'
                            data_5.push(item.map[key]);
                        } else if (key == '6') {
                            // title = '延期完成'
                            data_6.push(item.map[key]);
                        } else if (key == '7') {
                            // title = '暂停'
                            // data_7.push(item.map[key]);
	                         otherCount += item.map[key];
                        } else if (key == '8') {
                            // title = '关闭'
                            // data_8.push(item.map[key]);
	                         otherCount += item.map[key];
                        } else if (key == '9') {
                            // title = '成果不符'
                            // data_9.push(item.map[key]);
	                         otherCount += item.map[key];
                        }
                    }
	                data_9.push(otherCount);
                });

                return {
                    userArr: userArr,
                    data_0: data_0,
                    data_1: data_1,
                    data_2: data_2,
                    data_4: data_4,
                    data_5: data_5,
                    data_6: data_6,
                    // data_7: data_7,
                    // data_8: data_8,
                    data_9: data_9,
                    line_arr: line_arr
                }
            }

            function loadPieModule(searchData) {
                myChart.showLoading();
                searchData = searchData || {}
                // 获取数据
                $.get('/plcPlan/getTaskStatusCount?targetOrItem=item', searchData, function (res) {
                    myChart.hideLoading();
                    if (res.flag) {
                        var data = initPieData(res.obj);
						
                        myChart.setOption({
                            xAxis: [
                                {
                                    type: 'category',
                                    data: data.userArr,
                                    boundaryGap: true
                                }
                            ],
                            series: [
                                {
                                    name: '未开始',
                                    type: 'bar',
                                    stack: 'bar',
                                    barWidth: '50px',
                                    yAxisIndex: 1,
                                    data: data.data_0
                                },
                                {
                                    name: '进行中',
                                    type: 'bar',
                                    stack: 'bar',
                                    barWidth: '50px',
                                    yAxisIndex: 1,
                                    data: data.data_1
                                },
                                {
                                    name: '将到期',
                                    type: 'bar',
                                    stack: 'bar',
                                    barWidth: '50px',
                                    yAxisIndex: 1,
                                    data: data.data_2
                                },
                                {
                                    name: '已延期',
                                    type: 'bar',
                                    stack: 'bar',
                                    barWidth: '50px',
                                    yAxisIndex: 1,
                                    data: data.data_4
                                },
                                {
                                    name: '完成',
                                    type: 'bar',
                                    stack: 'bar',
                                    barWidth: '50px',
                                    yAxisIndex: 1,
                                    data: data.data_5
                                },
                                {
                                    name: '延期完成',
                                    type: 'bar',
                                    stack: 'bar',
                                    barWidth: '50px',
                                    yAxisIndex: 1,
                                    data: data.data_6
                                },
                                {
                                    name: '其他',
                                    type: 'bar',
                                    stack: 'bar',
                                    barWidth: '50px',
                                    yAxisIndex: 1,
                                    data: data.data_9
                                },
                                {
                                    name: '难度系数',
                                    type: 'line',
                                    stack: 'line',
                                    data: data.line_arr
                                },
                            ]
                        });
                    } else {
                        myChart.setOption(option);
                    }
                });
            }

			/**
			 * 将毫秒数转为yyyy-MM-dd格式时间
			 * @param t (时间戳)
			 * @returns {string}
			 */
			function format(t) {
				if (t) {
					return new Date(t).Format("yyyy-MM-dd");
				} else {
					return '';
				}
			}
		
		</script>
	</body>
</html>
