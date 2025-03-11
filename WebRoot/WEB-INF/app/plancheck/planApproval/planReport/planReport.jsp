<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/6/23
  Time: 14:50
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
		<title>计划上报</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">

		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui_v2.5.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
<%--		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/excel.js"></script>--%>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
		<script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
		
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
			
			.query {
				padding: 10px 0;
			}
			
			.query_item {
				float: left;
			}
			
			.query input, select {
				height: 35px;
			}
			
			.query .layui-form-label {
				width: 80px;
				height: 35px;
				padding: 0 10px;
				line-height: 35px;
				box-sizing: border-box;
			}
			
			.query .layui-input-block {
				margin-left: 80px;
			}
			
			.query .layui-form-item {
				height: 35px;
				margin: 0;
				clear: none;
			}
			
			.query .query_button_group {
				height: 100%;
				margin-top: 2px;
			}
			
			.query .query_btn {
				float: right;
				width: 55px;
				margin-right: 20px;
				margin-left: 0;
			}
			
			.layui-tab-content {
				padding: 0;
			}
			
			.titleSp {
				padding-left: 10px;
				font-size: 18px;
				cursor: pointer;
			}
			
			.ew-tree-table {
				margin: 0 !important;
			}
			
			.ew-tree-table-tool-right {
				display: none;
			}
			
			.layui-table-tool {
				height: 38px;
				min-height: 38px;
				padding: 3px 15px;
			}
			
			.layui-table-tool-self {
				top: 2px;
			}
			
			.layui-table-tool-temp {
				padding: 0;
			}
			.layui-layer-btn{
				background-color: inherit;
				text-align: center;
			}
			.required_field {
				margin-right: 2px;
				font-size: 25px;
				line-height: 20px;
				vertical-align: text-top;
				color: red;
			}
			
			.divShow {
				position: relative;
			}

			.divShow a {
				color: #1687cb !important;
				text-decoration: none !important;
			}
			
			.operationDiv {
				display: none;
				position: absolute;
				top: -40px;
                left: 5px;
				border-radius: 5px;
				background: #fff;
				box-shadow: 0 0 3px 1px rgba(0, 0, 0, .3);
			}
			
			.divShow:hover .operationDiv {
				display: block;
			}
			
			.td_title {
				background: #F2F2F2;
				width: 200px;
			}
			/*调整下拉框树的角标样式*/
			.layui-treeSelect .ztree li span.button.switch{
				top: -2px !important;
			}

			/*附件样式start*/
			.openFile input[type=file] {
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
			.bar {
				height: 18px;
				background: green;
			}
			/*附件样式end*/

			/*关键任务类型start*/
			.project_item {
				position: absolute;
				top: 5px;
				right: 15px;
				bottom: 10px;
				left: 250px;
			}

			.project_item .layui-table-view {
				margin: 0;
			}

			.select{
				background: #eee;
			}
			/*关键任务类型end*/
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
		<input type="hidden" id="projectId">
		<input type="hidden" id="belongtoDept">
		<%--计划调整按钮使用--%>
		<input type="hidden" id="allTgId">
		<div class="container">
			<%--<div class="header">
				<div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px">
                        <img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt="">
                        <span style="margin-left: 10px">计划上报</span>
                    </span>
				</div>
			</div>
			<hr>--%>
			<div class="layui-tab layui-tab-brief" lay-filter="reportTabs">
				<ul class="layui-tab-title">
					<li class="layui-this">未上报计划(<span class="reported">0</span>)</li>
					<li>已上报计划</li>
				</ul>
				<div class="layui-tab-content">
					<div class="layui-tab-item layui-show">
						<input type="hidden" id="planId">
						<input type="hidden" id="tabIndex" value="1">
						<div class="theParentBox">
							<form class="layui-form query clearfix">
								<div class="layui-form-item query_item">
									<label class="layui-form-label">类型:</label>
									<div class="layui-input-block">
										<select name="planClass" lay-verify="required">
											<option value="">请选择</option>
											<option value="1">主项计划</option>
											<option value="2">职能计划</option>
											<option value="3">子任务计划</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs query_item">
									<label class="layui-form-label">名称:</label>
									<div class="layui-input-block">
										<input type="text" name="planName" autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-form-item inputs query_item">
									<label class="layui-form-label">年度:</label>
									<div class="layui-input-block">
										<select name="planYear" lay-filter="planYear">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs query_item">
									<label class="layui-form-label">季度:</label>
									<div class="layui-input-block">
										<select name="planQuarter" lay-filter="planQuarter">
											<option value="">请选择</option>
											<option value="1">第一季度</option>
											<option value="2">第二季度</option>
											<option value="3">第三季度</option>
											<option value="4">第四季度</option>
										</select>
									</div>
								</div>
							</form>
							<form class="layui-form query clearfix">
								<div class="layui-form-item inputs query_item">
									<label class="layui-form-label">月度:</label>
									<div class="layui-input-block">
										<select name="planMonth"></select>
									</div>
								</div>
								<div class="layui-form-item inputs query_item">
									<label class="layui-form-label">计划类型:</label>
									<div class="layui-input-block">
										<select name="planType">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs query_item">
									<label class="layui-form-label">审批人:</label>
									<div class="layui-input-block">
										<input type="text" readonly placeholder="选择审批人" name="dutyUser" id="query_user" class="layui-input" style="cursor: pointer;background-color: #e7e7e7;" />
									</div>
								</div>
								<div class="layui-form-item inputs query_item">
									<label class="layui-form-label">所属部门:</label>
									<div class="layui-input-block">
										<input type="text" readonly placeholder="选择所属部门" name="belongtoUnits" id="query_dept" class="layui-input" style="cursor: pointer;background-color: #e7e7e7;" />
									</div>
								</div>
								<div class="query_button_group query_item" style="display: none;">
									<button type="reset" id="resetBtn" class="layui-btn layui-btn-sm query_btn">重置
									</button>
									<button type="button" class="layui-btn layui-btn-sm query_btn search_one">查询</button>
								</div>
							</form>
							<div class="project" style="padding: 0 20px;">
								<table id="reportedTable" lay-filter="reportedTable"></table>
							</div>
						</div>
						<div style="display: none;" class="theChildBox">
							<form class="layui-form query layui-row">
								<input type="hidden" id="planClass">
								<input type="hidden" id="projectOrDeptId">
								<div class="layui-form-item layui-col-xs2">
									<label class="layui-form-label">项目名称:</label>
									<div class="layui-input-block">
										<input type="text" name="projName" autocomplete="off" class="layui-input">
									</div>
								</div>
								<div class="layui-form-item layui-col-xs2">
									<label class="layui-form-label">所属部门:</label>
									<div class="layui-input-block">
										<select name="ownerUnit" class="deptName" lay-verify="required">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">计划类型:</label>
									<div class="layui-input-block">
										<select name="planType" lay-verify="required">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">年度:</label>
									<div class="layui-input-block">
										<select name="planYear" lay-filter="planYear">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
								<div class="layui-form-item inputs layui-col-xs2">
									<label class="layui-form-label">月度:</label>
									<div class="layui-input-block">
										<select name="planMonth" lay-filter="planMonth"></select>
									</div>
								</div>
								<div class="query_button_group layui-col-xs2" style="display: none;">
									<button type="reset" id="resetChildBtn" class="layui-btn layui-btn-sm query_btn">
										重置
									</button>
									<button type="button" class="layui-btn layui-btn-sm query_btn search_two">查询</button>
								</div>
							</form>
							<div id="theChildPlanBox" style="padding: 0 20px;">
								<table id="theChildPlan" lay-filter="theChildPlan"></table>
							</div>
							<div id="targetTableBox" style="padding: 0 20px;">
								<table id="targetTable" lay-filter="targetTable"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="barDemo">
			<div class="clearfix">
				{{# if(authorityObject && authorityObject['04']){ }}
				<a class="layui-btn layui-btn-sm rep" lay-event="delete" style="float: right; margin-right: 45px;">删除</a>
				{{# } }}
				{{# if(authorityObject && authorityObject['08']){ }}
				<a class="layui-btn layui-btn-sm rep" lay-event="report" style="float: right; margin-right: 15px;">上报</a>
				{{# } }}
			</div>
		</script>
		
		<script type="text/html" id="childDemo">
			<div>
				<span><i class="layui-icon layui-icon-next" style="color: green"></i><span
						class="titleSp" style="color: blue"></span></span>
				<a class="layui-btn layui-btn-sm" lay-event="export" style="float: right;margin-left: 10px;">导出</a>
				<a class="layui-btn layui-btn-sm targetButton" lay-event="revisionDetail" style="float: right;margin-left: 10px;">修编详情</a>
<%--				<a class="layui-btn layui-btn-sm targetButton" lay-event="submit" style="float: right;margin-left: 10px;">提交</a>--%>
				<a class="layui-btn layui-btn-sm targetButton" lay-event="revision" style="float: right">修编</a>
				<a class="layui-btn layui-btn-sm targetButton" lay-event="edit" style="float: right;margin-left: 10px;">编辑</a>
				<a class="layui-btn layui-btn-sm targetButton" lay-event="add" style="float: right;margin-left: 10px;">新增</a>
				<a class="layui-btn layui-btn-sm targetButton" lay-event="initialization" style="float: right;margin-left: 10px;">导入</a>
				<a class="layui-btn layui-btn-sm planModify" lay-event="planModify" style="float: right;margin-left: 10px;">计划调整</a>
				<%--{{#  if(authorityObject && authorityObject['04']){ }}
				<a class="layui-btn layui-btn-sm" lay-event="del" style="float: right;margin-left: 10px;">删除</a>
				{{# } }}
				{{#  if(authorityObject && authorityObject['05']){ }}
				<a class="layui-btn layui-btn-sm" lay-event="edit" style="float: right">编辑</a>
				{{# } }}
				{{#  if(authorityObject && authorityObject['08']){ }}
				<a class="layui-btn layui-btn-sm task_rep" lay-event="report" style="float: right">上报</a>
				{{# } }}--%>
			</div>
		</script>
		
		<script type="text/javascript">
			resizeQuery();
			
            window.onresize = function () {
                resizeQuery();
            }

            initAuthority();
            
            var user_id = '';

            var dictionaryObj = {
                PLAN_SYCLE: {},
                PLAN_TYPE: {},
                PLAN_PHASE: {},
                CONTROL_LEVEL: {},
                CGCL_TYPE: {},
                UNIT: {},
                RENWUJIHUA_TYPE: {},
                TG_TYPE: {},
				ORGANIZATION_TYPE:{},
				TG_GRADE:{},
            }
            var dictionaryStr = 'PLAN_SYCLE,PLAN_TYPE,PLAN_PHASE,CONTROL_LEVEL,CGCL_TYPE,UNIT,RENWUJIHUA_TYPE,TG_TYPE,ORGANIZATION_TYPE,TG_GRADE';
            // 获取数据字典数据
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: ''}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
                            });
                        }
                    }
                }
                init();
            });

            function init() {
                layui.use(['element', 'form', 'table', 'treeTable', 'soulTable','laydate','treeSelect','eleTree'], function () {
                    var form = layui.form,
                        table = layui.table,
                        element = layui.element,
                        treeTable = layui.treeTable,
                        soulTable = layui.soulTable,
						laydate = layui.laydate,
						treeSelect = layui.treeSelect,
						eleTree = layui.eleTree;

                    var reportedTable = null;
					var insTb = null;

					var tgIdsArr=[]

					//监听排序事件
					table.on('sort(reportedTable)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
						// console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
						if(obj.type=='asc'){
							var type=1
						}else{
							var type=2
						}
						if($('.layui-this').text().indexOf('已')!=-1){
							var apprivalStatus=1
						}else{
							var apprivalStatus=0
						}
						reportedTable.reload({
							where:{
								apprivalStatus:apprivalStatus ,
								_: new Date().getTime(),
								orderBy:type //排序方式
							},
							cur: {
								page: 1
							},
							done: function (res) {
								if (res.flag && apprivalStatus == 0) {
									$('.reported').text(res.totleNum);
								}
								soulTable.render(this);
								resizeQuery();
							}
						});
					});

                    $('.query [name="planCycle"]').append(dictionaryObj['PLAN_SYCLE']['str']);
                    $('.query [name="planType"]').append(dictionaryObj['PLAN_TYPE']['str']);
                    
                    // 所属部门的ajax
                    $.ajax({
                        url: '/department/getDeptTop',
                        dataType: 'json',
                        type: 'get',
                        success: function (res) {
                            var obj = res.obj
                            var str = ''
                            for (var i = 0; i < obj.length; i++) {
                                str += '<option value="' + obj[i].deptId + '">' + obj[i].deptName + '</option>'
                            }
                            $('.deptName').append(str);
                            form.render('select');
                        }
                    });
                    
                    $('#query_user').on("click",function(){
                        user_id = 'query_user';
                        $.popWindow('/common/selectUser?0');
                    })
					$('#query_dept').on("click",function(){
						dept_id = 'query_dept';
						$.popWindow('/common/selectDept');
					})

                    // 计划期间年度列表
                    var allYear = '';

                    // 外层查询
                    $('.search_one').on("click",function () {
                        var data = {_: new Date().getTime()};
                        var $queryEle = $('.theParentBox').find('[name]');
                        $queryEle.each(function (v, e) {
                            var key = $(e).attr('name');
                            var value = $(e).val();
                            data[key] = value ? value.trim() : '';
                        });
                        if($('#query_user').attr('user_id')){
							data['dutyUser'] = $('#query_user').attr('user_id').replace(/,$/, '')
						}else{
							data['dutyUser'] = '';
						}
						if($('#query_dept').attr('deptid')){
							data['belongtoUnits'] = $('#query_dept').attr('deptid').replace(/,$/, '')
						}else{
							data['belongtoUnits'] = '';
						}

                        var configWhere = reportedTable.config.where;
                        var apprivalStatus = configWhere.apprivalStatus || 0;
                        reportedTable.reload({
                            where: $.extend({}, configWhere, data),
                            cur: {
                                page: 1
                            },
                            done: function (res) {
                                if (res.flag && apprivalStatus == 0) {
                                    $('.reported').text(res.totleNum);
                                }
                                soulTable.render(this);
                            }
                        });
                    });

                    // 内侧查询
                    $('.search_two').on("click",function () {
                        var planClass = $('#planClass').val();
                        var searchData = {_: new Date().getTime()}
                        var title = $('.titleSp').text();

                        searchData.planId = $('#planId').val();
                        var $queryEle = $('.theChildBox').find('[name]');
                        $queryEle.each(function (v, e) {
                            var key = $(e).attr('name');
                            var value = $(e).val();
                            searchData[key] = value ? value.trim() : '';
                        });

                        initTaskTable(planClass, searchData, function () {
                            $('.titleSp').text(title);
                            var tabIndex = $('#tabIndex').val();
                            // 未上报显示新增、修编、续编详情按钮(只针对主项计划显示，其他不显示)
                            if (tabIndex == 1) {
                                $('.planModify').hide();
                                /*判断是否是计划调整过来的*/
                                if (planClass == 1 && $('#planId').attr('modify') == 1) {
                                    $('.targetButton').show();
                                } else {
                                    $('.targetButton').hide();
                                }
                            } else {
                                // 已上报显示计划调整按钮(只针对主项计划显示，其他不显示)
                                $('.targetButton').hide();
                                if (planClass == 1 && $('#planId').attr('taskApproval') == 2) {
                                    $('.planModify').show();
                                } else {
                                    $('.planModify').hide();
                                }
                            }
                        });
                    });

                    // 获取计划期间年度列表
                    $.get('/planPeroidSetting/selectAllYear', function (res) {
                        if (res.object.length > 0) {
                            res.object.forEach(function (item) {
                                allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                            });
                        }
                        $('.query [name="planYear"]').append(allYear);
                        form.render('select');
                    });

                    // 根据年度获取月度
                    form.on('select(planYear)', function (data) {
                        if (data.value) {
                            getPlanMonth(data.value, function (monthStr) {
                                $('.query [name="planMonth"]').html(monthStr);
								$('.query [name="planQuarter"]').html('<option value="">请选择</option>');
                                form.render('select');
                            });
                        } else {
                            $('.query [name="planMonth"]').html('<option value="">请选择</option>');
							form.render('select');
                        }
                    });
					// 根据季度获取月度
					form.on('select(planQuarter)', function (data) {
						if (data.value == 1) {
							$('.query [name="planMonth"]').html('<option value="">请选择</option>\n' +
									'<option value="">1</option>\n' +
									'<option value="">2</option>\n' +
									'<option value="">3</option>');
							form.render('select');
						} else if (data.value == 2){
							$('.query [name="planMonth"]').html('<option value="">请选择</option>\n' +
									'<option value="">4</option>\n' +
									'<option value="">5</option>\n' +
									'<option value="">6</option>');
							form.render('select');
						} else if (data.value == 3){
							$('.query [name="planMonth"]').html('<option value="">请选择</option>\n' +
									'<option value="">7</option>\n' +
									'<option value="">8</option>\n' +
									'<option value="">9</option>');
							form.render('select');
						} else if (data.value == 4){
							$('.query [name="planMonth"]').html('<option value="">请选择</option>\n' +
									'<option value="">10</option>\n' +
									'<option value="">11</option>\n' +
									'<option value="">12</option>');
							form.render('select');
						}
					});

                    form.render();

					//重置
					$('#resetBtn').on("click",function () {
						$(".theParentBox form")[0].reset()
						//清空选人/部门控件
						$('#query_user').attr('user_id','')
						$('#query_dept').attr('deptid','')
					})

                    // 切换未上报、已上报
                    element.on('tab(reportTabs)', function (data) {
                        $('.theChildBox').hide();
                        $('.theParentBox').show();
                        // 重置查询表单
                        $('#resetBtn').trigger('click');
                        $('#resetChildBtn').trigger('click');
                        switch (data.index) {
                            case 0:
                                initReportedTable(0);
                                $('#tabIndex').val(1);
                                $('.rep').show();
                                break;
                            case 1:
                                initReportedTable(1);
                                $('#tabIndex').val(2);
                                $('.rep').hide();
                                break;
                        }
                    });

                    initReportedTable(0);

                    function initReportedTable(type) {
                        var searchData = {
                            apprivalStatus: type,
                            _: new Date().getTime()
                        }
                        if (!reportedTable) {
                            reportedTable = table.render({
                                elem: '#reportedTable',
                                url: '/plcPlan/query', //数据接口
                                page: true, //开启分页
								limit: 50,
								height: 'full-170',
								toolbar: '#barDemo',
                                defaultToolbar: ['filter'],
								autoSort: false, //禁用前端自动排序。注意：该参数为 layui 2.4.4 新增
                                cols: [[ //表头
                                    {type: 'checkbox'},
                                    {
                                        field: 'planName',
                                        title: '名称',
                                        align: 'left',
                                        event: 'nameLink',
                                        width: 500,
                                        style: 'cursor: pointer;'
                                        , templet: function (d) {
                                            var style = 'color: blue;text-decoration: underline;';
                                            if (d.agreeStatus == 3) {
                                                style = 'color: red;text-decoration: underline;';
                                            }
                                            return '<a planName="'+d.planName+'" modify="'+d.modify+'" revisionYn="'+d.revisionYn+'" taskApproval="'+d.taskApproval+'" tgIds="'+d.tgIds+'" belongtoDept="'+d.belongtoDept+'" belongtoDeptName="'+d.belongtoDeptName+'" style="'+style+'">' + d.planName +function () {
												if(d.modify==1){
													return  '<span style="color: red">(修编)</span>'
												}else{
													return ''
												}
											}()+function () {
												if(d.revisionYn==1 && $('.layui-this').text().indexOf('已')!=-1){
													return  '<span style="color: red">(修编审批)</span>'
												}else{
													return ''
												}
											}()+ '</a>'
                                        }
                                    },
	                                {
                                        field: 'agreeStatus', title: '一级审批状态', width: 100,templet: function (d) {
                                            if (d.agreeStatus == 3) {
                                                return '<a style="color: red;cursor: pointer;text-decoration: underline;" class="back_detail" returnComments="'+isShowNull(d.returnComments)+'" questionName="'+isShowNull(d.questionName)+'">退回</a>'
                                            } else if (d.agreeStatus == 1) {
                                                return '待审批';
                                            } else if (d.agreeStatus == 2) {
                                                return '同意';
                                            } else {
                                                return '';
                                            }
                                        }
                                    },
									{
										field: 'taskApproval', title: '二级审批状态',width: 150,templet: function (d) {
											if (d.taskApproval == 1) {
												return '正在审批'
											} else if (d.taskApproval == 2) {
												return '同意';
											} else if (d.taskApproval == 3) {
												return '<a style="color: red;cursor: pointer;text-decoration: underline;" class="back_detail" returnComments="' + isShowNull(d.returnComments) + '" questionName="' + isShowNull(d.questionName) + '">退回</a>'
											} else {
												return '';
											}
										}
									},
                                    {
                                        field: 'planClass', title: '类型', templet: function (d) {
                                            var str = '';
                                            switch (d.planClass) {
                                                case '1':
                                                    str = '主项关键任务';
                                                    break;
                                                case '2':
                                                    str = '职能关键任务';
                                                    break;
                                                case '3':
                                                    str = '子任务计划';
                                                    break;
                                                default:
                                                    break;
                                            }
                                            return str;
                                        }
                                    },
                                    {
                                        field: 'planCycle', title: '周期类型', templet: function (d) {
                                            return dictionaryObj['PLAN_SYCLE']['object'][d.planCycle] || '';
                                        }
                                    },
                                    {
                                        field: 'planType', title: '计划类型', templet: function (d) {
                                            if (d.planClass == 3) {
                                                return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.planType] || '';
                                            } else {
                                                return dictionaryObj['TG_TYPE']['object'][d.planType] || '';
                                            }
                                        }
                                    },
                                    {
                                        field: 'planYear', title: '年度'
                                    },
                                    {
                                        field: 'planMonth', title: '月度'
                                    },
                                    {field: 'dutyUserName', title: '责任人',sort: true},
                                    {field: 'belongtoUnitName', title: '所属部门'},
									{field: 'attachments1', align: 'center',width:200, title: '编制依据',
										templet: function (d) {
											var attachmentList = d.attachments1;
											var str = ''
											if (attachmentList && attachmentList.length > 0) {
												attachmentList.forEach(function(item){
													var fileExtension=item.attachName.substring(item.attachName.lastIndexOf(".")+1,item.attachName.length);//截取附件文件后缀
													var attName = encodeURI(item.attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
													var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
													var deUrl = item.attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+item.size;

													str+= '<div class="divShow"><a href="javascript:;" title="'+item.attachName+'" style="display: block; overflow: hidden;text-overflow: ellipsis;">'+item.attachName+'</a>' +
															'<div class="operationDiv" style="width:45%;text-align: left">'+function(){
																if(fileExtension == 'pdf' || fileExtension == 'PDF'|| fileExtension == 'png' || fileExtension == 'PNG' || fileExtension == 'jpg' || fileExtension == 'JPG'|| fileExtension == 'txt'|| fileExtension == 'TXT') { //判断是否需要查阅
																	return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(deUrl) + '" style="display: block; padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																}else{
																	return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + deUrl + '" style="display: block;padding-left: 10px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																}
															}()+
															'<a class="operation" style="display: block;padding-left: 10px;" href="/download?' + encodeURI(deUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
															+'</div>' +
															'</div>'
												});
											}
											return str;
										}
									},
                                ]],
                                where: searchData,
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    msgName: 'msg',
                                    countName: 'totleNum',
                                    dataName: 'obj'
                                },
								request: {
										pageName: 'page' //页码的参数名称，默认：page
										,limitName: 'pageSize' //每页数据量的参数名，默认：limit
								},
                                done: function (res) {
                                    if (res.flag && type == 0) {
                                        $('.reported').text(res.totleNum);
                                    }
                                    soulTable.render(this);
									$('.divShow').parent().css('height','auto');
									$('.divShow').parent().css('overflow','visible');
									var $operationDiv = $('#reportedTable').next().find('.layui-table-main tr').last().find('.operationDiv');

									$operationDiv.each(function(){
										var length = $(this).children('a').length;
										$(this).css('top', '-'+(length*20+2)+'px');
									});
                                }
                            });
                        } else {
                            reportedTable.config.where = searchData;

                            reportedTable.reload({
                                where: searchData,
                                cur: {
                                    page: 1
                                },
                                done: function (res) {
                                    if (res.flag && type == 0) {
                                        $('.reported').text(res.totleNum);
                                    }
                                    soulTable.render(this);
                                    resizeQuery();
                                }
                            });
                        }
                    }
                    
                    // 退回详情
                    $(document).on('click', '.back_detail', function () {
                        var returncomments = $(this).attr('returncomments') || '';
                        var questionName = $(this).attr('questionName') || '';
                        layer.open({
                            type: 1,
                            title: '退回详情',
                            btn: ['返回'],
                            area: ['600px', '550px'],
                            content: ['<div style="padding: 10px;">',
                                '<p style="padding: 5px;font-size: 16px;">退回原因:</p>',
                                '<textarea name="backReason" readonly rows="3" class="layui-textarea"></textarea>',
                                '<p style="padding: 5px;font-size: 16px;">问题关键任务/子任务编码名称:</p>',
                                '<ul id="checkTgOrTask" style="height: 250px; overflow-y: auto;"></ul>',
                                '</div>'].join(''),
                            success: function () {
								$('[name="backReason"]').val(returncomments);
								var questionNames = questionName.replace(/,$/, '').split(',');
								var checkEleStr = '';
								questionNames.forEach(function(item){
								    checkEleStr += '<li style="padding: 5px;">' + item + '</li>';
								});
								$('#checkTgOrTask').html(checkEleStr);
                            }
                        });
	                });

                    //监听单元格编辑事件
                    table.on('tool(reportedTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        switch (layEvent) {
                            case 'nameLink':
                            	/*计划调整按钮使用*/
								$('#allTgId').attr('tgIds',$(this).find('a').attr('tgIds'))
								$('#allTgId').attr('belongtoDept',$(this).find('a').attr('belongtoDept'))
								$('#allTgId').attr('belongtoDeptName',$(this).find('a').attr('belongtoDeptName'))
								$('#allTgId').attr('taskApproval',$(this).find('a').attr('taskApproval'))

                                $('#planId').val(data.planId);
								/*判断该计划是否被计划调整过*/
                                $('#planId').attr('modify',data.modify);
                                $('#planId').attr('taskApproval',data.taskApproval || '');
								if($(this).find('a').attr('modify')==1){
									var content1='<span style="color: red">(修编)</span>'
								}else{
									var content1=''
								}
								if($(this).find('a').attr('revisionYn')==1 && $('.layui-this').text().indexOf('已')!=-1){
									var content2='<span style="color: red">(修编审批)</span>'
								}else{
									var content2=''
								}
                                var title = $(this).find('a').attr('planName')+content1+content2
                                var searchData = {_: new Date().getTime()}
                                var id = data.planClass == 1 ? data.belongtoProj : data.belongtoDept;
                                if (data.planClass == 1) {
                                    searchData.parentPbagId = 0;
                                    searchData.projectId = id;
                                } else if (data.planClass == 2) {
                                    searchData.deptId = id;
                                    /*新增职能关键任务时使用*/
                                    $('#belongtoDept').val(data.belongtoDept)
                                } else if (data.planClass == 3) {
                                    searchData.projOrgId = id;
                                }

                                $('#planClass').val(data.planClass);
                                $('#projectOrDeptId').val(id);

                                var datas = {
                                    _: new Date().getTime(),
                                    planId: data.planId
                                }
                                // 重置查询表单
                                $('#resetChildBtn').trigger('click');
                                initTaskTable(data.planClass, datas, function () {
                                    $('.titleSp').html(title);
                                    $('.theChildBox').show();
                                    $('.theParentBox').hide();
                                    var tabIndex = $('#tabIndex').val();
									// 未上报显示新增、修编、续编详情按钮(只针对主项计划显示，其他不显示)
									if (tabIndex == 1) {
										$('.planModify').hide();
										/*判断是否是计划调整过来的*/
										if (data.planClass == 1 && $('#planId').attr('modify') == 1) {
											$('.targetButton').show();
										} else {
											$('.targetButton').hide();
										}
									} else {
										// 已上报显示计划调整按钮(只针对主项计划显示，其他不显示)
										$('.targetButton').hide();
										if (data.planClass == 1 && $('#planId').attr('taskApproval') == 2) {
											$('.planModify').show();
										} else {
											$('.planModify').hide();
										}
									}
                                });
                                break;
                        }
                    });
                    
                    // 查看关键任务详情
                    $(document).on('click', '.tg_detail', function(){
                        var tgId = $(this).attr('tgId');
	                    $.get('/ProjectDaily/selectProjectDailyByItemId', {tgId: tgId}, function(res){
	                        
                            var targetData = res.object;
                            
                            layer.open({
                                type: 1,
                                title: '关键任务详情',
                                area: ['70%', '90%'],
                                maxmin: true,
                                min: function () {
                                    $('.layui-layer-shade').hide()
                                },
                                content: '<div id="target_detail" style="margin:10px"></div>',
                                success: function () {
                                    var dayReport = '';
                                    
                                    if (!!targetData) {
                                        dayReport += '<table class="layui-table"><tbody>' +
		                                            '<tr>' +
		                                                '<td class="td_title">关键任务编号</td>' +
				                                        '<td colspan="1">'+isShowNull(targetData.tgNo)+'</td>' +
				                                        '<td class="td_title">关键任务名称</td>' +
				                                        '<td colspan="3">'+isShowNull(targetData.tgName)+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">关注等级</td>' +
				                                        '<td colspan="1">'+isShowNull(dictionaryObj['CONTROL_LEVEL']['object'][targetData.controlLevel])+'</td>' +
				                                        '<td class="td_title">周期类型</td>' +
				                                        '<td colspan="3">'+isShowNull(dictionaryObj['PLAN_SYCLE']['object'][targetData.planSycle])+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">关键任务类型</td>' +
				                                        '<td colspan="1">'+isShowNull(dictionaryObj['TG_TYPE']['object'][targetData.tgType])+'</td>' +
				                                        '<td class="td_title">计划阶段</td>' +
				                                        '<td colspan="3">'+isShowNull(dictionaryObj['PLAN_PHASE']['object'][targetData.planStage])+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">设计量</td>' +
				                                        '<td colspan="1">'+isShowNull(targetData.designQuantity)+'</td>' +
				                                        '<td class="td_title">工程量</td>' +
				                                        '<td colspan="3">'+isShowNull(targetData.itemQuantity)+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">单位</td>' +
				                                        '<td colspan="1">'+isShowNull(dictionaryObj['UNIT']['object'][targetData.itemQuantityNuit])+'</td>' +
				                                        '<td class="td_title">完成标准</td>' +
				                                        '<td colspan="3">'+isShowNull(targetData.resultStandard)+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">负责人</td>' +
				                                        '<td colspan="1">'+isShowNull(targetData.dutyUserName).replace(/,$/, '')+'</td>' +
				                                        '<td class="td_title">中心责任部门</td>' +
				                                        '<td colspan="3">'+isShowNull(targetData.mainCenterDeptName).replace(/,$/, '')+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">计划开始时间</td>' +
				                                        '<td>'+
	                                                        function(){
                                                                if (targetData.planStartDate) {
                                                                    return format(targetData.planStartDate)
                                                                } else {
                                                                    return ''
                                                                }
                                                            }() +
	                                                    '</td>' +
				                                        '<td class="td_title">计划结束时间</td>' +
				                                        '<td>'+
		                                                    function(){
                                                                if (targetData.planEndDate) {
                                                                    return format(targetData.planEndDate)
                                                                } else {
                                                                    return ''
                                                                }
                                                            }() +
	                                                    '</td>' +
		                                                '<td class="td_title">计划工期</td>' +
				                                        '<td>'+isShowNull(targetData.planContinuedDate)+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">实际开始时间</td>' +
				                                        '<td>'+
	                                                        function(){
                                                                if (targetData.realStartDate) {
                                                                    return format(targetData.realStartDate)
                                                                } else {
                                                                    return ''
                                                                }
                                                            }() +
	                                                    '</td>' +
				                                        '<td class="td_title">实际结束时间</td>' +
				                                        '<td>'+
		                                                    function(){
                                                                if (targetData.realEndDate) {
                                                                    return format(targetData.realEndDate)
                                                                } else {
                                                                    return ''
                                                                }
                                                            }() +
	                                                    '</td>' +
		                                                '<td class="td_title">实际工期</td>' +
				                                        '<td>'+isShowNull(targetData.realContinuedDate)+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">区域责任部门</td>' +
				                                        '<td colspan="1">'+isShowNull(targetData.mainAreaDeptName).replace(/,$/, '')+'</td>' +
				                                        '<td class="td_title">总承包部责任部门</td>' +
				                                        '<td colspan="3">'+isShowNull(targetData.mainProjectDeptName).replace(/,$/, '')+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">难度系数</td>' +
				                                        '<td>'+isShowNull(targetData.hardDegree)+'</td>' +
		                                                '<td class="td_title">风险点</td>' +
				                                        '<td>'+isShowNull(targetData.riskPoint)+'</td>' +
				                                        '<td class="td_title">难度点</td>' +
				                                        '<td>'+isShowNull(targetData.difficultPoint)+'</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">成果标准模板</td>' +
				                                        '<td colspan="5">'+
				                                            function () {
				                                                if (!!targetData.attachments2 && targetData.attachments2.length > 0) {
				                                                    var str = '';
				
				                                                    targetData.attachments2.forEach(function (item) {
				                                                        var attachName = item.attachName;
				                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
				                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
				                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
				                                                        var attachmentUrl = item.attUrl;
				                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字
				
				                                                        fileExtension = fileExtension.toLowerCase();
				
				                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
				                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
				                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
				                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
				                                                                } else {
				                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
				                                                                }
				                                                            }() +
				                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
				                                                            + '</div>' +
				                                                            '</div>'
				                                                    });
				
				                                                    return str;
				                                                } else {
				                                                    return '';
				                                                }
				                                            }() +
	                                                    '</td>' +
	                                                '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">异常原因</td>' +
		                                                '<td colspan="5">'+isShowNull(targetData.unusualRes)+'</td>' +
		                                            '</tr>' +
		                                            '<tr>' +
		                                                '<td class="td_title">异常原因材料</td>' +
				                                        '<td colspan="5">'+
				                                            function () {
				                                                if (!!targetData.attachments3 && targetData.attachments3.length > 0) {
				                                                    var str = '';
				
				                                                    targetData.attachments3.forEach(function (item) {
				                                                        var attachName = item.attachName;
				                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
				                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
				                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
				                                                        var attachmentUrl = item.attUrl;
				                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字
				
				                                                        fileExtension = fileExtension.toLowerCase();
				
				                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
				                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
				                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
				                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
				                                                                } else {
				                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
				                                                                }
				                                                            }() +
				                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
				                                                            + '</div>' +
				                                                            '</div>'
				                                                    });
				
				                                                    return str;
				                                                } else {
				                                                    return '';
				                                                }
				                                            }() +
	                                                    '</td>' +
	                                                '</tr>' +
												'<tr>' +
												'<td class="td_title">编制依据附件</td>' +
												'<td colspan="5">'+
												function () {
													if (!!targetData.attachments4 && targetData.attachments4.length > 0) {
														var str = '';

														targetData.attachments4.forEach(function (item) {
															var attachName = item.attachName;
															var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
															var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
															var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
															var attachmentUrl = item.attUrl;
															attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

															fileExtension = fileExtension.toLowerCase();

															str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
																	'<div class="operationDiv" style="top: -50px;">' + function () {
																		if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
																			return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																		} else {
																			return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																		}
																	}() +
																	'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
																	+ '</div>' +
																	'</div>'
														});

														return str;
													} else {
														return '';
													}
												}() +
												'</td>' +
												'</tr>' +
	                                            '</tbody>' +
	                                        '</table>'
                                    }
                                    
                                    $('#target_detail').html(dayReport);
                                }
                            });
	                    });
                    });
                    
                    //查看子任务填报详情
                    $(document).on('click', '.task_detail', function () {
                    var planItemId = $(this).attr('planItemId')
                    $.ajax({
                        url: '/ProjectDaily/selectProjectDailyByItemId',
                        dataType: 'json',
                        type: 'get',
                        data: {planItemId: planItemId},
                        success: function (res) {
                            var taskData = res.object;
                            
                            layer.open({
                                type: 1,
                                title: '子任务详情',
                                area: ['70%', '90%'],
                                maxmin: true,
                                min: function () {
                                    $('.layui-layer-shade').hide()
                                },
                                content: '<div id="task_detail" style="margin:10px"></div>',
                                success: function () {
                                    var dayReport = '';

                                    if (!!taskData) {
                                        dayReport += '<table class="layui-table">\n' +
                                            '  <tbody>\n' +
                                            '    <tr>\n' +
                                            '      <td class="td_title">编号</td>\n' +
                                            '      <td colspan="1">' + isShowNull(taskData.taskNo) + '</td>\n' +
                                            '      <td class="td_title">上级子任务名称</td>\n' +
                                            '      <td colspan="3" class="topItemDetail"></td>\n' +
                                            '    </tr>\n' +
                                            '    <tr>\n' +
                                            '      <td class="td_title">子任务名称</td>\n' +
                                            '      <td colspan="1">' + isShowNull(taskData.taskName) + '</td>\n' +
                                            '      <td class="td_title">关联关键任务</td>\n' +
                                            '      <td colspan="3">' + function () {
                                                var tgIds = ''
                                                if (taskData.tgIds) {
                                                    taskData.tgIds.forEach(function (item) {
                                                        tgIds += item.tgName + ','
                                                    })
                                                    return tgIds.replace(/,$/, '')
                                                } else {
                                                    return ''
                                                }
                                            }() + '</td>\n' +
                                            '    </tr>\n' +
                                            '    <tr>\n' +
                                            '      <td class="td_title">周期类型</td>\n' +
                                            '      <td colspan="1">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][taskData.planSycle]) + '</td>\n' +
                                            '      <td class="td_title">任务来源</td>\n' +
                                            '      <td colspan="3">' + isShowNull(dictionaryObj['RENWUJIHUA_TYPE']['object'][taskData.taskType]) + '</td>\n' +
                                            '    </tr>\n' +
                                            '    <tr>\n' +
                                            '      <td class="td_title">负责人</td>\n' +
                                            '      <td colspan="1">' + isShowNull(taskData.dutyUserName.replace(/,$/, '')) + '</td>\n' +
                                            '      <td class="td_title">所属部门</td>\n' +
                                            '      <td colspan="3">' + isShowNull(taskData.mainCenterDeptName.replace(/,$/, '')) + '</td>\n' +
                                            '    </tr>\n' +
                                            '    <tr>\n' +
                                            '      <td class="td_title">计划开始时间</td>\n' +
                                            '      <td>' + function () {
                                                if (taskData.planStartDate) {
                                                    return format(taskData.planStartDate)
                                                } else {
                                                    return ''
                                                }
                                            }() + '</td>\n' +
                                            '      <td class="td_title">计划结束时间</td>\n' +
                                            '      <td>' + function () {
                                                if (taskData.planEndDate) {
                                                    return format(taskData.planEndDate)
                                                } else {
                                                    return ''
                                                }
                                            }() + '</td>\n' +
		                                        '      <td class="td_title">计划工期</td>\n' +
                                            '      <td>' + isShowNull(taskData.planContinuedDate) + '</td>\n' +
                                            '    </tr>\n' +
		                                        '    <tr>\n' +
                                            '      <td class="td_title">实际开始时间</td>\n' +
                                            '      <td>' + function () {
                                                if (taskData.realStartDate) {
                                                    return format(taskData.realStartDate)
                                                } else {
                                                    return ''
                                                }
                                            }() + '</td>\n' +
                                            '      <td class="td_title">实际结束时间</td>\n' +
                                            '      <td>' + function () {
                                                if (taskData.realEndDate) {
                                                    return format(taskData.realEndDate)
                                                } else {
                                                    return ''
                                                }
                                            }() + '</td>\n' +
		                                        '      <td class="td_title">实际工期</td>\n' +
                                            '      <td>' + isShowNull(taskData.realContinuedDate) + '</td>\n' +
                                            '    </tr>\n' +
                                            '    <tr>\n' +
                                            '      <td class="td_title">前置子任务</td>\n' +
                                            '      <td colspan="1">' + function () {
                                                var preTasks = ''
                                                if (taskData.preTasks) {
                                                    taskData.preTasks.forEach(function (item) {
                                                        preTasks += item.workItemName + ','
                                                    })
                                                    return preTasks.replace(/,$/, '')
                                                } else {
                                                    return ''
                                                }
                                            }() + '</td>\n' +
		                                        '      <td class="td_title">完成标准</td>\n' +
                                            '      <td colspan="3">' + isShowNull(taskData.resultStandard) + '</td>\n' +
                                            '    </tr>\n' +
                                            '    <tr>\n' +
                                            '      <td class="td_title">子任务描述</td>\n' +
                                            '      <td colspan="1">' + isShowNull(taskData.taskDesc) + '</td>\n' +
                                            '      <td class="td_title">协助部门</td>\n' +
                                            '      <td colspan="3">' + function () {
                                                if (taskData.assistCompanyDeptsName) {
                                                    return isShowNull(taskData.assistCompanyDeptsName.replace(/,$/, ''))
                                                } else {
                                                    return ''
                                                }
                                            }() + '</td>\n' +
                                            '    </tr>\n' +
		                                        '    <tr>\n' +
                                            '      <td class="td_title">成果标准模板</td>\n' +
                                            '      <td colspan="5">' + function () {
                                                if (!!taskData.attachments2 && taskData.attachments2.length > 0) {
                                                    var str = '';

                                                    taskData.attachments2.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }()+'</td>\n' +
                                            '    </tr>\n' +
		                                        '    </tr>\n' +
		                                        '    <tr>\n' +
                                            '      <td class="td_title">异常原因</td>\n' +
                                            '      <td colspan="5">' + isShowNull(taskData.unusualRes) + '</td>\n' +
                                            '    </tr>\n' +
		                                        '    <tr>\n' +
                                            '      <td class="td_title">异常原因材料</td>\n' +
                                            '      <td colspan="5">' + function () {
                                                if (!!taskData.attachments3 && taskData.attachments3.length > 0) {
                                                    var str = '';

                                                    taskData.attachments3.forEach(function (item) {
                                                        var attachName = item.attachName;
                                                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                                        var attachmentUrl = item.attUrl;
                                                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                                        fileExtension = fileExtension.toLowerCase();

                                                        str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
                                                            '<div class="operationDiv" style="top: -50px;">' + function () {
                                                                if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                } else {
                                                                    return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
                                                                }
                                                            }() +
                                                            '<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
                                                            + '</div>' +
                                                            '</div>'
                                                    });

                                                    return str;
                                                } else {
                                                    return '';
                                                }
                                            }()+'</td>\n' +
                                            '    </tr>\n' +
		                                        '    <tr>\n' +
                                            '      <td class="td_title">难度点</td>\n' +
                                            '      <td colspan="1">' + isShowNull(taskData.difficultPoint) + '</td>\n' +
	                                        '      <td class="td_title">风险点</td>\n' +
                                            '      <td colspan="3">' + isShowNull(taskData.riskPoint) + '</td>\n' +
                                            '    </tr>\n' +
												'    <tr>\n' +
												'      <td class="td_title">编制依据附件</td>\n' +
												'      <td colspan="5">' + function () {
													if (!!taskData.attachments4 && taskData.attachments4.length > 0) {
														var str = '';

														taskData.attachments4.forEach(function (item) {
															var attachName = item.attachName;
															var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
															var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
															var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
															var attachmentUrl = item.attUrl;
															attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

															fileExtension = fileExtension.toLowerCase();

															str += '<div class="divShow"><a href="javascript:;" title="' + item.attachName + '" style="display: block; overflow: hidden;text-overflow: ellipsis;color: blue;">' + item.attachName + '</a>' +
																	'<div class="operationDiv" style="top: -50px;">' + function () {
																		if (fileExtension == 'pdf' || fileExtension == 'png' || fileExtension == 'jpg' || fileExtension == 'txt') { //判断是否需要查阅
																			return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + encodeURI(attachmentUrl) + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																		} else {
																			return '<a class="operation yulan"  href="javascript:void(0);" data-url="' + attachmentUrl + '" style="display: block;padding: 5px;"><img src="/img/attachmentIcon/icon_skim.png" style="margin-right: 5px;" alt="">查阅</a>'
																		}
																	}() +
																	'<a class="operation" style="display: block;padding: 0 5px 5px 5px;" href="/download?' + encodeURI(attachmentUrl) + '"><img src="/img/attachmentIcon/icon_down.png" style="margin-right: 5px;" alt="">下载</a>'
																	+ '</div>' +
																	'</div>'
														});

														return str;
													} else {
														return '';
													}
												}()+'</td>\n' +
												'    </tr>\n' +
                                            '  </tbody>\n' +
                                            '</table>';
                                    }
	                                
                                    $('#task_detail').html(dayReport);
                                }
                            })
                        }
                    })
                });

                    /**
                     * 渲染关键任务、子任务列表方法
                     * @param type (1-主项关键任务，2-职能关键任务，3-计划子任务)
                     * @param id (type为1时，id为所属项目id;type为2和3时，id为所属部门id)
                     * @param fn (回调函数)
                     */
                    function initTaskTable(type, searchData, fn) {
                        //type--1主项 2职能 3子任务
                        if (type == 1) {
                            var cols = [[
								{type: 'checkbox'},
	                            {type: 'numbers', title: '序号', align: 'left', width: 100},
	                            // {type: 'numbers', title: '序号', align: 'left', width: 200},
                                // {
                                //     field: 'tgNo', title: '编号', minWidth: 200, templet: function (d) {
                                //         if (d.projectNo) {
                                //             return '<span>' + d.projectNo + '</span>'
                                //         } else if (d.bagNumber) {
                                //             return '<span>' + d.bagNumber + '</span>'
                                //         } else if (d.tgNo) {
                                //             return '<span>' + d.tgNo + '</span>'
                                //         } else {
                                //             return ''
                                //         }
                                //     }
                                // },
                                {
                                    field: 'tgName', title: '子项目/关键任务名称', event: 'tgDetail', minWidth: 400, templet: function (d) {
                                        if (d.projectName) {
                                            return '<span id="projectName" projectName="'+d.projectName+'" projectId="'+d.projectId+'"><a>【项目】</a>' + d.projectName + '</span>'
                                        } else if (d.pbagName) {
                                            return '<span><a>【子项目】</a>' + d.pbagName + '</span>'
                                        } else if (d.tgName) {
                                        	if(d.revision==1){
												return '<span style="color: red;cursor: pointer;" class="tg_detail" tgId="'+d.tgId+'">【关键任务】' + d.tgName + '</span>'
											}else{
												return '<span style="color: blue;cursor: pointer;" class="tg_detail" tgId="'+d.tgId+'">【关键任务】' + d.tgName + '</span>'
											}
                                        } else {
                                            return ''
                                        }
                                    }
                                },
								{
									field: 'planContinuedDate', title: '计划工期', minWidth: 100, templet: function (d) {
										var str = '';

										if (!!d.tgId) {
											str = d.planContinuedDate || '';
										} else if (!!d.pbagId) {
											str = d.planPeriod || '';
										} else if (!!d.projectId) {
											str = timeRange(d.startTime, d.endTime);
										}

										return str;
									}
								}
								, {
									field: 'planStartDate', title: '计划开始时间', minWidth: 130, templet: function (d) {
										var str = '';
										if (!!d.tgId) {
											str = format(d.planStartDate || '');
										} else if (!!d.pbagId) {
											str = format(d.planBeginDate || '');
										} else if (!!d.projectId) {
											str = format(d.statrtTime || '');
										}
										return str;
									}
								}
								, {
									field: 'planEndDate', title: '计划完成时间', minWidth: 130, templet: function (d) {
										var str = '';
										if (!!d.tgId) {
											str = format(d.planEndDate);
										} else if (!!d.pbagId) {
											str = format(d.planEndDate);
										} else if (!!d.projectId) {
											str = format(d.endTime);
										}
										return str;
									}
								},
                                {
                                    field: 'controlLevel',
                                    title: '关注等级',
                                    width: 150,
                                    templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
											return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                                        }
                                    }
                                }
                                , {
                                    field: 'planSycle', title: '周期类型', minWidth: 100, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'tgType', title: '关键任务类型', minWidth: 100, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return dictionaryObj['TG_TYPE']['object'][d.tgType] || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'planStage', title: '计划阶段', minWidth: 100, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'designQuantity', title: '设计量', minWidth: 100, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return d.designQuantity || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'itemQuantity', title: '工程量', minWidth: 100, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return d.itemQuantity || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'itemQuantityNuit', title: '单位', minWidth: 100, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'dutyUserName', title: '责任人', minWidth: 100, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return d.dutyUserName || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'mainCenterDeptName', title: '中心责任部门', minWidth: 150, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return (d.mainCenterDeptName || '').replace(/,$/, '');
                                        }
                                    }
                                }
								, {
									field: 'mainAreaDeptName', title: '区域责任部门', minWidth: 150, templet: function (d) {
										// return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
										if (d.tgId == '' || d.tgId == undefined) {
											return '';
										} else {
											return (d.mainAreaDeptName || '').replace(/,$/, '');
										}
									}
								}
								, {
									field: 'mainProjectDeptName', title: '总承包部责任部门', minWidth: 150, templet: function (d) {
										// return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
										if (d.tgId == '' || d.tgId == undefined) {
											return '';
										} else {
											return (d.mainProjectDeptName || '').replace(/,$/, '');
										}
									}
								}
                                , {
                                    field: 'resultStandard', title: '完成标准', minWidth: 150, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return d.resultStandard || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'riskPoint', title: '风险点', minWidth: 130, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return d.riskPoint || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'resultDict', title: '成果标准模板', minWidth: 150, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            var resultDictName = '';
                                            if (!!d.resultDict) {
                                                var resultDictList = d.resultDict.split(',');

                                                resultDictList.forEach(function (item) {
                                                    resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                                });
                                            }

                                            return resultDictName.replace(/,$/, '');
                                        }
                                    }
                                }
                                , {
                                    field: 'difficultPoint', title: '难度点', minWidth: 130, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return d.difficultPoint || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'tgDesc', title: '关键任务描述', minWidth: 150, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return d.tgDesc || '';
                                        }
                                    }
                                }
								, {field: 'hardDegree', title: '难度系数', minWidth: 150}
                            ]]
                            var childName = "children"
                        } else if (type == 2) {
                            var cols = [[ //表头
								{type: 'checkbox'},
                                {type: 'numbers', title: '序号', align: 'left', width: 100}
                                , {field: 'tgName', title: '关键任务名称', minWidth: 400, templet: function(d){
										if(d.revision==1){
											return '<span style="color: red;cursor: pointer;" class="tg_detail" tgId="'+d.tgId+'">' + d.tgName + '</span>'
										}else{
											return '<span style="color: blue;cursor: pointer;" class="tg_detail" tgId="'+d.tgId+'">' + d.tgName + '</span>'
										}
		                            }}
								, {field: 'planContinuedDate', title: '计划工期', minWidth: 100}
								, {field: 'planStartDate', title: '计划开始时间', minWidth: 130}
								, {field: 'planEndDate', title: '计划完成时间', minWidth: 130}
                                , {
                                    field: 'planSycle', title: '周期类型', minWidth: 100, templet: function (d) {
                                        return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                                    }
                                }
                                , {
                                    field: 'tgType', title: '关键任务类型', minWidth: 100, templet: function (d) {
                                        return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                                    }
                                }
                                , {field: 'dutyUserName', title: '责任人', minWidth: 100}
                                , {
                                    field: 'mainCenterDeptName', title: '所属部门', minWidth: 150, templet: function (d) {
                                        return '<span class="mainCenterDeptId" mainCenterDept="'+d.mainCenterDept+'">'+(d.mainCenterDeptName || '').replace(/,$/, '')+'</span>'
                                    }
                                }
                                , {field: 'resultStandard', title: '完成标准', minWidth: 100}
                                , {field: 'riskPoint', title: '风险点', minWidth: 130}
                                , {
                                    field: 'resultDict', title: '成果标准模板', minWidth: 150, templet: function (d) {
                                        var resultDictName = '';
                                        if (!!d.resultDict) {
                                            var resultDictList = d.resultDict.split(',');

                                            resultDictList.forEach(function (item) {
                                                resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                            });
                                        }

                                        return resultDictName.replace(/,$/, '');
                                    }
                                }
                                , {field: 'difficultPoint', title: '难度点', minWidth: 130}
                                , {field: 'tgDesc', title: '关键任务描述', minWidth: 150}
                                , {field: 'hardDegree', title: '难度系数', minWidth: 150}
                            ]]
                            var childName = "children"
                        } else if (type == 3) {
                            var cols = [[
								{type: 'checkbox'},
                                {type: 'numbers', title: '序号', align: 'left', width: 100},
                                {
                                    field: 'taskName',
                                    title: '子任务名称',
                                    minWidth: 400,
	                                templet: function(d) {
                                        return '<span class="task_detail" style="color: blue; cursor: pointer;" planItemId="'+d.planItemId+'">'+d.taskName+'</span>';
	                                }
                                },
								{field: 'planContinuedDate', minWidth: 100, title: '计划工期'},
								{
									field: 'planStartDate', title: '计划开始时间', minWidth: 150, templet: function (d) {
										return format(d.planStartDate)
									}
								},
								{
									field: 'planEndDate', title: '计划结束时间', minWidth: 150, templet: function (d) {
										return format(d.planEndDate)
									}
								},
                                {
                                    field: 'planSycle', title: '周期类型', minWidth: 100, templet: function (d) {
                                        return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                                    }
                                },
                                {
                                    field: 'taskType', title: '任务来源', minWidth: 100, templet: function (d) {
                                        return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || ''
                                    }
                                },
                                // {
                                // 	field: 'planStage', title: '计划阶段',minWidth:100, templet: function (d) {
                                // 		return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                                // 	}
                                // },
                                // {field: 'designQuantity',minWidth:100, title: '设计量'},
                                // {field: 'itemQuantity',minWidth: 100, title: '工程量'},
                                // {
                                // 	field: 'itemQuantityNuit',minWidth: 100, title: '单位', templet: function (d) {
                                // 		return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || ''
                                // 	}
                                // },
                                {field: 'dutyUserName', minWidth: 100, title: '负责人'},
                                {
                                    field: 'mainCenterDeptName', title: '所属部门', minWidth: 150, templet: function (d) {
                                        return (d.mainCenterDeptName || '').replace(/,$/, '');
                                    }
                                },
                                {
                                    field: 'resultStandard', title: '完成标准', minWidth: 150,
                                },
                                {
                                    field: 'preTask', title: '前置子任务', minWidth: 150, templet: function (d) {
                                        var preTasks = ''
                                        if (d.preTasks) {
                                            d.preTasks.forEach(function (item) {
                                                preTasks += item.workItemName + ','
                                            })
                                            return preTasks.replace(/,$/, '').split(',')
                                        }
                                    }
                                },
                                {field: 'riskPoint', title: '风险点', minWidth: 130},
                                {field: 'difficultPoint', title: '难度点', minWidth: 130},
                                {
                                    field: 'taskDesc', title: '子任务描述', minWidth: 150
                                },
								{
                                    field: 'hardDegree', title: '难度系数', minWidth: 150
                                }
                            ]]
                            var childName = "items"
                        }
						insTb=treeTable.render({
                            elem: '#theChildPlan'
                            , url: '/plcPlan/selectByPlanId'
                            , where: searchData
                            , toolbar: '#childDemo'
							, height: 'full-200'
                            , tree: {
                                iconIndex: 1,
                                idName: 'planItemId',
                                childName: childName
                            }
                            , cols: cols
                            , parseData: function (res) { //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.object //解析数据列表
                                };
                            },
							done:function (res) {
                                // console.log(res);
                                var tabIndex = $('#tabIndex').val();
                                if (tabIndex == 1) {
                                    //判断是主项还是职能
                                    if (res.length > 0 && res[0].projectId) {
                                        $('#projectId').val(res[0].projectId);
                                    }
                                }
							}
                        });
                        if (fn) {
                            fn();
                        }
                    }

                    //子表-表标点击事件
                    $(document).on('click', '.titleSp', function () {
                        $('.theChildBox').hide();
                        $('.theParentBox').show();
                    });

                    table.on('toolbar(reportedTable)', function (obj) {
                        var checkStatus = table.checkStatus(obj.config.id);
                        switch (obj.event) {
                            case 'report':
                                if (checkStatus.data.length == 0) {
                                    layer.msg('最少选中一项!', {icon: 0, time: 1000});
                                    return false;
                                }
								layer.open({
									type: 1,
									title: '上报',
									area: ['30%', '30%'],
									maxmin:true,
									min: function(){
										$('.layui-layer-shade').hide()
									},
									btn:['确定','取消'],
									content: '<div class="layui-form">\n' +
											'<div class="layui-form-item" style="margin-top: 25px;">\n' +
											'    <div class="layui-input-block" style="margin-left: 110px;">\n' +
											'      <input type="checkbox" name="remind" title="事务提醒" lay-skin="primary" checked>\n' +
											'      <input type="checkbox" name="smsRemind" title="短信提醒"  lay-skin="primary">\n' +
											'    </div>\n' +
											'  </div>'+
											'</div>',
									success:function () {
										form.render()
									},
									yes:function (index) {
										var remind
										var smsRemind
										if($('input[name="remind"]').prop('checked')){
											remind=1
										}else{
											remind=0
										}
										if($('input[name="smsRemind"]').prop('checked')){
											smsRemind=1
										}else{
											smsRemind=0
										}
										var ids = '';
										checkStatus.data.forEach(function (item) {
											ids += item.planId + ',';
										});
										var year = new Date().getFullYear();
										var month = new Date().getMonth()+1;
										var day = new Date().getDate();
										if (month < 10) {
											month = "0" + month;
										}
										if (day < 10) {
											day = "0" + day;
										}
										var today = year+"-" + month + "-" + day;
										$.post('/plcPlan/updateStatusByIds', {
											planIds: ids,
											apprivalStatus: 1,
											remind:remind,
											smsRemind:smsRemind,
											reportDate:today
										}, function (res) {
											if (res.flag) {
												layer.close(index);
												layer.msg('上报成功', {icon: 1, time: 1000});
												reportedTable.config.where._ = new Date().getTime();
												reportedTable.reload();
											} else {
												layer.msg('上报失败', {icon: 2, time: 1000});
											}
										});
									}
								})
                                break;
	                        case 'delete':
	                             if (checkStatus.data.length != 1) {
                                    layer.msg('请选择一项删除的数据!', {icon: 0, time: 1000});
                                    return false;
                                }

                                layer.confirm('是否删除选中数据？', function (index) {
                                    var ids = checkStatus.data[0].planId;
                                    $.post('/plcPlan/delPlcPlan', {
                                        planId: ids
                                    }, function (res) {
                                        if (res.flag) {
                                            layer.close(index);
                                            layer.msg('删除成功', {icon: 1, time: 1000});
                                            reportedTable.config.where._ = new Date().getTime();
                                            reportedTable.reload();
                                        } else {
                                            layer.msg('删除失败', {icon: 2, time: 1000});
                                        }
                                    });
                                });
	                            break;
                        }
                    });

					treeTable.on('toolbar(theChildPlan)', function (obj)  {
						// console.log(obj);
						switch (obj.event) {
							case 'add':
								//判断是主项关键任务还是职能关键任务
								var planClass=$('#planClass').val();
								if(planClass==1){
									newAndEdit(1);
								}else if(planClass==2){
									addOrEdit(1);
								}
								break;
							case 'edit':
								//判断该数据是否是计划调整过的新增的数据
								if(insTb.checkStatus().length == 1 && insTb.checkStatus()[0].revision == 1){
									//判断是主项关键任务还是职能关键任务
									var planClass=$('#planClass').val();
									if(planClass==1){
										newAndEdit(2,insTb.checkStatus()[0]);
									}else if(planClass==2){
										addOrEdit(2);
									}
								}else{
									layer.msg('请选择一项计划调整过的新增的关键任务！', {icon: 0, time: 1000});
									return false
								}
								break;
							case 'revision':
								var ids = '';
								insTb.checkStatus().forEach(function (v, i) {
									if (v.tgId) {
										ids += (v.tgId) + ',';
									}
								});
								if (!ids) {
									layer.msg('请至少选择一项关键任务！', {icon: 0, time: 1000});
									return false
								}

                                /*for (var i = 0; i < insTb.checkStatus().length; i++) {
                                    if (insTb.checkStatus()[i].taskStatus == 5 || insTb.checkStatus()[i].taskStatus == 6) {
                                        var str = insTb.checkStatus()[i].tgName
                                        layer.msg('任务['+str+']已完成，不可修编！', {icon: 0, time: 1000});
                                        return false;
                                    }
                                }*/
								$.get('/projectTarget/checkRevision',{tgIds:ids},function (res) {
									if(res=='1'){
										openRevision(ids);
									}else{
										layer.msg('任务已完成，不可修编！', {icon: 0, time: 1000});
										return false;
									}
								})
								break;
							case 'revisionDetail':
								var ids = '';
								insTb.checkStatus().forEach(function (v, i) {
									if (v.tgId) {
										ids += (v.tgId) + ',';
									}
								});
								if (!ids) {
									layer.msg('请至少选择一项关键任务！', {icon: 0, time: 1000});
									return false
								}
								openRevisionDetail(ids)
								break;
							case 'planModify':
								var taskApproval = $('#allTgId').attr('taskApproval')
								if(taskApproval==2){
									/*主项关键任务*/
									var projectName = $('#projectName').attr('projectName');
									var projectId=$('#projectName').attr('projectId') || '';
									/*职能关键任务*/
									var projOrgId = $('#allTgId').attr('belongtoDept')
									var belongtoDeptName = $('#allTgId').attr('belongtoDeptName');
									/*关键任务id*/
									var tgId=$('#allTgId').attr('tgIds')
									if(tgId){
										if(projectId){
											reportPlan(projectId, projectName,tgId);
										}else{
											reportPlanDept(projOrgId,tgId,belongtoDeptName);
										}
									}else{
										layer.msg('该项目下暂无关键任务可提交！', {icon: 0});
										return false
									}
								}else{
									layer.msg('该计划还未被同意！', {icon: 0});
									return false
								}
								break;
							case 'export':
								insTb.exportData('csv');
							    break;
							case 'initialization':
								if(insTb.checkStatus().length == 1 && !insTb.checkStatus()[0].tgId){
									initProjectPlan(insTb.checkStatus()[0]);
								}else{
									layer.msg('请选择一项项目或者子项目进行导入！', {icon: 0});
								}
								break;
						}
					});

					/***
					 * 初始化主项计划
					 * @param obj (所选项目或子项目对应数据)
					 */
					function initProjectPlan(obj) {
						var projectItemTable = null;
						layer.open({
							type: 1,
							title: '主项关键任务-初始化',
							btn: ['保存', '退出'],
							area: ['60%', '85%'],
							maxmin: true,
							content: '<div style="position: relative;height: 100%; width: 100%;padding: 5px 10px;box-sizing: border-box;">' +
									'<div class="target_module" style="position: relative;float: left;height: 100%; width: 230px;">' +
									'<h3 style="padding: 10px 15px; text-align: center;">关键任务模板</h3>' +
									'<div class="eleTree target_module_tree" lay-filter="targetModuleTree"></div>' +
									'</div>' +
									'<div class="project_item">' +
									'<h3 style="padding: 10px 15px; text-align: center;">关键任务选择</h3>' +
									'<div>' +
									'<table id="projectItemTable" lay-filter="projectItemTable"></table>' +
									'</div>' +
									'</div>' +
									'</div>',
							success: function () {
								// 初始化左侧关键任务模板树
								/*限制显示哪个层级*/
								var level=obj.LAY_INDEX.split('-').length
								var targetModuleTree = eleTree.render({
									elem: '.target_module_tree',
									url: '/TemplateType/findAllShow?level='+level,
									highlightCurrent: true,
									showLine: true,
									request: {
										name: "typeName", // 显示的内容
										key: "tplTypeId", // 节点id
										children: "son",
									},
									response: {
										statusName: 'flag',
										statusCode: true,
										dataName: "object"
									},
								});

								// 模板树节点点击
								eleTree.on("nodeClick(targetModuleTree)", function (d) {
									// console.log(d.data.currentData)
									//判断如果是最高父级，则展示该父级下所有关键任务
									if (d.data.currentData.parentTypeId == 0) {
										$('.project_item').hide()
									} else {
										$('.project_item').show()
										projectItemTable = table.render({
											elem: '#projectItemTable',
											url: '/TemplateItem/findTemplateByTypeId',
											// page: true,
											cols: [[
												{type: 'checkbox'},
												{
													field: 'tgName', align: 'left', title: '关键任务名称', templet: function (d) {
														return '<span  class="initTgId" tgId="' + d.tgId + '" >' + d.tgName + '</span>'
													}
												}
											]],
											where: {
												typeId: d.data.currentData.tplTypeId,
												useFlag: false
											},
											response: {
												statusName: 'flag',
												statusCode: true,
												msgName: 'msg',
												// countName: 'totleNum',
												dataName: 'obj'
											},
											done: function (res) {
												// console.log(res)
												// $('#projectItemTable').next().find('.layui-table-header').remove()
												//选中的回显
												$('.initTgId').each(function (index) {
													tgIdsArr.forEach(function (v, i) {
														if ($('.initTgId').eq(index).attr('tgid') == v) {
															$('.initTgId').eq(index).parents('td').prev().find('input').prop('checked', 'true')
															form.render()
														}
													})
												})
												//被强制勾选的回显且不可取消
												var data = res.obj
												data.forEach(function (item, index) {
													if (item.forceCheck == 1) {
														// tgIdsArr.push(item.tgId)
														$('.initTgId[tgid="' + item.tgId + '"]').parents('td').prev().find('input').prop('checked', 'true').attr('disabled', 'disabled')
														form.render()
													}
												})
												// console.log(tgIdsArr)
											}
										});
									}
								});
							},
							yes: function (index) {
								var tgIdsArr = []
								$('#projectItemTable').next().find('.layui-table-body .layui-table tr .layui-form-checked').each(function () {
									var tgId = $(this).parents('td').next().find('.initTgId').attr('tgId')
									tgIdsArr.push(tgId)
								})
								// console.log(tgIdsArr)
								if (tgIdsArr.length > 0) {
									var loadingIndex = layer.load();
									var workItemTgId = '';
									var data = {}
									workItemTgId = tgIdsArr.join() + ',';

									if(obj.pbagId){
										data.pbagIds=obj.pbagId+','
										data.projectId=obj.projectId
									}else{
										data.projectId=obj.projectId
									}

									data.workItemTgId = workItemTgId;
									data.pTargetLevel = obj.LAY_INDEX.split('-').length;

									data.planId = $('#planId').val();

									data.revision = 1;

									$.post('/projectTarget/initializePlus', data, function (res) {
										layer.close(loadingIndex);
										if (res.flag) {
											layer.close(index);
											layer.msg('初始化成功！', {icon: 1, time: 1000});
											var title = $('.titleSp').html();
											insTb.reload({
												done: function() {
													$('.titleSp').html(title);
												}
											})
										} else {
											layer.msg('初始化失败！', {icon: 2, time: 1000});
										}
									});
								} else {
									layer.msg('请选择关键任务', {icon: 0, time: 1000});
								}
							}
						});
					}
					//新增主项关键任务
					function newAndEdit(type, data) {
						var title = '';
						var url = '';
						if (type === 1) {
							title = '新增主项关键任务';
							url = '/plcPlan/addTgAndItem?deptOrProject=0';
						} else if (type === 2) {
							title = '编辑主项关键任务';
							url = '/projectTarget/update';
						}

						layer.open({
							type: 1,
							title: title,
							area: ['100%', '100%'],
							maxmin: true,
							min: function () {
								$('.layui-layer-shade').hide();
							},
							btn: ['保存','取消'],
							content: ['<form class="layui-form" id="newOrEditForm" lay-filter="formTest">' +
									//第一行
									'<div class="layui-row" style="margin-top:15px;">' +
									'<div class="newAndEdit layui-col-xs6" > <div class="layui-form-item" >\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="tgNo">*</span>编号</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="tgNo" readonly autocomplete="off" class="layui-input jinyong" style="width: 93%;display: inline-block;background:#e7e7e7;">\n' +
									'<a class="refresh_no" href="javascript:;" style="display: inline-block;visibility: hidden;color: #1e9fff;">刷新</a>' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="belongId">*</span>所属项目</label>\n' +
									'    <div class="layui-input-block">\n' +
							        ' <input name="belongId" type="hidden" class="client" id="client">'+
									' <input type="text" id="tree" lay-filter="tree" class="layui-input" readonly>'+
									'    </div>\n' +
									'  </div></div>' +
									'</div>' +
									//第二行
									'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="tgName">*</span>关键任务名称</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="tgName"  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div></div>' +
									'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
									'    <label class="layui-form-label">关注等级</label>\n' +
									'    <div class="layui-input-block">\n' +
									// '      <input type="checkbox" name="controlLevel" title="是" lay-skin="primary" checked>'+
									' <select name="controlLevel" lay-verify="required" class="jinyong">\n' +
									'      </select>' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第二行
									'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
									'    <label class="layui-form-label">目标等级</label>\n' +
									'    <div class="layui-input-block">\n' +
									' <select name="tgGrade" lay-verify="required">\n' +
									'      </select>' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第三行
									'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs4"><div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planSycle">*</span>周期类型</label>\n' +
									'    <div class="layui-input-block">\n' +
									' <select name="planSycle" lay-verify="required" class="jinyong">\n' +
									'      </select>' +
									'    </div>\n' +
									'  </div></div>' +
									'<div class="newAndEdit layui-col-xs4">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="tgType">*</span>关键任务类型</label>\n' +
									'    <div class="layui-input-block pbagNature">\n' +
									/*' <select name="tgType" lay-verify="required" class="jinyong">\n' +
									'      </select>' +*/
									'      <input type="text" name="tgType" id="tgType_add" readonly title="关键任务类型" style="background:#e7e7e7;width:77%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
									'      <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="tgTypeAdd">添加</a>\n' +
									'      <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="tgTypeDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planStage">*</span>计划阶段</label>\n' +
									'    <div class="layui-input-block">\n' +
									' <select name="planStage" lay-verify="required" class="jinyong">\n' +
									'      </select>' +
									'    </div>\n' +
									'  </div> </div>' +
									'</div>' +
									//第四行
									'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs4">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">设计量</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="designQuantity"  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">工程量</label>\n' +
									'    <div class="layui-input-block ">\n' +
									'      <input type="text" name="itemQuantity"  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div> </div>' +
									' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">单位</label>\n' +
									'    <div class="layui-input-block">\n' +
									' <select name="itemQuantityNuit" lay-verify="required" class="jinyong">\n' +
									'<option value="">请选择</option>'+
									'      </select>' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第五行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">中心责任部门负责人</label>\n' +
									'    <div class="layui-input-block">\n' +
									'  <textarea  type="text" name="dutyUser" id="dutyUser" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +
									'    </div>\n' +
									'  </div> </div>' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="mainCenterDept">*</span>中心责任部门</label>\n' +
									'    <div class="layui-input-block">\n' +
									'  <textarea  type="text" name="mainCenterDept" id="mainCenterDept" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第六行
									'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">区域责任部门负责人</label>\n' +
									'    <div class="layui-input-block">\n' +
									'  <textarea  type="text" name="mainAreaUser" id="mainAreaUser" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">区域责任部门</label>\n' +
									'    <div class="layui-input-block">\n' +
									'  <textarea  type="text" name="mainAreaDept" id="mainAreaDept" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第七行
									'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">总承包部责任部门负责人</label>\n' +
									'    <div class="layui-input-block">\n' +
									'  <textarea type="text" name="mainProjectUser" id="mainProjectUser" readonly style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">总承包部责任部门</label>\n' +
									'    <div class="layui-input-block">\n' +
									'  <textarea type="text" name="mainProjectDept" id="mainProjectDept" readonly style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9; resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第八行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planStartDate">*</span>计划开始时间</label>\n' +
									'    <div class="layui-input-block appendStartTime">\n' +
									'      <input type="text" class="layui-input jinyong" readonly autocomplete="off" name="planStartDate" id="planStartDate">' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planEndDate">*</span>计划结束时间</label>\n' +
									'    <div class="layui-input-block appendEndTime">\n' +
									'      <input type="text" class="layui-input jinyong" readonly autocomplete="off" name="planEndDate" id="planEndDate">' +
									'    </div>\n' +
									'  </div> </div>' +
									' <div class="newAndEdit layui-col-xs4"><div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planContinuedDate">*</span>计划工期</label>\n' +
									'    <div class="layui-input-inline">\n' +
									'      <input type="text" name="planContinuedDate" style="background-color: #e7e7e7;" readonly  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'<div class="layui-form-mid layui-word-aux">根据开始时间和结束时间自动生成</div>' +
									'  </div></div>' +
									'</div>' +
									//第九行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="resultStandard">*</span>完成标准</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="resultStandard" autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">难度点</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="difficultPoint"  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div> </div>' +
									'</div>' +
									//第十行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">风险点</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="riskPoint"  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="resultDict">*</span>成果标准模板</label>\n' +
									'    <div class="layui-input-block">\n' +
									'<input type="text" name="resultDict" readonly title="成果标准模板" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="resultDictAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="resultDictDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第十一行
									'<div><div class="layui-form-item">' +
									/*此处难度系数对应工作项库的标准难度系数*/
									'    <label class="layui-form-label">难度系数</label>\n' +
									'    <div class="layui-input-block">\n' +
									// '      <input type="number" name="hardDegree"  autocomplete="off" class="layui-input jinyong">\n' +
									' <select name="hardDegree" lay-verify="required"  class="jinyong">\n' +
									'<option value="1">1</option>'+
									'<option value="2">2</option>'+
									'<option value="3">3</option>'+
									'<option value="4">4</option>'+
									'<option value="5">5</option>'+
									'<option value="6">6</option>'+
									'<option value="7">7</option>'+
									'<option value="8">8</option>'+
									'<option value="9">9</option>'+
									'<option value="10">10</option>'+
									'      </select>'+
									'    </div>\n' +
									'</div>' +
									'</div>' +
									//第十二行
									'<div><div class="layui-form-item">' +
									'    <label class="layui-form-label">关键任务描述</label>\n' +
									'    <div class="layui-input-block">\n' +
									'<textarea name="tgDesc"  class="layui-textarea jinyong"></textarea>' +
									'    </div>\n' +
									'</div>' +
									'</div>' +
									//第十二行-----前置关键任务
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs11"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">前置关键任务</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="preTgId" readonly  autocomplete="off" class="layui-input jinyong" style="background:#e7e7e7;">\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									' <div class="newAndEdit layui-col-xs1"> <div class="layui-form-item">\n' +
									'<button type="button" class="layui-btn settings" style="margin-left: 25px">设置</button>'+
									'  </div> </div>' +
									'</div>' +
									//第十三行----关联关键任务
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs12"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">关联关键任务</label>\n' +
									'    <div class="layui-input-block">\n' +
									'<input type="text" name="tgId" readonly style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input jinyong " title="关联关键任务">\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="relationAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="relationDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									'</form>'].join(''),
							success: function () {
								treeSelect.render({
									// 选择器
									elem: '#tree',
									// 数据
									data:'/ProjectInfo/getInfoAndBag?projectId='+$('#projectId').val(),
									// 异步加载方式：get/post，默认get
									type: 'get',
									// 占位符
									placeholder: '请选择',
									// 是否开启搜索功能：true/false，默认false
									// search: true,
									// 一些可定制的样式
									style: {
										folder: {
											enable: true
										},
										line: {
											enable: true
										}
									},
									// 点击回调
									click: function(d){
										var data=d.current
										// console.log(d.current)
										if(data.pbagId){
											$('#client').attr('projectId','');
											$('#client').attr('pbagId',data.pbagId);
											$('#client').val(data.pbagId);
										}else{
											$('#client').attr('projectId',data.projectId);
											$('#client').attr('pbagId','');
											$('#client').val(data.projectId);
										}
										//判断是项目还是子项目
										if(data.statrtTime){
											$('#client').attr('minTime',data.statrtTime);
											$('#client').attr('maxTime',data.endTime);
										}else{
											$('#client').attr('minTime',format(data.planBeginDate));
											$('#client').attr('maxTime',format(data.planEndDate));
										}

										$('#newOrEditForm .appendStartTime #planStartDate').remove()
										$('#newOrEditForm .appendEndTime #planEndDate').remove()
										$('#newOrEditForm .appendStartTime').append('<input type="text" class="layui-input jinyong" readonly autocomplete="off" name="planStartDate" id="planStartDate">')
										$('#newOrEditForm .appendEndTime').append('<input type="text" class="layui-input jinyong" readonly autocomplete="off" name="planEndDate" id="planEndDate">')
										var min=$('#client').attr('minTime')
										var max=$('#client').attr('maxTime')
										// 初始化计划开始时间
										var planStartLaydateConfig = {
											elem: '#planStartDate',
											min:min,
											max:max,
											done: function (value, date) {
												if ($('#planEndDate').val()) {
													var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
													$('input[name="planContinuedDate"]').val(planPeriod);
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
											},
											trigger: 'click' //采用click弹出
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
												if ($('#planStartDate').val()) {
													var planPeriod = !!value ? timeRange($('#planStartDate').val(), value) + '天' : '';
													$('input[name="planContinuedDate"]').val(planPeriod);
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
											},
											trigger: 'click' //采用click弹出
										}
										if (data && data.planStartDate) {
											planEndLaydateConfig.min = data.planStartDate;
										}
										var planEndLaydate = laydate.render(planEndLaydateConfig);
									},
									// 加载完成后的回调函数
									success: function (d) {
										var treeBodyUl=$('.layui-treeSelect-body ul')
										if($('.layui-treeSelect-body').children(":first").children(":first").hasClass('root_close')){
											$('.layui-treeSelect-body').children(":first").children(":first").removeClass('root_close')
											$('.layui-treeSelect-body').children(":first").children(":first").addClass('center_close')
										}
										//选中节点，根据id筛选
										var treeId = $('.layui-treeSelect-body').attr('id')
										treeSelect.checkNode('tree',treeId, data.pbagId ? data.pbagId : data.projectId);
									}
								});
								//设置
								$('.settings').on("click",function () {
									layer.open({
										type: 1,
										title: '前置关键任务',
										area: ['80%', '70%'],
										btn: ['确定', '取消'],
										content:'<div style="margin-top: 15px" class="layui-form" id="targetSet">' +
												'<div class="layui-row" style="text-align: right;margin-right: 2%">' +
												'<div class="layui-col-xs4">' +
												'<div class="layui-form-item">\n' +
												'<label class="layui-form-label">年度:</label>\n' +
												'<div class="layui-input-block">\n' +
												'<select name="year" lay-filter="yearSet">\n' +
												'<option value="">请选择</option>\n' +
												'</select>\n' +
												'</div>\n' +
												'</div>'+
												'</div>'+
												'<div class="layui-col-xs4">' +
												'<div class="layui-form-item">\n' +
												'<label class="layui-form-label">月度:</label>\n' +
												'<div class="layui-input-block">\n' +
												'<select name="month">\n' +
												'</select>\n' +
												'</div>\n' +
												'</div>'+
												'</div>'+
												/*'<div class="layui-col-xs4">' +
												'<div class="layui-form-item">\n' +
												'<label class="layui-form-label">责任部门:</label>\n' +
												'<div class="layui-input-block">\n' +
												'<input type="text" name="mainCenterDept" readonly id="mainCenterDeptSet" autocomplete="off" class="layui-input"  readonly style="background:#e7e7e7;display: inline-block;width: 65%">' +
												'<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_taskSet_dept">添加</span>' +
												'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_taskSet_dept">清空</span>' +
												'</div>\n' +
												'</div>'+
												'</div>'+*/
												'<button type="button" class="layui-btn layui-btn-sm addPreTask">增加</button></div>'+
												'<table class="layui-table preTaskTable" style="width: 98%;margin: 8px">\n' +
												'  <thead>\n' +
												'    <tr>\n' +
												'      <th>关键任务名称</th>\n' +
												'      <th>类型</th>\n' +
												'      <th>延隔时间(天)</th>\n' +
												'    </tr> \n' +
												'  </thead>\n' +
												'  <tbody>\n' +
												'  </tbody>\n' +
												'</table>'+
												'</div>',
										success:function () {
											/***************************************************计划期间年度、月度*******************************************************/
													// 计划期间年度列表
											var allYear = '';
											// 获取计划期间年度列表
											$.get('/planPeroidSetting/selectAllYear', function(res) {
												if (res.object.length > 0) {
													res.object.forEach(function(item){
														allYear += '<option value="'+item.periodYear+'">'+item.periodYear+'</option>'
													});
												}
												$('#targetSet [name="year"]').append(allYear);
												form.render('select');
												//新建时默认年度为当年、月度为当月
												$('#targetSet select[name="year"] option').each(function () {
													var nowYear=new Date().getFullYear()
													if($(this).text()==nowYear){
														$('#targetSet select[name="year"]').val($(this).val())
														form.render()
														getPlanMonth($(this).val(), function (monthSrt) {
															$('#targetSet select[name="month"]').html(monthSrt);
															form.render('select');
															//判断是否存在当月
															var nextMonth=new Date().getMonth()+1
															$('#targetSet select[name="month"] option').each(function () {
																if(parseInt($(this).text())==nextMonth){
																	$('#targetSet select[name="month"]').val($(this).val())
																	form.render()
																}
															})
														});
													}
												})
											});

											// 获取月度
											form.on('select(yearSet)', function (data) {
												if (data.value) {
													getPlanMonth(data.value, function (monthStr) {
														$('#targetSet [name="month"]').html(monthStr);
														form.render('select');
													});
												} else {
													$('#targetSet [name="month"]').html('<option value="">请选择</option>');
													form.render('select');
												}
											});


											if($('#newOrEditForm input[name="preTgId"]').attr('preTgId')){
												$.get('/projectTarget/selectPreShow',{preTgIds:$('#newOrEditForm input[name="preTgId"]').attr('preTgId')},function (res) {
													if(res.flag){
														var data=res.obj
														data.forEach(function (item,index) {
															var str=''
															str+=   '    <tr class="trTask">\n' +
																	'      <td>' +
																	'  <select name="workTargetName" lay-verify="required">\n' +
																	function () {
																		var name=allTarget()
																		return name
																	}()+
																	'      </select>'+
																	'</td>\n' +
																	'      <td>' +
																	'  <select name="pretaskItemType" lay-verify="required">\n' +
																	'        <option value=""></option>\n' +
																	'        <option value="FS">完成-开始(FS)</option>\n' +
																	'        <option value="SS">开始-开始(SS)</option>\n' +
																	'        <option value="FF">完成-完成(FF)</option>\n' +
																	'        <option value="SF">开始-完成(SF)</option>\n' +
																	'      </select>'+
																	'</td>\n' +
																	'      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')"  name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
																	'    </tr>\n'
															$('.preTaskTable tbody').append(str)
															$('.trTask').eq(index).find('select[name="workTargetName"]').val(item.tgId)
															$('.trTask').eq(index).find('select[name="pretaskItemType"]').val(item.pretaskItemType)
															$('.trTask').eq(index).find('input[name="extendDates"]').val(item.extendDates)
															form.render()
														})
													}
												})
											}
											$('.addPreTask').on("click",function () {
												var str=   '    <tr class="trTask">\n' +
														'      <td>' +
														'  <select name="workTargetName" lay-verify="required">\n' +
														function () {
															var year=$('#targetSet select[name="year"]').val() || ''
															var month=$('#targetSet select[name="month"]').val() || ''
															var projectId=$('#projectId').val()
															var name=allTarget(year,month,projectId)
															return name
														}()+
														'      </select>'+
														'</td>\n' +
														'      <td>' +
														'  <select name="pretaskItemType" lay-verify="required">\n' +
														'        <option value=""></option>\n' +
														'        <option value="FS">完成-开始(FS)</option>\n' +
														'        <option value="SS">开始-开始(SS)</option>\n' +
														'        <option value="FF">完成-完成(FF)</option>\n' +
														'        <option value="SF">开始-完成(SF)</option>\n' +
														'      </select>'+
														'</td>\n' +
														'      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')" value="0" name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
														'    </tr>\n'
												$('.preTaskTable tbody').append(str)
												form.render()
											})
										},
										yes:function (index) {
											var arr=[]
											var str=''
											$('.trTask').each(function () {
												if($(this).find('select[name="workTargetName"]').val() && $(this).find('select[name="pretaskItemType"]').val() && $(this).find('input[name="extendDates"]').val()){
													var obj={}
													obj.tgId=$(this).find('select[name="workTargetName"]').val()
													obj.workTargetName=$(this).find('select[name="workTargetName"] option:selected').text()
													obj.pretaskItemType=$(this).find('select[name="pretaskItemType"]').val()
													obj.extendDates=$(this).find('input[name="extendDates"]').val()
													arr.push(obj)
													str+=obj.workTargetName+','
												}
											})
											$.ajax({
												url:'/projectTarget/insertPretask',
												data:JSON.stringify(arr),
												contentType:"application/json;charset=UTF-8",
												dataType:'json',
												type:'post',
												success:function(res){
													if(res.flag){
														$('#newOrEditForm input[name="preTgId"]').attr('preTgId',res.data)
														$('#newOrEditForm input[name="preTgId"]').val(str)
														layer.close(index)
													}
												}
											})
										}
									})
								})

								//关联关键任务
								$('.relationAdd').on("click",function () {
									layer.open({
										type: 2,
										title: '添加关联关键任务',
										area: ['80%', '80%'],
										btn: ['确定', '取消'],
										content:'/projectTarget/relationProjectTarget?projectId='+$('#projectId').val(),
										yes:function (index, layero) {
											var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
											// console.log(iframeWin.leftArr)
											var ids=iframeWin.leftArr.join()
											$.post('/projectTarget/selectByIds',{ids:ids},function (res) {
												if(res.flag){
													var tgId=''
													var tgName=''
													var str='<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 10px;">\n' +
															'  <thead>\n' +
															'    <tr>\n' +
															'      <th>关键任务名称</th>\n' +
															'      <th>关注等级</th>\n' +
															'      <th>计划开始时间</th>\n' +
															'      <th>计划结束时间</th>\n' +
															'      <th>完成标准</th>\n' +
															'      <th>关键任务描述</th>\n' +
															'    </tr> \n' +
															'  </thead>\n' +
															'  <tbody>\n'
													res.obj.forEach(function (v,i) {
														tgId+=v.tgId+','
														tgName+=v.tgName+','
														str+= '<tr>\n' +
																'<td>'+isShowNull(v.tgName)+'</td>\n' +
																'<td>'+(dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '')+'</td>\n' +
																'<td>'+isShowNull(v.planStartDate)+'</td>\n' +
																'<td>'+isShowNull(v.planEndDate)+'</td>\n' +
																'<td>'+isShowNull(v.resultStandard)+'</td>\n' +
																'<td>'+function () {
																	if(v.tgDesc){
																		return v.tgDesc
																	}else{
																		return  ''
																	}
																}()+'</td>\n' +
																'</tr>\n'
													})
													str+='</tbody></table>'
													$('#newOrEditForm input[name="tgId"]').val(tgName)
													$('#newOrEditForm input[name="tgId"]').attr('tgId',tgId)
													$('#newOrEditForm #targetDetail').remove()
													$('#newOrEditForm').append(str)
													layer.close(index)
												}
											})
										}
									})
								})
								$('.relationDel').on("click",function () {
									$('#newOrEditForm input[name="tgId"]').val('')
									$('#newOrEditForm input[name="tgId"]').attr('tgId','')
									$('#targetDetail').remove()
								})
								// 成果标准模板
								$('.resultDictAdd').on("click",function () {
									layer.open({
										type: 1,
										title: '添加成果标准模板',
										area: ['30%', '70%'],
										btn: ['确定', '取消'],
										content:'<div  class="layui-form result"  style="margin-top: 15px"></div>',
										success:function () {
											var cgclTypeObject = dictionaryObj['CGCL_TYPE']['object'];
											var str = '';
											for (var key in cgclTypeObject) {
												if (cgclTypeObject.hasOwnProperty(key)) {
													str += '<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+cgclTypeObject[key]+'" title="'+cgclTypeObject[key]+'" value="'+key+'" lay-skin="primary"></div>';
												}
											}
											$('.result').html(str);
											form.render();

											var resultDict = $('form input[name="resultDict"]').attr('resultDict');
											if (!!resultDict) {
												var resultDictArr = resultDict.replace(/,$/, '').split(',');
												$('.result input').each(function (index) {
													resultDictArr.forEach(function (v, i) {
														if ($('.result input').eq(index).val() == v) {
															$('.result input').eq(index).prop('checked', 'true');
															form.render();
														}
													});
												});
											}
										},
										yes:function (index) {
											var resultDict = '';
											var resultDictName = '';
											$('.result input').each(function () {
												if($(this).prop('checked')){
													resultDict += $(this).val() + ',';
													resultDictName += $(this).attr('title') + ',';
												}
											});
											$('#newOrEditForm input[name="resultDict"]').val(resultDictName.replace(/,$/, ''));
											$('#newOrEditForm input[name="resultDict"]').attr('resultDict',resultDict.replace(/,$/, ''));
											layer.close(index);
										}
									});
								});
								// 清空成果标准模板
								$('.resultDictDel').on("click",function () {
									$('#newOrEditForm input[name="resultDict"]').val('');
									$('#newOrEditForm input[name="resultDict"]').attr('resultDict','');
								});

								$('#newOrEditForm select[name="controlLevel"]').append(dictionaryObj['CONTROL_LEVEL']['str']);
								$('#newOrEditForm select[name="tgGrade"]').append(dictionaryObj['TG_GRADE']['str']);
								$('#newOrEditForm select[name="planSycle"]').append(dictionaryObj['PLAN_SYCLE']['str']);
								$('#newOrEditForm select[name="tgType"]').append(dictionaryObj['TG_TYPE']['str']);
								$('#newOrEditForm select[name="planStage"]').append(dictionaryObj['PLAN_PHASE']['str']);
								$('#newOrEditForm select[name="itemQuantityNuit"]').append(dictionaryObj['UNIT']['str']);

								form.render();

								if (type === 1) {
									//默认难度系数为5
									$('#newOrEditForm  select[name="hardDegree"]').val('5')
									form.render()
									// 获取主项计划的编号
									getAutoNo({model: 'projectTarget'}, function(autoNo){
										$('#newOrEditForm input[name="tgNo"]').val(autoNo);
									});

									$('.refresh_no').css('visibility', 'visible');
									$('.refresh_no').on('click', function () {
										getAutoNo({model: 'projectTarget'}, function (autoNo) {
											$('#newOrEditForm input[name="tgNo"]').val(autoNo);
										});
									});
								}

								if (type === 2) {
									//给表单赋值
									form.val("formTest", data);

									$('#dutyUser').val(data.dutyUserName);
									$('#dutyUser').attr('user_id', data.dutyUser);
									$('#mainCenterDept').val(data.mainCenterDeptName);
									$('#mainCenterDept').attr('deptid', data.mainCenterDept);
									$('#mainAreaDept').val(data.mainAreaDeptName || '');
									$('#mainAreaDept').attr('deptid', (data.mainAreaDept || ''));
									$('#mainProjectDept').val(data.mainProjectDeptName || '');
									$('#mainProjectDept').attr('deptid', (data.mainProjectDept || ''));
									$('#mainAreaUser').val(data.mainAreaUserName);
									$('#mainAreaUser').attr('user_id', data.mainAreaUser);
									$('#mainProjectUser').val(data.mainProjectUserName);
									$('#mainProjectUser').attr('user_id', data.mainProjectUser);

									//关键任务类型回显
									$('#tgType_add').val(dictionaryObj['TG_TYPE']['object'][data.tgType.replace(/,$/,'')]);
									$('#tgType_add').attr('dictNo', data.tgType);

									/*//顶层关注回显
									if (data.controlLevel == 1) {
										$('#newOrEditForm [name="controlLevel"]').prop('checked', true)
									} else {
										$('#newOrEditForm [name="controlLevel"]').prop('checked', false)
									}*/
									// 成果标准模板
									if(!!data.resultDict){
										var resultDictList = data.resultDict.split(',');
										var resultDictName = '';
										resultDictList.forEach(function (item) {
											resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
										})
										$('#newOrEditForm input[name="resultDict"]').val(resultDictName.replace(/,$/, ''));
										$('#newOrEditForm input[name="resultDict"]').attr('resultDict',data.resultDict);
									}

									if(data.pbagId){
										$('#client').attr('projectId','');
										$('#client').attr('pbagId',data.pbagId);
										$('#client').val(data.pbagId);
									}else{
										$('#client').attr('projectId',data.projectId);
										$('#client').attr('pbagId','');
										$('#client').val(data.projectId);
									}

									//前置关键任务
									if (data.preTarget) {
										$.get('/projectTarget/selectPreShow', {preTgIds: data.preTarget}, function (res) {
											if (res.flag) {
												var dataPre = res.obj
												var preTaskName = ''
												dataPre.forEach(function (item, index) {
													preTaskName += item.workTargetName + ','
												})
												$('#newOrEditForm input[name="preTgId"]').val(preTaskName)
												$('#newOrEditForm input[name="preTgId"]').attr('preTgId', data.preTarget)
											}
										})
									}

									//关联关键任务
									if (data.linkedTargetList) {
										var tgIds = data.linkedTargetList
										var tgId = ''
										var tgName = ''
										tgIds.forEach(function (item) {
											tgId += item.tgId + ','
											tgName += item.tgName + ','
										})
										$('#newOrEditForm input[name="tgId"]').val(tgName)
										$('#newOrEditForm input[name="tgId"]').attr('tgId', tgId)
										$.post('/projectTarget/selectByIds', {ids: tgId}, function (res) {
											if (res.flag) {
												var str = '<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 10px;">\n' +
														'  <thead>\n' +
														'    <tr>\n' +
														'      <th>关键任务名称</th>\n' +
														'      <th>关注等级</th>\n' +
														'      <th>计划开始时间</th>\n' +
														'      <th>计划结束时间</th>\n' +
														'      <th>完成标准</th>\n' +
														'      <th>关键任务描述</th>\n' +
														'    </tr> \n' +
														'  </thead>\n' +
														'  <tbody>\n'
												res.obj.forEach(function (v, i) {
													str += '<tr>\n' +
															'<td>' + isShowNull(v.tgName) + '</td>\n' +
															'<td>' + (dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '')+ '</td>\n' +
															'<td>' + isShowNull(v.planStartDate) + '</td>\n' +
															'<td>' + isShowNull(v.planEndDate) + '</td>\n' +
															'<td>' + isShowNull(v.resultStandard) + '</td>\n' +
															'<td>' + function () {
																if (v.tgDesc) {
																	return v.tgDesc
																} else {
																	return ''
																}
															}() + '</td>\n' +
															'</tr>\n'
												})
												str += '</tbody></table>'
												$('#newOrEditForm').append(str)
											}
										})
									} else {
										$('#newOrEditForm input[name="tgId"]').val('')
									}
								}
							},
							yes: function (index) {
								var loadingIndex = layer.load();

								var datas = $('#newOrEditForm').serializeArray()

								var obj = {}
								datas.forEach(function (item) {
									obj[item.name] = item.value.trim();
								});

								//获取中心责任部门负责人的id
								obj.dutyUser = '';
								if ($('#dutyUser').attr('user_id')) {
									obj.dutyUser = $('#dutyUser').attr('user_id');
								}
								//获取中心责任部门的id
								obj.mainCenterDept = '';
								if ($('#mainCenterDept').attr('deptid')) {
									obj.mainCenterDept = $('#mainCenterDept').attr('deptid').replace(/,$/, '');
								}
								//获取区域责任部门的id
								obj.mainAreaDept = '';
								if ($('#mainAreaDept').attr('deptid')) {
									obj.mainAreaDept = $('#mainAreaDept').attr('deptid').replace(/,$/, '');
								}
								//获取总承包部责任部门的id
								obj.mainProjectDept = '';
								if ($('#mainProjectDept').attr('deptid')) {
									obj.mainProjectDept = $('#mainProjectDept').attr('deptid').replace(/,$/, '');
								}
								//获取区域责任部门负责人的id
								obj.mainAreaUser = '';
								if ($('#mainAreaUser').attr('user_id')) {
									obj.mainAreaUser = $('#mainAreaUser').attr('user_id').replace(/,$/, '');
								}
								//获取总承包部责任部门负责人的id
								obj.mainProjectUser = '';
								if ($('#mainProjectUser').attr('user_id')) {
									obj.mainProjectUser = $('#mainProjectUser').attr('user_id').replace(/,$/, '');
								}
								// 获取成果标准模板
								obj.resultDict = $('#newOrEditForm input[name="resultDict"]').attr('resultDict') || '';
								//前置关键任务
								obj.preTarget=$('#newOrEditForm input[name="preTgId"]').attr('preTgId') || ''
								//关联关键任务
								obj.linkedTarget=$('#newOrEditForm input[name="tgId"]').attr('tgid') || ''

								//关键任务类型
								obj.tgType = $('#tgType_add').attr('dictNo')
								/*//判断顶层关注是否被勾选
								if($('#newOrEditForm [name="controlLevel"]').prop('checked')){
									obj.controlLevel = 1
								}else{
									obj.controlLevel = 0
								}*/


								obj.revision=1
								obj.planId=$('#planId').val();
								if($('#client').attr('projectId')){
									obj.projectId=$('#client').attr('projectId');
								}else{
									obj.pbagId=$('#client').attr('pbagId');
								}
								if (type === 1) {
									/*防止关联关键任务的id和主键id名称重复，新增时重设为空*/
									obj.tgId = ''
								} else if (type === 2) {
									obj.tgId = data.tgId;
								}

								// 判断必填项
								var $requiredEles = $('.required_field', $('#newOrEditForm'));
								var lock = true;
								$requiredEles.each(function () {
									var key = $(this).attr('field_name');
									var value = $(this).parent().text();

									if (!obj[key]) {
										layer.close(loadingIndex);
										layer.msg(value.substring(1) + '不能为空！', {icon: 0, time: 1000});
										lock = false;
										return false;
									}
								});

								if (lock) {
									$.post(url, obj, function (res) {
										layer.close(loadingIndex);
										if (res.flag) {
											if (type === 1) {
												if (res.object == 1) {
													layer.msg('编号重复，请刷新编号后重试！', {icon: 0, time: 1000});
													return false;
												} else {
													layer.msg('新增成功！', {icon: 1, time: 1000});
												}
											} else if (type === 2) {
												layer.msg('修改成功！', {icon: 1, time: 1000});
											}
											layer.close(index);
											var title = $('.titleSp').text();
											initTaskTable(1, {
												_: new Date().getTime(),
												planId: $('#planId').val()
											}, function () {
												$('.titleSp').text(title);
												$('.theChildBox').show();
												$('.theParentBox').hide();
                                                var tabIndex = $('#tabIndex').val();
												// 未上报显示新增、修编、续编详情按钮(只针对主项计划显示，其他不显示)
												if (tabIndex == 1) {
													$('.planModify').hide();
													/*判断是否是计划调整过来的*/
													if ($('#planClass').val() == 1 && $('#planId').attr('modify') == 1) {
														$('.targetButton').show();
													} else {
														$('.targetButton').hide();
													}
												} else {
													// 已上报显示计划调整按钮(只针对主项计划显示，其他不显示)
													$('.targetButton').hide();
													if ($('#planClass').val() == 1 && $('#planId').attr('taskApproval') == 2) {
														$('.planModify').show();
													} else {
														$('.planModify').hide();
													}
												}
											});
										} else {
											if (type === 1) {
												layer.msg('新增失败！', {icon: 2, time: 1000});
											} else if (type === 2) {
												layer.msg('修改失败！', {icon: 2, time: 1000});
											}
										}
									});
								}
							}
						});
					}

					//主项关键任务-关键任务类型选择
					$(document).on('click','.tgTypeAdd',function () {
						tgTypeSelect(1,$(this).siblings('input').attr('id'))
					})
					$(document).on('click','.tgTypeDel',function () {
						var id=$(this).siblings('input').attr('id')
						$('#'+id).val('')
						$('#'+id).attr('dictNo','')
					})

					/*弹出层显示关键任务类型--tgType*/
					function tgTypeSelect(chooseNum,id) {
						var tgTypeChildren=null
						if($('#'+id).attr('dictNo')){
							var dictArr=$('#'+id).attr('dictNo').split(',')
							var dictNameArr=$('#'+id).val().split(',')
						}else{
							var dictArr=[]
							var dictNameArr=[]
						}
						layer.open({
							type: 1,
							title: '关键任务类型',
							btn: ['确定', '取消'],
							area: ['60%', '85%'],
							maxmin: true,
							content: '<div style="position: relative;height: 100%; width: 100%;padding: 5px 10px;box-sizing: border-box;">' +
									'<div class="target_module" style="position: relative;float: left;height: 100%; width: 230px;">' +
									'<h3 style="padding: 10px 15px; text-align: center;">关键任务类型父级</h3>' +
									'<div class="tgTypeParent"><ul style="margin-top: 8px"></ul></div>' +
									'</div>' +
									'<div class="project_item">' +
									'<h3 style="padding: 10px 15px; text-align: center;">关键任务类型子级</h3>' +
									'<div>' +
									'<table id="tgTypeChildren" lay-filter="tgTypeChildren"></table>' +
									'</div>' +
									'</div>' +
									'</div>',
							success: function () {
								// 初始化左侧关键任务类型
								$.get('/Dictonary/selectDictionaryByNo',{dictNo:'TG_TYPE_PARENT'},function (res) {
									var data=res.data
									var str=''
									for(var i=0;i<data.length;i++){
										str+='<li dictNo="'+data[i].dictNo+'" style="text-align: center;padding: 3px">'+data[i].dictName+'</li>';
									}
									$('.tgTypeParent ul').html(str)
								})
								// 节点点击事件
								$(document).on('click','.tgTypeParent ul li',function () {
									$(this).addClass('select').siblings().removeClass('select')
									var dictNo=$(this).attr('dictNo')
									//判断是单选还是多选
									if(chooseNum==1){
										var chooseType='radio'
									}else{
										var chooseType='checkbox'
									}
									tgTypeChildren = table.render({
										elem: '#tgTypeChildren',
										url: '/Dictonary/getTgTypeByDictNo',
										cols: [[
											{type:chooseType},
											{
												field: 'dictName', align: 'left', title: '关键任务类型', templet: function (d) {
													return '<span  class="initTgId" dictNo="' + d.dictNo + '" >' + d.dictName + '</span>'
												}
											}
										]],
										where: {
											dictNo: dictNo,
										},
										response: {
											statusName: 'flag',
											statusCode: true,
											msgName: 'msg',
											dataName: 'obj'
										},
										done: function (res) {
											$('#tgTypeChildren').next().find('.layui-table-header').remove()
											//输入框选中的回显
											//弹出页面选择后切换回显
											if(dictArr.length>0){
												$('.initTgId').each(function (index) {
													dictArr.forEach(function (v, i) {
														if ($('.initTgId').eq(index).attr('dictNo') == v) {
															$('.initTgId').eq(index).parents('td').prev().find('input').prop('checked', 'true')
															form.render()
														}
													})
												})
											}
										}
									});
								})
								table.on('radio(tgTypeChildren)', function(obj){
									dictArr=[]
									dictNameArr=[]
									dictArr.push(obj.data.dictNo)
									dictNameArr.push(obj.data.dictName)
								});

								//监听复选框
								table.on('checkbox(tgTypeChildren)', function(obj){
									if(obj.checked){
										dictArr.push(obj.data.dictNo)
										dictNameArr.push(obj.data.dictName)
									}else{
										for(var i = 0; i < dictArr.length; i++){
											if(dictArr[i] ==obj.data.dictNo){
												dictArr.splice(i,1);
											}
										}
										for(var i = 0; i < dictNameArr.length; i++){
											if(dictNameArr[i] ==obj.data.dictName){
												dictNameArr.splice(i,1);
											}
										}
									}
								});
							},
							yes: function (index) {
								var dictNo=''
								var dictName=''
								dictArr.forEach(function (v) {
									dictNo += v+','
								})
								dictNameArr.forEach(function (v) {
									dictName += v+','
								})
								$('#'+id).val(dictName)
								$('#'+id).attr('dictNo',dictNo)
								layer.close(index)
							}
						});
					}

					//新增职能关键任务
					function addOrEdit(type, data) {
						var title = '';
						var url = '';
						if (type === 1) {
							title = '新增职能关键任务';
							url = '/plcPlan/addTgAndItem?deptOrProject=1';
						} else if (type === 2) {
							title = '编辑职能关键任务';
							url = '/projectTarget/update';
						}

						layer.open({
							type: 1,
							title: title,
							area: ['100%', '100%'],
							maxmin: true,
							min: function () {
								$('.layui-layer-shade').hide()
							},
							btn: ['保存', '取消'],
							content: '<form class="layui-form" id="newOrEditForm" lay-filter="deptTargetForm">' +
									'<input type="hidden" id="targetBelongDept" name="targetBelongDept" value="">' +
									//第一行
									'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="tgNo">*</span>编号</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="tgNo" readonly autocomplete="off" class="layui-input jinyong" style="background:#e7e7e7;width: 94%;display: inline-block">\n' +
									'<a class="refresh_no" href="javascript:;" style="display: inline-block;visibility: hidden;color: #1e9fff;">刷新</a>' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +

									'<div class="newAndEdit layui-col-xs6" style="margin-top: 15px"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="tgName">*</span>关键任务名称</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="tgName" autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div></div>' +
									'</div>' +
									//第二行
									/*'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="tgName">*</span>关键任务名称</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="tgName" autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div></div>' +
									'<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="controlLevel">*</span>关注等级</label>\n' +
									'    <div class="layui-input-block">\n' +
									' <select name="controlLevel" lay-verify="required" class="jinyong">\n' +
									'      </select>' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +*/
									//第三行
									'<div class="layui-row">' +
									'<div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planSycle">*</span>周期类型</label>\n' +
									'    <div class="layui-input-block">\n' +
									' <select name="planSycle" lay-verify="required" class="jinyong">\n' +
									'      </select>' +
									'    </div>\n' +
									'  </div></div>' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="tgType">*</span>关键任务类型</label>\n' +
									'    <div class="layui-input-block pbagNature">\n' +
									' <select name="tgType" lay-verify="required" class="jinyong">\n' +
									'      </select>' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第四行
									//第六行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">成果提交人</label>\n' +
									'    <div class="layui-input-block dutyUser">\n' +
									'  <textarea  type="text" name="dutyUser" id="dutyUser" readonly style="background:#e7e7e7;height: 45px;width: 70%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9;resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +
									'    </div>\n' +
									'  </div> </div>' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="mainCenterDept">*</span>责任部门</label>\n' +
									'    <div class="layui-input-block mainCenterDept">\n' +
									'  <textarea  type="text" name="mainCenterDept" id="mainCenterDept" readonly  style="background:#e7e7e7;height: 45px;width: 70%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9;resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第七行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planStartDate">*</span>计划开始时间</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" class="layui-input jinyong" readonly autocomplete="off" name="planStartDate" id="planStartDate">' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planEndDate">*</span>计划结束时间</label>\n' +
									'    <div class="layui-input-block contractDept">\n' +
									'      <input type="text" class="layui-input jinyong" readonly autocomplete="off" name="planEndDate" id="planEndDate">' +
									'    </div>\n' +
									'  </div> </div>' +
									' <div class="newAndEdit layui-col-xs4"><div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="planContinuedDate">*</span>计划工期</label>\n' +
									'    <div class="layui-input-inline">\n' +
									'      <input type="text" style="background-color: #e7e7e7;" name="planContinuedDate" readonly autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'<div class="layui-form-mid layui-word-aux">根据开始时间和结束时间自动生成</div>' +
									'  </div> </div>' +
									'</div>' +
									//第八行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="resultStandard">*</span>完成标准</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="resultStandard"  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">难度点</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="difficultPoint"  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div> </div>' +
									'</div>' +
									//第九行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">风险点</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="riskPoint"  autocomplete="off" class="layui-input jinyong">\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label"><span class="required_field" field_name="resultDict">*</span>成果标准模板</label>\n' +
									'    <div class="layui-input-block">\n' +
									/* ' <select name="resultDict" lay-verify="required" class="jinyong">\n' +
                                     '      </select>' +*/
									'<input type="text" name="resultDict" readonly title="成果标准模板" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="resultDictAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="resultDictDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第十行
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">难度系数</label>\n' +
									'    <div class="layui-input-block">\n' +
									// '      <input type="text" name="hardDegree"  value="5" autocomplete="off" class="layui-input number_input hardDegree">\n' +
									' <select name="hardDegree" lay-verify="required"  class="jinyong">\n' +
									'<option value="1">1</option>'+
									'<option value="2">2</option>'+
									'<option value="3">3</option>'+
									'<option value="4">4</option>'+
									'<option value="5">5</option>'+
									'<option value="6">6</option>'+
									'<option value="7">7</option>'+
									'<option value="8">8</option>'+
									'<option value="9">9</option>'+
									'<option value="10">10</option>'+
									'      </select>'+
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">协作部门</label>\n' +
									'    <div class="layui-input-block">\n' +
									'  <textarea  type="text" name="assistCompanyDepts" id="assistCompanyDepts" readonly  style="background:#e7e7e7;height: 45px;width: 70%;text-indent:1em;border-radius: 4px;border-color: #c9c9c9;resize: none;"></textarea>\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="2" class="deptAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									//第十一行
									'<div><div class="layui-form-item">' +
									'    <label class="layui-form-label">关键任务描述</label>\n' +
									'    <div class="layui-input-block">\n' +
									'<textarea name="tgDesc"  class="layui-textarea jinyong"></textarea>' +
									'    </div>\n' +
									'</div></div>' +
									//第十二行-----前置关键任务
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs11"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">前置关键任务</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <input type="text" name="preTgId" readonly  autocomplete="off" class="layui-input jinyong" style="background:#e7e7e7;">\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									' <div class="newAndEdit layui-col-xs1"> <div class="layui-form-item">\n' +
									'<button type="button" class="layui-btn settings" style="margin-left: 25px">设置</button>'+
									'  </div> </div>' +
									'</div>' +
									//第十三行----关联关键任务
									'<div class="layui-row">' +
									' <div class="newAndEdit layui-col-xs12"> <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">关联关键任务</label>\n' +
									'    <div class="layui-input-block">\n' +
									'<input type="text" name="tgId" readonly style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input jinyong " title="关联关键任务">\n' +
									'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="relationAdd">添加</a>\n' +
									' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="relationDel">清空</a>\n' +
									'    </div>\n' +
									'  </div>' +
									'  </div>' +
									'</div>' +
									'</form>',
							success: function () {
								//设置
								$('.settings').on("click",function () {
									layer.open({
										type: 1,
										title: '前置关键任务',
										area: ['80%', '70%'],
										btn: ['确定', '取消'],
										content:'<div style="margin-top: 15px" class="layui-form" id="targetSet">' +
												'<div class="layui-row" style="text-align: right;margin-right: 2%">' +
												'<div class="layui-col-xs4">' +
												'<div class="layui-form-item">\n' +
												'<label class="layui-form-label">年度:</label>\n' +
												'<div class="layui-input-block">\n' +
												'<select name="year" lay-filter="yearSet">\n' +
												'<option value="">请选择</option>\n' +
												'</select>\n' +
												'</div>\n' +
												'</div>'+
												'</div>'+
												'<div class="layui-col-xs4">' +
												'<div class="layui-form-item">\n' +
												'<label class="layui-form-label">月度:</label>\n' +
												'<div class="layui-input-block">\n' +
												'<select name="month">\n' +
												'</select>\n' +
												'</div>\n' +
												'</div>'+
												'</div>'+
												'<div class="layui-col-xs4">' +
												'<div class="layui-form-item">\n' +
												'<label class="layui-form-label">责任部门:</label>\n' +
												'<div class="layui-input-block">\n' +
												'<input type="text" name="mainCenterDept" readonly id="mainCenterDeptSet" autocomplete="off" class="layui-input"  readonly style="background:#e7e7e7;display: inline-block;width: 65%">' +
												'<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_targetSet_dept">添加</span>' +
												'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_targetSet_dept">清空</span>' +
												'</div>\n' +
												'</div>'+
												'</div>'+
												'<button type="button" class="layui-btn layui-btn-sm addPreTask">增加</button></div>'+
												'<table class="layui-table preTaskTable" style="width: 98%;margin: 8px">\n' +
												'  <thead>\n' +
												'    <tr>\n' +
												'      <th>关键任务名称</th>\n' +
												'      <th>类型</th>\n' +
												'      <th>延隔时间(天)</th>\n' +
												'    </tr> \n' +
												'  </thead>\n' +
												'  <tbody>\n' +
												'  </tbody>\n' +
												'</table>'+
												'</div>',
										success:function () {
											//默认责任部门为当前左侧所选部门
											$('#mainCenterDeptSet').val($('#leftId').attr('mainCenterDeptName'))
											$('#mainCenterDeptSet').attr('deptid',$('#leftId').attr('mainCenterDept'))
											$('.add_targetSet_dept').on('click', function(){
												dept_id = 'mainCenterDeptSet';
												$.popWindow("/common/selectDept?0");
											});
											$('.clear_targetSet_dept').on('click', function(){
												$('#mainCenterDeptSet').val('');
												$('#mainCenterDeptSet').attr('deptId', '');
											});
											/***************************************************计划期间年度、月度*******************************************************/
													// 计划期间年度列表
											var allYear = '';
											// 获取计划期间年度列表
											$.get('/planPeroidSetting/selectAllYear', function(res) {
												if (res.object.length > 0) {
													res.object.forEach(function(item){
														allYear += '<option value="'+item.periodYear+'">'+item.periodYear+'</option>'
													});
												}
												$('#targetSet [name="year"]').append(allYear);
												form.render('select');
												//新建时默认年度为当年、月度为当月
												$('#targetSet select[name="year"] option').each(function () {
													var nowYear=new Date().getFullYear()
													if($(this).text()==nowYear){
														$('#targetSet select[name="year"]').val($(this).val())
														form.render()
														getPlanMonth($(this).val(), function (monthSrt) {
															$('#targetSet select[name="month"]').html(monthSrt);
															form.render('select');
															//判断是否存在当月
															var nextMonth=new Date().getMonth()+1
															$('#targetSet select[name="month"] option').each(function () {
																if(parseInt($(this).text())==nextMonth){
																	$('#targetSet select[name="month"]').val($(this).val())
																	form.render()
																}
															})
														});
													}
												})
											});

											// 获取月度
											form.on('select(yearSet)', function (data) {
												if (data.value) {
													getPlanMonth(data.value, function (monthStr) {
														$('#targetSet [name="month"]').html(monthStr);
														form.render('select');
													});
												} else {
													$('#targetSet [name="month"]').html('<option value="">请选择</option>');
													form.render('select');
												}
											});


											if($('#newOrEditForm input[name="preTgId"]').attr('preTgId')){
												$.get('/projectTarget/selectPreShow',{preTgIds:$('#newOrEditForm input[name="preTgId"]').attr('preTgId')},function (res) {
													if(res.flag){
														var data=res.obj
														data.forEach(function (item,index) {
															var str=''
															str+=   '    <tr class="trTask">\n' +
																	'      <td>' +
																	'  <select name="workTargetName" lay-verify="required">\n' +
																	function () {
																		var name=allTargetDept()
																		return name
																	}()+
																	'      </select>'+
																	'</td>\n' +
																	'      <td>' +
																	'  <select name="pretaskItemType" lay-verify="required">\n' +
																	'        <option value=""></option>\n' +
																	'        <option value="FS">完成-开始(FS)</option>\n' +
																	'        <option value="SS">开始-开始(SS)</option>\n' +
																	'        <option value="FF">完成-完成(FF)</option>\n' +
																	'        <option value="SF">开始-完成(SF)</option>\n' +
																	'      </select>'+
																	'</td>\n' +
																	'      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')"  name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
																	'    </tr>\n'
															$('.preTaskTable tbody').append(str)
															$('.trTask').eq(index).find('select[name="workTargetName"]').val(item.tgId)
															$('.trTask').eq(index).find('select[name="pretaskItemType"]').val(item.pretaskItemType)
															$('.trTask').eq(index).find('input[name="extendDates"]').val(item.extendDates)
															form.render()
														})
													}
												})
											}
											$('.addPreTask').on("click",function () {
												var str=   '    <tr class="trTask">\n' +
														'      <td>' +
														'  <select name="workTargetName" lay-verify="required">\n' +
														function () {
															var year=$('#targetSet select[name="year"]').val() || ''
															var month=$('#targetSet select[name="month"]').val() || ''
															if($('#mainCenterDeptSet').attr('deptId')){
																var mainCenterDept=$('#mainCenterDeptSet').attr('deptId').replace(/,$/, '')
															}else{
																var mainCenterDept=''
															}

															var name=allTargetDept(year,month,mainCenterDept)
															return name
														}()+
														'      </select>'+
														'</td>\n' +
														'      <td>' +
														'  <select name="pretaskItemType" lay-verify="required">\n' +
														'        <option value=""></option>\n' +
														'        <option value="FS">完成-开始(FS)</option>\n' +
														'        <option value="SS">开始-开始(SS)</option>\n' +
														'        <option value="FF">完成-完成(FF)</option>\n' +
														'        <option value="SF">开始-完成(SF)</option>\n' +
														'      </select>'+
														'</td>\n' +
														'      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')" value="0" name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
														'    </tr>\n'
												$('.preTaskTable tbody').append(str)
												form.render()
											})
										},
										yes:function (index) {
											var arr=[]
											var str=''
											$('.trTask').each(function () {
												if($(this).find('select[name="workTargetName"]').val() && $(this).find('select[name="pretaskItemType"]').val() && $(this).find('input[name="extendDates"]').val()){
													var obj={}
													obj.tgId=$(this).find('select[name="workTargetName"]').val()
													obj.workTargetName=$(this).find('select[name="workTargetName"] option:selected').text()
													obj.pretaskItemType=$(this).find('select[name="pretaskItemType"]').val()
													obj.extendDates=$(this).find('input[name="extendDates"]').val()
													arr.push(obj)
													str+=obj.workTargetName+','
												}
											})
											$.ajax({
												url:'/projectTarget/insertPretask',
												data:JSON.stringify(arr),
												contentType:"application/json;charset=UTF-8",
												dataType:'json',
												type:'post',
												success:function(res){
													if(res.flag){
														$('#newOrEditForm input[name="preTgId"]').attr('preTgId',res.data)
														$('#newOrEditForm input[name="preTgId"]').val(str)
														layer.close(index)
													}
												}
											})
										}
									})
								})

								//关联关键任务
								$('.relationAdd').on("click",function () {
									layer.open({
										type: 2,
										title: '添加关联关键任务',
										area: ['80%', '80%'],
										btn: ['确定', '取消'],
										// content:'<div  class="layui-form relation"  style="margin-top: 15px"></div>',
										content:'/projectTarget/relationDeptTarget',
										success:function () {
											/*var tgId=$('form input[name="tgId"]').attr('tgId')
                                            if(tgId){
                                                var tgArr=tgId.replace(/,$/, '').split(',')
                                            }
                                            $.get('/projectTarget/getDropDown',function (res) {
                                                if(res.flag){
                                                    if(res.obj && res.obj.length>0){
                                                        var data=res.obj
                                                        var str=''
                                                        for(var i=0;i<data.length;i++){
                                                            str+='<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+res.obj[i].tgName+'" title="'+res.obj[i].tgName+'" value="'+res.obj[i].tgId+'" lay-skin="primary"> </div>'
                                                        }
                                                        $('.relation').html(str)
                                                        form.render()
                                                        if(tgArr){
                                                            $('.relation input').each(function (index) {
                                                                tgArr.forEach(function (v,i) {
                                                                    if($('.relation input').eq(index).val()==v){
                                                                        $('.relation input').eq(index).prop('checked','true')
                                                                        form.render()
                                                                    }
                                                                })
                                                            })
                                                        }
                                                    }
                                                }
                                            })*/
										},
										yes:function (index, layero) {
											var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
											// console.log(iframeWin.leftArr)
											var ids=iframeWin.leftArr.join()
											$.post('/projectTarget/selectByIds',{ids:ids},function (res) {
												if(res.flag){
													var tgId=''
													var tgName=''
													var str='<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 10px;">\n' +
															'  <thead>\n' +
															'    <tr>\n' +
															'      <th>关键任务名称</th>\n' +
															'      <th>关注等级</th>\n' +
															'      <th>计划开始时间</th>\n' +
															'      <th>计划结束时间</th>\n' +
															'      <th>完成标准</th>\n' +
															'      <th>关键任务描述</th>\n' +
															'    </tr> \n' +
															'  </thead>\n' +
															'  <tbody>\n'
													res.obj.forEach(function (v,i) {
														tgId+=v.tgId+','
														tgName+=v.tgName+','
														str+= '<tr>\n' +
																'<td>'+isShowNull(v.tgName)+'</td>\n' +
																'<td>'+(dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '')+'</td>\n' +
																'<td>'+isShowNull(v.planStartDate)+'</td>\n' +
																'<td>'+isShowNull(v.planEndDate)+'</td>\n' +
																'<td>'+isShowNull(v.resultStandard)+'</td>\n' +
																'<td>'+function () {
																	if(v.tgDesc){
																		return v.tgDesc
																	}else{
																		return  ''
																	}
																}()+'</td>\n' +
																'</tr>\n'
													})
													str+='</tbody></table>'
													$('#newOrEditForm input[name="tgId"]').val(tgName)
													$('#newOrEditForm input[name="tgId"]').attr('tgId',tgId)
													$('#newOrEditForm #targetDetail').remove()
													$('#newOrEditForm').append(str)
													layer.close(index)
												}
											})
										}
									})
								})
								$('.relationDel').on("click",function () {
									$('#newOrEditForm input[name="tgId"]').val('')
									$('#newOrEditForm input[name="tgId"]').attr('tgId','')
									$('#targetDetail').remove()
								})
								// 成果标准模板
								$('.resultDictAdd').on("click",function () {
									layer.open({
										type: 1,
										title: '添加成果标准模板',
										area: ['30%', '70%'],
										btn: ['确定', '取消'],
										content:'<div  class="layui-form result"  style="margin-top: 15px"></div>',
										success:function () {
											var cgclTypeObject = dictionaryObj['CGCL_TYPE']['object'];
											var str = '';
											for (var key in cgclTypeObject) {
												if (cgclTypeObject.hasOwnProperty(key)) {
													str += '<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+cgclTypeObject[key]+'" title="'+cgclTypeObject[key]+'" value="'+key+'" lay-skin="primary"></div>';
												}
											}
											$('.result').html(str);
											form.render();

											var resultDict = $('form input[name="resultDict"]').attr('resultDict');

											if(resultDict){
												var resultDictArr=resultDict.replace(/,$/, '').split(',');
											}

											if(resultDictArr){
												$('.result input').each(function (index) {
													resultDictArr.forEach(function (v,i) {
														if($('.result input').eq(index).val()==v){
															$('.result input').eq(index).prop('checked','true');
															form.render();
														}
													});
												});
											}
										},
										yes:function (index) {
											var resultDict = '';
											var resultDictName = '';
											$('.result input').each(function () {
												if($(this).prop('checked')){
													resultDict += $(this).val() + ',';
													resultDictName += $(this).attr('title') + ',';
												}
											});
											$('#newOrEditForm input[name="resultDict"]').val(resultDictName.replace(/,$/, ''));
											$('#newOrEditForm input[name="resultDict"]').attr('resultDict',resultDict.replace(/,$/, ''));
											layer.close(index);
										}
									})
								});
								// 清空成果标准模板
								$('.resultDictDel').on("click",function () {
									$('#newOrEditForm input[name="resultDict"]').val('');
									$('#newOrEditForm input[name="resultDict"]').attr('resultDict','');
								});

								$('#targetBelongDept', $('#newOrEditForm')).val($('#belongtoDept').val());
								$('#newOrEditForm select[name="controlLevel"]').append(dictionaryObj['CONTROL_LEVEL']['str']);
								$('#newOrEditForm select[name="planSycle"]').append(dictionaryObj['PLAN_SYCLE']['str']);
								$('#newOrEditForm select[name="tgType"]').append(dictionaryObj['TG_TYPE']['str']);
								$('#newOrEditForm select[name="planStage"]').append(dictionaryObj['PLAN_PHASE']['str']);

								form.render();

								if (type === 1) {
									//默认难度系数为5
									$('#newOrEditForm  select[name="hardDegree"]').val('5')
									form.render()
									// 获取职能关键任务的编号
									getAutoNo({model: 'projectTargetYear'}, function (autoNo) {
										$('#newOrEditForm input[name="tgNo"]').val(autoNo);
									});

									$('.refresh_no').css('visibility', 'visible');
									$('.refresh_no').on('click', function () {
										getAutoNo({model: 'projectTargetYear'}, function(autoNo){
											$('#newOrEditForm input[name="tgNo"]').val(autoNo);
										});
									});

									var mainCenterDeptId =  $('#leftId').attr('mainCenterDept') || '';
									var mainCenterDeptName = $('#leftId').attr('mainCenterDeptName') || '';

									$('#newOrEditForm [name="mainCenterDept"]').val(mainCenterDeptName);
									$('#newOrEditForm [name="mainCenterDept"]').attr('deptid', mainCenterDeptId);

									//新建时默认计划类型为年度关键任务
									$('#newOrEditForm select[name="tgType"] option').each(function () {
										if($(this).text()=='年度关键任务'){
											$('#newOrEditForm select[name="tgType"]').val($(this).val())
											form.render()
										}
									})
									//新建时默认周期类型为年度
									$('#newOrEditForm select[name="planSycle"] option').each(function () {
										if($(this).text()=='年度'){
											$('#newOrEditForm select[name="planSycle"]').val($(this).val())
											form.render()
										}
									})
								}

								// 给表单赋值
								if (type === 2) {

									form.val("deptTargetForm", data);

									$('#dutyUser').val(data.dutyUserName);
									$('#dutyUser').attr('user_id', data.dutyUser);
									$('#mainCenterDept').val(data.mainCenterDeptName);
									$('#mainCenterDept').attr('deptid', data.mainCenterDept);
									$('#assistCompanyDepts').val(data.assistCompanyDeptName);
									$('#assistCompanyDepts').attr('deptid', data.assistCompanyDepts);
									// 成果标准模板
									if(!!data.resultDict){
										var resultDictList = data.resultDict.split(',');
										var resultDictName = '';
										resultDictList.forEach(function (item) {
											resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
										});
										$('#newOrEditForm input[name="resultDict"]').val(resultDictName.replace(/,$/, ''));
										$('#newOrEditForm input[name="resultDict"]').attr('resultDict',data.resultDict);
									}
								}

								// 初始化计划开始时间
								var planStartLaydateConfig = {
									elem: '#planStartDate',
									done: function (value, date) {
										if ($('#planEndDate').val()) {
											var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
											$('input[name="planContinuedDate"]').val(planPeriod);
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
									},
									trigger: 'click' //采用click弹出
								}
								if (data && data.planEndDate) {
									planStartLaydateConfig.max = data.planEndDate;
								}
								var planStartLaydate = laydate.render(planStartLaydateConfig);

								// 初始化计划结束时间
								var planEndLaydateConfig = {
									elem: '#planEndDate',
									done: function (value, date) {
										if ($('#planStartDate').val()) {
											var planPeriod = !!value ? timeRange($('#planStartDate').val(), value) + '天' : '';
											$('input[name="planContinuedDate"]').val(planPeriod);
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
									},
									trigger: 'click' //采用click弹出
								}
								if (data && data.planStartDate) {
									planEndLaydateConfig.min = data.planStartDate;
								}
								var planEndLaydate = laydate.render(planEndLaydateConfig);
							},
							yes: function (index) {
								var loadingIndex = layer.load();

								var dataArr = $('#newOrEditForm').serializeArray();
								var obj = {}
								dataArr.forEach(function (item) {
									obj[item.name] = item.value.trim();
								});

								//获取负责人的id
								obj.dutyUser = '';
								if ($('#dutyUser').attr('user_id')) {
									obj.dutyUser = $('#dutyUser').attr('user_id');
								}
								//获取所属部门的id
								obj.mainCenterDept = '';
								if ($('#mainCenterDept').attr('deptid')) {
									obj.mainCenterDept = $('#mainCenterDept').attr('deptid').replace(/,$/, '');
								}
								//获取协作部门的id
								obj.assistCompanyDepts = '';
								if ($('#assistCompanyDepts').attr('deptid')) {
									obj.assistCompanyDepts = $('#assistCompanyDepts').attr('deptid');
								}
								// 获取成果标准模板
								obj.resultDict = $('#newOrEditForm input[name="resultDict"]').attr('resultDict') || '';

								//前置关键任务
								obj.preTarget=$('#newOrEditForm input[name="preTgId"]').attr('preTgId') || ''
								//关联关键任务
								obj.linkedTarget=$('#newOrEditForm input[name="tgId"]').attr('tgid') || ''

								// 判断必填项
								var $requiredEles = $('.required_field', $('#newOrEditForm'));
								var lock = true;
								$requiredEles.each(function () {
									var key = $(this).attr('field_name');
									var value = $(this).parent().text();

									if (!obj[key]) {
										layer.close(loadingIndex);
										layer.msg(value.substring(1) + '不能为空！', {icon: 0, time: 1000});
										lock = false;
										return false;
									}
								});

								if (lock) {
									/*防止关联关键任务的id和主键id名称重复，新增时重设为空*/
									obj.tgId = ''
									if (type === 2) {
										obj.tgId = data.tgId;
									}
									obj.revision=1
									// obj.mainCenterDept=$('.mainCenterDeptId').attr('mainCenterDept')
									obj.planId=$('#planId').val()
									$.post(url, obj, function (res) {
										layer.close(loadingIndex);
										if (res.flag) {
											if (type === 1) {
												if (res.object == 1) {
													layer.msg('编号重复，请刷新编号后重试！', {icon: 0, time: 1000});
													return false;
												} else {
													layer.msg('新增成功！', {icon: 1, time: 1000});
												}
											} else if (type === 2) {
												layer.msg('修改成功！', {icon: 1, time: 1000});
											}
											layer.close(index);
											var title = $('.titleSp').text();
											initTaskTable(2, {
												_: new Date().getTime(),
												planId: $('#planId').val()
											}, function () {
												$('.titleSp').text(title);
												$('.theChildBox').show();
												$('.theParentBox').hide();
												var tabIndex = $('#tabIndex').val();
												// 未上报显示新增、修编、续编详情按钮(只针对主项计划显示，其他不显示)
												if (tabIndex == 1) {
													$('.planModify').hide();
													/*判断是否是计划调整过来的*/
													if ($('#planClass').val() == 1 && $('#planId').attr('modify') == 1) {
														$('.targetButton').show();
													} else {
														$('.targetButton').hide();
													}
												} else {
													// 已上报显示计划调整按钮(只针对主项计划显示，其他不显示)
													$('.targetButton').hide();
													if ($('#planClass').val() == 1 && $('#planId').attr('taskApproval') == 2) {
														$('.planModify').show();
													} else {
														$('.planModify').hide();
													}
												}
											});

										} else {
											if (type === 1) {
												layer.msg('新增失败！', {icon: 2, time: 1000});
											} else if (type === 2) {
												layer.msg('修改失败！', {icon: 2, time: 1000});
											}
										}
									});
								}
							}
						});
					}

					//修编
					function openRevision(ids){
						$.post('/projectTarget/selectShowByIds',{ids:ids},function (res) {
							for(var i=0;i<res.obj.length;i++){
								if(!res.obj[i].planStartDate){
									layer.msg('请将勾选的子任务中的计划开始时间补充完整！', {icon: 0});
									return false
								}else if(!res.obj[i].planEndDate){
									layer.msg('请将勾选的子任务中的计划结束时间补充完整！', {icon: 0});
									return false
								}else if(!res.obj[i].planContinuedDate){
									layer.msg('请将勾选的子任务中的计划工期补充完整！', {icon: 0});
									return false
								}
							}
							layer.open({
								type: 1,
								title: '修编',
								btn: ['确定', '取消'],
								area: ['60%', '85%'],
								content: '<div>' +
										'<div><table id="projectRevisionTable" lay-filter="projectRevisionTable"></table></div>' +
										'<div>' +
										/* '<form id="revisionForm">' +
                                             '<div class="layui-form-item">' +
                                                 '<label class="layui-form-label">修编原因</label>' +
                                                 '<div class="layui-input-block">' +
                                                     '<textarea name="unusualStuff" class="layui-textarea"></textarea>' +
                                                 '</div>' +
                                             '</div>' +
                                             '<div class="layui-form-item">' +
                                                 '<label class="layui-form-label">支撑材料</label>' +
                                                 '<div class="layui-input-block">' +
                                                     '<div id="attachment3FileBox"></div>' +
                                                     '<a href="javascript:;" class="openFile" style="float: left;margin-top:8px;position:relative">' +
                                                         '<img src="../img/mg11.png" alt="">' +
                                                         '<span><fmt:message code="email.th.addfile"/></span>' +
								                            '<input type="file" multiple id="attachment3" data-url="/upload?module=plancheck" name="file">' +
							                            '</a>' +
						                            '</div>' +
						                        '</div>' +
	                                        '</form>' +*/
										'</div>' +
										'</div>',
								success: function () {
									// 初始化上传按钮
									// fileuploadFn('#attachment3', $('#attachment3FileBox'));

									var projectRevisionTable = table.render({
										elem: '#projectRevisionTable',
										data: res.obj,
										cols: [[
											{type: 'numbers'},
											{field: 'tgName', title: '关键任务名称',templet: function(d){
													return '<span  class="tgName" tgId="'+d.tgId+'" >'+ d.tgName +'</span>'
												}},
											{field: 'planStartDate', title: '计划开始时间', templet: function(d){
													var startDateStr = '<input type="text" style="height: 100%;" readonly class="layui-input table_date_start" value="'+d.planStartDate+'">'
													return startDateStr;
												}},
											{field: 'planEndDate', title: '计划完成时间', templet: function(d){
													var planEndDate = '<input type="text" style="height: 100%;" readonly class="layui-input table_date_end" value="'+d.planEndDate+'">'
													return planEndDate;
												}},
											{field: 'planContinuedDate', title: '计划工期', templet: function(d){
													return '<span class="table_planContinuedDate">'+d.planContinuedDate+'</span>'
												}},
										]],
										limit:1000,
										done: function (res) {
											var $tableTrEles = $('#projectRevisionTable').next().find('tr');

											res.data.forEach(function (item, index) {
												var tableDateStartEle = $tableTrEles.eq(index + 1).find('.table_date_start').get(0);
												var startDatePickConfig = {
													elem: tableDateStartEle,
													format: 'yyyy-MM-dd',
													btns: ['now', 'confirm'],
													max: item.planEndDate,
													done: function (value, date) {
														var $tr = $(tableDateStartEle).parents('tr').eq(0);
														var planPeriod = timeRange(value, $tr.find('.table_date_end').eq(0).val()) + '天';
														$tr.find('.table_planContinuedDate').text(planPeriod);

														if (endDatePick.config.min) {
															endDatePick.config.min = {
																year: date.year || 1900,
																month: date.month - 1 || 0,
																date: date.date || 1,
															}
														} else {
															endDatePickConfig.min = value;
														}
													},
													trigger: 'click' //采用click弹出
												}
												var startDatePick = laydate.render(startDatePickConfig);

												var tableDateEndEle = $tableTrEles.eq(index + 1).find('.table_date_end').get(0);
												var endDatePickConfig = {
													elem: tableDateEndEle,
													format: 'yyyy-MM-dd',
													btns: ['now', 'confirm'],
													min: item.planStartDate,
													done: function (value, date) {
														var $tr = $(tableDateEndEle).parents('tr').eq(0);
														var planPeriod = timeRange($tr.find('.table_date_start').eq(0).val(), value) + '天';
														$tr.find('.table_planContinuedDate').text(planPeriod);

														if (startDatePick.config.max) {
															startDatePick.config.max = {
																year: date.year || 2099,
																month: date.month - 1 || 11,
																date: date.date || 31
															}
														} else {
															startDatePickConfig.max = value;
														}
													},
													trigger: 'click' //采用click弹出
												}
												var endDatePick = laydate.render(endDatePickConfig);
											});
										}
									});
								},
								yes: function (index) {
									var arr=[]
									$('#projectRevisionTable').next().find('.layui-table-box .layui-table-body tr').each(function () {
										if($(this).find('.table_date_start').val() && $(this).find('.table_date_end').val()){
											var obj={}
											obj.planStartDate=$(this).find('.table_date_start').val()
											obj.planEndDate=$(this).find('.table_date_end').val()
											obj.planContinuedDate=$(this).find('.table_planContinuedDate').text()
											obj.tgId=$(this).find('.tgName').attr('tgId')
											arr.push(obj)
										}
									})
									// console.log(arr)
									$.ajax({
										url:'/projectTarget/revision',
										data:JSON.stringify(arr),
										contentType:"application/json;charset=UTF-8",
										dataType:'json',
										type:'post',
										success:function(res){
											if(res.flag){
												layer.msg('修编成功！', {icon: 1});
												layer.close(index)
												var title = $('.titleSp').html();
												insTb.reload({
													done: function() {
													    $('.titleSp').html(title);
													}
												})
											}
										}
									})
								}
							});
						})
					}
					//修编详情
					function  openRevisionDetail(tgId){
						$.post('/EditRecord/selectByTgId',{tgId:tgId},function (res) {
							layer.open({
								type: 1,
								title: '修编详情',
								area: ['80%', '70%'],
								content: '<div id="revision_view"></div><table id="demo"></table>',
								success:function () {
									var data=res.obj
									var addData=res.object
									if(res.flag && data.length>0){
										data.forEach(function (item,index) {
											if(item.length>0){
												var tableTitle='<table class="layui-table"><thead><tr>'+'<th nowrap="nowrap">关键任务名称</th>'+'<th nowrap="nowrap">修编人</th>'
												var str='<tbody><tr>'+'<td>'+function () {
													if(item.length>0){
														return  item[0].tgName
													}else{
														return ''
													}
												}()+'</td>'+'<td>'+function () {
													if(item.length>0){
														return  item[0].editUserName
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
														tableTitle+='<th nowrap="nowrap">计划开始时间(修编)</th>\n' +
																'      <th nowrap="nowrap">计划完成时间(修编)</th>\n' +
																'      <th nowrap="nowrap">计划工期(修编)</th></thead>'
													}else{
														tableTitle+='<th nowrap="nowrap">计划开始时间</th>\n' +
																'      <th nowrap="nowrap">计划完成时间</th>\n' +
																'      <th nowrap="nowrap">计划工期</th>'
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
												// $('#revision_view').append('<p style="text-align: center">暂无修编详情</p>')
											}
										})
									}
									//新增数据的详情
									if(res.flag && addData.length > 0){
										table.render({
											elem: '#demo',
											data: addData,
											cols: [[ //表头
												{field: 'tgNo', title: '关键任务编号', width: 200}
												, {
													field: 'tgName', title: '关键任务名称', width: 300,templet: function (d) {
														return '<span class="tg_detail" style="color: blue;cursor: pointer;" tgId="' + d.tgId + '" >' + d.tgName + '</span>'
													}
												}
												, {
													field: 'planStartDate', title: '计划开始时间', width: 130, templet: function (d) {
														return format(d.planStartDate);
													}
												}
												, {
													field: 'planEndDate', title: '计划完成时间', width: 130, templet: function (d) {
														return format(d.planEndDate);
													}
												}
												, {
													field: 'planContinuedDate', title: '计划工期', width: 100
												}
												, {field: 'mainCenterDeptName', title: '中心责任部门', width: 130}
												, {field: 'mainAreaDeptName', title: '区域责任部门', width: 130}
												, {field: 'mainProjectDeptName', title: '总承包部责任部门', width: 150}
												, {
													field: 'controlLevel', title: '关注等级', width: 100, templet: function (d) {
														return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
													}
												}
												, {
													field: 'tgGrade', title: '目标等级', width: 100, templet: function (d) {
														return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
													}
												}
												, {
													field: 'planSycle', title: '周期类型', width: 100, templet: function (d) {
														return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
													}
												}
												, {
													field: 'tgType', title: '关键任务类型', width: 100, templet: function (d) {
														return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
													}
												}
												, {
													field: 'dutyUserName', title: '中心责任部门责任人', width: 160, templet: function (d) {
														if (d.dutyUserName) {
															return d.dutyUserName.replace(/,$/, '');
														} else {
															return ''
														}
													}
												}
												, {field: 'mainAreaUserName', title: '区域责任部门责任人', width: 160}
												, {field: 'mainProjectUserName', title: '总承包部责任部门责任人', width: 200}
												, {field: 'resultStandard', title: '完成标准', width: 150}
												, {field: 'riskPoint', title: '风险点', width: 130}
												, {
													field: 'resultDict', title: '成果标准模板', width: 150, templet: function (d) {
														var resultDictName = '';
														if (!!d.resultDict) {
															var resultDictList = d.resultDict.split(',');

															resultDictList.forEach(function (item) {
																resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
															});
														}

														return resultDictName.replace(/,$/, '');
													}
												}
												, {field: 'difficultPoint', title: '难度点', width: 130}
												, {field: 'tgDesc', title: '关键任务描述', width: 150}
											]]
										});
									}
								},
							})
						})
					}
					/***
					 * 获取编号
					 * @param data (参数)
					 * @param fn (回调函数)
					 */
					function getAutoNo(data, fn) {
						$.get('/ProjectInfo/getMaxNo', data, function (res) {
							if (fn) {
								fn(res);
							}
						});
					}
					//选人控件添加
					$(document).on('click', '.userAdd', function () {
						var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
						user_id = $(this).siblings('textarea').attr('id');
						$.popWindow("/common/selectUser" + chooseNum);
					})
					//选人控件删除
					$(document).on('click', '.userDel', function () {
						var userId = $(this).siblings('textarea').attr('id');
						$('#' + userId).val('');
						$('#' + userId).attr('user_id', '');
					})
					//选部门控件添加
					$(document).on('click', '.deptAdd', function () {
						var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
						dept_id = $(this).siblings('textarea').attr('id');
						$.popWindow("/common/selectDept" + chooseNum);
					});
					//选部门控件删除
					$(document).on('click', '.deptDel', function () {
						var deptId = $(this).siblings('textarea').attr('id');
						$('#' + deptId).val('');
						$('#' + deptId).attr('deptid', '');
					});

					/***
					 * 主项关键任务上报方法
					 * @param targetType (关键任务类型)
					 * @param projectId (项目id)
					 * @param projectName (项目名称)
					 */
					function reportPlan(projectId, projectName,tgId){
						layer.open({
							type: 1,
							title: '计划提交',
							btn: ['保存','取消'],
							area: ['1000px', '500px'],
							content: ['<form class="layui-form" id="reportForm" style="padding: 20px 15px;" lay-filter="reportForm">' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs6">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">计划编号<span class="required_field" field_name="planNo">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="planNo" readonly autocomplete="off" class="layui-input" style="display: inline-block;width: 300px;background:#e7e7e7;">' +
									'<span class="refreshPlanNo" style="margin-left: 10px;color: rgb(30, 159, 255);cursor: pointer;">刷新</span>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs6">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">类型<span class="required_field" field_name="planClass">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="planClass" readonly autocomplete="off" class="layui-input" value="主项关键任务" style="background:#e7e7e7;">' +
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">周期类型<span class="required_field" field_name="planCycle">*</span></label>' +
									'<div class="layui-input-block">' +
									'<select name="planCycle"></select>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">年度</label>' +
									'<div class="layui-input-block">' +
									'<select name="planYear" lay-filter="planYear">' +
									'<option value="">请选择</option>' +
									'</select>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">月度</label>' +
									'<div class="layui-input-block">' +
									'<select name="planMonth"></select>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">关键任务类型<span class="required_field" field_name="planType">*</span></label>' +
									'<div class="layui-input-block">' +
									// '<select name="planType"></select>' +
							'      <input type="text" name="tgType" id="tgType_add_report" readonly title="关键任务类型" style="background:#e7e7e7;width:60%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
							'      <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="tgTypeAdd">添加</a>\n' +
							'      <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="tgTypeDel">清空</a>\n' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">审批人<span class="required_field" field_name="dutyUser">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="dutyUser" readonly id="reportDutyUser" class="layui-input" style="display: inline-block; width: 150px;background-color: #e7e7e7;">' +
									'<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_report_user">添加</span>' +
									'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_report_user">清空</span>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">所属部门<span class="required_field" field_name="belongtoUnit">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="belongtoUnit" id="belongtoUnit" readonly autocomplete="off" style="display: inline-block;background-color: #e7e7e7;" class="layui-input">' +
									/*'<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_report_dept">添加</span>' +
									'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_report_dept">清空</span>' +*/
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs12">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">所属项目</label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="belongtoProj" readonly autocomplete="off" class="layui-input" style="background:#e7e7e7;">' +
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs12">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">计划名称<span class="required_field" field_name="planName">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="planName" autocomplete="off" class="layui-input" style="display: inline-block;width: 88%">' +
									' <button type="button" class="layui-btn layui-btn-sm autoPlanName" style="margin-left: 15px">生成名称</button>'+
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									' <div class="layui-form-item"  style="margin-top:15px">\n' +
									'    <label class="layui-form-label" style="padding:3px;width:90px">编制依据:</label>\n' +
									'    <div class="layui-input-block">\n' +
									' <div id="fileContent">\n' +
									'</div>\n' +
									'<a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
									'<img src="../img/mg11.png" alt="">\n' +
									'<span><fmt:message code="email.th.addfile"/></span>\n' +
									'<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
									'</a>\n' +
									'<div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">\n' +
									'<div class="bar" style="width: 0%;"></div>\n' +
									'</div>\n' +
									'<div class="barText" style="float: left;margin-left: 10px;"></div>'+
									'</div>\n' +
									'</div>' +

									'</form>'].join(''),
							success: function(){
								fileuploadFn('#fileupload', $('#fileContent'));
								/*自动生成计划名称*/
								$('.autoPlanName').on("click",function () {
									var planYear=$('#reportForm select[name="planYear"]').val()
									var planMonth=$('#reportForm select[name="planMonth"]').val()
									var planCycle=$('#reportForm select[name="planCycle"] option:selected').text()
									var planClass=$('#reportForm input[name="planClass"]').val()
									var belongtoProj=$('#reportForm input[name="belongtoProj"]').val()
									$('#reportForm input[name="planName"]').val(function () {
										if(planYear){
											return planYear+'年'
										}else{
											return  ''
										}
									}()+planMonth+planCycle+planClass+'-'+belongtoProj)
								})
								//默认审批人为所属项目在组织机构的组织负责人及所属部门
								$.get('/ProjectInfo/getOrgUser',{projectId:projectId,pbagId:''},function (res) {
									if(res.object){
										$('#reportDutyUser').val(res.object.principalUserName || '')
										$('#reportDutyUser').attr('user_id',res.object.principalUser || '')
										$('#belongtoUnit').val(res.object.deptName || '')
										$('#belongtoUnit').attr('deptid',res.object.deptId || '')
									}
								})
								$('#reportForm select[name="planCycle"]').append(dictionaryObj['PLAN_SYCLE']['str']);
								$('#reportForm select[name="planType"]').append(dictionaryObj['TG_TYPE']['str']);

								$('#reportForm select[name="planYear"]').append(allYear);

								form.render();

								getPlanMonth($('#reportForm select[name="planYear"]').val(), function(monthSrt){
									$('#reportForm select[name="planMonth"]').html(monthSrt);
									form.render('select');
								});

								// 监听年度下拉框选择
								form.on('select(planYear)', function (data) {
									getPlanMonth(data.value, function (monthSrt) {
										$('#reportForm select[name="planMonth"]').html(monthSrt);
										form.render('select');
									});
								});

								getAutoNo({model: 'plcPlan', planClass: 1}, function(autoNo){
									$('#reportForm [name="planNo"]').val(autoNo);
								});

								// 刷新编号
								$('.refreshPlanNo').on('click', function () {
									getAutoNo({model: 'plcPlan', planClass: 1}, function (autoNo) {
										$('#reportForm [name="planNo"]').val(autoNo);
									});
								});

								$('#reportForm [name="belongtoProj"]').val(projectName);

								//新建时默认年度为当年
								$('#reportForm select[name="planYear"] option').each(function () {
									var nowYear=new Date().getFullYear()
									if($(this).text()==nowYear){
										$('#reportForm select[name="planYear"]').val($(this).val())
										form.render()
									}
								})

								$('.add_report_user').on('click', function(){
									user_id = 'reportDutyUser';
									$.popWindow("/common/selectUser?0");
								});
								$('.clear_report_user').on('click', function(){
									$('#reportDutyUser').val('');
									$('#reportDutyUser').attr('user_id', '');
									$('#belongtoUnit').val('');
									$('#belongtoUnit').attr('deptId', '');
								});
								$('.add_report_dept').on('click', function(){
									dept_id = 'belongtoUnit';
									$.popWindow("/common/selectDept?0");
								});
								$('.clear_report_dept').on('click', function(){
									$('#belongtoUnit').val('');
									$('#belongtoUnit').attr('deptId', '');
								});

							},
							yes: function (index) {
								var loadingIndex = layer.load();

								var datas = $('#reportForm').serializeArray();

								var obj = {}
								datas.forEach(function (item) {
									obj[item.name] = item.value.trim();
								});

								//关键任务类型
								obj.planType=$('#tgType_add_report').attr('dictNo')

								obj.dutyUser = $('#reportDutyUser').attr('user_id') || '';
								obj.belongtoUnit = parseInt(($('#belongtoUnit').attr('deptId') || '').replace(/,$/, ''));
								obj.belongtoProj = projectId;
								obj.planClass = 1;
								obj.tgIds = tgId
								/*判断是计划调整过的*/
								obj.revisionYn = 1
								obj.taskApproval = 1
								obj.agreeStatus = 2
								obj.apprivalStatus = 1

								//编制依据
								var attachmentId1 = '';
								var attachmentName1 = '';
								for (var i = 0; i < $('#fileContent .dech').length; i++) {
									attachmentId1 += $('#fileContent .dech').eq(i).find('input').val();
									attachmentName1 += $('#fileContent a').eq(i).attr('name');
								}
								obj.attachmentId1=attachmentId1
								obj.attachmentName1=attachmentName1

								if(!obj.attachmentId1){
									layer.close(loadingIndex);
									layer.msg( '请上传编制依据！', {icon: 0, time: 1000});
									return false;
								}

								// 判断必填项
								var $requiredEles = $('.required_field', $('#reportForm'));
								var isLock = false;
								$requiredEles.each(function () {
									var key = $(this).attr('field_name');
									var value = $(this).parent().text();

									if (!obj[key]) {
										layer.close(loadingIndex);
										layer.msg(value.replace(/\*$/, '') + '不能为空！', {icon: 0, time: 1000});
										isLock = true;
										return false;
									}
								});

								if (!isLock) {
									$.post('/plcPlan/addPlcPlan', obj, function(res){
										layer.close(loadingIndex);
										if (res.flag) {
											if (res.object == 1) {
												layer.msg(res.msg, {icon: 2, time: 1000});
											} else {
												layer.msg('提交成功！', {icon: 1, time: 1000});
												layer.close(index);
												$('.layui-tab-title li').eq(0).trigger('click')
											}
										} else {
											layer.msg('保存失败！', {icon: 2, time: 1000});
										}
									});
								}
							}
						});
					}
					/***
					 * 职能关键任务上报方法
					 * @param targetType (关键任务类型)
					 * @param projOrgId
					 * @param projectName (项目名称)
					 */
					function reportPlanDept(projOrgId,tgId,projectName){
						layer.open({
							type: 1,
							title: '计划提交',
							btn: ['保存','取消'],
							area: ['1000px', '500px'],
							content: '<form class="layui-form" id="reportForm" style="padding: 20px 15px;" lay-filter="reportForm">' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs6">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">计划编号<span class="required_field" field_name="planNo">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="planNo" readonly autocomplete="off" class="layui-input" style="display: inline-block;width: 300px;background:#e7e7e7;">' +
									'<span class="refreshPlanNo" style="margin-left: 10px;color: rgb(30, 159, 255);cursor: pointer;">刷新</span>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs6">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">类型<span class="required_field" field_name="planClass">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="planClass" readonly autocomplete="off" class="layui-input" value="职能关键任务" style="background:#e7e7e7;">' +
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">周期类型<span class="required_field" field_name="planCycle">*</span></label>' +
									'<div class="layui-input-block">' +
									'<select name="planCycle" disabled></select>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">年度<span class="required_field" field_name="planYear">*</span></label>' +
									'<div class="layui-input-block">' +
									'<select name="planYear" lay-filter="planYear">' +
									'<option value="">请选择</option>'+
									'</select>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">月度</label>' +
									'<div class="layui-input-block">' +
									'<select name="planMonth"></select>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">关键任务类型<span class="required_field" field_name="planType">*</span></label>' +
									'<div class="layui-input-block">' +
									'<select name="planType"></select>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">审批人<span class="required_field" field_name="dutyUser">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="dutyUser" readonly id="reportDutyUser" class="layui-input" style="display: inline-block; width: 150px;background-color: #e7e7e7;">' +
									'<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_report_user">添加</span>' +
									'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_report_user">清空</span>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-col-xs4">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">责任部门<span class="required_field" field_name="belongtoUnit">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="belongtoUnit" id="belongtoUnit" style="display: inline-block;background-color: #e7e7e7;" readonly autocomplete="off" class="layui-input">' +
									/*'<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_report_dept">添加</span>' +
									'<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_report_dept">清空</span>' +*/
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs12">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">责任部门</label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="belongtoDept" autocomplete="off" class="layui-input" readonly style="background:#e7e7e7;">' +
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'<div class="layui-row">' +
									'<div class="layui-col-xs12">' +
									'<div class="layui-form-item">' +
									'<label class="layui-form-label">计划名称<span class="required_field" field_name="planName">*</span></label>' +
									'<div class="layui-input-block">' +
									'<input type="text" name="planName" autocomplete="off" class="layui-input" style="display: inline-block;width: 88%">' +
									' <button type="button" class="layui-btn layui-btn-sm autoPlanName" style="margin-left: 15px">生成名称</button>'+
									'</div>' +
									'</div>' +
									'</div>' +
									'</div>' +
									'</form>',
							success: function(){
								/*自动生成计划名称*/
								$('.autoPlanName').on("click",function () {
									var planYear=$('#reportForm select[name="planYear"]').val()
									var planMonth=$('#reportForm select[name="planMonth"]').val()
									var planCycle=$('#reportForm select[name="planCycle"] option:selected').text()
									var planClass=$('#reportForm input[name="planClass"]').val()
									var belongtoDept=$('#reportForm input[name="belongtoDept"]').val()
									$('#reportForm input[name="planName"]').val(planYear+'年'+planMonth+planCycle+planClass+'-'+belongtoDept)
								})
								//默认审批人为组织机构的组织负责人及所属部门
								$.get('/plcOrg/queryId', {projOrgId:projOrgId}, function (res) {
									if(res.object){
										$('#reportDutyUser').val(res.object.principalUserName || '')
										$('#reportDutyUser').attr('user_id',res.object.principalUser || '')
										$('#belongtoUnit').val(res.object.deptName || '')
										$('#belongtoUnit').attr('deptid',res.object.deptId || '')
									}
								})

								$('#reportForm select[name="planCycle"]').append(dictionaryObj['PLAN_SYCLE']['str']);
								$('#reportForm select[name="planType"]').append(dictionaryObj['TG_TYPE']['str']);

								$('#reportForm select[name="planYear"]').append(allYear);

								form.render();

								getPlanMonth($('#reportForm select[name="planYear"]').val(), function(monthSrt){
									$('#reportForm select[name="planMonth"]').html(monthSrt);
									form.render('select');
								});

								// 监听年度下拉框选择
								form.on('select(planYear)', function (data) {
									getPlanMonth(data.value, function (monthSrt) {
										$('#reportForm select[name="planMonth"]').html(monthSrt);
										form.render('select');
									});
								});

								getAutoNo({model: 'plcPlan', planClass: 2}, function(autoNo){
									$('#reportForm [name="planNo"]').val(autoNo);
								});

								// 刷新编号
								$('.refreshPlanNo').on('click', function () {
									getAutoNo({model: 'plcPlan', planClass: 2}, function (autoNo) {
										$('#reportForm [name="planNo"]').val(autoNo);
									});
								});

								//新建时默认年度为当年
								$('#reportForm select[name="planYear"] option').each(function () {
									var nowYear=new Date().getFullYear()
									if($(this).text()==nowYear){
										$('#reportForm select[name="planYear"]').val($(this).val())
										form.render()
									}
								})

								$('.add_report_user').on('click', function(){
									user_id = 'reportDutyUser';
									$.popWindow("/common/selectUser?0");
								});
								$('.clear_report_user').on('click', function(){
									$('#reportDutyUser').val('');
									$('#reportDutyUser').attr('user_id', '');
									$('#belongtoUnit').val('');
									$('#belongtoUnit').attr('deptId', '');
								});
								$('.add_report_dept').on('click', function(){
									dept_id = 'belongtoUnit';
									$.popWindow("/common/selectDept?0");
								});
								$('.clear_report_dept').on('click', function(){
									$('#belongtoUnit').val('');
									$('#belongtoUnit').attr('deptId', '');
								});

								$('#reportForm [name="belongtoDept"]').val(projectName);

								//新建时默认周期类型为年度
								$('#reportForm select[name="planCycle"] option').each(function () {
									if($(this).text()=='年度'){
										$('#reportForm select[name="planCycle"]').val($(this).val())
										form.render()
									}
								})
								//新建时默认计划类型为年度关键任务
								$('#reportForm select[name="planType"] option').each(function () {
									if($(this).text()=='年度关键任务'){
										$('#reportForm select[name="planType"]').val($(this).val())
										form.render()
									}
								})

							},
							yes: function (index) {
								var loadingIndex = layer.load();

								var datas = $('#reportForm').serializeArray()

								var obj = {}
								datas.forEach(function (item) {
									obj[item.name] = item.value.trim();
								});

								obj.dutyUser = $('#reportDutyUser').attr('user_id') || '';
								obj.belongtoUnit = parseInt(($('#belongtoUnit').attr('deptId') || '').replace(/,$/, ''));
								obj.belongtoDept = projOrgId;
								obj.planClass = 2;
								obj.tgIds = tgId
								obj.planCycle = $('#reportForm select[name="planCycle"]').val()
								/*判断是计划调整过的*/
								obj.revisionYn = 1
								obj.taskApproval = 1
								obj.agreeStatus = 2
								obj.apprivalStatus = 1

								// 判断必填项
								var $requiredEles = $('.required_field', $('#reportForm'));
								var isLock = false;
								$requiredEles.each(function () {
									var key = $(this).attr('field_name');
									var value = $(this).parent().text();

									if (!obj[key]) {
										layer.close(loadingIndex);
										layer.msg(value.replace(/\*$/, '') + '不能为空！', {icon: 0, time: 1000});
										isLock = true;
										return false;
									}
								});

								if (!isLock) {
									$.post('/plcPlan/addPlcPlan', obj, function(res){
										layer.close(loadingIndex);
										if (res.flag) {
											if (res.object == 1) {
												layer.msg(res.msg, {icon: 2, time: 1000});
											} else {
												layer.msg('提交成功！', {icon: 1, time: 1000});
												layer.close(index);
												$('.layui-tab-title li').eq(0).trigger('click')
											}
										} else {
											layer.msg('保存失败！', {icon: 2, time: 1000});
										}
									});
								}
							}
						});
					}
                });
            }

            //判断是否该为空
            function isUndefined(data) {
                if (data == 1) {
                    return '是'
                } else if (data == 0) {
                    return '否'
                } else {
                    return ''
                }
            }

            //将毫秒数转为yyyy-MM-dd格式时间
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

            /***
             * 获取计划期间月度
             * @param year (月度对应年份)
             * @param cb (回调函数)
             */
            function getPlanMonth(year, fn) {
                $.get('/planPeroidSetting/showAllSet', {periodYear: year}, function (res) {
                    var str = '<option value="">请选择</option>';
                    if (res.object.length > 0) {
                        res.object.forEach(function (item) {
                            str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>'
                        });
                    }
                    if (fn) {
                        fn(str);
                    }
                });
            }

            /**
             * 处理主项关键任务的数据为树结构
             * @param data 主项关键任务数据
             * @returns {[]} 返回树结构数组
             */
            function getTreeData(data) {
                var treeData = [];
                treeData = data.bags.concat(data.plcTarget);
                return treeData;
            }

            // 初始化页面操作权限
            function initAuthority() {
                // 是否设置页面权限
                if (authorityObject) {
                    // 检查保存权限
                    if (authorityObject['09']) {
                        $('.query_button_group').show();
                    }
                }
            }
            
            function resizeQuery() {
				var queryWidth = $('.query ').width();
                $('.query_item').width(queryWidth/5);
                $('.theParentBox .query_button_group ').width($('.query ').width()-$('.query_item').width()*4 -100);
            }
            
            // 附件查阅
            $(document).on('click', '.yulan', function () {
                var url = $(this).attr('data-url');
                pdurl($.UrlGetRequest('?' + url), url);
            });
            
            //判断是否显示空
            function isShowNull(data) {
                if (!!data) {
                    return data
                } else {
                    return ''
                }
            }

			/***
			 * 计算计划工期
			 * @param beginTime (开始时间)
			 * @param endTime (结束时间)
			 * @returns {number}
			 */
			function timeRange(beginTime, endTime) {
				var t1 = new Date(beginTime);
				var t2 = new Date(endTime);
				var time = t2.getTime() - t1.getTime();
				var days = parseInt(time / (1000 * 60 * 60 * 24))+1;
				return days;
			}

			//主项前置关键任务的项目下所有关键任务
			function allTarget(year,month,projectId){
				var allTarget=''
				$.ajax({
					url:'/projectTarget/selectPre',
					dataType:'json',
					type:'get',
					async:false,
					data:{
						year:year,
						month:month,
						projectId:projectId
					},
					success:function(res){
						var data=res.obj
						var targetName='<option value=""></option>'
						data.forEach(function (item) {
							targetName+='<option value="'+item.tgId+'">'+item.tgName+'</option>'
						})
						allTarget=targetName
					}
				})
				return allTarget
			}
			//职能前置关键任务的项目下所有关键任务
			function allTargetDept(year,month,deptId){
				var allTarget=''
				$.ajax({
					url:'/projectTarget/selectZhiByTgId',
					dataType:'json',
					type:'get',
					async:false,
					data:{
						year:year,
						month:month,
						deptId:deptId,
					},
					success:function(res){
						var data=res.obj
						var targetName='<option value=""></option>'
						data.forEach(function (item) {
							targetName+='<option value="'+item.tgId+'">'+item.tgName+'</option>'
						})
						allTarget=targetName
					}
				})
				return allTarget
			}

			//附件上传 方法
			var timer=null;
			function fileuploadFn(formId,element) {
				$(formId).fileupload({
					dataType:'json',
					progressall: function (e, data) {
						var progress = parseInt(data.loaded / data.total * 100, 10);
						element.siblings('.progress').find('.bar').css(
								'width',
								progress + '%'
						);
						element.siblings('.barText').html(progress + '%');
						if(progress >= 100){  //判断滚动条到100%清除定时器
							timer=setTimeout(function () {
								element.siblings('.progress').find('.bar').css(
										'width',
										0 + '%'
								);
								element.siblings('.barText').html('');
							},2000);

						}
					},
					done: function (e, data) {
						if(data.result.obj != ''){
							var data = data.result.obj;
							var str = '';
							var str1 = '';
							for (var i = 0; i < data.length; i++) {
								var gs = data[i].attachName.split('.')[1];
								if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
									str += '';
									layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
										layer.closeAll();
									});
								}
								else{
									var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
									var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
									var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
									var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

									str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
								}
							}
							element.append(str);
						}else{
							layer.alert('添加附件大小不能为空!',{},function(index){
								layer.close(index);
							});
						}
					}
				});
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
								layer.msg('删除成功', {icon: 1, time: 1000});
								$(_this).parent().remove();
							} else {
								layer.msg('删除失败', {icon: 2, time: 1000});
							}
						}
					});
				});
			});
		
		</script>
	</body>
</html>
