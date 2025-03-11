<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/12/31
  Time: 16:58
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
		<title>数据检测</title>
		
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
		<script type="text/javascript" src="/js/base/base.js"></script>
	</head>
	<body>
		<div class="wrapper">
			<div class="container">
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
						<div class="panel">
							<h4 class="panel_title">计划完成率分析</h4>
							<div class="chart" id="chart_2"></div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel" id="table_1">
							<h4 class="panel_title">项目滞后分析</h4>
							<div class="table_box">
								<div class="table_header">
									<dl class="table_content table_header_con">
										<dd class="table_li">
											<div class="li_item" style="width: 50%;">
												<div class="item_con">检测断面</div>
											</div>
											<div class="li_item" style="width: 25%;">
												<div class="item_con" style="text-align: center;">测量时间</div>
											</div>
											<div class="li_item" style="width: 25%;">
												<div class="item_con" style="text-align: center;">水质类别</div>
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
					<div class="column"></div>
					<div class="column">
						<div class="panel">
							<h4 class="panel_title">计划完成率分析</h4>
							<div class="chart" id="chart_3"></div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel">
							<h4 class="panel_title">计划完成率分析</h4>
							<div class="chart" id="chart_4"></div>
							<div class="panel_footer"></div>
						</div>
						<div class="panel">
							<h4 class="panel_title">计划完成率分析</h4>
							<div class="chart" id="chart_5"></div>
							<div class="panel_footer"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script src="/js/planCheck/operationsCockpit_ZDJ/scroll/js/jquery.liMarquee.js?"></script>
		<script src="/js/planCheck/operationsCockpit_ZDJ/tool.js?<%=datetime%>"></script>
	</body>
</html>
