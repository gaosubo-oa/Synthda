<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/7
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.*" %>
<%
	Long datetime = new Date().getTime(); // 获取系统时间
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="renderer" content="webkit">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>中电建生态公司运营驾驶舱</title>
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
		<link rel="stylesheet" href="/css/planCheck/operationsCockpit_ZDJ/reset.css">
		<link rel="stylesheet" href="/css/planCheck/operationsCockpit_ZDJ/index.css?<%=datetime%>">
		<link rel="stylesheet" href="/js/planCheck/operationsCockpit_ZDJ/scroll/css/liMarquee.css">
		
		<script src="/js/xoajq/xoajq1.js"></script>
		<script src="/js/planCheck/operationsCockpit_ZDJ/echarts.min.js"></script>
		<script type="text/javascript" src="/js/base/base.js?<%=datetime%>"></script>
	</head>
	<body>
		<div class="wrapper">
			<div class="button_group group_left">
				<button>运维管理</button>
			</div>
			
			<div class="button_group group_right">
				<button class="active" btn_type="1">计划任务</button>
				<button btn_type="2">业务流程</button>
				<button btn_type="3">绩效考核</button>
			</div>
			<div id="wrapOne" class="container">
				<div class="header">
					<h2 class="header_title">中电建生态公司运营驾驶舱</h2>
				</div>
				<div class="content">
					<div class="column">
						<div class="panel">
							<h4 class="panel_title">计划完成率分析</h4>
							<div class="chart" id="chart_1"></div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_1">
							<h4 class="panel_title">项目滞后分析</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item">
												<div class="item_con">项目名称</div>
											</div>
											<div class="li_item">
												<div class="item_con" style="text-align: center;">进行中</div>
											</div>
											<div class="li_item">
												<div class="item_con" style="text-align: center;">延期数量</div>
											</div>
											<div class="li_item">
												<div class="item_con" style="text-align: center;">延期天数</div>
											</div>
											<div class="li_item">
												<div class="item_con" style="text-align: center;">滞后率</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_2">
							<h4 class="panel_title">严重滞后项目排名</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 25%;">
												<div class="item_con">项目名称</div>
											</div>
											<div class="li_item" style="width: 25%;">
												<div class="item_con">所属单位</div>
											</div>
											<div class="li_item" style="width: 25%;">
												<div class="item_con" style="text-align: center;">延期数量</div>
											</div>
											<div class="li_item" style="width: 25%;">
												<div class="item_con" style="text-align: center;">延期天数</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
					</div>
					<div class="column">
						<div class="map_content">
							<div class="btn_group"></div>
							<div class="dashboard">
								<div class="dashboard_item">
									<div class="chart" id="chart_2"></div>
								</div>
								<div class="dashboard_item">
									<div class="chart" id="chart_3"></div>
								</div>
								<div class="dashboard_item">
									<div class="chart" id="chart_4"></div>
								</div>
							</div>
							<div class="map" style="background-color: #0F1C3C;">
								<div class="chart" id="map_1" style="visibility: hidden"></div>
								<div class="map_table" style="visibility: hidden">
									<p>在建项目 <span class="map_total"></span> 个</p>
									<p>正常进行 <span class="map_normal_count"></span> 个</p>
									<p>滞后项目 <span class="map_delay_count"></span> 个</p>
								</div>
							</div>
						</div>
					</div>
					<div class="column">
						<div class="panel">
							<h4 class="panel_title">关键任务发展分析</h4>
							<div class="chart" id="chart_5"></div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel">
							<h4 class="panel_title">关键任务滞后类型分析</h4>
							<div class="set_btn"></div>
							<div class="chart" id="chart_6"></div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_3">
							<h4 class="panel_title">严重滞后关键任务排名</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item">
												<div class="item_con">所属部门</div>
											</div>
											<div class="li_item">
												<div class="item_con">任务名称</div>
											</div>
											<div class="li_item">
												<div class="item_con">任务类型</div>
											</div>
											<div class="li_item">
												<div class="item_con">负责人</div>
											</div>
											<div class="li_item">
												<div class="item_con" style="text-align: center;">延期天数</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
					</div>
				</div>
			</div>
			<div id="wrapTwo" class="container">
				<div class="header">
					<h2 class="header_title">中电建生态公司运营驾驶舱</h2>
				</div>
				<div class="content">
					<div class="column">
						<div class="panel">
							<h4 class="panel_title">流程办理时效<br/>-<br/>直属单位</h4>
							<div class="chart" id="chart_7"></div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_4">
							<h4 class="panel_title">流程被回退次数</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 50%;text-align: center;">
												<div class="item_con">所属部门</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">人员姓名</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">被退回次数</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_5">
							<h4 class="panel_title">超过7天未办结流程</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">流程名称</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">所属部门</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">当前办理人</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">已用时(天)</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
					</div>
					<div class="column">
						<div class="map_content">
							<div class="dashboard" style="padding: 5px 0;">
								<div class="dashboard_item" style="width: 50%;max-width: 50%;min-width: 50%;padding-right: 10px;">
									<div class="box_wrap">
										<div class="box_con">
											<h4>本月办结流程数</h4>
											<p class="flow_count">0</p>
										</div>
										<div class="box_con">
											<h4>流程平均时效</h4>
											<p class="flow_avg_day">0</p>
										</div>
										<div class="box_con">
											<h4>节点平均时效</h4>
											<p class="node_avg_day">0</p>
										</div>
									</div>
								</div>
								<div class="dashboard_item" style="width: 50%;max-width: 50%;min-width: 50%;">
									<div class="chart panel" style="padding: 10px 5px;" id="table_6">
										<div class="table_box">
											<div class="table_header">
												<dl class="table_content table_header_con">
													<dd class="table_li">
														<div class="li_item" style="width: 40%;text-align: center;">
															<div class="item_con">单位</div>
														</div>
														<div class="li_item" style="width: 30%;text-align: center;">
															<div class="item_con">办结流程数</div>
														</div>
														<div class="li_item" style="width: 30%;text-align: center;">
															<div class="item_con">平均用时天数</div>
														</div>
													</dd>
												</dl>
											</div>
											<div class="table_body">
												<dl class="table_content table_body_con scroll_box" tkey="timer_4"></dl>
											</div>
										</div>
										<div class="panel_footer"></div>
									</div>
								</div>
							</div>
							<div class="map" style="background-color: #0A282F;">
								<div class="chart" id="map_2" style="visibility: hidden"></div>
								<div class="map_table" style="visibility: hidden">
									<p>本月办结流程 <span class="map_total"></span> 个</p>
									<p>平均用时 <span class="map_normal_count"></span> 天</p>
								</div>
							</div>
						</div>
					</div>
					<div class="column">
						<div class="panel">
							<h4 class="panel_title">流程办理时效<br/>-<br/>总部各中心</h4>
							<div class="chart" id="chart_9"></div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_12">
							<h4 class="panel_title">未关联制度流程统计</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 60%;text-align: center;">
												<div class="item_con">流程类别名称</div>
											</div>
											<div class="li_item" style="width: 40%;text-align: center;">
												<div class="item_con">流程数</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_7">
							<h4 class="panel_title">流程应用频率排行</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 70%;text-align: center;">
												<div class="item_con">流程名称</div>
											</div>
											<div class="li_item" style="width: 30%;text-align: center;">
												<div class="item_con">启用次数</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
					</div>
				</div>
			</div>
			<div id="wrapThree" class="container">
				<div class="header">
					<h2 class="header_title">中电建生态公司运营驾驶舱</h2>
				</div>
				<div class="content">
					<div class="column">
						<div class="panel" id="table_8">
							<h4 class="panel_title">上月单位计划考核情况</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">单位</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">完成计划数</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con" title="完成计划考核数">完成计划考核数</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">覆盖率</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_9">
							<h4 class="panel_title">部门绩效考核</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">部门</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">完成计划数</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con" title="完成计划考核数">完成计划考核数</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">覆盖率</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
					</div>
					<div class="column">
						<div class="map_content">
							<div class="dashboard" style="padding: 5px 0;">
								<div class="dashboard_item" style="width: 50%;max-width: 50%;min-width: 50%;">
									<div class="box_wrap">
										<div class="box_con">
											<h4>上月计划考核数</h4>
											<p class="plan_score_count">0</p>
										</div>
										<div class="box_con">
											<h4>平均覆盖率</h4>
											<p class="plan_score_avg">0</p>
										</div>
									</div>
								</div>
								<div class="dashboard_item" style="width: 50%;max-width: 50%;min-width: 50%;">
									<div class="box_wrap">
										<div class="box_con">
											<h4>上月流程负面清单数</h4>
											<p class="flow_negative_count">0</p>
										</div>
										<div class="box_con">
											<h4>负面清单平均扣分</h4>
											<p class="deduct_points">0.00</p>
										</div>
									</div>
								</div>
							</div>
							<div class="map" style="background-color: #0F1C3C;">
								<div class="chart" id="map_3" style="visibility: hidden"></div>
								<div class="map_table" style="visibility: hidden">
									<p>本月办结流程 <span class="map_total"></span> 个</p>
									<p>平均用时 <span class="map_normal_count"></span> 天</p>
								</div>
							</div>
						</div>
					</div>
					<div class="column">
						<div class="panel" id="table_10">
							<h4 class="panel_title">上月单位流程负面清单</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 40%;text-align: center;">
												<div class="item_con">单位</div>
											</div>
											<div class="li_item" style="width: 30%;text-align: center;">
												<div class="item_con">完成流程数</div>
											</div>
											<div class="li_item" style="width: 30%;text-align: center;">
												<div class="item_con">流程负面清单数</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_11">
							<h4 class="panel_title">流程退回延时明细表</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">节点名称</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">姓名</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">类型</div>
											</div>
											<div class="li_item" style="width: 25%;text-align: center;">
												<div class="item_con">扣分</div>
											</div>
										</dd>
									</dl>
								</div>
								<div class="table_body">
									<dl class="table_content table_body_con scroll_box"></dl>
								</div>
							</div>
							<div class="panel_footer"></div>
						</div>
					</div>
				</div>
			</div>
			<div id="wrapFour" class="container">
				<div class="header">
					<h2 class="header_title">中电建生态公司运营驾驶舱</h2>
				</div>
				<div class="content">
					<iframe id="waterId" src="" frameborder="0" style="width: 100%;height: 100%;"></iframe>
				</div>
			</div>
		</div>
		
		<script>
			$.get("/monitoring/judgmentDownload",function (res) {
				var url = 'http://10.191.17.23:8450/water/sso/ssoComoduleIndex?flag='+res;
				$('#waterId').attr('src', url);
			});
            resizeWrapper()
            window.onresize = function () {
                resizeWrapper()
            }

            function resizeWrapper() {
                var clientHeight = $(window).height()
                var clientWidth = $(window).width()

                var h = clientHeight / 1080
                var w = clientWidth / 1920

                $('.wrapper').css({
                    'transform': 'scale(' + w + ', ' + h + ')'
                })
            }

            var height = $('.table_box').height()
            var theadHeight = $('.table_header').height()
            $('.table_body').height(height - theadHeight - 3).show()
            
            var tHeight = $('#wrapThree .table_box').height()
            var tTheadHeight = $('#wrapThree .table_header').height()
            $('#wrapThree .table_body').height(tHeight - tTheadHeight - 3).show()

            $('.group_right button').on('click', function () {
                if ($(this).hasClass('active')) {
                    return false
                }
                $('.group_left button').removeClass('active')
                var btnType = $(this).attr('btn_type')
                var eleId = ''
                if (btnType == 1) {
                    eleId = 'wrapOne'
                    $('.wrapper').css({
                        'background': 'url(/img/planCheck/operationsCockpit_ZDJ/bg.jpg)'
                    })
                } else if (btnType == 2) {
                    eleId = 'wrapTwo'
                    $('.wrapper').css({
                        'background': 'url(/img/planCheck/operationsCockpit_ZDJ/theme_2/bg.png)'
                    })
                } else if (btnType == 3) {
                    eleId = 'wrapThree'
                    $('.wrapper').css({
                        'background': 'url(/img/planCheck/operationsCockpit_ZDJ/theme_3/bg.png)'
                    })
                }
                $(this).siblings().removeClass('active')
                $(this).addClass('active')
                $('.container').css({
                    'opacity': '0',
                    'z-index': '0'
                })
                $('#' + eleId).css({
                    'opacity': '1',
                    'z-index': '1'
                }).fadeIn()
            })
			
			$('.group_left button').on('click', function() {
			    if ($(this).hasClass('active')) {
                    return false
                }
			    $('.group_right button').removeClass('active')
				$(this).addClass('active')
				$('.wrapper').css({
                        'background': 'url(/img/planCheck/operationsCockpit_ZDJ/bg.jpg)'
                    })
				$('.container').css({
					'opacity': '0',
                    'z-index': '0'
				})
				$('#wrapFour').css({
                    'opacity': '1',
                    'z-index': '1'
                }).fadeIn()
			})
		</script>
		<script src="/js/planCheck/operationsCockpit_ZDJ/scroll/js/jquery.liMarquee.js?"></script>
		<script src="/js/planCheck/operationsCockpit_ZDJ/tool.js?<%=datetime%>"></script>
		<script src="/js/planCheck/operationsCockpit_ZDJ/index.js?<%=datetime%>"></script>
	</body>
</html>
