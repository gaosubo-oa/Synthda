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
	<title>OA升级</title>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1"  media="all">
	<script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<%--<script src="/js/jqmeter.min.js" type="text/javascript"></script>--%>
	<style type="text/css">
		body,div,a,span,p,input,table,tr,td,th,thead,tbody,select{
			margin: 0;
			padding: 0;
		}
		body{
			font-family: 微软雅黑;
			width: 100%;
			/*overflow: hidden;*/
			background: #f2f2f2;
		}
		.content{
			width: 100%;
			position: relative;
		}
		.mainCont{
			width: 352px;
			height: 416px;
			position: absolute;
		}
		.mainCont span{
			display: block;
			width: 100%;
			text-align: center;
			font-size: 18px;
			color: #5b7491;
			margin-top: 20px;
		}
		.divBtn{
			width: 180px;
			height: 76px;
			line-height: 62px;
			text-align: center;
			font-size: 18px;
			background: url("/img/common/updateDatebase/icon_closeBtn.png") no-repeat;
			color: #ffffff;
			margin: 10px auto;
			cursor: pointer;
		}
		.divBtn:hover{
			background: url("/img/common/updateDatebase/icon_floatClose.png") no-repeat;
		}
	</style>
</head>
<body>
<div id="main" class="content">
	<div class="mainCont">
		<img src="/img/common/updateDatebase/icon_yijingshengji.png" alt="">
		<span>已进行过升级，请勿重新操作</span>
		<div class="divBtn">关闭</div>
	</div>
</div>
<script type="text/javascript">
	$(function () {
		var WHIDTH=$(document).width();
		var HEIGHT=$(document).height();
		var Left=(WHIDTH-352)/2;
		var Top=(HEIGHT-416)/2;
		$('.mainCont').css({'top':Top+'px','left':Left+'px'});

		$('.divBtn').click(function () {
            $('.divBtn').css('background','url(/img/common/updateDatebase/icon_clickClose.png)')
			window.location.href='/';
			window.close();
        })

    })
</script>
</body>
</html>
