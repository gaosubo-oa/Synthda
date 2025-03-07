<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title></title>
	<script src="/js/common/language.js"></script>
    <script type="text/javascript" src="js/jquery/jquery-1.11.1.min.js"></script>
    <script src="js/base/base.js"></script>
	<!-- <link rel="stylesheet" type="text/css" href="css/index.css"/> -->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
	<link rel="stylesheet" type="text/css" href="css/main/theme1/m_reset.css"/>
	<link rel="stylesheet" type="text/css" href="css/main/theme1/cont.css"/>
	
	<style>
		@import url(m_reset.css);
		.emli_choose{
			background: #00a2d4;
		}
	</style>
</head>

<body>
	<div class="wrapper">
		<div class="header">
			<ul>
				<li><span class="head_title active"><fmt:message code="main.title.oneself"/></span></li>
				<li><span class="head_title"><fmt:message code="main.title.company"/></span></li>
				<li><span class="head_title"><fmt:message code="main.title.manage"/></span></li>
			</ul>
		
		</div>
		<div class="main">
			<ul class="total">
				<li class="contain side">
					 <div class="s_head">
						<span  class="model"><fmt:message code="main.th.function"/></span><span class="more"><a><fmt:message code="main.th.manage"/></a></span>
					</div>
					<div class="s_container">
						<div class="every_logo" menu_tid="0116"><img src="img/spirit/menu/notice.png"><h2><fmt:message code="notice.th.notice" /></h2></div>
						<div class="every_logo" menu_tid="0101"><img src="img/spirit/menu/mail.png"><h2><fmt:message code="notice.th.mail" /></h2></div>
						<div class="every_logo" menu_tid="0124"><img src="img/spirit/menu/data.png"><h2><fmt:message code="email.th.agenda" /></h2></div>
						<div class="every_logo" menu_tid="2013"><img src="img/spirit/menu/news.png"><h2><fmt:message code="main.news" /></h2></div>
						<div class="every_logo" menu_tid="3001"><img src="img/spirit/menu/nor.png"><h2><fmt:message code="file.th.file" /></h2></div>
						<div class="every_logo" menu_tid="0128"><img src="img/spirit/menu/daily.png"><h2><fmt:message code="email.th.log" /></h2></div>
					</div>
				</li>
				<li class="contain middle">
				 <div class="s_head">
						<span  class="model"><fmt:message code="email.title.mailbox"/></span><span class="head_title sort active actives"><fmt:message code="email.th.allmail"/></span><span class="head_title sort"><fmt:message code="email.th.unreadmail"/></span><span class="head_title sort"><fmt:message code="email.th.readmail"/></span><span class="more"><a><fmt:message code="email.th.more"/></a></span>
					</div>
					<div class="s_container">
						<ul>
							<li><span class="e_img"><img src="http://devapp.gsubo.com/file0/E101000001/avatar/332841055.1325694304.jpg"></span><span class="e_name">张兰</span><span class="e_title">本人季度薪资申请<i style="background:url(https://app.gsubo.com/ui/img/mail/fileflag.png)"></i></span><span class="e_time">4月28日</span></li>
							<li><span class="e_img"><img src="http://app.gsubo.com/file0/E101000001/avatar/1008181431.357608441.png"></span><span class="e_name">王丽</span><span  class="e_title">ReAll:王曰岐04-23工作日报<i></i></span><span class="e_time">4月23日</span></li>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/1107331905.1411049547.png"></span><span class="e_name">刘云</span><span  class="e_title">软通反馈的无法登录问题报告<i></i></span><span class="e_time">1月12日</span></li>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/1971178126.1475652706.png"></span><span class="e_name">潘芝芝</span><span  class="e_title">本次升级测试bug分析<i></i></span><span class="e_time">2016年7月21日</span></li>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/1772713180.972046570.jpg"></span><span class="e_name">周小北</span><span  class="e_title">关于小卓通知的汇报<i></i></span><span class="e_time">2016年4月30日</span></li>
						</ul>
					</div>
				</li>
				<li class="contain side">
					 <div class="s_head">
						<span  class="model"><fmt:message code="email.th.log"/></span><span class="more"><a><fmt:message code="email.th.more"/></a></span>
					</div>
					<div class="s_container">
						<ul>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/990557262.180238795.png"></span><span class="e_name">朱红</span><span class="e_title">人力资源变更备忘<i style="background:url(http://devapp.gsubo.com/ui/img/mail/fileflag.png)"></i></span><span class="e_time">3月20日</span></li>
							<li><span class="e_img"><img src="http://app.gsubo.com/file0/E101000001/photo/115438796.997410756.jpg"></span><span class="e_name">王媛</span><span  class="e_title">修改开发规范<i></i></span><span class="e_time">2月04日</span></li>
							<li><span class="e_img"><img src="http://app.gsubo.com/file0/E101000001/photo/1367380632.1000119131.jpg"></span><span class="e_name">张咪</span><span  class="e_title">市场调查结果分析<i></i></span><span class="e_time">1月11日</span></li>
							<li><span class="e_img"><img src="http://devapp.gsubo.com/file0/E101000001/avatar/332841055.1325694304.jpg"></span><span class="e_name">刘芳妮</span><span  class="e_title">售后服务问题反馈<i></i></span><span class="e_time">2016年10月21日</span></li>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/1721260475.1180844205.png"></span><span class="e_name">鲁平平</span><span  class="e_title">项目开发进度演示<i></i></span><span class="e_time">2016年10月07日</span></li>
						</ul>
					</div>
				</li>
				<li class="contain side">
					 <div class="s_head">
						<span  class="model"><fmt:message code="main.schedule"/></span><span class="more"><a><fmt:message code="global.lang.add"/></a></span>
					</div>
					<div class="s_container">
						<img style="width:100%;height:100%" src="img/spirit/menu/richenganpai.png">
					</div>
				</li>
				<li class="contain middle">
					 <div class="s_head">
						<span  class="model"><fmt:message code="notice.th.notice"/></span><span class="head_title sort active actives"><fmt:message code="notice.th.allnotice"/></span><span class="head_title sort"><fmt:message code="notice.title.unreadannouncement"/></span><span class="more"><a><fmt:message code="email.th.more"/></a></span>
					</div>
					<div class="s_container">
						<ul>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/1898498514.1379470215.png"></span><span class="e_name">于青</span><span class="e_title">2017年公司五一放假通知<i style="background:url(http://devapp.gsubo.com/ui/img/mail/fileflag.png)"></i></span><span class="e_time">4月27日</span></li>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/1988893313.2124360565.png"></span><span class="e_name">刘敏</span><span  class="e_title">通知：关于加班申请，大家仔细阅读<i></i></span><span class="e_time">4月24日</span></li>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/1476383706.601542059.png"></span><span class="e_name">王伟</span><span  class="e_title">关于差旅制度完善的通知<i></i></span><span class="e_time">2016年5月27日</span></li>
							<li><span class="e_img"><img src="https://www.gsubo.com/file0/E101000001/avatar/912559279.204126377.jpg"></span><span class="e_name">陈彤</span><span  class="e_title">月度部门奖励公告<i></i></span><span class="e_time">2016年4月21日</span></li>
							<li><span class="e_img"><img src="http://devapp.gsubo.com/file0/E101000001/avatar/332841055.1325694304.jpg"></span><span class="e_name">张兰</span><span  class="e_title">全员测试要求<i></i></span><span class="e_time">2016年1月20日</span></li>
						</ul>
					</div>
				</li>
				<li class="contain side">
					 <div class="s_head">
						<span  class="model"><fmt:message code="file.th.file"/></span><span class="more"><a><fmt:message code="email.th.more"/></a></span>
					</div>
					<div class="s_container">
						<img style="width:100%;height:100%" src="img/spirit/menu/wenjiangui.png">
					</div>
				</li>
			</ul>
		</div>
    </div>
 
</body>
	<script>
			$(function(){
				var lh=$(".s_container ul li").height();
				$(".s_container ul li span").css("line-height",lh + 'px');
				$(window).resize(function(){
					var lh=$(".s_container ul li").height();
					$(".s_container ul li span").css("line-height",lh + 'px');
				});
				//点击常用功能里面的div,进行页面跳转。
				$('.s_container').on('click','.every_logo',function(){
					var  tid=$(this).attr('menu_tid');
					console.log(tid);
				})
				
			})
			
		
		
	</script>
</html>

