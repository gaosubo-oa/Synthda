<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/8/10
  Time: 17:56
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
		<title>项目进展报表</title>
		
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script src="../js/jquery/jquery.cookie.js"></script>
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
			
			.search_form .layui-input-block {
				margin-left: 80px;
			}
			
			.search_form .layui-form-item {
				height: 35px;
				margin: 0;
				clear: none;
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
			
			.ew-tree-table .ew-tree-table-tool {
				height: 38px;
				min-height: 38px !important;
				padding: 3px 15px !important;
			}
			
			.ew-tree-table-tool-right {
				display: none;
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
		
		</style>
	
	</head>
	<body>
		<div class="container">
			<div class="layui-tab layui-tab-brief" lay-filter="planProgressTab" style="margin-top: 0;">
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
					<li class="icon_item">
						<img class="icon_img" src="/img/planCheck/planProgressReport/suspend.png">
						<span class="icon_tip">暂停</span>
					</li>
				</ul>
				<div class="layui-tab-content" style="position: absolute;top: 40px;right: 0;bottom: 80px;left: 0;">
					<div class="search_module">
						<form class="layui-form clearfix search_form">
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
									<label class="layui-form-label">项目:</label>
									<div class="layui-input-block">
										<div id="projectIdsSelect" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">周期类型:</label>
									<div class="layui-input-block">
										<select name="planSycle">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="query_button_group query_item">
									<button type="reset" id="resetBtn" class="layui-btn layui-btn-sm query_btn" style="margin-right: 0;">重置</button>
									<button type="button" id="searchBtn" class="layui-btn layui-btn-sm query_btn">查询</button>
									<button type="button" class="layui-btn layui-btn-sm more_query query_btn" isshow="0">
										<i class="layui-icon layui-icon-down" style="margin: 0;"></i>
									</button>
								</div>
							</div>

							<div class="clearfix hide_query" style="display: none;padding: 5px 0;">
								<div class="layui-form-item query_item">
									<label class="layui-form-label" style="line-height: normal">关键任务类型</label>
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
									<label class="layui-form-label">责任人</label>
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
									<label class="layui-form-label">分配状态</label>
									<div class="layui-input-block">
										<select name="allocationStatus">
											<option	value="">请选择</option>
											<option value="0">未分配</option>
											<option value="1">已分配</option>
										</select>
									</div>
								</div>
							</div>
						</form>
					</div>
					
					<div class="content">
						<div id="targetreportr" style="margin: 10px auto; height: 340px;"></div>
						<table id="projectProgressTable" lay-filter="projectProgressTable"></table>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="projectProgressBar">
			<div class="clearfix">
				<a class="layui-btn layui-btn-sm pie_chart" style="float: right;margin-left: 10px;" lay-event="pieChart">图表<i
						class="layui-icon layui-icon-up"></i></a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="projectDetail">甘特图</a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="projectDetail">网络图</a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="projectDetail">导出</a>
			</div>
		</script>
		
		<script type="text/javascript">

            var myChart = echarts.init(document.getElementById('targetreportr'));

            var pieDataObj = {}

            var option = {
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b} : {c} ({d}%)'
                },
                color: ['#7f7f7f', '#19ab7e', '#fad706', '#e46c0a', '#0119ff', '#4bacc6', '#ff0000'],
                legend: {
                    orient: 'vertical',
                    left: '20%',
                    top: '13%',
                    bottom: '10',
                    data: ['未开始', '进行中', '将到期', '已延期', '完成', '延期完成', '其他']
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
                        data: [],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            resizeQuery();

            window.onresize = function () {
                resizeQuery();
                myChart.resize();
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
                layui.use(['form', 'treeTable', 'xmSelect', 'table'], function () {
                    var form = layui.form,
                        treeTable = layui.treeTable,
                        xmSelect = layui.xmSelect,
                        table = layui.table;

                    myChart.on('pieselectchanged', function (obj) {
                        var key = [];
                        for (var k in obj.selected) {
                            if (obj.selected[k]) {
                                switch (k) {
                                    case '未开始':
                                        key.push('0');
                                        break;
                                    case '进行中':
                                        key.push('1');
                                        break;
                                    case '将到期':
                                        key.push('2');
                                        break;
                                    case '已延期':
                                        key.push('4');
                                        break;
                                    case '完成':
                                        key.push('5');
                                        break;
                                    case '延期完成':
                                        key.push('6');
                                        break;
                                    case '暂停':
                                        key.push('7');
                                        break;
                                    case '关闭':
                                        key.push('8');
                                        break;
                                    case '成果不符':
                                        key.push('9');
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }

                        taskStatusSelect.setValue(key);
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name');
                            var value = $(this).val();
                            searchData[key] = value;
                        });

                        // 状态
                        searchData.taskStatus = taskStatusSelect.getValue('valueStr');

                        // 所属部门
                        searchData.targetBelongDept = ($('#targetBelongDept').attr('deptid') || '').replace(/,$/, '');

                        projectProgressTable.reload({
                            where: searchData,
                            page: {
                                curr: 1
                            }
                        });
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

                    function initListData(projectId) {

                        var height = ''

                        if ($('#container').is(':hidden')) {
	                        height = $(window).height() - 538 >= 350 ? 'full-460' : '350px'
                        } else {
                            height = 'full-120'
                        }
                        
                        projectProgressTable = treeTable.render({
                            elem: '#projectProgressTable',
                            url: '/plcPlan/selectProReport',
                            toolbar: '#projectProgressBar',
                            defaultToolbar: [''],
                            height: height,
                            tree: {
                                iconIndex: 1,
                                idName: 'planItemId',
                                childName: 'children',
                                onlyIconControl: true
                            },
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
								// {
								//     field: 'tgNo', title: '编码', width: 300, align: 'left', templet: function (d) {
								//         if (!!d.tgId) {
								//             return d.tgNo;
								//         } else if (!!d.pbagId) {
								//             return d.bagNumber;
								//         } else if (!!d.projectId) {
								//             return d.projectNo;
								//         }
								//     }
								// },
								{
									field: 'tgName', title: '项目/关键任务名称', width: 400, align: 'left', templet: function (d) {
										if (!!d.planItemId) {
											return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="taskDetail" planItemId="' + d.planItemId + '" parentPlanItemId="' + d.parentPlanItemId + '">' + '【子任务】' + d.taskName + '</a>';
										} else if (!!d.tgId) {
											return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="target_name_link" tgId="' + d.tgId + '">' + '【关键任务】' + d.tgName + '</a>';
										} else if (!!d.pbagId) {
											return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="pbag_name_link" pbagId="' + d.pbagId + '">' + '【子项目】' + d.pbagName + '</a>';
										} else if (!!d.projectId) {
											return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="project_name_link" projectId="' + d.projectId + '">' + '【项目】' + d.projectName + '</a>';
										} else {
											return '';
										}
									}
								},
								// {
								//     field: 'taskStatus', title: '状态', width: 120, align: 'center', templet: function (d) {
								//         if (!!d.tgId) {
								//             if (d.taskStatus == '1') {
								//                 return '未开始';
								//             } else if (d.taskStatus == '2') {
								//                 return '进行中';
								//             } else if (d.taskStatus == '3') {
								//                 return '将到期';
								//             } else if (d.taskStatus == '4') {
								//                 return '已延期';
								//             } else if (d.taskStatus == '5') {
								//                 return '暂停';
								//             } else if (d.taskStatus == '6') {
								//                 return '完成';
								//             } else if (d.taskStatus == '7') {
								//                 return '延期完成';
								//             } else if (d.taskStatus == '8') {
								//                 return '成果不符';
								//             } else if (d.taskStatus == '9') {
								//                 return '关闭';
								//             } else {
								//                 return '';
								//             }
								//         } else {
								//             if (d.taskStatus == '1') {
								//                 return '未开始';
								//             } else if (d.taskStatus == '3') {
								//                 return '进行中';
								//             } else if (d.taskStatus == '4') {
								//                 return '将到期';
								//             } else if (d.taskStatus == '5') {
								//                 return '已延期';
								//             } else if (d.taskStatus == '6') {
								//                 return '暂停';
								//             } else if (d.taskStatus == '7') {
								//                 return '完成';
								//             } else if (d.taskStatus == '8') {
								//                 return '延期完成';
								//             } else {
								//                 return '';
								//             }
								//         }
								//     }
								// },
								{
									field: 'taskPrecess', title: '完成度', width: 100, align: 'center',templet:function (d) {
										if(d.taskPrecess==undefined){
											return ''
										}else {
											return d.taskPrecess+'%'
										}
									}
								},
								{field: 'mainCenterDeptName', title: '中心责任部门', width: 130},
								{
									field: 'dutyUserName', title: '中心责任人', width: 160, templet: function (d) {
										//判断是子项目
										if(d.bagNumber && d.pbagId){
											return  ''
										}else{
											if (d.dutyUserName) {
												return d.dutyUserName.replace(/,$/, '');
											} else {
												return ''
											}
										}
									}
								},
								{field: 'mainAreaDeptName', title: '区域责任部门', width: 130},
								{field: 'mainAreaUserName', title: '区域责任人', width: 160},
								{field: 'mainProjectDeptName', title: '总承包部责任部门', width: 150},
								{field: 'mainProjectUserName', title: '总承包部责任人', width: 200,templet:function (d) {
										//判断是子项目
										if(d.bagNumber && d.pbagId){
											return  d.dutyUserName
										}else{
											d.mainProjectUserName
										}
									}},
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
									field: 'planContinuedDate', title: '计划工期', width: 150, align: 'center', templet: function (d) {
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
									field: 'realContinuedDate', title: '实际工期', width: 150, align: 'center', templet: function (d) {
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
									field: 'controlLevel', title: '关注等级', width: 120, align: 'center', templet: function (d) {
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
                            where: {
                                projectId: projectId
                            }
                        });
                    }

                    var projectProgressTable = null;

                    treeTable.on('toolbar(projectProgressTable)', function (obj) {
                        switch (obj.event) {
                            case 'pieChart':
                                if ($('#targetreportr').is(':hidden')) {
                                    var height = $(window).height() - 538 >= 350 ? 'full-460' : '350px'
                                    projectProgressTable.reload({
                                        height: height
                                    });
                                    $('.pie_chart').find('.layui-icon').removeClass('layui-icon-down').addClass('layui-icon-up');
                                } else {
                                    projectProgressTable.reload({
                                        height: 'full-80'
                                    });
                                    $('.pie_chart').find('.layui-icon').removeClass('layui-icon-up').addClass('layui-icon-down');
                                }
                                $('#targetreportr').slideToggle(100, function () {
                                    myChart.resize();
                                });
                                break;
                        }
                    });

                    var projectIdsSelect = null
                    $.get('/plcPlan/getProJectInfoByLogin', function (res) {
                        var projectId = $.cookie("projectId")

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
                                name: 'projectId',
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
                            projectIdsSelect.setValue([projectId]);
                        }
                        initListData(projectId)
                        // 初始化饼状图
                        initPie({projectId: projectId});

                        form.render();
                    });

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
                    $('.search_form [name="planSycle"]').append(dictionaryObj['PLAN_SYCLE'].str);
                    $('.search_form [name="planStage"]').append(dictionaryObj['PLAN_PHASE'].str);

                    // 查询
                    $('#searchBtn').on("click",function () {
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name');
                            var value = $(this).val();
                            searchData[key] = value;
                        });

                        // 将查询值保存至cookie中
                        $.cookie('projectId', searchData['projectId'], {expires: 5, path: "/",});

                        // 状态
                        searchData.taskStatus = taskStatusSelect.getValue('valueStr');

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
                        
                        var height = ''

                        if ($('#container').is(':hidden')) {
	                        height = $(window).height() - 538 >= 350 ? 'full-460' : '350px'
                        } else {
                            height = 'full-120'
                        }

                        projectProgressTable.reload({
                            where: searchData,
	                        height: height,
                            page: {
                                curr: 1
                            }
                        });

                        initPie(searchData)

                    });

                    // 清空查询条件
                    $('#resetBtn').on("click",function () {
                        // 清空状态
                        taskStatusSelect.setValue([]);
                        projectIdsSelect.setValue([]);
                        tgTypeSelect.setValue([]);
                        // 所属部门
                        $('#targetBelongDept').val('');
                        $('#targetBelongDept').attr('deptid', '');
                    });

                    // 点击项目名称显示详情
                    $(document).on('click', '.project_name_link', function () {
                        myChart.showLoading();
                        var projectId = $(this).attr('projectId');
                        var pieData = initPieData(pieDataObj[projectId]);
                        myChart.hideLoading();
                        myChart.setOption({
                            tooltip: {
                                trigger: 'item',
                                formatter: '{a} <br/>{b} : {c} ({d}%)'
                            },
                            legend: {
                                orient: 'vertical',
                                left: '20%',
                                top: '13%',
                                bottom: '10',
                                data: ['未开始', '进行中', '将到期', '已延期', '完成', '延期完成', '其他']
                            },
	                        color: ['#7f7f7f', '#19ab7e', '#fad706', '#e46c0a', '#0119ff', '#4bacc6', '#ff0000'],
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

                    form.render();

                    function initPie(searchData) {
                        myChart.showLoading();
                        searchData = searchData || {}
                        $.get('/plcPlan/selectProReportChart', searchData, function (res) {
                            myChart.hideLoading();
                            if (res.object) {
                                res.object.forEach(function (item) {
                                    pieDataObj[item.projectId] = item.size;
                                });
                                var data = res.object[0];
                                var pieData = initPieData(data.size);

                                myChart.setOption({
                                    tooltip: {
                                        trigger: 'item',
                                        formatter: '{a} <br/>{b} : {c} ({d}%)'
                                    },
	                                color: ['#7f7f7f', '#19ab7e', '#fad706', '#e46c0a', '#0119ff', '#4bacc6', '#ff0000'],
                                    legend: {
                                        orient: 'vertical',
                                        left: '20%',
                                        top: '13%',
                                        bottom: '10',
                                        data: ['未开始', '进行中', '将到期', '已延期', '完成', '延期完成', '其他']
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

                            } else {
                                myChart.setOption(option);
                            }
                        });
                    }

                });
            }

			// 更多查询
			$('.more_query').on("click",function(){
				var isShow = $(this).attr('isshow');
				if (isShow == 0) {
					$(this).children().removeClass('layui-icon-down').addClass('layui-icon-up');
					$('.hide_query').show();
					$(this).attr('isshow', 1);
					$('.search_module').css('height','96px')
				} else {
					$(this).children().removeClass('layui-icon-up').addClass('layui-icon-down');
					$('.hide_query').hide();
					$(this).attr('isshow', 0);
					$('.search_module').css('height','35px')
				}
			});
			// 选择责任人
			$('#dutyUser').on('click', function(){
				user_id = 'dutyUser';
				$.popWindow('/common/selectUser');
			});
			// 选择责任部门
			$('#mainCenterDept').on('click', function(){
				dept_id = 'mainCenterDept';
				$.popWindow('/common/selectDept');
			});

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

            // 重置查询区域布局
            function resizeQuery() {
                $('.layui-tab-content').height($(window).height() - 70);
                var queryWidth = $('.search_form ').width();
                $('.query_item').width((queryWidth - 20) / 6);
            }

            // 初始化饼状图数据
            function initPieData(data) {
                var pieData = [];
                let otherObj = {name: '其他', value: 0}
                for (var i in data) {
                    switch (i) {
                        case 'i0':
                            pieData.push({name: '未开始', value: data[i]});
                            break;
                        case 'i1':
                            pieData.push({name: '进行中', value: data[i]});
                            break;
                        case 'i2':
                            pieData.push({name: '将到期', value: data[i]});
                            break;
                        // case 'i3':
                        //     pieData.push({name: '已完成', value: data[i]});
                        //     break;
                        case 'i4':
                            pieData.push({name: '已延期', value: data[i]});
                            break;
                        case 'i5':
                            pieData.push({name: '完成', value: data[i]});
                            break;
                        case 'i6':
                            pieData.push({name: '延期完成', value: data[i]});
                            break;
                        case 'i7':
                            // pieData.push({name: '暂停', value: data[i]});
                            otherObj.value += data[i];
                            break;
                        case 'i8':
                            // pieData.push({name: '关闭', value: data[i]});
                            otherObj.value += data[i];
                            break;
                        case 'i9':
                            // pieData.push({name: '成果不符', value: data[i]});
                            otherObj.value += data[i];
                            break;
                        default:
                            break;
                    }
                }
                pieData.push(otherObj);
                return pieData;
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
