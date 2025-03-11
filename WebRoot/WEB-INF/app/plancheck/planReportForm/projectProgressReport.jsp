<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/11
  Time: 9:49
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
<html>
	<head>

		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>项目进展报表</title>

		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script src="../js/jquery/jquery.cookie.js"></script>
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

			/* 查询表单样式 START */
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

			/* 查询表单样式 EDN */

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

			.icon_box {
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

			.task_panel {
				height: 100%;
				padding: 20px 30px 20px 40px;
				font-size: 18px;
				line-height: 1.5;
				box-shadow: 0 0 12px 2px rgba(0, 0, 0, .1);
				border-radius: 3px;
				box-sizing: border-box;
			}

			.task_panel p {
				width: 90%;
				margin: 15px auto;
			}

			.layui-layer-tips {
				width: 250px !important;
			}

			.tips_module {
				position: relative;
				overflow: hidden;
			}

			.tips_content {
				max-height: 300px;
				padding-right: 20px;
				margin-right: -20px;
				overflow-y: auto;
			}

			.tips_p {
				overflow: hidden;
				word-break: break-all;
				white-space: nowrap;
				text-overflow: ellipsis;
				cursor: pointer;
			}

			.tips_p:hover {
				color: #e4ff00;
			}

			.project_link, .pBag_link, .target_link {
				color: #2b669a;
				text-decoration: underline;
				cursor: pointer;
			}

			.td_file {
				display: block;
				line-height: 1.5;
				color: blue !important;
				overflow: hidden;
				text-overflow: ellipsis;
			}

			.layui-table-tool-temp {
				padding-right: 40px;
			}

			.list_module li {
				max-width: 240px;
				overflow: hidden;
				white-space: nowrap;
				word-break: break-all;
				text-overflow: ellipsis;
			}

		</style>

		<style id="projectIdsSelectStyle">
			#projectIdsSelect .xm-body .xm-option-content {
				display: block !important;
				max-width: 300px;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="project">
			<div class="layui-tab layui-tab-brief" lay-filter="planProgressTab" style="margin: 0;">
				<ul class="layui-tab-title" style="float: left">
					<li class="layui-this">项目进展报表</li>
				</ul>
				<ul class="icon_box clearfix" style="float: left;margin-left: 5%">
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
							<div class="clearfix" style="padding: 5px 0;">
								<div class="layui-form-item query_item">
									<label class="layui-form-label" style="line-height: normal;">关键任务名称:</label>
									<div class="layui-input-block">
										<input type="text" name="tgName" placeholder="关键任务名称" autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">关注等级:</label>
									<div class="layui-input-block">
										<select name="controlLevel">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">状态:</label>
									<div class="layui-input-block">
										<div id="taskStatusSelect" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">项目名称:</label>
									<div class="layui-input-block">
										<div id="projectIdsSelect" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="query_button_group query_item">
									<button type="button" id="resetBtn" class="layui-btn layui-btn-sm query_btn" style="margin-right: 0;">重置</button>
									<button type="button" id="searchBtn" class="layui-btn layui-btn-sm query_btn">查询</button>
									<button type="button" class="layui-btn layui-btn-sm more_query query_btn" isshow="0">
										<i class="layui-icon layui-icon-down" style="margin: 0;"></i>
									</button>
								</div>
							</div>

							<div class="clearfix hide_query" style="display: none;padding: 5px 0;">
								<div class="layui-form-item query_item">
									<label class="layui-form-label" style="line-height: normal">关键任务类型:</label>
									<div class="layui-input-block">
										<div id="tgType" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">计划阶段</label>
									<div class="layui-input-block">
										<select name="planStage">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">责任人:</label>
									<div class="layui-input-block">
										<input type="text" name="dutyUser" id="dutyUser" placeholder="请选择"
										       style="background-color: #e7e7e7;cursor:pointer;" required readonly class="layui-input">
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">责任部门</label>
									<div class="layui-input-block">
										<input type="text" name="mainCenterDept" id="mainCenterDept" placeholder="请选择"
										       style="background-color: #e7e7e7;cursor:pointer;" required readonly class="layui-input">
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">年度:</label>
									<div class="layui-input-block">
										<select name="year">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
							</div>

							<div class="clearfix hide_query" style="display: none;padding: 5px 0;">
								<div class="layui-form-item query_item">
									<label class="layui-form-label">开始时间:</label>
									<div class="layui-input-block">
										<input type="text" class="layui-input" name="startDate" id="startDate">
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">结束时间</label>
									<div class="layui-input-block">
										<input type="text" class="layui-input" name="endDate" id="endDate">
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="content">
						<div class="layui-row">
							<div class="layui-col-xs2">
								<div class="layui-card task_card" style="height: 340px; margin: 20px 0;">
									<div class="layui-card-body task_panel">
										<p class="task_panel_1">项目数量：<span></span></p>
										<p class="task_panel_2">完成项目数：<span></span></p>
										<p class="task_panel_3">在建项目数：<span></span></p>
										<p class="task_panel_5">竣工项目数：<span></span></p>
										<p class="task_panel_6">收尾项目数：<span></span></p>
										<p class="task_panel_4"><font color="red">延期项目数：</font><span id="delayProject"
																									 style="cursor: pointer; color: #0aa3e3; text-decoration: underline;"></span>
										</p>
									</div>
								</div>
							</div>
							<div class="layui-col-xs6">
								<div id="chart_one" style="margin: 30px auto;height: 340px;"></div>
							</div>
							<div class="layui-col-xs4">
								<div id="chart_two" style="margin: 30px auto;height: 340px;"></div>
							</div>
						</div>
						<table id="planTaskTable" lay-filter="planTaskTable"></table>
					</div>
				</div>
			</div>
		</div>

		<script type="text/html" id="toolBar">
			<div class="layui-btn-container" style="text-align: right;">
				<button class="layui-btn layui-btn-sm" style="margin: 0 10px;" lay-event="export">导出</button>
				<button class="layui-btn layui-btn-sm" style="margin: 0;" lay-event="networkChart">网络图</button>
			</div>
		</script>

		<script>
            var nowDateObj = {
                year: new Date().getFullYear()
            }

            var user_id = ''
            var dept_id = ''

            var tipsIndex = null

            var taskStatusObj = {
                '未开始': {
                    value: 0,
                    color: '#7f7f7f'
                },
                '进行中': {
                    value: 1,
                    color: '#19ab7e'
                },
                '将到期': {
                    value: 2,
                    color: '#fad706'
                },
                '已延期': {
                    value: 4,
                    color: '#e46c0a'
                },
                '暂停': {
                    value: 7,
                    color: '#ff2e2e'
                },
                '完成': {
                    value: 5,
                    color: '#0119ff'
                },
                '延期完成': {
                    value: 6,
                    color: '#4bacc6'
                },
                '成果不符': {
                    value: 9,
                    color: '#ff3636'
                },
                '关闭': {
                    value: 8,
                    color: '#ff1b1b'
                }
            }

            var chartOne = echarts.init(document.getElementById('chart_one'));
            var chartTwo = echarts.init(document.getElementById('chart_two'));

            resizeQuery()
            window.onresize = function () {
                resizeQuery();
                chartOne.resize()
                chartTwo.resize()
            }

            var dictionaryObj = {
                CONTROL_LEVEL: {},
                PROJECT_TYPE: {},
                PBAG_TYPE: {},
                PBAG_NATURE: {},
                PBAG_CLASS: {},
                CUSTOMER_UNIT: {},
                PLAN_SYCLE: {},
                TG_TYPE: {},
                PLAN_PHASE: {},
                UNIT: {},
                CGCL_TYPE: {},
                RENWUJIHUA_TYPE: {},
            }
            var dictionaryStr = 'CONTROL_LEVEL,PROJECT_TYPE,PBAG_TYPE,PBAG_NATURE,PBAG_CLASS,CUSTOMER_UNIT,PLAN_SYCLE,TG_TYPE,PLAN_PHASE,UNIT,CGCL_TYPE,RENWUJIHUA_TYPE';
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
                layui.use(['form', 'xmSelect', 'table', 'element', 'laydate'], function () {
                    var layuiForm = layui.form,
                        element = layui.element,
                        layuiTable = layui.table,
	                    laydate = layui.laydate;

                    var planTaskTable = null

                    //日期范围选择
                    laydate.render({
                        elem: '#startDate',
                        range: '|'
                    });

                    laydate.render({
                        elem: '#endDate',
                        range: '|'
                    });

                    var taskStatusSelect = xmSelect.render({
                        el: '#taskStatusSelect',
                        toolbar: {
                            show: true,
                        },
                        name: 'taskStatus',
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
                        }
                    });

                    chartTwo.on('click', function (params) {
                        var taskStatus = taskStatusObj[params.name].value
                        var data = planTaskTable.config.where
                        data.taskStatus = taskStatus
                        laodTabel(data)
                    })

                    var projectIdsSelect = null
                    // 获取查询项目
                    $.get('/plcPlan/getProJectInfoByLogin', function (res) {
                        var projectId = ''
                        if (res.flag) {
                            var newData = [];
                            var index = 0;
                            var defaultPro = null;
                            $.each(res.object, function (k, o) {
                                var p = {
                                    projectName: k,
                                    projectId: 'p_' + index,
                                    child: o
                                }

                                if (!defaultPro && o && o.length > 0) {
                                    defaultPro = o[0];
                                }

                                newData.push(p);
                                index++;
                            });
                            projectIdsSelect = xmSelect.render({
                                el: '#projectIdsSelect',
                                toolbar: {
                                    show: true,
                                },
                                name: 'projectIds',
                                template: function (obj) {
                                    return '<span title="' + obj.name + '">' + obj.name + '</span>'
                                },
                                filterable: true,
                                data: newData,
                                tree: {
                                    show: true,
                                    showFolderIcon: true,
                                    showLine: true,
                                    indent: 20,
                                    expandedKeys: [-3],
                                },
                                prop: {
                                    name: 'projectName',
                                    value: 'projectId',
	                                children: 'child'
                                },
                                model: {
                                    label: {
                                        block: {
                                            template: function (item, sels) {
                                                return '<span style="max-width: 70px; overflow: hidden;" title="' + item.projectName + '">' + item.projectName + '</span>';
                                            }
                                        }
                                    }
                                }
                            });
                            projectId = defaultPro ? defaultPro.projectId : '';
                            $('#project').val(projectId)
                            $('#project').attr('projectId', projectId)
                            $('#project').attr('projectname', defaultPro.projectName)
                            projectIdsSelect.setValue([projectId])
                        }
                        loadProjectStatusCount({projectIds: projectId, year: nowDateObj.year});
                        loadChart({projectIds: projectId, year: nowDateObj.year});
                        laodTabel({projectIds: projectId, year: nowDateObj.year});
                    })

	                // 获取关键任务类型
	                var tgTypeSelect = null;
                    $.get('/Dictonary/getTgType', function (res) {
                        tgTypeSelect = xmSelect.render({
                            el: '#tgType',
                            toolbar: {
                                show: true,
                            },
                            data: res.object,
                            name: 'tgType',
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
                            }
                        });
                    });

                    $('.search_form [name="controlLevel"]').append(dictionaryObj['CONTROL_LEVEL'].str);
                    $('.search_form [name="planStage"]').append(dictionaryObj['PLAN_PHASE'].str);

                    // 获取计划期间年度列表
                    $.get('/planPeroidSetting/selectAllYear', function (res) {
                        var allYear = '';
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
                        $('.search_form [name="year"]').val(nowYearNo);

                        layuiForm.render('select');
                    });

                    layuiForm.render()

                    // 查询
                    $('#searchBtn').click(function () {
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name');
                            var value = $(this).val();
                            searchData[key] = value;
                        });

                        // 责任人
                        searchData.dutyUser = ($('#dutyUser').attr('user_id') || '').replace(/,$/, '');
                        // 责任部门
                        searchData.mainCenterDept = ($('#mainCenterDept').attr('deptid') || '').replace(/,$/, '');

                        var tgTypeArr = tgTypeSelect.getValue();
                        var tgType = ''
                        tgTypeArr.forEach(function(item){
                            tgType += item.dictNo + ',';
                        });

                        searchData.tgType = tgType

                        loadProjectStatusCount(searchData)
                        loadChart(searchData)
                        laodTabel(searchData)

                    });
                    // 清空查询条件
                    $('#resetBtn').click(function () {
                        $('.search_form [name="tgName"]').val('')
                        $('.search_form [name="controlLevel"]').val('')
	                    tgTypeSelect.setValue([])
                        $('.search_form [name="planStage"]').val('')
                        // 清空状态
                        taskStatusSelect.setValue([]);
                        // 清空项目
                        var projectId = $('#project').attr('projectId') || ''
                        projectIdsSelect.setValue([projectId])
                        // 所属部门
                        $('#mainCenterDept').val('');
                        $('#mainCenterDept').attr('deptid', '');
                        $('#mainCenterDept').attr('deptname', '');
                        // 责任人
                        $('#dutyUser').val('')
                        $('#dutyUser').attr('user_id', '')
                        $('#dutyUser').attr('username', '')
                        $('#dutyUser').attr('dataid', '')
                        $('#dutyUser').attr('userprivname', '')

	                    // 开始时间-结束时间
	                    $('#startDate').val('')
	                    $('#endDate').val('')

                        layuiForm.render()
                    });
                    // 更多查询切换
                    $('.more_query').click(function () {
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
                    // 选择责任人
                    $('#dutyUser').on('click', function () {
                        user_id = 'dutyUser';
                        $.popWindow('/common/selectUser');
                    });
                    // 选择责任部门
                    $('#mainCenterDept').on('click', function () {
                        dept_id = 'mainCenterDept';
                        $.popWindow('/common/selectDept');
                    });

                    $(document).on('mouseleave', '.tips_module', function () {
                        layer.close(tipsIndex)
                    })

                    $(document).on('click', '.tips_p', function () {
                        var $this = $(this)
                        var projectId = $this.attr('projectid')
                        var projectName = $this.text()
                        $('#projectId').val(projectId)
                        $('#projectId').attr('projectName', projectName)
                        projectIdsSelect.setValue([projectId])

                        loadProjectStatusCount({projectIds: projectId})
                        loadChart({projectIds: projectId})
                        laodTabel({projectIds: projectId})

                        layer.close(tipsIndex)
                    })

                    layuiTable.on('toolbar(planTaskTable)', function (obj) {
                        var layEvent = obj.event;

                        if (layEvent == 'networkChart') {
                            var projectArr = projectIdsSelect.getValue()
                            var projectIds = ''
                            var tabStr = ''
                            projectArr.forEach(function (item, index) {
                                projectIds += item.projectId + ','
                                if (index == 0) {
                                    tabStr += '<li class="layui-this" title="' + item.projectName + '">' + item.projectName + '</li>'
                                } else {
                                    tabStr += '<li title="' + item.projectName + '">' + item.projectName + '</li>'
                                }
                            })
                            layer.open({
                                type: 1,
                                title: '关键任务网络图',
                                area: ['100%', '100%'],
                                content: '<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">' +
                                    '  <ul class="layui-tab-title list_module">' + tabStr +
                                    '  </ul>' +
                                    '  <div class="layui-tab-content"><div id="mountNode"></div></div>' +
                                    '</div> ',
                                success: function () {
                                    var dataArr = []
                                    G6.registerNode(
                                        'round-rect',
                                        {
                                            drawShape: function (cfg, group) {
                                                var width = cfg.style.width;
                                                var stroke = cfg.style.stroke;
                                                var rect = group.addShape('rect', {
                                                    attrs: {
                                                        x: -width / 2,
                                                        y: -15,
                                                        width,
                                                        height: 30,
                                                        radius: 15,
                                                        stroke,
                                                        lineWidth: 1.2,
                                                        fillOpacity: 1,
                                                    },
                                                    name: 'rect-shape'
                                                });
                                                group.addShape('circle', {
                                                    attrs: {
                                                        x: -width / 2,
                                                        y: 0,
                                                        r: 3,
                                                        fill: stroke,
                                                    },
                                                    name: 'circle-shape'
                                                });
                                                group.addShape('circle', {
                                                    attrs: {
                                                        x: width / 2,
                                                        y: 0,
                                                        r: 3,
                                                        fill: stroke,
                                                    },
                                                    name: 'circle-shape2'
                                                });
                                                return rect;
                                            },
                                            getAnchorPoints: function () {
                                                return [
                                                    [0, 0.5],
                                                    [1, 0.5],
                                                ];
                                            },
                                            update: function (cfg, item) {
                                                var group = item.getContainer();
                                                var children = group.get('children');
                                                var node = children[0];
                                                var circleLeft = children[1];
                                                var circleRight = children[2];

                                                var stroke = cfg.style.stroke;

                                                if (stroke) {
                                                    node.attr('stroke', stroke);
                                                    circleLeft.attr('fill', stroke);
                                                    circleRight.attr('fill', stroke);
                                                }
                                            }
                                        },
                                        'single-node'
                                    );
                                    G6.registerEdge('polyline', {
                                        itemType: 'edge',
                                        draw: function (cfg, group) {
                                            var startPoint = cfg.startPoint;
                                            var endPoint = cfg.endPoint;

                                            var Ydiff = endPoint.y - startPoint.y;

                                            var slope = Ydiff !== 0 ? 500 / Math.abs(Ydiff) : 0;

                                            var cpOffset = 16;
                                            var offset = Ydiff < 0 ? cpOffset : -cpOffset;

                                            var line1EndPoint = {
                                                x: startPoint.x + slope,
                                                y: endPoint.y + offset,
                                            };
                                            var line2StartPoint = {
                                                x: line1EndPoint.x + cpOffset,
                                                y: endPoint.y,
                                            };

                                            // 控制点坐标
                                            var controlPoint = {
                                                x:
                                                    ((line1EndPoint.x - startPoint.x) * (endPoint.y - startPoint.y)) /
                                                    (line1EndPoint.y - startPoint.y) +
                                                    startPoint.x,
                                                y: endPoint.y,
                                            };

                                            let path = [
                                                ['M', startPoint.x, startPoint.y],
                                                ['L', line1EndPoint.x, line1EndPoint.y],
                                                ['Q', controlPoint.x, controlPoint.y, line2StartPoint.x, line2StartPoint.y],
                                                ['L', endPoint.x, endPoint.y],
                                            ];

                                            if (Ydiff === 0) {
                                                path = [
                                                    ['M', startPoint.x, startPoint.y],
                                                    ['L', endPoint.x, endPoint.y],
                                                ];
                                            }

                                            var line = group.addShape('path', {
                                                attrs: {
                                                    path,
                                                    stroke: '#1A91FF',
                                                    lineWidth: 1.2,
                                                    endArrow: false,
                                                },
                                                name: 'path-shape',
                                            });

                                            var labelLeftOffset = 0;
                                            var labelTopOffset = 8;
                                            // amount
                                            var amount = group.addShape('text', {
                                                attrs: {
                                                    text: cfg.data && cfg.data.amount,
                                                    x: line2StartPoint.x + labelLeftOffset,
                                                    y: endPoint.y - labelTopOffset - 2,
                                                    fontSize: 14,
                                                    textAlign: 'left',
                                                    textBaseline: 'middle',
                                                    fill: '#000000D9',
                                                },
                                                name: 'text-shape-amount',
                                            });

                                            return line;
                                        }
                                    });

                                    var width = document.getElementById('mountNode').scrollWidth;
                                    var height = document.getElementById('mountNode').scrollHeight || 700;
                                    var graph = new G6.Graph({
                                        container: 'mountNode',
                                        width,
                                        height,
                                        layout: {
                                            type: 'dagre',
                                            rankdir: 'LR',
                                            nodesep: 30,
                                            ranksep: 100
                                        },
                                        modes: {
                                            default: ['drag-canvas']
                                        },
                                        defaultNode: {
                                            type: 'round-rect',
                                            labelCfg: {
                                                style: {
                                                    fill: '#000000A6',
                                                    fontSize: 10
                                                }
                                            },
                                            style: {
                                                stroke: '#72CC4A',
                                                width: 150
                                            }
                                        },
                                        defaultEdge: {
                                            type: 'polyline'
                                        }
                                    });

                                    var edges = graph.getEdges();
                                    edges.forEach(function (edge) {
                                        var line = edge.getKeyShape();
                                        var stroke = line.attr('stroke');
                                        var targetNode = edge.getTarget();
                                        targetNode.update({
                                            style: {
                                                stroke
                                            }
                                        });
                                    });
                                    graph.paint();

                                    graph.on('node:click', function (evt) {
                                        var tgId = evt.item._cfg.id
                                        // 一些操作
                                        $.get('/ProjectDaily/selectProjectDailyByItemId', {tgId: tgId}, function (res) {
                                            var data = res.data;
                                            var targetData = res.object;

                                            layer.open({
                                                type: 1,
                                                title: '【关键任务】' + isShowNull(targetData.tgName),
                                                area: ['70%', '90%'],
                                                maxmin: true,
                                                min: function () {
                                                    $('.layui-layer-shade').hide()
                                                },
                                                content: '<div><h3 style="line-height: 30px;font-size: 20px;text-align: center;">关联子任务</h3><table id="taskTable" lay-filter="taskTable"></table><div id="target_detail" style="margin:10px"></div></div>',
                                                success: function () {
                                                    /*展示关联子任务*/
                                                    layuiTable.render({
                                                        elem: '#taskTable'
                                                        , url: '/projectTarget/findItemByTgId?tgId=' + tgId//数据接口
                                                        , cols: [[
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
                                                            {
                                                                field: 'taskName',
                                                                title: '子任务名称',
                                                                width: 300,
                                                                style: "color:blue;cursor: pointer",
                                                                templet: function (d) {
                                                                    return '<span class="taskDetail" planItemId="' + d.planItemId + '" parentPlanItemId="' + d.parentPlanItemId + '">' + d.taskName + '</span>'
                                                                }
                                                            },
                                                            {
                                                                field: 'planSycle', title: '周期类型', width: 120, templet: function (d) {
                                                                    return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                                                                }
                                                            },
                                                            {
                                                                field: 'taskType', title: '任务来源', width: 120, templet: function (d) {
                                                                    return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || ''
                                                                }
                                                            },
                                                            {field: 'dutyUserName', title: '负责人', width: 100},
                                                            {field: 'mainCenterDeptName', title: '责任部门', width: 150},
                                                            {field: 'assistCompanyDeptsName', title: '协助部门', width: 150},
                                                            {
                                                                field: 'planStartDate', title: '计划开始时间', width: 150, templet: function (d) {
                                                                    return format(d.planStartDate)
                                                                }
                                                            },
                                                            {
                                                                field: 'planEndDate', title: '计划结束时间', width: 150, templet: function (d) {
                                                                    return format(d.planEndDate)
                                                                }
                                                            },
                                                            {field: 'planContinuedDate', title: '计划工期', width: 150},
                                                            {
                                                                field: 'resultStandard', title: '完成标准', width: 130,
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
                                                                field: 'taskDesc', title: '子任务描述', width: 120,
                                                            }
                                                        ]]
                                                        , parseData: function (res) { //res 即为原始返回的数据
                                                            return {
                                                                "code": 0, //解析接口状态
                                                                "data": res.obj//解析数据列表
                                                            };
                                                        }
                                                    });

                                                    var targetDatailStr = '';

                                                    if (!!targetData) {
                                                        targetDatailStr += ['<h3 style="line-height: 30px;font-size: 20px;text-align: center;">关键任务详情</h3><table class="layui-table"><tbody>',
                                                            '<tr>' +
                                                            '<td class="td_title">关键任务编号</td><td class="td_content">' + isShowNull(targetData.tgNo) + '</td>' +
                                                            '<td class="td_title">关键任务名称</td><td class="td_content">' + isShowNull(targetData.tgName) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">关注等级</td><td class="td_content">' + isShowNull(dictionaryObj['CONTROL_LEVEL']['object'][targetData.controlLevel]) + '</td>' +
                                                            '<td class="td_title">周期类型</td><td class="td_content">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][targetData.planSycle]) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">关键任务类型</td><td class="td_content">' + isShowNull(dictionaryObj['TG_TYPE']['object'][targetData.controlLevel]) + '</td>' +
                                                            '<td class="td_title">计划阶段</td><td class="td_content">' + isShowNull(dictionaryObj['PLAN_PHASE']['object'][targetData.planStage]) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">设计量</td><td class="td_content">' + isShowNull(targetData.designQuantity) + '</td>' +
                                                            '<td class="td_title">工程量</td><td class="td_content">' + isShowNull(targetData.itemQuantity) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">单位</td><td class="td_content">' + isShowNull(dictionaryObj['UNIT']['object'][targetData.itemQuantityNuit]) + '</td>' +
                                                            '<td class="td_title">难度系数</td><td class="td_content">' + isShowNull(targetData.hardDegree) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">负责人</td><td class="td_content">' + isShowNull(targetData.dutyUserName).replace(/,$/, '') + '</td>' +
                                                            '<td class="td_title">中心责任部门</td><td class="td_content">' + isShowNull(targetData.mainCenterDeptName).replace(/,$/, '') + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">计划开始时间</td><td class="td_content">' + formatDate(targetData.planStartDate) + '</td>' +
                                                            '<td class="td_title">实际开始时间</td><td class="td_content">' + formatDate(targetData.realStartDate) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">计划结束时间</td><td class="td_content">' + formatDate(targetData.planEndDate) + '</td>' +
                                                            '<td class="td_title">实际结束时间</td><td class="td_content">' + formatDate(targetData.realEndDate) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">计划工期</td><td class="td_content">' + isShowNull(targetData.planContinuedDate) + '</td>' +
                                                            '<td class="td_title">实际工期</td><td class="td_content">' + isShowNull(targetData.realContinuedDate) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">区域责任部门</td><td class="td_content">' + isShowNull(targetData.mainAreaDeptName).replace(/,$/, '') + '</td>' +
                                                            '<td class="td_title">总承包部责任部门</td><td class="td_content">' + isShowNull(targetData.mainProjectDeptName).replace(/,$/, '') + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">风险点</td><td class="td_content">' + isShowNull(targetData.riskPoint) + '</td>' +
                                                            '<td class="td_title">难度点</td><td class="td_content">' + isShowNull(targetData.difficultPoint) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">完成标准</td><td>' + isShowNull(targetData.resultStandard) + '</td>' +
                                                            '<td class="td_title">成果标准模板</td><td>' +
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
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">前置关键任务</td><td colspan="3">' +
                                                            function () {
                                                                var preTargetStr = '';
                                                                if (targetData.preTargetList && targetData.preTargetList.length > 0) {
                                                                    targetData.preTargetList.forEach(function (item) {
                                                                        preTargetStr += item.workTargetName + ',';
                                                                    });
                                                                }
                                                                return preTargetStr.replace(/,$/, '');
                                                            }() +
                                                            '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">关联关键任务</td><td colspan="3">' +
                                                            function () {
                                                                var linkedTargetStr = '';
                                                                if (targetData.linkedTargetList && targetData.linkedTargetList.length > 0) {
                                                                    targetData.linkedTargetList.forEach(function (item) {
                                                                        linkedTargetStr += item.tgName + ',';
                                                                    });
                                                                }
                                                                return linkedTargetStr.replace(/,$/, '');
                                                            }() +
                                                            '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">成果附件</td><td colspan="3">' +
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
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">异常原因</td><td colspan="3">' + isShowNull(targetData.unusualRes) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">异常原因材料</td><td colspan="3">' +
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
                                                                            '</div>';
                                                                    });

                                                                    return str;
                                                                } else {
                                                                    return '';
                                                                }
                                                            }() +
                                                            '</td>' +
                                                            '</tr>' +
                                                            '<tr>' +
                                                            '<td class="td_title">编制依据附件</td><td colspan="3">' +
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
                                                                            '</div>';
                                                                    });

                                                                    return str;
                                                                } else {
                                                                    return '';
                                                                }
                                                            }() +
                                                            '</td>' +
                                                            '</tr>' +
                                                            '</tbody></table>'].join('');
                                                    }

                                                    if (data.length > 0) {
                                                        targetDatailStr += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">关键任务填报信息</h3>';
                                                        for (var i = 0; i < data.length; i++) {
                                                            targetDatailStr += ['<table class="layui-table" style="margin-bottom: 5px"><tbody>\n' +
                                                            '<tr>' +
                                                            '<td class="td_title">每日填报人</td><td class="td_content">' + isShowNull(data[i].ctreateUserName) + '</td>' +
                                                            '<td class="td_title">时间</td><td class="td_content">' + formatDate(data[i].ctreateTime) + '</td>' +
                                                            '</tr>',
                                                                '<tr>' +
                                                                '<td class="td_title">增加协作人</td><td class="td_content">' + isShowNull(data[i].assistUserName) + '</td>' +
                                                                '<td class="td_title">当日完成量</td><td class="td_content">' +
                                                                function () {
                                                                    if (data[i].assistUserName || data[i].transfer) {
                                                                        return '—';
                                                                    } else {
                                                                        return isShowNull(data[i].tadayProgress) + '%';
                                                                    }
                                                                }() +
                                                                '</td>' +
                                                                '</tr>',
                                                                '<tr>' +
                                                                '<td class="td_title">转办</td><td colspan="3">' + isShowNull(data[i].transfer) + '</td>' +
                                                                '</tr>',
                                                                '<tr>' +
                                                                '<td class="td_title">进展日志</td><td colspan="3">' + isShowNull(data[i].tadayDesc) + '</td>' +
                                                                '</tr>',
                                                                '</tbody></table>'].join('');
                                                        }
                                                    }

                                                    $('#target_detail').append(targetDatailStr);
                                                }
                                            });
                                        });
                                    })
                                    $.get('/StatisticalReport/getProjectAno', {projectIds: projectIds}, function (res) {
                                        if (res.flag && res.data.length > 0) {
                                            res.data.forEach(function (item) {
                                                var d = initNetworkData(item)
                                                dataArr.push(d)
                                            })

                                            graph.data(dataArr[0]);
                                            graph.render();
                                            console.log(dataArr);
                                        }
                                    })

                                    element.on('tab(docDemoTabBrief)', function (data) {
                                        var index = data.index
                                        graph.changeData(dataArr[index], true)
                                    });
                                },
                                yes: function (index) {
                                    layer.close(index)
                                }
                            })
                        } else if (layEvent == 'export') {
                            var $selectEle = $('.search_form [name]');
                            var searchData = {}

                            $selectEle.each(function () {
                                var key = $(this).attr('name');
                                var value = $(this).val();
                                searchData[key] = value;
                            });

                            // 责任人
                            searchData.dutyUser = ($('#dutyUser').attr('user_id') || '').replace(/,$/, '');
                            // 责任部门
                            searchData.mainCenterDept = ($('#mainCenterDept').attr('deptid') || '').replace(/,$/, '');

                            var query = ''

                            $.each(searchData, function (k, o) {
                                query += k + '=' + o + '&'
                            })

                            location.href = '/StatisticalReport/getProjectTarget?'+query+'isExport=1'
                        }
                    });

                    //监听筛选列
                    layuiForm.on('checkbox()', function (data) {
                        //判断监听的复选框是筛选列下的复选框
                        if ($(data.elem).attr('lay-filter') == 'LAY_TABLE_TOOL_COLS') {
                            var $parent = $(data.elem).parent().parent()
	                        var obj = {}
                            $parent.find('input[type="checkbox"]').each(function () {
                                var name = $(this).attr('name')
	                            obj[name] = !$(this).prop('checked')
                            })
                            localStorage.setItem("PPR_filter", JSON.stringify(obj))
                        }
                    });

                    function laodTabel(searchData) {
						var filterStr = localStorage.getItem("PPR_filter") || '';
                        var filterObj = filterStr ? JSON.parse(filterStr) : null;

                        planTaskTable = layuiTable.render({
                            elem: '#planTaskTable',
                            url: '/StatisticalReport/getProjectTarget',
                            page: true,
                            toolbar: '#toolBar',
                            defaultToolbar: ['filter'],
                            where: searchData,
                            request: {
                                pageName: 'page',
                                limitName: 'pageSize'
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'data',
                            },
                            cols: [[
                                {
                                    field: 'projectAbbreviation', title: '项目名称', align: 'left', width: 90, rowspan: 2, templet: function (d) {
                                        return '<span class="project_link" projectId="' + d.projectId + '">' + d.projectAbbreviation + '</span>'
                                    },
	                                hide: filterObj ? filterObj['projectAbbreviation'] : false
                                },
                                {
                                    field: 'pBagName', title: '子项目', align: 'left', width: 90, rowspan: 2, templet: function (d) {
                                        return '<span class="pBag_link" pbagId="' + d.pbagId + '">' + (d.pbagName || '') + '</span>'
                                    },
	                                hide: filterObj ? filterObj['pBagName'] : false
                                },
                                {
                                    field: 'tgName', title: '关键任务名称', align: 'left', width: 120, rowspan: 2, templet: function (d) {
                                        return '<span class="target_link" tgId="' + d.tgId + '">' + d.tgName + '</span>'
                                    },
	                                hide: filterObj ? filterObj['tgName'] : false
                                },
                                {
                                    field: 'controlLevel', title: '关注等级', align: 'center', width: 120, rowspan: 2, templet: function (d) {
                                        return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                    },
	                                hide: filterObj ? filterObj['controlLevel'] : false
                                },
                                {
                                    field: 'planStartDate', title: '计划开始时间', align: 'center', width: 120, rowspan: 2, templet: function (d) {
                                        return formatDate(d.planStartDate)
                                    },
	                                hide: filterObj ? filterObj['planStartDate'] : false
                                },
                                {
                                    field: 'planEndDate', title: '计划结束时间', align: 'center', width: 120, rowspan: 2, templet: function (d) {
                                        return formatDate(d.planEndDate)
                                    },
	                                hide: filterObj ? filterObj['planEndDate'] : false
                                },
                                {title: '总承包部', align: 'center', width: 120, colspan: 8},
                                {title: '区域', align: 'center', width: 120, colspan: 8},
                                {title: '中心', align: 'center', width: 120, colspan: 8}
                            ], [
                                {
                                    field: 'taskStatusProject', title: '状态', width: 120, templet: function (d) {
                                        if (d.taskStatusProject == '0') {
                                            // '未开始';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/not_started.png"/>';
                                        } else if (d.taskStatusProject == '1') {
                                            // '进行中';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/underway.png"/>';
                                        } else if (d.taskStatusProject == '2') {
                                            // '将到期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_underway.png"/>';
                                        } else if (d.taskStatusProject == '4') {
                                            // '已延期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/out_underway.png"/>';
                                        } else if (d.taskStatusProject == '7') {
                                            // '暂停';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/suspend.png"/>';
                                        } else if (d.taskStatusProject == '5') {
                                            // '完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/complete.png"/>';
                                        } else if (d.taskStatusProject == '6') {
                                            // '延期完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_complete.png"/>';
                                        } else if (d.taskStatusProject == '9') {
                                            // '成果不符';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/result_default.png"/>';
                                        } else if (d.taskStatusProject == '8') {
                                            // '关闭';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/closed.png"/>';
                                        } else {
                                            return '';
                                        }
                                    },
	                                hide: filterObj ? filterObj['taskStatusProject'] : false
                                },
                                {field: 'mainProjectDeptName', title: '责任部门', width: 120, hide: filterObj ? filterObj['mainProjectDeptName'] : false},
                                {field: 'mainProjectUserName', title: '责任人', width: 120, hide: filterObj ? filterObj['mainProjectUserName'] : false},
                                {field: 'completeQuantityProject', title: '完成度', width: 120, hide: filterObj ? filterObj['completeQuantityProject'] : false},
                                {
                                    field: 'projectStartDate', title: '开始实际时间', width: 120, templet: function (d) {
                                        return formatDate(d.projectStartDate)
                                    },
	                                hide: filterObj ? filterObj['projectStartDate'] : false
                                },
                                {
                                    field: 'projectEndDate', title: '完成实际时间', width: 120, templet: function (d) {
                                        return formatDate(d.projectEndDate)
                                    },
	                                hide: filterObj ? filterObj['projectEndDate'] : false
                                },
                                {field: 'areaDuty', title: '完成标准', width: 120, hide: filterObj ? filterObj['areaDuty'] : false},
                                {
                                    field: 'attachments6', title: '最终成果', width: 120, templet: function (d) {
                                        var attachmentList = d.attachments6;
                                        var str = ''
                                        if (attachmentList && attachmentList.length > 0) {
                                            attachmentList.forEach(function (item) {
                                                var fileExtension = item.attachName.substring(item.attachName.lastIndexOf(".") + 1, item.attachName.length);//截取附件文件后缀
                                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + item.size;

                                                str += '<a class="td_file" href="/download?' + encodeURI(deUrl) + '">' + item.attachName + '</a>'
                                            });
                                        }
                                        return str;
                                    },
	                                hide: filterObj ? filterObj['attachments6'] : false
                                },
                                {
                                    field: 'taskStatusArea', title: '状态', width: 120, templet: function (d) {
                                        if (d.taskStatusArea == '0') {
                                            // '未开始';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/not_started.png"/>';
                                        } else if (d.taskStatusArea == '1') {
                                            // '进行中';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/underway.png"/>';
                                        } else if (d.taskStatusArea == '2') {
                                            // '将到期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_underway.png"/>';
                                        } else if (d.taskStatusArea == '4') {
                                            // '已延期';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/out_underway.png"/>';
                                        } else if (d.taskStatusArea == '7') {
                                            // '暂停';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/suspend.png"/>';
                                        } else if (d.taskStatusArea == '5') {
                                            // '完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/complete.png"/>';
                                        } else if (d.taskStatusArea == '6') {
                                            // '延期完成';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/delay_complete.png"/>';
                                        } else if (d.taskStatusArea == '9') {
                                            // '成果不符';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/result_default.png"/>';
                                        } else if (d.taskStatusArea == '8') {
                                            // '关闭';
                                            return '<img class="td_img" src="/img/planCheck/planProgressReport/closed.png"/>';
                                        } else {
                                            return '';
                                        }
                                    },
	                                hide: filterObj ? filterObj['taskStatusArea'] : false
                                },
                                {field: 'mainAreaDeptName', title: '责任部门', width: 120, hide: filterObj ? filterObj['mainAreaDeptName'] : false},
                                {field: 'mainAreaUserName', title: '责任人', width: 120, hide: filterObj ? filterObj['mainAreaUserName'] : false},
                                {field: 'completeQuantityArea', title: '完成度', width: 120, hide: filterObj ? filterObj['completeQuantityArea'] : false},
                                {
                                    field: 'areaStartDate', title: '开始实际时间', width: 120, templet: function (d) {
                                        return formatDate(d.areaStartDate)
                                    },
	                                hide: filterObj ? filterObj['areaStartDate'] : false
                                },
                                {
                                    field: 'areaEndDate', title: '完成实际时间', width: 120, templet: function (d) {
                                        return formatDate(d.areaEndDate)
                                    },
	                                hide: filterObj ? filterObj['areaEndDate'] : false
                                },
                                {field: 'projectDuty', title: '完成标准', width: 120, hide: filterObj ? filterObj['projectDuty'] : false},
                                {
                                    field: 'attachments5', title: '最终成果', width: 120, templet: function (d) {
                                        var attachmentList = d.attachments5;
                                        var str = ''
                                        if (attachmentList && attachmentList.length > 0) {
                                            attachmentList.forEach(function (item) {
                                                var fileExtension = item.attachName.substring(item.attachName.lastIndexOf(".") + 1, item.attachName.length);//截取附件文件后缀
                                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + item.size;

                                                str += '<a class="td_file" href="/download?' + encodeURI(deUrl) + '">' + item.attachName + '</a>'
                                            });
                                        }
                                        return str;
                                    },
	                                hide: filterObj ? filterObj['attachments5'] : false
                                },
                                {
                                    field: 'taskStatus', title: '状态', width: 120, templet: function (d) {
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
                                    },
	                                hide: filterObj ? filterObj['taskStatus'] : false
                                },
                                {field: 'mainCenterDeptName', title: '责任部门', width: 120, hide: filterObj ? filterObj['mainCenterDeptName'] : false},
                                {field: 'dutyUserName', title: '责任人', width: 120, hide: filterObj ? filterObj['dutyUserName'] : false},
                                {field: 'completeQuantity', title: '完成度', width: 120, hide: filterObj ? filterObj['completeQuantity'] : false},
                                {
                                    field: 'realStartDate', title: '开始实际时间', width: 120, templet: function (d) {
                                        return formatDate(d.realStartDate)
                                    },
	                                hide: filterObj ? filterObj['realStartDate'] : false
                                },
                                {
                                    field: 'realEndDate', title: '完成实际时间', width: 120, templet: function (d) {
                                        return formatDate(d.realEndDate)
                                    },
	                                hide: filterObj ? filterObj['realEndDate'] : false
                                },
                                {field: 'centerDuty', title: '完成标准', width: 120, hide: filterObj ? filterObj['centerDuty'] : false},
                                {
                                    field: 'attachments2', title: '最终成果', width: 120, templet: function (d) {
                                        var attachmentList = d.attachments2;
                                        var str = ''
                                        if (attachmentList && attachmentList.length > 0) {
                                            attachmentList.forEach(function (item) {
                                                var fileExtension = item.attachName.substring(item.attachName.lastIndexOf(".") + 1, item.attachName.length);//截取附件文件后缀
                                                var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + item.size;

                                                str += '<a class="td_file" href="/download?' + encodeURI(deUrl) + '">' + item.attachName + '</a>'
                                            });
                                        }
                                        return str;
                                    },
	                                hide: filterObj ? filterObj['attachments2'] : false
                                }
                            ]],
                            done: function () {
                                $('.td_file').parent().css('height', 'auto');

                                $('.td_file').hover(function () {
                                    var that = this;
                                    var text = $(this).text()
                                    layer.tips(text, that, {
                                        tips: [1, '#3595CC'],
                                        time: 0
                                    })
                                }, function () {
                                    layer.closeAll()
                                });
                            }
                        })
                    }

                    // 点击项目名称显示详情
                    $(document).on('click', '.project_link', function () {
                        var projectId = $(this).attr('projectId');
                        $.get('/ProjectInfo/selectProjectInfoById', {projectId: projectId}, function (res) {
                            var projectData = res.obj;
                            if (res.code == 0) {
                                layer.open({
                                    type: 1,
                                    title: '【项目】' + projectData.projectName,
                                    area: ['70%', '90%'],
                                    maxmin: true,
                                    min: function () {
                                        $('.layui-layer-shade').hide()
                                    },
                                    content: '<div id="projectDetail"></div>',
                                    success: function () {
                                        var projectStr = ['<table class="layui-table"><tbody>',
                                            '<tr>' +
                                            '<td class="td_title">项目编码：</td><td class="td_content">' + isShowNull(projectData.projectNo) + '</td>' +
                                            '<td class="td_title">项目名称：</td><td class="td_content">' + isShowNull(projectData.projectName) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">项目类型：</td><td class="td_content">' + isShowNull(dictionaryObj['PROJECT_TYPE']['object'][projectData.projectType]) + '</td>' +
                                            '<td class="td_title">项目简称：</td><td class="td_content">' + isShowNull(projectData.projectAbbreviation) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">是否是公司重点：</td><td class="td_content">' + (isShowNull(projectData.importantYn) == 1 ? '是' : '否') + '</td>' +
                                            '<td class="td_title">项目编码：</td><td class="td_content">' + isShowNull(projectData.projectCode) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">项目地点：</td><td class="td_content">' + isShowNull(projectData.projectPlace) + '</td>' +
                                            '<td class="td_title">所属区域：</td><td class="td_content">' + isShowNull(projectData.respectiveRegionName) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">业主单位：</td><td class="td_content">' + isShowNull(projectData.ownerUnitName) + '</td>' +
                                            '<td class="td_title">业主联系人：</td><td class="td_content">' + isShowNull(projectData.ownerName) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">业主联系电话：</td><td class="td_content">' + isShowNull(projectData.ownerPhone) + '</td>' +
                                            '<td class="td_title">监理单位：</td><td class="td_content">' +
                                            function () {
                                                var manageUnitList = isShowNull(projectData.manageUnitList);
                                                if (!!manageUnitList && manageUnitList.length > 0) {
                                                    var manageUnitStr = '';
                                                    manageUnitList.forEach(function (item) {
                                                        manageUnitStr += item.dictName + ',';
                                                    });
                                                    return manageUnitStr.replace(/,$/, '');
                                                } else {
                                                    return '';
                                                }
                                            }() + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">监理联系人：</td><td class="td_content">' + isShowNull(projectData.manageName) + '</td>' +
                                            '<td class="td_title">监理联系电话：</td><td class="td_content">' + isShowNull(projectData.managePhone) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">合同总金额：</td><td class="td_content">' + isShowNull(projectData.contractMoney) + '</td>' +
                                            '<td class="td_title">合同总工期：</td><td class="td_content">' + isShowNull(projectData.contractDuration) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">计划开始时间：</td><td class="td_content">' + formatDate(projectData.statrtTime) + '</td>' +
                                            '<td class="td_title">计划结束时间：</td><td class="td_content">' + formatDate(projectData.endTime) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">项目经理：</td><td class="td_content">' + isShowNull(projectData.projectManageName) + '</td>' +
                                            '<td class="td_title">项目经理电话：</td><td class="td_content">' + isShowNull(projectData.projectManagePhone) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">项目总工：</td><td class="td_content">' + isShowNull(projectData.projectChief) + '</td>' +
                                            '<td class="td_title">项目总工电话：</td><td class="td_content">' + isShowNull(projectData.projectChiefPhone) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">中标日期：</td><td class="td_content">' + formatDate(projectData.winningDate) + '</td>' +
                                            '<td class="td_title">编制人：</td><td class="td_content">' + isShowNull(projectData.createUserName) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">计划模板：</td><td class="td_content">' + isShowNull(projectData.mainPlanTpl) + '</td>' +
                                            '<td class="td_title">所属上级机构：</td><td class="td_content">' + isShowNull(projectData.belongDept) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">验收标准：</td><td class="td_content">' + isShowNull(projectData.acceptStandard) + '</td>' +
                                            '<td class="td_title">总承包部：</td><td class="td_content">' + isShowNull(projectData.contractDeptName) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">施工内容：</td><td class="td_content">' + isShowNull(projectData.workContent) + '</td>' +
                                            '<td class="td_title">初始化分解层级：</td><td class="td_content">' + isShowNull(projectData.breakTimes) + '级</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">实际开始时间：</td><td class="td_content">' + formatDate(projectData.realBeginDate) + '</td>' +
                                            '<td class="td_title">实际完工时间：</td><td class="td_content">' + formatDate(projectData.realEndDate) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">项目进展：</td><td class="td_content">' +
                                            function () {
                                                var projectStatus = isShowNull(projectData.projectStatus);
                                                if (projectStatus == 0) {
                                                    return '在建';
                                                } else if (projectStatus == 1) {
                                                    return '收尾';
                                                } else if (projectStatus == 2) {
                                                    return '竣工';
                                                } else if (projectStatus == 3) {
                                                    return '关闭';
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">项目概述：</td><td class="td_content">' + isShowNull(projectData.projectDesc) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">总承包部负责人：</td><td class="td_content">' + isShowNull(projectData.overallLeaderName) + '</td>' +
                                            '<td class="td_title">项目关键任务审批状态：</td><td class="td_content">' +
                                            function () {
                                                var targetApprivalStatus = isShowNull(projectData.targetApprivalStatus);
                                                if (targetApprivalStatus == 0) {
                                                    return '未上报';
                                                } else if (targetApprivalStatus == 1) {
                                                    return '已上报(待批)';
                                                } else if (targetApprivalStatus == 2) {
                                                    return '同意';
                                                } else if (targetApprivalStatus == 3) {
                                                    return '不同意';
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">项目关键任务审批意见：</td><td class="td_content">' + isShowNull(projectData.targetApprivalComment) + '</td>' +
                                            '<td class="td_title">项目子任务审批状态：</td><td class="td_content">' +
                                            function () {
                                                var itemApprivalStatus = isShowNull(projectData.itemApprivalStatus);
                                                if (itemApprivalStatus == 0) {
                                                    return '未上报';
                                                } else if (itemApprivalStatus == 1) {
                                                    return '已上报(待批)';
                                                } else if (itemApprivalStatus == 2) {
                                                    return '同意';
                                                } else if (itemApprivalStatus == 3) {
                                                    return '不同意';
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">项目经验：</td><td class="td_content">' + isShowNull(projectData.experience) + '</td>' +
                                            '<td class="td_title">校核人：</td><td class="td_content">' + isShowNull(projectData.infoCheckName) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">审批状态：</td><td class="td_content">' +
                                            function () {
                                                var auditerStatus = isShowNull(projectData.auditerStatus);
                                                if (auditerStatus == 0) {
                                                    return '待审批';
                                                } else if (auditerStatus == 1) {
                                                    return '批准';
                                                } else if (auditerStatus == 2) {
                                                    return '不批准';
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">审批人：</td><td class="td_content">' + isShowNull(projectData.auditer) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">支付比例1：</td><td class="td_content">' + isShowNull(projectData.paymentRatio1) + '</td>' +
                                            '<td class="td_title">结算比例1：</td><td class="td_content">' + isShowNull(projectData.settlementRatio1) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">支付比例2：</td><td class="td_content">' + isShowNull(projectData.paymentRatio2) + '</td>' +
                                            '<td class="td_title">结算比例2：</td><td class="td_content">' + isShowNull(projectData.settlementRatio2) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">支付比例3：</td><td class="td_content">' + isShowNull(projectData.paymentRatio3) + '</td>' +
                                            '<td class="td_title">结算比例3：</td><td class="td_content">' + isShowNull(projectData.settlementRatio3) + '</td>' +
                                            '</tr>',
                                            '</tbody></table>'].join('');

                                        $('#projectDetail').html(projectStr);
                                    }
                                });
                            }
                        });
                    });

                    // 点击子项目名称显示详情
                    $(document).on('click', '.pBag_link', function () {
                        var pbagId = $(this).attr('pbagId');
                        $.get('/plcProjectBag/selectPbagById', {pbagId: pbagId}, function (res) {
                            var pBagData = res.data;
                            if (!!pBagData) {
                                layer.open({
                                    type: 1,
                                    title: '【子项目】' + pBagData.pbagName,
                                    area: ['70%', '90%'],
                                    maxmin: true,
                                    min: function () {
                                        $('.layui-layer-shade').hide()
                                    },
                                    content: '<div id="pBagDetail"></div>',
                                    success: function () {
                                        var pBagStr = ['<table class="layui-table"><tbody>',
                                            '<tr>' +
                                            '<td class="td_title">子项目编号：</td><td class="td_content">' + isShowNull(pBagData.bagNumber) + '</td>' +
                                            '<td class="td_title">子项目名称：</td><td class="td_content">' + isShowNull(pBagData.pbagName) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">上级子项目：</td><td class="td_content">' + isShowNull(pBagData.parentPbagName) + '</td>' +
                                            '<td class="td_title">子项目性质：</td><td class="td_content">' + isShowNull(pBagData.pbagNature) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">子项目内容：</td><td class="td_content">' + isShowNull(pBagData.pbagContent) + '</td>' +
                                            '<td class="td_title">子项目分类：</td><td class="td_content">' + isShowNull(dictionaryObj['PBAG_CLASS']['object'][pBagData.pbagClass]) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">子项目类型：</td><td class="td_content">' + isShowNull(dictionaryObj['PBAG_TYPE']['object'][pBagData.pbagType]) + '</td>' +
                                            '<td class="td_title">成本类型：</td><td class="td_content">' + isShowNull(pBagData.costType) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">责任人：</td><td class="td_content">' + isShowNull(pBagData.dutyUserName) + '</td>' +
                                            '<td class="td_title">责任人电话：</td><td class="td_content">' + isShowNull(pBagData.dutyUserTel) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">责任部门：</td><td class="td_content">' + isShowNull(pBagData.dutyDeptName) + '</td>' +
                                            '<td class="td_title">验收标准：</td><td class="td_content">' + isShowNull(pBagData.acceptStandard) + '</td>' +
                                            '</tr>',
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">计划开始时间：</td><td class="td_content">' + formatDate(pBagData.planBeginDate) + '</td>' +
                                            '<td class="td_title">计划结束时间：</td><td class="td_content">' + formatDate(pBagData.planEndDate) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">实际开始时间：</td><td class="td_content">' + formatDate(pBagData.realBeginDate) + '</td>' +
                                            '<td class="td_title">实际结束时间：</td><td class="td_content">' + formatDate(pBagData.realEndDate) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">是否控制预算：</td><td class="td_content">' + (isShowNull(pBagData.budgetYn) == 1 ? '是' : '否') + '</td>' +
                                            '<td class="td_title">子项目层级：</td><td class="td_content">' + isShowNull(pBagData.pbagLevel) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">建设单位：</td><td class="td_content">' + isShowNull(dictionaryObj['CUSTOMER_UNIT']['object'][pBagData.buildUnit]) + '</td>' +
                                            '<td class="td_title">设计单位：</td><td class="td_content">' + isShowNull(dictionaryObj['CUSTOMER_UNIT']['object'][pBagData.designUnit]) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">计划工期：</td><td class="td_content">' + isShowNull(pBagData.truePeriod) + '</td>' +
                                            '<td class="td_title">实际工期：</td><td class="td_content">' + isShowNull(pBagData.planPeriod) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">子项目关键任务：</td><td class="td_content">' + isShowNull(pBagData.pbagTarget) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">是否新建子任务：</td><td class="td_content">' + (isShowNull(pBagData.isNewItem) == 1 ? '是' : '否') + '</td>' +
                                            '<td class="td_title">是否新建关键任务：</td><td class="td_content">' + (isShowNull(pBagData.isNewTarget) == 1 ? '是' : '否') + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">建设单位负责人及电话：</td><td class="td_content">' + isShowNull(pBagData.buildUnitUser) + '</td>' +
                                            '<td class="td_title">设计单位负责人及电话：</td><td class="td_content">' + isShowNull(pBagData.designUnitUser) + '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">采购单位负责人及电话：</td><td class="td_content">' + isShowNull(pBagData.purchaseUnitUser) + '</td>' +
                                            '<td class="td_title">子项目状态：</td><td class="td_content">' +
                                            function () {
                                                var bagStatus = isShowNull(pBagData.bagStatus);
                                                if (bagStatus == 1) {
                                                    return '未开始';
                                                } else if (bagStatus == 2) {
                                                    return '超时未开始';
                                                } else if (bagStatus == 3) {
                                                    return '正在进行';
                                                } else if (bagStatus == 4) {
                                                    return '进度滞后';
                                                } else if (bagStatus == 5) {
                                                    return '进度超前';
                                                } else if (bagStatus == 6) {
                                                    return '暂停执行';
                                                } else if (bagStatus == 7) {
                                                    return '正常完成';
                                                } else if (bagStatus == 8) {
                                                    return '滞后完成';
                                                } else if (bagStatus == 9) {
                                                    return '提前完成';
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '</tr>',
                                            '<tr>' +
                                            '<td class="td_title">审批状态：</td><td class="td_content">' +
                                            function () {
                                                var auditerStatus = isShowNull(pBagData.auditerStatus);
                                                if (auditerStatus == 0) {
                                                    return '待审批';
                                                } else if (auditerStatus == 1) {
                                                    return '批准';
                                                } else if (auditerStatus == 2) {
                                                    return '不批准';
                                                } else {
                                                    return '';
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">审批人：</td><td class="td_content">' + isShowNull(pBagData.auditerName) + '</td>' +
                                            '</tr>',
                                            '</tbody></table>'].join('');

                                        $('#pBagDetail').html(pBagStr);
                                    }
                                });
                            }
                        });
                    });

                    // 点击关键任务名称显示详情
                    $(document).on('click', '.target_link', function () {
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
                    });
                })

                function loadProjectStatusCount(searchData) {
                    // 获取项目数据
                    $.get('/StatisticalReport/getProJectInfoStatusCount', searchData, function (res) {
                        if (res.flag) {
                            $('.task_panel_1 span').text(res.data.sumCount)
                            $('.task_panel_2 span').text(res.data.beCompleted)
                            $('.task_panel_3 span').text(res.data.inProcess)
                            $('.task_panel_4 span').text(res.data.delay)
                            $('.task_panel_5 span').text(res.data.beCompleting)
                            $('.task_panel_6 span').text(res.data.ending)

                            $('#delayProject').off('click')
                            if (res.obj.length > 0) {
                                var str = ''
                                res.obj.forEach(function (item) {
                                    str += '<p class="tips_p" projectId="' + item.projectId + '" title="' + item.projectAbbreviation + '">' + item.projectAbbreviation + '</p>'
                                })
                                $('#delayProject').on('click', function () {
                                    var _this = this
                                    tipsIndex = layer.tips('<div class="tips_module"><div class="tips_content">' + str + '</div></div>', _this, {
                                        tips: [1, '#3595CC'],
                                        time: 0
                                    });
                                    return false
                                })
                            }
                        }
                    })
                }

                function loadChart(searchData) {
                    chartOne.showLoading()
                    chartTwo.showLoading()
                    $.get('/StatisticalReport/getProjTargetTaskStatusByBages', searchData, function (res) {
                        chartOne.hideLoading()
                        if (res.flag && res.data.length > 0) {
                            var legendData = []
                            var series = []
                            res.data.forEach(function (item) {
                                legendData.push(item.name)
                                var obj = {
                                    name: item.name,
                                    type: 'bar',
                                    data: [item.data['将到期'], item.data['已延期'], item.data['延期完成']],
                                    markLine: {
                                        data: [
                                            {type: 'average', name: '平均值'}
                                        ]
                                    }
                                }
                                series.push(obj)
                            })
                            chartOne.setOption({
                                title: {
                                    show: false,
                                    text: $('#project').attr('projectname'),
                                },
                                tooltip: {
                                    trigger: 'axis'
                                },
                                legend: {
                                    data: legendData
                                },
                                calculable: true,
                                xAxis: [
                                    {
                                        type: 'category',
                                        data: ['将到期', '已延期', '延期完成']
                                    }
                                ],
                                yAxis: [
                                    {
                                        type: 'value'
                                    }
                                ],
                                series: series
                            }, true)
                        } else {
                            chartOne.setOption({}, true)
                        }
                    })

                    $.get('/StatisticalReport/getAllProjTargetStatusCount', searchData, function (res) {
                        chartTwo.hideLoading()
                        if (res.flag) {
                            var legendData = []
                            var data = []
                            var color = []
                            $.each(res.data, function (k, o) {
                                legendData.push(k)
                                color.push(taskStatusObj[k].color)
                                var obj = {
                                    value: o,
                                    name: k
                                }
                                data.push(obj)
                            })
                            chartTwo.setOption({
                                title: {
                                    show: false,
                                    text: $('#project').attr('projectname'),
                                    left: 'center',
                                    textStyle: {
                                        width: '60%'
                                    }
                                },
                                color: color,
                                tooltip: {
                                    trigger: 'item',
                                    formatter: '{a} <br/>{b} : {c} ({d}%)'
                                },
                                legend: {
                                    orient: 'vertical',
                                    left: 'left',
                                    data: legendData
                                },
                                series: [
                                    {
                                        name: '任务状态',
                                        type: 'pie',
                                        radius: '55%',
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
                                        data: data
                                    }
                                ]
                            }, true)
                        } else {
                            chartTwo.setOption({}, true)
                        }
                    })
                }
            }

            // 重置查询区域布局
            function resizeQuery() {
                $('.layui-tab-content').height($(window).height() - 70);
                var queryWidth = $('.search_form ').width();
                $('.query_item').width((queryWidth - 20) / 5);
                var maxWidth = (queryWidth - 20) / 5 - 126
                $('#projectIdsSelectStyle').html('#projectIdsSelect .xm-body .xm-option-content {\n' +
                    '\t\t\t\tdisplay: block !important;\n' +
                    '\t\t\t\tmax-width: ' + maxWidth + 'px;\n' +
                    '\t\t\t}')
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

            // 处理网络图数据
            function initNetworkData(data, pId) {
                var nodes = []
                var edges = []
                data.forEach(function (item) {
                    var node = {
                        id: item.tgId.toString(),
                        label: fittingString(item.tgName, 150, 14)
                    }

                    if (item.nextType && pId) {
                        var edge = {
                            source: pId.toString(), // 起始节点id
                            target: item.tgId.toString(), // 结束点id
                            data: { // 画线数据
                                amount: item.nextType
                            }
                        }

                        edges.push(edge)
                    }
                    nodes.push(node)
                    if (item.preNodes && item.preNodes.length > 0) {
                        var childNode = initNetworkData(item.preNodes, item.tgId)
                        nodes = nodes.concat(childNode.nodes)
                        edges = edges.concat(childNode.edges)
                    }
                })

                return {
                    nodes: nodes,
                    edges: edges
                }
            }

            function fittingString(str, maxWidth, fontSize) {
                let currentWidth = 0;
                let res = str;
                const pattern = new RegExp('[\u4E00-\u9FA5]+'); // distinguish the Chinese charactors and letters
                str.split('').forEach(function (letter, i) {
                    if (currentWidth > maxWidth) return;
                    if (pattern.test(letter)) {
                        // Chinese charactors
                        currentWidth += fontSize;
                    } else {
                        // get the width of single letter according to the fontSize
                        currentWidth += G6.Util.getLetterWidth(letter, fontSize);
                    }
                    if (currentWidth > maxWidth) {
                        res = str.substr(0, i) + '\n' + str.substr(i);
                    }
                });
                return res;
            };

			//将毫秒数转为yyyy-MM-dd格式时间
			function format(t) {
				if (t) {
					return new Date(t).Format("yyyy-MM-dd");
				} else {
					return '';
				}
			}
		</script>
		<script src="/js/planCheck/g6.min.js"></script>
	</body>
</html>
