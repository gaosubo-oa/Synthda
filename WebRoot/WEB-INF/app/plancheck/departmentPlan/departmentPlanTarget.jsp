<%--
  Created by IntelliJ IDEA.
  User: 96394
  Date: 2020/5/8
  Time: 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>部门计划关键任务</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
		<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		
		<style>
			/*html, body {*/
				/*height: 100%;*/
				/*width: 100%;*/
				/*user-select: none;*/
			/*}*/
			
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
				position: absolute;
				width: 100%;
				height: 100%;
			}
			
			.content {
				position: absolute;
				top: 61px;
				left: 0;
				bottom: 0;
				right: 0;
			}
			
			.con_left {
				float: left;
				width: 320px;
				height: 100%;
			}
			
			.left_List .left_List_item {
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
			
			.left_List .select {
				background: #c7e1ff;
			}
			
			.con_right {
				float: left;
				width: calc(100% - 320px);
				height: 100%;
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
				width:100%;
				box-shadow: 0 0px 5px 0 rgba(0, 0, 0, .1);
				border-radius: 3px;
			}
			
			.dept_name {
				font-size: 18px;
				font-weight: 500;
			}
			.ew-tree-table-tool{
				height: 50px;!important;
			}
			.ew-tree-table{
				width: 100%;
			}
		
		</style>
	
	</head>
	<body>
		<div class="container">
			<div class="header">
				<div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img
							style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span
							style="margin-left: 10px">部门计划关键任务</span></span>
				</div>
			</div>
			<hr>
			<%--筛选查询--%>
			<form class="layui-form" action="">
				<div class="query" style="display: flex" >
					<div class="layui-form-item" >
						<label class="layui-form-label" style="margin-top: -5px">项目名称</label>
						<div class="layui-input-block">
							<input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item" >
						<label class="layui-form-label" style="margin-top: -5px">关注等级</label>
						<div class="layui-input-block">
							<input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
						</div>
					</div>

					<div class="layui-form-item" >
						<label class="layui-form-label" style="margin-top: -5px">周期类型</label>
						<div class="layui-input-block">
							<input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
						</div>
					</div>

					<div class="layui-form-item" >
						<label class="layui-form-label" style="margin-top: -5px">计划类型</label>
						<div class="layui-input-block">
							<input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item" >
						<label class="layui-form-label" style="margin-top: -5px">所属部门</label>
						<div class="layui-input-block">
							<input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item" >
						<label class="layui-form-label" style="margin-top: -5px">关键任务状态</label>
						<div class="layui-input-block">
							<input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
						</div>
					</div>

					<button type="button" class="layui-btn layui-btn-sm" style="margin-left:8%">查询</button>
				</div>
			</form>
			<hr style="margin-top: -8px">
			<div class="content clearfix" style="margin-top: 50px;">
				<div class="con_left">
					<div class="layui-card">
						<div class="layui-card-body" style="height: 100%; padding-bottom: 20px; box-sizing: border-box;">
							<div class="eleTree department_tree" style="height: 100%; overflow: auto;"
							     lay-filter="departmentData"></div>
						</div>
					</div>
				</div>
				<div class="con_right">
					<div class="layui-card" style="height: 100%;">
						<div class="layui-card-header dept_name"></div>
						<div class="layui-card-body clearfix">
							<table id="targetTreeTb"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%-- 子任务工具条 --%>
		<%--<script type="text/html" id="targetBar">--%>
			<%--<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>--%>
			<%--<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>--%>
			<%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
		<%--</script>--%>
		
		<%-- 子任务头部工具条 --%>
		<script type="text/html" id="targetToolBar">
			<div class="layui-btn-container">
				<button class="layui-btn layui-btn-sm" lay-event="add">新增关键任务</button>
				<div style="position:relative;margin-top: -40px;margin-left:75%">
					<button class="layui-btn layui-btn-sm" lay-event="inforAdd" style="margin-left:10px;">查看</button>
					<button class="layui-btn layui-btn-sm" lay-event="edit" style="margin-left:10px;">编辑</button>
					<button class="layui-btn layui-btn-sm" lay-event="del" style="margin-left:10px;">删除</button>
				</div>
			</div>
		</script>
		
		<script>

            var globalInfo = {}

            layui.use(['table', 'layer', 'form', 'laydate', 'upload', 'eleTree', 'treeTable'], function () {
                var table = layui.table,
                    form = layui.form,
                    layer = layui.layer,
                    laydate = layui.laydate,
                    upload = layui.upload,
                    eleTree = layui.eleTree,
                    treeTable = layui.treeTable;

                var eTree = eleTree.render({
                    elem: '.department_tree',
                    showLine: true, // 显示连接线
                    url: '/department/getChDeptfq',
                    lazy: true, // 开启懒加载
	                accordion: true,
                    //expandOnClickNode: false, // 禁止点击节点关闭显示子节点
                    highlightCurrent: true, // 选中高亮
                    where: {
                        deptId: 0
                    },
                    request: { // 修改数据为组件需要的数据
                        name: "deptName", // 显示的内容
                        key: "deptId", // 节点id
                        parentId: 'deptParent', // 节点父id
                        isLeaf: 'isLeaf' // 是否有子节点
                    },
                    response: { // 修改响应数据为组件需要的数据
                        statusName: "flag",
                        statusCode: true,
                        dataName: "obj"
                    },
                    load: function (data, callback) { // 懒加载方法
                        $.post('/department/getChDeptfq?deptId=' + data.deptId, function (res) {
                            res.obj.forEach(function (dept) {
                                dept.isLeaf = dept.isHaveCh === '1' ? false : true
                            })
                            callback(res.obj);//点击节点回调
                        })
                    }
                })

                // 树节点点击事件
                eleTree.on("nodeClick(departmentData)", function (d) {
                    
                    $('.dept_name').text(d.data.currentData.deptName)
	                
                    // 渲染表格
                    var insTb = treeTable.render({
                        elem: '#targetTreeTb',
                        url: '/plcDeptTarget/query',
	                    toolbar: '#targetToolBar',
						defaultToolbar:false,
                        tree: {
                            iconIndex: 1,           // 折叠图标显示在第几列
                            isPidData: true,        // 是否是id、pid形式数据
                            idName: 'tgId',  // id字段名称
                            pidName: 'parentTgId'     // pid字段名称
                        }
                        ,parseData: function (res) { //res 即为原始返回的数据
                            return {
                                "code": res.flag ? 0 : 1,
                                "msg": res.msg,
                                "data": res.obj
                            }
                        }
						,cols: [[ //表头
									{field: 'tgNo', title: '关键任务编号', minWidth: 110}
									,{field: 'tgName', title: '关键任务名称', minWidth: 150}
									,{field: 'parentTgId', title: '上级关键任务', minWidth: 90 }
									,{field: 'tgType', title: '关键任务类型', minWidth: 110}
									,{field: 'tgGrade', title: '关键任务等级', minWidth: 90}
									,{field: 'tgDesc', title: '关键任务说明', minWidth: 90}
									,{field: 'mainAreaDeptName', title: '一级监督部门', minWidth:150}
									,{field: 'mainProjectDeptName', title: '二级监督部门', minWidth:150}
									,{field: 'projectId', title: '所属项目名称' }
									,{field: 'pbagId', title: '所属子项目名称' }
									,{field: 'dutyUserName', title: '责任人', minWidth: 110}
									,{field: 'assistUserName', title: '协作人', minWidth: 110}
									,{field: 'mainCenterDeptName', title: '所属部门', minWidth:150}
									,{field: 'assistCompanyDeptName', title: '协助部门', minWidth:150}
									,{field: 'planType', title: '计划类型', minWidth: 110}
									,{field: 'planStage', title: '计划阶段', minWidth: 110}
									,{field: 'planRate', title: '计划形式', minWidth: 110}
									,{field: 'planLevel', title: '计划级次', minWidth: 110}
									,{field: 'controlLevel', title: '关注等级', minWidth: 110}
									,{field: 'according', title: '工作项依据', minWidth: 110}
									,{field: 'isKeypoint', title: '是否关键工作项', minWidth: 110}
									,{field: 'isResult', title: '是否提交成果', minWidth: 110}
									,{field: 'planSycle', title: '周期类型', minWidth: 110}
									// ,{field: 'flowId', title: '审批流程', minWidth: 110}
									,{field: 'planStartDate', title: '计划开始时间',minWidth:120}
									,{field: 'planEndDate', title: '计划完成时间',minWidth:120}
									,{field: 'planContinuedDate', title: '计划工期', minWidth: 110}
									,{field: 'realStartDate', title: '实际开始时间',minWidth:120}
									,{field: 'realEndDate', title: '实际完成时间',minWidth:120}
									,{field: 'realContinuedDate', title: '实际工期', minWidth: 110}
									,{field: 'standardDegree', title: '标准难度系数', minWidth: 110}
									,{field: 'hardDegree', title: '难度系数', minWidth: 110}
									,{field: 'resultConfirm', title: '成果确认', minWidth: 110}
									,{field: 'resultDesc', title: '成果描述', minWidth: 110}
									,{field: 'finalResultDesc', title: '最终交付成果描述', minWidth: 110}
									,{field: 'unusualRes', title: '异常原因', minWidth: 110}
									,{field: 'unusualStuff', title: '异常支撑材料', minWidth: 110}
									,{field: 'qualityScore', title: '质量得分', minWidth: 110}
									,{field: 'taskStatus', title: '关键任务状态', minWidth: 110}
									,{field: 'taskPrecess', title: '关键任务进度', minWidth: 110}
									,{field: 'taskType', title: '关键任务类型', minWidth: 110}
									,{field: 'taskDesc', title: '关键任务说明', minWidth: 110}
									,{field: 'riskPoint', title: '风险点', minWidth: 110}
									,{field: 'difficultPoint', title: '难度点', minWidth: 110}
									,{field: 'endScore', title: '单项得分', minWidth: 110}
									,{field: 'resultStandard', title: '完成标准', minWidth: 110}
									,{field: 'itemQuantity', title: '工程量', minWidth: 110}
									,{field: 'itemQuantityNuit', title: '工程量单位', minWidth: 110}
									// ,{fixed: 'right',title: '操作',align:'center', toolbar: '#targetBar', minWidth:170}
								]]
	                    ,where: {
                            mainCenterDept: d.data.currentData.deptId,
                            time: new Date().getTime()
	                    }
                    })

					//监听事件
					treeTable.on('toolbar(targetTreeTb)', function(obj){
						var layEvent = obj.event;
						if(layEvent === 'add'){
							layer.open({
								type: 1,
								title:'新增关键任务',
								area: ['100%', '100%'],
								maxmin:true,
								min: function(){
									$('.layui-layer-shade').hide()
								},
								btn:['确定','取消'],
								btnAlign: 'c',
								content:'<form id="targetForm" lay-filter="targetForm" style="padding: 30px 50px 0 30px;"class="layui-form">\n' +
										'<div class="layui-row">\n' +
										'<div class="layui-col-xs6">\n' +
										'<div class="layui-form-item">\n' +
										'<label class="layui-form-label">关键任务编号:</label>\n' +
										'<div class="layui-input-block">\n' +
										'<input type="text" name="tgNo" placeholder="请输入" autocomplete="off" class="layui-input ">' +
										'</div>\n' +
										'</div>\n' +
										'<div class="layui-form-item">\n' +
										'<label class="layui-form-label">关键任务名称:</label>\n' +
										'<div class="layui-input-block">\n' +
										'<input type="text" name="tgName" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'</div>\n' +
										'</div>\n' +
										'<div class="layui-form-item">\n' +
										'<label class="layui-form-label">上级关键任务:</label>\n' +
										'<div class="layui-input-block">\n' +
										'<input  type="text" name="parentTgId" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
										'</div>\n' +
										'</div>\n' +
										'<div class="layui-form-item">\n' +
										'<label class="layui-form-label">关键任务类型:</label>\n' +
										'<div class="layui-input-block">\n' +
										'<select id="tgType"  name="tgType" lay-verify="required" >' +
										'<option value=""></option>\n' +
										'</select>\n' +
										'</div>\n' +
										'</div>\n' +
										'<div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">关键任务等级:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <select id="tgGrade"  name="tgGrade" lay-verify="required">\n' +
										'                                                        <option value=""></option>\n' +
										'                                                    </select>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">关键任务说明:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input  type="text" name="tgDesc" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">一级监督部门:</label>\n' +
										'                                                <div class="layui-input-inline">\n' +
										'                                                    <input type="text" readonly id="mainAreaDept" name="mainAreaDept" autocomplete="off" class="layui-input dept_input ">\n' +
										'                                                </div>\n' +
										'                                                <div class="layui-form-mid layui-word-aux " deptid="mainAreaDept">\n' +
										'                                                    <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
										'                                                    <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">二级监督部门:</label>\n' +
										'                                                <div class="layui-input-inline">\n' +
										'                                                    <input  type="text" readonly id="mainProjectDept" name="mainProjectDept" autocomplete="off" class="layui-input dept_input ">\n' +
										'                                                </div>\n' +
										'                                                <div class="layui-form-mid layui-word-aux " deptid="mainProjectDept">\n' +
										'                                                    <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
										'                                                    <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										/*  '                                            <div class="layui-form-item">\n' +
                                          '                                                <label class="layui-form-label">所属项目:</label>\n' +
                                          '                                                <div class="layui-input-block">\n' +
                                          '                                                    <input '+disabled+' type="text" name="projectId" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                                          '                                                </div>\n' +
                                          '                                            </div>\n' +
                                          '                                            <div class="layui-form-item">\n' +
                                          '                                                <label class="layui-form-label">所属子项目:</label>\n' +
                                          '                                                <div class="layui-input-block">\n' +
                                          '                                                    <input '+disabled+' type="text" name="pbagId" placeholder="请输入" autocomplete="off" class="layui-input '+disabled+'">\n' +
                                          '                                                </div>\n' +
                                          '                                            </div>\n' +*/
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">责任人:</label>\n' +
										'                                                <div class="layui-input-inline">\n' +
										'                                                    <input  type="text" readonly id="dutyUser" name="dutyUser" autocomplete="off" class="layui-input  user_input ">\n' +
										'                                                </div>\n' +
										'                                                <div class="layui-form-mid layui-word-aux " userid="dutyUser">\n' +
										'                                                    <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
										'                                                    <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">协作人:</label>\n' +
										'                                                <div class="layui-input-inline">\n' +
										'                                                    <input type="text" readonly id="assistUser" name="assistUser" autocomplete="off" class="layui-input user_input ">\n' +
										'                                                </div>\n' +
										'                                                <div class="layui-form-mid layui-word-aux " userid="assistUser">\n' +
										'                                                    <a href="javascript:;" class="choose_user" choosetype="2" style="color: blue;">添加</a>\n' +
										'                                                    <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">所属部门:</label>\n' +
										'                                                <div class="layui-input-inline">\n' +
										'                                                    <input type="text" readonly id="mainCenterDept" name="mainCenterDept" autocomplete="off" class="layui-input dept_input ">\n' +
										'                                                </div>\n' +
										'                                                <div class="layui-form-mid layui-word-aux " deptid="mainCenterDept">\n' +
										'                                                    <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
										'                                                    <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">协助部门:</label>\n' +
										'                                                <div class="layui-input-inline">\n' +
										'                                                    <input type="text" readonly id="assistCompanyDepts" name="assistCompanyDepts" autocomplete="off" class="layui-input dept_input ">\n' +
										'                                                </div>\n' +
										'                                                <div class="layui-form-mid layui-word-aux " deptid="assistCompanyDepts">\n' +
										'                                                    <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
										'                                                    <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">计划类型:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <select id="planType" name="planType" lay-verify="required">\n' +
										'                                                        <option value=""></option>\n' +
										'                                                    </select>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">计划阶段:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <select id="planStage" name="planStage" lay-verify="required">\n' +
										'                                                        <option value=""></option>\n' +
										'                                                    </select>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">计划形式:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <select  id="planRate" name="planRate" lay-verify="required">\n' +
										'                                                        <option value=""></option>\n' +
										'                                                    </select>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">计划级次:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <select  id="planLevel" name="planLevel" lay-verify="required">\n' +
										'                                                        <option value=""></option>\n' +
										'                                                    </select>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">关注等级:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <select  id="controlLevel" name="controlLevel" lay-verify="required">\n' +
										'                                                        <option value=""></option>\n' +
										'                                                    </select>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">工作项依据:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <select  id="according" name="according" lay-verify="required">\n' +
										'                                                        <option value=""></option>\n' +
										'                                                    </select>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">是否关键工作项:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input  type="radio" name="isKeypoint" value="1" title="是">\n' +
										'                                                    <input  type="radio" name="isKeypoint" value="0" title="否" checked>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">是否提交成果:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="radio" name="isResult" value="1" title="是">\n' +
										'                                                    <input type="radio" name="isResult" value="0" title="否" checked>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">周期类型:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <select  id="planSycle" name="planSycle" lay-verify="required">\n' +
										'                                                        <option value=""></option>\n' +
										'                                                    </select>\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">工作量单位:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input  type="text" name="itemQuantityNuit" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-upload" style="height: auto">\n' +
										'                                                <div id="achievementsFile" style="padding-left: 160px;"></div>\n' +
										'                                                <label class="layui-form-label">成果文件:</label>\n' +
										'                        <div class="layui-input-block" id="achievementsFile_box">\n' +
										'                                                <button type="button" class="layui-btn layui-btn-primary " id="uploadAchievementsFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
										'                                            </div>\n' +
										'                                            </div>\n' +
										'                                        </div>\n' +
										'                                        <div class="layui-col-xs6">\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">计划开始时间:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input  type="text" name="planStartDate" id="planStartDate"  autocomplete="off" class="layui-input">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">计划完成时间:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="planEndDate" id="planEndDate"  autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">计划工期:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input  type="text" name="planContinuedDate" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">实际开始时间:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="realStartDate" id="realStartDate"  autocomplete="off" class="layui-input">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">实际完成时间:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="realEndDate" id="realEndDate" autocomplete="off" class="layui-input">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">实际工期:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="realContinuedDate" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">标准难度系数:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="standardDegree" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">难度系数:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="hardDegree" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">成果确认:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="resultConfirm" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">成果描述:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="resultDesc" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">最终交付成果描述:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="finalResultDesc" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">异常原因:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="unusualRes" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">异常支撑材料:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="unusualStuff" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">质量得分:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="qualityScore" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">关键任务状态:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="taskStatus" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">关键任务进度:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="taskPrecess" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">关键任务说明:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="taskDesc" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">风险点:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="riskPoint" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">难度点:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="difficultPoint" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">单项得分:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="endScore" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">完成标准:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="resultStandard" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-form-item">\n' +
										'                                                <label class="layui-form-label">工程量:</label>\n' +
										'                                                <div class="layui-input-block">\n' +
										'                                                    <input type="text" name="itemQuantity" placeholder="请输入" autocomplete="off" class="layui-input ">\n' +
										'                                                </div>\n' +
										'                                            </div>\n' +
										'                                            <div class="layui-upload" style="height: auto">\n' +
										'                                                <div id="targetFile" style="padding-left: 160px;"></div>\n' +
										'                                                <label class="layui-form-label">关键任务文件:</label>\n' +
										'                        <div class="layui-input-block" id="targetFile_box">\n' +
										'                                                <button type="button" class="layui-btn layui-btn-primary " id="uploadTargetFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
										'                                            </div>\n' +
										'                                            </div>\n' +
										'                                        </div>\n' +
										'                                    </div>\n' +
										'                                </form>',
								success:function () {

									form.render()
									// 处理时间显示
									// 计划开始时间
									// laydate.render({
									// 	elem: '#planStartDate',
									// 	value: tData && tData.planStartDate ? new Date(tData.planStartDate) : ''
									// })
									// 计划完成时间
									// laydate.render({
									// 	elem: '#planEndDate',
									// 	value: tData && tData.planEndDate ? new Date(tData.planEndDate) : ''
									// })
									// 实际开始时间
									// laydate.render({
									// 	elem: '#realStartDate',
									// 	value: tData && tData.realStartDate ? new Date(tData.realStartDate) : ''
									// })
									// 实际完成时间
									// laydate.render({
									// 	elem: '#realEndDate',
									// 	value: tData && tData.realEndDate ? new Date(tData.realEndDate) : ''
									// })

									$('.layui-disabled').attr('placeholder', '')
									//关键任务文件附件上传
									upload.render({
										elem: '#uploadTargetFile'
										,url: '/upload?module=plancheck' //上传接口
										,accept: 'file' //普通文件
										,done: function(res){
											var data=res.obj[0];

											var fileExtension=data.attachName.substring(data.attachName.lastIndexOf(".")+1,data.attachName.length);//截取附件文件后缀
											var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
											var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
											var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.size;
											var str = '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+data.attachName+'" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';

											$('#targetFile').append(str);

											layer.msg('上传成功', {icon:6});
										}
									})
									//成果文件附件上传
									upload.render({
										elem: '#uploadAchievementsFile'
										,url: '/upload?module=plancheck' //上传接口
										,accept: 'file' //普通文件
										,done: function(res){
											var data=res.obj[0];

											var fileExtension=data.attachName.substring(data.attachName.lastIndexOf(".")+1,data.attachName.length);//截取附件文件后缀
											var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
											var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
											var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data.size;
											var str = '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="'+data.attachName+'" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';

											$('#achievementsFile').append(str);

											layer.msg('上传成功', {icon:6});
										}
									})
								},
								yes:function (index) {
								layer.close(index)
								}
							})
						}

					});

                })
            })

            //将毫秒数转为yyyy-MM-dd格式时间
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd")
                } else {
                    return ''
                }
            }
			
		</script>
	
	</body>
</html>
