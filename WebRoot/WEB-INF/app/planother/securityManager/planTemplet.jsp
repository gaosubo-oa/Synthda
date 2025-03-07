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
	<title>计划模板管理</title>
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
			background: #fff;
			user-select: none;
		}

		/*伪元素是行内元素 正常浏览器清除浮动方法*/
		.clearfix:after {
			content: "";
			display: block;
			height: 0;
			clear: both;
			visibility: hidden;
		}

		.clearfix {
			*zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
		}

		.container {
			position: relative;
			width: 100%;
			height: 100%;
		}

		.con_left {
			float: left;
			width: 230px;
			height: 100%;
			margin-top: 10px;
		}

		.left_List .left_List_item{
			width: 100%;
			line-height: 40px;
			padding-left: 10px;
			border-bottom: 1px solid #ddd;
			border-radius: 3px;
			overflow: hidden;
			box-sizing: border-box;
			word-break: break-all;
			white-space: nowrap;
			text-overflow: ellipsis;
			cursor: pointer;
		}

		.left_List .select{
			background: #c7e1ff;
		}

		.con_right {
			float: left;
			width: calc(100% - 230px);
			height: 100%;
			position: relative;
			overflow-y: auto;
			/*margin-top: 41px;*/
		}

		.project_tree_module {
			float: left;
			width: 255px;
			min-height: 50px;
			padding-right: 15px;
			box-sizing: border-box;
			height: 100%;
			overflow: hidden;
		}
		.project_info {
			float: left;
			width: calc(100% - 255px);
			box-shadow: 0 0px 5px 0 rgba(0,0,0,.1);
			border-radius: 3px;
		}

		.project_name {
			font-size: 18px;
			font-weight: 500;
		}
		.inputs input{
			height: 30px !important;
		}
		form{
			padding: 10px;
			margin-left: -20px;
		}
		.query .layui-form-item{
			margin-bottom: 0px;
		}
		.query .layui-input{
			height: 35px;
		}
		.query .layui-input-block{
			margin-top: 2px;
		}
		.foldIcon{
			display: none;
			position: absolute;
			left: -8px;
			top: 42%;
			font-size: 30px;
			cursor: pointer;
		}
		.select{
			/*background: #c7e1ff;*/
			background: #eee;
		}
		.con_left ul li{
			padding: 5px;
		}
		.con_left ul{
			overflow-y: auto;
		}
		.layui-btn-container{
			position: relative;
		}
		.layui-layer-btn{
			text-align: center;
		}
		.ew-tree-table{
			margin-left: 10px !important;
		}
		.con_left input{
			height: 35px;
		}
		.query .layui-form-label{
			padding: 9px 0px;
		}
		.query .layui-input-block{
			margin-left: 90px
		}
		.layui-btn-container .layui-btn{
			margin-bottom: 0px;
		}
		.ew-tree-table .ew-tree-table-tool{
			padding: 6px 15px !important;
			min-height: 30px !important;
		}
		.ew-tree-table-tool-right{
			position: absolute;
			right: 12px;
			top: 6px;
		}
		/*固定顶部*/
		/*  .ew-tree-table-tool{
              position: fixed;
              top: 110px;
              width: 80.6%;
              z-index: 99999;
          }*/
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
<div class="container" style="padding-top: 15px;box-sizing: border-box">
	<input type="hidden" id="leftId" class="layui-input">
	<%--限制最高顶级工区新建时间--%>
	<input type="hidden" id="plan_time">
	<%-- <div class="header">
         <div class="headImg" style="padding-top: 10px">
                     <span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img
                             style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span
                             style="margin-left: 10px">子项目</span></span>
         </div>
     </div>
     <hr>--%>
<%--	<div class="query layui-form layui-row">--%>
<%--		<div class="layui-col-xs2">--%>
<%--			<div class="layui-form-item" style="width: 237px">--%>
<%--				<label class="layui-form-label" >子项目名称</label>--%>
<%--				<div class="layui-input-block" >--%>
<%--					<input type="text" name="pbagName" required  lay-verify="required"  autocomplete="off" class="layui-input">--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="layui-col-xs2" style="width: 16.1%">--%>
<%--			<div class="layui-form-item" >--%>
<%--				<label class="layui-form-label">施工单位</label>--%>
<%--				<div class="layui-input-block">--%>
<%--					<select name="buildUnit" lay-verify="required">--%>
<%--						<option value="">请选择</option>--%>
<%--					</select>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="layui-col-xs2" style="width: 16.2%">--%>
<%--			<div class="layui-form-item">--%>
<%--				<label class="layui-form-label">设计单位</label>--%>
<%--				<div class="layui-input-block">--%>
<%--					<select name="designUnit" lay-verify="required">--%>
<%--						<option value="">请选择</option>--%>
<%--					</select>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="layui-col-xs2" style="width: 16.2%">--%>
<%--			<div class="layui-form-item">--%>
<%--				<label class="layui-form-label">子项目类型</label>--%>
<%--				<div class="layui-input-block">--%>
<%--					<select name="pbagType" lay-verify="required">--%>
<%--						<option value="">请选择</option>--%>
<%--					</select>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="layui-col-xs2" style="width: 16.2%">--%>
<%--			<div class="layui-form-item">--%>
<%--				<label class="layui-form-label">子项目状态</label>--%>
<%--				<div class="layui-input-block">--%>
<%--					&lt;%&ndash;                    <input type="text" name="bagStatus" required  lay-verify="required" autocomplete="off" class="layui-input">&ndash;%&gt;--%>
<%--					<select name="bagStatus" lay-verify="required">--%>
<%--						<option value="">请选择</option>--%>
<%--						<option value="1">未开始</option>--%>
<%--						<option value="2">超时未开始</option>--%>
<%--						<option value="3">正在进行</option>--%>
<%--						<option value="4">进度滞后</option>--%>
<%--						<option value="5">进度超前</option>--%>
<%--						<option value="6">暂停执行</option>--%>
<%--						<option value="7">正常完成</option>--%>
<%--						<option value="8">滞后完成</option>--%>
<%--						<option value="9">提前完成</option>--%>
<%--					</select>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="layui-col-xs2 authority_search" style="margin-top:4px;width: 18%; display: none;">--%>
<%--			<button type="button" class="layui-btn layui-btn-sm showAll"  style="float: right;" >显示全部</button>--%>
<%--			<button type="button" class="layui-btn layui-btn-sm"  onclick="reset()" style="float: right;margin-right: 10px;">重置</button>--%>
<%--			<button type="button" class="layui-btn layui-btn-sm querySubproject"  style="float: right">查询</button>--%>
<%--		</div>--%>
<%--	</div>--%>
	<div style="padding: 0px 8px;" class="clearfix">
		<div class="con_left">
			<%--组织筛选--%>
<%--			<div  class="layui-form">--%>
<%--				<select name="deptName" lay-verify="required" lay-filter="deptName">--%>
<%--				</select>--%>
<%--			</div>--%>
			<%--项目机构和项目信息--%>
			<%--            <div class="eleTree ele1" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeft"></div>--%>
			<ul style="margin-top: 10px;"></ul>
		</div>
		<div class="con_right">
			<%--<div class="tishi" style="height: 100%;text-align: center;border: none;">
                <div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
                <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧项目</h2>
            </div>--%>
			<div><%--style="position: relative"--%>
				<div id="formContent"></div>
			</div>
		</div>
	</div>
</div>
<script type="text/html" id="toolbarDemo">
	<div class="layui-btn-container" style="height: 30px;">
		{{#  if(authorityObject && authorityObject['07']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="initialization">初始化</button>
		{{#  } }}
		{{#  if(authorityObject && authorityObject['21']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="report">提交</button>
		{{#  } }}
		{{#  if(authorityObject && authorityObject['06']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="revision">修编</button>
		{{#  } }}
		{{#  if(authorityObject && authorityObject['39']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="revisionDetail">修编详情</button>
		{{#  } }}
		{{#  if(authorityObject && authorityObject['22']){ }}
		<button class="layui-btn layui-btn-sm" lay-event="stop">暂停</button>
		{{#  } }}
		<div style="top: 0px;right:28px;height: 30px;">
			{{#  if(authorityObject && authorityObject['01']){ }}
			<button class="layui-btn layui-btn-sm add" lay-event="add" style="margin-left:10px;">新增</button>
			{{#  } }}
			{{#  if(authorityObject && authorityObject['11']){ }}
			<button class="layui-btn layui-btn-sm addLevel" lay-event="addLevel" style="margin-left:10px;">添加平级</button>
			{{#  } }}
			{{#  if(authorityObject && authorityObject['12']){ }}
			<button class="layui-btn layui-btn-sm addNextLevel" lay-event="addNextLevel" style="margin-left:10px;">添加下一级</button>
			{{#  } }}
			{{#  if(authorityObject && authorityObject['05']){ }}
			<button class="layui-btn layui-btn-sm edit" lay-event="edit" style="margin-left:10px;">编辑</button>
			{{#  } }}
			{{#  if(authorityObject && authorityObject['04']){ }}
			<button class="layui-btn layui-btn-sm del" lay-event="del" style="margin-left:10px;">删除</button>
			{{#  } }}
			{{#  if(authorityObject && authorityObject['02']){ }}
			<button class="layui-btn layui-btn-sm" lay-event="import" style="margin-left:10px;">导入</button>
			{{#  } }}
			{{#  if(authorityObject && authorityObject['03']){ }}
			<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;">导出</button>
			{{#  } }}
			{{#  if(authorityObject && authorityObject['41']){ }}
			<button class="layui-btn layui-btn-sm" lay-event="drawing" style="margin-left:10px;">图纸管理</button>
			{{#  } }}
		</div>
	</div>
</script>

<script type="text/html" id="formTable1toolbar">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="initialization">新增</button>
		<button class="layui-btn layui-btn-sm" lay-event="initialization">删除</button>
	</div>
</script>
<script type="text/html" id="formTable1bar">
	<div class="layui-btn-container" style="height: 30px;">
		<button class="layui-btn layui-btn-sm" lay-event="initialization">删除</button>
	</div>
</script>

<script>
	initAuthority();
	var projectIdd;
	var projectIds = '';
	var form
	var insTb
	$('.con_left ul').height($(window).height()-180)
	// $('.con_right').height($(window).height()-180)
	//选人控件添加
	$(document).on('click','.userAdd',function () {
		var chooseNum=$(this).attr('chooseNum')==1? '?0' : ''
		user_id=$(this).siblings('textarea').attr('id')
		$.popWindow("/common/selectUser"+chooseNum);
	})
	//选人控件删除
	$(document).on('click','.userDel',function () {
		var userId=$(this).siblings('textarea').attr('id')
		$('#'+userId).val('')
		$('#'+userId).attr('user_id','')
	})
	var dictionaryObj = {PBAG_NATURE: {}, PBAG_CLASS: {}, PBAG_TYPE: {}, COST_TYPE: {}, PBAG_LEVEL: {}, ACCORDING: {}, PLAN_SYCLE: {}, TASK_TYPE: {},CUSTOMER_UNIT:{},WORKAREA_NAME:{}}
	var dictionaryStr = 'PBAG_NATURE,PBAG_CLASS,PBAG_TYPE,COST_TYPE,PBAG_LEVEL,ACCORDING,PLAN_SYCLE,TASK_TYPE,CUSTOMER_UNIT,WORKAREA_NAME'
	var CUSTOMER_UNIT=''
	var PBAG_CLASS=''
	// 获取数据字典数据
	$.ajax({
		url:'/Dictonary/selectDictionaryByDictNos',
		dataType:'json',
		type:'get',
		async:false,
		data:{dictNos: dictionaryStr},
		success:function(res){
			if (res.flag) {
				if(res.object['CUSTOMER_UNIT'] || res.object['PBAG_CLASS']){
					CUSTOMER_UNIT=res.object['CUSTOMER_UNIT']
					PBAG_CLASS=res.object['PBAG_CLASS']
				}
				for (var dict in dictionaryObj) {
					dictionaryObj[dict] = {object: {}, str: ''}
					if (res.object[dict]) {
						res.object[dict].forEach(function(item){
							dictionaryObj[dict]['object'][item.dictNo] = item.dictName
							dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
						})
					}
				}
			}
		}
	})
	layui.use(['treeTable','form','laydate','upload','eleTree',"table"], function () {
		var  treeTable = layui.treeTable;
		var  laydate = layui.laydate;
		var  upload = layui.upload;
		var eleTree = layui.eleTree;
		var form = layui.form;
		var table = layui.table;
		// var insTb
		$('.query select[name="buildUnit"]').append(dictionaryObj['CUSTOMER_UNIT']['str'])
		$('.query select[name="designUnit"]').append(dictionaryObj['CUSTOMER_UNIT']['str'])
		$('.query select[name="pbagType"]').append(dictionaryObj['PBAG_TYPE']['str'])
		form.render();
		//左侧下拉框部门展示
		$.ajax({
			// url:'/department/getDeptTop',
			url:'/plcOrg/selectYJ',
			dataType:'json',
			type:'get',
			success:function(res){
				var data=res.obj
				var str='<option value="">请选择</option>'
				for(var i=0;i<data.length;i++){
					str+='<option value="'+data[i].projOrgId+'">'+data[i].contractorName+'</option>'
				}
				$('.con_left [name="deptName"]').html(str)
				form.render()
				projectLeft($('.con_left [name="deptName"]').val())
			}
		})
		//加监听左侧下拉框部门选择
		form.on('select(deptName)', function(data){
			// console.log(data.value); //得到被选中的值
			projectLeft(data.value)
		});
		//左侧项目信息列表
		function projectLeft(projOrgId){
			var data=[{"id":"1","name":"安全检查计划模板"}];
			var str=''
			for(var i=0;i<data.length;i++){
				str+='<li statrtTime="'+function () {
				}()+'" id="'+data[i].id+'">'+data[i].name+'</li>';
			}
			$('.con_left ul').html(str)
		}
		// 节点点击事件
		$(document).on('click','.con_left ul li',function () {
			$(this).addClass('select').siblings().removeClass('select')
			var projectId=$(this).attr('id')
			projectIdd=$(this).attr('projectId')
			var projectNo=$(this).attr('projectNo')
			var statrtTime=$(this).attr('statrtTime')
			var endTime=$(this).attr('endTime')
			treeTableShow(projectId)
			$('.foldIcon').show()
			// debugger
			$('#leftId').attr('projectId',projectId)
			$('#leftId').attr('projectInfoNo',projectNo)
			$('#plan_time').attr('minTime',statrtTime)
			$('#plan_time').attr('maxTime',endTime)
		})
		// 渲染树形表格
		function treeTableShow(projectId) {
			if (projectId===1||projectId==="1") {
				 //安全检查计划
					var htm ='<form class="layui-form" id="formBox1" action="" lay-filter="formTest1">\n' +
							'<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'                <div class="layui-inline" style="width: 98%;">\n' +
							'                    <label class="layui-form-label" style="width: 30%;">项目名称</label>\n' +
							'                    <div class="layui-input-inline" style="width: 55%;">\n' +
							'                        <input type="text" id="companyName" placeholder="请选择" name="companyName" autocomplete="off" class="layui-input">\n' +
							'                    </div>\n' +
							'                </div>\n' +
							'            </div>\n' +
							'            <div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'                <div class="layui-inline" style="width: 98%;">\n' +
							'                    <label class="layui-form-label" style="width: 30%;">检查类型</label>\n' +
							'                    <div class="layui-input-inline" style="width: 55%;">\n' +
							'                        <input type="text" id="companyNo" name="companyNo" placeholder="请选择" autocomplete="off" class="layui-input">\n' +
							'                    </div>\n' +
							'                </div>\n' +
							'            </div>\n' +
							'            <div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'                <div class="layui-inline" style="width: 98%;">\n' +
							'                    <label class="layui-form-label" style="width: 30%;">被检查单位</label>\n' +
							'                    <div class="layui-input-inline" style="width: 55%;">\n' +
							'                        <input type="text" id="companyNo" name="companyNo" placeholder="请选择" autocomplete="off" class="layui-input">\n' +
							'                    </div>\n' +
							'                </div>\n' +
							'            </div>\n' +
							'            <div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
							'                <div class="layui-inline" style="width: 98%;">\n' +
							'                    <label class="layui-form-label" style="width: 30%;">检查组长</label>\n' +
							'                    <div class="layui-input-inline" style="width: 55%;">\n' +
							'                        <input type="text" id="companyNo" name="companyNo" placeholder="请选择" autocomplete="off" class="layui-input">\n' +
							'                    </div>\n' +
							'                </div>\n' +
							'            </div>\n' +
							'</form>\n' +
							'<div style="width: 88%;margin: auto;"><table id="formTable1" lay-filter="formTable1"></table></div>';
					$("#formContent").html(htm);
					form.render();
					var dat = []
						dat.push({"u1":"选择","u2":"选择","u3":"选择"})
					table.render({
						elem: '#formTable1'
						, page:false
						,data:dat
						,toolbar:'#formTable1toolbar'
						,cols: [[
							{field:'u1',title:'检查人'}
							,{field: 'u2', title: '检查区域'}
							,{field: 'u3', title: '检查项'}
							,{title: '操作', align: 'center', toolbar: '#formTable1bar'}
						]]
					});
			}
		}
		treeTable.on('toolbar(demoTreeTb)', function(obj){
			// console.log(obj)
			var $table = $('#demoTreeTb').siblings('.ew-tree-table').find('.ew-tree-table-box tbody');
			switch(obj.event){
				case 'edit':
					var checkData = insTb.checkStatus();
					if(checkData==undefined||checkData.length!=1){
						layer.msg("请选择一条进行编辑");
					}else{
						var checked = checkData[0];
						layer.open({
							type: 1,
							skin: 'layui-layer-molv', //加上边框
							area: ['30%', '30%'], //宽高
							title: '编辑区域名称',
							maxmin: true,
							btn: ['提交', '取消'],
							content: '<div class="layui-form">' +
										'<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
											'<label class="layui-form-label">区域名称</label>' +
											'<div class="layui-input-block">' +
												'<input class="layui-input"  lay-verify="required" name="regionName" id="regionName">' +
											'</div>' +
										'</div>' +
									'</div>',
							success: function () {
								$("#regionName").val(checked.regionName);
							},
							yes: function (index, layero) {
								var regionName = $("#regionName").val();
								if(regionName==undefined||regionName==""){
									layer.msg("请输入区域名称");
									return false;
								}else {
									var region = {
										regionName:regionName,
										regionId:checked.regionId
									}
									$.ajax({
										url:'/workflow/secirityManager/updateRegion',
										dataType:'json',
										type:'post',
										data:region,
										success:function(res){
											if(res.code===0||res.code==="0"){
												layer.msg(res.msg,{icon:1});
												$("div[lay-filter='demoTreeTb']").find("tr[data-index="+ checked.LAY_INDEX +"]").find("td[data-field='regionName']").find("span[class='ew-tree-pack']").find("span").text(regionName);//改变当前选中行
												layer.close(index)
											}else{
												layer.msg(res.msg,{icon:0});
											}
										}
									})
								}
							}
						});
					}
					break;
				case 'del':
					var checkData = insTb.checkStatus();
					if(checkData==undefined||checkData.length<1){
						layer.msg("请至少选择一条进行删除");
					}else{
						var delIds=''
						insTb.checkStatus().forEach(function (item,index) {
							delIds+=item.regionId+','
						})
						if(projectIdd!=undefined){
							layer.confirm('确定删除选中数据吗？', function(index){
								$.ajax({
									url:'/workflow/secirityManager/deleteRegion',
									dataType:'json',
									type:'post',
									data:{delIds:delIds,projectId:projectIdd},
									success:function(res){
										if(res.code===0||res.code==="0"){
											layer.msg(res.msg,{icon:1});
											layer.close(index)
											insTb.reload()
										}else{
											layer.msg(res.msg,{icon:0});
										}
									}
								})
							});
						}else{
							layer.msg("请点击左侧项目列表重试");
						}
					}
					break;
					case 'add':
						layer.open({
							type: 1,
							skin: 'layui-layer-molv', //加上边框
							area: ['40%', '60%'], //宽高
							title: '新增',
							maxmin: true,
							btn: ['提交', '取消'],
							content: '<div class="layui-form">' +
									'<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
									'<label class="layui-form-label">区域名称</label>' +
									'<div class="layui-input-block">' +
									'<input class="layui-input"  lay-verify="required" name="regionName" id="regionName">' +
									'</div>' +
									'</div>' +
									'<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
									'<label class="layui-form-label">上级区域</label>' +
									'<div class="layui-input-block">' +
									'<input type="text" id="pele" pid name="ttitle1" required="" style="cursor: pointer;" placeholder="请选择父级(不选择默认为一级)" readonly="" autocomplete="off" class="layui-input">' +
			                        '<div class="eleTree ele2" lay-filter="data2" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div>' +
									//'<input class="layui-input"  lay-verify="required" name="regionParent" id="regionParent" placeholder="请选择父级(不选择默认为一级)">' +
									'</div>' +
									'</div>' +
									'</div>',
							success: function () {
								var el;
								$("[name='ttitle1']").on("click",function (e) {
									e.stopPropagation();
									if(!el){
										el=eleTree.render({
											elem: '.ele2',
											url:'/workflow/secirityManager/childTree?projectId='+projectIdd,
											expandOnClickNode: false,
											highlightCurrent: true,
											showLine:true,
											showCheckbox: true,
											checked: true,
											done: function(res){

											}
										});
									}
									$(".ele2").slideDown();
								})
								$(document).on("click",function() {
									$(".ele2").slideUp();
								})
								//选中监听事件
								var arr = [];
								var arr1 = [];
								eleTree.on("nodeChecked(data2)",function(d) {
									var id = d.data.currentData.regionId;
									var label = d.data.currentData.label;
									if(d.isChecked == true || d.isChecked == "true"){
										arr.push(id);
										arr1.push(label);
									}else{
										arr.remove(id);
										arr1.remove(label);
									}
									var str = "";
									var str1 = "";
									var str2 = "";
									for(var i=0;i<arr.length;i++){
										str+=arr[i]+","
										str1+=arr1[i]+","
									}
									$("[name='ttitle1']").val(str1);
									$("#pele").attr("pid",str);
								})
								form.render();//初始化表单
							},
							yes: function (index, layero) {
								var regionName = $("#regionName").val();
								var regionParent = $("#pele").attr("pid");
								if(regionName==undefined||regionName==""){
									layer.msg("请输入区域名称");
									return false;
								}else {
									var region = {
										regionName:regionName,
										parents:regionParent,
										projectId:projectIdd
									}
									$.ajax({
										url:'/workflow/secirityManager/insertRegion',
										dataType:'json',
										type:'post',
										data:region,
										success:function(res){
											if(res.code===0||res.code==="0"){
												layer.msg(res.msg,{icon:1});
												insTb.reload()
												layer.close(index)
											}else{
												layer.msg(res.msg,{icon:0});
											}
										}
									})
								}
							}
						});
					break;
				case 'drawing':
					var checkData = insTb.checkStatus();
					if(checkData==undefined||checkData.length<1){
						layer.msg("请至少选择一条");
					}else{
						layer.open({
							type: 1,
							skin: 'layui-layer-molv', //加上边框
							area: ['40%', '60%'], //宽高
							title: '图纸管理',
							maxmin: true,
							btn: ['提交', '取消'],
							content: '<div class="layui-form">' +
									'<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
									'<label class="layui-form-label">区域名称</label>' +
									'<div class="layui-input-block">' +
									'<input class="layui-input"  lay-verify="required" name="regionName" id="regionName">' +
									'</div>' +
									'</div>' +
									'<div class="inbox" style="margin: 27px 31px 10px -2px;">' +
									'<label class="layui-form-label">图纸名称</label>' +
									'<div class="layui-input-block">' +
									'<input class="layui-input"  lay-verify="required" name="regionName" id="regionName">' +
									'</div>' +
									'</div>' +
									'</div>',
							success: function () {
								var el;
								$("[name='ttitle1']").on("click",function (e) {
									e.stopPropagation();
									if(!el){
										el=eleTree.render({
											elem: '.ele2',
											url:'/workflow/secirityManager/childTree?projectId='+projectIdd,
											expandOnClickNode: false,
											highlightCurrent: true,
											showLine:true,
											showCheckbox: true,
											checked: true,
											done: function(res){

											}
										});
									}
									$(".ele2").slideDown();
								})
								$(document).on("click",function() {
									$(".ele2").slideUp();
								})
								//选中监听事件
								var arr = [];
								var arr1 = [];
								eleTree.on("nodeChecked(data2)",function(d) {
									var id = d.data.currentData.regionId;
									var label = d.data.currentData.label;
									if(d.isChecked == true || d.isChecked == "true"){
										arr.push(id);
										arr1.push(label);
									}else{
										arr.remove(id);
										arr1.remove(label);
									}
									var str = "";
									var str1 = "";
									var str2 = "";
									for(var i=0;i<arr.length;i++){
										str+=arr[i]+","
										str1+=arr1[i]+","
									}
									$("[name='ttitle1']").val(str1);
									$("#pele").attr("pid",str);
								})
								form.render();//初始化表单
							},
							yes: function (index, layero) {
								var regionName = $("#regionName").val();
								var regionParent = $("#pele").attr("pid");
								if(regionName==undefined||regionName==""){
									layer.msg("请输入区域名称");
									return false;
								}else {
									var region = {
										regionName:regionName,
										parents:regionParent,
										projectId:projectIdd
									}
									$.ajax({
										url:'/workflow/secirityManager/insertRegion',
										dataType:'json',
										type:'post',
										data:region,
										success:function(res){
											if(res.code===0||res.code==="0"){
												layer.msg(res.msg,{icon:1});
												insTb.reload()
												layer.close(index)
											}else{
												layer.msg(res.msg,{icon:0});
											}
										}
									})
								}
							}
						});
					}
					break;
			};
		});
		//修编时勾选的子项目id(只传最高级父元素的id)
		function revisionPbagId() {
			var arrId=[]
			var pbagIdArr=[]
			$('tbody td .layui-form-checked').each(function (index,item) {
				//判断是否有子集
				if($(this).parents('tr').attr('data-indent')!=0){
					arrId.push($(this).parents('tr').prevAll('tr[data-indent="0"]').last().find('.pbagName').attr('pbagid'))
				}else{
					arrId.push($(this).parents('tr').find('.pbagName').attr('pbagid'))
				}
			})
			//数组去重
			for(var i=0;i<arrId.length;i++){
				if(pbagIdArr.indexOf(arrId[i])==-1){
					pbagIdArr.push(arrId[i])
				}
			}
			// console.log(pbagIdArr)
			var pbagId=pbagIdArr.join(',')
			return  pbagId
		}
		//修编
		function openRevision(pbagIds){
			$.post('/plcProjectBag/selectByIds',{ids:pbagIds,type:1},function (res) {
				layer.open({
					type: 1,
					title: '修编',
					area: ['80%', '70%'],
					maxmin:true,
					min: function(){
						$('.layui-layer-shade').hide()
					},
					btn:['确定','取消'],
					content: '<div>' +
							'<table id="revisionTreetable" lay-filter="revisionTreetable"></table>'+
							'</div>',
					success:function () {
						treeTable.render({
							elem: '#revisionTreetable',
							data: res.object,
							tree: {
								iconIndex: 1,           // 折叠图标显示在第几列
								idName:'ids',
								childName:"bags"
							},
							cols: [[
								{field: 'bagNumber', title: '子项目编号',width:200,},
								{field: 'pbagName', title: '子项目名称',width:300,templet: function(d){
										return '<span  class="pbagName pbagDetail" ids="'+d.ids+'" pbagId="'+d.pbagId+'" >'+ d.pbagName +'</span>'
									}},
								{field: 'planBeginDate', title: '计划开始时间',width:150,templet: function(d){
										return '<input type="text" readonly class="layui-input treeTable_date_start" value="'+format(d.planBeginDate)+'">'
									}},
								{field: 'planEndDate', title: '计划结束时间',width:150,templet: function(d){
										return '<input type="text" readonly class="layui-input treeTable_date_end" value="'+format(d.planEndDate)+'">'
									}},
								{field: 'planPeriod', title: '计划工期',width:100,templet: function(d){
										return '<span class="treeTable_planPeriod">'+d.planPeriod+'</span>'
									}},
								{field: 'buildUnit', title: '施工单位',singleLine: false,templet: function(d){
										// return  dictionaryObj['CUSTOMER_UNIT']['object'][d.buildUnit] || ''
										var selectShow='<select  lay-filter="revisionBuildUnit" name="buildUnit" defaultVal="'+d.buildUnit+'">'+dictionaryObj['CUSTOMER_UNIT']['str']+'</select>'
										return selectShow
									}},
							]],
							done:function (res) {
								$('#revisionTreetable').next().find('.ew-tree-table-box').height($(window).height()-200)
								var vars={}; //批量定义
								/************************************************开始时间**************************************************************/
								$('.treeTable_date_start').each(function(index,item) {
									var varStart='start'+index;  //动态定义变量名
									$('.treeTable_date_start').eq(index).attr('number',index)
									//判断是否是最父级
									if($(this).parents('tr').attr('data-indent')!=0){
										vars[varStart]=laydate.render({
											elem:this
											,trigger : 'click'
											,btns: ['now', 'confirm']
											,min: $(this).parents('tr').prev().find('.treeTable_date_start').val()
											,max: $(this).parents('tr').find('.treeTable_date_end').val()
											,done: function (value, date) {
												var $tr = $(item).parents('tr')
												var planPeriod = timeRange(value, $tr.find('.treeTable_date_end').val()) + '天';
												$tr.find('.treeTable_planPeriod').text(planPeriod);
												var number=$('.treeTable_date_start').eq(index).attr('number')
												if (vars['end'+number].config.min) {
													vars['end'+number].config.min = {
														year: date.year || 1900,
														month: date.month - 1 || 0,
														date: date.date || 1,
													}
												} else {
													vars['end'+number].min = value;
												}
												if($tr.next().length>0 &&$tr.next().attr('data-indent') !=0){
													//配置下一级时间范围
													if (vars['start'+parseInt(parseInt(number)+1)].config.min) {
														vars['start'+parseInt(parseInt(number)+1)].config.min = {
															year: date.year || 1900,
															month: date.month - 1 || 0,
															date: date.date || 1,
														}
													} else {
														vars['start'+parseInt(parseInt(number)+1)].min = value;
													}
												}
											}
										});
									}else{
										vars[varStart]=laydate.render({
											elem:this
											,trigger : 'click'
											,btns: ['now', 'confirm']
											,max: $(this).parents('tr').find('.treeTable_date_end').val()
											,done: function (value, date) {
												var $tr = $(item).parents('tr')
												var planPeriod = timeRange(value, $tr.find('.treeTable_date_end').val()) + '天';
												$tr.find('.treeTable_planPeriod').text(planPeriod);
												var number=$('.treeTable_date_start').eq(index).attr('number')
												if (vars['end'+number].config.min) {
													vars['end'+number].config.min = {
														year: date.year || 1900,
														month: date.month - 1 || 0,
														date: date.date || 1,
													}
												} else {
													vars['end'+number].min = value;
												}
												if($tr.next().length>0 && $tr.next().attr('data-indent') !=0){
													//配置下一级时间范围
													if (vars['start'+parseInt(parseInt(number)+1)].config.min) {
														vars['start'+parseInt(parseInt(number)+1)].config.min = {
															year: date.year || 1900,
															month: date.month - 1 || 0,
															date: date.date || 1,
														}
													} else {
														vars['start'+parseInt(parseInt(number)+1)].min = value;
													}
												}
											}
										});
									}
								});
								/************************************************结束时间**************************************************************/
								$('.treeTable_date_end').each(function(index,item) {
									var varEnd='end'+index;  //动态定义变量名
									$('.treeTable_date_end').eq(index).attr('number',index)
									//判断是否是最父级
									if($(this).parents('tr').attr('data-indent')!=0){
										vars[varEnd]=laydate.render({
											elem:this
											,trigger:'click'
											,btns: ['now', 'confirm']
											,min: $(this).parents('tr').find('.treeTable_date_start').val()
											,max: $(this).parents('tr').prev().find('.treeTable_date_end').val()
											,done: function (value, date) {
												var $tr = $(item).parents('tr')
												var planPeriod = timeRange($tr.find('.treeTable_date_start').val(), value) + '天';
												$tr.find('.treeTable_planPeriod').text(planPeriod);
												var number=$('.treeTable_date_end').eq(index).attr('number')
												if (vars['start'+number].config.max) {
													vars['start'+number].config.max = {
														year: date.year || 1900,
														month: date.month - 1 || 0,
														date: date.date || 1,
													}
												} else {
													vars['start'+number].max = value;
												}
												if($tr.next().length>0 && $tr.next().attr('data-indent') !=0){
													//配置下一级时间范围
													if (vars['end'+parseInt(parseInt(number)+1)].config.max) {
														vars['end'+parseInt(parseInt(number)+1)].config.max = {
															year: date.year || 1900,
															month: date.month - 1 || 0,
															date: date.date || 1,
														}
													} else {
														vars['end'+parseInt(parseInt(number)+1)].max = value;
													}
												}
											}
										});
									}else{
										vars[varEnd]=laydate.render({
											elem:this
											,trigger:'click'
											,btns: ['now', 'confirm']
											,min: $(this).parents('tr').find('.treeTable_date_start').val()
											,done: function (value, date) {
												var $tr = $(item).parents('tr')
												var planPeriod = timeRange($tr.find('.treeTable_date_start').val(), value) + '天';
												$tr.find('.treeTable_planPeriod').text(planPeriod);
												var number=$('.treeTable_date_end').eq(index).attr('number')
												if (vars['start'+number].config.max) {
													vars['start'+number].config.max = {
														year: date.year || 1900,
														month: date.month - 1 || 0,
														date: date.date || 1,
													}
												} else {
													vars['start'+number].max = value;
												}
												if($tr.next().length>0 && $tr.next().attr('data-indent') !=0){
													//配置下一级时间范围
													if (vars['end'+parseInt(parseInt(number)+1)].config.max) {
														vars['end'+parseInt(parseInt(number)+1)].config.max = {
															year: date.year || 1900,
															month: date.month - 1 || 0,
															date: date.date || 1,
														}
													} else {
														vars['end'+parseInt(parseInt(number)+1)].max = value;
													}
												}
											}
										});
									}
								});
								// console.log(vars)
								//在每次动态生成laydate组件时, laydate框架会给input输入框增加一个lay-key="1",
								//这样就导致了多个laydate 的inpute框都有lay-key="1"这个属性。导致时间控件不起作用，
								//需要把动态生成的lay-key属性删除
								// $(".treeTable_date_start").removeAttr("lay-key");
								$('#revisionTreetable').next().find('[name="buildUnit"]').each(function () {
									$(this).val($(this).attr('defaultVal'))
									form.render()
								})
							}
						});
					},
					yes:function (index) {
						var arr=[]
						$('#revisionTreetable').next().find('.ew-tree-table-box tr').each(function () {
							if($(this).find('.treeTable_date_start').val() && $(this).find('.treeTable_date_end').val() && $(this).find('select[name="buildUnit"]').val()){
								var obj={}
								obj.planBeginDate=$(this).find('.treeTable_date_start').val()
								obj.planEndDate=$(this).find('.treeTable_date_end').val()
								obj.planPeriod=$(this).find('.treeTable_planPeriod').text()
								obj.buildUnit=$(this).find('select[name="buildUnit"]').val()
								obj.pbagId=$(this).find('.pbagName').attr('pbagid')
								arr.push(obj)
							}
						})
						// console.log(arr)
						$.ajax({
							url:'/plcProjectBag/revision',
							data:JSON.stringify(arr),
							contentType:"application/json;charset=UTF-8",
							dataType:'json',
							type:'post',
							success:function(res){
								if(res.flag){
									layer.msg('修编成功！', {icon: 1});
									layer.close(index)
									insTb.reload()
								}
							}
						})
					}
				})
			})
		}
		//修编详情
		function  openRevisionDetail(){
			var pbagId=''
			$('tbody td .layui-form-checked').each(function (index,item) {
				pbagId+=$(this).parents('tr').find('.pbagName').attr('pbagid')+','
			})
			$.post('/EditRecord/selectByPbagId',{pbagId:pbagId},function (res) {
				layer.open({
					type: 1,
					title: '修编详情',
					area: ['80%', '70%'],
					content: '<div id="revision_view"></div>',
					success:function () {
						var data=res.obj
						if(res.flag && data.length>0){
							data.forEach(function (item,index) {
								if(item.length>0){
									var tableTitle='<table class="layui-table"><thead><tr>'+'<th nowrap="nowrap">子项目名称</th>'
									var str='<tbody><tr>'+'<td>'+function () {
										if(item.length>0){
											return  item[0].pbagName
										}else{
											return ''
										}
									}()+'</td>'
									var editArr=[]
									//对数据进行分割处理
									item.forEach(function (v,i) {
										if(i==0){
											var bEditContent=v.bEditContent.split('&')
											var aEditContent=v.aEditContent.split('&')
											editArr=editArr.concat(bEditContent).concat(aEditContent)
										}else{
											var aEditContent=v.aEditContent.split('&')
											editArr=editArr.concat(aEditContent)
										}
									})
									//对表头显示处理
									for(var i=0;i<item.length+1;i++){
										if(i==item.length){
											tableTitle+='<th nowrap="nowrap">计划开始时间</th>\n' +
													'      <th nowrap="nowrap">计划结束时间</th>\n' +
													'      <th nowrap="nowrap">计划工期</th>'+
													'      <th nowrap="nowrap">施工单位</th></thead>'
										}else{
											tableTitle+='<th nowrap="nowrap">计划开始时间</th>\n' +
													'      <th nowrap="nowrap">计划结束时间</th>\n' +
													'      <th nowrap="nowrap">计划工期</th>'+
													'      <th nowrap="nowrap">施工单位</th>'
										}
									}
									editArr.forEach(function (v,i) {
										if(i==editArr.length-1){
											str+='<td nowrap="nowrap">'+v+'</td></tr></tbody></table>'
										}else{
											str+='<td nowrap="nowrap">'+v+'</td>'
										}
									})
									/*  console.log(tableTitle)
                                      console.log(str)*/
									$('#revision_view').append(tableTitle+str)
								}else{
									$('#revision_view').append('<p style="text-align: center">暂无修编详情</p>')
								}
							})
						}
					},
				})
			})
		}
		//判断是否全选
		treeTable.on('checkbox(demoTreeTb)', function(obj){
			/* console.log(obj.checked);  // 当前是否选中状态
             console.log(obj.data);  // 选中行的相关数据
             console.log(obj.type);  // 如果触发的是全选，则为：all，如果触发的是单选，则为：more*/
			if(obj.type=='more'){
				var checkbox=$('tbody td .layui-form-checkbox')
				for(var i=0;i<checkbox.length;i++){
					if(!checkbox.eq(i).hasClass('layui-form-checked')){
						$('thead th .layui-form-checkbox').removeClass('layui-form-checked')
						return false
					}else{
						$('thead th .layui-form-checkbox').addClass('layui-form-checked')
					}
				}
			}
		});
		// // 监听行双击事件
		// treeTable.on('rowDouble(demoTreeTb)', function(obj){
		// 	var isCsh=isinitializtion()
		// 	if(!isCsh){
		// 		layer.msg('请先初始化项目！',{icon:0});
		// 		return false
		// 	}
		// 	// creat(1,'','','',obj.data.pbagId,obj.data)
		// });
		//添加平级、添加下一级
		/*function creat(type,isLevel,projectId,parentId,pbagId,data,pbagLevel) {
			// console.log(parentId)
			var title
			var url
			if(type=='0'){
				//判断是增加平级还是增加下一级
				if(isLevel){
					title='子项目-添加平级'
				}else{
					title='子项目-添加下一级'
				}
				url='/plcProjectBag/add'
			}else if(type=='1'){
				title='编辑子项目'
				url='/plcProjectBag/update'
			}else{
				title='查看子项目'
			}
			layer.open({
				type: 1,
				title: title,
				area: ['100%', '100%'],
				maxmin:true,
				min: function(){
					$('.layui-layer-shade').hide()
				},
				btn:['保存','取消'],
				content: '<form class="layui-form" id="form" lay-filter="formTest">' +
						//第一行
						'<div class="layui-row">'+
						'<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
						'    <label class="layui-form-label">编号<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						'      <input type="text" name="bagNumber" readonly style="background:#e7e7e7;width:90%;display:inline-block" autocomplete="off" class="layui-input jinyong testNull" title="编号">\n' +
						'<button type="button" class="layui-btn layui-btn-sm refresh">刷新</button>'+
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						'<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">上级子项目<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						'      <input type="text" name="topSubName" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong testNull" title="上级子项目">\n' +
						'    </div>\n' +
						'  </div></div>'+
						'</div>'+
						//第二行
						'<div class="layui-row">'+
						'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
						'    <label class="layui-form-label">子项目名称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						'      <input type="text" name="pbagName"  autocomplete="off" class="layui-input jinyong testNull" title="子项目名称">\n' +
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						'<div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
						'    <label class="layui-form-label">子项目类型<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						' <select name="pbagType" lay-verify="required" class="jinyong testNull" title="子项目类型">\n' +
						'      </select>'+
						'    </div>\n' +
						'  </div></div>'+
						'</div>'+
						//第三行
						'<div class="layui-row">'+
						'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">子项目性质<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block pbagNature">\n' +
						' <select name="pbagNature" lay-verify="required" class="jinyong testNull" title="子项目性质">\n' +
						'      </select>'+
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">子项目分类<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						/!*' <select name="pbagClass" lay-verify="required" class="jinyong testNull" title="子项目分类">\n' +
                        '      </select>'+*!/
						'<input type="text" name="pbagClass" readonly title="子项目分类" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
						'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="pbagClassAdd">添加</a>\n' +
						' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" type="pbagClass" class="customerUnitDel">清空</a>\n' +
						'    </div>\n' +
						'  </div> </div>'+
						'</div>'+
						//第四行
						'<div class="layui-row">'+
						'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">施工单位<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						/!* ' <select name="buildUnit" lay-verify="required" class="jinyong testNull" title="施工单位">\n' +
                         '      </select>'+*!/
						'<input type="text" name="buildUnit" readonly title="施工单位" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
						'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" type="buildUnit" title="施工单位" class="customerUnitAdd">添加</a>\n' +
						' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" type="buildUnit" class="customerUnitDel">清空</a>\n' +
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">施工单位负责人及电话<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block ">\n' +
						'      <input type="text" name="buildUnitUser"  autocomplete="off" class="layui-input jinyong testNull" title="施工单位负责人及电话">\n' +
						'    </div>\n' +
						'  </div> </div>'+
						'</div>'+
						//第五行
						'<div class="layui-row">'+
						' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">设计单位<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						/!*' <select name="designUnit" lay-verify="required" class="jinyong testNull" title="设计单位">\n' +
                        '      </select>'+*!/
						'<input type="text" name="designUnit" readonly title="设计单位" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
						'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" type="designUnit" isMore="true" title="设计单位" class="customerUnitAdd">添加</a>\n' +
						' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" type="designUnit" class="customerUnitDel">清空</a>\n' +
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">设计单位负责人及电话<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						'      <input type="text" name="designUnitUser"  autocomplete="off" class="layui-input jinyong testNull" title="设计单位负责人及电话">\n' +
						'    </div>\n' +
						'  </div> </div>'+
						'</div>'+
						//第六行
						'<div class="layui-row">'+
						' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
						'    <label class="layui-form-label">采购单位<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						'<input type="text" name="purchaseUnitUser" readonly title="采购单位" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
						'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" type="purchaseUnitUser" title="采购单位" class="customerUnitAdd">添加</a>\n' +
						' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" type="purchaseUnitUser" class="customerUnitDel">清空</a>\n' +
						'    </div>\n' +
						'  </div> </div>'+
						'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">主要负责人<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						'  <textarea  type="text" name="dutyUser" id="dutyUser" readonly  style="background:#e7e7e7;height: 45px;width: 370px;text-indent:1em;border-radius: 4px;" class="testNull" title="主要负责人"></textarea>\n' +
						'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
						' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n'+
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						'</div>'+
						//第七行
						'<div class="layui-row">'+
						' <div class="newAndEdit layui-col-xs4"><div class="layui-form-item">\n' +
						'    <label class="layui-form-label">计划开始时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						'      <input type="text" class="layui-input jinyong testNull" autocomplete="off" name="planBeginDate" id="planBeginDate" title="计划开始时间">' +
						'    </div>\n' +
						'  </div> </div>'+
						' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">计划结束时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block ">\n' +
						'      <input type="text" class="layui-input jinyong testNull" autocomplete="off" name="planEndDate" id="planEndDate" title="计划结束时间">' +
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">计划工期<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
						'    <div class="layui-input-block">\n' +
						'      <input type="text" name="planPeriod" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong testNull" title="计划工期">\n' +
						'    </div>\n' +
						'  </div> </div>'+
						'</div>'+
						//第八行
						'<div class="layui-row">'+
						' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">是否要预算控制</label>\n' +
						'    <div class="layui-input-block budgetYn">\n' +
						'<input type="checkbox" name="budgetYn" title="是否要预算控制" lay-skin="primary" value="0" class="jinyong">'+
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						// ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
						// '    <label class="layui-form-label">是否开放下级子项目</label>\n' +
						// '    <div class="layui-input-block">\n' +
						// '<input type="checkbox" name="isNewChild" title="是否开放下级子项目" lay-skin="primary" value="0" class="jinyong">'+
						// '    </div>\n' +
						// '  </div> </div>'+
						'</div>'+
						//第九行
						'<div class="layui-row">'+
						' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">是否可新建关键任务</label>\n' +
						'    <div class="layui-input-block contractDept">\n' +
						'<input type="checkbox" name="isNewTarget" title="是否可新建关键任务" lay-skin="primary" value="0" class="jinyong">'+
						'    </div>\n' +
						'  </div>'+
						'  </div>'+
						' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
						'    <label class="layui-form-label">是否可新建子任务</label>\n' +
						'    <div class="layui-input-block">\n' +
						'<input type="checkbox" name="isNewItem" title="是否可新建子任务" lay-skin="primary" value="0" class="jinyong">'+
						'    </div>\n' +
						'  </div> </div>'+
						'</div>'+
						//第十行
						'<div><div class="layui-form-item">' +
						'    <label class="layui-form-label">施工内容</label>\n' +
						'    <div class="layui-input-block">\n' +
						'<textarea name="pbagContent"  class="layui-textarea jinyong"></textarea>'+
						'    </div>\n' +
						'</div>'+
						'</div>'+
						'</form>',
				success:function () {
					// 施工单位
					$('.customerUnitAdd').click(function () {
						var name=$(this).attr('type')
						var isMore=$(this).attr('isMore')
						layer.open({
							type: 1,
							title: '添加'+$(this).attr('title'),
							area: ['40%', '70%'],
							btn: ['确定', '取消'],
							content:'<div style="margin-top: 10px;"><input style="margin-left: 10%;width: 80%" type="text" name="buildUnitSearch" placeholder="请输入'+$(this).attr('title')+'" autocomplete="off" class="layui-input"><div  class="layui-form result"  style="margin-top: 15px"></div></div>',
							success:function () {
								var data=CUSTOMER_UNIT
								var str=''
								if(isMore){
									for(var i=0;i<data.length;i++){
										str+='<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+data[i].dictName+'" title="'+data[i].dictName+'" value="'+data[i].dictNo+'" lay-skin="primary"> </div>'
									}
								}else{
									for(var i=0;i<data.length;i++){
										str+='<div class="layui-input-block" style="margin-left: 10%"><input type="radio" name="buildUnitRadio" title="'+data[i].dictName+'" value="'+data[i].dictNo+'" > </div>'
									}
								}
								$('.result').html(str)
								form.render()
								var buildUnit=$('#form input[name="'+name+'"]').attr(name)
								if(buildUnit){
									if(isMore){
										var buildUnitArr=buildUnit.replace(/,$/, '').split(',')
										$('.result input').each(function (index) {
											buildUnitArr.forEach(function (v,i) {
												if($('.result input').eq(index).val()==v){
													$('.result input').eq(index).prop('checked','true')
													form.render()
												}
											})
										})
									}else{
										$('.result input').each(function (index) {
											if($('.result input').eq(index).val()==buildUnit){
												$('.result input').eq(index).prop('checked','true')
												form.render()
											}
										})
									}
								}
								/!*监听输入框进行模糊查询*!/
								$(document).on('input propertychange', '[name="buildUnitSearch"]', function (event) {
									var val=$(this).val()
									if(isMore){
										var $query=$('.result .layui-input-block span')
									}else{
										var $query=$('.result .layui-input-block .layui-form-radio div')
									}
									$query.each(function(i,v){
										// console.log($(v).text())
										if($(v).text().indexOf(val)>-1){
											$(v).parents('.layui-input-block').show();
										}else{
											$(v).parents('.layui-input-block').hide();
										}
									})
								});
							},
							yes:function (index) {
								var buildUnit=''
								var buildUnitName=''
								$('.result input').each(function () {
									if($(this).prop('checked')){
										if(isMore){
											buildUnit+=$(this).val()+','
											buildUnitName+=$(this).attr('title')+','
										}else{
											buildUnit+=$(this).val()
											buildUnitName+=$(this).attr('title')
										}
									}
								})
								$('#form input[name="'+name+'"]').val(buildUnitName)
								$('#form input[name="'+name+'"]').attr(name,buildUnit)
								layer.close(index);
							}
						})
					})
					$('.customerUnitDel').click(function () {
						var name=$(this).attr('type')
						$('#form input[name="'+name+'"]').val('')
						$('#form input[name="'+name+'"]').attr(name,'')
					})
					// 子项目分类
					$('.pbagClassAdd').click(function () {
						layer.open({
							type: 1,
							title: '添加子项目分类',
							area: ['40%', '70%'],
							btn: ['确定', '取消'],
							content:'<div  class="layui-form result"  style="margin-top: 15px"></div>',
							success:function () {
								var data=PBAG_CLASS
								var str=''
								for(var i=0;i<data.length;i++){
									str+='<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+data[i].dictName+'" title="'+data[i].dictName+'" value="'+data[i].dictNo+'" lay-skin="primary"> </div>'
								}
								$('.result').html(str)
								form.render()
								var pbagClass=$('#form input[name="pbagClass"]').attr('pbagClass')
								if(pbagClass){
									var pbagClassArr=pbagClass.replace(/,$/, '').split(',')
								}
								if(pbagClassArr){
									$('.result input').each(function (index) {
										pbagClassArr.forEach(function (v,i) {
											if($('.result input').eq(index).val()==v){
												$('.result input').eq(index).prop('checked','true')
												form.render()
											}
										})
									})
								}
							},
							yes:function (index) {
								var pbagClass=''
								var pbagClassName=''
								$('.result input').each(function () {
									if($(this).prop('checked')){
										pbagClass+=$(this).val()+','
										pbagClassName+=$(this).attr('title')+','
									}
								})
								$('#form input[name="pbagClass"]').val(pbagClassName)
								$('#form input[name="pbagClass"]').attr('pbagClass',pbagClass)
								layer.close(index);
							}
						})
					})
					//编号
					if(type==0){
						var level
						//判断如果是添加一级子项目
						if(parentId==0){
							level=2
						}else{
							if(isLevel){
								level=parseInt(pbagLevel)
							}else{
								level=parseInt(pbagLevel)+1
							}
						}
						$.get('/ProjectInfo/getMaxNo',{model:'plcProjectBag',projectInfoNo:$('#leftId').attr('projectInfoNo'),level:level},function (res) {
							$('form input[name="bagNumber"]').val(res)
						})
						//默认采购单位为【中电建生态环境集团有限公司】
						for (var name in dictionaryObj['CUSTOMER_UNIT']['object']){
							if(dictionaryObj['CUSTOMER_UNIT']['object'][name]=='中电建生态环境集团有限公司'){
								$('form input[name="purchaseUnitUser"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][name])
								$('form input[name="purchaseUnitUser"]').attr('purchaseUnitUser',name)
							}
						}
					}
					//点击刷新按钮
					$('.refresh').click(function () {
						$.get('/ProjectInfo/getMaxNo',{model:'plcProjectBag',projectInfoNo:$('#leftId').attr('projectInfoNo'),level:level},function (res) {
							$('form input[name="bagNumber"]').val(res)
						})
					})
					//获取上级子项目名称
					if(data){
						var parentIdName=data.parentPbagId || 0
					}else{
						var parentIdName=parentId
					}
					var time_data=''
					$.ajax({
						url:'/plcProjectBag/bagNameByParentId',
						dataType:'json',
						type:'get',
						async:false,
						data:{parentId:parentIdName},
						success:function(res){
							//判断是否已经是一级子项目
							if(res.object.pbagName){
								time_data=res.object
								$('input[name="topSubName"]').val(res.object.pbagName)
							}else{
								$('input[name="topSubName"]').val(res.object)
							}
						}
					})
					$('form select[name="pbagType"]').html(dictionaryObj['PBAG_TYPE']['str'])
					$('form select[name="pbagNature"]').html(dictionaryObj['PBAG_NATURE']['str'])
					// $('form select[name="pbagClass"]').html(dictionaryObj['PBAG_CLASS']['str'])
					$('form select[name="buildUnit"]').html(dictionaryObj['CUSTOMER_UNIT']['str'])
					$('form select[name="designUnit"]').html(dictionaryObj['CUSTOMER_UNIT']['str'])
					form.render()
					//编辑回显
					if(type==1){
						$('.refresh').hide()
						$('input[name="bagNumber"]').css('width','100%')
						// console.log(data)
						form.val("formTest",data);
						$('#planBeginDate').val(format(data.planBeginDate))
						$('#planEndDate').val(format(data.planEndDate))
						//主要负责人
						$('#dutyUser').val(data.dutyUserName)
						$('#dutyUser').attr('user_id',data.dutyUser)
						data.budgetYn==1 ? $('[name="budgetYn"]').prop('checked',true) : $('[name="budgetYn"]').prop('checked',false)
						data.isNewChild==1 ? $('[name="isNewChild"]').prop('checked',true) : $('[name="isNewChild"]').prop('checked',false)
						data.isNewTarget==1 ? $('[name="isNewTarget"]').prop('checked',true) : $('[name="isNewTarget"]').prop('checked',false)
						data.isNewItem==1 ? $('[name="isNewItem"]').prop('checked',true) : $('[name="isNewItem"]').prop('checked',false)
						form.render()
						//子项目分类
						if(data.pbagClassList){
							var pbagClassList=data.pbagClassList
							var pbagClass=''
							var pbagClassName=''
							pbagClassList.forEach(function (item) {
								pbagClass+=item.dictNo+','
								pbagClassName+=item.dictName+','
							})
							$('form input[name="pbagClass"]').val(pbagClassName)
							$('form input[name="pbagClass"]').attr('pbagClass',pbagClass)
						}
						//施工单位
						if(data.buildUnit){
							$('form input[name="buildUnit"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][data.buildUnit])
							$('form input[name="buildUnit"]').attr('buildUnit',data.buildUnit)
						}
						//设计单位
						if(data.designUnitList){
							var designUnitList=data.designUnitList
							var designUnit=''
							var designUnitName=''
							designUnitList.forEach(function (item) {
								designUnit+=item.dictNo+','
								designUnitName+=item.dictName+','
							})
							$('form input[name="designUnit"]').val(designUnitName)
							$('form input[name="designUnit"]').attr('designUnit',designUnit)
						}
						//采购单位
						if(data.purchaseUnitUser){
							$('form input[name="purchaseUnitUser"]').val(dictionaryObj['CUSTOMER_UNIT']['object'][data.purchaseUnitUser])
							$('form input[name="purchaseUnitUser"]').attr('purchaseUnitUser',data.purchaseUnitUser)
						}
					}
					if(time_data){
						var min=format(time_data.planBeginDate)
						var max=format(time_data.planEndDate)
						// 初始化计划开始时间
						var planStartLaydateConfig = {
							elem: '#planBeginDate',
							min: min,
							max: max,
							done: function (value, date) {
								if ($('#planEndDate').val()) {
									var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
									$('input[name="planPeriod"]').val(planPeriod);
								}
								if (planEndLaydate.config.min) {
									// 修改开始时间最大选择日期
									planEndLaydate.config.min = {
										year: date.year || 1900,
										month: date.month - 1 || 0,
										date: date.date || 1,
									}
								} else {
									planEndLaydateConfig.min = value;
								}
							}
							,trigger: 'click' //采用click弹出
						}
						if (data && data.planEndDate) {
							planStartLaydateConfig.max = data.planEndDate;
						}
						var planStartLaydate = laydate.render(planStartLaydateConfig);

						// 初始化计划结束时间
						var planEndLaydateConfig = {
							elem: '#planEndDate',
							min: min,
							max: max,
							done: function (value, date) {
								if ($('#planBeginDate').val()) {
									var planPeriod = !!value ? timeRange($('#planBeginDate').val(), value) + '天' : '';
									$('input[name="planPeriod"]').val(planPeriod);
								}
								if (planStartLaydate.config.max) {
									// 修改开始时间最大选择日期
									planStartLaydate.config.max = {
										year: date.year || 2099,
										month: date.month - 1 || 11,
										date: date.date || 31,
									}
								} else {
									planStartLaydateConfig.max = value;
								}
							}
							,trigger: 'click' //采用click弹出
						}
						if (data && data.planBeginDate) {
							planEndLaydateConfig.min = data.planBeginDate;
						}
						var planEndLaydate = laydate.render(planEndLaydateConfig);
					}else{
						var min=$('#plan_time').attr('minTime')
						var max=$('#plan_time').attr('maxTime')
						// 初始化计划开始时间
						var planStartLaydateConfig = {
							elem: '#planBeginDate',
							min:min,
							max:max,
							done: function (value, date) {
								if ($('#planEndDate').val()) {
									var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
									$('input[name="planPeriod"]').val(planPeriod);
								}
								if (planEndLaydate.config.min) {
									// 修改开始时间最大选择日期
									planEndLaydate.config.min = {
										year: date.year || 1900,
										month: date.month - 1 || 0,
										date: date.date || 1,
									}
								} else {
									planEndLaydateConfig.min = value;
								}
							}
							,trigger: 'click' //采用click弹出
						}
						if (data && data.planEndDate) {
							planStartLaydateConfig.max = data.planEndDate;
						}
						var planStartLaydate = laydate.render(planStartLaydateConfig);

						// 初始化计划结束时间
						var planEndLaydateConfig = {
							elem: '#planEndDate',
							min:min,
							max:max,
							done: function (value, date) {
								if ($('#planBeginDate').val()) {
									var planPeriod = !!value ? timeRange($('#planBeginDate').val(), value) + '天' : '';
									$('input[name="planPeriod"]').val(planPeriod);
								}
								if (planStartLaydate.config.max) {
									// 修改开始时间最大选择日期
									planStartLaydate.config.max = {
										year: date.year || 2099,
										month: date.month - 1 || 11,
										date: date.date || 31,
									}
								} else {
									planStartLaydateConfig.max = value;
								}
							}
							,trigger: 'click' //采用click弹出
						}
						if (data && data.planBeginDate) {
							planEndLaydateConfig.min = data.planBeginDate;
						}
						var planEndLaydate = laydate.render(planEndLaydateConfig);
					}
					/!*laydate.render({
                        elem: '#planBeginDate', //指定元素
                        value: data && data.planBeginDate ? format(data.planBeginDate) : ''
                        ,trigger: 'click' //采用click弹出
                    });
                    laydate.render({
                        elem: '#planEndDate', //指定元素
                        value: data && data.planEndDate ? new Date(data.planEndDate) : '',
                        done: function(value, date, endDate){
                            console.log(value); //得到日期生成的值，如：2017-08-18
                            if($('#planBeginDate').val() && value){
                                var planPeriod=timeRange($('#planBeginDate').val(),value)+'天'
                                $('input[name="planPeriod"]').val(planPeriod)
                            }
                            if(!value){
                                $('input[name="planPeriod"]').val('')
                            }
                    }
                        ,trigger: 'click' //采用click弹出
                    });*!/
				},
				yes:function (index) {
					//必填项提示
					for(var i=0;i<$('.testNull').length;i++){
						if($('.testNull').eq(i).val()==''){
							layer.msg($('.testNull').eq(i).attr('title')+'为必填项！', {icon: 0});
							return false
						}
					}
					var datas=$('#form').serializeArray()
					// console.log(datas)
					var obj={}
					datas.forEach(function (item,index) {
						obj[item.name]=item.value
					})
					obj.dutyUser=$('#dutyUser').attr('user_id')
					obj.budgetYn=$('[name="budgetYn"]').prop('checked') ? 1 :0
					obj.isNewChild=$('[name="isNewChild"]').prop('checked') ? 1 :0
					obj.isNewTarget=$('[name="isNewTarget"]').prop('checked') ? 1 :0
					obj.isNewItem=$('[name="isNewItem"]').prop('checked') ? 1 :0

					// console.log(obj)
					//添加平级
					//新增
					if(type==0){
						//判断是增加平级还是增加下一级
						if(isLevel){
							obj.type=2
							obj.pbagLevel=pbagLevel
						}else{
							obj.type=3
							obj.pbagLevel=parseInt(pbagLevel)+1
						}
					}
					obj.projectId=projectId
					obj.parentPbagId=parentId
					obj.pbagId=pbagId
					obj.buildUnit=$('form [name="buildUnit"]').attr('buildUnit')
					obj.designUnit=$('form [name="designUnit"]').attr('designUnit')
					obj.purchaseUnitUser=$('form [name="purchaseUnitUser"]').attr('purchaseUnitUser')
					obj.pbagClass=$('form [name="pbagClass"]').attr('pbagClass')
					// console.log(obj)
					$.ajax({
						url:url,
						data:obj,
						dataType:'json',
						type:'post',
						success:function(res){
							if(type==0){
								if(res.flag && res.object==1){
									layer.msg('编号重复，请点击刷新按钮重置编号！',{icon:0});
								}else if(res.flag){
									layer.msg('新增成功！',{icon:1});
									layer.close(index)
									insTb.reload()
								}
							}else if(type==1){
								if(res.flag){
									layer.msg('修改成功！',{icon:1});
									layer.close(index)
									insTb.reload()
								}
							}

						}
					})
				}
			})
		}*/
		//子项目详情页面
		$(document).on('click','.pbagDetail',function () {
			$.get('/plcProjectBag/selectPbagById',{pbagId:$(this).attr('pbagId')},function (res) {
				var data=res.data
				layer.open({
					type: 1,
					title: '子项目详情',
					area: ['70%', '80%'],
					maxmin: true,
					min: function () {
						$('.layui-layer-shade').hide()
					},
					content: '<div style="margin: 10px"><table class="layui-table child" >\n' +
							'  <tbody>\n' +
							'    <tr>\n' +
							'      <td width="100">编号</td>\n' +
							'      <td>'+isShowNull(data.bagNumber)+'</td>\n' +
							'      <td width="100">上级子项目</td>\n' +
							'      <td id="shangjiName">'+isShowNull(data.parentPbagId)+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>子项目名称</td>\n' +
							'      <td>'+isShowNull(data.pbagName)+'</td>\n' +
							'      <td>子项目类型</td>\n' +
							'      <td>'+isShowNull(dictionaryObj['PBAG_TYPE']['object'][data.pbagType])+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>子项目性质</td>\n' +
							'      <td>'+isShowNull(dictionaryObj['PBAG_NATURE']['object'][data.pbagNature])+'</td>\n' +
							'      <td>子项目分类</td>\n' +
							'      <td>'+function () {
								if(data.pbagClassList){
									var pbagClassList=data.pbagClassList
									var pbagClassName=''
									pbagClassList.forEach(function (item) {
										pbagClassName+=item.dictName+','
									})
									return pbagClassName
								}else{
									return  ''
								}
							}()+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>施工单位</td>\n' +
							'      <td>'+isShowNull(dictionaryObj['CUSTOMER_UNIT']['object'][data.buildUnit])+'</td>\n' +
							'      <td>施工单位负责人及电话</td>\n' +
							'      <td>'+isShowNull(data.buildUnitUser)+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>设计单位</td>\n' +
							'      <td>'+function () {
								if(data.designUnitList){
									var designUnitList=data.designUnitList
									var designUnitName=''
									designUnitList.forEach(function (item) {
										designUnitName+=item.dictName+','
									})
									return designUnitName
								}else{
									return  ''
								}
							}()+'</td>\n' +
							'      <td>设计单位负责人及电话</td>\n' +
							'      <td>'+isShowNull(data.designUnitUser)+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>采购单位</td>\n' +
							'      <td>'+isShowNull(dictionaryObj['CUSTOMER_UNIT']['object'][data.purchaseUnitUser])+'</td>\n' +
							'      <td>计划开始时间</td>\n' +
							'      <td>'+function () {
								if(data.planBeginDate){
									return format(data.planBeginDate)
								}else{
									return  ''
								}
							}()+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>计划结束时间</td>\n' +
							'      <td>'+function () {
								if(data.planEndDate){
									return format(data.planEndDate)
								}else{
									return  ''
								}
							}()+'</td>\n' +
							'      <td>计划工期</td>\n' +
							'      <td>'+isShowNull(data.planPeriod)+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>是否要预算控制</td>\n' +
							'      <td>'+isUndefined(data.budgetYn)+'</td>\n' +
							'      <td>是否开放下级子项目</td>\n' +
							'      <td>'+isUndefined(data.isNewChild)+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>是否可新建关键任务</td>\n' +
							'      <td>'+isUndefined(data.isNewTarget)+'</td>\n' +
							'      <td>是否可新建子任务</td>\n' +
							'      <td>'+isUndefined(data.isNewItem)+'</td>\n' +
							'    </tr>\n' +
							'    <tr>\n' +
							'      <td>主要负责人</td>\n' +
							'      <td>'+isShowNull(data.dutyUserName.replace(/,$/, '').split(','))+'</td>\n' +
							'      <td>施工内容</td>\n' +
							'      <td>'+isShowNull(data.pbagContent)+'</td>\n' +
							'    </tr>\n' +
							'  </tbody>\n' +
							'</table></div>',
					success:function () {
						//获取上级子项目名称
						var parentIdName=data.parentPbagId || 0
						$.get('/plcProjectBag/bagNameByParentId',{parentId:parentIdName},function (res) {
							//判断是否已经是一级子项目
							if(res.object.pbagName){
								$('#shangjiName').text(res.object.pbagName)
							}else{
								$('#shangjiName').text(res.object)
							}
						})
					}
				})
			})
		})
		//判断是否初始化
		function isinitializtion() {
			var isOpen=''
			$.ajax({
				url:'/plcProjectBag/isStart',
				data:{projectId:$('#leftId').attr('projectId')},
				dataType:'json',
				type:'get',
				async:false,
				success:function(res){
					if(res.flag){
						isOpen=res.data
					}
				}
			})
			return isOpen
		}
		//判断分解次数是否为1
		function isOne() {
			var isOpen=''
			$.ajax({
				url:'/plcProjectBag/breakTimes',
				data:{projectId:$('#leftId').attr('projectId')},
				dataType:'json',
				type:'get',
				async:false,
				success:function(res){
					isOpen=res.data
				}
			})
			return isOpen
		}
		//判断是否可以进行下一步或者完成操作
		function isNextOrOver(projectId,pbagId){
			var isOpen=''
			$.ajax({
				url:'/plcProjectBag/checkNull',
				data:{projectId:projectId,pbagId:pbagId},
				dataType:'json',
				type:'get',
				async:false,
				success:function(res){
					if(res.totleNum!=0){
						isOpen=true
					}
				}
			})
			return isOpen
		}
		//查询
		$('.querySubproject').click(function () {
			/*  if(!$('#leftId').attr('projectId')){
                  layer.msg('请先选择左侧项目！', {icon: 0});
                  return false
              }*/
			var projectId=$('#leftId').attr('projectId')
			if(!projectId){
				projectId=''
			}
			var params={
				projectId:projectId,
				pbagName:$('.query input[name="pbagName"]').val(),
				buildUnit:$('.query select[name="buildUnit"]').val(),
				designUnit:$('.query select[name="designUnit"]').val(),
				pbagType:$('.query select[name="pbagType"]').val(),
				bagStatus:$('.query select[name="bagStatus"]').val(),
				_:new Date().getTime()
			}
			insTb.reload({
				url:'/plcProjectBag/selectPro',
				where: params
			})
		})
		//显示全部
		$('.showAll').click(function () {
			treeTableShow('', projectIds)
			$('.foldIcon').show()
			$('.select').removeClass('select')
			$('#leftId').removeAttr('projectId')
		})
	})
	//点击按钮收缩
	$('.foldIcon').click(function () {
		if($(this).hasClass('layui-icon-left')){
			$(this).attr('title','展开')
			$('.con_left').hide()
			$('.con_right').css({
				'width':'100%',
			})
			$(this).addClass('layui-icon-right').removeClass('layui-icon-left')
		}else{
			$(this).attr('title','折叠')
			$('.con_left').show().css('width','230px')
			$('.con_right').css({
				'width':'calc(100% - 230px)',
				'margin-left':'0px'
			})
			$(this).addClass('layui-icon-left').removeClass('layui-icon-right')
		}

	})
	//判断是否该为空
	function isUndefined(data) {
		if(data==1){
			return '是'
		}else if(data==0){
			return '否'
		}else{
			return ''
		}
	}
	//将毫秒数转为yyyy-MM-dd格式时间
	function format(t) {
		if (t) return new Date(t).Format("yyyy-MM-dd");
		else return ''
	}
	//计算计划工期
	function timeRange(beginTime,endTime) {
		var t1=new Date(beginTime)
		var t2=new Date(endTime)
		var time=t2.getTime()-t1.getTime()
		var days=parseInt(time / (1000*60*60*24))+1
		return days
	}
	//重置功能
	function reset() {
		$('.query input[name="pbagName"]').val('')
		$('.query select[name="buildUnit"]').val('')
		$('.query select[name="designUnit"]').val('')
		$('.query select[name="pbagType"]').val('')
		$('.query input[name="title"]').val('')
		form.render()
		var projectId=$('#leftId').attr('projectId')
		if(!projectId){
			projectId=''
		}
		var params={
			projectId:projectId,
			pbagName:$('.query input[name="pbagName"]').val(),
			buildUnit:$('.query select[name="buildUnit"]').val(),
			designUnit:$('.query select[name="designUnit"]').val(),
			pbagType:$('.query select[name="pbagType"]').val(),
			bagStatus:$('.query select[name="bagStatus"]').val(),
			_:new Date().getTime()
		}
		insTb.reload({
			url:'/plcProjectBag/selectPro',
			where: params
		})
	}
	//判断是否显示空
	function isShowNull(data) {
		if(data){
			return data
		}else{
			return ''
		}
	}

	// 初始化页面操作权限
	function initAuthority() {
		// 是否设置页面权限
		if (authorityObject) {
			// 检查查询权限
			if (authorityObject['09']) {
				$('.authority_search').show();
			}
		}
	}

</script>
</body>
</html>

