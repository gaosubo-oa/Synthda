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
		<title>项目分析</title>
		
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		
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
			
			.select {
				background: #eee;
			}
			
			.project_item {
				position: absolute;
				top: 5px;
				right: 15px;
				bottom: 10px;
				left: 250px;
			}
			
			/*关键任务类型复选框位置调整*/
			.layui-table-cell .layui-form-checkbox[lay-skin=primary] {
				top: 6px;
			}
			
			/*表格排序样式*/
			.order_box {
				position: absolute;
				top: 0;
				right: 0;
				width: 16px;
				height: 100%;
				z-index: 3;
			}
			
			.order_box .layui-icon {
				position: absolute;
				left: 0;
				width: 16px;
				height: 16px;
				line-height: 16px;
				color: #c2c2c2;
				cursor: pointer;
			}
			
			.order_box .icon_asc {
				top: 5px;
				transform: rotate(180deg);
			}
			
			.order_box .icon_desc {
				bottom: 5px;
			}
			
			.order_asc .icon_asc {
				color: #666;
			}
			
			.order_desc .icon_desc {
				color: #666;
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
			<div class="layui-tab layui-tab-brief" lay-filter="planProgressTab" style="margin: 0;">
				<ul class="layui-tab-title" style="float: left">
					<li class="layui-this">项目分析</li>
				</ul>
				<div class="layui-tab-content" style="position: absolute;top: 40px;right: 0;bottom: 80px;left: 0;">
					<div class="search_module">
						<form class="layui-form clearfix search_form" lay-filter="searchForm">
							<div class="layui-row" style="padding: 5px 0;">
								<div class="layui-form-item query_item layui-col-xs2">
									<label class="layui-form-label">区域:</label>
									<div class="layui-input-block">
										<select name="projectOrgId" lay-filter="projectOrgId">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item query_item layui-col-xs2">
									<label class="layui-form-label">项目:</label>
									<div class="layui-input-block">
										<div id="projectId" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="layui-form-item query_item layui-col-xs2">
									<label class="layui-form-label">关注等级:</label>
									<div class="layui-input-block">
										<div id="controlLevel" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="layui-form-item query_item layui-col-xs2">
									<label class="layui-form-label" style="line-height: normal">关键任务类型:</label>
									<div class="layui-input-block">
										<div id="tgType" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="query_button_group query_item layui-col-xs2">
									<button type="button" id="searchBtn" class="layui-btn layui-btn-sm" style="margin-left: 25px;">查询</button>
									<button type="reset" id="resetBtn" class="layui-btn layui-btn-sm">重置</button>
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
								<div class="layui-col-xs6">
									<div id="radarShow" style="height: 340px;"></div>
								</div>
							</div>
						</div>
						
						<table id="projectProgressTable" lay-filter="projectProgressTable"></table>
					</div>
				</div>
			</div>
		</div>
		
		<script>
            var form, table, treeTable
            window.onresize = function () {
                myChartPie.resize();
                myChartRadar.resize();
            }
            var tgTypeData = []
            var ControlLevelData = []
            var projectId = []
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
                TG_TYPE_PARENT: {},
            }
            var dictionaryStr = 'CONTROL_LEVEL,PROJECT_TYPE,PBAG_TYPE,PBAG_NATURE,PBAG_CLASS,CUSTOMER_UNIT,PLAN_SYCLE,TG_TYPE,PLAN_PHASE,UNIT,CGCL_TYPE,RENWUJIHUA_TYPE,TG_TYPE_PARENT';
            // 获取数据字典数据
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: ''}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
                                if (dict == 'CONTROL_LEVEL') {
                                    ControlLevelData.push({name: item.dictName, value: item.dictNo})
                                }
                            });
                        }
                    }
                }

                // 获取项目数据
                $.get('/StatisticalReport/getProjectInfo', function (res) {
                    var str = '';
                    if (res.flag && res.data.length > 0) {
                        res.data.forEach(function (item) {
                            projectId.push({name: item.projectAbbreviation, value: item.projectId})
                        });
                        res.obj.forEach(function (item) {
                            str += '<option value="' + item.deptId + '">' + item.deptName + '</option>'
                        });
                    }
                    $('.search_form [name="projectOrgId"]').append(str);

                    $.get('/Dictonary/getTgType', function(res) {
                        tgTypeData = res.object;
                        init();
                    });
                });
            });

            function init() {
                layui.use(['form', 'treeTable', 'table', 'xmSelect'], function () {
                    form = layui.form,
                        table = layui.table,
                        xmSelect = layui.xmSelect,
                        treeTable = layui.treeTable;
                    form.render()
                    var projectProgressTable = null

                    // 获取关注等级
                    $('.search_form [name="controlLevel"]').append(dictionaryObj['CONTROL_LEVEL'].str);

                    // 关键任务类型
                    var tgTypeSelect = xmSelect.render({
                        el: '#tgType',
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
                    // 关键任务类型
	                if ($.cookie('proAnaplanType')) {
		                tgTypeSelect.setValue($.cookie('proAnaplanType').split(','))
	                }
                    // 关注等级多选
                    var ControlLevelSelect = xmSelect.render({
                        el: '#controlLevel',
                        toolbar: {
                            show: true,
                        },
                        data: ControlLevelData,
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
	                    name: 'controlLevel'
                    });
                    // 关注等级
	                if ($.cookie('proAnacontrolLevel')) {
		                ControlLevelSelect.setValue($.cookie('proAnacontrolLevel').split(','))
	                }
                    // 项目多选
                    var ProjectSelect = xmSelect.render({
                        el: '#projectId',
                        toolbar: {
                            show: true,
                        },
                        data: projectId,
                        name: 'projectId',
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

                    /**
                     * 加载表格数据
                     * @param searchData (查询条件)
                     */
                    function initTable(searchData) {
                        var height = $(window).height() - 538 >= 350 ? 'full-460' : '350px'
                        projectProgressTable = treeTable.render({
                            elem: '#projectProgressTable',
                            url: '/StatisticalReport/getProjectInfoByTaskStatus',
                            defaultToolbar: [''],
                            height: height,
                            tree: {
                                iconIndex: 0,
                                idName: 'planItemId',
                                childName: 'children',
                                onlyIconControl: true
                            },
                            cols: [[
                                /* {
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
								 },*/
                                {
                                    field: 'tgName', title: '项目/关键任务名称', width: 350, align: 'left', templet: function (d) {
                                        if (!!d.planItemId) {
                                            return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="taskDetail" planItemId="' + d.planItemId + '" parentPlanItemId="' + d.parentPlanItemId + '">' + '【子任务】' + d.taskName + '</a>';
                                        } else if (!!d.tgId) {
                                            return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="target_name_link" tgId="' + d.tgId + '">' + '【关键任务】' + d.tgName + '</a>';
                                        } else if (!!d.pbagId) {
                                            return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="pbag_name_link" pbagId="' + d.pbagId + '">' + '【子项目】' + d.pbagName + '</a>';
                                        } else if (!!d.projectId) {
                                            return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="project_name_link" projectId="' + d.projectId + '">' + '【项目】' + d.projectAbbreviation + '</a>';
                                        } else {
                                            return '';
                                        }
                                    }
                                },
                                {
                                    field: 'day',
                                    title: '延期天数<div field="day" class="order_box"><i class="layui-icon icon_asc layui-icon-triangle-d"></i><i class="layui-icon icon_desc layui-icon-triangle-d"></i></div>',
                                    minWidth: 90,
                                    align: 'center'
                                },
                                {
                                    field: 'count',
                                    title: '延期任务数<div field="count" class="order_box"><i class="layui-icon icon_asc layui-icon-triangle-d"></i><i class="layui-icon icon_desc layui-icon-triangle-d"></i></div>',
                                    minWidth: 100,
                                    align: 'center'
                                },
                                {
                                    field: 'tgType', title: '任务类型', width: 130, align: 'center', templet: function (d) {
                                        if (!d.tgType) {
                                            return ''
                                        } else {
                                            return d.tgType
                                        }
                                    }
                                },
                                {
                                    field: 'taskPrecess', title: '完成度', width: 50, align: 'center', templet: function (d) {
                                        if (d.taskPrecess == undefined) {
                                            return ''
                                        } else {
                                            return d.taskPrecess + '%'
                                        }
                                    }
                                },
                                {
                                    field: 'mainCenterDeptName', title: '中心责任部门', width: 130, templet: function (d) {
                                        if (d.delayStatus && d.delayStatus.centerDept && d.mainCenterDeptName && d.delayStatus.centerDept == 1) {
                                            return '<span style="color: #36648B;font-size: 20px">★</span>' + d.mainCenterDeptName
                                        } else {
                                            return d.mainCenterDeptName
                                        }
                                    }
                                },
                                {
                                    field: 'dutyUserName', title: '中心责任人', width: 100, templet: function (d) {
                                        //判断是子项目
                                        if (d.bagNumber && d.pbagId) {
                                            return ''
                                        } else {
                                            if (d.dutyUserName) {
                                                if (d.delayStatus && d.delayStatus.centerDeptUser && d.delayStatus.centerDeptUser == 2) {
                                                    return '<span style="color: #c00;font-size: 25px">★</span>' + d.dutyUserName.replace(/,$/, '')
                                                } else if (d.delayStatus && d.delayStatus.centerDeptUser && d.delayStatus.centerDeptUser == 3) {
                                                    return '<span style="color: #458B74;font-size: 25px">★</span>' + d.dutyUserName.replace(/,$/, '')
                                                } else {
                                                    return d.dutyUserName.replace(/,$/, '')
                                                }
                                            } else {
                                                return ''
                                            }
                                        }
                                    }
                                },
                                {
                                    field: 'mainAreaDeptName', title: '区域责任部门', width: 130, templet: function (d) {
                                        if (d.delayStatus && d.delayStatus.areaDept && d.mainAreaDeptName && d.delayStatus.areaDept == 1) {
                                            return '<span style="color: #36648B;font-size: 25px">★</span>' + d.mainAreaDeptName
                                        } else {
                                            return d.mainAreaDeptName
                                        }
                                    }
                                },
                                {
                                    field: 'mainAreaUserName', title: '区域责任人', width: 100, templet: function (d) {
                                        if (d.delayStatus && d.delayStatus.areaDeptUser && d.mainAreaUserName && d.delayStatus.areaDeptUser == 2) {
                                            return '<span style="color: #c00;font-size: 25px">★</span>' + d.mainAreaUserName
                                        } else if (d.delayStatus && d.delayStatus.areaDeptUser && d.mainAreaUserName && d.delayStatus.areaDeptUser == 3) {
                                            return '<span style="color: #458B74;font-size: 25px">★</span>' + d.mainAreaUserName
                                        } else {
                                            return d.mainAreaUserName
                                        }
                                    }
                                },
                                {
                                    field: 'mainProjectDeptName', title: '总承包部责任部门', width: 130, templet: function (d) {
                                        if (d.delayStatus && d.delayStatus.projectDept && d.mainProjectDeptName && d.delayStatus.projectDept == 1) {
                                            return '<span style="color: #36648B;font-size: 25px">★</span>' + d.mainProjectDeptName
                                        } else {
                                            return d.mainProjectDeptName
                                        }
                                    }
                                },
                                {
                                    field: 'mainProjectUserName', title: '总承包部责任人', width: 100, templet: function (d) {
                                        //判断是子项目
                                        if (d.bagNumber && d.pbagId) {
                                            return d.dutyUserName
                                        } else {
                                            if (d.delayStatus && d.delayStatus.projectDeptUser && d.mainProjectUserName && d.delayStatus.projectDeptUser == 2) {
                                                return '<span style="color: #c00;font-size: 25px">★</span>' + d.mainProjectUserName
                                            } else if (d.delayStatus && d.delayStatus.projectDeptUser && d.mainProjectUserName && d.delayStatus.projectDeptUser == 3) {
                                                return '<span style="color: #458B74;font-size: 25px">★</span>' + d.mainProjectUserName
                                            } else {
                                                return d.mainProjectUserName
                                            }
                                        }
                                    }
                                },
                                {
                                    field: 'planEndDate', title: '计划结束时间', width: 150, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.tgId) {
                                            str = formatDate(d.planEndDate);
                                        } else if (!!d.pbagId) {
                                            str = formatDate(d.planEndDate);
                                        } else if (!!d.projectId) {
                                            str = formatDate(d.endTime);
                                        }

                                        return str;
                                    }
                                },
                                {
                                    field: 'realEndDate', title: '实际结束时间', width: 150, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.realEndDate) {
                                            str = formatDate(d.realEndDate);
                                        }

                                        return str;
                                    }
                                },
                                {
                                    field: 'planStartDate', title: '计划开始时间', width: 150, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.tgId) {
                                            str = formatDate(d.planStartDate);
                                        } else if (!!d.pbagId) {
                                            str = formatDate(d.planBeginDate);
                                        } else if (!!d.projectId) {
                                            str = formatDate(d.statrtTime);
                                        }

                                        return str;
                                    }
                                },
                                {
                                    field: 'realStartDate', title: '实际开始时间', width: 150, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.tgId) {
                                            str = formatDate(d.realStartDate);
                                        } else if (!!d.pbagId) {
                                            str = formatDate(d.truePeriod);
                                        } else if (!!d.projectId) {
                                            str = formatDate(d.realBeginDate);
                                        }

                                        return str;
                                    }
                                },
                                {
                                    field: 'planContinuedDate', title: '计划工期', width: 100, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.tgId) {
                                            str = d.planContinuedDate || '';
                                        } else if (!!d.pbagId) {
                                            str = d.planPeriod || '';
                                        } else if (!!d.projectId) {
                                            str = timeRange(d.startTime, d.endTime);
                                        }

                                        return str;
                                    }
                                },
                                {
                                    field: 'realContinuedDate', title: '实际工期', width: 100, align: 'center', templet: function (d) {
                                        var str = '';

                                        if (!!d.tgId) {
                                            str = d.realContinuedDate || '';
                                        } else if (!!d.pbagId) {
                                            str = d.realBeginDate || '';
                                        } else if (!!d.projectId) {
                                            str = timeRange(d.realBeginDate, d.realEndDate);
                                        }

                                        return str;
                                    }
                                },
                                {
                                    field: 'controlLevel', title: '关注等级', width: 100, align: 'center', templet: function (d) {
                                        if (!!d.controlLevel) {
                                            return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                        } else {
                                            return '';
                                        }
                                    }
                                },
                                {
                                    field: 'resultStandard', title: '完成标准', width: 300, align: 'left', templet: function (d) {
                                        var str = '';

                                        if (!!d.tgId) {
                                            str = d.resultStandard || '';
                                        } else if (!!d.pbagId) {
                                            str = d.acceptStandard || '';
                                        } else if (!!d.projectId) {
                                            str = d.acceptStandard || '';
                                        }

                                        return str;
                                    }
                                }
                            ]],
                            parseData: function (res) { //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data //解析数据列表
                                };
                            },
                            where: searchData
                        });
                    }

                    form.on('select(projectOrgId)', function (data) {
                        loadProjectInfo(data.value)
                    })

                    // 查询
                    $('#searchBtn').click(function () {
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name');
                            var value = $(this).val();
                            searchData[key] = value;

                            // 将查询值保存至cookie中,有效期为5天,添加前缀，防止和其他页面的cookie冲突
                            $.cookie('proAna'+key, value, {expires: 5, path: "/"});
                        });

						var projectStr  = ProjectSelect.getValue('valueStr');
						if(projectStr==""){
							projectId.forEach(function (item) {
								projectStr+=item.value+",";
							})
							searchData.projectId = projectStr;
						}else{
							searchData.projectId = projectStr;
						}
                        var planTypeArr = tgTypeSelect.getValue();
                        var planType = ''
                        planTypeArr.forEach(function (item) {
                            planType += item.dictNo + ',';
                        });

                        searchData.planType = planType;

                        initTable(searchData);
                        initChart(searchData);
                    });

                    // 清空查询条件
                    $('#resetBtn').click(function () {
                        $('[name="projectId"]').val('');
                        $('[name="controlLevel"]').val('');
                        $('#tgType_query').val('');
                        $('#tgType_query').attr('dictNo', '');
                        ControlLevelSelect.setValue([]);
                        ProjectSelect.setValue([]);
                        tgTypeSelect.setValue([]);
                        form.render();
                    });

                    // 排序按钮点击
                    $(document).on('click', '.order_box', function () {
                        var $this = $(this)
                        var $parent = $this.parents('table')
                        var orderStr = ''
                        var sortType = ''

                        if ($this.hasClass('order_asc')) {
                            orderStr = 'order_desc'
                            sortType = 'desc'
                        } else if ($this.hasClass('order_desc')) {
                            sortType = orderStr = ''
                        } else {
                            orderStr = 'order_asc'
                            sortType = 'asc'
                        }
                        $parent.find('.order_box').removeClass('order_asc').removeClass('order_desc')
                        $this.addClass(orderStr)

                        projectProgressTable.options.where.sort = $this.attr('field') || ''
                        projectProgressTable.options.where.sortType = sortType
                        projectProgressTable.refresh()
                    })

	                // 区域
	                if ($.cookie('proAnaprojectOrgId')) {
	                    $('.search_form [name="projectOrgId"]').val($.cookie('proAnaprojectOrgId'))
		                form.render('select')
		                loadProjectInfo($.cookie('proAnaprojectOrgId'))
	                }

	                // 触发查询事件加载数据
                    setTimeout(function () {
                        $('#searchBtn').trigger('click');
                    }, 300);

                    function loadProjectInfo(deptId) {
                        // 获取项目数据
                        $.get('/StatisticalReport/getProjectInfo', {deptId: deptId}, function (res) {
                            var str = '';
                            projectId = []
                            if (res.flag && res.data.length > 0) {
                                projectId = []
                                res.data.forEach(function (item) {
                                    projectId.push({name: item.projectAbbreviation, value: item.projectId})
                                });
                            }
                            ProjectSelect = xmSelect.render({
                                el: '#projectId',
                                toolbar: {
                                    show: true,
                                },
                                data: projectId,
                                name: 'projectId',
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
                        });
                    }
                });
            }

            // 加载其他图表
            function initChart(searchData) {
                // 加载饼图
                initPie(searchData);
                // 加载雷达图
                initRadar(searchData);
            }

            /********************************饼图开始**************************************/
            var myChartPie = echarts.init(document.getElementById('pieShow'));

            /**
             * 加载饼图
             */
            function initPie(searchData) {
                myChartPie.showLoading();
                searchData = searchData || {}
                $.get('/StatisticalReport/getAllTarCountAndTaskType', searchData, function (res) {
                    myChartPie.hideLoading();
                    if (res.flag) {
                        var data = res.data;
                        var legendData = ['延期进行中', '延期未分配', '延期已完成']
                        var pieData = []
                        legendData.forEach(function (item) {
                            var pieObj = {}
                            pieObj.name = item
                            pieObj.value = data[item]
                            pieData.push(pieObj)
                        })

                        myChartPie.setOption({
                            tooltip: {
                                trigger: 'item',
                                formatter: '{a} <br/>{b} : {c} ({d}%)'
                            },
                            color: ['#c00', '#36648B', '#458B74'],
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
            var myChartRadar = echarts.init(document.getElementById('radarShow'));

            /**
             * 加载雷达图
             */
            function initRadar(searchData) {
                myChartRadar.showLoading();
                $.get('/StatisticalReport/getAllTarCountAndType', searchData, function (res) {
                    myChartRadar.hideLoading();
                    var data = res.data
                    var optionData = radar(data)
                    myChartRadar.setOption({
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
                        color: ['#c00', '#36648B', '#458B74'],
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
            }

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

            //计算计划工期
            function timeRange(beginTime, endTime) {
                if (!!beginTime && !!endTime) {
                    var t1 = new Date(beginTime)
                    var t2 = new Date(endTime)
                    var time = t2.getTime() - t1.getTime()
                    var days = parseInt(time / (1000 * 60 * 60 * 24)) + 1
                    return days
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

            //点击子任务展示详情
            $(document).on('click', '.taskDetail', function () {
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
            })

            // 点击关键任务名称显示详情
            $(document).on('click', '.target_name_link', function () {
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

            // 点击子项目名称显示详情
            $(document).on('click', '.pbag_name_link', function () {
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

            // 点击项目名称显示详情
            $(document).on('click', '.project_name_link', function () {
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

            //查询--关键任务类型--弹出层选择
            $('#tgType_query').click(function () {
                tgTypeSelect()
            })

            /*弹出层显示关键任务类型--tgType*/
            function tgTypeSelect() {
                var tgTypeChildren = null
                layer.open({
                    type: 1,
                    title: '关键任务类型',
                    btn: ['确定', '取消'],
                    area: ['60%', '85%'],
                    maxmin: true,
                    content: '<div style="position: relative;height: 100%; width: 100%;padding: 5px 10px;box-sizing: border-box;">' +
                        '<div class="target_module" style="position: relative;float: left;height: 100%; width: 230px;">' +
                        '<h3 style="padding: 10px 15px; text-align: center;">关键任务类型父级</h3>' +
                        '<div class="tgTypeParent"><ul style="margin-top: 8px"></ul></div>' +
                        '</div>' +
                        '<div class="project_item">' +
                        '<h3 style="padding: 10px 15px; text-align: center;">关键任务类型子级</h3>' +
                        '<div>' +
                        '<table id="tgTypeChildren" lay-filter="tgTypeChildren"></table>' +
                        '</div>' +
                        '</div>' +
                        '</div>',
                    success: function () {
                        // 初始化左侧关键任务类型
                        $.get('/Dictonary/selectDictionaryByNo', {dictNo: 'TG_TYPE_PARENT'}, function (res) {
                            var data = res.data
                            var str = ''
                            for (var i = 0; i < data.length; i++) {
                                str += '<li dictNo="' + data[i].dictNo + '" style="text-align: center;padding: 3px">' + data[i].dictName + '</li>';
                            }
                            $('.tgTypeParent ul').html(str)
                        })
                        // 节点点击事件
                        $(document).on('click', '.tgTypeParent ul li', function () {
                            $(this).addClass('select').siblings().removeClass('select')
                            var dictNo = $(this).attr('dictNo')
                            tgTypeChildren = table.render({
                                elem: '#tgTypeChildren',
                                url: '/Dictonary/getTgTypeByDictNo',
                                cols: [[
                                    {type: 'checkbox'},
                                    {
                                        field: 'dictName', align: 'left', title: '关键任务类型', templet: function (d) {
                                            return '<span  class="initTgId" dictNo="' + d.dictNo + '" >' + d.dictName + '</span>'
                                        }
                                    }
                                ]],
                                where: {
                                    dictNo: dictNo,
                                },
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    msgName: 'msg',
                                    dataName: 'obj'
                                },
                                done: function (res) {
                                    //选中的回显
                                    if ($('#tgType_query').attr('dictNo')) {
                                        var dictNoArr = $('#tgType_query').attr('dictNo').split(',')
                                        $('.initTgId').each(function (index) {
                                            dictNoArr.forEach(function (v, i) {
                                                if ($('.initTgId').eq(index).attr('dictNo') == v) {
                                                    $('.initTgId').eq(index).parents('td').prev().find('input').prop('checked', 'true')
                                                    form.render()
                                                }
                                            })
                                        })
                                    }
                                }
                            });
                        })
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('tgTypeChildren');
                        var dictNo = '';
                        var dictName = '';
                        checkStatus.data.forEach(function (item) {
                            dictNo += item.dictNo + ',';
                            dictName += item.dictName + ',';
                        });
                        $('#tgType_query').val(dictName)
                        $('#tgType_query').attr('dictNo', dictNo)
                        layer.close(index)
                    }
                });
            }
		
		</script>
	
	</body>
</html>
