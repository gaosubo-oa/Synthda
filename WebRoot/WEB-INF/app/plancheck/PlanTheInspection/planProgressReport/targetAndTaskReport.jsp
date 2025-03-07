<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/9/30
  Time: 9:18
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
		<title>职能计划报表</title>
		
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
			.ew-tree-table {
				margin: 40px 0 !important;
				position: relative;
				border: 1px solid #e6e6e6;
				border-bottom: none;
				border-right: none;
			}
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
			
			.task_panel {
				height: 100%;
				padding: 20px 30px 20px 40px;
				font-size: 16px;
				line-height: 1.3;
				box-sizing: border-box;
			}
			
			.task_panel p {
				width: 90%;
				margin: 15px auto;
			}
			
			.task_panel_con {
				padding: 20px 0;
				box-shadow: 0 0 12px 2px rgba(0, 0, 0, .1);
				border-radius: 3px;
			}
		
		</style>
	
	</head>
	<body>
		<div class="container">
			<div class="layui-tab layui-tab-brief" lay-filter="planProgressTab" style="margin: 0;">
				<ul class="layui-tab-title" style="float: left">
					<li class="layui-this">职能计划报表</li>
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
										<input type="text" id="dutyUser" readonly placeholder="请选择" style="cursor: pointer; background-color: #e7e7e7;"
											   autocomplete="off"
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
									<label class="layui-form-label">任务名称:</label>
									<div class="layui-input-block">
										<input type="text" name="tgName" placeholder="任务名称" autocomplete="off" class="layui-input">
									</div>
								</div>
		<%--							<div class="layui-form-item query_item">--%>
		<%--								<label class="layui-form-label" >类型:</label>--%>
		<%--								<div class="layui-input-block">--%>
		<%--									<select name="taskType">--%>
		<%--										<option value="">请选择</option>--%>
		<%--									</select>--%>
		<%--								</div>--%>
		<%--							</div>--%>
		<%--							<div class="layui-form-item inputs layui-col-xs2">--%>
		<%--								<label class="layui-form-label">开始时间:</label>--%>
		<%--								<div class="layui-input-block">--%>
		<%--									<input type="text" id="queryWinTime" name="queryWinTime" readonly--%>
		<%--										   placeholder="请选择开始时间" class="layui-input">--%>
		<%--								</div>--%>
		<%--							</div>--%>
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
									<label class="layui-form-label">任务来源:</label>
									<div class="layui-input-block">
										<%--<select name="taskType">
											<option value="">请选择</option>
										</select>--%>
										<div id="taskType" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">任务类型</label>
									<div class="layui-input-block">
										<%--<select name="tgType" lay-verify="required">
											<option value="">请选择</option>
										</select>--%>
										<div id="tgType" class="xm-select-demo"></div>
									</div>
								</div>
								<div class="layui-form-item query_item">
									<label class="layui-form-label">状态:</label>
									<div class="layui-input-block">
										<div id="taskStatusSelect" class="xm-select-demo"></div>
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
								<div class="layui-form-item query_item">
									<label class="layui-form-label">计划类型</label>
									<div class="layui-input-block">
										<select name="type">
											<option value="">请选择</option>
											<option value="1">关键任务</option>
											<option value="2">子任务</option>
										</select>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="content">
						<div class="layui-row">
							<div class="layui-col-xs3">
								<div class="layui-card task_card" style="height: 340px; margin: 20px 0;">
									<div class="layui-card-body task_panel">
										<div class="task_panel_con">
											<p class="task_panel_1">任务数量：<span></span></p>
											<p class="task_panel_2">关键任务数量：<span></span></p>
											<p class="task_panel_3">子任务数量：<span></span></p>
											<p class="task_panel_4">关键任务延期数量：<span></span></p>
											<p class="task_panel_5">子任务延期数量：<span></span></p>
										</div>
									</div>
								</div>
							</div>
							<div class="layui-col-xs9">
								<div id="container" style="margin: 30px auto;height: 340px;"></div>
							</div>
						</div>
						<table id="planTaskTable" lay-filter="planTaskTable"></table>
					</div>
				</div>
			</div>
		</div>

		<script type="text/html" id="deptTargetBar">
			<div class="clearfix">
				<a class="layui-btn layui-btn-sm pie_chart" style="float: right;margin-left: 10px;" lay-event="pieChart">图表<i class="layui-icon layui-icon-up"></i></a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="projectDetail">甘特图</a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="projectDetail">网络图</a>
				<a class="layui-btn layui-btn-sm" style="float: right;" lay-event="export">导出</a>
			</div>
		</script>

		<script>
			var nowDateObj = {
			    year: new Date().getFullYear(),
				month: new Date().getMonth()
			}
			// 如果为1月，则显示上一年12月
            if (nowDateObj.month == 0) {
                nowDateObj.year -= 1;
                nowDateObj.month = 12;
            }

            var paramsDeptId = $.GetRequest()['deptId'] || '';

            if (paramsDeptId) {
	            // 获取部门信息
                $.get('/department/getDeptById', {deptId: paramsDeptId}, function (res) {
                    if (res.flag && res.object) {
						$('#itemBelongDepts').val(res.object.deptName);
						$('#itemBelongDepts').attr('deptid', res.object.deptId);
                    }
                });
            } else {
				// 获取当前登录人信息
                $.get('/getLoginUser', function (res) {
                    if (res.flag && res.object) {
                        //取出cookie存储的查询值
                        if ($.cookie("itemBelongDeptsName") && $.cookie("itemBelongDeptsId")) {
                            $('#itemBelongDepts').val($.cookie("itemBelongDeptsName"))
                            $('#itemBelongDepts').attr('deptid', $.cookie("itemBelongDeptsId"))
                        } else {
                            $('#itemBelongDepts').val(res.object.deptName);
                            $('#itemBelongDepts').attr('deptid', res.object.deptId);
                        }
                    }
                });
            }

            var myChart = echarts.init(document.getElementById('container'));

            var option = {
                title: {
                    text: '左侧关键任务，右侧子任务',
                    x: "center", //标题水平方向位置
                    y: "0", //标题竖直方向位置
                    textStyle: {
                        fontSize: 18,
                        fontWeight: 'normal',
                        color: '#666'
                    }
                },
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
                    y: 'bottom',
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '20%',
                    top: '10%',
                    containLabel: true
                },
                xAxis: [{
                    min: 0,
                    axisTick: {
                        show: false
                    },
                    type: 'category', //纵向柱状图，若需要为横向，则此处值为'value'， 下面 yAxis 的type值为'category'
                    data: [],
					axisLabel: {
						//  X 坐标轴标签相关设置
						interval: 0,
						rotate: '45'
					}
                }],
                yAxis: [
                    {
                        type: 'value',
                        scale: true,
                        name: '总难度系数',
                        min: 0,
                        boundaryGap: [0.2, 0.2]
                    },
                    {
                        type: 'value',
                        scale: true,
                        name: '总子任务数',
                        min: 0,
                        boundaryGap: [0.2, 0.2]
                    }
                ],
	            color: ['#7f7f7f', '#7f7f7f', '#19ab7e', '#19ab7e', '#fad706', '#fad706', '#e46c0a', '#e46c0a', '#0119ff', '#0119ff', '#4bacc6', '#4bacc6', '#ff0000', '#ff0000', '#37a2da', '#ff9f7f'],
                series: []
            };
            myChart.setOption(option);

            resizeQuery()

            window.onresize = function () {
                myChart.resize();
                resizeQuery();
            }
			var taskTypeData=[]
			var tgTypeData=[]
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
                                if(dict=='RENWUJIHUA_TYPE'){
									taskTypeData.push({name:item.dictName,value:item.dictNo})
								}
                            });
                        }
                    }
                }
                $.get('/Dictonary/getTgType', function (res) {
                    tgTypeData = res.object;
                    init();
                });
            });

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

            function init() {
                layui.use(['form', 'treeTable', 'xmSelect', 'table'], function () {
                    var form = layui.form,
                        treeTable = layui.treeTable,
                        xmSelect = layui.xmSelect,
                        table = layui.table;

					//取出cookie存储的查询值
					$('#dutyUser').val($.cookie("dutyUserName"))
					$('#dutyUser').attr('user_id',$.cookie("dutyUserId"))
					$('input[name="tgName"]').val($.cookie("tgName"))
					$('select[name="allocationStatus"]').val($.cookie("allocationStatus"))
					$('select[name="type"]').val($.cookie("type"))


                    // 任务来源
					// $('.search_form select[name="taskType"]').append(dictionaryObj['RENWUJIHUA_TYPE'].str);
					// 关键任务类型
					// $('.search_form select[name="tgType"]').append(dictionaryObj['TG_TYPE'].str);

                    // 选择成果提交人
                    $('#dutyUser').on("click",function () {
                        user_id = 'dutyUser';
                        $.popWindow('/common/selectUser');
                    });

                    // 选择所属部门
                    $('#itemBelongDepts').on("click",function () {
                        dept_id = 'itemBelongDepts';
                        $.popWindow('/common/selectDept');
                    });

					// 任务来源
					var taskTypeSelect = xmSelect.render({
						el: '#taskType',
						toolbar: {
							show: true,
						},
						data:taskTypeData,
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
	                    name: 'tgType',
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
                    // 状态
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
					//取出cookie存储的查询值
					if($.cookie("taskType")) {
						taskTypeSelect.setValue($.cookie("taskType").split(','));
					}
					if($.cookie("tgType")) {
						tgTypeSelect.setValue($.cookie("tgType").split(','));
					}
					if($.cookie("taskStatus")) {
						taskStatusSelect.setValue($.cookie("taskStatus").split(','));
					}

                    // 查询
                    $('#searchBtn').on("click",function () {
                    	//把最后一次查询记录储存在cookie
						$.cookie('planYear',$('select[name="planYear"]').val(),{expires:5, path:"/",});
						$.cookie('planMonth',$('select[name="planMonth"]').val(),{expires:5, path:"/",});
						$.cookie('dutyUserName',$('#dutyUser').val(),{expires:5, path:"/",});
						$.cookie('dutyUserId',$('#dutyUser').attr('user_id'),{expires:5, path:"/",});
						$.cookie('itemBelongDeptsName',$('#itemBelongDepts').val(),{expires:5, path:"/",});
						$.cookie('itemBelongDeptsId',$('#itemBelongDepts').attr('deptid'),{expires:5, path:"/",});
						$.cookie('tgName',$('input[name="tgName"]').val(),{expires:5, path:"/",});
						$.cookie('taskType',taskTypeSelect.getValue('valueStr'),{expires:5, path:"/",});
						$.cookie('tgType',tgTypeSelect.getValue('valueStr'),{expires:5, path:"/",});
						$.cookie('taskStatus',taskStatusSelect.getValue('valueStr'),{expires:5, path:"/",});
						$.cookie('allocationStatus',$('select[name="allocationStatus"]').val(),{expires:5, path:"/",});
						$.cookie('type',$('select[name="type"]').val(),{expires:5, path:"/",});



                        var loadIndex = layer.load();
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name');
                            var value = $(this).val();
                            searchData[key] = value;
                        });

						// 任务名称（需传两个--tgName和taskName ---一致的值）
						searchData.taskName = $('.search_form [name="tgName"]').val();

						// 任务来源
						searchData.taskType = taskTypeSelect.getValue('valueStr');
						// 关键任务类型
	                    var tgTypeArr = tgTypeSelect.getValue();
                        var tgType = ''
                        tgTypeArr.forEach(function (item) {
                            tgType += item.dictNo + ',';
                        });
						searchData.tgType = tgType;
                        // 状态
                        searchData.taskStatus = taskStatusSelect.getValue('valueStr');/**/
                        // 责任人
                        searchData.dutyUser = ($('#dutyUser').attr('user_id') || '').replace(/,$/, '');
                        // 所属部门
                        searchData.itemBelongDepts = ($('#itemBelongDepts').attr('deptid') || '').replace(/,$/, '');
                        
                        searchData.targetBelongDepts = ($('#itemBelongDepts').attr('deptid') || '').replace(/,$/, '');

	                    loadColumnModule(searchData)

                        $.get('/plcPlan/selectDeptItemAndTarReport', searchData, function (res) {
							layer.close(loadIndex);
                            var treeData = res.plcProjectTarget.data.concat(res.plcProjectItem.data)

	                        var height = ''
                            
	                        if ($('#container').is(':hidden')) {
	                            height = 'full-120'
                            } else {
	                            height = $(window).height() - 538 >= 350 ? 'full-460' : '350px'
	                        }

                            treeTableData = treeTable.render({
                                elem: '#planTaskTable',
                                toolbar: '#deptTargetBar',
                                defaultToolbar: [''],
                                height: height,
                                tree: {
                                    iconIndex: 1,
                                    idName: 'tgId',
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
                                    {
                                        field: 'taskName', title: '子任务名称', minWidth: 400, align: 'left', templet: function (d) {
                                            if (d.planItemId) {
                                                return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="task_name_link" planItemId="' + d.planItemId + '">【子任务】' + d.taskName + '</a>';
                                            } else if (d.tgId) {
                                                return '<a style="width: 100%; color: blue; cursor: pointer; text-decoration: underline;" class="target_name_link" tgId="' + d.tgId + '">【关键任务】' + d.tgName + '</a>';
                                            }
                                        }
                                    },
									{
										field: 'taskType', title: '任务来源', width: 100, templet: function (d) {
											return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || ''
										}
									},
									{field: 'taskPrecess', title: '完成度', minWidth: 120, align: 'center',templet:function (d) {
                                            if(d.taskPrecess==undefined){
                                                return ''
                                            }else {
                                                return d.taskPrecess+'%'
                                            }
                                        }},
                                    {field: 'itemBelongDeptName', title: '所属部门', minWidth: 150, align: 'center', templet: function(d){
                                        if (d.planItemId) {
                                                return d.itemBelongDeptName || ''
                                            } else if (d.tgId) {
                                                return d.targetBelongDeptName || ''
                                            }
	                                    }},
                                    {field: 'dutyUserName', title: '责任人', minWidth: 120, align: 'center'},
									{
										field: 'planEndDate', title: '计划结束时间', minWidth: 150, align: 'center', templet: function (d) {
											var str = '';

											if (!!d.planEndDate) {
												str = formatDate(d.planEndDate);
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
										field: 'realStartDate', title: '实际开始时间', minWidth: 150, align: 'center', templet: function (d) {
											var str = '';

											if (!!d.realStartDate) {
												str = formatDate(d.realStartDate);
											}

											return str;
										}
									},
                                    {field: 'planContinuedDate', title: '计划工期', minWidth: 150, align: 'center'},
                                    {field: 'realContinuedDate', title: '实际工期', minWidth: 150, align: 'center'},
                                    {field: 'resultStandard', title: '完成标准', minWidth: 300, align: 'left'}
                                ]],
                                data: treeData
                            })
                        })
	                    
	                    $.get('/plcPlan/getProjectTaskCount', searchData, function(res) {
	                        if (res.flag) {
	                            $('.task_panel_1 span').text(res.data['任务数量'])
		                        $('.task_panel_2 span').text(res.data['关键任务数量'])
		                        $('.task_panel_3 span').text(res.data['子任务数量'])
		                        $('.task_panel_4 span').text(res.data['关键任务延期数量'])
		                        $('.task_panel_5 span').text(res.data['子任务延期数量'])
	                        }
	                    })
                    });

                    // 清空查询条件
                    $('#resetBtn').on("click",function () {
                        // 清空状态
                        taskStatusSelect.setValue([]);
						taskTypeSelect.setValue([]);
						tgTypeSelect.setValue([]);
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
					var taskType= '';
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
                        	if($.cookie("planYear")){
								$('select[name="planYear"]').val($.cookie("planYear"))
							}else{
								$('.search_form [name="planYear"]').val(nowYearNo);
							}
                            getPlanMonth(nowYearNo, function (monthStr) {
                                $('.search_form [name="planMonth"]').html(monthStr);
                                if($.cookie("planMonth")){
									$('select[name="planMonth"]').val($.cookie("planMonth"))
								}else{
									$('.search_form [name="planMonth"]').val(nowDateObj.month);
								}
                                form.render('select');
                                $('#searchBtn').trigger('click');
                            });
                        } else {
                            $('#searchBtn').trigger('click');
                        }
                        form.render('select');
                    });
					/*	// 获取任务的类型
					$.get('/Dictonary/selectDictionaryByNo?dictNo=RENWUJIHUA_TYPE', function (res) {
						var nowTaskType = '';
						if (res.data.length > 0) {
							res.data.forEach(function (item) {
								taskType+= '<option value="' + item.dictNo + '">' + item.dictName + '</option>';
								if (!nowTaskType) {
									nowTaskType = item.dictName;
								}
							});
						}
						$('.search_form [name="taskType"]').append(taskType);
						if (nowTaskType) {
							$('.search_form [name="taskType"]').val(nowTaskType);
							$('#searchBtn').trigger('click');
							form.render('select');
						} else {
							$('#searchBtn').trigger('click');
						}
						// laydate.render({
						// 	elem: '#queryWinTime' //指定元素
						// });
						form.render('select');
					});*/

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

                    form.render()
					
                    var treeTableData = null

                    treeTable.on('toolbar(planTaskTable)', function (obj) {
                        switch (obj.event) {
                            case 'pieChart':
                                if ($('#container').is(':hidden')) {
                                    var height = $(window).height() - 538 >= 350 ? 'full-460' : '350px';
                                    treeTableData.reload({
                                        height: height
                                    });
                                    $('.pie_chart').find('.layui-icon').removeClass('layui-icon-down').addClass('layui-icon-up');
                                } else {
                                    treeTableData.reload({
                                        height: 'full-120'
                                    });
                                    $('.pie_chart').find('.layui-icon').removeClass('layui-icon-up').addClass('layui-icon-down');
                                }
                                $('#container').slideToggle(100, function () {
                                    myChart.resize();
                                });
	                            $('.task_card').slideToggle(100)
                                break;
	                        case 'export':
                                var exportData = getExportData(treeTableData.options.data);
                                // 使用post导出
                                $.dynamicSubmit('/PlcAssessScore/outItem', {
                                    "data": JSON.stringify(exportData)
                                });
                                break;
                        }
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

                })
            }

            function initColumnData(targetData, taskData) {
                var baseLegend = ['未开始', '进行中', '将到期', '已延期', '完成', '延期完成', '其他'];
                var legendData = [];

                // 折线数据
                var lineObj = {
                    targetLine: [],
                    taskLine: []
                }

                // xType存放的是横坐标
                var xType = [];
                // 创建一个数组，用来装对象传给series.data，因为series.data里面不能直接写for循环
                var seriesData = [];

                var data_0 = [], data_1 = [], data_2 = [], data_4 = [], data_5 = [], data_6 = [], data_9 = [];
                var tdata_0 = [], tdata_1 = [], tdata_2 = [], tdata_4 = [], tdata_5 = [], tdata_6 = [], tdata_9 = [];

                //遍历baseLegend，将legend 的data做出来，就是legendData
                for (var i = 0; i < baseLegend.length; i++) {
                    legendData.push(baseLegend[i] + "关键任务");
                    legendData.push(baseLegend[i] + "子任务");
                }

                // 将x轴的用户名放到xType中，添加难度系数数据
                for (var i = 0; i < targetData.length; i++) {
                    xType.push(targetData[i].userName);
                    lineObj.targetLine.push(targetData[i].hardDegree)
                    lineObj.taskLine.push(taskData[i].hardDegree)
                    var otherCount = 0;
                    for (var key in targetData[i].map) {
                        if (key == '0') {
                            // title = '未开始'
                            data_0.push(targetData[i].map[key]);
                        } else if (key == '1') {
                            // title = '进行中'
                            data_1.push(targetData[i].map[key]);
                        } else if (key == '2') {
                            // title = '将到期'
                            data_2.push(targetData[i].map[key]);
                        } else if (key == '4') {
                            // title = '已延期'
                            data_4.push(targetData[i].map[key]);
                        } else if (key == '5') {
                            // title = '完成'
                            data_5.push(targetData[i].map[key]);
                        } else if (key == '6') {
                            // title = '延期完成'
                            data_6.push(targetData[i].map[key]);
                        } else if (key == '7') {
                            // title = '暂停'
                            otherCount += targetData[i].map[key];
                        } else if (key == '8') {
                            // title = '关闭'
                            otherCount += targetData[i].map[key];
                        } else if (key == '9') {
                            // title = '成果不符'
                            otherCount += targetData[i].map[key];
                        }
                    }
                    data_9.push(otherCount);
                    var otherCount2 = 0;
                    for (var key in taskData[i].map) {
                        if (key == '0') {
                            // title = '未开始'
                            tdata_0.push(taskData[i].map[key]);
                        } else if (key == '1') {
                            // title = '进行中'
                            tdata_1.push(taskData[i].map[key]);
                        } else if (key == '2') {
                            // title = '将到期'
                            tdata_2.push(taskData[i].map[key]);
                        } else if (key == '4') {
                            // title = '已延期'
                            tdata_4.push(taskData[i].map[key]);
                        } else if (key == '5') {
                            // title = '完成'
                            tdata_5.push(taskData[i].map[key]);
                        } else if (key == '6') {
                            // title = '延期完成'
                            tdata_6.push(taskData[i].map[key]);
                        } else if (key == '7') {
                            // title = '暂停'
                            otherCount2 += taskData[i].map[key];
                        } else if (key == '8') {
                            // title = '关闭'
                            otherCount2 += taskData[i].map[key];
                        } else if (key == '9') {
                            // title = '成果不符'
                            otherCount2 += taskData[i].map[key];
                        }
                    }
                    tdata_9.push(otherCount);
                }
                var dataArray = [];
                dataArray.push(data_0, tdata_0, data_1, tdata_1, data_2, tdata_2, data_4, tdata_4, data_5, tdata_5, data_6, tdata_6, data_9, tdata_9);

                //  初始化seriesData这个service所用的data数组
                /* 
                    name是名字，data是数据
                    stack标明两个柱子分别对应的字段,比如收入和支出，这个自己定义
                 */
                for (var i = 0; i < legendData.length; i++) {
                    var obj = {
                        barWidth: '20px',
                        name: legendData[i],
                        data: dataArray[i],
                        type: 'bar',
                        yAxisIndex: 1,
                        stack: 'key_' + (i % 2),
                    }
                    
                    if (i >= legendData.length - 2 && i < legendData.length) {
                        obj.label = {
                            normal: {
                                show: true,
                                position: 'top',
                                textStyle: {color: '#000'}
                            }
                        }
	                    switch (i) {
		                    case 12:
		                        obj.label.normal.formatter = function (params) {
                                    var str = 0
                                    var j = 0;
                                    while (j < 13) {
                                        str += parseInt(dataArray[j][params.dataIndex]);
                                        j += 2;
                                    }
                                    return str
                                }
		                        break;
		                    case 13:
		                        obj.label.normal.formatter = function (params) {
                                    var str = 0
                                    var j = 1;
                                    while (j < 14) {
                                        str += parseInt(dataArray[j][params.dataIndex]);
                                        j += 2;
                                    }
                                    return str
                                }
		                        break;
                        }
	                }
                    seriesData[i] = obj;
                }
                legendData.push('关键任务难度系数', '子任务难度系数');

                for (var key in lineObj) {
                    var name = (key == 'targetLine' ? '关键任务难度系数' : '子任务难度系数');
                    var obj = {
                        name: name,
                        type: 'line',
                        stack: key,
                        data: lineObj[key]
                    }
                    seriesData.push(obj);
                }

                return {
                    xType: xType,
                    seriesData: seriesData,
                    legendData: legendData
                }
            }

            function loadColumnModule(searchData) {
                myChart.showLoading();
                searchData = searchData || {}

                // 获取数据
                $.get('/plcPlan/getTaskStatusCount', searchData, function (res) {
                    myChart.hideLoading();
                    if (res.flag && res.obj.length > 0 && res.obj1.length > 0) {
                        var columnData = initColumnData(res.obj, res.obj1);

                        myChart.setOption({ //加载数据图表
                            xAxis: [{
                                min: 0,
                                axisTick: {
                                    show: true,
                                    alignWithLabel: true,
                                },
                                // boundaryGap: false,
                                type: 'category', //纵向柱状图，若需要为横向，则此处值为'value'， 下面 yAxis 的type值为'category'
                                data: columnData.xType,
                                axisLabel: {
                                    interval: 0
                                }
                            }],
                            series: columnData.seriesData,
                            legend: {
                                left: 50,
                                data: columnData.legendData,
                                y: 'bottom',
                                width: '90%'
                            }
                        });
                    } else {
                        myChart.setOption(option,true);
                    }
                })
            }

            // 重置查询区域布局
            function resizeQuery() {
                $('.layui-tab-content').height($(window).height() - 70);
                var queryWidth = $('.search_form ').width();
                $('.query_item').width((queryWidth - 20) / 6);
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

			// 获取导出数据
			function getExportData(data){
			    var arr = [];
			    if (!!data && data.length > 0) {
                    data.forEach(function (item) {
	                    arr.push(item);

                        if (item.children && item.children.length > 0) {
                            arr = arr.concat(getExportData(item.children));
                        }
                    });
			    }
				return arr;
			}

            // 导出
            $.dynamicSubmit = function (url, datas, fn) {
                var form = $('#dynamicForm');
                if (form.length <= 0) {
                    form = $("<form>");
                    form.attr('id', 'dynamicForm');
                    form.attr('style', 'display:none');
                    form.attr('target', '');
                    form.attr('method', 'post');
                    $('body').append(form);
                }
                form = $('#dynamicForm');
                form.attr('action', url);
                form.empty();
                if (datas && typeof (datas) == 'object') {
                    for (var item in datas) {
                        var $_input = $('<input>');
                        $_input.attr('type', 'hidden');
                        $_input.attr('name', item);
                        $_input.val(datas[item]);
                        $_input.appendTo(form);
                    }
                }
                form.submit();
                if (fn) {
                    fn();
                }
            };
		
		</script>
	</body>
</html>
