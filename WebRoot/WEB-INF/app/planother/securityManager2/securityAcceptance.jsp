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
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>安全验收</title>
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
	<%--<script type="text/javascript" src="../../js/common/fileupload.js"></script>--%>
	<style>
		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
		}
		.mbox{
			padding: 0px;
		}
		.inbox{
			padding: 5px;
			padding-right: 30px;
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
		.layui-form-select dl dd{
			height: 32px;
			line-height: 32px;
		}
		.layui-form-select .layui-select-title .layui-input{
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


		.container {
			position: relative;
			width: 100%;
			height: 100%;
			padding: 15px 0 10px;
			box-sizing: border-box;
		}

		.wrapper {
			position: relative;
			width: 100%;
			height: 100%;
			padding: 0 8px;
			box-sizing: border-box;
		}

		.wrap_left {
			position: relative;
			float: left;
			width: 230px;
			height: 100%;
			padding-right: 10px;
			box-sizing: border-box;
		}

		.wrap_left h2 {
			line-height: 35px;
			text-align: center;
		}

		.wrap_left .left_form {
			position: relative;
			overflow: hidden;
		}

		.left_form .layui-input {
			height: 35px;
			margin: 10px 0;
			padding-right: 25px;
		}

		.tree_module {
			position: absolute;
			top: 90px;
			right: 10px;
			bottom: 0;
			left: 0;
			overflow: auto;
			box-sizing: border-box;
		}

		.eleTree-node-content {
			overflow: hidden;
			word-break: break-all;
			white-space: nowrap;
			text-overflow: ellipsis;
		}

		.search_icon {
			position: absolute;
			top: 10px;
			right: 0;
			height: 35px;
			width: 25px;
			padding-top: 8px;
			text-align: center;
			cursor: pointer;
			box-sizing: border-box;
		}

		.search_icon:hover {
			color: #0aa3e3;
		}

		.wrap_right {
			position: relative;
			height: 100%;
			margin-left: 230px;
			overflow: auto;
		}

		.query_module .layui-input {
			height: 35px;
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
	<input type="hidden" id="leftId" class="layui-input">
	<div class="wrapper">
		<div class="wrap_left">
			<h2 style="text-align: center;line-height: 35px;">安全验收</h2>
			<div class="left_form">
				<div class="search_icon">
					<i class="layui-icon layui-icon-search"></i>
				</div>
				<input type="text" name="title" id="search_project" placeholder="项目名称" autocomplete="off" class="layui-input"/>
			</div>
			<div class="tree_module">
				<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
			</div>
		</div>
		<div class="wrap_right">
			<div class="query_module layui-form layui-row" style="position: relative">
				<%--表格上方搜索栏--%>
				<form class="layui-form" action="" style="height: 40px">
					<div class="demoTable" style="height: 40px" >
						<label style="float: left;height: 40px;line-height: 40px;margin: 0 10px;padding: 0 10px">查询字段</label>
						<div class="layui-input-inline" style="float:left;margin-top: 4px">
							<select name="serchSelect" id="serchSelect" lay-filter="columnName" placeholder="请选择" lay-search="" style="height: 10px">
								<option value="0">请选择查询字段</option>
								<option value="projectId">项目名称</option>
								<option value="planName">检查计划名称</option>
								<option value="securityKnowledgeId">隐患项</option>
								<option value="securityRegionId">隐患区域</option>
								<option value="rectificationPersion">整改人</option>
							</select>
						</div>
						<div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
							<div id="selha">
								<input type="text" id="test11"  disabled name="test11" placeholder="请选择" autocomplete="off" class="layui-input">
							</div>
							<div id="selha1" style="display: none">
								<select id="projectId" name="projectId" ></select>
							</div>
							<div id="selha2" style="display: none">
								<input class="layui-input" id="planName" autocomplete="off"  name="planName"  style="height: 38px;margin-left: 6px;">

							</div>
							<div id="selha3" style="display: none">
								<input type="text" id="securityKnowledgeId" pid name="securityKnowledgeId" placeholder="请选择" autocomplete="off" class="layui-input" style="height: 38px;margin-left: 6px;">
								<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:5px;width: 100%;"></div>
							</div>
							<div id="selha4" style="display: none; width:400px">
								<div style="height: 38px;margin-left: 6px;width: 47%;position: relative">
									<select id="projectId1" name="projectId1" ></select>
								</div>
								<input class="layui-input" id="securityRegionId" pid3 autocomplete="off"  name="securityRegionId" placeholder="请选择区域" style="height: 38px;width: 47%;margin-left: 6px;position: absolute;left:202px;top: 0px;">
								<div class="eleTree eleb4 region" lay-filter="dataX" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:206px;width: 47%;"></div>
							</div>
							<div id="selha5" style="display: none">
								<input class="layui-input" id="rectificationPersion" autocomplete="off"  name="rectificationPersion" style="height: 38px;margin-left: 6px;">
							</div>
						</div>
						<div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
							<a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="float:left;height:32px;line-height: 32px;margin-left: 10px">搜索</a>
						</div>
						<div class="layui-input-inline" style="float:left;margin-top: 4px;margin-left: 2%;">
							<select name="serchSelect1" id="serchSelect1" lay-filter="columnName1" placeholder="请选择" lay-search="" style="height: 10px">
								<option value="1">未验收</option>
								<option value="2">已验收未提交</option>
								<option value="3">已验收已提交</option>
								<option value="4">已退回</option>
								<option selected value="5">查询全部</option>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div style="position: relative">
				<div class="table_box"  >
					<table id="Settlement" lay-filter="SettlementFilter"></table>
				</div>
				<div class="no_data" style="text-align: center;">
					<div class="no_data_img" style="margin-top:12%;">
						<img style="margin-top: 2%;" src="/img/noData.png">
					</div>
					<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧项目</p>
				</div>
			</div>
		</div>
	</div>
</div>


<%--<script type="text/html" id="toolbar">
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" lay-event="submit" style="width: 60px">同意</button>
		<button class="layui-btn layui-btn-sm" lay-event="goback" style="width: 60px">退回</button>
		<button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 60px">导入</button>
		<button class="layui-btn layui-btn-sm" lay-event="export" style="width: 60px">导出</button>
	</div>
</script>--%>
<script type="text/html" id="toolbar">
	<div class="layui-btn-container">
		{{#  if(authorityObject && authorityObject['33']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="submit" style="width: 60px">同意</button>
		{{#  } }}
		{{#  if(authorityObject && authorityObject['25']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="goback" style="width: 60px">退回</button>
		{{#  } }}
		{{#  if(authorityObject && authorityObject['02']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 60px">导入</button>
		{{#  } }}
		{{#  if(authorityObject && authorityObject['03']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="export" style="width: 60px">导出</button>
		{{#  } }}
	</div>
</script>
<script type="text/html" id="barOperation">
	{{#  if(d.recificationStatus == 2||d.recificationStatus == 3){ }}
	<a class="layui-btn layui-btn-xs" lay-event="check" style="background-color: #666;">查看详情</a>
	{{#  } }}
	{{#  if(d.recificationStatus != 2&&d.recificationStatus != 3){ }}
	<a class="layui-btn layui-btn-xs" lay-event="check" >安全验收</a>
	{{#  } }}

</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
	var recificationStatus_1 = '1,3';
	var securityInfoDate1;
	var user_id;
	var detailsInit;
	var detailsInitData=[];
	var detailsInit2;
	var detailsInitData2=[];
	var dept_id;
	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}
	var columnId = parent.columnTrId;//getUrlParam('columnId');
	var SettlementTable;

	layui.use(['table','layer','form','element','eleTree','upload','laydate'], function() {
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		var eleTree = layui.eleTree;
		var element = layui.element;
		var $ = layui.jquery;
		var upload = layui.upload;
		var laydate = layui.laydate;


		form.on('select(columnName)',function (data) {
			if(data.value=="projectId") {
				$("#selha1").show();
				$("#selha2").hide();
				$("#selha3").hide();
				$("#selha4").hide();
				$("#selha5").hide();
				$("#selha").hide();
			}else if(data.value=="planName"){
				$("#selha1").hide();
				$("#selha2").show();
				$("#selha3").hide();
				$("#selha4").hide();
				$("#selha5").hide();
				$("#selha").hide();
			}else if(data.value=="securityKnowledgeId"){
				$("#selha1").hide();
				$("#selha2").hide();
				$("#selha3").show();
				$("#selha4").hide();
				$("#selha5").hide();
				$("#selha").hide();
			}else if(data.value=="securityRegionId"){
				$("#selha1").hide();
				$("#selha2").hide();
				$("#selha3").hide();
				$("#selha4").show();
				$("#selha5").hide();
				$("#selha").hide();
			}else if(data.value=="rectificationPersion"){
				$("#selha1").hide();
				$("#selha2").hide();
				$("#selha3").hide();
				$("#selha4").hide();
				$("#selha5").show();
				$("#selha").hide();
			}else{
				$("#selha1").hide();
				$("#selha2").hide();
				$("#selha3").hide();
				$("#selha4").hide();
				$("#selha5").hide();
				$("#selha").show();
			}
		})

		form.on('select(columnName1)',function (data) {
			if(data.value=='1'){
				recificationStatus_1 = '1';
				table.reload("Settlement",{
					url:'/workflow/secirityManager/getDetailInfo?isRecification=false&acceptanceFlag=0&recificationStatus=1'
				});
			}else if(data.value=='2'){
				recificationStatus_1 = '1';
				table.reload("Settlement",{
					url:'/workflow/secirityManager/getDetailInfo?isRecification=false&acceptanceFlag=1&recificationStatus=1'
				});
			}else if(data.value=='3'){
				recificationStatus_1 = '3';
				table.reload("Settlement",{
					url:'/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus=3'
				});
			}else if(data.value=='4'){
				recificationStatus_1 = '2';
				table.reload("Settlement",{
					url:'/workflow/secirityManager/getDetailInfo?isRecification=false&acceptanceFlag=1&recificationStatus=2'
				});
			}else if(data.value=='5'){
				recificationStatus_1 = '1,3';
				table.reload("Settlement",{
					url:'/workflow/secirityManager/getDetailInfo?isRecification=false&acceptanceFlag=0,1&recificationStatus=1,2,3'
				});
			}
		})

		//渲染项目名称
		var $select2 = $("#projectId");
		var optionStr2 = '<option value="">请选择</option>';
		$.ajax({ //查询文档等级
			url: '/ProjectInfo/selectProPlus?projOrgId=&useflag=false',
			type: 'get',
			dataType: 'json',
			async:false,
			success: function (res) {
				var data=res.data
				if(data!=undefined&&data.length>0){
					for(var i=0;i<data.length;i++){
						optionStr2 += '<option value="' + data[i].projectId + '">' + data[i].projectName + '</option>'
					}
				}
			}
		})
		$select2.html(optionStr2);

		//渲染隐患项

		var el;
		$("[name='securityKnowledgeId']").on("click",function (e) {
			//debugger
			e.stopPropagation();
			if(!el){
				el=eleTree.render({
					elem: '.ele2',
					url:'/workflow/secirityManager/getSecurityByType?parent=0',
					expandOnClickNode: false,
					highlightCurrent: true,
					showLine:true,
					showCheckbox: false,
					checked: false,
					lazy: true,
					load: function(data,callback) {
						$.post('/workflow/secirityManager/getSecurityByType?parent='+data.id,function (res) {
							callback(res.data);//点击节点回调
						})
					},
					done: function(res){
						if(res.data.length == 0){
							$(".ele2").html('<div style="text-align: center">暂无数据</div>');
						}
					}
				});
			}
			$(".ele2").slideDown();
		})
		$(document).on("click",function() {
			$(".ele2").slideUp();
		})
		//节点点击事件
		eleTree.on("nodeClick(data2)",function(d) {
			var parData1 = d.data.currentData;
			var str111="";
			//console.log(parData1)
			$.ajax({
				url:'/workflow/secirityManager/getKnowledgeById?knowleId='+parData1.securityKnowledgeId,
				dataType:'json',
				type:'post',
				async: false,
				success:function(res){
					if(res.code===0||res.code==="0"){
						var securityKnowledgeId = res.obj;
						str111 = securityKnowledgeId;
						//console.log(res.obj);
					}
				}
			})

			$("[name='securityKnowledgeId']").val(str111);
			$("#securityKnowledgeId").attr("pid",parData1.id);
		})
		//渲染项目名称1
		var $select3 = $("#projectId1");
		var optionStr3 = '<option value="">请选择项目名称</option>';
		$.ajax({ //查询文档等级
			url: '/ProjectInfo/selectProPlus?projOrgId=&useflag=false',
			type: 'get',
			dataType: 'json',
			async:false,
			success: function (res) {
				var data=res.data
				if(data!=undefined&&data.length>0){
					for(var i=0;i<data.length;i++){
						optionStr3 += '<option value="' + data[i].projectId + '">' + data[i].projectName + '</option>'
					}
				}
			}
		})
		$select3.html(optionStr3);
		//渲染隐患区域
		$(document).on("click","[name='securityRegionId']",function (e) {
			e.stopPropagation();
			var projectId = $("#projectId1").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value")
			if(projectId == null|| projectId == undefined){
				layer.msg('请先选择项目名称')
			}else{
				eleTree.render({
					elem: '.eleb4',
					url:'/workflow/secirityManager/getRegionByProject?projectId='+projectId,
					expandOnClickNode: false,
					highlightCurrent: true,
					showLine:true,
					showCheckbox: false,
					checked: false,
					lazy: false,
					done: function(res){
						if(res.data.length == 0){
							$(".eleb4").html('<div style="text-align: center">暂无数据</div>');
						}
					}
				});
			}

			$(".eleb4").slideDown();
		})
		$(document).on("click",function() {
			$(".eleb4").slideUp();
		})

		// 节点点击事件
		eleTree.on("nodeClick(dataX)",function(d) {
			var parData = d.data.currentData;
			var str111="";
			$.ajax({
				url:'/workflow/secirityManager/getRegionById?regionId='+parData.regionId,
				dataType:'json',
				type:'post',
				async: false,
				success:function(res){
					if(res.code===0||res.code==="0"){
						var regionName = res.obj;
						str111 = regionName//name
					}
				}
			})
			$("#securityRegionId").val(str111)
			$("#securityRegionId").attr("pid3",parData.id)
		});

		//渲染整改人
		$(document).on("click","#rectificationPersion",function(){
			user_id = "rectificationPersion";
			$.popWindow("/projectTarget/selectOwnDeptUser?0");
		})

		form.render();

		//头工具栏事件

		$('#searchCust').click(function () {
			var serchSelect = $("#serchSelect").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"); //下拉列表的值
			var searchtext = "";
			var serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1;
			//debugger
			if(serchSelect == "projectId"){
				searchtext = $("#projectId").val();
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1;//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1+"&"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "planName"){
				searchtext = $("#planName").val(); //输入框的值
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1;//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1+"&"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "securityKnowledgeId"){
				searchtext = $("#securityKnowledgeId").attr("pid"); //输入框的值
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1;//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1+"&"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "securityRegionId"){
				searchtext = $("#securityRegionId").attr("pid3"); //输入框的值
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1;//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1+"&"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "rectificationPersion"){
				searchtext = $("#rectificationPersion").attr("user_id"); //输入框的值
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1;//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					if(searchtext.indexOf(",")!=-1){
						searchtext = searchtext.replace(",","");
					}else if(searchtext.indexOf("，")!=-1){
						searchtext = searchtext.replace("，","");
					}
					serchObjUrl = "/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus="+recificationStatus_1+"&"+serchSelect+"="+searchtext;//重载表格
				}
			}else{
				layer.msg("请选择查询条件");
			}
			table.reload("Settlement",{
				url: serchObjUrl
			});
		})

		projectLeft();

		/**
		 * 左侧项目信息列表
		 * @param projectName 项目名称
		 */
		function projectLeft(projectName) {
			projectName = projectName ? projectName : '';
			var loadingIndex = layer.load();
			$.get('/plbOrg/treeListOrg', {projectName: projectName}, function (res) {
				layer.close(loadingIndex);
				if (res.flag) {
					eleTree.render({
						elem: '#leftTree',
						data: res.data,
						highlightCurrent: true,
						showLine: true,
						defaultExpandAll: false,
						request: {
							name: 'name',
							children: "plbProjList",
						}
					});

				}
			});
		}

		// 树节点点击事件
		eleTree.on("nodeClick(leftTree)", function (d) {
			var currentData = d.data.currentData;
			if (currentData.projId) {
				$('#leftId').attr('projId', currentData.projId);
				tableInit(currentData.projId);
				$('.no_data').hide();
				$('.table_box').show();
			}else{
				$('.table_box').hide();
				$('.no_data').show();
			}
		});

		// 渲染数据表格
		function tableInit(projectId) {
			// 树右侧表格实例
			SettlementTable = layui.table.render({
				elem: '#Settlement'
				// , data: []
				, url: '/workflow/secirityManager/getDetailInfo?isRecification=false&recificationStatus=1,2,3&acceptanceFlag=0,1&projectId=' + projectId//数据接口
				, page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
					layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
					, limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
					, first: false //不显示首页
					, last: false //不显示尾页
				} //开启分页
				, toolbar: '#toolbar'
				, cols: [[ //表头
					{type: 'checkbox'}
					, {field: 'projectName', title: '项目名称'}
					, {field: 'planName', title: '检查计划名称'}
					, {field: 'securityKnowledgeName', title: '隐患项'}
					, {field: 'securityRegionName', title: '隐患区域'}
					, {field: 'rectificationDesc', title: '整改描述'}
					, {field: 'securityGradeName', title: '隐患等级'}
					, {field: 'rectificationUserName', title: '整改人'}
					, {field: 'rectificationTime', title: '整改时间'}
					, {field: 'rectificationId', title: '验收状态',templet: function (d) {
							if(d.recificationStatus==1&&d.acceptanceFlag==0){
								return  '<span>未验收</span>'
							}else if(d.recificationStatus==1&&d.acceptanceFlag==1){
								return  '<span>已验收未提交</span>'
							}else if(d.recificationStatus==3&&d.acceptanceFlag==1){
								return  '<span>已验收已提交</span>'
							}else if(d.recificationStatus==2&&d.acceptanceFlag==1){
								return  '<span>已退回</span>'
							}else{
								return  '<span></span>'
							}
						}}
					,{width:100, title: '操作',align:'center', toolbar: '#barOperation'}
				]]
				, limit: 10
				, done: function (res) {
				}
			});
		}


		//表格头工具事件
		table.on('toolbar(SettlementFilter)', function(obj){
			//debugger
			var checkStatus = table.checkStatus("Settlement").data;
			var event = obj.event;
			switch(event){
				case 'submit'://同意
					if (checkStatus.length == 0 ) {
						layer.msg("请选择至少一条");
					} else {
						layer.confirm('确定同意吗吗？',{icon: 3, title:'提示'}, function(index){
							var isTrue = true;
							var rectificationIds ='';
							for(var i=0;i<checkStatus.length;i++){
								if(checkStatus[i].rectificationId==undefined||checkStatus[i].rectificationId==null){
									layer.msg("未整改");
									return false;
								}else {
									if(checkStatus[i].recificationStatus === '1'){
										isTrue = false
									}
									rectificationIds += checkStatus[i].rectificationId+','
								}
							}
							if(isTrue){
								layer.msg("不可重复提交");
							}else {
								$.ajax({
									url:'/workflow/secirityManager/commitAcceptance?ids='+rectificationIds+'&type=accptance&flag=true&acceptance=false',
									type: 'post',
									dataType:'json',
									success:function(res){
										if(res.code===0||res.code==="0"){
											//layer.closeAll();
											layer.msg(res.msg)
											SettlementTable.reload();
										}
									}
								})
							}
						})
					}
					break;
				case 'goback'://退回
					if (checkStatus.length == 0 ) {
						layer.msg("请选择至少一条");
					} else {
						layer.confirm('确定退回吗吗？',{icon: 3, title:'提示'}, function(index){
							var rectificationIds ='';
							for(var i=0;i<checkStatus.length;i++){
								if(checkStatus[i].rectificationId==undefined||checkStatus[i].rectificationId==null){
									layer.msg("未整改");
									return false;
								}else {
									rectificationIds += checkStatus[i].rectificationId+','
								}
							}
							$.ajax({
								url:'/workflow/secirityManager/commitAcceptance?ids='+rectificationIds+'&type=accptance&flag=false&acceptance=false',
								type: 'post',
								dataType:'json',
								success:function(res){
									if(res.code===0||res.code==="0"){
										//layer.closeAll();
										layer.msg(res.msg)
										SettlementTable.reload();
									}
								}
							})
						})
					}
					break;
				case 'upfile': //导入
					layer.msg("功能正在开发中");
					break;
				case 'export':  //导出
					layer.msg("功能正在开发中");
					break;
			};
		});

		//表格行操作事件
		table.on('tool(SettlementFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var dataa = obj.data; //获得当前行数据
			securityInfoDate1 = dataa;
			var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
			var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
			if(layEvent === 'check'){ //安全验收
				var checkliId = dataa.checkliId;
				var btnArr=[]
				if(dataa.recificationStatus==="1"){ //未提交
					btnArr=['保存并同意','保存并退回','保存','取消']
				}else{
					btnArr=['取消']
				}
				var index = layer.open({
					type: 2,
					skin: 'layui-layer-molv', //加上边框
					area: ['100%', '100%'], //宽高
					title: '安全验收',
					maxmin: true,
					btn: btnArr,
					content: '/workflow/secirityManager/addRectification?urlType=acceptance',
					success: function () {

					},
					yes: function (index, layero) {
						var childData  = $(layero).find("iframe")[0].contentWindow.getDate1();
						if(dataa.recificationStatus==="1"){ //未提交
							$.ajax({
								url:'/workflow/secirityManager/commitAcceptance?acceptanceFlag=1&ids='+dataa.rectificationId+'&type=accptance&flag=true&acceptance=true&rectificationId='+dataa.rectificationId,
								dataType:"json",
								data:childData,
								type:"post",
								success:function(res){
									//console.log(res);
									if(res.code==="0"||res.code===0){
										layer.msg(res.msg)
										layer.close(index)
										SettlementTable.reload()

									}
								}
							})
						}else{
							layer.close(index)
						}
					}
					,btn2:function(index,layero){
						var childData  = $(layero).find("iframe")[0].contentWindow.getDate1();

						$.ajax({
							url:'/workflow/secirityManager/commitAcceptance?acceptanceFlag=1&ids='+dataa.rectificationId+'&type=accptance&flag=false&acceptance=true&rectificationId='+dataa.rectificationId,
							dataType:"json",
							data:childData,
							type:"post",
							success:function(res){
								//console.log(res);
								if(res.code==="0"||res.code===0){
									layer.msg(res.msg)
									layer.close(index)
									SettlementTable.reload()

								}
							}
						})
					},btn3:function(index,layero){
						var childData  = $(layero).find("iframe")[0].contentWindow.getDate1();

						$.ajax({
							url:"/workflow/secirityManager/acceptance?acceptanceFlag=1&rectificationId="+dataa.rectificationId,
							dataType:"json",
							data:childData,
							type:"post",
							success:function(res){
								//console.log(res);
								if(res.code==="0"||res.code===0){
									layer.close(index)
									SettlementTable.reload()
								}
							}
						})
					}
					,btn4:function(index,layero){
						layer.close(index)
					}
				});
			} else if(layEvent === 'down'){ //下载
				var attachId = data.attachmentId;
				if(attachId==undefined||attachId==''){
					layer.msg("文件损坏或未上传附件")
				}else{
					window.location.href = "/equipment/limsDownload?model=knowlage&attachId=" +attachId
				}
			}else if(layEvent === 'info'){ //查看详情
				var index = layer.open({
					type: 1,
					skin: 'layui-layer-molv', //加上边框
					area: ['80%', '80%'], //宽高
					title: '文档详情',
					maxmin: true,
					btn: ['确定'],
					content: '<div class="layui-form" id="boxfo">' +
							//'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档编号</label><div class="layui-input-block" style="margin-left: 130px;">' +
							//'<input disabled class="layui-input" lay-verify="required" name="docfileNo" id="docfileNo"></div></div>' +
							'<div class="inbox" id="finde"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>关键词</label><div class="layui-input-block" style="margin-left: 130px;">' +
							'<input disabled class="layui-input"  lay-verify="required" name="keyWord" id="keyWord"></div></div>' +
							//'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>下载密码</label><div class="layui-input-block" style="margin-left: 130px;">' +
							//'<input class="layui-input"  lay-verify="required" name="downloadPassword" id="downloadPassword"></div></div>' +
							'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档等级</label><div class="layui-input-block" style="margin-left: 130px;">' +
							'<select disabled name="docfileClass" lay-verify="required"></select></div></div>' +
							'<div class="inbox"><label class="layui-form-label" style="width: 100px;">下载标识</label><div class="layui-input-block" style="margin-left: 130px;">' +
							'<input disabled class="layui-input"  lay-verify="required" name="downloadKey" id="downloadKey"></div></div>' +
							'<div class="inbox"><label class="layui-form-label" style="width: 100px;">文档摘要</label><div class="layui-input-block" style="margin-left: 130px;">' +
							'<textarea readonly name="docfileDesc" id="docfileDesc" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
							//'<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="add-file-submit" id="add-file-submit" value="确认"></div>' +
							//'<button hidden id="uploadButton"></button>'+
							//'<input hidden id="attachmentId" name="attachmentId"/>'+
							//'<input hidden id="attachmentName" name="attachmentName"/>'+
							'</div>',
					success: function () {
						$.ajax({ //查询文档等级
							url: '/knowledge/childTree?docFileId='+data.docfileId,
							type: 'get',
							dataType: 'json',
							async:false,
							success: function (res) {
								if(res.code == 0){
									var qdata = res.data;
									var str1 = '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档名称</label><div class="layui-input-block" style="margin-left: 130px;">' +
											'<button type="button" class="layui-btn" id="but_chose1" style=" float: right"> <i class="layui-icon">&#xe67c;</i>选择文件 </button>' +
											'<input id="docfileName" disabled readonly name="docfileName" style="width:80%; float: left"  class="layui-input"></div></div>' ;
									var str2 = ""
									if(qdata.length>0){
										for(var i =0; i<qdata.length;i++){
											str2+='<div class="inbox" ><label class="layui-form-label" style="width: 100px;" paid="'+qdata[i].id+'"><span class="red">*</span>'+qdata[i].name+'</label><div class="layui-input-block" style="margin-left: 130px;" lay-event="eleFn">' +
													'<textarea type="text" readonly data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer" lay-verify="required" placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele"></textarea>' +
													'<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div></div>'
										}
									}
									var str = str1 + str2;
									$("#finde").before(str);
									form.render();
									if(qdata.length>0) {
										for (var i = 0; i < qdata.length; i++) {
											(function (i) {
												var elm = '.ele' + i
												eleTree.render({
													elem: '.ele' + i,
													data: qdata[i].children,
													expandOnClickNode: false,
													highlightCurrent: true,
													showLine: true,
													showCheckbox: true,
													checked: true,
													defaultExpandAll: true,
													load: function (data, callback) {
													},
													done: function (res) {
														var pidar = obj.data.columnId.split(",");
														var pidarr = [];
														for (var j = 0; j < pidar.length; j++) {
															if (pidar[j] == "") {

															} else {
																pidarr.push(pidar[j]);
															}
														}
														for (var j = 0; j < pidarr.length; j++) {
															$(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("checked", true);
															$(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).attr("eletree-status", "1");
															// $(elm+" div[data-id="+pidarr[j]+"]").find("input").eq(0).addClass("eleTree-disabled");
															$(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").addClass("eleTree-checkbox-checked");
															$(elm + " div[data-id=" + pidarr[j] + "]").find("input").eq(0).next("div.eleTree-checkbox").find("i").addClass("layui-icon-ok");
														}
														var $inp = $(elm +' input[eletree-status="1"]');
														var str = "";
														var str1 = "";
														for(var i=0;i<$inp.length;i++){
															str += $inp.eq(i).parent().find("span.eleTree-node-content-label").text()+",";
															str1 += $inp.eq(i).parent().parent().attr("data-id")+",";
														}
														$(elm).prev("textarea").attr("pid",str1)
														$(elm).prev("textarea").text(str);
														//    $(elm).prev("input").attr("pid",str1)
														//    $(elm).prev("input").text(str);
													}
												});
												var $inp = $(elm +' input[eletree-status="1"]');
												var str = "";
												var str1 = "";
												for(var i=0;i<$inp.length;i++){
													str += $inp.eq(i).parent().find("span.eleTree-node-content-label").text()+",";
													str1 += $inp.eq(i).parent().parent().attr("data-id")+",";
												}
												$(elm).prev("textarea").attr("pid",str1)
												$(elm).prev("textarea").text(str);
											})(i);
										}
									}
								}


							}
						})
						// var $td = $("#boxfo").find('div[lay-event="eleFn"]');
						// $td.click(function (obj) {
						//     var td = $(this);
						//     if(td.find("textarea.ele").attr("data-type") == "0"){
						//         td.find(".eleTree").slideDown();
						//         td.find("textarea.ele").attr("data-type","1");
						//     }else{
						//         td.find(".eleTree").slideUp();
						//         td.find("textarea.ele").attr("data-type","0");
						//     }
						//     //点击本身外收起下拉的主体
						//     document.onmouseup = function(e){
						//         var e = e || window.event;
						//         var target = e.target || e.srcElement;
						//         //1. 点击事件的对象不是目标区域本身
						//         //2. 事件对象同时也不是目标区域的子元素
						//         if(!td.is(e.target) &&td.has(e.target).length === 0){
						//             $(".eleTree").slideUp();
						//             $("textarea.ele").attr("data-type","0");
						//         }
						//     }
						//     //选中监听事件
						//     var arr = [];
						//     var arr1 = [];
						//     var pidt = td.find("textarea.ele").attr("pid");
						//     var valt = td.find("textarea.ele").val();
						//     layui.eleTree.on("nodeChecked(data1)",function(d) {
						//         var id = d.data.currentData.columnId+"";
						//         var label = d.data.currentData.label+"";
						//         if(d.isChecked == true || d.isChecked == "true"){
						//             arr.push(id);
						//             arr1.push(label);
						//         }else{
						//             arr.remove(id);
						//             arr1.remove(label);
						//         }
						//         if(pidt != undefined || pidt != "undefined" || pidt != ""){
						//             var str = pidt;
						//         }else{
						//             var str= "";
						//         }
						//         if(valt != undefined || valt != "undefined" || valt != ""){
						//             var str1 = valt;
						//         }else{
						//             var str1 = "";
						//         }
						//         for(var i=0;i<arr.length;i++){
						//             str+=arr[i]+","
						//             str1+=arr1[i]+","
						//         }
						//         td.find("textarea.ele").val(str1);
						//         td.find("textarea.ele").attr("pid",str);
						//         // var data =  layui.table.cache["addTable"]
						//         // var ind = td.find("textarea.ele").parents("tr").attr("data-index");
						//         // data[ind].columnName = str1;
						//         // data[ind].columnId = str;
						//     })
						// })
						var $select1 = $("select[name='docfileClass']");
						var optionStr = '<option value="">请选择</option>';
						$.ajax({ //查询文档等级
							url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
							type: 'get',
							dataType: 'json',
							async:false,
							success: function (res) {
								if(res.obj!=undefined&&res.obj.length>0){
									for(var i=0;i<res.obj.length;i++){
										if(res.obj[i].codeName==data.docfileClass){
											optionStr += '<option  selected value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
										}else{
											optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
										}
									}
								}
							}
						})
						$select1.html(optionStr);//文档等级
						$("#docfileName").val(undefind_nullStr(data.docfileName));//文档名称
						$("#keyWord").val(undefind_nullStr(data.keyWord));//关键词
						$("#pele").val(undefind_nullStr(data.columnName));//栏目名称
						//$("#docfileNo").val(undefind_nullStr(data.docfileNo));//文档编号
						$("#docfileDesc").text(undefind_nullStr(data.docfileDesc));//文档摘要
						$("#downloadKey").val(undefind_nullStr(data.downloadAddress));//下载标识
						form.render();//初始化表单
					},
					yes: function (index, layero) {
						layer.close(index)
					}
				});
			}
		});
	})

	//删除附件
	$(document).on('click', '.deImgs', function () {
		var _this = this;
		var attUrl = $(this).parents('.dech').attr('deUrl');
		layer.confirm('确定删除该附件吗？', function (index) {
			$.ajax({
				type: 'get',
				url: '/delete?' + attUrl,
				dataType: 'json',
				success: function (res) {
					if (res.flag == true) {
						layer.msg('删除成功', {icon: 6, time: 1000});
						$(_this).parent().remove();
					} else {
						layer.msg('删除失败', {icon: 2, time: 1000});
					}
				}
			})
		});
	});

	function childFunc(){
		columnId = parent.columnTrId
		SettlementTable.reload({
			url: '/fileManage/getFile?columnIds='+columnId//数据接口
		});
	}
	function lookFile(repalogId){//查看附件
		if (repalogId == undefined || repalogId == "") {
			layer.msg("文件已被损坏，无法查看");
		} else {
			selectFile1(repalogId,'knowlage');
			//window.location.href = "/equipment/limsDownload?model=" + model + "&attachId=" + attachId  下载
		}
	}
	//查看附件
	function selectFile1(attchId,model) {
		if(attchId){
			//查看附件
			var data={
				attachId:attchId,
				model:model
			}
			var res=toAjaxT1("/equipment/selectAttchUrl",data);
			if(res.code==0){
				if(res.object){
					limsPreview1(res.object);
				}
			}
		}

	}
	//附件预览点击调取
	function limsPreview1(attrUrl) {
		var url = '';
		if(attrUrl != undefined&&attrUrl.indexOf('&ATTACHMENT_NAME=') > -1){
			var atturl1 = attrUrl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
			var atturl2 = '';
			if(attrUrl.split('&ATTACHMENT_NAME=')[1] != undefined&&attrUrl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
				for(var i=1;i<attrUrl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
					atturl2 += '&' + attrUrl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
				}
				url = atturl1 + atturl2;
			}else{
				url = atturl1;
			}
		}
		if(limsUrlGetRequest('?'+attrUrl) == 'pdf' || limsUrlGetRequest('?'+attrUrl) == 'PDF'){
			layui.layer.open({
				type: 2,
				title: '预览',
				offset:["20px",""],
				content: "/pdfPreview?"+url,
				area: ['80%', '80%']
			})
			// $.popWindow("/pdfPreview?"+url,PreviewPage,'0','0','1200px','600px');
		}else if(limsUrlGetRequest('?'+attrUrl) == 'png' || limsUrlGetRequest('?'+attrUrl) == 'PNG'|| limsUrlGetRequest('?'+attrUrl) == 'jpg' || limsUrlGetRequest('?'+attrUrl) == 'JPG'|| limsUrlGetRequest('?'+attrUrl) == 'txt'|| limsUrlGetRequest('?'+attrUrl) == 'TXT'){
			layui.layer.open({
				type: 2,
				title: '预览',
				content: "/xs?"+url,
				offset:["20px",""],
				area: ['80%', '80%'],
				success:function(layero, index){
					var iframeWindow = window['layui-layer-iframe'+ index];
					var doc = $(iframeWindow.document);
					doc.find('img').css("width","100%");
				}
			})
			// $.popWindow("/xs?"+url,PreviewPage,'0','0','1200px','600px');
		}else{
			pdurl1(limsUrlGetRequest('?'+attrUrl),attrUrl)
			// $.ajax({
			//     type:'get',
			//     url:'/sysTasks/getOfficePreviewSetting',
			//     dataType:'json',
			//     success:function (res) {
			//         if(res.flag){
			//             var strOfficeApps = res.object.previewUrl;//在线预览服务地址
			//             if(strOfficeApps == ''){
			//                 strOfficeApps = 'https://view.officeapps.live.com';
			//             }
			//             layui.layer.open({
			//                 type: 2,
			//                 title: '预览',
			//                 offset:["20px",""],
			//                 content: strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),
			//                 area: ['80%', '80%']
			//             })
			//             // $.popWindow(strOfficeApps+'/op/view.aspx?src='+domains+'/download?'+encodeURIComponent(url),'','0','0','1200px','600px')
			//         }
			//     }
			// })

		}
	}
	//判断是否显示空
	function isShowNull2(data) {
		if(data){
			return data
		}else{
			return "";
		}
	}
	//同步
	function toAjaxT1(url,data) {
		var result;
		$.ajax({
			url:url,
			data:data,
			type: 'post',
			async:false,
			dataType: 'json',
			success: function (res){
				result=res;
			}
		});
		return result;
	}
	//截取附件文件后缀
	function limsUrlGetRequest(name) {
		var attach=name
		return attach.substring(attach.lastIndexOf(".")+1,attach.length);
	}
	function pdurl1(gs,atturl){ //根据后缀判断选择调取那种打开方式
		if(atturl != undefined&&atturl.indexOf('&ATTACHMENT_NAME=') > -1){
			var atturl1 = atturl.split('&ATTACHMENT_NAME=')[0] + '&ATTACHMENT_NAME=';
			var atturl2 = '';
			if(atturl.split('&ATTACHMENT_NAME=')[1] != undefined&&atturl.split('&ATTACHMENT_NAME=')[1].indexOf('&') > -1){
				for(var i=1;i<atturl.split('&ATTACHMENT_NAME=')[1].split('&').length;i++){
					atturl2 += '&' + atturl.split('&ATTACHMENT_NAME=')[1].split('&')[i];
				}
				atturl = atturl1 + atturl2;
			}else{
				atturl = atturl1;
			}
		}
		if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'|| gs == 'txt'|| gs == 'TXT'){
			$.popWindow("/xs?"+atturl,PreviewPage,'0','0','1200px','600px');
		}else if(gs == 'mp4'||gs == 'rmvb'||gs == 'avi'||gs == 'ifo'||gs == 'wmv'||gs == 'MP4'||gs == 'RMVB'||gs == 'AVI'||gs == 'IFO'||gs == 'WMV'){
			layer.open({type: 2, title: false, area: ['630px', '360px'], shade: 0.8, closeBtn: 0, shadeClose: true, content: "/common/video?videoatturlsplit="+atturl});
			layer.msg('点击任意处关闭');
		}else if(gs == 'pdf'||gs == 'PDF'){
			$.popWindow("/pdfPreview?"+atturl,PreviewPage,'0','0','1200px','600px');
		}else{
			var url = "/common/webOfficeView?documentEditPriv=0&fomat="+gs+"&"+atturl;
			$.ajax({
				url:'/syspara/selectTheSysPara?paraName=OFFICE_EDIT',
				type:'post',
				datatype:'json',
				async:false,
				success: function (res) {
					if(res.flag){
						if(res.object[0].paraValue == 0){
							//默认加载NTKO插件 进行跳转
							url = "/common/ntkoview?documentEditPriv=0&fomat="+gs+"&"+atturl;
						}else if(res.object[0].paraValue == 2){
							//默认加载NTKO插件 进行跳转
							url = "/wps/info?"+ atturl +"&permission=read";
						}
					}

				}
			})
			setTimeout(function(){
				$.popWindow(url,PreviewPage,'0','0','1200px','600px');
			}, 1000);
		}
	}
	function undefind_nullStr(value) {
		if(value==undefined){
			return ""
		}
		return value
	}
	function getAttachIds(obj) {
		return obj.aid+"@"+obj.ym+"_"+obj.attachId;
	}
	//图片上传 方法
	function fileuploadFn(formId,element) {
		var timer=null;
		// $('#uploadinputimg').fileupload({
		$(formId).fileupload({
			dataType:'json',
			progressall: function (e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
				$('#progress .bar').css(
						'width',
						progress + '%'
				);
				$('.barText').html(progress + '%');
				if(progress >= 100){  //判断滚动条到100%清除定时器
					timer=setTimeout(function () {
						$('#progress .bar').css(
								'width',
								0 + '%'
						);
						$('.barText').html('');
					},2000);

				}
			},
			done: function (e, data) {
				if(data.result.obj!=undefined){
					if(data.result.obj != ''){
						var data = data.result.obj;
						var str = '';
						var str1 = '';
						for (var i = 0; i < data.length; i++) {
							var gs = data[i].attachName.split('.')[1];
							if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
								var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
								var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
								var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
								var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

								str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
							}
							/* else if(data[i].attachName.indexOf('+')!=-1){
                                     alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");

                             }*/
							else{ //后缀为这些的禁止上传
								str += '';
								layer.msg('只能上传图片!', {icon: 2, time: 1000});
								/*layer.alert('只能上传图片!',{},function(){
									layer.closeAll();
								});*/
							}
						}
						// $('.Attachment td').eq(1).append(str);
						console.log(element)
						element.append(str);
					}else{

						layer.msg('添加附件大小不能为空!', {icon: 2, time: 1000});
						/*layer.alert('添加附件大小不能为空!',{},function(){
							layer.closeAll();
						});*/
					}
				}else {
					if(data.result.datas != ''){
						var data = data.result.datas;
						var str = '';
						var str1 = '';
						for (var i = 0; i < data.length; i++) {
							var gs = data[i].attachName.split('.')[1];
							if(gs == 'png'||gs == 'jpg'||gs == 'bmp' || gs == 'emf' || gs == 'gif'|| gs == 'pcx'|| gs == 'pcd'|| gs == 'ai'|| gs == 'webp'|| gs == 'WMF'|| gs == 'dxf' ||gs == 'PNG'||gs == 'JPG'||gs == 'BMP' || gs == 'EMF' || gs == 'GIF'|| gs == 'PCX'|| gs == 'PCD'|| gs == 'AI'|| gs == 'WEBP'|| gs == 'wmf'|| gs == 'DXF'){
								var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
								var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
								var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
								var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

								str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
							}
							/* else if(data[i].attachName.indexOf('+')!=-1){
                                     alert("你上传的"+data[i].attachName+"文件有特殊字符'+',文件名中不可存在特殊字符,请重新上传");

                             }*/
							else{ //后缀为这些的禁止上传
								str += '';
								layer.msg('只能上传图片!', {icon: 2, time: 1000});
								/*layer.alert('只能上传图片!',{},function(){
									layer.closeAll();
								});*/
							}
						}
						// $('.Attachment td').eq(1).append(str);
						console.log(element)
						element.append(str);
					}else{
						layer.msg('添加附件大小不能为空!', {icon: 2, time: 1000});
						/*layer.alert('添加附件大小不能为空!',{},function(){
							layer.closeAll();
						});*/
					}
				}

			}
		});
	}
</script>
</body>
</html>