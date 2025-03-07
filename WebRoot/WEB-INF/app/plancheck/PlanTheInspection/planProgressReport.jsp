<%--
  Created by IntelliJ IDEA.
  User: 96394
  Date: 2020/6/5
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
	<head>
		<title>职能计划进展报表</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
		
		<style>
			html,body {
				height: 100%;
				width: 100%;
				background-color: #fff;
			}
			
			.container {
				position: relative;
				width: 100%;
				height: 100%;
			}
			
			.content {
				position: absolute;
				top: 10px;
				right: 0;
				bottom: 0;
				left: 0;
				width: 100%;
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
			<div class="content">
				<div class="layui-tab layui-tab-brief" lay-filter="planProgressTab" style="margin-top: 0;">
					<ul class="layui-tab-title" style="float: left">
						<li class="layui-this">计划子任务报表</li>
						<li>职能关键任务报表</li>
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
						<iframe id="iframeName" src="/StatisticalReport/planTaskReport" style="width: 100%;height: 100%" frameborder="0"></iframe>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			$('.layui-tab-content').height($(window).height()-70);
			window.onresize = function(){
				$('.layui-tab-content').height($(window).height()-70);
			}
            layui.use(['element'], function(){
			    var element = layui.element;
			    
			    element.on('tab(planProgressTab)', function(obj){
			        var iframeUrl = '';
                    switch (obj.index) {
						case 0:
						    iframeUrl = '/StatisticalReport/planTaskReport';
						    break;
	                    case 1:
	                        iframeUrl = '/StatisticalReport/deptTargetReport';
	                        break;
                    }
                    
                    $('#iframeName').attr('src', iframeUrl);
                });
			    
			});
		</script>
	
	</body>
</html>
