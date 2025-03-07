<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-06-08
  Time: 11:03
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
		<title>计划关键任务</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		
		<style>
			html, body {
				width: 100%;
				height: 100%;
				background: #fff;
				user-select: none;
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
				overflow: hidden;
			}
		</style>
		
		<script type="text/javascript">
            var funcUrl = location.pathname;
            var authorityObject = null;
            if (funcUrl) {
                $.ajax({
                    type: 'GET',
                    url: '/plcPriv/findPermissions',
                    data: {
                        funcUrl: funcUrl
                    },
                    dataType: 'json',
                    async: false,
                    success: function (res) {
                        if (res.flag) {
                            if (res.object && res.object.length > 0) {
                                authorityObject = {}
                                res.object.forEach(function (item) {
                                    authorityObject[item] = item;
                                });
                            }
                        }
                    },
                    error: function () {

                    }
                });
            }
		</script>
	
	</head>
	<body>
		<div class="container">
		<%--	<div class="header">
				<div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px">
                        <img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt="">
                        <span style="margin-left: 10px">计划关键任务</span>
                    </span>
				</div>
			</div>
			<hr>--%>
			<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
				<ul class="layui-tab-title">
					<li class="layui-this">主项关键任务</li>
					<li>职能关键任务</li>
				</ul>
				<div class="layui-tab-content" style="padding: 0;">
					<div class="layui-tab-item layui-show">
						<iframe id="iframeName" src="/projectTarget/projectPlan" style="width:100%;height: 100%;min-height: 500px;"
						        frameborder="0"></iframe>
					</div>
				</div>
			</div>
		</div>
		
		<script>
            $('#iframeName').height($(window).height() - 130);
            layui.use(['element'], function () {
                var element = layui.element;
                //一些事件监听
                element.on('tab(docDemoTabBrief)', function (data) {
                    var iframeUrl = '';
                    switch (data.index) {
                        case 0:
                            iframeUrl = '/projectTarget/projectPlan';
                            break;
                        case 1:
                            iframeUrl = '/projectTarget/deptPlan';
                            break;
                        default:
                            iframeUrl = '/projectTarget/projectPlan';
                            break;
                    }
                    $('#iframeName').attr('src', iframeUrl);
                });
            });
		</script>
	</body>
</html>

