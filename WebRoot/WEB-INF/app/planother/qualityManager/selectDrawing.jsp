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
	<title>图纸</title><%--图纸--%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%--    <meta name="renderer" content="webkit">--%>
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/common.css">
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<script src="/lib/layui/layui/layui.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
	<script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
	<script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="../../js/common/fileupload.js"></script>
</head>
<style type="text/css">
	html,body{
		background: #fff;
	}
	.layui-card-header{
		border-bottom: 1px solid #eee;
	}
	.mbox{
		padding: 0px;
	}
	.inbox{
		padding: 5px;
		padding-right: 30px;
	}
	.deptinput{
		display: inline-block;
		width: 75%;
	}
	.layui-btn{
		margin-left: 10px;
	}
	.layui-btn .layui-icon{
		margin-right: 0px;
	}
	.red{
		color: red;
		font-size: 16px;
	}
	.layui-form-label{
		padding: 8px 15px;
	}
	.layui-card-body{
		display: flex;
	}
	.layui-lf{
		min-width: 16%;
		overflow-x: auto;
		height: 600px !important;
	}
	.layui-rt{
		width: 84%;
		margin-left: 6px;
		margin-top:0px;
	}
	.treeTitle{
		display: flex;
		box-sizing: border-box;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 30px;
		background-color: #00a0e9;
		color: #fff;
		padding: 15px;
		position: relative;
	}
	.layui-nav-item,.layadmin-flexible{
		position: absolute;
		left: 5px;
		top: 23px;
		z-index: 9999999;
	}
	.rtfix{
		width:200px;
		overflow-x: scroll;
	}
	.bg{
		background-color: #F2F2F2;
	}
	.bgs{
		background-color: #F2F2F2;
	}
	.back{
		background-color: #ccc;
	}
	/*滚动条样式*/
	/*.rtfix::-webkit-scrollbar {!*滚动条整体样式*!*/
	/*width: 4px;     !*高宽分别对应横竖滚动条的尺寸*!*/
	/*height: 10px;*/
	/*}*/
	/*.rtfix::-webkit-scrollbar-button{*/
	/*background-color: #000;*/
	/*border:1px solid #ccc;*/
	/*display:block;*/
	/*}*/
	/*.rtfix::-webkit-scrollbar-thumb {!*滚动条里面小方块*!*/
	/*border-radius: 5px;*/
	/*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
	/*background: rgba(0,0,0,0.2);*/
	/*}*/
	/*.rtfix::-webkit-scrollbar-track {!*滚动条里面轨道*!*/
	/*-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);*/
	/*border-radius: 0;*/
	/*background: rgba(0,0,0,0.1);}*/
	.eleTree{
		cursor: pointer;
	}
	.layui-table-view .layui-table td, .layui-table-view .layui-table th{
		padding: 3px 0;
	}
	.layui-tab layui-tab-card{
		margin-top: -4px;
	}
	.layui-tab-card>.layui-tab-title .layui-this:after {
		border-width: 0px;
	}
	.baseinfo td{
		padding: 5px 2px;
	}
	.active{
		display: none;
	}
	.back{
		background-color: #F2F2F2;
	}
	.layui-colla-item {
		position: relative;
	}
	.layui-collapse .layui-card-body{
		padding: 0 8px;
	}
	.repairLable{
		padding: 8px 15px;
		text-align: right;
		vertical-align: middle;
	}
	.layui-form-select dl dd{
		height: 32px;
		line-height: 32px;
	}
	.layui-form-select .layui-select-title .layui-input{
		height: 32px;
	}
	#formTest .layui-form-select input,#lendListTest .layui-form-select input{
		height: 32px;
	}
	.layui-input{
		height: 32px !important;
	}
	.layui-form-item{
		margin-bottom: 5px; !important;
	}
	.layui-form-label{
		width: 70px; !important;
	}
	.textAreaBox{
		width: 100%;
		max-width: 100%;
		cursor: pointer;
		margin: 0px;
		overflow-y:visible;
		min-height: 37px;
	}
	.openFile input[type=file]{
		position: absolute;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		width: 100%;
		height: 18px;
		z-index: 99;
		opacity: 0;
	}

	#south {
		position: fixed;
		bottom: 0px;
		width: 100%;
		text-align: right;
		padding: 5px 0px;
		background: #e7e7e7;
		border-top: 1px #fff solid;
		overflow: hidden;
	}

	input.BigButtonA {
		width: 60px;
		height: 30px;
		height: 28px !important;
		padding-bottom: 3px;
		color: #ffffff;
		background: url(/img/common/selectUser_normal.png) no-repeat;
		border: 0px;
		cursor: pointer;
		font-size: 12pt;
	}

	.img{
		position:relative;
	}
	.img .marker{
		width: 15px;
		height: 15px;
		position:absolute;
		background:#f00;
		border-radius: 50%;
	}
	#drawImg{
		width: 100%;
		margin: 0 auto;
	}
	#magnify{
		width: 500px;
		position: fixed;
		top: 7%;
		left: 50%;
		margin-left: -250px;
	}
</style>
<body>
<div style="width: 100%;height: 80px">
	<div id="magnify">
		<%--<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
            <legend>基本滑块</legend>
        </fieldset>--%>
		<div id="slideTest1" class="demo-slider"></div>
	</div>
</div>
<div class="img" id="dv" style="height: 100%">
	<img id="drawImg" src=" ">
</div>
<div id="south">
	<input type="button" class="BigButtonA" id="define" value='确定'>&nbsp;&nbsp;<%--确定--%>
</div>
</body>
<script type="text/javascript">
	var detailsInit2;
	var detailsInitData2=[];
	var detailsInit3;
	var detailsInitData3=[];
	var offWidth;
	var offHeight;
	var markerValue;

	$(document).on("click","#rectificationPersion",function(){ //整改人
		user_id = "rectificationPersion";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})

	$(document).on("click","#acceptancePersion",function(){ //验收人
		user_id = "acceptancePersion";
		$.popWindow("/projectTarget/selectOwnDeptUser?0");
	})

	var securityContentId = getUrlParam("securityContentId");
	var layEvent1 = getUrlParam("layEvent1");
	//var layEvent2 = getUrlParam("layEvent2");
	var layEvent3 = getUrlParam("layEvent3");
	var layEvent4 = getUrlParam("layEvent4");


	var _type = getUrlParam("type");
	var _urls = getUrlParam("urls");
	var _regionX = getUrlParam("regionX");
	var _regionY = getUrlParam("regionY");

	if(opener._urlImg){
		(function () {
			$('#drawImg').attr('src','/xs?'+opener._urlImg);
			$('#dv').css('width',$(window).width());
		})()
	}


	layui.use(['table','layer','form','element','eleTree','upload','laydate','slider'], function() {
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		var eleTree = layui.eleTree;
		var element = layui.element;
		var $ = layui.jquery;
		var upload = layui.upload;
		var laydate = layui.laydate;
		var slider = layui.slider;
		//默认滑块
		slider.render({
			elem: '#slideTest1'
		});



		var dataa;
		/*$.ajax({
			url:"/workflow/secirityManager/getDetailsInfoById?detailsInfoId="+securityContentId,
			dataType:"json",
			type:"post",
			async:false,
			success:function(res){
				if(res.code===0||res.code==="0"){
					dataa = res.obj;
					console.log(dataa);
					$('#drawImg').attr('src','/xs?'+dataa.urls);
					$('#dv').css('width',$(window).width());
				}
			}
		})*/
		var dv1 = document.getElementById("dv");


		window.onresize = function(){
			offWidth = dv1.offsetWidth;
			offHeight = dv1.offsetHeight;
			if($(window).width()!=$('#dv').css('width'))
					/*console.log($(window).width());
                    console.log($(document).width());
                    console.log($(document.body).width());
                    console.log($('#dv').css('width'));*/
				$('#dv').css('width',$(window).width());
			ins1.setValue(0);
		}
		//debugger
		//var widthImg = $('#dv').css('width');
		var ins1 =  slider.render({
			elem: '#slideTest1'
			,change: function(value){
				if(value==0||value=='0'){
					$('#dv').css('width',$(window).width());
					$('.marker').css('width',15+value);
					$('.marker').css('height',15+value);
					markerValue = value;
					offWidth = document.getElementById("dv").offsetWidth;
					offHeight = document.getElementById("dv").offsetHeight;
				}else {
					$('#dv').css('width',(parseInt($(window).width())+parseInt(value*80))+'px');
					$('.marker').css('width',15+value);
					$('.marker').css('height',15+value);
					markerValue = value;
					offWidth = document.getElementById("dv").offsetWidth;
					offHeight = document.getElementById("dv").offsetHeight;

				}
				//console.log(widthImg);
				//console.log(value) //动态获取滑块数值
			}
		});

		if(_type == 'manage'){

			if(_regionX&&_regionY){
				var loadIndex = layer.load(1);
				createMarker(_regionX,_regionY,"dv");
				layer.close(loadIndex);
			}

			document.getElementById('dv').onclick = function (e) {
				$('.marker').remove();
				preDef(e);
				stopBubble(e);
				e = e || window.event;
				var x = e.offsetX || e.layerX, y = e.offsetY || e.layerY;
				x = ((x-10)/offWidth).toFixed(10);
				y = ((y-10)/offHeight).toFixed(10);

				createMarker(x, y,'dv');
				/*var obj={
					regionX:x,
					regionY:y,
				}*/

			}
			function createMarker(x, y,divName) {
				var isMove = false;
				x = (x*100) + '%';
				y = (y*100) + '%';
				var div = document.createElement('div');
				//div.className = 'marker'; div.style.left = (x - 3) + 'px'; div.style.top = (y - 3) + 'px';
				div.className = 'marker'; div.style.left = x; div.style.top = y;
				div.style.width = 15 + markerValue + 'px';
				div.style.height = 15 + markerValue + 'px';
				document.getElementById(divName).appendChild(div);
				div.onclick = function (e) {
					preDef(e);
					stopBubble(e);
					layer.confirm('确定要删除选中的检查项吗？', {icon: 3, title:'提示'}, function(index){
						div.remove();
						layer.close(index);
					})
				}
				return div;
			}
			$('#define').on("click",function() {
				if($(".marker").length>0){
					var regionX = $(".marker").css('left');
					regionX = regionX.replace("px","");
					var regionY = $(".marker").css('top');
					regionY = regionY.replace("px","");
					regionX = (regionX/offWidth).toFixed(10);
					regionY = (regionY/offHeight).toFixed(10);
					parent.opener.document.getElementById(parent.opener.drawing_id).setAttribute('regionX', regionX);
					parent.opener.document.getElementById(parent.opener.drawing_id).setAttribute('regionY', regionY);
					parent.opener.document.getElementById(parent.opener.drawing_id).innerText ='已标注';
					window.close();
				}else {
					parent.opener.document.getElementById(parent.opener.drawing_id).removeAttribute('regionX');
					parent.opener.document.getElementById(parent.opener.drawing_id).removeAttribute('regionY');
					parent.opener.document.getElementById(parent.opener.drawing_id).innerText ='未标注';
					window.close();
				}
			})
		}else if(_type =='manageOther'){
			if(_regionX&&_regionY){
				var loadIndex = layer.load(1);
				createMarker(_regionX,_regionY,"dv");
				layer.close(loadIndex);
			}
			function createMarker(x, y,divName) {
				var isMove = false;
				x = (x*100) + '%';
				y = (y*100) + '%';
				var div = document.createElement('div');
				//div.className = 'marker'; div.style.left = (x - 3) + 'px'; div.style.top = (y - 3) + 'px';
				div.className = 'marker'; div.style.left = x; div.style.top = y;
				div.style.width = 15 + markerValue + 'px';
				div.style.height = 15 + markerValue + 'px';
				document.getElementById(divName).appendChild(div);
				/*div.onclick = function (e) {
					preDef(e);
					stopBubble(e);
					layer.confirm('确定要删除选中的检查项吗？', {icon: 3, title:'提示'}, function(index){
						div.remove();
						layer.close(index);
					})
				}*/
				//拖拽
				/*div.onmousedown = function(ev){
					isMove = false
					//console.log("鼠标按下了");
					var e = ev || window.event;
					var offsetX = e.clientX - div.offsetLeft;
					var offsetY = e.clientY - div.offsetTop;
					//debugger
					document.onmousemove = function(ev){
						isMove = true
						//console.log("鼠标在移动");
						var e =ev || window.event;
						var l = e.clientX - offsetX;
						var t = e.clientY - offsetY;
						//限制出界
						if(l <= 0){
							l = 0;
						}
						if(l >= offWidth){
							l = offWidth;
						}
						if(t <= 0){
							t = 0;
						}
						if(t >= offHeight){
							t = offHeight;
						}
						div.style.left = l + 'px';
						div.style.top = t + 'px';
					}
					document.onmouseup = function(){
						//console.log("鼠标抬起了");
						document.onmousemove = null;
						document.onmouseup = null;
					}
				}*/

				return div;
			}
			$('#define').on("click",function() {
				window.close();
			})
		}else if(layEvent1 === 'initialization'){
			var loadIndex = layer.load(1);
			$.ajax({
				url:'/workflow/secirityManager/getDetailsInfoByRegionId?securityRegionId='+dataa.securityRegionId+'&checkliId='+dataa.checkliId,
				dataType:"json",
				type:"post",
				success:function(res){
					var dataa1 = res.data;
					if(dataa1!=undefined&&dataa1.length>0){
						for(var j=0;j<dataa1.length;j++){
							var detail = dataa1[j];
							//debugger
							if(detail.regionX!=undefined&&detail.regionX!=""&&detail.regionY!=undefined&&detail.regionY!=""&&detail.securityContentId==dataa.securityContentId){
								createMarker(detail.regionX,detail.regionY,"dv",detail.securityContentId);
							}
						}
					}
					layer.close(loadIndex);
				}
			})
			document.getElementById('dv').onclick = function (e) {
				$('.marker').remove();
				preDef(e);
				stopBubble(e);
				e = e || window.event;
				var x = e.offsetX || e.layerX, y = e.offsetY || e.layerY;
				x = ((x-10)/offWidth).toFixed(10);
				y = ((y-10)/offHeight).toFixed(10);

				var securityContentId = dataa.securityContentId;
				var makerDom = createMarker(x, y,'dv',securityContentId);
				var obj={
					regionX:x,
					regionY:y,
					securityContentId:securityContentId
				}
				$.ajax({
					url: '/workflow/secirityManager/updateDetailsInfo',
					type: 'post',
					dataType: 'json',
					data:obj,
					async:false,
					success: function (res) {
						if(res.code===0||res.code==="0"){
							//console.log(res.obj)
							//layer.closeAll();
						}
						//layer.msg(res.msg)
					}
				})
				$(makerDom).attr("securityContentId",securityContentId);
			}
			function createMarker(x, y,divName,securityContentId) {
				var isMove = false;
				x = (x*100) + '%';
				y = (y*100) + '%';
				var div = document.createElement('div');
				//div.className = 'marker'; div.style.left = (x - 3) + 'px'; div.style.top = (y - 3) + 'px';
				div.className = 'marker'; div.style.left = x; div.style.top = y;
				div.style.width = 15 + markerValue + 'px';
				div.style.height = 15 + markerValue + 'px';
				div.setAttribute('securityContentId',securityContentId);
				//拖拽
				div.onmousedown = function(ev){
					isMove = false
					//console.log("鼠标按下了");
					var e = ev || window.event;
					var offsetX = e.clientX - div.offsetLeft;
					var offsetY = e.clientY - div.offsetTop;
					//debugger
					document.onmousemove = function(ev){
						isMove = true
						//console.log("鼠标在移动");
						var e =ev || window.event;
						var l = e.clientX - offsetX;
						var t = e.clientY - offsetY;
						//限制出界
						if(l <= 0){
							l = 0;
						}
						if(l >= offWidth){
							l = offWidth;
						}
						if(t <= 0){
							t = 0;
						}
						if(t >= offHeight){
							t = offHeight;
						}
						div.style.left = l + 'px';
						div.style.top = t + 'px';
					}
					document.onmouseup = function(){
						//console.log("鼠标抬起了");
						document.onmousemove = null;
						document.onmouseup = null;
					}
				}
				div.onclick = function (e) {
					preDef(e);
					stopBubble(e);
					// 没有在移动，说明在点击
					if (isMove==false) {
						//console.log("鼠标点击了");
						layer.confirm('确定要删除选中的检查项吗？', {icon: 3, title:'提示'}, function(index){
							$.ajax({
								url: '/workflow/secirityManager/delRegionDetails?securityContentId='+dataa.securityContentId,
								type: 'get',
								dataType: 'json',
								async:false,
								success: function (res) {
									if(res.code===0||res.code==="0"){
										//layer.closeAll();
										div.remove();
										layer.msg(res.msg);
										layer.close(index);
									}
								}
							});
						})
					}
				}
				document.getElementById(divName).appendChild(div);
				return div;
			}
			$('#define').on("click",function() {
				var dataArr = [];
				$(".marker").each(function (index,element) {
					var obj={};
					var securityContentId = $(element).attr("securityContentId")
					var regionX = $(element).css('left');
					regionX = regionX.replace("px","");
					var regionY = $(element).css('top');
					regionY = regionY.replace("px","");
					obj.securityContentId = securityContentId;
					obj.regionX = (regionX/offWidth).toFixed(10);
					obj.regionY = (regionY/offHeight).toFixed(10);
					dataArr.push(obj)
				})

				if(dataArr!=undefined||dataArr.length>0){
					$.ajax({
						url: '/workflow/secirityManager/updateDetailsByJson',
						type: 'post',
						dataType: 'json',
						data:{detailsJson:JSON.stringify(dataArr)},
						async:false,
						success: function (res) {
							if(res.code===0||res.code==="0"){
								//console.log(res.obj)
								//layer.closeAll();
								layer.msg(res.msg);
							}
							window.close();
						}
					})
				}
			})
		}/*else if(layEvent2 === 'examineTest'){
			var loadIndex = layer.load(1);
			$.ajax({
				url:'/workflow/secirityManager/getDetailsInfoByRegionId?securityRegionId='+dataa.securityRegionId+'&checkliId='+dataa.checkliId,
				dataType:"json",
				type:"post",
				success:function(res){
					var dataa1 = res.data;
					if(dataa1!=undefined&&dataa1.length>0){
						for(var j=0;j<dataa1.length;j++){
							var detail = dataa1[j];
							//debugger
							if(detail.regionX!=undefined&&detail.regionX!=""&&detail.regionY!=undefined&&detail.regionY!=""&&detail.securityContentId==dataa.securityContentId){
								createMarker(detail.regionX,detail.regionY,"dv",detail.securityContentId);
							}
						}
					}
					layer.close(loadIndex);
				}
			})
			document.getElementById('dv').onclick = function (e) {
				$('.marker').remove();
				preDef(e);
				stopBubble(e);
				e = e || window.event;
				var x = e.offsetX || e.layerX, y = e.offsetY || e.layerY;
				x = ((x-10)/offWidth).toFixed(10);
				y = ((y-10)/offHeight).toFixed(10);

				var securityContentId = dataa.securityContentId;
				var makerDom = createMarker(x, y,'dv',securityContentId);
				var obj={
					regionX:x,
					regionY:y,
					securityContentId:securityContentId
				}
				$.ajax({
					url: '/workflow/secirityManager/updateDetailsInfo',
					type: 'post',
					dataType: 'json',
					data:obj,
					async:false,
					success: function (res) {
						if(res.code===0||res.code==="0"){
							//console.log(res.obj)
							//layer.closeAll();
						}
						//layer.msg(res.msg)
					}
				})
				$(makerDom).attr("securityContentId",securityContentId);
			}
			function createMarker(x, y,divName,securityContentId) {
				var isMove = false;
				x = (x*100) + '%';
				y = (y*100) + '%';
				var div = document.createElement('div');
				//div.className = 'marker'; div.style.left = (x - 3) + 'px'; div.style.top = (y - 3) + 'px';
				div.className = 'marker'; div.style.left = x; div.style.top = y;
				div.setAttribute('securityContentId',securityContentId);
				div.style.width = 15 + markerValue + 'px';
				div.style.height = 15 + markerValue + 'px';
				//拖拽
				div.onmousedown = function(ev){
					isMove = false
					//console.log("鼠标按下了");
					var e = ev || window.event;
					var offsetX = e.clientX - div.offsetLeft;
					var offsetY = e.clientY - div.offsetTop;
					//debugger
					document.onmousemove = function(ev){
						isMove = true
						//console.log("鼠标在移动");
						var e =ev || window.event;
						var l = e.clientX - offsetX;
						var t = e.clientY - offsetY;
						//限制出界
						if(l <= 0){
							l = 0;
						}
						if(l >= offWidth){
							l = offWidth;
						}
						if(t <= 0){
							t = 0;
						}
						if(t >= offHeight){
							t = offHeight;
						}
						div.style.left = l + 'px';
						div.style.top = t + 'px';
					}
					document.onmouseup = function(){
						//console.log("鼠标抬起了");
						document.onmousemove = null;
						document.onmouseup = null;
					}
				}
				div.onclick = function (e) {
					preDef(e);
					stopBubble(e);
					// 没有在移动，说明在点击
					if (isMove==false) {
						//console.log("鼠标点击了");
						layer.confirm('确定要删除选中的检查项吗？', {icon: 3, title:'提示'}, function(index){
							$.ajax({
								url: '/workflow/secirityManager/delRegionDetails?securityContentId='+dataa.securityContentId,
								type: 'get',
								dataType: 'json',
								async:false,
								success: function (res) {
									if(res.code===0||res.code==="0"){
										//layer.closeAll();
										div.remove();
										layer.msg(res.msg);
										layer.close(index);
									}
								}
							});
						})
					}
				}
				document.getElementById(divName).appendChild(div);
				return div;
			}
			$('#define').on("click",function() {
				var dataArr = [];
				$(".marker").each(function (index,element) {
					var obj={};
					var securityContentId = $(element).attr("securityContentId")
					var regionX = $(element).css('left');
					regionX = regionX.replace("px","");
					var regionY = $(element).css('top');
					regionY = regionY.replace("px","");
					obj.securityContentId = securityContentId;
					obj.regionX = (regionX/offWidth).toFixed(10);
					obj.regionY = (regionY/offHeight).toFixed(10);
					dataArr.push(obj)
				})

				if(dataArr!=undefined||dataArr.length>0){
					$.ajax({
						url: '/workflow/secirityManager/updateDetailsByJson',
						type: 'post',
						dataType: 'json',
						data:{detailsJson:JSON.stringify(dataArr)},
						async:false,
						success: function (res) {
							if(res.code===0||res.code==="0"){
								//console.log(res.obj)
								//layer.closeAll();
								layer.msg(res.msg);
							}
							window.close();
						}
					})
				}
			})
		}*/else if(layEvent3 === 'initialization1'){
			var loadIndex = layer.load(1);
			if(dataa.regionX!=undefined&&dataa.regionX!=""&&dataa.regionY!=undefined&&dataa.regionY!=""&&dataa.securityContentId==dataa.securityContentId){
				createMarker(dataa.regionX,dataa.regionY,"dv",dataa.securityContentId);
			}
			layer.close(loadIndex);

			function createMarker(x, y,divName,securityContentId) {
				x = (x*100) + '%';
				y = (y*100) + '%';
				var div = document.createElement('div');
				//div.className = 'marker'; div.style.left = (x - 3) + 'px'; div.style.top = (y - 3) + 'px';
				div.className = 'marker'; div.style.left = x; div.style.top = y;
				div.setAttribute('securityContentId',securityContentId);
				div.style.width = 15 + markerValue + 'px';
				div.style.height = 15 + markerValue + 'px';

				document.getElementById(divName).appendChild(div);
			}
			$('#define').on("click",function() {
				window.close();
			})
		}else if(layEvent4 === 'examineTest1'){
			var loadIndex = layer.load(1);
			if(dataa.regionX!=undefined&&dataa.regionX!=""&&dataa.regionY!=undefined&&dataa.regionY!=""&&dataa.securityContentId==dataa.securityContentId){
				createMarker(dataa.regionX,dataa.regionY,"dv",dataa.securityContentId);
			}
			layer.close(loadIndex);
			function createMarker(x, y,divName,securityContentId) {
				var isMove = false;
				x = (x*100) + '%';
				y = (y*100) + '%';
				var div = document.createElement('div');
				//div.className = 'marker'; div.style.left = (x - 3) + 'px'; div.style.top = (y - 3) + 'px';
				div.className = 'marker'; div.style.left = x; div.style.top = y;
				div.setAttribute('securityContentId',securityContentId);
				div.style.width = 15 + markerValue + 'px';
				div.style.height = 15 + markerValue + 'px';
				document.getElementById(divName).appendChild(div);
			}
			$('#define').on("click",function() {
				window.close();
			})
		}else{
			if(dataa!=undefined||dataa!=null){
				var loadIndex = layer.load(1);
				$.ajax({
					url:'/workflow/secirityManager/getDetailsInfoByRegionId?securityRegionId='+dataa.securityRegionId+'&checkliId='+dataa.checkliId,
					dataType:"json",
					type:"post",
					success:function(res){
						var dataa1 = res.data;
						if(dataa1!=undefined&&dataa1.length>0){
							for(var j=0;j<dataa1.length;j++){
								var detail = dataa1[j];
								//debugger
								if(detail.regionX!=undefined&&detail.regionX!=""&&detail.regionY!=undefined&&detail.regionY!=""&&detail.securityContentId==dataa.securityContentId){
									createMarker(detail.regionX,detail.regionY,"dv",detail.securityContentId);
								}
							}
						}
						layer.close(loadIndex);
					}
				})
				/*var loadIndex = layer.load(1);
				$.ajax({
					url:'/workflow/secirityManager/getDetailsInfoByRegionId?securityRegionId='+dataa.securityRegionId+'&checkliId='+dataa.checkliId,
					dataType:"json",
					type:"post",
					success:function(res){
						var dataa = res.data;
						if(dataa!=undefined&&dataa.length>0){
							for(var j=0;j<dataa.length;j++){
								var detail = dataa[j];
								//debugger
								if(detail.regionX!=undefined&&detail.regionX!=""&&detail.regionY!=undefined&&detail.regionY!=""){
									createMarker(detail.regionX,detail.regionY,"dv",detail.securityContentId);
								}
							}
						}
						layer.close(loadIndex);
					}
				})*/
			}


			function createMarker(x, y,divName,securityContentId) {
				var isMove = false;
				x = (x*100) + '%';
				y = (y*100) + '%';
				var div = document.createElement('div');
				//div.className = 'marker'; div.style.left = (x - 3) + 'px'; div.style.top = (y - 3) + 'px';
				div.className = 'marker'; div.style.left = x; div.style.top = y;
				div.style.width = 15 + markerValue + 'px';
				div.style.height = 15 + markerValue + 'px';
				div.setAttribute('securityContentId',securityContentId);
				//拖拽
				/*div.onmousedown = function(ev){
					isMove = false
					//console.log("鼠标按下了");
					var e = ev || window.event;
					var offsetX = e.clientX - div.offsetLeft;
					var offsetY = e.clientY - div.offsetTop;
					//debugger
					document.onmousemove = function(ev){
						isMove = true
						//console.log("鼠标在移动");
						var e =ev || window.event;
						var l = e.clientX - offsetX;
						var t = e.clientY - offsetY;
						//限制出界
						if(l <= 0){
							l = 0;
						}
						if(l >= offWidth){
							l = offWidth;
						}
						if(t <= 0){
							t = 0;
						}
						if(t >= offHeight){
							t = offHeight;
						}
						div.style.left = l + 'px';
						div.style.top = t + 'px';
					}
					document.onmouseup = function(){
						//console.log("鼠标抬起了");
						document.onmousemove = null;
						document.onmouseup = null;
					}
				}*/
				/*div.onclick = function (e) {
					preDef(e);
					stopBubble(e);
					// 没有在移动，说明在点击
					if (isMove==false) {
						//console.log("鼠标点击了");
						layer.open({
							type: 1,
							skin: 'layui-layer-molv', //加上边框
							area: ['70%', '80%'], //宽高
							title: '图纸',
							maxmin: true,
							btn: ['提交', '删除','取消'],
							content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
									'<div class="layui-container">\n' +
									'	<div class="layui-row">\n' +
									'		<div class="layui-col-xs12 layui-col-sm6 layui-col-md4">' +
									'   		<div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
									'   		    <div class="layui-inline" style="width: 98%;">\n' +
									'   		         <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>隐患区域</label>\n' +
									'   		         <div class="layui-input-inline" style="width: 55%;">\n' +
									'   		<input type="text" placeholder="请选择" disabled id="region" pid name="ttitle3" style="cursor: pointer;height: 38px !important;" autocomplete="off" class="layui-input">' +
									'   		<div class="eleTree ele3" lay-filter="data3" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
									//'   		             <input type="text" id="region" lay-verify="required" name="region" autocomplete="off" class="layui-input">\n' +
									'   		         </div>\n' +
									'   		    </div>\n' +
									'   		</div>\n' +
									'		</div>\n' +
									'		<div class="layui-col-xs12 layui-col-sm6 layui-col-md4">' +
									'   			<div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
									'   			    <div class="layui-inline" style="width: 98%;">\n' +
									'   			         <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>隐患项</label>\n' +
									'   			         <div class="layui-input-inline" style="width: 55%;">\n' +
									'   			             <input type="text" disabled id="hiddenDanger" pid2 lay-verify="required" style="cursor: pointer;height: 38px !important;" name="ttitle4" autocomplete="off" class="layui-input">\n' +
									//'   			<div class="eleTree ele4" lay-filter="data4" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
									'   			         </div>\n' +
									'   			    </div>\n' +
									'   			</div>\n' +
									'		</div>\n' +
									/!*'		<div class="layui-col-xs6 layui-col-sm6 layui-col-md4">' +
									'   		<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
									' 			    <div class="layui-inline" style="width: 98%;">\n' +
									' 			         <label class="layui-form-label" style="width: 30%;">图纸</label>\n' +
									' 			         <div class="layui-input-inline" style="width: 55%;">\n' +
									' 			             <img style="width: 50px; height: 50px" src="https://ns-strategy.cdn.bcebos.com/ns-strategy/upload/fc_big_pic/part-00425-2004.jpg">\n' +
									' 			         </div>\n' +
									' 			    </div>\n' +
									' 			</div>\n' +
									'		</div>\n' +*!/
									'		<div class="layui-col-xs12 layui-col-sm6 layui-col-md4">' +
									'   		<div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
									'   		    <div class="layui-inline" style="width: 98%;">\n' +
									'   		         <label class="layui-form-label" style="width: 30%;">隐患级别</label>\n' +
									'   		         <div class="layui-input-inline" style="width: 55%;">\n' +
									'   		             <input type="text" securityGrade id="dangerGrade" disabled lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input">\n' +
									'   		         </div>\n' +
									'   		<input hidden id="urls" name="urls"/>'+
									'   		<input hidden id="securityContentId" name="securityContentId"/>'+
									'   		    </div>\n' +
									'   		</div>\n' +
									'		</div>\n' +
									'	</div>\n' +
									'	<div class="layui-row">\n' +
									'		<div class="layui-col-xs12 layui-col-sm12 layui-col-md12">' +
									'   		<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
									'   		    <div class="layui-inline" style="width: 98%;">\n' +
									'   		         <label class="layui-form-label" style="width: 15%;">检查内容</label>\n' +
									'   		         <div class="layui-input-inline" style="width: 75%;">\n' +
									'   		             <textarea type="text" pid3 disabled style="width:100%;min-height: 80px !important;" id="securityDanger" lay-verify="required" name="securityDanger" autocomplete="off" class="layui-input"></textarea>\n' +
									'   		         </div>\n' +
									'   		    </div>\n' +
									'   		</div>\n' +
									'		</div>\n' +
									'		<div class="layui-col-xs12 layui-col-sm12 layui-col-md12">' +
									'  			<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
									'  			    <div class="layui-inline" style="width: 98%;">\n' +
									'  			         <label class="layui-form-label" style="width: 15%;">整改措施</label>\n' +
									'  			         <div class="layui-input-inline" style="width: 75%;">\n' +
									'  			             <textarea type="text" disabled style="width:100%;min-height: 80px !important;" id="securityDangerMeasures" lay-verify="required" name="securityDangerMeasures" autocomplete="off" class="layui-input"></textarea>\n' +
									'  			         </div>\n' +
									'  			    </div>\n' +
									'  			</div>\n' +
									'		</div>\n' +
									'		<div class="layui-col-xs12 layui-col-sm12 layui-col-md12">' +
									'   		<div class="layui-form-item" style="margin:10px 6%;display: inline-block">\n' +
									'					<div class="layui-form-item" style="width: 98%; pane="">\n' +
									'						<label class="layui-form-label" style="width:60%;">是否需要整改</label>\n' +
									'						<div class="layui-input-block" style="width: 50%;">\n' +
									'							<input type="checkbox" name="close" id="needRecification" pid5 lay-skin="switch" lay-filter="switchTest" lay-text="是|否">\n' +
									'						</div>\n' +
									'					</div>\n' +
									'   		</div>\n' +
									'		</div><br/>\n' +
									'		<div class="layui-col-xs12 layui-col-sm6 layui-col-md6" id="PeriodShow">' +
									'   		<div class="layui-form-item" style="margin:10px 0;display: inline-block;margin-left: 13%;" >\n' +
									'   		    <div class="layui-inline" style="width: 98%;">\n' +
									'   		         <label class="layui-form-label" style="width: 30%;">整改期限</label>\n' +
									'   		         <div class="layui-input-inline" style="width: 52%;">\n' +
									'   		             <input class="layui-input" style="height: 38px !important;" lay-verify="required" id="rectificationPeriod">\n' +
									'   		         </div>\n' +
									'   		    </div>\n' +
									'   		</div>\n' +
									'		</div>\n' +
									'		<div class="layui-col-xs12 layui-col-sm6 layui-col-md6" id="PersionShow">' +
									'   		<div class="layui-form-item" style="margin:10px 0;display: inline-block">\n' +
									'   		    <div class="layui-inline" style="width: 98%;">\n' +
									'   		         <label class="layui-form-label" style="width: 30%;">整改人</label>\n' +
									'   		         <div class="layui-input-inline" style="width: 55%;">\n' +
									'   		             <input class="layui-input" style="height: 38px !important;" lay-verify="required" id="rectificationPersion">\n' +
									'   		         </div>\n' +
									'   		    </div>\n' +
									'   		</div>\n' +
									'		</div>\n' +
									'		<div class="layui-col-xs12 layui-col-sm12 layui-col-md12" id="switchShow">' +
									'   		<div class="layui-form-item" style="margin:10px 6%;display: inline-block">\n' +
									'					<div class="layui-form-item" style="width: 98%; pane="">\n' +
									'						<label class="layui-form-label" style="width:60%;">是否需要验收</label>\n' +
									'						<div class="layui-input-block" style="width: 50%;">\n' +
									'							<input type="checkbox" name="close" id="needAcceptance" pid7 lay-skin="switch" lay-filter="switchTest1" lay-text="是|否">\n' +
									'						</div>\n' +
									'					</div>\n' +
									'   		</div>\n' +
									'		</div><br/>\n' +
									'		<div class="layui-col-xs12 layui-col-sm6 layui-col-md6" id="acceptanceShow">' +
									'   		<div class="layui-form-item" style="margin:10px 0;display: inline-block;margin-left: 13%;">\n' +
									'   		    <div class="layui-inline" style="width: 98%;">\n' +
									'   		         <label class="layui-form-label" style="width: 30%;">验收人</label>\n' +
									'   		         <div class="layui-input-inline" style="width: 55%;">\n' +
									'   		             <input class="layui-input" style="height: 38px !important;"  lay-verify="required" id="acceptancePersion">\n' +
									'   		         </div>\n' +
									'   		    </div>\n' +
									'   		</div>\n' +
									'		</div>\n' +
									'		<div class="layui-col-xs12 layui-col-sm12 layui-col-md12">' +
									'   		<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
									'   		    <div class="layui-inline" style="width: 98%;">\n' +
									'   		         <label class="layui-form-label" style="width: 15%;">隐患描述</label>\n' +
									'   		         <div class="layui-input-inline" style="width: 75%;">\n' +
									'   		             <textarea type="text" style="width:100%;min-height: 80px !important;" id="securityDangerDesc" lay-verify="required" name="securityDangerDesc" autocomplete="off" class="layui-input"></textarea>\n' +
									'   		         </div>\n' +
									'   		    </div>\n' +
									'   		</div>\n' +
									'		</div>\n' +
									'		<div class="layui-col-xs12 layui-col-sm12 layui-col-md12">' +
									'   		<div class="layui-input-inline" style="margin-left: 130px;">\n' +
									'   		<div id="fujians"></div>' +
									'   		 <div id="fileAll">\n' +
									'   		</div>\n' +
									'   		<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
									'   		<img src="../img/mg11.png" alt="">\n' +
									'   		<span>添加附件</span>\n' +
									'   		<input type="file" multiple id="fileupload" data-url="/upload?module=workLog" name="file">\n' +
									'   		</a>\n' +
									'   		</div>\n' +
									'		</div>\n' +
									'	</div>\n' +
									'</div>\n' +
									'</div></form>',
							success: function () {
								var tData1
								$.ajax({
									url: '/workflow/secirityManager/getDetailsInfoById?detailsInfoId='+securityContentId,
									type: 'get',
									dataType: 'json',
									async:false,
									success: function (res) {
										if(res.code===0||res.code==="0"){
											tData = res.obj;
											//layer.closeAll();
											//layer.msg(res.msg)
										}
									}
								});
								//console.log(tData1);
								//form.render("select");//初始化表单
								fileuploadFn('#fileupload', $('#fileAll'));

								laydate.render({
									elem: '#rectificationPeriod'
									, trigger: 'click'//呼出事件改成click
								});
								//var detailsId = $("#detailsId").val();
								$('#region').val(tData.securityRegionName);//检查区域
								$('#region').attr('pid',tData.securityRegionId);//检查区域id
								$('#hiddenDanger').val(tData.securityKnowledgeName);//检查项
								$('#hiddenDanger').attr('pid2',tData.securityKnowledgeId);//检查项id
								$('#dangerGrade').val(tData.securityGradeName);//隐患级别
								$('#dangerGrade').attr('securityGrade',tData.securityGrade);
								$('#securityDangerMeasures').val(tData.securityDangerMeasures);//整改措施
								$('#securityDanger').val(tData.securityDanger);//检查内容
								$('#securityDanger').attr('pid3',tData.securityDangerId);//检查内容id

								//$("#needAcceptance").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value',tData.needAcceptance); //是否需要验收
								//$('#needAcceptance').val(tData.needAcceptance);

								if(tData.needRecification===0||tData.needRecification==='0'){
									$('#needRecification').prop('checked','checked');
									$('#PeriodShow').show();
									$('#PersionShow').show();
									$('#switchShow').show();
									if(tData.needAcceptance===0||tData.needAcceptance==='0'){
										$('#needAcceptance').prop('checked','checked');
										$('#acceptanceShow').show();
									}else {
										$('#acceptanceShow').hide();
									}
								}else {
									$('#PeriodShow').hide();
									$('#PersionShow').hide();
									$('#switchShow').hide();
									$('#acceptanceShow').hide();
								}
								//$("#needRecification").attr("pid5",tData.needRecification);//是否需要整改
								$("#rectificationPeriod").val(tData.rectificationPeriod);//整改期限
								$("#rectificationPersion").attr("user_id",tData.rectificationPersion);//整改人id
								$("#rectificationPersion").val(tData.rectificationPersionName);//整改人
								//$("#needAcceptance").attr("pid7",tData.needAcceptance);//是否需要验收
								$("#acceptancePersion").attr("user_id",tData.acceptancePersion);//验收人id
								$("#acceptancePersion").val(tData.acceptancePersionName); //验收人
								$("#securityDangerDesc").val(tData.securityDangerDesc);//隐患描述
								$('#urls').val(tData.urls)//图纸位置

								//图纸位置
								if((tData.regionX!=undefined&&tData.regionX!="")&&(tData.regionY!=undefined&&tData.regionY!="")){
									$('#drawingImg').text("已标注");
								}else{
									$('#drawingImg').text("未标注");
								}

								//附件
								fileuploadFn('#fileupload', $('#fileAll'));

								var str = ''
								if(tData.attachmentList!=undefined&&tData.attachmentList.length>0){
									for(var i=0;i<tData.attachmentList.length;i++){
										str+='<div class="dech" deUrl="' +tData.attachmentList[i].attUrl + '"><a href="/download?' + tData.attachmentList[i].attUrl + '" NAME="' + tData.attachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + tData.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + tData.attachmentList[i].aid + '@' + tData.attachmentList[i].ym + '_' + tData.attachmentList[i].attachId +',"></div>'
									}
								}else{
									str='';
								}
								$('#fileAll').append(str)

								$("#securityContentId").val(tData.securityContentId);

								Array.prototype.remove = function(val) {
									var index = this.indexOf(val);
									if (index > -1) {
										this.splice(index, 1);
									}
								};

								$('#drawingImg').on("click",function() {
									$.popWindow("/workflow/secirityManager/selectDrawing?layEvent1=initialization&securityContentId="+tData.securityContentId);
								})
								form.on('switch(switchTest)', function(data){
									if(data.elem.checked == true){
										isShow = true;
										$('#PeriodShow').show();
										$('#PersionShow').show();
										$('#switchShow').show();
									}else{
										isShow = false;
										isShow1 = false;
										$('#PeriodShow').hide();
										$('#PersionShow').hide();
										$('#switchShow').hide();
										//$('#acceptanceShow').hide();
										//$('#needAcceptance').next().removeClass('layui-form-onswitch');

									}
								});
								form.on('switch(switchTest1)', function(data){
									if(data.elem.checked == true){
										isShow1 = true;
										$('#acceptanceShow').show();
									}else{
										isShow1 = false;
										$('#acceptanceShow').hide();
									}
								});

								form.render();//初始化表单
							},
							yes: function (index, layero) {
								var securityRegionId = $("#region").attr("pid");//检查区域id
								var securityRegionName = $("#region").val();//检查区域
								var securityKnowledgeId = $("#hiddenDanger").attr("pid2");//检查项id
								var securityKnowledgeName = $("#hiddenDanger").val();//检查项
								//隐患照片
								//var attachmentId = $("#attachmentId").val();
								//var attachmentName = $("#attachmentName").val();
								var urls = $('#urls').val();//图纸位置
								var securityGrade = $("#dangerGrade").attr("securityGrade");
								var securityGradeName = $("#dangerGrade").val();//隐患级别
								var securityDangerMeasures = $("#securityDangerMeasures").val();//整改措施
								var securityDangerId = $("#securityDanger").attr("pid3");//检查内容id
								var securityDanger = $("#securityDanger").val();//检查内容
								//是否需要整改
								if(isShow == true){
									var needRecification = 0;
									//是否需要验收
									if(isShow1 == true){
										var needAcceptance = 0;
									}else{
										var needAcceptance = 1;
									}
								}else{
									var needRecification = 1;
									var needAcceptance = 1;
								}
								//var needAcceptance = $("#needAcceptance").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value'); //是否需要验收
								var rectificationPeriod = $("#rectificationPeriod").val();//整改期限
								var rectificationPersion = $("#rectificationPersion").attr("user_id");//整改人id
								var rectificationPersionName = $("#rectificationPersion").val();//整改人
								var acceptancePersion = $("#acceptancePersion").attr("user_id");//验收人id
								var acceptancePersionName = $("#acceptancePersion").val(); //验收人
								var securityDangerDesc = $("#securityDangerDesc").val();//隐患描述
								//附件
								var attachmentId = '';
								var attachmentName = '';
								for (var i = 0; i < $('#fileAll .dech').length; i++) {
									attachmentId += $('#fileAll .dech').eq(i).find('input').val();
									attachmentName += $('#fileAll a').eq(i).attr('name');
								}
								var securityContentId = $("#securityContentId").val();

								var checkFlag = 1;

								if(rectificationPersion!=undefined||rectificationPersion!=null){
									if(rectificationPersion.substring(rectificationPersion.length-1,rectificationPersion.length)==","){
										rectificationPersion = rectificationPersion.substring(0,rectificationPersion.length-1);
									}
								}

								if(acceptancePersion!=undefined||acceptancePersion!=null){
									if(acceptancePersion.substring(acceptancePersion.length-1,acceptancePersion.length)==","){
										acceptancePersion = acceptancePersion.substring(0,acceptancePersion.length-1);
									}
								}

								if(rectificationPersionName!=undefined||rectificationPersionName!=null){
									if(rectificationPersionName.substring(rectificationPersionName.length-1,rectificationPersionName.length)==","){
										rectificationPersionName = rectificationPersionName.substring(0,rectificationPersionName.length-1);
									}
								}

								if(acceptancePersionName!=undefined||acceptancePersionName!=null){
									if(acceptancePersionName.substring(acceptancePersionName.length-1,acceptancePersionName.length)==","){
										acceptancePersionName = acceptancePersionName.substring(0,acceptancePersionName.length-1);
									}
								}

								var details = {
									securityRegionId:securityRegionId,
									securityRegionName:securityRegionName,
									securityKnowledgeId:securityKnowledgeId,
									securityKnowledgeName:securityKnowledgeName,
									attachmentId:attachmentId,
									attachmentName:attachmentName,
									securityGrade:securityGrade,
									securityGradeName:securityGradeName,
									securityDangerMeasures:securityDangerMeasures,
									securityDanger:securityDanger,
									securityDangerId:securityDangerId,
									//needAcceptance:needAcceptance,
									rectificationPeriod:rectificationPeriod,
									rectificationPersion:rectificationPersion,
									rectificationPersionName:rectificationPersionName,
									acceptancePersion:acceptancePersion,
									acceptancePersionName:acceptancePersionName,
									securityDangerDesc:securityDangerDesc,
									attachmentId:attachmentId,
									attachmentName:attachmentName,
									securityContentId:securityContentId,
									urls:urls,
									needRecification:needRecification,
									needAcceptance:needAcceptance,
									checkFlag:1
								}
								var details2 = {
									//needAcceptance:needAcceptance,
									rectificationPeriod:rectificationPeriod,
									rectificationPersion:rectificationPersion,
									rectificationPersionName:rectificationPersionName,
									acceptancePersion:acceptancePersion,
									acceptancePersionName:acceptancePersionName,
									securityDangerDesc:securityDangerDesc,
									attachmentId:attachmentId,
									attachmentName:attachmentName,
									securityContentId:securityContentId,
									urls:urls,
									needRecification:needRecification,
									needAcceptance:needAcceptance,
									checkFlag:1
								}
								//debugger
								//detailsInitData2.push(details);
								$.ajax({
									url:'/workflow/secirityManager/updateDetailsInfo',
									type: 'post',
									dataType:'json',
									data:details2,
									success:function(res){
										if(res.code===0||res.code==="0"){
											//layer.closeAll();
											if(parent.opener && parent.opener.detailsInitData2){
												for(var i = 0; i <= parent.opener.detailsInitData2.length; i++){
													if(parent.opener.detailsInitData2[i].securityContentId == securityContentId){
														countt = i;
														break;
													}
												}
												if(countt!=null){
													parent.opener.detailsInitData2[countt] = details;
												}
												parent.opener.detailsInit2.reload({
													url:'',data:parent.opener.detailsInitData2
													,done:function(d){
														layer.close(index)
													}
												});
											}
											layer.close(index);
										}
										layer.msg(res.msg)
									}
								})
							}
							,btn2: function(index, layero){
								$.ajax({
									url: '/workflow/secirityManager/delRegionDetails?securityContentId='+securityContentId,
									type: 'get',
									dataType: 'json',
									async:false,
									success: function (res) {
										if(res.code===0||res.code==="0"){
											//layer.closeAll();
											div.remove();
											layer.msg(res.msg);
											layer.close(index);
										}
									}
								});
							}
							,btn3: function(index, layero){
								layer.close(index);
							}
						});
					}
				}*/

				document.getElementById(divName).appendChild(div);
				return div;
			}
			/*document.getElementById('dv').onclick = function (e) {
				preDef(e);
				e = e || window.event;
				//debugger
				var x = e.offsetX || e.layerX, y = e.offsetY || e.layerY;
				x = ((x-10)/offWidth).toFixed(10);
				y = ((y-10)/offHeight).toFixed(10);
				layer.open({
					type: 1,
					skin: 'layui-layer-molv', //加上边框
					area: ['50%', '80%'], //宽高
					title: '检查内容',
					maxmin: true,
					page:true,
					btn: ['确定', '取消'],
					content: '<div style="width: 88%;margin: auto;"><table id="formTable3" lay-filter="formTable3"></table></div>',
					success: function () {
						detailsInit3 = table.render({
							elem: '#formTable3'
							,page:true
							//,data:dataa1
							,url:'/workflow/secirityManager/getDetailsInfoByRegionId?region=region&securityRegionId='+dataa.securityRegionId+'&checkliId='+dataa.checkliId
							//,toolbar:'#formTable1toolbar3'
							, cols:[[
								{type: 'radio'}
								,{type: 'numbers',title:'序号',width:60}
								,{field: 'securityKnowledgeName', title: '检查项'}
								,{field: 'securityDanger', title: '检查内容'}
								,{field: 'securityDangerMeasures', title: '整改措施'}
							]],
							done:function(obj, curr, count){
								detailsInitData3 = obj.data;
							}
						});
						form.render();//初始化表单
					},
					yes: function (index, layero) {
						var chechData = table.checkStatus("formTable3").data;
						if(chechData.length==1){
							var securityContentId = chechData[0].securityContentId;
							var makerDom = createMarker(x, y,'dv',securityContentId);
							var obj={
								regionX:x,
								regionY:y,
								securityContentId:securityContentId
							}
							$.ajax({
								url: '/workflow/secirityManager/updateDetailsInfo',
								type: 'post',
								dataType: 'json',
								data:obj,
								success: function (res) {
									if(res.code===0||res.code==="0"){
										//console.log(res.obj)
										//layer.closeAll();
									}
									//layer.msg(res.msg)
								}
							})
							$(makerDom).attr("securityContentId",securityContentId);
							layer.close(index);
						}else{
							layer.msg("请选择至少一条");
						}

					},
					btn2:function(index, layero){
						//$(makerDom).remove();
						layer.close(index);
					}
				});
			}*/
			//console.log(detailsInitData3);
			form.render();//初始化表单

			$('#define').on("click",function() {
				window.close();
				/*var dataArr = [];
				$(".marker").each(function (index,element) {
					var obj={};
					var securityContentId = $(element).attr("securityContentId")
					var regionX = $(element).css('left');
					regionX = regionX.replace("px","");
					var regionY = $(element).css('top');
					regionY = regionY.replace("px","");
					obj.securityContentId = securityContentId;
					obj.regionX = (regionX/offWidth).toFixed(10);
					obj.regionY = (regionY/offHeight).toFixed(10);
					dataArr.push(obj)
				})

				if(dataArr!=undefined||dataArr.length>0){
					$.ajax({
						url: '/workflow/secirityManager/updateDetailsByJson',
						type: 'post',
						dataType: 'json',
						data:{detailsJson:JSON.stringify(dataArr)},
						async:false,
						success: function (res) {
							if(res.code===0||res.code==="0"){
								//console.log(res.obj)
								//layer.closeAll();
								layer.msg(res.msg);
							}
							window.close();
						}
					})
				}*/
			})
		}
	})

	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}

	//浏览器兼容
	//阻止默认行为
	function preDef(e){
		if(e.preventDefault){
			e.preventDefault();
		}else{
			window.event.returnValue = false;
		}
	}
	//跨浏览器兼容
	//阻止冒泡
	function stopBubble(e){
		//e是事件对象
		if(e.stopPropagation){
			e.stopPropagation();
		}else{
			e.cancelBubble = true;
		}
	}
</script>
</html>

