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
		<title>公文收发</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" type="text/css" href="/css/news/center.css"/>
		<link rel="stylesheet" type="text/css" href="/css/base.css"/>
		<link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
		<link rel="stylesheet" type="text/css" href="/css/news/new_news.css"/>
		<link rel="stylesheet" type="text/css" href="/css/news/management_query.css"/>
		<link rel="stylesheet" type="text/css" href="/css/workflow/work/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

		<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
		<script src="/js/jquery/jquery.cookie.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		
		<style>
			html,body{
				width: 100%;
				height: 100%;
			}
			
			.bx {
				position: relative;
				height: 100%;
			}
			.head.w {
				position: absolute;
				top: 0;
				left: 0;
			}
		</style>
	</head>
	<body>
		<div class="bx">
			<!--head开始-->
			<div class="head w clearfix">
				<ul class="index_head">
					<li data-num="0">
						<span class="head_li one"><fmt:message code="main.th.fawen"/></span>
						<img src="/img/twoth.png" style="margin-left: 15px;">
					</li>
					<li data-num="1">
						<span class="head_li"><fmt:message code="main.issuedADocument"/></span>
						<img src="/img/twoth.png" style="margin-left: 15px;">
					</li>
					<li data-num="2">
						<span class="head_li"><fmt:message code="main.th.shouwen"/></span>
						<img src="/img/twoth.png" style="margin-left: 15px;">
					</li>
					<li data-num="3">
						<span class="head_li"><fmt:message code="doc.th.HasOffice"/></span>
						<img src="/img/twoth.png" style="margin-left: 15px;">
					</li>
				</ul>
			</div>
			<div style="width: 100%;height: 100%;padding-top: 44px;box-sizing: border-box;">
				<iframe id="documentModule" src="/document/makeADraft" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize" tid="2"></iframe>
			</div>
		</div>
		
		<script>
			// 切换页面
			$('.index_head li').on('click', function(){
			    $(this).siblings().find('.head_li').removeClass('one');
			    $(this).find('.head_li').addClass('one');
			    var num = $(this).index();
			    var iframeUrl = '';
				switch (num) {
					case 0:
					    iframeUrl = '/document/makeADraft';
					    break;
                    case 1:
                        iframeUrl = '/document/IthasBeenDone';
					    break;
					case 2:
					    iframeUrl = '/document/inAbeyance';
					    break;
                    case 3:
                        iframeUrl = '/document/received';
					    break;
                }
                $('#documentModule').attr('src', iframeUrl);
            })
		</script>
		
	</body>
</html>
