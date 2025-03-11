<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><fmt:message code="vote.th.supervisionRecord"/></title>
	<link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css"/>
<%--	<script type="text/javascript" src="../js/xoajq/xoajq1.js"></script>--%>
	<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
	<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
	<script src="../js/news/page.js"></script>
	<script src="../lib/laydate/laydate.js"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106"></script>
	<style>
		.bx{
			width: 100%;
			height: 100%;
		}
		.head{
			height:45px;
		}
	</style>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>

</head>

<body>
	<div class="bx">
		<div class="head w clearfix">
			<ul class="index_head">
				<li data_id="0" data-num="0"><span class="one headli1_1"><fmt:message code="vote.th.supervisionRecord"/></span><img class="headli1_2" src="../img/twoth.png" alt=""/></li>
				<li data_id="1" data-num="1"><span class="headli1_1"><fmt:message code="vote.th.NewFile"/></span><img class="headli1_2" src="../img/twoth.png" alt=""/></li>
				<li data_id="2" data-num="2"><span class="headli"><fmt:message code="vote.th.FileQuery"/></span></li>
			</ul>
		</div>
		<div class="mainCon">
			<div class="divIframeOne iframeShow" style="width: 100%;height: 100%;display: block;">
				<iframe src="/rmsRoll/toManagePage" id="iframeOne" style="width: 100%;height: 100%;" frameborder="0"></iframe>
			</div>
			<div class="divIframeTwo iframeShow" style="width: 100%;height: 100%;display: none;">
				<iframe src="/rmsRoll/toNewPage" id="iframeTwo" style="width: 100%;height: 100%;" frameborder="0"></iframe>
			</div>
			<div class="divIframeThr iframeShow" style="width: 100%;height: 100%;display: none;">
				<iframe src="/rmsRoll/toQueryPage" id="iframeThr" style="width: 100%;height: 100%;" frameborder="0"></iframe>
			</div>
			<div class="divIframeFour iframeShow" style="width: 100%;height: 100%;display: none;">
				<iframe src="/rmsRoll/toQueryPage" id="iframeFour" style="width: 100%;height: 100%;" frameborder="0"></iframe>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){

			$('.one').on('click',function(){
				location.reload();
			})

            $('.mainCon').height($('.bx').height() - $('.head').height() - 1)

			$('.index_head li').on('click',function(){
			    var ind=$(this).index();
			    $(this).find('span').addClass('one').end().siblings().find('span').removeClass('one');
			    $('.mainCon').find('.iframeShow').eq(ind).show().siblings().hide();

			    if($('.divIframeOne').css('display') == 'block'){
                    var test = $("#iframeOne").contents().find("#juMange");
                    test.show().siblings().hide();
				}
			})
		})
	</script>
</body>
</html>
