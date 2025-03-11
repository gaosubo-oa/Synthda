<%--需把局部样式归并为一个通用或符合公告管理的公共样式，
接口对完需调整--%>

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
<head lang="en">
	<meta charset="UTF-8">
	<title>二维码打印</title>
	<link rel="stylesheet" type="text/css" href="../css/news/center.css"/>
	<link rel="stylesheet" type="text/css" href="../lib/pagination/style/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="../css/base.css" />
	<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
	<script src="../js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
	<script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="../css/news/new_news.css"/>
	<!-- word文本编辑器 -->
	<script src="../lib/ueditor/ueditor.config.js" type="text/javascript" charset="utf-8"></script>
	<script src="../lib/ueditor/ueditor.all.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../lib/laydate/laydate.js"></script>
	<script src="../../lib/layer/layer.js?20201106"></script>
	<script src="/js/jquery/jquery.form.min.js"></script>
	<script type="text/javascript" src="/lib/qrcode.js"></script>
	<script src="/js/jquery/jquery.jqprint-0.3.js"></script>
	<style>

		/*.fl{*/
		/*	float: left;*/
		/*	margin: 10px;*/
		/*}*/
		.innerTop{
			display: flex;
			justify-content: center;
			margin-top: 25px;
		}
		.print{
			border-radius: 6px;
			cursor:pointer;
			width:100px;
			color:#fff;
			background: #1169d8;
			text-align: center;
			line-height: 28px;
			height: 28px;
		}
		#pageCount{
			padding:0 5px;
			color:#00A5E4;
		}
		.innerTop div{
			margin-right: 20px;
		}
		.tiaoZ{
			margin: 5px auto;
		}
		.submit{
			margin: 0;
			border-radius: 6px;
			cursor: pointer;
			width: 60px;
			color: #fff;
			background: #1169d8;
			text-align: center;
			line-height: 28px;
			height: 28px;
			margin-right: 5px;
		}
	</style>
	<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body>
<div class="top">
	<div class="innerTop">
		<div>所在部门:
			<input type="text" name="" id="deptment" user_id=""  style="width: 110px;height: 22px;" disabled>
			<a href="javascript:;" id="selectDept" style="color:#1772c0"><fmt:message code="global.lang.add"/></a>
			<a href="javascript:;" id="clearDept" style="color:#1772c0"><fmt:message code="global.lang.empty"/></a>
		</div>
		<div style="margin-left: 10px;width:175px">所在位置:
			<select  name="currrntLocation" id="currrntLocation" onchange="danwei()">
			</select>
			<input type="text" id="units" name="units" style="width: 87px;margin-left: -114px;height: 22px;border: 1px solid #c0c0c0;">
		</div>
		<div id="cx" class="submit">
			<fmt:message code="global.lang.query" />
		</div>
		<div class="fl" style="position: relative;margin: 4px">请选择规格:</div>
		<select name="format " id="format" class="fl" style="margin-right: 20px">
			<option value="0" selected>纵向打印</option>
			<option value="1">横向打印</option>
		</select>
		<div id="print" class="fl print">打印二维码</div>
		<div class="fl" style="    margin-top: 4px;">共<span id="pageCount"></span>页</div>
		<div id="queryAll" class="fl print">查询全部</div>
		<div id="conditional" class="fl print">条件查询全部</div>
	</div>
</div>

<div class="main"  style="width: 88%;margin:0 auto;padding-left:2%;overflow: hidden;font-size: 14px;padding-bottom: 30px;">
	<div class="QR_content">

	</div>
</div>
<div class="right" style="margin-right: 10%;">
	<!-- 分页按钮-->
	<div class="M-box3" id="dbgz_pagesd"></div>
</div>


</body>
</html>

<script>
	$.ajax({
		type:'get',
		url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
		dataType:'json',
		success:function (res) {
			if(res.object.length!=0){
				var data=res.object[0]
				if (data.paraValue!=0){
					$('.innerTop').after('<span style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 12pt;position: absolute;top: 30px;left: 30px;"> 机密级★ </span>')
				}
			}
		}
	})
	function danwei(){
		var val=$("#currrntLocation").val();
		var text = $("option[value="+val+"]").text();
		$("#units").val(text);
		$('#units').focus();
	}
	//所在部门
	$("#selectDept").on("click", function () {
		dept_id = 'deptment';
		$.popWindow("../../common/selectDept?0");
	});
	function clearDept() {
		$('#deptment').removeAttr('deptid');
		$('#deptment').attr('dataid', '');
		$('#deptment').removeAttr('deptno');
		$('#deptment').val('');
	}

	$('#clearDept').on("click",function () {
		clearDept();
	});
	//所在位置
	$.ajax({
		type: 'get',
		url: "/code/getCode",
		data: {"parentNo": "LOCATION_ADDRESS"},
		success: function (data) {
			$('#currrntLocation').html('');
			for (var x = 0; x < data.obj.length; x++) {
				$("#currrntLocation").append("<option value=" + data.obj[x]["codeNo"] + ">" + data.obj[x]["codeName"] + "</option>")
			}
		}
	});
	//查询
	// layui.use
	$('.submit').on("click",function(){
		var deptName = $('#deptment').val();
		if(deptName.charAt(deptName.length-1) == ","){
			deptName = deptName.substring(0,deptName.length-1);
		}
		// alert(deptName)
		var deptId= $('#deptment').attr('deptid')
		if(deptId == undefined){
			deptId = ''
		}else{
				var reg=/,$/gi
					deptId=deptId.replace(reg,"")
		}
			var data1={
			 	deptId:deptId,
			 	// deptName:deptName,
			 	currrntLocation:$("#units").val(),
			 	page:1,//当前处于第几页
			 	pageSize:20,//一页显示几条
			 	useFlag:true,
			 }
		queryInit(data1)
	})


	var pageCount;
	var logoImgUrl ='/img/fixAssets/logo.png' ;

	$(function () {
		data={
			page:1,//当前处于第几页
			pageSize:20,//一页显示几条
			useFlag:true
		};

		$.ajax({
			url:"/eduFixAssets/getSetting",
			type:"get",
			dataType:"json",
			success:function(res){
				if(res.flag){
					if(res.object.logoUrl){
						logoImgUrl = '/xs?'+res.object.logoUrl;
					}
				}

				//获取固定资产信息生成二维码
				//code12();
				queryInit(data);
			}
		});

	});

	//一张12个
	function code12(url,data,type){
		$.ajax({
			url:url,   //"/eduFixAssets/selFixAssetsAll"
			data:data,
			type:"get",
			dataType:"json",
			success:function(res){
				var str = "";
				var data = ""
				if(type == '1'){
					data = res.obj;
				}else{
					data = res.object;
				}
				pageCount = Math.ceil(data.length/20);
				$("#pageCount").html(pageCount);

				for(i=0;i<data.length;i++){
					var id = data[i].id;
					if(data[i].id.length>12)
						id = data[i].id.substr(12,data[i].id.length)

					str+="<div class='code' style='float: left;width:250px;height:135px;padding: 5px;' >" +
							"<img width='245px' src='"+logoImgUrl+"'>"+
							"<div style='border: 1px solid black;float:left;font-size: 16px;color: black;margin-top: 3px;'>"+
							"<div style='float: left'>"+
							"<div style='text-align: left;width:160px;overflow: hidden;'>固定资产</div>"+
							"<div style='text-align: left;width:160px;overflow: hidden;'>编号："+id+"</div>" +
							"<div style='text-align: left;width:160px;overflow: hidden;'>名称："+data[i].assetsName+"</div>" +
							"</div>"+
							"<div style='display: inline-block;float: right;margin:2px;' id='showQRCode"+i+"'></div>" +
							"</div>" +
							"</div>"

				}
				$(".QR_content").html(str)

				for(i=0;i<data.length;i++){

					var createrTime = data[i].createrTime;
					var id = data[i].id;
					var companyId = data[i].companyId;
					var obj ={"mark":"fixAssets","id":id,"createrTime":createrTime,"companyId":companyId};
					var text = JSON.stringify(obj);
					var qrcode = new QRCode(document.getElementById("showQRCode"+i), {
						width : 80,//设置宽高
						height : 80,
						text:text
					});
				}

				if($("select[name='format'] option:selected").val()==0){
					$('.code').css("padding","5px");
				}else{
					$('.code').css("padding","16.5px 5px");
				}
				$(".right").css("display","none")

			}
		})
	}
	function code18(){
		//一张18个
		$.ajax({
			url:"/eduFixAssets/selFixAssetsAll",
			type:"get",
			dataType:"json",
			success:function(res){
				var data = res.object;
				var str = "";
				pageCount = Math.ceil(data.length/20);
				$("#pageCount").html(pageCount);
				for(i=0;i<data.length;i++){
					str+="<div class='code' style='float: left;width:180px;height:170px;' >" +
							"<div style='margin:10px 40px;' id='showQRCode"+i+"'></div>" +
							"<div style='text-align: center;width:180px'>"+data[i].id+"</div>" +
							"<div style='text-align: center;width:180px'>"+data[i].assetsName+"</div>" +
							"</div>"

				}
				$(".main").html(str)

				for(i=0;i<data.length;i++){

					var createrTime = data[i].createrTime;
					var id = data[i].id;
					var companyId = data[i].companyId;
					var obj ={"mark":"fixAssets","id":id,"createrTime":createrTime,"companyId":companyId};
					var text = JSON.stringify(obj);
					var qrcode = new QRCode(document.getElementById("showQRCode"+i), {
						width : 100,//设置宽高
						height : 100,
						text:text
					});
				}


			}
		})
	}

	function queryInit(condition) {
		var ajaxPage={
			data:condition,
			page:function () {
				var me=this;
				$.ajax({
					url:"/eduFixAssets/selectEduFixAssets",
					type:"get",
					dataType:"json",
					data:me.data,
					success:function(res){
						var data = res.obj;
						var str = "";

						for(i=0;i<data.length;i++){
							var id = data[i].id;
							if(data[i].id.length>12)
								id = data[i].id.substr(12,data[i].id.length)

							str+="<div class='code tiaoZ' style='float: left;width:250px;padding: 5px;' >" +
									"<img width='245px' src='"+logoImgUrl+"'>"+
									"<div style='border: 1px solid black;float:left;font-size: 16px;color: black;margin-top: 3px;'>"+
									"<div style='float: left'>"+
									"<div style='text-align: left;width:160px;overflow: hidden;'>固定资产</div>"+
									"<div style='text-align: left;width:160px;overflow: hidden;'>编号："+id+"</div>" +
									"<div style='text-align: left;width:160px;overflow: hidden;'>名称："+data[i].assetsName+"</div>" +
									"</div>"+
									"<div style='display: inline-block;float: right;margin:2px;' id='showQRCode"+i+"'></div>" +
									"</div>" +
									"</div>"

						}
						$(".QR_content").html(str);

						me.pageTwo(res.totleNum,me.data.pageSize,me.data.page);

						// 共多少页显示
						pageCount = Math.ceil(res.totleNum/20);
						$("#pageCount").html(pageCount);

						// 二维码生成
						for(i=0;i<data.length;i++){

							var createrTime = data[i].createrTime;
							var id = data[i].id;
							var companyId = data[i].companyId;
							var obj ={"mark":"fixAssets","id":id,"createrTime":createrTime,"companyId":companyId};
							var text = JSON.stringify(obj);
							var qrcode = new QRCode(document.getElementById("showQRCode"+i), {
								width : 80,//设置宽高
								height : 80,
								text:text
							});
						}

						if($("select[name='format'] option:selected").val()==0){
							$('.code').css("padding","5px");
						}else{
							$('.code').css("padding","16.5px 5px");
							$('.code').css('height','140px')
						}

					}
				})

			},
			pageTwo:function (totalData, pageSize,indexs) {
				var mes=this;
				$('#dbgz_pagesd').pagination({
					totalData: totalData,
					showData: pageSize,
					jump: true,
					coping: true,
					homePage:'',
					endPage: '',
					current:indexs||1,
					callback: function (index) {
						mes.data.page=index.getCurrent();
						mes.page();
					}
				});
			}
		}
		ajaxPage.page();
	}

	$("#format").on("change",function(){
		if($("select[name='format'] option:selected").val()==0){
			$('.code').css("padding","5px");
		}else{
			$('.code').css("padding","16.5px 5px");
			$('.code').css('height','140px')
		}

	})

	// 点击查询全部
	$("#queryAll").on("click",function () {
		var url = '/eduFixAssets/selFixAssetsAll'
		code12(url,'','');

	});

	$('#conditional').on("click",function(){
		var deptName = $('#deptment').val();
		var deptId= $('#deptment').attr('deptid')
		if(deptId == undefined){
			deptId = ''
		}else{
			var reg=/,$/gi
			deptId=deptId.replace(reg,"")
		}
		deptId=deptId.replace(reg,"")
		if(deptName.charAt(deptName.length-1) == ","){
			deptName = deptName.substring(0,deptName.length-1);
		}
		var url = '/eduFixAssets/selectEduFixAssets'
		var data = {
			deptId:deptId,
			currrntLocation:$("#units").val(),
			useFlag:false,
		}
		code12(url,data,1);
	})


	//点击打印
	$("#print").on("click",function(){
		$('.QR_content').jqprint({
			debug: false,
			importCSS: true,
			printContainer: true,
			operaSupport: false
		});
	})

</script>
