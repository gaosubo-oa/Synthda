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
	<title>新增安全检查</title>
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
		/*.textAreaBox{
			width: 100%;
			max-width: 100%;
			cursor: pointer;
			margin: 0px;
			overflow-y:visible;
			min-height: 37px;
		}*/
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

		/*.img{
			width: 94%;
			margin: auto;
			position:relative;
			margin:50px 50px;
		}
		.img .marker{
			position:absolute;
			width:20px;
			height:20px;
			background:#f00;
			border-radius: 50%;
		}*/

	</style>
</head>
<body>
<form  class="layui-form" id="form" lay-filter="formTest">
	<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">安全检查单</div>
	<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
		<div class="layui-inline" style="width: 98%;">
			<label class="layui-form-label" style="width: 30%;">项目名称</label>
			<div class="layui-input-inline" style="width: 55%;">
				<input type="text" disabled id="aqProjName" lay-verify="required" name="aqProjName" autocomplete="off" class="layui-input">
				<input type="hidden" disabled id="detailsId" lay-verify="required" name="detailsId" class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">
		<div class="layui-inline" style="width: 98%;">
			<label class="layui-form-label" style="width: 30%;">检查类型</label>
			<div class="layui-input-inline" style="width: 55%;">
				<select id="aqTestType" disabled lay-verify="required" name="aqTestType"></select>
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
<div style="margin: 7px 23px;width: 95%;height:36px;line-height:36px;font-weight:bold;padding-left: 6px;background-color: #eeeeee">检查内容</div>
<div style="width: 88%;margin: auto;"><table id="formTable2" lay-filter="formTable2"></table></div>
<script type="text/html" id="formTable1toolbar2">
	<div class="layui-btn-container" style="height: 30px;">
		<%--<input type="button" class="layui-btn layui-btn-sm" lay-event="addTest" value="新增">
		<input type="button" class="layui-btn layui-btn-sm" lay-event="delTest" value="删除">--%>
		<%--<input type="button" class="layui-btn layui-btn-sm" lay-event="examineTest" value="执行检查">--%>
	</div>
</script>
<script type="text/html" id="formTable1bar">

	{{#  if(d.checkFlag == 1){ }}
	<div class="layui-btn-container" style="height: 30px;">
		<input type="button" class="layui-btn <%--layui-disabled--%> layui-btn-sm" <%--disabled--%> lay-event="initialization" value="已检查" style="width: 68px; align-content: center;background-color: #666;">
	</div>
	{{#  } }}
	{{#  if(d.checkFlag == 0){ }}
	<div class="layui-btn-container" style="height: 30px;">
		<input type="button" class="layui-btn <%--layui-disabled--%> layui-btn-sm" <%--disabled--%> lay-event="initialization" value="执行检查" style="width: 68px;align-content: center">
	</div>
	{{#  } }}
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
	var securityInfoDate = parent.securityInfoDate;//安全检查
	console.log(securityInfoDate)

	var user_id;
	var detailsInit;
	var detailsInitData=[];
	var detailsInit2;
	var detailsInitData2=[];
	var isShow;
	var isShow1;
	var dept_id;
	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}
	var columnId = parent.columnTrId;//getUrlParam('columnId');
	var SettlementTable;

	layui.use(['table','layer','form','element','eleTree','upload','layedit','laydate'], function() {
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		var eleTree = layui.eleTree;
		var element = layui.element;
		var $ = layui.jquery;
		var upload = layui.upload;
		var layedit = layui.layedit;
		var laydate = layui.laydate;

		$(document).on("click", "#rectificationPersion", function () { //整改人
			user_id = "rectificationPersion";
			$.popWindow("/projectTarget/selectOwnDeptUser?0");
		})

		$(document).on("click", "#acceptancePersion", function () { //验收人
			user_id = "acceptancePersion";
			$.popWindow("/projectTarget/selectOwnDeptUser?0");
		})
		//选部门控件添加
		$(document).on('click', '#testDeptId', function () {
			dept_id = "testDeptId";
			$.popWindow("/common/selectDept?0");
		});
		$(document).on('click', '#testLeader', function () {
			user_id = "testLeader";
			$.popWindow("/projectTarget/selectOwnDeptUser?0");
		})

		//回显
		$("#detailsId").val(securityInfoDate.detailsId);
		//渲染检查类型
		var $select1 = $("#aqTestType");
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
		//渲染项目名称
		$("#aqProjName").val(securityInfoDate.projectName);
		// var $select2 = $("#aqProjName");
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
		$("#testDept").val(securityInfoDate.testDeptName);
		$("#testDept").attr("deptid",securityInfoDate.testDept);
		//选部门控件添加
		$("#testLeader").val(securityInfoDate.testLeaderName);
		$("#testLeader").attr("user_id",securityInfoDate.testLeader);

		detailsInit = table.render({
			elem: '#formTable1'
			, page:true
			,url:'/workflow/secirityManager/selectChecklistDetails?checkId='+securityInfoDate.checkliId
			//,toolbar:'#formTable1toolbar'
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
		form.render();
		detailsInit2 = table.render({
			elem: '#formTable2'
			, page:true
			,url:'/workflow/secirityManager/selectDetailInfo?checkliId='+securityInfoDate.checkliId
			,toolbar:'#formTable1toolbar2'
			,cols: [[
				{type: 'checkbox'}
				,{field:'securityRegionName',title:'检查区域',width:100}
				,{field: 'securityKnowledgeName', title: '检查项',width:80}
				,{field: 'urls', title: '图纸位置',event: 'drawing',width:100, style:'cursor: pointer;color:blue',templet:function(d){
						if((d.regionX!=undefined&&d.regionX!="")&&(d.regionY!=undefined&&d.regionY!="")){
							return "已标注"
						}else{
							return "未标注";
						}
					}}
				,{field: 'securityDanger', title: '检查内容',width:100}
				//,{field: '', title: '隐患照片'}
				,{field: 'dangerGrade', title: '隐患级别',width:100,templet:function(d){
						if(d.securityGrade===0||d.securityGrade==="0"){
							return "重大隐患"
						}else if(d.securityGrade===1||d.securityGrade==="1"){
							return "一般隐患"
						}else{
							return "";
						}
					}}
				,{field: 'securityDangerMeasures',width:100, title: '整改措施'}
				,{field: 'needRecification', title: '是否需要整改',width:120,templet:function(d){
						if(d.needRecification===0||d.needRecification==="0"){
							return "需要"
						}else if(d.needRecification===1||d.needRecification==="1"){
							return "不需要"
						}else{
							return ""
						}
					}}
				,{field: 'rectificationPeriod', title: '整改期限',width:100}
				,{field: 'rectificationPersionName', title: '整改人',width:80}
				,{field: 'needAcceptance', title: '是否需要验收',width:120,templet:function(d){
						if(d.needAcceptance===0||d.needAcceptance==="0"){
							return "需要"
						}else if(d.needAcceptance===1||d.needAcceptance==="1"){
							return "不需要"
						}else{
							return ""
						}
					}}
				,{field: 'acceptancePersionName', title: '验收人',width:80}
				,{field: 'checkFlag', title: '检查状态',width:100,templet:function(d){
						if(d.checkFlag===0||d.checkFlag==="0"){
							return "未检查"
						}else if(d.checkFlag===1||d.checkFlag==="1"){
							return "已检查"
						}else{
							return ""
						}
					}}
				,{title: '操作', align: 'center', fixed:'right',toolbar: '#formTable1bar',width:100}
			]],
			done:function(obj, curr, count){
				detailsInitData2 = obj.data;
			}
		});
		form.render();

		// 执行检查
		/*table.on('toolbar(formTable2)', function (obj) {
			var events = obj.event;
			var datas = table.checkStatus('formTable2').data;
			if (events == 'examineTest') {
				if (datas.length != 1) {
					layer.msg("请选择一条");
				} else {
					var checkDate = datas[0];
					//console.log(checkDate);
					layer.open({
						type: 1,
						skin: 'layui-layer-molv', //加上边框
						area: ['80%', '80%'], //宽高
						title: '执行检查',
						maxmin: true,
						btn: ['提交', '取消'],
						content: '<form class="layui-form" id="form1" lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>检查区域</label>\n' +
								'         <div class="layui-input-inline" style="width: 55%;">\n' +
								'<input type="text" placeholder="请选择" disabled id="region" pid name="ttitle3" style="cursor: pointer;height: 38px !important;" autocomplete="off" class="layui-input">' +
								'<div class="eleTree ele3" lay-filter="data3" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
								//'             <input type="text" id="region" lay-verify="required" name="region" autocomplete="off" class="layui-input">\n' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>检查项</label>\n' +
								'         <div class="layui-input-inline" style="width: 55%;">\n' +
								'             <input type="text" disabled id="hiddenDanger" pid2 lay-verify="required" style="cursor: pointer;height: 38px !important;" name="ttitle4" autocomplete="off" class="layui-input">\n' +
								//'<div class="eleTree ele4" lay-filter="data4" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 30%;">图纸位置</label>\n' +
								'         <div class="layui-input-inline" style="width: 55%;margin-top: 6px;">\n' +
								'             <span id="drawingImg" style="cursor: pointer;color:blue;"></span>\n' +
								'         </div>\n' +
								'<input hidden id="urls" name="urls"/>' +
								'<input hidden id="securityContentId" name="securityContentId"/>' +
								'    </div>\n' +
								'</div>\n' +
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 30%;">隐患级别</label>\n' +
								'         <div class="layui-input-inline" style="width: 55%;">\n' +
								'             <input type="text" securityGrade id="dangerGrade" disabled lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input">\n' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								'<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 15%;">检查内容</label>\n' +
								'         <div class="layui-input-inline" style="width: 75%;">\n' +
								'             <textarea type="text" pid3 disabled style="width:100%;min-height: 80px !important;" id="securityDanger" lay-verify="required" name="securityDanger" autocomplete="off" class="layui-input"></textarea>\n' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								'<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 15%;">整改措施</label>\n' +
								'         <div class="layui-input-inline" style="width: 75%;">\n' +
								'             <textarea type="text" disabled style="width:100%;min-height: 80px !important;" id="securityDangerMeasures" lay-verify="required" name="securityDangerMeasures" autocomplete="off" class="layui-input"></textarea>\n' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								/!*'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                                '    <div class="layui-inline" style="width: 98%;">\n' +
                                '         <label class="layui-form-label" style="width: 30%;">是否需要验收</label>\n' +
                                '         <div class="layui-input-inline" style="width: 55%;">\n' +
                                '             <select id="needAcceptance" name="needAcceptance">\n' +
                                '              <option value="">请选择</option><option value="0">是</option><option value="1">否</option>\n' +
                                '             </select>\n' +
                                '         </div>\n' +
                                '    </div>\n' +
                                '</div>\n' +*!/
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
								'	<div class="layui-form-item" style="width: 98%; pane="">\n' +
								'		<label class="layui-form-label" style="width: 30%;">是否需要整改</label>\n' +
								'		<div class="layui-input-block" style="width: 55%;">\n' +
								'			<input type="checkbox" checked name="close" id="needRecification" pid5 lay-skin="switch" lay-filter="switchTest" lay-text="是|否">\n' +
								'		</div>\n' +
								'	</div>\n' +
								'</div><br/>\n' +
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="PeriodShow">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 30%;">整改期限</label>\n' +
								'         <div class="layui-input-inline" style="width: 55%;">\n' +
								'             <input class="layui-input" style="height: 38px !important;" lay-verify="required" id="rectificationPeriod">\n' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="PersionShow">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 30%;">整改人</label>\n' +
								'         <div class="layui-input-inline" style="width: 55%;">\n' +
								'             <input class="layui-input" style="height: 38px !important;" lay-verify="required" id="rectificationPersion">\n' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="switchShow">\n' +
								'	<div class="layui-form-item" style="width: 98%; pane="">\n' +
								'		<label class="layui-form-label" style="width: 30%;">是否需要验收</label>\n' +
								'		<div class="layui-input-block" style="width: 55%;">\n' +
								'			<input type="checkbox" checked name="close" id="needAcceptance" pid7 lay-skin="switch" lay-filter="switchTest1" lay-text="是|否">\n' +
								'		</div>\n' +
								'	</div>\n' +
								'</div><br/>\n' +
								'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="acceptanceShow">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 30%;">验收人</label>\n' +
								'         <div class="layui-input-inline" style="width: 55%;">\n' +
								'             <input class="layui-input" style="height: 38px !important;"  lay-verify="required" id="acceptancePersion">\n' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								'<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
								'    <div class="layui-inline" style="width: 98%;">\n' +
								'         <label class="layui-form-label" style="width: 15%;">隐患描述</label>\n' +
								'         <div class="layui-input-inline" style="width: 75%;">\n' +
								'             <textarea type="text" style="width:100%;min-height: 80px !important;" id="securityDangerDesc" lay-verify="required" name="securityDangerDesc" autocomplete="off" class="layui-input"></textarea>\n' +
								'         </div>\n' +
								'    </div>\n' +
								'</div>\n' +
								/!*'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                                '    <div class="layui-inline" style="width: 98%;">\n' +
                                '         <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>隐患照片</label>\n' +
                                '         <div class="layui-input-inline" style="width: 55%;">\n' +
                                '             <input type="text" style="width: 62%;float:left;height: 38px !important;" id="dangersPhotos" name="dangersPhotos" lay-verify="required" autocomplete="off" class="layui-input"><button type="button" class="layui-btn" id="but_chose" style=" float: right"> <i class="layui-icon">&#xe67c;</i>选择图片</button>\n' +
                                '         </div>\n' +
                                '    </div>\n' +
                                '</div>\n' +*!/
								'<div class="layui-input-inline" style="margin-left: 130px;">\n' +
								'<div id="fujians"></div>' +
								' <div id="fileAll">\n' +
								'</div>\n' +
								'<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
								'<img src="../img/mg11.png" alt="">\n' +
								'<span>添加附件</span>\n' +
								'<input type="file" multiple id="fileupload" data-url="/upload?module=H5" name="file">\n' +
								'</a>\n' +
								'</div>\n' +
								'</div></form>',
						success: function () {
							//form.render("select");//初始化表单
							//fileuploadFn('#fileupload', $('#fileAll'));
							laydate.render({
								elem: '#rectificationPeriod'
								, trigger: 'click'//呼出事件改成click
							});

							//var detailsId = $("#detailsId").val();
							$('#region').val(checkDate.securityRegionName);//检查区域
							$('#region').attr('pid', checkDate.securityRegionId);//检查区域id
							$('#hiddenDanger').val(checkDate.securityKnowledgeName);//检查项
							$('#hiddenDanger').attr('pid2', checkDate.securityKnowledgeId);//检查项id
							$('#dangerGrade').val(checkDate.securityGradeName);//隐患级别
							$('#dangerGrade').attr('securityGrade', checkDate.securityGrade);
							$('#securityDangerMeasures').val(checkDate.securityDangerMeasures);//整改措施
							$('#securityDanger').val(checkDate.securityDanger);//检查内容
							$('#securityDanger').attr('pid3', checkDate.securityDangerId);//检查内容id

							//$("#needAcceptance").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value',checkDate.needAcceptance);

							if (checkDate.needRecification === 0 || checkDate.needRecification === '0') {
								isShow = true;
								$('#needRecification').prop('checked', 'checked');
								$('#PeriodShow').show();
								$('#PersionShow').show();
								$('#switchShow').show();
								if (checkDate.needAcceptance === 0 || checkDate.needAcceptance === '0') {
									isShow1 = true;
									$('#needAcceptance').prop('checked', 'checked');
									$('#acceptanceShow').show();
								} else {
									$('#acceptanceShow').hide();
								}
							} else {
								isShow = false;
								isShow1 = false;
								$('#PeriodShow').hide();
								$('#PersionShow').hide();
								$('#switchShow').hide();
								$('#acceptanceShow').hide();
							}

							//$("#needRecification").attr("pid5",checkDate.needRecification);//是否需要整改
							$("#rectificationPeriod").val(checkDate.rectificationPeriod);//整改期限
							$("#rectificationPersion").attr("user_id", checkDate.rectificationPersion);//整改人id
							$("#rectificationPersion").val(checkDate.rectificationPersionName);//整改人
							//$("#needAcceptance").attr("pid7",checkDate.needAcceptance);//是否需要验收
							$("#acceptancePersion").attr("user_id", checkDate.acceptancePersion);//验收人id
							$("#acceptancePersion").val(checkDate.acceptancePersionName); //验收人
							$("#securityDangerDesc").val(checkDate.securityDangerDesc);//隐患描述
							$('#urls').val(checkDate.urls)//图纸位置

							//图纸位置
							if ((checkDate.regionX != undefined && checkDate.regionX != "") && (checkDate.regionY != undefined && checkDate.regionY != "")) {
								$('#drawingImg').text("已标注");
							} else {
								$('#drawingImg').text("未标注");
							}

							//debugger
							//附件
							fileuploadFn('#fileupload', $('#fileAll'));

							var str = ''

							if (checkDate.attachmentList != undefined && checkDate.attachmentList.length > 0) {
								for (var i = 0; i < checkDate.attachmentList.length; i++) {
									str += '<div class="dech" deUrl="' + checkDate.attachmentList[i].attUrl + '"><a href="/download?' + checkDate.attachmentList[i].attUrl + '" NAME="' + checkDate.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + checkDate.attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + checkDate.attachmentList[i].aid + '@' + checkDate.attachmentList[i].ym + '_' + checkDate.attachmentList[i].attachId + ',"></div>'
								}
							} else {
								str = '';
							}
							$('#fileAll').append(str)

							$("#securityContentId").val(checkDate.securityContentId);


							Array.prototype.remove = function (val) {
								var index = this.indexOf(val);
								if (index > -1) {
									this.splice(index, 1);
								}
							};

							$('#drawingImg').on("click", function () {
								$.popWindow("/workflow/secirityManager/selectDrawing?layEvent2=examineTest&securityContentId=" + checkDate.securityContentId);
							})

							form.on('switch(switchTest)', function (data) {
								if (data.elem.checked == true) {
									isShow = true;
									$('#PeriodShow').show();
									$('#PersionShow').show();
									$('#switchShow').show();
									if (isShow1) {
										$('#acceptanceShow').show();
									} else {
										$('#acceptanceShow').hide();
									}
								} else {
									isShow = false;
									//isShow1 = false;

									$('#PeriodShow').hide();
									$('#PersionShow').hide();
									$('#switchShow').hide();
									$('#acceptanceShow').hide();
									//$('#needAcceptance').next().removeClass('layui-form-onswitch');
								}
							});
							form.on('switch(switchTest1)', function (data) {
								if (data.elem.checked == true) {
									isShow1 = true;
									$('#acceptanceShow').show();
								} else {
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
							if (isShow == true) {
								var needRecification = 0;
								//是否需要验收
								if (isShow1 == true) {
									var needAcceptance = 0;
								} else {
									var needAcceptance = 1;
								}
							} else {
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

							if (rectificationPersion != undefined || rectificationPersion != null) {
								if (rectificationPersion.substring(rectificationPersion.length - 1, rectificationPersion.length) == ",") {
									rectificationPersion = rectificationPersion.substring(0, rectificationPersion.length - 1);
								}
							}

							if (acceptancePersion != undefined || acceptancePersion != null) {
								if (acceptancePersion.substring(acceptancePersion.length - 1, acceptancePersion.length) == ",") {
									acceptancePersion = acceptancePersion.substring(0, acceptancePersion.length - 1);
								}
							}

							if (rectificationPersionName != undefined || rectificationPersionName != null) {
								if (rectificationPersionName.substring(rectificationPersionName.length - 1, rectificationPersionName.length) == ",") {
									rectificationPersionName = rectificationPersionName.substring(0, rectificationPersionName.length - 1);
								}
							}

							if (acceptancePersionName != undefined || acceptancePersionName != null) {
								if (acceptancePersionName.substring(acceptancePersionName.length - 1, acceptancePersionName.length) == ",") {
									acceptancePersionName = acceptancePersionName.substring(0, acceptancePersionName.length - 1);
								}
							}

							var details = {
								securityRegionId: securityRegionId,
								securityRegionName: securityRegionName,
								securityKnowledgeId: securityKnowledgeId,
								securityKnowledgeName: securityKnowledgeName,
								attachmentId: attachmentId,
								attachmentName: attachmentName,
								securityGrade: securityGrade,
								securityGradeName: securityGradeName,
								securityDangerMeasures: securityDangerMeasures,
								securityDanger: securityDanger,
								securityDangerId: securityDangerId,
								//needAcceptance:needAcceptance,
								rectificationPeriod: rectificationPeriod,
								rectificationPersion: rectificationPersion,
								rectificationPersionName: rectificationPersionName,
								acceptancePersion: acceptancePersion,
								acceptancePersionName: acceptancePersionName,
								securityDangerDesc: securityDangerDesc,
								attachmentId: attachmentId,
								attachmentName: attachmentName,
								securityContentId: securityContentId,
								urls: urls,
								needRecification: needRecification,
								needAcceptance: needAcceptance,
								checkFlag: 1
							}
							var details2 = {
								//needAcceptance:needAcceptance,
								rectificationPeriod: rectificationPeriod,
								rectificationPersion: rectificationPersion,
								rectificationPersionName: rectificationPersionName,
								acceptancePersion: acceptancePersion,
								acceptancePersionName: acceptancePersionName,
								securityDangerDesc: securityDangerDesc,
								attachmentId: attachmentId,
								attachmentName: attachmentName,
								securityContentId: securityContentId,
								urls: urls,
								needRecification: needRecification,
								needAcceptance: needAcceptance,
								checkFlag: 1
							}
							//debugger
							//detailsInitData2.push(details);
							var countt = null;
							for (var i = 0; i <= detailsInitData2.length; i++) {
								if (detailsInitData2[i].securityContentId == securityContentId) {
									countt = i;
									break;
								}
							}
							if (countt != null) {
								detailsInitData2[countt] = details;
							}
							detailsInit2.reload({
								url: '', data: detailsInitData2
								, done: function (d) {
									layer.close(index)
								}
							});
							$.ajax({
								url: '/workflow/secirityManager/updateDetailsInfo',
								type: 'post',
								dataType: 'json',
								data: details2,
								success: function (res) {
									if (res.code === 0 || res.code === "0") {
										//layer.closeAll();
										layer.msg(res.msg)
									}

								}
							})
						}
						, btn2: function (index, layero) {
							layer.close(index);
						}
					});
				}
			}
		})*/
		//行内执行检查
		table.on('tool(formTable2)', function (obj) {
			var tData = obj.data;
			var layEvent = obj.event;
			if (layEvent === 'initialization') {
				if(tData.checkStatus!="0"){ //已提交
					btnArr=[ '取消']
				}else{
					btnArr=['提交','取消']
				}
				layer.open({
					type: 1,
					skin: 'layui-layer-molv', //加上边框
					area: ['80%', '80%'], //宽高
					title: '执行检查',
					maxmin: true,
					btn: btnArr,
					content: '<form class="layui-form" id="form1"  lay-filter="formTest1"><div class="layui-form" style="margin-top: 20px;">' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>检查区域</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'<input type="text" placeholder="请选择" disabled id="region" pid name="ttitle3" style="cursor: pointer;height: 38px !important;" autocomplete="off" class="layui-input">' +
							'<div class="eleTree ele3" lay-filter="data3" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
							//'             <input type="text" id="region" lay-verify="required" name="region" autocomplete="off" class="layui-input">\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>检查项</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'             <input type="text" disabled id="hiddenDanger" pid2 lay-verify="required" style="cursor: pointer;height: 38px !important;" name="ttitle4" autocomplete="off" class="layui-input">\n' +
							//'<div class="eleTree ele4" lay-filter="data4" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;">图纸位置</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;margin-top: 6px;">\n' +
							'             <span id="drawingImg" style="cursor: pointer;color:blue;"></span>\n' +
							'         </div>\n' +
							'<input hidden id="urls" name="urls"/>' +
							'<input hidden id="securityContentId" name="securityContentId"/>' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;">隐患级别</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'             <input type="text" securityGrade id="dangerGrade" disabled lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input">\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 15%;">检查内容</label>\n' +
							'         <div class="layui-input-inline" style="width: 75%;">\n' +
							'             <textarea type="text" pid3 disabled style="width:100%;min-height: 80px !important;" id="securityDanger" lay-verify="required" name="securityDanger" autocomplete="off" class="layui-input"></textarea>\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 15%;">整改措施</label>\n' +
							'         <div class="layui-input-inline" style="width: 75%;">\n' +
							'             <textarea type="text" disabled style="width:100%;min-height: 80px !important;" id="securityDangerMeasures" lay-verify="required" name="securityDangerMeasures" autocomplete="off" class="layui-input"></textarea>\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;">检查时间</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'             <input class="layui-input" style="height: 38px !important;" lay-verify="required" id="checkTime">\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div><br>\n' +
							/*'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;">是否需要验收</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'             <select id="needAcceptance" name="needAcceptance">\n' +
							'              <option value="">请选择</option><option value="0">是</option><option value="1">否</option>\n' +
							'             </select>\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +*/
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'	<div class="layui-form-item" style="width: 98%; pane="">\n' +
							'		<label class="layui-form-label" style="width: 30%;">是否需要整改</label>\n' +
							'		<div class="layui-input-block" style="width: 55%;">\n' +
							'			<input type="checkbox"  name="close" id="needRecification" pid5 lay-skin="switch" lay-filter="switchTest" lay-text="是|否">\n' +
							'		</div>\n' +
							'	</div>\n' +
							'</div><br/>\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="PeriodShow">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;">整改期限</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'             <input class="layui-input" style="height: 38px !important;" lay-verify="required" id="rectificationPeriod">\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="PersionShow">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;">整改人</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'             <input class="layui-input" style="height: 38px !important;" lay-verify="required" id="rectificationPersion">\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 98%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 15%;">隐患描述</label>\n' +
							'         <div class="layui-input-inline" style="width: 75%;">\n' +
							'             <textarea type="text" style="width:100%;min-height: 80px !important;" id="securityDangerDesc" lay-verify="required" name="securityDangerDesc" autocomplete="off" class="layui-input"></textarea>\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="switchShow">\n' +
							'	<div class="layui-form-item" style="width: 98%; pane="">\n' +
							'		<label class="layui-form-label" style="width: 30%;">是否需要验收</label>\n' +
							'		<div class="layui-input-block" style="width: 55%;">\n' +
							'			<input type="checkbox" name="close" id="needAcceptance" pid7 lay-skin="switch" lay-filter="switchTest1" lay-text="是|否">\n' +
							'		</div>\n' +
							'	</div>\n' +
							'</div><br/>\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block" id="acceptanceShow">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;">验收人</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'             <input class="layui-input"  style="height: 38px !important;"  lay-verify="required" id="acceptancePersion">\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div><br/>\n' +
							/*'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'    <div class="layui-inline" style="width: 98%;">\n' +
							'         <label class="layui-form-label" style="width: 30%;"><span style="color:red">*</span>隐患照片</label>\n' +
							'         <div class="layui-input-inline" style="width: 55%;">\n' +
							'             <input type="text" style="width: 62%;float:left;height: 38px !important;" id="dangersPhotos" name="dangersPhotos" lay-verify="required" autocomplete="off" class="layui-input"><button type="button" class="layui-btn" id="but_chose" style=" float: right"> <i class="layui-icon">&#xe67c;</i>选择图片</button>\n' +
							'         </div>\n' +
							'    </div>\n' +
							'</div>\n' +*/
							'<div class="layui-input-inline" style="margin-left: 130px;">\n' +
							'<div id="fujians"></div>' +
							' <div id="fileAll">\n' +
							'</div>\n' +
							'<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">\n' +
							'<img src="../img/mg11.png" alt="">\n' +
							'<span>添加附件</span>\n' +
							'<input type="file" multiple id="fileupload" data-url="/upload?module=H5" name="file">\n' +
							'</a>\n' +
							'</div>\n' +
							'</div></form>',
					success: function () {
						//form.render("select");//初始化表单
						//fileuploadFn('#fileupload', $('#fileAll'));

						/*var uploadInst = upload.render({
                            elem: '#but_chose' //绑定元素
                            , url: '/upload?module=security '//上传接口
                            , accept: 'file'
                            , auto: true
                            , bindAction: '#uploadButton'
                            , multiple: false
                            , choose: function (obj) {
                                obj.preview(function (index, file, result) {
                                    $('#attachmentName').val(file.name);//显示文件名
                                    $('#dangersPhotos').val(file.name);//显示文件名
                                });
                            }
                            , done: function (res) {
                                if(res.obj.length == 0){
                                    if(res.msg == "The file size is 0"){
                                        layer.msg("不可上传空文件!");
                                    }else{
                                        layer.msg(res.msg);
                                    }
                                }else{
                                    var obj = res.obj[0];
                                    $('#attachmentId').val(getAttachIds(obj));
                                    $("#add-file-submit").click();
                                }
                            }
                        });*/
						laydate.render({
							elem: '#checkTime'
							, trigger: 'click'//呼出事件改成click
						});
						laydate.render({
							elem: '#rectificationPeriod'
							, trigger: 'click'//呼出事件改成click
						});
						//var detailsId = $("#detailsId").val();
						$('#region').val(tData.securityRegionName);//检查区域
						$('#region').attr('pid', tData.securityRegionId);//检查区域id
						$('#hiddenDanger').val(tData.securityKnowledgeName);//检查项
						$('#hiddenDanger').attr('pid2', tData.securityKnowledgeId);//检查项id
						$('#dangerGrade').val(tData.securityGradeName);//隐患级别
						$('#dangerGrade').attr('securityGrade', tData.securityGrade);
						$('#securityDangerMeasures').val(tData.securityDangerMeasures);//整改措施
						$('#securityDanger').val(tData.securityDanger);//检查内容
						$('#securityDanger').attr('pid3', tData.securityDangerId);//检查内容id
						$('#checkTime').val(tData.checkTime);//检查时间

						//$("#needAcceptance").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value',tData.needAcceptance); //是否需要验收
						//$('#needAcceptance').val(tData.needAcceptance);

						if(tData.checkStatus!="0") { //已提交
							$('#needRecification').attr("disabled","disabled");
							$('#rectificationPeriod').attr("disabled","disabled");
							$('#rectificationPersion').attr("disabled","disabled");
							$('#securityDangerDesc').attr("disabled","disabled");
							$('#needAcceptance').attr("disabled","disabled");
							$('#acceptancePersion').attr("disabled","disabled");
							$('#fileupload').attr("disabled","disabled");
						}

						if (tData.needRecification === 0 || tData.needRecification === '0') {
							isShow = true;
							$('#needRecification').prop('checked', 'checked');
							$('#PeriodShow').show();
							$('#PersionShow').show();
							$('#switchShow').show();
							if (tData.needAcceptance === 0 || tData.needAcceptance === '0') {
								isShow1 = true;
								$('#needAcceptance').prop('checked', 'checked');
								$('#acceptanceShow').show();
							} else {
								$('#acceptanceShow').hide();
							}
						} else if (tData.needRecification === 1 || tData.needRecification === '1'){
							isShow = false;
							isShow1 = false;
							$('#PeriodShow').hide();
							$('#PersionShow').hide();
							$('#switchShow').hide();
							$('#acceptanceShow').hide();
						}else {
							isShow = true;
							$('#needRecification').prop('checked', 'checked');
							$('#PeriodShow').show();
							$('#PersionShow').show();
							$('#switchShow').show();
							isShow1 = true;
							$('#needAcceptance').prop('checked', 'checked');
							$('#acceptanceShow').show();
						}
						//$("#needRecification").attr("pid5",tData.needRecification);//是否需要整改
						$("#rectificationPeriod").val(tData.rectificationPeriod);//整改期限
						$("#rectificationPersion").attr("user_id", tData.rectificationPersion);//整改人id
						$("#rectificationPersion").val(tData.rectificationPersionName);//整改人
						//$("#needAcceptance").attr("pid7",tData.needAcceptance);//是否需要验收
						$("#acceptancePersion").attr("user_id", tData.acceptancePersion);//验收人id
						$("#acceptancePersion").val(tData.acceptancePersionName); //验收人
						$("#securityDangerDesc").val(tData.securityDangerDesc);//隐患描述
						$('#urls').val(tData.urls)//图纸位置

						//图纸位置
						if ((tData.regionX != undefined && tData.regionX != "") && (tData.regionY != undefined && tData.regionY != "")) {
							$('#drawingImg').text("已标注");
						} else {
							$('#drawingImg').text("未标注");
						}

						//附件
						fileuploadFn('#fileupload', $('#fileAll'));

						var str = ''
						if (tData.attachmentList != undefined && tData.attachmentList.length > 0) {
							for (var i = 0; i < tData.attachmentList.length; i++) {
								str += '<div class="dech" deUrl="' + tData.attachmentList[i].attUrl + '"><img class="preview" style="width: 100px;" src="/xs?' + tData.attachmentList[i].attUrl + '" NAME="' + tData.attachmentList[i].attachName + '*"><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + tData.attachmentList[i].aid + '@' + tData.attachmentList[i].ym + '_' + tData.attachmentList[i].attachId + ',"></div>'
							}
						} else {
							str = '';
						}
						$('#fileAll').append(str)

						$("#securityContentId").val(tData.securityContentId);

						Array.prototype.remove = function (val) {
							var index = this.indexOf(val);
							if (index > -1) {
								this.splice(index, 1);
							}
						};

						$('#drawingImg').on("click", function () {
							$.popWindow("/workflow/secirityManager/selectDrawing?layEvent1=initialization&securityContentId=" + tData.securityContentId);
						})
						form.on('switch(switchTest)', function (data) {
							if (data.elem.checked == true) {
								isShow = true;
								$('#PeriodShow').show();
								$('#PersionShow').show();
								$('#switchShow').show();
								if (isShow1) {
									$('#acceptanceShow').show();
								} else {
									$('#acceptanceShow').hide();
								}
							} else {
								isShow = false;
								//isShow1 = false;

								$('#PeriodShow').hide();
								$('#PersionShow').hide();
								$('#switchShow').hide();
								$('#acceptanceShow').hide();
								//$('#needAcceptance').next().removeClass('layui-form-onswitch');
							}
						});
						form.on('switch(switchTest1)', function (data) {
							if (data.elem.checked == true) {
								isShow1 = true;
								$('#acceptanceShow').show();
							} else {
								isShow1 = false;
								$('#acceptanceShow').hide();
							}
						});
						form.render();//初始化表单
					},
					yes: function (index, layero) {
						if(tData.checkStatus!="0") { //已提交
							layer.close(index);
						}else{
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
							var checkTime = $("#checkTime").val();//检查时间

							//var needAcceptance = $("#needAcceptance").next('.layui-form-select').find('dl dd.layui-this').attr('lay-value'); //是否需要验收
							var rectificationPeriod = $("#rectificationPeriod").val();//整改期限
							var rectificationPersion = $("#rectificationPersion").attr("user_id");//整改人id
							var rectificationPersionName = $("#rectificationPersion").val();//整改人
							var acceptancePersion = $("#acceptancePersion").attr("user_id");//验收人id
							var acceptancePersionName = $("#acceptancePersion").val(); //验收人
							var securityDangerDesc = $("#securityDangerDesc").val();//隐患描述

							//是否需要整改
							if (isShow == true) {
								var needRecification = 0;
								if(rectificationPeriod === ''){
									layer.msg('整改期限不能为空!', {icon: 2, time: 1000});
									return false;
								}
								if(rectificationPersionName === ''){
									layer.msg('整改人不能为空!', {icon: 2, time: 1000});
									return false;
								}
								//是否需要验收
								if (isShow1 == true) {
									var needAcceptance = 0;
									if(acceptancePersionName === ''){
										layer.msg('验收人不能为空!', {icon: 2, time: 1000});
										return false;
									}
								} else {
									var needAcceptance = 1;
								}
							} else {
								var needRecification = 1;
								var needAcceptance = 1;
							}

							//附件
							var attachmentId = '';
							var attachmentName = '';
							var attachmentList=[];
							for (var i = 0; i < $('#fileAll .dech').length; i++) {
								var att={
									attUrl:$('#fileAll .dech').eq(i).attr('deurl'),
									attachName:$('#fileAll img').eq(i).attr('name')
								}
								attachmentId += $('#fileAll .dech').eq(i).find('input').val();
								attachmentName += $('#fileAll img').eq(i).attr('name');
								attachmentList[i]=att;
							}
							var securityContentId = $("#securityContentId").val();

							var checkFlag = 1;

							if (rectificationPersion != undefined || rectificationPersion != null) {
								if (rectificationPersion.substring(rectificationPersion.length - 1, rectificationPersion.length) == ",") {
									rectificationPersion = rectificationPersion.substring(0, rectificationPersion.length - 1);
								}
							}
							if (acceptancePersion != undefined || acceptancePersion != null) {
								if (acceptancePersion.substring(acceptancePersion.length - 1, acceptancePersion.length) == ",") {
									acceptancePersion = acceptancePersion.substring(0, acceptancePersion.length - 1);
								}
							}

							if (rectificationPersionName != undefined || rectificationPersionName != null) {
								if (rectificationPersionName.substring(rectificationPersionName.length - 1, rectificationPersionName.length) == ",") {
									rectificationPersionName = rectificationPersionName.substring(0, rectificationPersionName.length - 1);
								}
							}

							if (acceptancePersionName != undefined || acceptancePersionName != null) {
								if (acceptancePersionName.substring(acceptancePersionName.length - 1, acceptancePersionName.length) == ",") {
									acceptancePersionName = acceptancePersionName.substring(0, acceptancePersionName.length - 1);
								}
							}
							var details = {
								attachmentList:attachmentList,
								securityRegionId: securityRegionId,
								securityRegionName: securityRegionName,
								securityKnowledgeId: securityKnowledgeId,
								securityKnowledgeName: securityKnowledgeName,
								attachmentId: attachmentId,
								attachmentName: attachmentName,
								securityGrade: securityGrade,
								securityGradeName: securityGradeName,
								securityDangerMeasures: securityDangerMeasures,
								securityDanger: securityDanger,
								securityDangerId: securityDangerId,
								checkTime:checkTime,
								//needAcceptance:needAcceptance,
								rectificationPeriod: rectificationPeriod,
								rectificationPersion: rectificationPersion,
								rectificationPersionName: rectificationPersionName,
								acceptancePersion: acceptancePersion,
								acceptancePersionName: acceptancePersionName,
								securityDangerDesc: securityDangerDesc,
								securityContentId: securityContentId,
								urls: urls,
								needRecification: needRecification,
								needAcceptance: needAcceptance,
								checkFlag: 1,
								checkStatus:tData.checkStatus
							}
							var details2 = {
								//needAcceptance:needAcceptance,
								rectificationPeriod: rectificationPeriod,
								rectificationPersion: rectificationPersion,
								rectificationPersionName: rectificationPersionName,
								acceptancePersion: acceptancePersion,
								acceptancePersionName: acceptancePersionName,
								securityDangerDesc: securityDangerDesc,
								attachmentId: attachmentId,
								attachmentName: attachmentName,
								securityContentId: securityContentId,
								urls: urls,
								needRecification: needRecification,
								needAcceptance: needAcceptance,
								checkFlag: 1
							}
							//debugger
							//detailsInitData2.push(details);
							var countt = null;
							for (var i = 0; i <= detailsInitData2.length; i++) {
								if (detailsInitData2[i].securityContentId == securityContentId) {
									countt = i;
									break;
								}
							}
							if (countt != null) {
								detailsInitData2[countt] = details;
							}
							detailsInit2.reload({
								url: '', data: detailsInitData2
								, done: function (d) {
									layer.close(index)
								}
							});
							$.ajax({
								url: '/workflow/secirityManager/updateDetailsInfo',
								type: 'post',
								dataType: 'json',
								data: details2,
								success: function (res) {
									if (res.code === 0 || res.code === "0") {
										//layer.closeAll();
										layer.msg(res.msg)
									}

								}
							})
						}

					}
					, btn2: function (index, layero) {
						layer.close(index);
					}
				});
			} else if (layEvent === 'drawing') {
				$.popWindow("/workflow/secirityManager/selectDrawing?securityContentId=" + tData.securityContentId);
			}
		})
	})

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

								str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img class="deImgs" style="cursor: pointer;margin-top: -40px;margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
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

								str += '<div class="dech" deUrl="' + deUrl+ '"><img class="preview" style="width: 100px;" src="/xs?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img class="deImgs" style="cursor: pointer;margin-top: -40px;margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
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

	$(document).on('click', '.preview', function () {
		var deUrl = $(this).attr("src").split('?')[1];
		layui.layer.open({
			type: 2,
			title: '预览',
			content: "/xs?"+encodeURI(deUrl),
			offset:["20px",""],
			area: ['70%', '90%'],
			success:function(layero, index){
				var iframeWindow = window['layui-layer-iframe'+ index];
				var doc = $(iframeWindow.document);
				doc.find('img').css("width","100%");
			}
		})
	})
</script>
</body>
</html>
