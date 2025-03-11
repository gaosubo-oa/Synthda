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
	<title>进度计划模板</title>
	<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
	<link rel="stylesheet" href="/lib/layui/layui/css/common.css">
	<%--<link rel="stylesheet" href="/lims/css/eleTree.css">--%>
	<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
	<script src="/lib/layui/layui/layui.js"></script>
	<script src="/lib/layui/layui/lay/mymodules/eleTree.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
	<script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
	<script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="/lib/jquery-2.1.4.min.js"></script>
	<script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../js/jquery/jquery.cookie.js"></script>
	<script src="/lib/jquery.form.min.js"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
	<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="/js/email/fileuploadPlus.js?20230529"></script>
	<script type="text/javascript" src="/js/email/fileupload.js"></script>
	<style>
		html,body{
			height: 99.8%;
		}
		.layui-card-header{
			border-bottom: 1px solid #eee;
		}
		.mbox{
			height: 100%;
			padding:0px;
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
			float: left;
			position: relative;
			border: 1px solid #eee;
			/*width: 200px;*/
			width: 14%;
			overflow-x: auto;
			height: 100%;
			/*height: 600px !important;*/
		}
		.layui-rt{
			float: left;
			width: 84%;
			margin-left: 6px;
			height: 100%;
			/*margin-top: -10px;*/
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
			/*width:200px;*/
			overflow-x: hidden;
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
		.scroll::-webkit-scrollbar {/*滚动条整体样式*/
			width: 4px;     /*高宽分别对应横竖滚动条的尺寸*/
			height: 10px;
		}
		.scroll::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
			border-radius: 5px;
			-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
			background: rgba(0,0,0,0.2);
		}
		.scroll::-webkit-scrollbar-track {/*滚动条里面轨道*/
			-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
			border-radius: 0;
			background: rgba(0,0,0,0.1);
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
		/*.iframe{*/
		/*width: 100% !important;*/
		/*height: 100% !important;*/
		/*}*/
		.layui-tab-title .layui-this {
			color: #000;
			background-color: #fff;
		}

		.form_label {
			float: none;
			padding: 9px 0;
			text-align: left;
			width: auto;
		}

		.form_block {
			margin: 0;
		}

		.field_required {
			color: red;
			font-size: 16px;
		}
	</style>

	<script type="text/javascript">
	</script>
</head>
<body>
<div class="mbox">
	<div class="layui-card" style="height: 100%;">
		<div class="layui-tab layui-tab-card" lay-filter="tabTaggle" style="position:relative;height: 100%;overflow: hidden">
			<div class="scroll" style="overflow-x:auto;overflow-y:hidden;background-color: #f2f2f2;">
				<ul class="layui-tab-title" id="ulBox">
					<li num="1" class="layui-this">进度计划模板</li>
					<%--<li>计家云</li>--%>
				</ul>
			</div>
			<div class="layui-tab-content" id="divBox" style="height:90%;display: block;position: relative;width:100%;padding: 2px">
				<%--工程类别--%>
				<div class="layui-tab-item layui-show" style="height: 100%">
					<div class="layui-card" style="height: 100%">
						<div class="layui-card-body" style="height: 100%">
							<div class="layui-lf rtfix">
								<div style="margin: 1% 1%;" id="editBox">
									<button type="button" style="margin-left:2px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan">新增</button>
									<button type="button" style="margin-left:2px;" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan">编辑</button>
									<button type="button" style="margin-left:2px;" class="layui-btn layui-btn-primary layui-btn-sm del" id="delPlan">删除</button>
								</div>
								<div class="panel-body">
									<div class="eleTree ele1" lay-filter="tdata"></div>
								</div>
							</div>
							<div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
							<div class="layui-rt" style="position: relative">
								<div class="query_module layui-form layui-row" style="position: relative">
									<div class="layui-col-xs2">
										<input type="text" name="securityKnowledgeName" placeholder="检查项" autocomplete="off" class="layui-input">
									</div>
									<div class="layui-col-xs2" style="margin-left: 15px;">
										<select name="securityDangerGrade">
											<option value="">请选择隐患级别</option>
											<option value="0">重大隐患</option>
											<option value="1">一般隐患</option>
										</select>
									</div>
									<div class="layui-col-xs2" style="margin-top: 3px;text-align: center">
										<button type="button" class="layui-btn layui-btn-sm searchData">查询</button>
										<%--                                        <button type="button" class="layui-btn layui-btn-sm">高级查询</button>--%>
									</div>
								</div>
								<div style="position: relative">
									<div class="table_box" style="display: none">
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
				</div>
				<%--<div class="layui-tab-item" style="height: 100%;">
                    <div class="layui-card" style="height: 100%">
                        <div class="layui-card-body" style="height: 100%">
                            <div class="layui-lf rtfix">

                                <div class="panel-body">
                                    <div class="eleTree ele3"  lay-filter="tdata1"></div>
                                </div>
                            </div>
                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>
                            <div class="layui-rt" style="position: relative">
                                <table id="Settlement1" lay-filter="SettlementFilter1"></table>
                            </div>
                        </div>
                    </div>
                </div>--%>
			</div>
		</div>
	</div>
</div>

<script type="text/html" id="formTable1toolbar">
	<div class="layui-btn-container" style="float: left">
		<%--        {{#  if(authorityObject && authorityObject['11']){ }}--%>
		<input type="button" class="layui-btn layui-btn-sm" lay-event="addTest" value="导入">
		<%--        {{#  } }}--%>
		<%--        {{#  if(authorityObject && authorityObject['05']){ }}--%>
		<input type="button" class="layui-btn layui-btn-sm" lay-event="editTest" value="编辑">
		<%--        {{#  } }}--%>
		<%--{{#  if(authorityObject && authorityObject['02']){ }}
        <button class="layui-btn layui-btn-sm" lay-event=" " style="width: 70px">导入</button>
        {{#  } }}
        {{#  if(authorityObject && authorityObject['03']){ }}
        <button class="layui-btn layui-btn-sm" lay-event="supplierExport" style="width: 70px">导出</button>
        {{#  } }}--%>
		<%--        {{#  if(authorityObject && authorityObject['04']){ }}--%>
		<input type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delTest" value="删除">
		<%--        {{#  } }}--%>
	</div>
</script>


<script type="text/html" id="formTable1bar">
	<div class="layui-btn-container" style="height: 30px;">
		<%--        {{#  if(authorityObject && authorityObject['04']){ }}--%>
		<input type="button" class="layui-btn layui-btn-sm layui-btn-danger" lay-event="delete" value="删除">
		<%--        {{#  } }}--%>
	</div>
</script>

<script type="text/html" id="toolbar2">
	<div class="layui-btn-container">
		<button class="layui-btn layui-btn-sm" lay-event="supplierImport2" style="width: 100px">导入本地</button>
	</div>
</script>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>
<script type="text/javascript">


	// initAuthority();

	$('.rtfix').css('max-height',autodivheight()-55)
	var el;
	var el1;
	var ell;
	var parData;
	var arr = [];
	var columnTrId;
	var columnTrId1;
	var codeNo;
	var codNam;
	var SettlementTable;

	var _data=[]
	function getUrlParam(name){
		var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.href.match(reg); //匹配目标参数
		if (r!=null) return unescape(r[1]); return null; //返回参数值
	}
	var type = getUrlParam('pageType');
	var tableType = getUrlParam('type');;
	if(tableType=='model'){
		$('#addPlan').hide();
		$('#editPlan').hide();
		$('#delPlan').hide();
	}

	// 获取数据字典数据
	var dictionaryObj = {
		PROGRESS_TYPE: {},
		SCHEDULE_INPORTANCE:{}
	}
	var dictionaryStr = 'PROGRESS_TYPE,SCHEDULE_INPORTANCE';
	$.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
		if (res.flag) {
			for (var dict in dictionaryObj) {
				dictionaryObj[dict] = {object: {}, str: ''}
				if (res.object[dict]) {
					res.object[dict].forEach(function (item) {
						dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
						dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
					});
				}
			}
		}
	});

	var urrl = "";
	layui.use(['table','layer','form','element','eleTree','laydate','upload','treeTable'], function(){
		var table = layui.table;
		var layer = layui.layer;
		var form = layui.form;
		var eleTree = layui.eleTree;
		var element = layui.element;
		var $ = layui.jquery;
		var laydate = layui.laydate;
		var upload = layui.upload;
		var treeTable = layui.treeTable;

		function tab(date1,date2){
			var oDate1 = new Date(date1);
			var oDate2 = new Date(date2);
			var dataTime = new Date();
			if(oDate1!=undefined&&oDate2!=undefined){
				if(dataTime.getTime() >= oDate1.getTime()&&dataTime.getTime() <= oDate2.getTime()){
					return true;
				}
			}
		}
		//判断权限
		$.ajax({
			url:'/knowledgeCenter/getCloudPriv',
			dataType:'json',
			type:'post',
			success:function(res){
				if(res.obj&&res.obj.knowledgeFlag!=undefined&&res.obj.knowledgeFlag==0){
					if(tab(res.obj.knowledgeBTime,res.obj.knowledgeETime)){
						$('#ulBox').append('<li>计家云</li>')
						var htmlDiv = '<div class="layui-tab-item" style="height: 100%;">\n' +
								'                    <div class="layui-card" style="height: 100%">\n' +
								'                        <div class="layui-card-body" style="height: 100%">\n' +
								'                            <div class="layui-lf rtfix">\n' +
								'                                <div class="panel-body">\n' +
								'                                    <div class="eleTree ele3"  lay-filter="tdata1"></div>\n' +
								'                                </div>\n' +
								'                            </div>\n' +
								'                            <div class="layui-md" style="width: 4px;cursor: e-resize;position: relative;"></div>\n' +
								'                            <div class="layui-rt" style="position: relative">\n' +
								'                                <table id="Settlement1" lay-filter="SettlementFilter1"></table>\n' +
								'                            </div>\n' +
								'                        </div>\n' +
								'                    </div>\n' +
								'                </div>'
						$('#divBox').append(htmlDiv);
						// 初始化渲染 树形菜单

						el1 = eleTree.render({
							elem: '.ele3',
							showLine:true,
							url:'/scheduleTemplte/getScheduleTemplteByType?parent=0',
							lazy: true,
							// checked: true,
							load: function(data,callback) {
								$.post('/scheduleTemplte/getScheduleTemplteByType?parent='+data.id,function (res) {
									callback(res.data);//点击节点回调
								})
							},
							done:function (data) { //渲染完成回调
								var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
								var na = $("#ulBox").find("li.layui-this").html();
								codNam = encodeURI(encodeURI(na));
								codeNo = n1;
								if(data&&data.data&&data.data.length > 0){
									columnTrId1 = data.data[0].id;
									var dataid=$('.ele1 div').attr("data-id")
									$('.eleTree-node').removeClass('back')
									$('.ele1 div[data-id='+dataid+']').addClass('back')
									$('.eleTree-node-group').css('background','#fff');
									childFunc1(columnTrId1);  //调用应用中方法
								}else{
									$('.ele1').html('<div style="text-align: center">暂无数据</div>');
									columnTrId1 = undefined;
								}
								if(type == 1 || type == "1"){
									urrl = '/columManage/getColumManagePage?columnTrId='+columnTrId1+'&codeNo='+codeNo+'&codeName'+'&codeName='+codNam
								}else if(type == 2 || type == "2"){
									urrl = '/fileManage/getFileManagePage?columnTrId='+columnTrId1
								}
								$("#divBox").find("div.layui-show").find(".iframe").attr("src",urrl);
							}
						});
					}
				}
			}
		})

		// 初始化渲染 树形菜单
		el = eleTree.render({
			elem: '.ele1',
			showLine:true,
			url:'/scheduleTemplte/getScheduleTemplteByType?parent=0',
			lazy: true,
			// checked: true,
			load: function(data,callback) {
				$.post('/scheduleTemplte/getScheduleTemplteByType?parent='+data.id,function (res) {
					callback(res.data);//点击节点回调
				})
			},
			done:function (data) { //渲染完成回调
				/*var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
				var na = $("#ulBox").find("li.layui-this").html();
				codNam = encodeURI(encodeURI(na));
				codeNo = n1;
				*/
				if(data&&data.data&&data.data.length > 0){

				}else{
					$('.ele1').html('<div style="text-align: center">暂无数据</div>');
				}
			}
		});
		// 节点点击事件
		eleTree.on("nodeClick(tdata)",function(d) {
			parData = d.data.currentData;
			columnTrId = d.data.currentData.id;
			if(columnTrId){
				$('.no_data').hide();
				$('.table_box').show();

				var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
				var na = $("#ulBox").find("li.layui-this").html();
				codNam = encodeURI(encodeURI(na));
				codeNo = n1;
				var clas = "";
				var idn = ""
				var dataid=$(clas+' div').attr("data-id")
				$('.eleTree-node').removeClass('back')
				$(d.node[0]).addClass('back')
				$('.eleTree-node-group').css('background','#fff')
				//调用子页面的方法
				childFunc(columnTrId);  //调用应用中方法
			}else {
				$('.table_box').hide();
				$('.no_data').show();
			}

		});
		//选中监听事件
		eleTree.on("nodeChecked(tdata)",function(d) {
			var id = d.data.currentData.columnId;
			if(d.isChecked == true || d.isChecked == "true"){
				arr.push(id);
			}else{
				arr.remove(id);
			}
		})
		$(document).on("click",function() {
			$(".ele2").slideUp();
		})

		//计家云
		eleTree.on("nodeClick(tdata1)",function(d) {
			//debugger
			parData = d.data.curtdatarentData;
			var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
			var na = $("#ulBox").find("li.layui-this").html();
			codNam = encodeURI(encodeURI(na));
			codeNo = n1;
			columnTrId1 = d.data.currentData.id;
			var clas = "";
			var idn = ""
			var dataid=$(clas+' div').attr("data-id")
			$('.eleTree-node').removeClass('back')
			$(d.node[0]).addClass('back')
			$('.eleTree-node-group').css('background','#fff')
			//调用子页面的方法
			childFunc1(columnTrId1);  //调用应用中方法
		});

		eleTree.on("nodeChecked(tdata1)",function(d) {
			var id = d.data.currentData.columnId;
			if(d.isChecked == true || d.isChecked == "true"){
				arr.push(id);
			}else{
				arr.remove(id);
			}
		})
		$(document).on("click",function() {
			$(".ele2").slideUp();
		})

		function childFunc(scheduleTypeId){

			var cols = [
				{type: 'checkbox'},
				{field: 'documentNo', title: '编号', minWidth: 200,templet: function (d) {
						return '<span class="documentNo" scheduleTemplteId="'+d.scheduleTemplteId+'">'+(d.documentNo||'')+'</span>'
					}},
				{field: 'scheduleName', title: '任务名称', minWidth: 100},
				{field:'scheduleBeginDate',title:'计划开始时间',minWidth: 130},
				{field: 'scheduleEndDate', title: '计划完成时间', minWidth: 130},
				{field: 'scheduleDuration', title: '持续时间',minWidth: 110},
				// {field:'beforeSchedule',title:'紧前任务',minWidth: 110,templet: function (d) {
				// 		return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
				// 	}},
				// {field: 'nodeScheduleName', title: '节点计划',minWidth: 110},
				{field: 'scheduleUserName', title: '责任人',minWidth: 120},
				{field: 'supervisorUserName', title: '监督人',minWidth: 120},
				{field: 'importanceLevel', title: '重要性',minWidth: 120,templet: function (d) {
						if(d.importanceLevel) {
							return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
						}else {
							return ''
						}
					}}
			]
			if(tableType!='model'){
				cols.push({
					fixed: 'right',
					align: 'center',
					toolbar: '#formTable1bar',
					title: '操作',
					minWidth: 100
				})
			}

			SettlementTable = treeTable.render({
				elem: '#Settlement'
				// ,page:true
				,url:'/scheduleTemplte/select?delFlag=0&scheduleTypeId='+scheduleTypeId
				,toolbar:tableType=='model'?false:'#formTable1toolbar'
				// ,defaultToolbar: ['filter']
				,height: 'full-100'
				,tree: {
					iconIndex: 1,
					idName: 'scheduleId',
					childName: "child"
				}
				,cols: [cols]
				, done:function(obj, curr, count){
					_data=obj.data
				}
			});

		}

		//点击查询
		$('.searchData').click(function () {
			var searchParams = {}
			var $seachData = $('.query_module [name]')
			$seachData.each(function () {
				searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
				// 将查询值保存至cookie中
				// $.cookie($(this).attr('name'), $(this).val(), {expires: 5, path: "/",});
			})
			SettlementTable.reload({
				where: searchParams,
				page: {
					curr: 1 //重新从第 1 页开始
				}
			});
		});

		function childFunc1(scheduleTypeId){
			SettlementTable = treeTable.render({
				elem: '#Settlement'
				// , page:true
				,url:'/scheduleTemplte/select?delFlag=0&scheduleTypeId='+scheduleTypeId
				,height: 'full-100'
				// ,defaultToolbar: ['filter']
				,tree: {
					iconIndex: 1,
					idName: 'scheduleId',
					childName: "child"
				}
				// ,toolbar:'#formTable1toolbar'
				,cols: [[
					{type: 'checkbox'},
					{field: 'documentNo', title: '编号', minWidth: 150,templet: function (d) {
							return '<span class="documentNo" scheduleTemplteId="'+d.scheduleTemplteId+'">'+(d.documentNo||'')+'</span>'
						}},
					{field: 'scheduleName', title: '任务名称', minWidth: 100},
					{field:'scheduleBeginDate',title:'计划开始时间',minWidth: 130},
					{field: 'scheduleEndDate', title: '计划完成时间', minWidth: 130},
					{field: 'scheduleDuration', title: '持续时间',minWidth: 110},
					// {field:'beforeSchedule',title:'紧前任务',minWidth: 110,templet: function (d) {
					// 		return '<span>'+(d.beforeSchedule&&d.beforeSchedule.scheduleName||'')+'</span>'
					// 	}},
					// {field: 'nodeScheduleName', title: '节点计划',minWidth: 110},
					{field: 'scheduleUserName', title: '责任人',minWidth: 120},
					{field: 'supervisorUserName', title: '监督人',minWidth: 120},
					{field: 'importanceLevel', title: '重要性',minWidth: 120,templet: function (d) {
							if(d.importanceLevel) {
								return '<span>'+((dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['object'][d.importanceLevel])||'')+'</span>'
							}else {
								return ''
							}
						}},
					{
						fixed: 'right',
						align: 'center',
						toolbar: '#formTable1bar',
						title: '操作',
						minWidth: 200
					}
				]]
				, done:function(obj, curr, count){
					_data=obj.data
				}
			});
		}


		treeTable.on('toolbar(Settlement)', function (obj) {
			var events = obj.event;
			var datas = SettlementTable.checkStatus();
			// 新增
			if (events == 'addTest') {
				layer.open({
					type: 2,
					title: '导入',
					btn: ['确定','取消'],
					btnAlign: 'c',
					area: ['90%', '80%'],
					maxmin: true,
					content: '/procedureSchedule/procedureScheduleIndex?type=model',
					success: function () {

					},
					yes: function (index,layero) {
						var childData  = $(layero).find("iframe")[0].contentWindow.getRepairDate();
						// var ids = ''
						// for(var i = 0;i<childData.length;i++){
						// 	// childData[i].scheduleTypeId=columnTrId
						// 	ids += childData[i].operationDictionaryId+','
						// }
						if(childData){
							$.ajax({
								url:'/scheduleTemplte/exportDictionary?scheduleTypeId='+columnTrId,
								dataType:'json',
								type:'post',
								// data:{ids:ids,scheduleTypeId:columnTrId},
								data: JSON.stringify(childData),
								contentType: "application/json;charset=UTF-8",
								success:function(res){
									if(res.code===0||res.code==="0"){
										//layer.msg("更新成功",{icon:1});
										layer.msg(res.msg,{icon:1});
										SettlementTable.reload()
										layer.close(index)
									}else{
										//layer.msg("更新成功",{icon:1});
										layer.msg(res.msg,{icon:0});
									}
								}
							})
						}else {
							layer.msg('请选择一项！', {icon: 0});
						}

					}
				})
			}else if (events == 'delTest') {//删除
				if(datas.length<1){
					layer.msg("请至少选择一条");
				}else{
					layer.confirm('确定要删除选中的检查项吗？', {icon: 3, title:'提示'}, function(index){
						var ids="";
						for(var i=0;i<datas.length;i++){
							ids+=datas[i].scheduleTemplteId+",";
						}
						$.ajax({
							url:'/scheduleTemplte/del',
							type: 'post',
							dataType: 'json',
							data:{ids:ids},
							success:function(res){
								layer.msg(res.msg);
								SettlementTable.reload();
							}
						});
						layer.close(index);
					});
				}
			}else if (events == 'editTest') {//编辑
				if(datas.length!=1){
					layer.msg("请选择一条");
				}else {
					var checkDate = datas[0];
					newOrEdit(1,checkDate)

				}
			}
		})
		function newOrEdit(type, data) {
			var title = '';
			var url = '';
			//var content = ''
			// var projectId = $('#leftId').attr('projId');
			if (type == '0') {
				title = '新增';
				url = '/scheduleTemplte/insert';
			} else if (type == '1') {
				title = '编辑';
				url = '/scheduleTemplte/updateById';
			}else if(type == '4'){
				title = '查看详情'
			}
			layer.open({
				type: 1,
				title: title,
				area: ['80%', '90%'],
				btn: type != '4'?['保存', '取消']:['确定'],
				btnAlign: 'c',
				content: ['<form class="layui-form _disabled" id="baseForm" lay-filter="formTest">' +
				'<div class="layui-collapse">\n' +
				/* region 任务信息 */
				'  <div class="layui-colla-item">\n' +
				'    <h2 class="layui-colla-title">任务信息</h2>\n' +
				'    <div class="layui-colla-content layui-show plan_base_info">' +
				/* region 第一行 */
				'           <div class="layui-row">' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">编号</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="documentNo" readonly style="background: #e7e7e7"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				/*'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">排序号</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="companySort"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +*/
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">任务名称</label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                           <input type="text" name="scheduleName"  autocomplete="off" class="layui-input">' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				// '               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				// '                   <div class="layui-form-item">\n' +
				// '                       <label class="layui-form-label form_label">项目名称</label>\n' +
				// '                       <div class="layui-input-block form_block">\n' +
				// '                           <input type="text" name="projectName" id="projectName" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
				// '                       </div>\n' +
				// '                   </div>' +
				// '               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">重要性<!--<span field="importanceLevel" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <select class="importanceLevel" name="importanceLevel" ></select>\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
				'                   <div class="layui-form-item">\n' +
				'                       <label class="layui-form-label form_label">责任人<!--<span field="scheduleUserName" class="field_required">*</span>--></label>\n' +
				'                       <div class="layui-input-block form_block">\n' +
				'                       <input type="text" name="scheduleUserName" id="scheduleUserName" autocomplete="off" class="layui-input">\n' +
				'                       </div>\n' +
				'                   </div>' +
				'               </div>' +
				'           </div>' ,
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">持续时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="number" name="scheduleDuration" id="scheduleDuration"  autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">开始时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="scheduleBeginDate" id="scheduleBeginDate" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">结束时间<!--<span field="scheduleEndDate" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="scheduleEndDate" id="scheduleEndDate"  autocomplete="off" class="layui-input" >\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">监督人<!--<span field="supervisorUserName" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                       <input type="text" name="supervisorUserName" id="supervisorUserName" autocomplete="off" class="layui-input">\n' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'           </div>',
					/* endregion */
					'    </div>\n' +
					'  </div>\n' +
					/* endregion  常规任务 */
					'  <div class="layui-colla-item">\n' +
					'    <h2 class="layui-colla-title">上级任务</h2>\n' +
					'    <div class="layui-colla-content layui-show three_info">' +
					'           <div class="layui-row">' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">上级任务<!--<span field="parentScheduleId" class="field_required">*</span>--></label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text" name="parentScheduleId" autocomplete="off" class="layui-input one_click">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">上级任务开始时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text"  id="schedule_BeginDate" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +
					'               <div class="layui-col-xs3" style="padding: 0 5px;">' +
					'                   <div class="layui-form-item">\n' +
					'                       <label class="layui-form-label form_label">上级任务结束时间</label>\n' +
					'                       <div class="layui-input-block form_block">\n' +
					'                           <input type="text"  id="schedule_EndDate" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
					'                       </div>\n' +
					'                   </div>' +
					'               </div>' +

					'      		 </div>',
					'		</div>\n' +
					'  </div>' +
					/* endregion */
					'</div>' +
					'</form>'].join(''),
				success: function () {

					//回显项目名称
					// getProjName('#projectName',projectId?projectId:data.projectId)

					//类型
					var $select1 = $(".scheduleType");
					var optionStr = '<option value="">请选择</option>';
					optionStr += dictionaryObj&&dictionaryObj['PROGRESS_TYPE']&&dictionaryObj['PROGRESS_TYPE']['str']
					$select1.html(optionStr);

					//重要性
					var $select2 = $(".importanceLevel");
					var optionStr2 = '<option value="">请选择</option>';
					optionStr2 += dictionaryObj&&dictionaryObj['SCHEDULE_INPORTANCE']&&dictionaryObj['SCHEDULE_INPORTANCE']['str']
					$select2.html(optionStr2);

					laydate.render({
						elem: '#scheduleBeginDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						, done: function(value, date){ //监听日期被切换
							//紧前任务的结束时间
							var schedule_EndDate = $('#schedule_EndDate2').val()
							var beforeScheduleDate = ''
							//持续时间
							var scheduleDuration = $('#scheduleDuration').val()
							var scheduleEndDate = $('#scheduleEndDate').val()||''
							//console.log(dateParse(value))
							//反算紧前时间
							if(value&&schedule_EndDate){
								beforeScheduleDate = getDays(schedule_EndDate,value)-1
								$('#beforeScheduleDate').val(beforeScheduleDate)
							}
							//反算结束时间
							if(value&&scheduleDuration){
								scheduleEndDate = getNewDay(value,scheduleDuration,-1)
								$('#scheduleEndDate').val(scheduleEndDate)
							}

							//反算持续时间
							if(value&&scheduleEndDate){
								scheduleDuration = getDays(scheduleEndDate,value)+1
								$('#scheduleDuration').val(scheduleDuration)
							}
						}
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
					});
					laydate.render({
						elem: '#scheduleEndDate'
						, trigger: 'click'
						, format: 'yyyy-MM-dd'
						// , format: 'yyyy-MM-dd HH:mm:ss'
						//,value: new Date()
						, done: function(value, date) { //监听日期被切换
							//持续时间
							var scheduleDuration = $('#scheduleDuration').val()
							//开始时间
							var scheduleBeginDate = $('#scheduleBeginDate').val()||''
							//反算开始时间
							if(value&&scheduleDuration){
								scheduleBeginDate = getNewDay(value,-scheduleDuration,1)
								$('#scheduleBeginDate').val(scheduleBeginDate)
							}
							//反算持续时间
							if(value&&scheduleBeginDate){
								scheduleDuration = getDays(scheduleBeginDate,value)+1
								$('#scheduleDuration').val(scheduleDuration)
							}

							//紧前任务的结束时间
							var schedule_EndDate = $('#schedule_EndDate2').val()
							var beforeScheduleDate = ''
							//反算紧前时间
							if(value&&schedule_EndDate){
								beforeScheduleDate = getDays(schedule_EndDate,$('#scheduleBeginDate').val())-1
								$('#beforeScheduleDate').val(beforeScheduleDate)
							}
						}
					});

					//回显数据
					if (type == 1 || type == 4) {
						form.val("formTest", data);
						//责任人id
						$('[name="scheduleUserName"]').attr('user_id',data.scheduleUser)
						//监督人id
						$('[name="supervisorUserName"]').attr('user_id',data.supervisorUser)

						//上级任务
						$('[name="parentScheduleId"]').val(data&&data.parentSchedule ? data.parentSchedule.scheduleName : '');
						$('[name="parentScheduleId"]').attr('parentScheduleId',data? data.parentScheduleId : '');
						//上级任务开始时间
						$('#schedule_BeginDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleBeginDate : '');
						//上级任务结束时间
						$('#schedule_EndDate').val(data&&data.parentSchedule ? data.parentSchedule.scheduleEndDate : '');
						//查看详情
						if(type==4){
							$('._disabled').find('input,select').attr('disabled', 'disabled');
							$('.refresh_no_btn').hide();
							// $('.file_upload_box').hide()
							// $('.deImgs').hide();
						}
					}else {
						// 获取自动编号
						getAutoNumber({autoNumberType: 'operationDictionary'}, function(res) {
							$('#baseForm input[name="documentNo"]').val(res.obj);
							$('#baseForm input[name="companySort"]').val(res.object.sort);
							$('#baseForm input[name="scheduleUserName"]').val(res.object.createUserName).attr('user_id',res.object.createUser);
						});
					}
					if(data&&data.beforeSchedule&&data.beforeSchedule.scheduleName){
						$('#beforeScheduleDate').attr('disabled',false).css("background","")
					}else {
						$('#beforeScheduleDate').attr('disabled',true).css("background","#e7e7e7").val('')
					}
					element.render();
					form.render()
				},
				yes: function (index,layero) {
					if(type!='4'){
						var datas = $('#baseForm').serializeArray();
						var obj = {}
						datas.forEach(function (item) {
							obj[item.name] = item.value
						});

						//责任人id
						var scheduleUser = $('#baseForm input[name="scheduleUserName"]').attr('user_id')
						if(scheduleUser&&scheduleUser.indexOf(',')!=-1){
							scheduleUser = scheduleUser.substring(0,scheduleUser.lastIndexOf(','))
						}
						obj.scheduleUser = scheduleUser || '';

						//监督人id
						var supervisorUser = $('#baseForm input[name="supervisorUserName"]').attr('user_id')
						if(supervisorUser&&supervisorUser.indexOf(',')!=-1){
							supervisorUser = supervisorUser.substring(0,supervisorUser.lastIndexOf(','))
						}
						obj.supervisorUser = supervisorUser || '';

						//上级任务
						obj.parentScheduleId = $('[name="parentScheduleId"]').attr('parentScheduleId')||'0'

						// obj.projectId = projectId?projectId:data.projectId;


						if(type == '1'){
							obj.scheduleTemplteId= data.scheduleTemplteId;
						}


						// 判断必填项
						var requiredFlag = false;
						$('#baseForm').find('.field_required').each(function(){
							var field = $(this).attr('field');
							if (!obj[field]) {
								var fieldName = $(this).parent().text().replace('*', '');
								layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
								requiredFlag = true;
								return false;
							}
						});
						if (requiredFlag) {
							return false;
						}
						var loadIndex = layer.load();

						$.ajax({
							url: url,
							data: obj,
							dataType: 'json',
							type: 'post',
							success: function (res) {
								layer.close(loadIndex);
								if (res.code=='0') {
									layer.msg('保存成功！', {icon: 1});
									layer.close(index);

									SettlementTable.reload();

								} else {
									layer.msg(res.msg, {icon: 7});
								}
							}
						});
					}else {
						layer.close(index);
					}

				}
			});
		}
		//进度计划模板页面与计家云页面切换
		element.on('tab(tabTaggle)', function(){
			childFunc(columnTrId);
			childFunc1(columnTrId1);
		});




		//表格头工具事件
		var parData3;
		var columnTrId3;
		var codeNo3;
		var codNam3;
		treeTable.on('toolbar(Settlement1)', function(obj){
			var checkStatus = SettlementTable.checkStatus();
			var event = obj.event;
			switch(event){
				case 'supplierImport2': //导入本地
					if(checkStatus.length!='1'){
						layer.msg("请选择一条");
					}else{
						layer.open({
							type: 1,
							skin: 'layui-layer-molv', //加上边框
							area: ['20%', '60%'], //宽高
							title: '导入本地',
							btn: ['确定', '取消'],
							btnAlign: 'c',
							content:
									'<div class="layui-card-body" style="height: 100%">'+
									'<div class="panel-body">'+
									'<div class="eleTree elee4" lay-filter="tdata2"></div>'+
									'</div>'+
									'</div>',
							success: function () {
								// 初始化渲染 树形菜单
								var el = eleTree.render({
									elem: '.elee4',
									showLine:true,
									url:'/scheduleTemplte/getScheduleTemplteByType?parent=0',
									lazy: true,
									// checked: true,
									load: function(data,callback) {
										$.post('/scheduleTemplte/getScheduleTemplteByType?parent='+data.id,function (res) {
											callback(res.data);//点击节点回调
										})
									},
									done:function (data) { //渲染完成回调
										var n1 = $("#ulBox").find("li.layui-this").attr("codeNo");
										var na = $("#ulBox").find("li.layui-this").html();
										codNam3 = encodeURI(encodeURI(na));
										codeNo3 = n1;
										if(data&&data.data&&data.data.length > 0){
											columnTrId3 = data.data[0].id;
											var dataid=$('.elee4 div').attr("data-id")
											$('.eleTree-node').removeClass('back')
											$('.elee4 div[data-id='+dataid+']').addClass('back')
											$('.eleTree-node-group').css('background','#fff');
										}else{
											$('.elee4').html('<div style="text-align: center">暂无数据</div>');
											columnTrId3 = undefined;
										}
									}
								});
							},
							yes: function (index, layero) {
								delete  checkStatus.securityCreateUser;
								delete  checkStatus.securityCreateTime;
								delete  checkStatus.securityDangerId;
								delete  checkStatus.templteDetailsId;
								checkStatus.securityDangerTypeId = columnTrId3;
								$.ajax({
									url:'/workflow/secirityManager/insertSecurityTemplteDetails',
									type: 'post',
									dataType:'json',
									data:checkStatus,
									success:function(res){
										if(res.code===0||res.code==="0"){
											layer.close(index);
										}
										layer.msg(res.msg)
									}
								})
							}
						});
					}
					break;
			};
		});

		// 节点点击事件
		eleTree.on("nodeClick(tdata2)",function(d) {
			parData3 = d.data.currentData;
			var n1 = $("#ulBox").find("li.layui-this").attr("codeNo3");
			var na = $("#ulBox").find("li.layui-this").html();
			codNam3 = encodeURI(encodeURI(na));
			codeNo3 = n1;
			columnTrId3 = d.data.currentData.id;
			var clas = "";
			var dataid=$(clas+' div').attr("data-id")
			$('.eleTree-node').removeClass('back')
			$(d.node[0]).addClass('back')
			$('.eleTree-node-group').css('background','#fff')
		});


		//表格行操作事件
		treeTable.on('tool(Settlement)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var dataa = obj.data; //获得当前行数据
			var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
			var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
			if(layEvent === 'delete'){ //删除
				layer.confirm('确定要删除检查项吗？', {icon: 3, title:'提示'}, function(index){
					var ids=dataa.scheduleTemplteId;
					$.ajax({
						url:'/scheduleTemplte/del',
						type: 'post',
						dataType: 'json',
						data:{ids:ids},
						success:function(res){
							layer.msg(res.msg);
							SettlementTable.reload();
						}
					});
					layer.close(index);
				});
			}
		})




		//左侧新建类型
		$('#addPlan').click(function () {
			layer.open({
				type: 1,
				title: "新建",
				shadeClose: true,
				btn: ['提交', '取消'],
				btnAlign: 'c',
				shade: 0.5,
				maxmin: true, //开启最大化最小化按钮
				area: ['40%', '50%'],
				content: '<form class="layui-form" lay-filter="formTest" action=""style="width: 100%;\n' +
						'margin: 10px auto;">\n' +
						'                                    <div class="layui-form-item">\n' +
						'                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>\n' +
						'                                        <div class="layui-input-block">\n' +
						'                                            <input type="text" id="scheduleTypeSort" name="scheduleTypeSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
						'                                        </div>\n' +
						'                                    </div>\n' +
						'                                    <div class="layui-form-item">\n' +
						'                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
						'                                        <div class="layui-input-block">\n' +
						'                                            <input type="text" name="scheduleTypeName" id="scheduleTypeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
						'                                        </div>\n' +
						'                                    </div>\n' +
						'                                    <div class="layui-form-item">\n' +
						'                                        <label class="layui-form-label"><span style="color: red;">*</span>父级类型</label>\n' +
						'                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
						'                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
						'                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
						'                                        </div>\n' +
						'                                    </div>\n' +
						'                                </form>',
				success: function () {
					$("[name='ttitle']").on("click",function (e) {
						e.stopPropagation();
						ell=eleTree.render({
							elem: '.ele2',
							url:'/scheduleTemplte/getScheduleTemplteByType?parent=0',
							expandOnClickNode: false,
							highlightCurrent: true,
							showLine:true,
							lazy: true,
							load: function(data,callback) {
								$.post('/scheduleTemplte/getScheduleTemplteByType?parent='+data.id,function (res) {
									callback(res.data);//点击节点回调
								})
							},
							done: function(res){
								if(data&&data.data&&data.data.length > 0){

								}else{
									$('.ele2').html('<div style="text-align: center">暂无数据</div>');
								}
							}
						});
						$(".ele2").slideDown();
					})
					eleTree.on("nodeClick(data1)",function(d) {
						$("[name='ttitle']").val(d.data.currentData.label)
						$("#pele").attr("pid",d.data.currentData.id)
						$(".ele2").slideUp();
					})
					$(document).on("click",function() {
						$(".ele2").slideUp();
					})
				},
				yes: function (indexx) {
					var plbSecurityKnowledge = {};
					plbSecurityKnowledge.scheduleTypeSort = $("#scheduleTypeSort").val();
					plbSecurityKnowledge.scheduleTypeName = $("#scheduleTypeName").val();
					// plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
					var parent = $("#pele").attr("pid");
					if(parent==undefined||parent==""){
						parent=0;
					}
					plbSecurityKnowledge.scheduleTypeParent =parent;
					// plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
					if($("#scheduleTypeName").val()==''){ //||$("#columnCode").val()==''
						layer.msg("必填项不能为空")
					}else{
						$.ajax({
							type: "post",
							url: '/scheduleTemplte/insertType',
							dataType: "json",
							data:plbSecurityKnowledge,
							success:function (res) {
								if(res.code == "0" || res.code == 0){
									layer.msg(res.msg);
									setTimeout(function(){
										if(el){
											el.reload()
										}
										if(ell){
											ell.reload();
										}
										layer.close(indexx)
									},1000)
								}else{
									layer.msg(res.msg);
								}
							}
						})
					}
				}
			});
		})
		//左侧编辑类型
		$('#editPlan').click(function () {
			layer.open({
				type: 1,
				title: "编辑",
				shadeClose: true,
				btn: ['提交', '取消'],
				btnAlign: 'c',
				shade: 0.5,
				maxmin: true, //开启最大化最小化按钮
				area: ['40%', '50%'],
				content: '<form class="layui-form" lay-filter="formTest" action=""style="width: 100%;\n' +
						'margin: 10px auto;">\n' +
						'                                    <div class="layui-form-item">\n' +
						'                                        <label class="layui-form-label" style=""><span style="color: red;">*</span>排序号</label>\n' +
						'                                        <div class="layui-input-block">\n' +
						'                                            <input type="text" id="scheduleTypeSort" name="scheduleTypeSort" lay-verify="required" placeholder="请输入排序号" autocomplete="off" class="layui-input">\n' +
						'                                        </div>\n' +
						'                                    </div>\n' +
						'                                    <div class="layui-form-item">\n' +
						'                                        <label class="layui-form-label"><span style="color: red;">*</span>类型名称</label>\n' +
						'                                        <div class="layui-input-block">\n' +
						'                                            <input type="text" name="scheduleTypeName" id="scheduleTypeName" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
						'                                        </div>\n' +
						'                                    </div>\n' +
						'                                    <div class="layui-form-item">\n' +
						'                                        <label class="layui-form-label"><span style="color: red;">*</span>父级类型</label>\n' +
						'                                        <div class="layui-input-block" id="parent" style="position: relative">\n' +
						'                                            <input type="text" style="cursor: pointer" id="pele" pid name="ttitle" required="" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">\n' +
						'                                            <div class="eleTree ele2" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;z-index: 999;top:38px;left:0px;width: 99%;"></div>\n' +
						'                                        </div>\n' +
						'                                    </div>\n' +
						'                                </form>',
				success: function () {
					$.ajax({
						url:'/scheduleTemplte/getByIdType?kayId='+columnTrId,
						dataType:'json',
						type:'post',
						success:function(res){
							if(res.code===0||res.code==="0"){
								if(res.obj){
									if(res.obj.scheduleTypeSort!=undefined&&res.obj.scheduleTypeSort!=""){
										$("#scheduleTypeSort").val(res.obj.scheduleTypeSort);
									}
									if(res.obj.scheduleTypeName!=undefined&&res.obj.scheduleTypeName!=""){
										$("#scheduleTypeName").val(res.obj.scheduleTypeName);
									}
									if(res.obj.parentName!=undefined&&res.obj.parentName!=""){
										$("#pele").val(res.obj.parentName);
										$("#pele").attr("pid",res.obj.scheduleTypeParent);
									}
								}
							}
						}
					})
					$("[name='ttitle']").on("click",function (e) {
						e.stopPropagation();
						ell=eleTree.render({
							elem: '.ele2',
							url:'/scheduleTemplte/getScheduleTemplteByType?parent=0',
							expandOnClickNode: false,
							highlightCurrent: true,
							showLine:true,
							lazy: true,
							load: function(data,callback) {
								$.post('/scheduleTemplte/getScheduleTemplteByType?parent='+data.id,function (res) {
									callback(res.data);//点击节点回调
								})
							},
							done: function(res){
								if(data&&data.data&&data.data.length > 0){

								}else{
									$('.ele2').html('<div style="text-align: center">暂无数据</div>');
								}
							}
						});
						$(".ele2").slideDown();
					})
					eleTree.on("nodeClick(data1)",function(d) {
						if(d.data.currentData.id==columnTrId){
							layer.msg('父级类型不能是自己！', {icon: 0});
							return false
						}
						$("[name='ttitle']").val(d.data.currentData.label)
						$("#pele").attr("pid",d.data.currentData.id)
						$(".ele2").slideUp();
					})
					$(document).on("click",function() {
						$(".ele2").slideUp();
					})
				},
				yes: function (indexx) {
					var plbSecurityKnowledge = {};
					plbSecurityKnowledge.scheduleTypeId = columnTrId;
					plbSecurityKnowledge.scheduleTypeSort = $("#scheduleTypeSort").val();
					plbSecurityKnowledge.scheduleTypeName = $("#scheduleTypeName").val();
					// plbSecurityKnowledge.columnDesc = $("#columnDesc").val();
					var parent = $("#pele").attr("pid");
					if(parent==undefined||parent==""){
						parent=0;
					}
					plbSecurityKnowledge.scheduleTypeParent =parent;
					// plbSecurityKnowledge.sysCode = $("#pele").attr("pcode")
					if($("#scheduleTypeName").val()==''){ //||$("#columnCode").val()==''
						layer.msg("必填项不能为空")
					}else{
						$.ajax({
							type: "post",
							url: '/scheduleTemplte/updateByIdType',
							dataType: "json",
							data:plbSecurityKnowledge,
							success:function (res) {
								if(res.code == "0" || res.code == 0){
									layer.msg(res.msg);
									setTimeout(function(){
										if(el){
											el.reload()
										}
										if(ell){
											ell.reload();
										}
										layer.close(indexx)
									},1000)
								}else{
									layer.msg(res.msg);
								}
							}
						})
					}
				}
			});
		})

		//左侧删除类型
		$('#delPlan').click(function () {
			if(columnTrId){
				layer.confirm('是否要删除', {icon: 3, title: '删除'}, function (index) {
					$.ajax({
						url: '/scheduleTemplte/delType',
						data: {ids: columnTrId},
						type: 'get',
						dataType: 'json',
						success: function (res) {
							if (res.code===0||res.code==="1") {
								if(el){
									el.reload()
								}
								if(ell){
									ell.reload();
								}
								layer.msg(res.msg, {icon: 1})
							} else {
								layer.msg(res.msg, {icon: 2})
							}
						}
					})
					layer.close(index);
				});
			}else{
				layer.msg('请点击左侧类型进行删除')
			}
		})
	});


	//监听持续时间
	$(document).on('input propertychange', '#scheduleDuration', function () {
		var scheduleDuration = $('#scheduleDuration').val()
		var scheduleBeginDate = $('#scheduleBeginDate').val()
		var scheduleEndDate = ''
		if(scheduleDuration&&scheduleBeginDate){
			scheduleEndDate = getNewDay(scheduleBeginDate,scheduleDuration,-1)
			$('#scheduleEndDate').val(scheduleEndDate)
		}
	})


	//日期加上天数得到新的日期
	//dateTemp 需要参加计算的日期，days要添加的天数，返回新的日期，日期格式：YYYY-MM-DD
	//differ 相差几天
	function getNewDay(dateTemp, days,differ) {
		days = Number(days) + Number(differ)
		var dateTemp = dateTemp.split("-");
		var nDate = new Date(dateTemp[1] + '-' + dateTemp[2] + '-' + dateTemp[0]); //转换为MM-DD-YYYY格式
		var millSeconds = Math.abs(nDate) + (days * 24 * 60 * 60 * 1000);
		var rDate = new Date(millSeconds);
		var year = rDate.getFullYear();
		var month = rDate.getMonth() + 1;
		if (month < 10) month = "0" + month;
		var date = rDate.getDate();
		if (date < 10) date = "0" + date;
		return (year + "-" + month + "-" + date);
	}

	/**
	 * 日期解析，字符串转日期
	 * @param dateString 可以为2017-02-16，2017/02/16，2017.02.16
	 * @returns {Date} 返回对应的日期
	 */
	function dateParse(dateString){
		var SEPARATOR_BAR = "-";
		var SEPARATOR_SLASH = "/";
		var SEPARATOR_DOT = ".";
		var dateArray;
		if(dateString.indexOf(SEPARATOR_BAR) > -1){
			dateArray = dateString.split(SEPARATOR_BAR);
		}else if(dateString.indexOf(SEPARATOR_SLASH) > -1){
			dateArray = dateString.split(SEPARATOR_SLASH);
		}else{
			dateArray = dateString.split(SEPARATOR_DOT);
		}
		return new Date(dateArray[0], dateArray[1]-1, dateArray[2]).getTime();
	};
	//根据2个日期计算相差天数
	function getDays(strDateStart,strDateEnd){
		var strSeparator = "-"; //日期分隔符
		var oDate1;
		var oDate2;
		var iDays;
		oDate1= strDateStart.split(strSeparator);
		oDate2= strDateEnd.split(strSeparator);
		var strDateS = new Date(oDate1[0], oDate1[1]-1, oDate1[2]);
		var strDateE = new Date(oDate2[0], oDate2[1]-1, oDate2[2]);
		iDays = parseInt(Math.abs(strDateS - strDateE ) / 1000 / 60 / 60 /24)//把相差的毫秒数转换为天数
		return iDays ;
	}

	//其他页面引用
	function getRepairDate(){
		if(columnTrId){
			var datas = SettlementTable.checkStatus();
			if(datas&&datas.length>0){
				// var scheduleTemplteIds = ''
				// datas.forEach(function (item) {
				// 	scheduleTemplteIds+=item.scheduleTemplteId+','
				// })
				// return {scheduleTemplteIds:scheduleTemplteIds}
				return {datas:datas}
			}
			return {scheduleTypeId:columnTrId}
		}else {
			layui.layer.msg("请选择数据")
		}
		return null;
	}


	// 初始化页面操作权限
	// function initAuthority() {
	//     // 是否设置页面权限
	//     if (authorityObject) {
	//         // 检查保存权限
	//         if (authorityObject['01']) {
	//             $('#addPlan').show();
	//         }
	//         if (authorityObject['05']) {
	//             $('#editPlan').show();
	//         }
	//         if (authorityObject['04']) {
	//             $('#delPlan').show();
	//         }
	//     }
	// }
</script>
</body>
</html>

