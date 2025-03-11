<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/10/12
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>运营效能</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
		
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/drag/dragSort.js?20200824"></script>
		<script type="text/javascript" src="/js/jquery/jquery.cookie.js"></script>
		<script type="text/javascript" src="/js/planCheck/echarts.min.js"></script>
		
		<style>
			html, body {
				width: 100%;
				min-width: 1000px;
				height: 100%;
				color: #666;
				background-color: #fff;
				font-family: "Microsoft Yahei" !important;
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
				width: 100%;
				height: 100%;
				padding: 5px;
				background-color: #f6f7f7;
				overflow-x: hidden;
				overflow-y: auto;
			}
			
			#setOrder {
				position: absolute;
				top: 5px;
				right: 20px;
				cursor: pointer;
			}
			
			.card_label {
				float: left;
				clear: none;
			}
			
			.order_label {
				width: 200px;
			}
			
			/* 卡片样式 START */
			.card_box {
				height: 400px;
				margin: 5px 0;
			}
			
			.card_item {
				position: relative;
				/*width: 100%;*/
				height: 100%;
				margin: 0 5px;
				background-color: #fff;
				box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
				border-top: 3px solid #2b7fe0;
			}
			
			.card_head {
				position: relative;
				height: 31px;
				line-height: 20px;
				padding: 5px 10px;
				background-color: #e8f4fc;
				border-bottom: 1px solid #f0f0f0;
				box-sizing: border-box;
				cursor: move;
			}
			
			.card_head_l {
				float: left;
				height: 22px;
				line-height: 22px;
			}
			
			.card_head_select {
				width: 120px;
				height: 20px;
				margin: 1px 5px;
				font-size: 7.5pt;
				cursor: pointer;
			}
			
			.card_head_r {
				float: right;
			}
			
			.r_item {
				position: relative;
				float: left;
				width: 55px;
				padding: 0 5px;
				box-sizing: border-box;
			}
			
			.r_item_img {
				display: none;
				position: absolute;
				top: -5px;
				right: -3px;
				width: 12px;
				height: 12px;
				line-height: 12px;
				padding: 2px;
				background-color: red;
				border-radius: 50%;
				color: #fff;
				text-align: center;
				font-size: 9pt;
			}
			
			.read_all {
				cursor: pointer;
			}
			
			.r_item_t, .r_item_more {
				display: block;
				text-align: center;
				cursor: pointer;
				font-size: 13px;
			}
			
			.more_t {
				display: none;
			}
			
			.r_item_select .r_item_t {
				border-radius: 5px;
				background: #fff;
			}
			
			.card_title {
				font-size: 14px;
				color: #000;
				font-weight: 600;
				cursor: move;
				user-select: none;
			}
			
			.card_content {
				display: none;
				height: 355px;
				margin: 5px 0;
				padding: 0 20px 0 5px;
				overflow: auto;
				box-sizing: border-box;
			}
			
			.outer_link {
				display: block;
				padding: 5px;
				overflow: hidden;
			}
			
			.noData {
				display: none;
				text-align: center;
				border: none;
				padding-top: 80px;
			}
			
			.noData img {
				width: 10%;
			}
			
			/* 卡片样式 END */
			
			/* 列表样式 START */
			.li_item {
				position: relative;
				height: 20px;
				line-height: 20px;
				margin: 5px;
				padding-left: 20px;
				font-size: 9pt;
				cursor: pointer;
			}
			
			.li_item:hover {
				background-color: #e8f4fc;
			}
			
			.circle {
				position: absolute;
				top: 8px;
				left: 8px;
				width: 4px;
				height: 4px;
				border-radius: 50%;
				background: #666666;
			}
			
			.li_title {
				position: absolute;
				top: 0;
				right: 100px;
				bottom: 0;
				left: 20px;
				overflow: hidden;
				word-break: break-all;
				white-space: nowrap;
				text-overflow: ellipsis;
			}
			
			.hide {
				left: 40px;
			}
			
			.li_date {
				float: right;
			}
			
			.scroll_cover {
				position: absolute;
				right: 0;
				bottom: 0;
				width: 25px;
				height: 369px;
				background-color: #fff;
			}
			
			/* 列表样式 END */
			
			.layui-input-block {
				margin-left: 200px;
			}
		
		</style>
	
	</head>
	<body>
		<div class="container layui-container">
			<div class="layui-row hide_content" style="display: none;">
				<div class="layui-col-xs6 card_box" ordernum="08" type="1" id="chartReport_08">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title"></span>
								<select class="card_head_select choose_task" style="width: 80px;" value="1">
									<option value="1">个人</option>
									<option value="2">部门</option>
								</select>
								<select class="card_head_select task_dept" style="display: none; width: 80px;" value="1">
								
								</select>
							</div>
							<div class="card_head_r">
								<ul class="clearfix">
									<li class="r_item r_item_select" itemType="0" style="width: 70px;">
										<span class="r_item_t task">关键任务</span>
									</li>
									<li class="r_item" itemType="1" style="width: 70px;">
										<span class="r_item_t task">职能任务</span>
									</li>
									<li class="r_item" itemType="2">
										<span class="r_item_t task">子任务</span>
									</li>
								</ul>
							</div>
						</div>
						<div class="card_content outer_link">
							<div id="chartOne" style="height: 100%;"></div>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="01" type="2" id="dataReport_01">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title"></span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src=""
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="02" type="2" id="dataReport_02">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title"></span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src=""
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="03" type="2" id="dataReport_03">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title"></span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src=""
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="04" type="2" id="dataReport_04">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title"></span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src=""
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="05" type="2" id="dataReport_05">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title"></span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src=""
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="06" type="2" id="dataReport_06">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title"></span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src=""
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
				<div class="layui-col-xs6 card_box" ordernum="07" type="2" id="dataReport_07">
					<div class="card_item">
						<div class="card_head">
							<div class="card_head_l">
								<span class="card_title"></span>
							</div>
						</div>
						<div class="card_content outer_link">
							<iframe src=""
							        frameborder="0" style="width: 100%;height: 100%"></iframe>
						</div>
						<div class="scroll_cover"></div>
					</div>
				</div>
			</div>
			<div class="layui-row content main" id="sortContent" style="display: none;">
				<button id="setOrder" class="layui-btn layui-btn-xs layui-btn-normal" style="display: none;">设置</button>
			</div>
		</div>
		
		<script type="text/javascript">

			var myChart = null;
			
            var dataReportObj = {
                chartReport_08: {
                    title: '任务类型图'
                },
                dataReport_01: {
                    title: '流程办理时效-总部各中心',
                    url: 'http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow%252Fsingle%252F%25E6%2580%25BB%25E9%2583%25A8%25E6%25B5%2581%25E7%25A8%258B%25E6%2597%25B6%25E6%2595%2588%25E6%259F%25B1%25E7%258A%25B6%25E5%259B%25BE.cpt&op=write'
                },
                dataReport_02: {
                    title: '计划任务数量-总部各中心',
                    url: 'http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow%252Fsingle%252F%25E6%2580%25BB%25E9%2583%25A8%25E8%25AE%25A1%25E5%2588%2592%25E4%25BB%25BB%25E5%258A%25A1%25E6%2595%25B0%25E9%2587%258F%25E6%2583%2585%25E5%2586%25B5.cpt&op=write'
                },
                dataReport_03: {
                    title: '流程应用频率排行TOP10',
                    url: 'http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow%252Fsingle%252F%25E6%25B5%2581%25E7%25A8%258B%25E5%25BA%2594%25E7%2594%25A8%25E9%25A2%2591%25E7%258E%2587.cpt&op=write'
                },
                dataReport_04: {
                    title: '流程被回退次数周排行TOP10',
                    url: 'http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow%252Fsingle%252F%25E6%25B5%2581%25E7%25A8%258B%25E8%25A2%25AB%25E9%2580%2580%25E5%259B%259E%25E5%2591%25A8%25E6%258E%2592%25E8%25A1%258C.cpt&op=write'
                },
                dataReport_05: {
                    title: '流程办理时效-直属单位',
                    url: 'http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow%252Fsingle%252F%25E7%259B%25B4%25E5%25B1%259E%25E5%258D%2595%25E4%25BD%258D%25E6%25B5%2581%25E7%25A8%258B%25E6%2597%25B6%25E6%2595%2588%25E6%259F%25B1%25E7%258A%25B6%25E5%259B%25BE.cpt&op=write'
                },
                dataReport_06: {
                    title: '超过7天未办结流程TOP10',
                    url: 'http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow%252Fsingle%252F%25E8%25B6%2585%25E4%25B8%2583%25E5%25A4%25A9%25E6%25B5%2581%25E7%25A8%258B%25E5%258D%2595%25E7%258B%25AC%25E6%258A%25A5%25E8%25A1%25A8.cpt&op=write'
                },
                dataReport_07: {
                    title: '超过3天未办结节点流程TOP10',
                    url: 'http://10.191.15.57:8075/webroot/decision/view/report?viewlet=flow%252Fsingle%252F%25E8%25B6%2585%25E4%25B8%2589%25E5%25A4%25A9%25E6%259C%25AA%25E5%258A%259E%25E7%2590%2586.cpt&op=write'
                }
            }

            var moduleType = 2;

            // 个人门户设置方法
            function setOrder() {
                $('#setOrder').trigger('click');
            }

            // 获取可显示模块及模块显示顺序
            $.get('/userPrivateSet/operationalEfficiency', function (res) {
                var cardOrderArr = ['01', '02', '03', '04', '05', '06'];
                try {
                    if (res.flag && res.object) {
                        var cardOrderObj = JSON.parse(res.object);
                        cardOrderArr = cardOrderObj.cardOrder;
                        moduleType = parseInt(cardOrderObj.moduleType);
                    }
                } catch (e) {
                    console.log(e);
                }
                resizeSize();
                loadCardModule(cardOrderArr);
            });

            /**
             * 加载模块方法
             */
            function loadCardModule(cardOrderArr) {
                var $cardEle = $('.hide_content .card_box');
                if (cardOrderArr && cardOrderArr.length > 0) {
                    cardOrderArr.forEach(function (item) {
                        var $cardEle = $('.card_box[ordernum="' + item + '"]');
                        var $ele = $cardEle.clone();
                        var id = $ele.attr('id');
                        $ele.find('.card_title').text(dataReportObj[id].title);
                        if ($ele.attr('type') == 2) {
                            $ele.find('iframe').attr('src', dataReportObj[id].url);
                        }
                        $('.content').append($ele);
                    });
                } else {
                    $cardEle.each(function () {
                        var $ele = $(this).clone();
                        var id = $ele.attr('id');
                        $ele.find('.card_title').text(dataReportObj[id].title);
                        if ($ele.attr('type') == 2) {
                            $ele.find('iframe').attr('src', dataReportObj[id].url);
                        }
                        $('.content').append($ele);
                    });
                }
                $('.content').show(0, function () {
                    $('.hide_content').remove();
                    var chartEle = document.getElementById('chartOne');
                    if (chartEle) {
                        myChart = echarts.init(chartEle);
                    }
                    initSelect();
                    initEvent();
                    initTaskPieChartModule(0);
                });
            }

            // 初始化事件
            function initEvent() {
                // 点击设置
                $('#setOrder').on('click', function () {
                    var height = $(window).height();
                    var layerHeight = height <= 420 ? '100%' : '420px';

                    layui.use(['form'], function () {
                        var form = layui.form;
                        layer.open({
                            type: 1,
                            title: '运营效能门户设置',
                            btn: ['保存', '取消'],
                            btnAlign: 'c',
                            area: ['600px', layerHeight],
                            content: ['<div style="overflow:hidden;"><form class="layui-form layui-row card_form" style="padding: 20px 20px;overflow: hidden;">',
                                '<div style="clear: both;">' +
                                '<div class="layui-form-item layui-col-xs6" style="clear: none;">' +
                                '<label class="layui-form-label order_label">四模块</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="radio" value="2" name="moduleType" lay-skin="primary">' +
                                '</div>' +
                                '</div>',
                                '<div class="layui-form-item layui-col-xs6" style="clear: none;">' +
                                '<label class="layui-form-label order_label">六模块</label>' +
                                '<div class="layui-input-block">' +
                                '<input type="radio" value="3" name="moduleType" lay-skin="primary">' +
                                '</div>' +
                                '</div></div>',
                                '</form></div>'].join(''),
                            success: function () {
                                $.get('/userPrivateSet/operationalEfficiency', function (res) {
                                    var cardOrderArr = cardOrderArr = ['01', '02', '03', '04', '05', '06'];
                                    var moduleType = 3;
                                    var data;
                                    try {
                                        if (res.flag && res.object) {
                                            var cardOrderObj = JSON.parse(res.object);
                                            cardOrderArr = cardOrderObj.cardOrder;
                                            data = res.data;
                                            moduleType = parseInt(cardOrderObj.moduleType);
                                        }
                                    } catch (e) {
                                        console.log(e);
                                    }
                                    var str = ''
                                    for (var key in dataReportObj) {
                                        var num = key.substring(key.length - 2);

                                        str += '<div class="layui-form-item layui-col-xs6 card_label" id="' + num + '">' +
                                            '<label class="layui-form-label order_label">' + dataReportObj[key].title + '</label>' +
                                            '<div class="layui-input-block">' +
                                            '<input type="checkbox" value="' + num + '" name="setOrder" lay-skin="primary">' +
                                            '</div></div>';
                                    }

                                    $('.card_form').prepend(str);

                                    cardOrderArr.forEach(function (item) {
                                        $('input[value="' + item + '"]').prop('checked', 'true')
                                        form.render()
                                    })
                                    data.forEach(function (item) {
                                        $('input[value="' + item + '"]').prop('disabled', 'disabled')
                                        form.render()
                                    })
                                    if (moduleType == 3) {
                                        $('input[name="moduleType"]').eq(1).prop('checked', true);
                                    } else {
                                        $('input[name="moduleType"]').eq(0).prop('checked', true);
                                    }

                                    form.render();
                                    // 拖拽
                                    $('.card_label').arrangeable();
                                });
                            },
                            yes: function () {
                                var cardOrderArr = []
                                $('input[name="setOrder"]:checked').each(function () {
                                    var key = $(this).val();
                                    cardOrderArr.push(key);
                                });

                                var moduleType = $('input[name="moduleType"]:checked').val();

                                var cardOrderObj = {"cardOrder": cardOrderArr, "moduleType": moduleType}

                                $.post('/userPrivateSet/operationalEfficiency', {code: JSON.stringify(cardOrderObj)}, function (res) {
                                    if (res.flag) {
                                        window.location.reload();
                                    } else {
                                        layer.msg('保存失败！', {icon: 2, time: 2000});
                                    }
                                });
                            }
                        });
                    });
                });

                // 卡片头部右侧点击
                $('.r_item_t').on('click', function () {
                    var $p = $(this).parent();
                    $p.siblings().removeClass('r_item_select');
                    $p.addClass('r_item_select');
                });

                // 拖拽
                $('.card_box').arrangeable({
                    dragSelector: '.card_head',
                    afterDragEnd: function (e) { // 拖拽结束调用
                        var cardOrderArr = []
                        $('.content .card_box').each(function () {
                            var key = $(this).attr('ordernum');
                            cardOrderArr.push(key);
                        });

                        var cardOrderObj = {"cardOrder": cardOrderArr, "moduleType": moduleType}
                        $.post('/userPrivateSet/operationalEfficiency', {code: JSON.stringify(cardOrderObj)}, function (res) {

                        });
                    }
                });

                // 切换任务（跟人或部门）
                $('.choose_task').on('change', function () {
                    var typeId = $(this).val();
                    var deptId = '';
                    if (typeId == 1) {
                        $('.task_dept').hide();
                    } else {
                        $('.task_dept').show();
                        deptId = $('.task_dept').val();
                    }
                    var taskType = $('#chartReport_08').find('.r_item_select').attr('itemtype');
                    initTaskPieChartModule(taskType, deptId);
                });
                
                // 切换部门
	            $('.task_dept').on('change', function(){
	                var deptId = $(this).val();
		            var taskType = $('#chartReport_08').find('.r_item_select').attr('itemtype');
	                initTaskPieChartModule(taskType, deptId);
	            });

                // 点击关键任务
                $('.task').click(function () {
                    var typeId = $('.choose_task').val();
                    var deptId = '';
                    if (typeId == 2) {
                        deptId = $('.task_dept').val();
                    }

                    var taskType = $(this).parent().attr('itemType');
                    initTaskPieChartModule(taskType, deptId);
                });
            }

            // 加载头部下拉框数据
            function initSelect() {
                // 任务部门下拉框
                $.get('/plcOrg/getDeptsByUserId', function (res) {

                    var str = '';
                    var data = res.data;
                    if (data && data.length > 0) {
                        for (var i = 0; i < data.length; i++) {
                            str += '<option value="' + data[i].deptId + '">' + data[i].contractorName + '</option>'
                        }
                    }

                    $('.task_dept').html(str);
                });
            }

            /**
             * 加载任务饼图
             * @param taskType (任务类型,0-关键任务，1-职能任务，2-子任务)
             * @param deptId (部门Id)
             */
            function initTaskPieChartModule(taskType, deptId) {
                myChart.showLoading();
                if (taskType == 2) {
                    $.get('/StatisticalReport/getAllItemCountByUserId', {deptId: deptId || ''}, function (res) {
                        myChart.hideLoading();
                        if (res.flag) {
                            var pieData = initPieData(res.data);
                            myChart.setOption({
                                tooltip: {
                                    trigger: 'item',
                                    formatter: '{a} <br/>{b}: {c} ({d}%)'
                                },
                                legend: {
                                    orient: 'vertical',
                                    left: 10,
                                    data: pieData.legendData
                                },
	                            color: ['#7f7f7f', '#19ab7e', '#0119ff', '#19ab7e', '#fad706', '#e46c0a', '#4bacc6', '#2f4554'],
                                series: [
                                    {
                                        name: '任务状态',
                                        type: 'pie',
                                        selectedMode: 'single',
                                        radius: [0, '55%'],
                                        labelLine: {
                                            show: true
                                        },
                                        label: {
                                            formatter: '{b|{b}：}{c}',
                                            color: '#000',
	                                        fontSize: 12,
                                            rich: {
                                                b: {
                                                    color: '#000',
                                                    fontSize: 12,
                                                    lineHeight: 20
                                                }
                                            }
                                        },
                                        data: pieData.seriesData.innerData
                                    },
                                    {
                                        name: '任务状态',
                                        type: 'pie',
                                        radius: ['70%', '90%'],
                                        label: {
                                            formatter: '{b|{b}：}{c}',
                                            backgroundColor: '#eee',
                                            borderColor: '#aaa',
                                            borderWidth: 1,
                                            borderRadius: 4,
	                                        padding: [0, 5],
	                                        color: '#000',
	                                        fontSize: 12,
                                            rich: {
                                                b: {
                                                    color: '#000',
                                                    fontSize: 12,
                                                    lineHeight: 20
                                                }
                                            }
                                        },
                                        data: pieData.seriesData.outerData
                                    }
                                ]
                            }, true);
                        }
                    });
                } else {
                    $.get('/StatisticalReport/getTarNumByUser', {taskType: taskType, deptId: deptId || ''}, function (res) {
                        myChart.hideLoading();
                        if (res.flag) {
                            var pieData = initPieData(res.data);
                            myChart.setOption({
                                tooltip: {
                                    trigger: 'item',
                                    formatter: '{a} <br/>{b}: {c} ({d}%)'
                                },
                                legend: {
                                    orient: 'vertical',
                                    left: 10,
                                    data: pieData.legendData
                                },
	                            color: ['#7f7f7f', '#19ab7e', '#0119ff', '#19ab7e', '#fad706', '#e46c0a', '#4bacc6', '#2f4554'],
                                series: [
                                    {
                                        name: '任务状态',
                                        type: 'pie',
                                        selectedMode: 'single',
                                        radius: [0, '55%'],
                                        labelLine: {
                                            show: true
                                        },
                                        label: {
                                            formatter: '{b|{b}：}{c}',
	                                        color: '#000',
	                                        fontSize: 12,
                                            rich: {
                                                b: {
                                                    color: '#000',
                                                    fontSize: 12,
                                                    lineHeight: 20
                                                }
                                            }
                                        },
                                        data: pieData.seriesData.innerData
                                    },
                                    {
                                        name: '任务状态',
                                        type: 'pie',
                                        radius: ['70%', '90%'],
                                        label: {
                                            formatter: '{b|{b}：}{c}',
                                            backgroundColor: '#eee',
                                            borderColor: '#aaa',
                                            borderWidth: 1,
                                            borderRadius: 4,
	                                        padding: [0, 5],
	                                        color: '#000',
	                                        fontSize: 12,
                                            rich: {
                                                b: {
                                                    color: '#000',
                                                    fontSize: 12,
                                                    lineHeight: 20
                                                }
                                            }
                                        },
                                        data: pieData.seriesData.outerData
                                    }
                                ]
                            }, true);
                        }
                    });
                }
            }

            window.onresize = resizeSize;

            function resizeSize() {
                var windowHeight = $(window).height();
                var cardHeight = (windowHeight - 10 - (moduleType * 10)) / moduleType;
                $('.card_box').height(cardHeight);
                $('.scroll_cover').height(cardHeight - 31);
                $('.card_content').height(cardHeight - 45);
                $('.noData').css('padding-top', (cardHeight - 45) / 4);
                if (myChart) {
                    myChart.resize();
                }
            }

            /**
             * 处理饼图数据
             * @param data
             * @returns {{seriesData: [], legendData: []}}
             */
            function initPieData(data) {
	            var legendData = ['未开始', '进行中', '已完成', '未开始', '未分配', '正常进行中', '已延期', '已评分', '未评分'];
                var seriesData = {
                    innerData: [],
	                outerData: []
                }
	            
                legendData.forEach(function(item, index) {
                    var key = item
                    if (index < 3) {
                        seriesData.innerData.push({value: data[key], name: item})
                    } else {
                        seriesData.outerData.push({value: data[key], name: item})
                    }
                })
	            
                return {
                    legendData: legendData,
                    seriesData: seriesData
                }
            }
		
		</script>
	
	</body>
</html>
