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
	<title>新建质量检查记录</title>
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
	<style>
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


		#steps {
			width: 360px;
			margin: 100px auto;
		}

		.step-item {
			display: inline-block;
			line-height: 26px;
			position: relative;
			background: #ffffff;
		}

		.step-item-tail {
			width: 31%;
			padding: 0 10px;
			position: relative;
			left: -20px;
			top: 0;

			transform: rotate(90deg);
			-ms-transform: rotate(90deg);
			/* Internet Explorer 9*/
			-moz-transform: rotate(90deg);
			/* Firefox */
			-webkit-transform: rotate(90deg);
			/* Safari 和 Chrome */
			-o-transform: rotate(90deg);
			/* Opera */
		}

		.step-item-tail i {
			display: inline-block;
			width: 100%;
			height: 1px;
			vertical-align: top;
			background: #c2c2c2;
			position: relative;
		}
		.step-item-tail-done {
			background: #009688 !important;
		}

		.step-item-head {
			position: relative;
			display: inline-block;
			height: 26px;
			width: 26px;
			text-align: center;
			vertical-align: top;
			color: #009688;
			border: 1px solid #009688;
			border-radius: 50%;
			background: #ffffff;
		}

		.step-item-head.step-item-head-active {
			background: #009688;
			color: #ffffff;
		}

		.step-item-main {
			background: #ffffff;
			display: block;
			position: relative;
			float: right;
		}

		.step-item-main-title {
			font-weight: bolder;
			color: #555555;
		}
		.step-item-main-desc {
			color: #aaaaaa;
		}

	</style>
</head>
<body>

<form  class="layui-form" id="form" lay-filter="formTest">
	<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">质量检查单</div>
	<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
		<div class="layui-inline" style="width: 98%;">
			<label class="layui-form-label" style="width: 30%;">项目名称</label>
			<div class="layui-input-inline" style="width: 55%;">
				<input type="text" disabled id="projectId" lay-verify="required" name="projectId" autocomplete="off" class="layui-input">
				<input type="hidden" disabled id="detailsId" lay-verify="required" name="detailsId" class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
		<div class="layui-inline" style="width: 98%;">
			<label class="layui-form-label" style="width: 30%;">检查类型</label>
			<div class="layui-input-inline" style="width: 55%;">
				<select id="testTypeNo" disabled lay-verify="required" name="testTypeNo"></select>
			</div>
		</div>
	</div>
	<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
		<div class="layui-inline" style="width: 98%;">
			<label class="layui-form-label" style="width: 30%;">被检查单位</label>
			<div class="layui-input-inline" style="width: 55%;">
				<input type="text" disabled id="testDept" lay-verify="required" name="testDept" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
		<div class="layui-inline" style="width: 98%;">
			<label class="layui-form-label" style="width: 30%;">检查组长</label>
			<div class="layui-input-inline" style="width: 55%;">
				<input type="text" disabled id="testLeader" name="testLeader" placeholder="请选择" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
</form>
<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">应检查项</div>
<div style="width: 88%;margin: auto;"><table id="formTable1" lay-filter="formTable1"></table></div>
<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">检查记录</div>
<div style="width: 88%;margin: auto;"><table id="formTable2" lay-filter="formTable2"></table></div>

<script type="text/html" id="formTable1toolbar2">
	<div class="layui-btn-container" style="height: 30px;">
		<%--<input type="button" class="layui-btn layui-btn-sm" lay-event="addTest" value="新增">
		<input type="button" class="layui-btn layui-btn-sm" lay-event="delTest" value="删除">--%>
		<%--<input type="button" class="layui-btn layui-btn-sm" lay-event="examineTest" value="执行检查">--%>
	</div>
</script>
<script type="text/html" id="formTable1bar">
	<div class="layui-btn-container" style="height: 30px;">
		<input type="button" class="layui-btn layui-btn-sm" lay-event="check" value="查看" style="align-content: center"><%--表单查询页面--%>
	</div>
</script>
<script type="text/html" id="formTable1bar1">
	<div class="layui-btn-container" style="height: 30px;">
		<input type="button" class="layui-btn layui-btn-sm" lay-event="check1" value="查看" style="align-content: center"><%--检查记录界面--%>
	</div>
</script>
<script type="text/html" id="barOperation">
	<a class="layui-btn layui-btn-xs" lay-event="flowsheet" >流程图</a>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
	var securityInfoDate;
	var planItemId = getUrlParam("planItemId");
	$.ajax({
		url: '/workflow/qualityManager/getCheckByItemId?planItemId='+planItemId,
		type: 'get',
		dataType: 'json',
		async:false,
		success: function (res) {
			securityInfoDate = res.obj;
		}
	})

	var user_id;
	var detailsInit;
	var detailsInitData=[];
	var detailsInit2;
	var detailsInitData2=[];
    var detailsInit3;
    var detailsInitData3=[];
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

		$(document).on("click","#rectificationPersion",function(){ //整改人
			user_id = "rectificationPersion";
			$.popWindow("/projectTarget/selectOwnDeptUser?0");
		})

		$(document).on("click","#acceptancePersion",function(){ //验收人
			user_id = "acceptancePersion";
			$.popWindow("/projectTarget/selectOwnDeptUser?0");
		})
		$(document).on('click', '#testDept', function () {
			dept_id = "testDept";
			$.popWindow("/common/selectDept?0");
		});
		$(document).on('click', '#testLeader', function () {
			user_id = "testLeader";
			$.popWindow("/projectTarget/selectOwnDeptUser?0");
		})
		//选部门控件添加
		$(document).on('click', '#testDeptId', function () {
			dept_id = "testDeptId";
			$.popWindow("/common/selectDept?0");
		});

		//回显
		$("#detailsId").val(securityInfoDate.detailsId);

		//渲染项目名称
		$("#projectId").val(securityInfoDate.projectName);


		// var $select2 = $("#projectId");
		// var optionStr2 = '<option value="">请选择</option>';
		// $.ajax({ //查询文档等级
		// 	url: '/ProjectInfo/selectProPlus?projOrgId=&useflag=false',
		// 	type: 'get',
		// 	dataType: 'json',
		// 	async:false,
		// 	success: function (res) {
		// 		var data=res.data
		// 		if(data!=undefined&&data.length>0){
		// 			for(var i=0;i<data.length;i++){
		// 				if(data[i].projectId==securityInfoDate.projectId){
		// 					optionStr2 += '<option selected value="' + data[i].projectId + '">' + data[i].projectName + '</option>'
		// 				}else{
		// 					optionStr2 += '<option value="' + data[i].projectId + '">' + data[i].projectName + '</option>'
		// 				}
		// 			}
		// 		}
		// 	}
		// })
		// $select2.html(optionStr2);

		//检查类型
		var $select1 = $("#testTypeNo");
		var optionStr = '<option value="">请选择</option>';
		$.ajax({ //查询文档等级
			url: '/Dictonary/selectDictionaryByNo?dictNo=SECURITY_CHECK_TYPE',
			type: 'get',
			dataType: 'json',
			async:false,
			success: function (res) {
				var data=res.data
				if(data!=undefined&&data.length>0){
					for(var i=0;i<data.length;i++){
						if(data[i].dictNo==securityInfoDate.testTypeNo){
							optionStr += '<option selected value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
						}else{
							optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
						}
					}
				}
			}
		})
		$select1.html(optionStr);
		//被检查单位
		$("#testDept").val(securityInfoDate.testDeptName);
		$("#testDept").attr("deptid",securityInfoDate.testDept);
		//选部门控件添加
		$("#testLeader").val(securityInfoDate.testLeaderName);
		$("#testLeader").attr("user_id",securityInfoDate.testLeader);


		detailsInit = table.render({
			elem: '#formTable1'
			, page:true
			,url:'/workflow/qualityManager/selectChecklistDetails?checkId='+securityInfoDate.checkliId
			,toolbar:'#formTable1toolbar'
			,cols: [[
				//{type: 'checkbox'}
				//,{field:'testUserName',title:'检查人'}
				{field:'detailsName',title:'名称'}
				,{field: 'securityKnowledgeName', title: '检查项'}
				,{field: 'securityDangerName', title: '检查内容'}
				,{field: 'securityRegionName', title: '检查区域'}
			]],
			done:function(obj, curr, count){

			}
		});

		detailsInit2 = table.render({
			elem: '#formTable2'
			, page:true
			,url:' /workflow/qualityManager/getDetailInfoGroupTypeNotUser?checkliId='+securityInfoDate.checkliId+'&type=check'
			,toolbar:'#formTable1toolbar2'
			,cols: [[
				{type: 'numbers',title:'序号',width:60}
				,{field:'knowledgeName',title:'检查项'}
				,{field: 'dangerNumber', title: '隐患数量'}
				,{field: 'needRectificationNumber', title: '需整改数量'}
				,{field: 'rectificationNumber', title: '已整改数量'}
				,{field: 'needAcceptanceNumber', title: '需验收数量'}
				,{field: 'acceptanceNumber', title: '已验收数量'}
				,{title: '操作', align: 'center', toolbar: '#formTable1bar',width:100}
			]],
			done:function(obj, curr, count){
				detailsInitData2 = obj.data;
			}
		});
		Array.prototype.remove = function(val) {
			var index = this.indexOf(val);
			if (index > -1) {
				this.splice(index, 1);
			}
		};
		form.render();

		//行内查看
        table.on('tool(formTable3)', function(obj){
            var tDataa = obj.data;
            console.log(tDataa);
            var layEvent = obj.event;
            if(layEvent === 'check1'){//检查记录页面中的查看
				var htm='<form  class="layui-form" id="form" lay-filter="formTest">\n'+
						'<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">隐患信息</div>\n' +
						'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
						'    <div class="layui-inline" style="width: 98%;">\n' +
						'        <label class="layui-form-label" style="width: 30%;">项目名称</label>\n' +
						'        <div class="layui-input-inline" style="width: 55%;">\n' +
						'            <input type="text" disabled id="projectName1" lay-verify="required" name="projectName1" autocomplete="off" class="layui-input">\n' +
						'            <input type="hidden" disabled id="detailsId" lay-verify="required" name="detailsId" class="layui-input">\n' +
						'        </div>\n' +
						'    </div>\n' +
						'</div>\n' +
						'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
						'    <div class="layui-inline" style="width: 98%;">\n' +
						'        <label class="layui-form-label" style="width: 30%;">被检查单位</label>\n' +
						'        <div class="layui-input-inline" style="width: 55%;">\n' +
						'            <input type="text" disabled id="testDept1" lay-verify="required" name="testDept1" autocomplete="off" class="layui-input">\n' +
						'        </div>\n' +
						'    </div>\n' +
						'</div>\n' +
						'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
						'    <div class="layui-inline" style="width: 98%;">\n' +
						'        <label class="layui-form-label" style="width: 30%;">检查人</label>\n' +
						'        <div class="layui-input-inline" style="width: 55%;">\n' +
						'            <input type="text" disabled id="createUserName" name="createUserName" autocomplete="off" class="layui-input">\n' +
						'        </div>\n' +
						'    </div>\n' +
						'</div>\n' +
						'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
						'    <div class="layui-inline" style="width: 98%;">\n' +
						'         <label class="layui-form-label" style="width: 30%;">检查区域</label>\n' +
						'         <div class="layui-input-inline" style="width: 55%;">\n' +
						'             <input type="text" id="securityRegionName1" disabled lay-verify="required" name="securityRegionName1" autocomplete="off" class="layui-input">\n' +
						'         </div>\n' +
						'    </div>\n' +
						'</div>\n' +
						/*'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
						'    <div class="layui-inline" style="width: 98%;">\n' +
						'         <label class="layui-form-label" style="width: 30%;">图纸位置</label>\n' +
						'         <div class="layui-input-inline" style="width: 55%;">\n' +
						'             <input type="text" disabled style="height: 38px !important;" lay-verify="required" autocomplete="off" class="layui-input">\n' +
						'         </div>\n' +
						'<input hidden id="attachmentId" name="attachmentId"/>'+
						'<input hidden id="attachmentName" name="attachmentName"/>'+
						'<input hidden id="securityContentId" name="securityContentId"/>'+
						'    </div>\n' +
						'</div>\n' +*/
						'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
						'    <div class="layui-inline" style="width: 98%;">\n' +
						'         <label class="layui-form-label" style="width: 30%;">检查时间</label>\n' +
						'         <div class="layui-input-inline" style="width: 55%;">\n' +
						'             <input type="text" id="createTime" disabled lay-verify="required" name="createTime" autocomplete="off" class="layui-input">\n' +
						'         </div>\n' +
						'    </div>\n' +
						'</div>\n' +
						'<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
						'    <div class="layui-inline" style="width: 98%;">\n' +
						'         <label class="layui-form-label" style="width: 15%;">隐患描述</label>\n' +
						'         <div class="layui-input-inline" style="width: 75%;">\n' +
						'             <textarea type="text" disabled style="width:100%;min-height: 80px !important;" id="securityDangerDesc" lay-verify="required" name="securityDangerDesc" autocomplete="off" class="layui-input"></textarea>\n' +
						'         </div>\n' +
						'    </div>\n' +
						'</div>\n' +
						'<div class="layui-input-inline" style="margin-left: 130px;">\n' +
						'<div id="fujians"></div>\n' +
						'<div id="fileAll">\n' +
						'</div>\n' +
						'<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
						/*'<img src="../img/mg11.png" alt="">\n' +
						'<span>添加附件</span>\n' +*/
						'<input type="file" multiple id="fileupload" data-url="/upload?module=workLog" disabled name="file">\n' +
						'</a>\n' +
						'</div>\n' +
					'<div id="isShow">\n' +
                    '<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">整改信息:<span id="rectification_span"></span></div>\n' +
                    '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                    '    <div class="layui-inline" style="width: 98%;">\n' +
                    '        <label class="layui-form-label" style="width: 30%;">整改人</label>\n' +
                    '        <div class="layui-input-inline" style="width: 55%;">\n' +
                    '            <input class="layui-input" style="height: 38px !important;" lay-verify="required" disabled id="rectificationUserName">\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</div>\n' +
                    '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                    '    <div class="layui-inline" style="width: 98%;">\n' +
                    '        <label class="layui-form-label" style="width: 30%;">整改时间</label>\n' +
                    '        <div class="layui-input-inline" style="width: 55%;">\n' +
                    '            <input type="text"  style="height: 38px !important;" lay-verify="required" autocomplete="off" class="layui-input" disabled id="rectificationTime">\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</div>\n' +
                    '<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
                    '    <div class="layui-inline" style="width: 98%;">\n' +
                    '         <label class="layui-form-label" style="width: 15%;">整改描述</label>\n' +
                    '         <div class="layui-input-inline" style="width: 75%;">\n' +
                    '             <textarea type="text" disabled style="width:100%;min-height: 80px !important;" id="rectificationDesc" lay-verify="required"  name="rectificationDesc" autocomplete="off" class="layui-input"></textarea>\n' +
                    '         </div>\n' +
                    '    </div>\n' +
                    '</div>\n' +
                    '<div class="layui-input-inline" id="one11" style="margin-left: 130px;">\n' +
                    '<div id="fujians1"></div>\n' +
                    '<div id="fileAll1">\n' +
                    '</div>\n' +
                    '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                    /*'<img src="../img/mg11.png" alt="">\n' +
                    '<span>添加附件</span>\n' +*/
                    '<input type="file" multiple id="fileupload1" data-url="/upload?module=workLog" disabled name="file">\n' +
                    '</a>\n' +
                    '</div>\n' +
					'</div>\n' +
					'<div id="isShow1">\n' +
                    '<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">验收信息:<span id="acceptance_span"></span></div>\n'+
                    '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                    '    <div class="layui-inline" style="width: 98%;">\n' +
                    '        <label class="layui-form-label" style="width: 30%;">验收人</label>\n' +
                    '        <div class="layui-input-inline" style="width: 55%;">\n' +
                    '            <input class="layui-input" style="height: 38px !important;" lay-verify="required" disabled id="acceptanceUserName">\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</div>\n' +
                    '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                    '    <div class="layui-inline" style="width: 98%;">\n' +
                    '        <label class="layui-form-label" style="width: 30%;">验收时间</label>\n' +
                    '        <div class="layui-input-inline" style="width: 55%;">\n' +
                    '            <input type="text"  style="height: 38px !important;" lay-verify="required" autocomplete="off" class="layui-input" disabled id="acceptanceTime">\n' +
                    '        </div>\n' +
                    '    </div>\n' +
                    '</div>\n' +
                    '<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
                    '    <div class="layui-inline" style="width: 98%;">\n' +
                    '         <label class="layui-form-label" style="width: 15%;">验收描述</label>\n' +
                    '         <div class="layui-input-inline" style="width: 75%;">\n' +
                    '             <textarea type="text" disabled style="width:100%;min-height: 80px !important;" id="acceptanceDesc" lay-verify="required"  name="acceptanceDesc" autocomplete="off" class="layui-input"></textarea>\n' +
                    '         </div>\n' +
                    '    </div>\n' +
                    '</div>\n' +
                    '<div class="layui-input-inline" id="one11" style="margin-left: 130px;">\n' +
                    '<div id="fujians2"></div>\n' +
                    '<div id="fileAll2">\n' +
                    '</div>\n' +
                    '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
                    /*'<img src="../img/mg11.png" alt="">\n' +
                    '<span>添加附件</span>\n' +*/
                    '<input type="file" multiple id="fileupload2" data-url="/upload?module=workLog" disabled name="file">\n' +
                    '</a>\n' +
                    '</div>\n' +
					'</div>\n' +
                    '</form>\n';
				//var checkliId = tDataa.checkliId;
                layer.open({
                    type: 1,
                    skin: 'layui-layer-molv', //加上边框
                    area: ['70%', '70%'], //宽高
                    title: '检查单',
                    maxmin: true,
                    //btn: ['提交', '取消'],
					content: htm,
					success: function () {
                        $.ajax({
                            url:'/workflow/qualityManager/getDetailsInfoById?detailsInfoId='+tDataa.securityContentId,
                            dataType:'json',
                            type:'get',
                            async: false,
                            success:function(res){
                                if(res.code===0||res.code==="0"){
                                    console.log(res.obj);
                                    var datta = res.obj
									if(datta.needRecification!=0||datta.needRecification!='0'){
										$('#isShow').hide();
									}
									if(datta.needAcceptance!=0||datta.needAcceptance!='0'){
										$('#isShow1').hide();
									}
                                    $("#detailsId").val(datta.detailsId);

									$("#projectName1").val(datta.projectName);//渲染项目名称
									$("#testDept1").val(datta.testDeptName);//被检查单位
									$("#createUserName").val(datta.createUserName);//检查人
									$("#securityRegionName1").val(datta.securityRegionName);//检查区域
									$("#createTime").val(datta.createTime);//检查时间
									$("#securityDangerDesc").val(datta.securityDangerDesc);//隐患描述
									//附件
									fileuploadFn('#fileupload', $('#fileAll'));

									var str = ''
									if(datta.attachmentList!=undefined&&datta.attachmentList.length>0){
										for(var i=0;i<datta.attachmentList.length;i++){
											str+='<div class="dech" deUrl="' +datta.attachmentList[i].attUrl + '"><a href="/download?' + datta.attachmentList[i].attUrl + '" NAME="' + datta.attachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + datta.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + datta.attachmentList[i].aid + '@' + datta.attachmentList[i].ym + '_' + datta.attachmentList[i].attachId +',"></div>'
										}
									}else{
										str='';
									}
									$('#fileAll').append(str)

                                    //整改状态
                                    if(datta.rectificationUser==undefined||datta.rectificationUser==null){
                                        $('#rectification_span').text('未整改');
                                    }else{
                                        $('#rectification_span').text('已整改');
                                    }
									$("#rectificationUserName").val(datta.rectificationUserName);//整改人
									$("#rectificationTime").val(datta.rectificationTime);//整改时间
									$("#rectificationDesc").val(datta.rectificationDesc);//整改描述
									//附件
									fileuploadFn('#fileupload1', $('#fileAll1'));

									var str1 = ''
									if(datta.rectificationAttachmentList!=undefined&&datta.rectificationAttachmentList.length>0){
										for(var i=0;i<datta.rectificationAttachmentList.length;i++){
											str1+='<div class="dech" deUrl="' +datta.rectificationAttachmentList[i].attUrl + '"><a href="/download?' + datta.rectificationAttachmentList[i].attUrl + '" NAME="' + datta.rectificationAttachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + datta.rectificationAttachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + datta.rectificationAttachmentList[i].aid + '@' + datta.rectificationAttachmentList[i].ym + '_' + datta.rectificationAttachmentList[i].attachId +',"></div>'
										}
									}else{
										str1='';
									}
									$('#fileAll1').append(str1)

                                    //验收状态
                                    if(datta.acceptanceUser==undefined||datta.acceptanceUser==null){
                                        $('#acceptance_span').text('未验收');
                                    }else{
                                        $('#acceptance_span').text('已验收');
                                    }
									$("#acceptanceUserName").val(datta.acceptanceUserName);//验收人
									$("#acceptanceTime").val(datta.acceptanceTime);//验收时间
									$("#acceptanceDesc").val(datta.acceptanceDesc);//验收描述
									//附件
									fileuploadFn('#fileupload2', $('#fileAll2'));

									var str2 = ''
									if(datta.acceptanceAttachmentList!=undefined&&datta.acceptanceAttachmentList.length>0){
										for(var i=0;i<datta.acceptanceAttachmentList.length;i++){
											str2+='<div class="dech" deUrl="' +datta.acceptanceAttachmentList[i].attUrl + '"><a href="/download?' + datta.acceptanceAttachmentList[i].attUrl + '" NAME="' + datta.acceptanceAttachmentList[i].attachName +'*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + datta.acceptanceAttachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + datta.acceptanceAttachmentList[i].aid + '@' + datta.acceptanceAttachmentList[i].ym + '_' + datta.acceptanceAttachmentList[i].attachId +',"></div>'
										}
									}else{
										str2='';
									}
									$('#fileAll2').append(str2)
                                }
                            }
                        })

						/*Array.prototype.remove = function(val) {
                            var index = this.indexOf(val);
                            if (index > -1) {
                                this.splice(index, 1);
                            }
                        };*/
                        form.render();//初始化表单
                    },
                    /*yes: function (index, layero) {

                    }*/
                });
            }else if(layEvent === 'flowsheet'){ //流程图
				layer.open({
					type: 1,
					skin: 'layui-layer-molv', //加上边框
					area: ['50%', '90%'], //宽高
					title: '流程监控信息',
					maxmin: true,
					//btn: ['确定'],
					content: '<div id="steps"></div>' +
							'<ul class="progress_box">\n' +
							'  </ul>',
					success: function () {
						var data = [];
						$.ajax({
							url:'/workflow/qualityManager/flowChart?securityContentId='+tDataa.securityContentId,
							type: 'post',
							dataType:'json',
							success:function(res){
								if(res.code===0||res.code==="0"){
									//layer.closeAll();
									for(var i = 0;i < res.data.length; i++){
										data.push(res.data[i]);
									}

									make(data, '#steps', 3)

									layer.msg(res.msg)
									console.log(data);

								}
							}
						})
						/*var data = [
                            {'title': "第一步", "desc": "2018-07-01 10:24:42"},
                            {'title': "第二步", "desc": "2018-07-01 10:44:42"},
                            {'title': "第三步", "desc": "2018-07-01 10:44:42"},
                            {'title': "第四步", "desc": "2018-07-01 10:44:42"},
                            {'title': "第五步", "desc": "2018-07-01 10:44:42"}
                        ];*/
					},
					/*yes: function (index, layero) {
						layer.close(index)
					}*/
				});
			}
        })
		//行内查看
		table.on('tool(formTable2)', function(obj){
			var tData = obj.data;
			var layEvent = obj.event;
			console.log(tData);
			if(layEvent === 'check'){//质量记录详情页面中的查看
				layer.open({
					type: 1,
					skin: 'layui-layer-molv', //加上边框
					area: ['80%', '80%'], //宽高
					title: '检查记录',
					maxmin: true,
					//btn: ['提交', '取消'],
					content: '		<form class="layui-form" action="" style="height: 40px"><div class="layui-form" style="margin-top: 20px;">\n' +
						'		<div class="layui-form-item" style="width: 30%;margin:10px 0;display: inline-block">\n' +
						'		    <div class="layui-inline" style="width: 98%;margin-left: -15px">\n' +
						'		         <label class="layui-form-label" style="width: 30%;">检查区域</label>\n' +
						'		         <div class="layui-input-inline" style="width: 45%;">\n' +
						'             		<input class="layui-input" id="securityRegionName" pid3 autocomplete="off"  name="securityRegionName" placeholder="请选择区域" style="height: 38px;margin-left: 6px;position: absolute;">\n' +
						'             		<div class="eleTree eleb4 region" lay-filter="dataX" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:6px;width: 100%;"></div>\n' +
						'		         </div>\n' +
						'		    </div>\n' +
						'		</div>\n' +
						'		<div class="layui-form-item" style="width: 30%;margin:10px 0;display: inline-block">\n' +
						'		    <div class="layui-inline" style="width: 98%;margin-left: -30px">\n' +
						'		         <label class="layui-form-label" style="width: 30%;">整改状态</label>\n' +
						'		         <div class="layui-input-inline" style="width: 45%;">\n' +
						'		             <select id="recification" name="recification" style="height: 38px;margin-left: 6px; cursor: pointer;">\n' +
						'		         		<option value="" >请选择</option>\n' +
						'		         		<option value="1">已整改</option>\n' +
						'		         		<option value="0">未整改</option>\n' +
						'		         	 </select>\n' +
						'		         </div>\n' +
						'		    </div>\n' +
						'		</div>\n' +
						'		<div class="layui-form-item" style="width: 30%;margin:10px 0;display: inline-block">\n' +
						'		    <div class="layui-inline" style="width: 98%;margin-left: -45px">\n' +
						'		         <label class="layui-form-label" style="width: 30%;">验收状态</label>\n' +
						'		         <div class="layui-input-inline" style="width: 45%;">\n' +
						'		             <select id="acceptance" name="acceptance"  style="height: 38px;margin-left: 6px; cursor: pointer;">\n' +
						'		         		<option value="">请选择</option>\n' +
						'		         		<option value="3">已验收</option>\n' +
						'		         		<option value="0,1">未验收</option>\n' +
						'		         	 </select>\n' +
						'		         </div>\n' +
						'		    </div>\n' +
						'		</div>\n' +
						'		<div class="layui-input-inline" style="height: 32px;margin-top: -5px;">\n' +
						'			<a class="layui-btn" data-type="reload" lay-event="searchCust1" id="searchCust1" style="height:32px;line-height: 32px;margin-left: -35px">搜索</a>\n' +
						'		</div>\n' +
						'		</div></form>\n' +
                        '    <div style="width: 88%;margin: 20px auto;"><table id="formTable3" lay-filter="formTable3"></table></div>',
					success: function () {

						detailsInit3 = table.render({
							elem: '#formTable3'
							, page:true
							,data:tData.knowledgeValue
							//,url:'/workflow/qualityManager/selectDetailInfo?checkliId='+tData.checkliId
							//,toolbar:'#formTable1toolbar3'
							,cols: [[
								{type: 'numbers',title:'序号',width:60}
								,{field:'securityGradeName',title:'隐患级别'}
								,{field: 'securityDangerDesc', title: '隐患描述'}
								,{field: 'securityDangerMeasures', title: '整改措施'}
								,{field: 'securityRegionName', title: '检查区域'}
								, {field: 'rectificationId', title: '整改状态',templet: function (d) {
										if(d.needRecification===1||d.needRecification==="1"){
											return '<span>不需要整改</span>'
										}else {
											if(d.recificationStatus=='1'||d.recificationStatus=='3'){
												return  '<span>已整改</span>'
											}else{
												return  '<span>未整改</span>'
											}
										}
									}}
								, {field: 'rectificationId', title: '验收状态',templet: function (d) {
										if(d.needAcceptance===1||d.needAcceptance==="1"){
											return '<span>不需要验收</span>'
										}else{
											if(d.recificationStatus=='3'){
												return  '<span>已验收</span>'
											}else{
												return  '<span>未验收</span>'
											}
										}
									}}
								,{title: '操作', align: 'center', toolbar: '#formTable1bar1',width:100}
								,{title: '操作',align:'center', toolbar: '#barOperation',width:100,}
							]],
							done:function(obj, curr, count){
								detailsInitData3 = obj.data;
							}
						});
						//渲染检查区域
						$(document).on("click","[name='securityRegionName']",function (e) {
							e.stopPropagation();
							if(tData.projectId == null|| tData.projectId == undefined){
								layer.msg('项目名称为空')
							}else{
								eleTree.render({
									elem: '.eleb4',
									url:'/workflow/qualityManager/getRegionByProject?projectId='+tData.projectId,
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
								url:'/workflow/qualityManager/getRegionById?regionId='+parData.regionId,
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
							$("#securityRegionName").val(str111)
							$("#securityRegionName").attr("pid3",parData.id)
						});
						form.render();//初始化表单

						$('#searchCust1').click(function () {
							//debugger
							var serchObjUrl = "/workflow/qualityManager/serchDetailInfo?securityKnowledgeId="+tData.securityKnowledgeId+"&checkliId="+tData.checkliId;
							var searchtext = $("#securityRegionName").attr("pid3");
							var searchtext1 = $("#recification").val();
							var searchtext2 = $("#acceptance").val();
							if(searchtext!=""&&searchtext!=undefined){
								serchObjUrl+="&securityRegionId="+searchtext;
							}
							if(searchtext1!=""&&searchtext1!=undefined&&searchtext2!=""&&searchtext2!=undefined){
								if((searchtext1==1||searchtext1=="1")&&(searchtext2==3||searchtext2=="3")){//已整改已验收
									serchObjUrl+="&recificationStatus="+searchtext2;
								}else if((searchtext1==0||searchtext1=="0")&&(searchtext2==3||searchtext2=="3")){//未整改已验收
									serchObjUrl+="&recificationStatus="+searchtext2;
								}else if((searchtext1==1||searchtext1=="1")&&(searchtext2==(0,1)||searchtext2=="0,1")){//已整改未验收
									serchObjUrl+="&recificationStatus="+searchtext1;
								}else {//未整改未验收
									serchObjUrl+="&recificationStatus="+searchtext1;
								}
							}else if((searchtext1!=""&&searchtext1!=undefined)||(searchtext2!=""&&searchtext2!=undefined)){
								serchObjUrl+="&recificationStatus="+searchtext1+','+searchtext2;
							}else {
								serchObjUrl+="&recificationStatus="+searchtext1+','+searchtext2;
							}
							table.reload("formTable3",{
								url: serchObjUrl
							});
						})
					},
					/*yes: function (index, layero) {

					}*/
				});
			}
		})
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

	//流程图
	function make (data, ele, current) {
		var html = ''
				, data_length = data.length
				, percentage = 100 / data_length;

		for (var i = 0; i < data_length; i++) {
			var icon = ''
					, tail = '';
			if (i < current) {
				icon = 'layui-icon-ok';
				tail = 'step-item-tail-done';
			}

			var temp = '<div class="step-item" style="height: ' + percentage + '%;">';

			if (icon) {
				temp += '<div><div class="step-item-head"><i class="layui-icon ' + icon + '"></i></div>';
			} else {
				temp += '<div><div class="step-item-head step-item-head-active"><i class="layui-icon">' + (parseInt(i) + 1) + '</i></div>'
			}
			temp += '<div class="step-item-main"><div class="step-item-main-title">' + undefind_nullStr(data[i].title) + '</div><div class="step-item-main-desc">' + undefind_nullStr(data[i].desc) + '</div></div></div>';

			if (parseInt(i) + 1 < data_length) {
				temp += '<div class="step-item-tail"><i class="' + tail + '"></i></div></div><br/>';
			}

			html += temp;
		}

		$(ele).append(html);
	}
</script>
</body>
</html>
