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
	<title>安全检查记录</title>
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
		html, body {
			width: 100%;
			height: 100%;
			background: #fff;
		}
		.mbox{
			padding: 0px;
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
			<h2 style="text-align: center;line-height: 35px;">安全检查记录</h2>
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
								<option value="testTypeNo">检查类型</option>
								<option value="testDeptId">被检查单位</option>
								<option value="planDate">计划检查时间</option>
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
								<select id="testTypeNo" name="testTypeNo" ></select>
							</div>
							<div id="selha3" style="display: none">
								<input type="text" id="testDeptId"  name="testDeptId" placeholder="请选择" autocomplete="off" class="layui-input">
							</div>
							<div id="selha4" style="display: none">
								<input class="layui-input" id="beginTime" autocomplete="off"  name="beginTime" style="height: 38px;width: 47%; margin-left: 6px;position: relative">
								<span style="display: block; position: absolute;top: 8px;left: 100px">-</span>
								<input class="layui-input" id="endTime" autocomplete="off"  name="endTime" style="height: 38px;width: 47%;margin-left: 6px;position: absolute;left:102px;top: 0px;">
							</div>
						</div>
						<div class="layui-input-inline" style="float: left;height: 32px;margin-top: 4px;">
							<a class="layui-btn" data-type="reload" lay-event="searchCust" id="searchCust" style="float:left;height:32px;line-height: 32px;margin-left: 10px">搜索</a>
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
		&lt;%&ndash;<button class="layui-btn layui-btn-sm" lay-event="submit" style="width: 60px" id="">提交</button>&ndash;%&gt;
		<button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 60px" id="">导入</button>
		&lt;%&ndash;<button class="layui-btn layui-btn-sm" lay-event="delete" style="width: 60px">导出</button>&ndash;%&gt;
	</div>
</script>--%>
<script type="text/html" id="toolbar">
	<div class="layui-btn-container">
		<%--{{#  if(authorityObject && authorityObject['21']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="submit" style="width: 60px">提交</button>
		{{#  } }}--%>
		{{#  if(authorityObject && authorityObject['02']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="upfile" style="width: 60px" id="">导入</button>
		{{#  } }}
		<%--{{#  if(authorityObject && authorityObject['03']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="export" style="width: 60px">导出</button>
		{{#  } }}--%>
	</div>
</script>
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
<%--<script type="text/html" id="barOperation">
	<a class="layui-btn layui-btn-xs" lay-event="flowsheet" >流程图</a>
</script>--%>
<%----------------------------------------------------数据操作--------------------------------------------------------------------------%>

<script type="text/javascript">
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
        //渲染检查类型
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
                        optionStr += '<option value="' + data[i].dictNo + '">' + data[i].dictName + '</option>'
                    }
                }
            }
        })
        $select1.html(optionStr);
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
		form.render()
		form.on('select(columnName)',function (data) {
			if(data.value=="projectId") {
				$("#selha1").show();
				$("#selha2").hide();
				$("#selha3").hide();
				$("#selha4").hide();
				$("#selha").hide();
			}else if(data.value=="testTypeNo"){
                $("#selha1").hide();
                $("#selha2").show();
                $("#selha3").hide();
                $("#selha4").hide();
				$("#selha").hide();
			}else if(data.value=="testDeptId"){
                $("#selha1").hide();
                $("#selha2").hide();
                $("#selha3").show();
                $("#selha4").hide();
				$("#selha").hide();
			}else if(data.value=="planDate"){
				laydate.render({
					elem: '#beginTime'
					, trigger: 'click'
					, format: 'yyyy-MM-dd'
					// , format: 'yyyy-MM-dd HH:mm:ss'
				});
				laydate.render({
					elem: '#endTime'
					, trigger: 'click'
					, format: 'yyyy-MM-dd'
					// , format: 'yyyy-MM-dd HH:mm:ss'
				});
                $("#selha1").hide();
                $("#selha2").hide();
                $("#selha3").hide();
                $("#selha4").show();
				$("#selha").hide();
			}else{
                $("#selha1").hide();
                $("#selha2").hide();
                $("#selha3").hide();
                $("#selha4").hide();
				$("#selha").show();
			}
		})
		//头工具栏事件

		$('#searchCust').click(function () {
			var serchSelect = $("#serchSelect").next(".layui-form-select").find("dl dd.layui-this").attr("lay-value"); //下拉列表的值
			var searchtext = "";
			var searchtext1 = "";
			var serchObjUrl = "/workflow/secirityManager/getSecurityCheckByStatus";
			//debugger
			if(serchSelect == "projectId"){
				searchtext = $("#projectId").val();
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/secirityManager/getSecurityCheckByStatus";//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					serchObjUrl = "/workflow/secirityManager/getSecurityCheckByStatus?"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "testTypeNo"){
				searchtext = $("#testTypeNo").val(); //输入框的值
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/secirityManager/getSecurityCheckByStatus";//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					serchObjUrl = "/workflow/secirityManager/getSecurityCheckByStatus?"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "testDeptId"){
				searchtext = $("#testDeptId").attr("deptid"); //输入框的值
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/secirityManager/getSecurityCheckByStatus";//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					if(searchtext.indexOf(",")!=-1){
						searchtext = searchtext.replace(",","");
					}else if(searchtext.indexOf("，")!=-1){
						searchtext = searchtext.replace("，","");
					}
					serchObjUrl = "/workflow/secirityManager/getSecurityCheckByStatus?"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "planDate"){
				searchtext = $("#beginTime").val(); //输入框的值
				searchtext1 = $("#endTime").val();
				serchObjUrl = "/workflow/secirityManager/getSecurityCheckByStatus?";
				if(searchtext!=""&&searchtext!=undefined){
					serchObjUrl+="&beginTime="+searchtext
				}
				if(searchtext1!=""&&searchtext1!=undefined){
					serchObjUrl+="&endTime="+searchtext1
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
				, url: '/workflow/secirityManager/getSecurityCheckByStatus?projectId=' + projectId//数据接口
				, page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
					layout: ['prev', 'page', 'next', 'skip', 'count', 'limit',]//自定义分页布局
					, limits: [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]
					, first: false //不显示首页
					, last: false //不显示尾页
				} //开启分页
				, toolbar: '#toolbar'
				, cols: [[ //表头
					{type: 'checkbox'}
					, {field: 'checkliId', title: 'ID'}
					, {field: 'projectName', title: '项目名称'}
					, {field: 'planName', title: '检查计划名称',event: 'detail', style:'cursor: pointer;color:blue'}
					, {field: 'testTypeName', title: '检查类型'}
					, {field: 'testDeptName', title: '被检查单位'}
					, {field: 'dangerNumber', title: '隐患数量'}
					, {field: 'planDate', title: '计划检查时间'}
					, {field: 'dangerName', title: '检查内容'}
					, {field: 'testLeaderName', title: '检查组长'}
					, {field: 'checkUserName', title: '检查人'}
					, {field: 'checkTime', title: '检查时间'}
					//, {width:100, title: '操作',align:'center', toolbar: '#barOperation'}
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
				case 'submit'://提交
					if (checkStatus.length == 0 ) {
						layer.msg("请选择至少一条");
					} else {
						var checkliIds ='';
						for(var i=0;i<checkStatus.length;i++){
							checkliIds += checkStatus[i].checkliId+','
						}
						$.ajax({
							url:'/workflow/secirityManager/commitChecklist?checkliIds='+checkliIds+'&status=1',
							type: 'post',
							dataType:'json',
							success:function(res){
								if(res.code===0||res.code==="1"){
									//layer.closeAll();
									layer.msg(res.msg)
									SettlementTable.reload();
								}

							}
						})
					}
					break;
				case 'upfile': //导入
					layer.msg("功能正在开发中");
					break;
				case 'delete':  //多条删除
					if(checkStatus.length == 0){
						layer.msg("请选中一条或多条数据，进行删除");
						return false;
					}else{
						var docfileIds = "";
						for(var i=0;i<checkStatus.length;i++){
							docfileIds += checkStatus[i].docfileId+",";
						}
						layer.confirm('确定要删除吗？', function(index){
							$.ajax({
								type: "post",
								url: '/fileManage/delFile',
								dataType: "json",
								data:{
									columnIds:docfileIds
								},
								success:function (res) {
									if(res.code == "0" || res.code == 0){
										SettlementTable.reload();
									}
									layer.msg(res.msg);
								}
							})
							layer.close(index);
						});
					}
					break;
			};
		});

		//表格行操作事件
		table.on('tool(SettlementFilter)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var dataa = obj.data; //获得当前行数据
			console.log(dataa);
			var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
			var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
			if(layEvent === 'detail'){ //安全记录详情
				layer.open({
					type: 2,
					skin: 'layui-layer-molv', //加上边框
					area: ['100%', '100%'], //宽高
					title: '安全记录详情',
					maxmin: true,
					//btn: ['确定'],
					content: '/workflow/secirityManager/addSecurityCheckRecord?planItemId='+dataa.planItemId,
					success: function () {

					},
					/*yes: function (index, layero) {
						layer.close(index)
					}*/
				});
			}/*else if(layEvent === 'flowsheet'){ //流程图
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
						$.ajax({
							url:'/workflow/secirityManager/flowChart?securityContentId='+dataa.securityContentId,
							type: 'post',
							dataType:'json',
							success:function(res){
								if(res.code===0||res.code==="0"){
									//layer.closeAll();
									layer.msg(res.msg)
									console.log(res);
								}

							}
						})
                        /!*var data = [
                            {'title': "第一步", "desc": "2018-07-01 10:24:42"},
                            {'title': "第二步", "desc": "2018-07-01 10:44:42"},
                            {'title': "第三步", "desc": "2018-07-01 10:44:42"},
                            {'title': "第四步", "desc": "2018-07-01 10:44:42"},
							{'title': "第五步", "desc": "2018-07-01 10:44:42"}
                        ];*!/
                        make(data, '#steps', 3)
					},
					/!*yes: function (index, layero) {
						layer.close(index)
					}*!/
				});
			}*/
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

</script>
</body>
</html>
