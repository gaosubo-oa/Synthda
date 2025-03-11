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
	<title>会议查询</title>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
	<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css">

	<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
	<script type="text/javascript" src="/js/base/base.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js"></script>

	<style>

		html, body {
			width: 100%;
			height: 100%;
			padding: 0;
			margin: 0;
			/*background: #fff;*/
			user-select: none;
			font-size: 1.3vw;
			font-weight: 600;
		}
		#footerBox{
			width: 100%;
			height: 100%;
			padding: 0;
			margin: 0;
			background: url("/img/app/metting.png") no-repeat;
			background-size: 100% 100%;
			position: absolute;
		}

		/*#footer ul{*/
		/*	height: 60%;*/
		/*	position: relative;*/
		/*	width: 73%;*/
		/*	background: red;*/
		/*	top: 28%;*/
		/*	left: 26%;*/
		/*}*/

		#footer li{
			height: 80px;
			list-style: none;
		}

		#footer li span,.footerUl span{
			height: 100%;
			line-height: 80px;
			margin-left: 2%;
		}
		#footer #footerRbox,.noBox {
			height: 58%;
			overflow: hidden;
			position: relative;
			width: 73%;
			top: 26%;
			left: 26%;
		}
		.footerUl{
			position: relative;
			width: 73%;
			top: 28%;
			left: 26%;
		}

	</style>
</head>
<body>
	<div id="footer" calss="mainBox">
		<div id="footerBox" style="transition:1.5s;overflow:hidden;">
			<div class="footerUl">
				<span>会议室</span><span>会议名称</span><span>申请人</span><span>开始时间</span><span>结束时间</span><span>会议状态</span>
			</div>
			<div id="footerRbox">
				<ul id="footerUlBox">

				</ul>
				<div id="footerCoBox" class="mainBox" style="width: 100%;padding: 0;margin: 0;position: absolute;"></div>
			</div>

		</div>
	</div>
</body>
<script>
	window.onresize = function(){
		var box = document.getElementById("footer");
		box.style["z-index"] = 1;
	}
	layui.use(['form', 'layer','table', 'element','upload','laydate','treeSelect'], function() {
		render();
		function render(page){
			$("#footerUlBox").empty();
			//获取数据
			$.ajax({
				url:"/meeting/meetingQueryByStatus?statusStr=2,3",
				dataType:"json",
				async: false,
				type:"post",
				success:function(res){
					if(res.flag){
						var data = res.obj;
						if(data!=undefined&&data.length>0){
							//初始化渲染
							var ele = "";
							for(var i=0;i<data.length;i++){
								ele+="<li><span>"+data[i].meetRoomName+"</span><span>"+data[i].meetName+"</span><span>"+data[i].startTime+"</span><span>"+data[i].startTime+"</span><span>"+data[i].endTime+"</span><span>"+data[i].statusName+"</span></li>";
							}
							$("#footerUlBox").html(ele);
							var viewHeight = $("#footerRbox").height();
							if(80*data.length>viewHeight){
								var speed=3000;
								var footerBox=document.getElementById("footerRbox");
								var footerUlBox=document.getElementById("footerUlBox");
								var footerCoBox=document.getElementById("footerCoBox");
								footerCoBox.innerHTML=footerUlBox.innerHTML
								function Marquee(){
									if(footerBox.scrollTop>=footerUlBox.offsetHeight){
										footerBox.scrollTop=0;
									}
									else{
										var liHeight = $("#footerUlBox").find("li").eq(0).height();
										var h =footerBox.scrollTop+liHeight;
										$("#footerRbox").animate({scrollTop: h}, 2000);
									}
								}
								var MyMar=setInterval(Marquee,speed)
								footerBox.onmouseover=function(){clearInterval(MyMar)}
								footerBox.onmouseout=function(){MyMar=setInterval(Marquee,speed)}
							}
						}else{
							$("#footerBox").html("<div class='noBox'><span>暂无会议</span></div>")
						}
					}else{
						$("#footerBox").html("<div class='noBox'><span>暂无会议</span></div>")
					}
				}
			})
		}
	})
</script>
</html>

