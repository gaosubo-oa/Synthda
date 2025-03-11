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
	<title>质量检查记录</title>
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


		* {
			margin: 0;
			padding: 0;
		}

		ul {
			width: 360px;
			margin:100px auto;
		}

		li {
			position: relative;
			padding: 0 21px;
			list-style: none;
			height: 54px;
			border-left: 1px solid #4BACFD;
		}

		li:before {
			content: "";
			display: block;
			position: absolute;
			/* margin-left: -6px; */
			top: 0;
			left: -5px;
			width: 10px;
			height: 10px;
			/* line-height: 22px; */
			text-align: center;
			background: #4BACFD;
			/* color: #fff; */
			/* font-size: 14px; */
			border-radius: 50%;
		}
		.last_progress{
			border: none;
		}
		.last_progress::before{
			content: "●";
			display: table-cell;
			position: absolute;
			vertical-align: middle;
			/* margin-left: -6px; */
			/* top: 0; */
			left: -6px;
			width: 14px;
			height: 14px;
			line-height: 11.5px;
			text-align: center;
			background: rgba(75, 172, 253, .3);
			color: #4BACFD;
			font-size: 18px;
			border-radius: 50%;
		}
		.progress_content{
			position: absolute;
			top: -4px;
		}
		.progress_title{
			font-size: 15px;
			color: #222;
			font-weight: 600;
			margin-bottom: 3px;
		}
		.progress_time{
			color: #999999;
			font-size: 12px;
		}
		.active{
			color: #2BA0FF;
		}
	</style>
</head>
<body>
<div class="mbox">
	<div class="layui-tab layui-tab-card" style="margin: 3px 0 10px 0;">
		<div id="clientSerch" style="height: 40px">
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
		<table id="Settlement" lay-filter="SettlementFilter"></table>
	</div>
</div>
<script type="text/html" id="toolbar">
	<div class="layui-btn-container">
		<%--<button class="layui-btn layui-btn-sm" lay-event="submit" style="width: 60px" id="">提交</button>--%>
		<button class="layui-btn layui-btn-sm" lay-event="import" style="width: 60px" id="">导入</button>
		<%--<button class="layui-btn layui-btn-sm" lay-event="delete" style="width: 60px">导出</button>--%>
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
			var serchObjUrl = "/workflow/qualityManager/getQualityCheckByStatus";
			//debugger
			if(serchSelect == "projectId"){
				searchtext = $("#projectId").val();
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/qualityManager/getQualityCheckByStatus";//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					serchObjUrl = "/workflow/qualityManager/getQualityCheckByStatus?"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "testTypeNo"){
				searchtext = $("#testTypeNo").val(); //输入框的值
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/qualityManager/getQualityCheckByStatus";//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					serchObjUrl = "/workflow/qualityManager/getQualityCheckByStatus?"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "testDeptId"){
				searchtext = $("#testDeptId").attr("deptid"); //输入框的值
				if((searchtext==''&&serchSelect=='0') || (searchtext==''&&serchSelect==0)){ //两个都为空查询全部
					serchObjUrl = "/workflow/qualityManager/getQualityCheckByStatus";//重载表格
				}else if((searchtext!=""&&serchSelect=='0') || (searchtext!=""&&serchSelect==0)){ //只输入，没有选择
					layer.msg("请选择查询条件");
				}else{
					if(searchtext.indexOf(",")!=-1){
						searchtext = searchtext.replace(",","");
					}else if(searchtext.indexOf("，")!=-1){
						searchtext = searchtext.replace("，","");
					}
					serchObjUrl = "/workflow/qualityManager/getQualityCheckByStatus?"+serchSelect+"="+searchtext;//重载表格
				}
			}else if(serchSelect == "planDate"){
				searchtext = $("#beginTime").val(); //输入框的值
				searchtext1 = $("#endTime").val();
				serchObjUrl = "/workflow/qualityManager/getQualityCheckByStatus?";
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
		// 树右侧表格实例
		SettlementTable = layui.table.render({
			elem: '#Settlement'
			// , data: []
			, url: '/workflow/qualityManager/getQualityCheckByStatus'//数据接口
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
							url:'/workflow/qualityManager/commitChecklist?checkliIds='+checkliIds+'&status=1',
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
				case 'import': //导入
					layer.open({
						type: 1,
						area: ['300px', '200px'], //宽高
						title: '提示',
						maxmin: true,
						content:'<div>功能待开发</div>'
					})
					// if(columnId==undefined){
					// 	layer.msg("请选择栏目");
					// 	return false;
					// }
					// var index = layer.open({
					// 	type: 1,
					// 	skin: 'layui-layer-molv', //加上边框
					// 	area: ['80%', '80%'], //宽高
					// 	title: '上传文档',
					// 	maxmin: true,
					// 	btn: ['提交', '取消'],
					// 	content: '<div class="layui-form" id="boxfo">' +
					// 			//'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档编号</label><div class="layui-input-block" style="margin-left: 130px;">' +
					// 			//'<input class="layui-input" lay-verify="required" name="docfileNo"></div></div>' +
					// 			'<div class="inbox" id="finde"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>关键词</label><div class="layui-input-block" style="margin-left: 130px;">' +
					// 			'<input class="layui-input"  lay-verify="required" name="keyWord"></div></div>' +
					// 			//'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>下载密码</label><div class="layui-input-block" style="margin-left: 130px;">' +
					// 			//'<input class="layui-input"  lay-verify="required" name="downloadPassword" id="downloadPassword"></div></div>' +
					// 			'<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档等级</label><div class="layui-input-block" style="margin-left: 130px;">' +
					// 			'<select name="docfileClass" lay-verify="required"></select></div></div>' +
					// 			'<div class="inbox"><label class="layui-form-label" style="width: 100px;">下载标识</label><div class="layui-input-block" style="margin-left: 130px;">' +
					// 			'<input disabled class="layui-input" style="width: 90%;float: left;"  lay-verify="required" name="downloadKey" id="downloadKey"><i id="reKey" style="cursor: pointer; position: relative;top: 7px;left: 10px;" class="layui-icon layui-icon-refresh"></i>  </div></div>' +
					// 			'<div class="inbox"><label class="layui-form-label" style="width: 100px;">文档摘要</label><div class="layui-input-block" style="margin-left: 130px;">' +
					// 			'<textarea name="docfileDesc" style="max-width: 100%;width: 100%;height:100px"></textarea></div></div>' +
					// 			'<div class="layui-form-item layui-hide"><input type="button" lay-submit lay-filter="add-file-submit" id="add-file-submit" value="确认"></div>' +
					// 			'<button hidden id="uploadButton"></button>'+
					// 			'<input hidden id="attachmentId" name="attachmentId"/>'+
					// 			'<input hidden id="attachmentName" name="attachmentName"/>'+
					// 			'</div>',
					// 	success: function () {
					// 		$.ajax({ //查询文档等级
					// 			url: '/knowledge/childTree',
					// 			type: 'get',
					// 			dataType: 'json',
					// 			async:false,
					// 			success: function (res) {
					// 				if(res.code == 0){
					// 					var qdata = res.data;
					// 					var str1 = '<div class="inbox"><label class="layui-form-label" style="width: 100px;"><span class="red">*</span>文档名称</label><div class="layui-input-block" style="margin-left: 130px;">' +
					// 							'<button type="button" class="layui-btn" id="but_chose" style=" float: right"> <i class="layui-icon">&#xe67c;</i>选择文件 </button>' +
					// 							'<input id="docfileName" readonly name="docfileName" style="width:80%; float: left"  class="layui-input"></div></div>' ;
					// 					var str2 = ""
					// 					if(qdata.length>0){
					// 						for(var i =0; i<qdata.length;i++){
					// 							str2+='<div class="inbox" ><label class="layui-form-label" style="width: 100px;" paid="'+qdata[i].id+'">'+qdata[i].name+'</label><div class="layui-input-block" style="margin-left: 130px;" lay-event="eleFn">' +
					// 									'<textarea type="text"  data-type="0" id="pele'+i+'" pid name="ptitle" required="" style="cursor: pointer"  placeholder="请选择" readonly="" autocomplete="off" class="textAreaBox ele treeNum"></textarea>' +
					// 									'<div class="eleTree ele'+i+'" lay-filter="data1" style="display:none;position:absolute;border: 1px solid #d2d2d2;overflow-y: auto;background-color: #fff;border-radius: 2px;box-shadow: 0 2px 4px rgba(0,0,0,.12);box-sizing: border-box;overflow:hidden;z-index: 999;top:38px;left:0px;width: 100%;"></div></div></div>'
					// 						}
					// 					}
					// 					var str = str1 + str2;
					// 					$("#finde").before(str);
					// 					form.render();
					// 					if(qdata.length>0) {
					// 						for (var i = 0; i < qdata.length; i++) {
					// 							(function (i) {
					// 								var elm = '.ele' + i
					// 								eleTree.render({
					// 									elem: '.ele' + i,
					// 									data: qdata[i].children,
					// 									expandOnClickNode: false,
					// 									highlightCurrent: true,
					// 									showLine: true,
					// 									showCheckbox: true,
					// 									checked: true,
					// 									// defaultExpandAll: true,
					// 									load: function (data, callback) {
					// 									},
					// 									done: function (res) {
					//
					// 									}
					// 								});
					// 							})(i);
					// 						}
					// 					}
					// 				}
					//
					//
					// 			}
					// 		})
					// 		var $td = $("#boxfo").find('div[lay-event="eleFn"]');
					// 		$td.click(function (obj) {
					// 			var td = $(this);
					// 			if(td.find("textarea.ele").attr("data-type") == "0"){
					// 				td.find(".eleTree").slideDown();
					// 				td.find("textarea.ele").attr("data-type","1");
					// 			}else{
					// 				td.find(".eleTree").slideUp();
					// 				td.find("textarea.ele").attr("data-type","0");
					// 			}
					// 			//点击本身外收起下拉的主体
					// 			document.onmouseup = function(e){
					// 				var e = e || window.event;
					// 				var target = e.target || e.srcElement;
					// 				//1. 点击事件的对象不是目标区域本身
					// 				//2. 事件对象同时也不是目标区域的子元素
					// 				if(!td.is(e.target) &&td.has(e.target).length === 0){
					// 					$(".eleTree").slideUp();
					// 					$("textarea.ele").attr("data-type","0");
					// 				}
					// 			}
					// 			//选中监听事件
					// 			var arr = [];
					// 			var arr1 = [];
					// 			var pidt = td.find("textarea.ele").attr("pid");
					// 			var valt = td.find("textarea.ele").val();
					// 			layui.eleTree.on("nodeChecked(data1)",function(d) {
					// 				var id = d.data.currentData.columnId+"";
					// 				var label = d.data.currentData.label+"";
					// 				if(d.isChecked == true || d.isChecked == "true"){
					// 					arr.push(id);
					// 					arr1.push(label);
					// 				}else{
					// 					arr.remove(id);
					// 					arr1.remove(label);
					// 				}
					// 				if(pidt != undefined || pidt != "undefined" || pidt != ""){
					// 					var str = pidt;
					// 				}else{
					// 					var str= "";
					// 				}
					// 				if(valt != undefined || valt != "undefined" || valt != ""){
					// 					var str1 = valt;
					// 				}else{
					// 					var str1 = "";
					// 				}
					// 				for(var i=0;i<arr.length;i++){
					// 					str+=arr[i]+","
					// 					str1+=arr1[i]+","
					// 				}
					// 				td.find("textarea.ele").val(str1);
					// 				td.find("textarea.ele").attr("pid",str);
					// 				// var data =  layui.table.cache["addTable"]
					// 				// var ind = td.find("textarea.ele").parents("tr").attr("data-index");
					// 				// data[ind].columnName = str1;
					// 				// data[ind].columnId = str;
					// 			})
					// 		})
					// 		$.ajax({ //随机生成不重复的key
					// 			url: '/fileManage/generStr',
					// 			type: 'post',
					// 			dataType: 'json',
					// 			// async:false,
					// 			success: function (res) {
					// 				$("#downloadKey").val(undefind_nullStr(res.obj));
					// 			}
					// 		})
					//
					// 		$("#reKey").on("click",function (e) {
					// 			$.ajax({ //随机生成不重复的key
					// 				url: '/fileManage/generStr',
					// 				type: 'post',
					// 				dataType: 'json',
					// 				// async:false,
					// 				success: function (res) {
					// 					$("#downloadKey").val(undefind_nullStr(res.obj));
					// 				}
					// 			})
					// 		})
					// 		var $select1 = $("select[name='docfileClass']");
					// 		var optionStr = '<option value="">请选择</option>';
					// 		$.ajax({ //查询文档等级
					// 			url: '/code/getCode?parentNo=KNOWLEDGE_DOCFILE_CLASS',
					// 			type: 'get',
					// 			dataType: 'json',
					// 			async:false,
					// 			success: function (res) {
					// 				if(res.obj!=undefined&&res.obj.length>0){
					// 					for(var i=0;i<res.obj.length;i++){
					// 						optionStr += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
					// 					}
					// 				}
					// 			}
					// 		})
					// 		$select1.html(optionStr);
					// 		form.render();//初始化表单
					// 		var uploadInst = upload.render({
					// 			elem: '#but_chose' //绑定元素
					// 			, url: '/upload?module=knowlage '//上传接口
					// 			, accept: 'file'
					// 			, auto: false
					// 			, bindAction: '#uploadButton'
					// 			, multiple: false
					// 			, choose: function (obj) {
					// 				obj.preview(function (index, file, result) {
					// 					$('#attachmentName').val(file.name);//显示文件名
					// 					$('#dangersPhotos').val(file.name);//显示文件名
					// 				});
					// 			}
					// 			, done: function (res) {
					// 				if(res.obj.length == 0){
					// 					if(res.msg == "The file size is 0"){
					// 						layer.msg("不可上传空文件!");
					// 					}else{
					// 						layer.msg(res.msg);
					// 					}
					// 				}else{
					// 					var obj = res.obj[0];
					// 					$('#attachmentId').val(getAttachIds(obj));
					// 					$("#add-file-submit").click();
					// 				}
					// 			}
					// 		});
					// 	},
					// 	yes: function (index, layero) {
					// 		var $select1 = $("select[name='itemFileType']");
					// 		if($("#attachmentName").val()==undefined||$("#attachmentName").val()==""){
					// 			layer.msg("请选择需要上传的文档");
					// 			return false;
					// 		}else if($("select[name='itemFileType']").val()==""){
					// 			layer.msg("请选择文档等级");
					// 			return false;
					// 		}else {
					// 			$('#uploadButton').click();
					// 		}
					// 	}
					// });
					// form.on('submit(add-file-submit)', function (data) {
					// 	var knowledgeDocfile = data.field;
					// 	var columnId="";
					// 	var treeNum = $(".treeNum").length;
					// 	for(var i=0;i<treeNum;i++){
					// 		columnId+=$('.ele' + i).prev("textarea").attr("pid")
					// 	}
					// 	knowledgeDocfile.columnId = columnId;
					// 	knowledgeDocfile.downloadAddress = $("#downloadKey").val();
					// 	$.ajax({
					// 		url:'/fileManage/insertFile',
					// 		type: 'post',
					// 		dataType:'json',
					// 		data:knowledgeDocfile,
					// 		success:function(res){
					// 			if(res.flag){
					// 				SettlementTable.reload();
					// 				layer.closeAll();
					// 			}
					// 			layer.msg(res.msg)
					// 		}
					// 	})
					// });
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
			if(layEvent === 'detail'){ //质量记录详情
				layer.open({
					type: 2,
					skin: 'layui-layer-molv', //加上边框
					area: ['100%', '100%'], //宽高
					title: '质量记录详情',
					maxmin: true,
					//btn: ['确定'],
					content: '/workflow/qualityManager/addQualityCheckRecord?planItemId='+dataa.planItemId,
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
							url:'/workflow/qualityManager/flowChart?securityContentId='+dataa.securityContentId,
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

    /*function make (data, ele, current) {//流程图
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
			temp += '<div class="step-item-main"><div class="step-item-main-title">' + data[i].title + '</div><div class="step-item-main-desc">' + data[i].desc + '</div></div></div>';

            if (parseInt(i) + 1 < data_length) {
                temp += '<div class="step-item-tail"><i class="' + tail + '"></i></div></div><br/>';
            }

            html += temp;
        }

        $(ele).append(html);
    }*/
</script>
</body>
</html>
