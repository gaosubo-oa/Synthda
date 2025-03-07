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
		<title>子任务审批</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/dropdown.min.css">
		
<%--		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
		<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--		<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
		<%--		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/excel.js"></script>--%>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
		
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
				padding: 15px 15px 0px 15px;
				box-sizing: border-box;
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
			
			.project .layui-table-tool-temp {
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
			
			.layui-tab-item {
				overflow-y: inherit;
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
			
			.required_field {
				margin-right: 2px;
				font-size: 25px;
				line-height: 20px;
				vertical-align: text-top;
				color: red;
			}
			
			.layui-treeSelect .ztree li span.button.switch {
				top: 1px !important;
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
		<div class="container" style="">
			<%--<div class="header">
				<div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px">
                        <img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt="">
                        <span style="margin-left: 10px">计划审批</span>
                    </span>
				</div>
			</div>
			<hr>--%>
			<div class="layui-tab layui-tab-brief" lay-filter="reportTabs">
				<input type="hidden" value="4" id="agreeStatus">
				<input type="hidden" value="" id="planClass">
				<input type="hidden" value="" id="planId">
				<input type="hidden" value="" id="projectOrDeptId">
				<input type="hidden" value="" id="targetIdOrTaskId">
				<ul class="layui-tab-title">
					<li class="layui-this">未审批计划(<span class="noApproved"></span>)</li>
					<li>已审批计划</li>
				</ul>
				<div class="layui-tab-content">
					<div class="layui-tab-item layui-show">
						<div class="theParentBox">
							<form class="layui-form query" style="padding: 5px 0;">
								<div class="layui-row" style="padding: 5px 0;">
									<div class="layui-form-item layui-col-xs2">
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
									<div class="layui-form-item inputs layui-col-xs2">
										<label class="layui-form-label">周期类型:</label>
										<div class="layui-input-block">
											<select name="planCycle" lay-verify="required">
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
										<label class="layui-form-label">计划类型:</label>
										<div class="layui-input-block">
											<select name="planType">
												<option value="">请选择</option>
											</select>
										</div>
									</div>
									<div class="query_button_group layui-col-xs2" style="display: none;">
										<button type="button" class="layui-btn layui-btn-sm more_query" isshow="0" style="margin-left: 15px;">
											<i class="layui-icon layui-icon-down" style="margin: 0;"></i>
										</button>
										<button type="button" class="layui-btn layui-btn-sm search_one">查询</button>
										<button type="reset" id="resetBtn" class="layui-btn layui-btn-sm">重置</button>
									</div>
								</div>
								<div class="layui-row hide_query" style="display: none;padding: 5px 0;">
									<div class="layui-form-item inputs layui-col-xs2">
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
									<div class="layui-form-item inputs layui-col-xs2">
										<label class="layui-form-label">月度:</label>
										<div class="layui-input-block">
											<select name="planMonth"></select>
										</div>
									</div>
									<div class="layui-form-item inputs layui-col-xs2">
										<label class="layui-form-label">责任人:</label>
										<div class="layui-input-block">
											<input type="text" readonly placeholder="选择责任人" name="dutyUser" id="query_user" class="layui-input"
											       style="cursor: pointer;background-color: #e7e7e7;"/>
										</div>
									</div>
									<div class="layui-form-item inputs layui-col-xs2">
										<label class="layui-form-label">所属部门:</label>
										<div class="layui-input-block">
											<input type="text" readonly placeholder="选择所属部门" name="belongtoUnits" id="query_dept" class="layui-input"
												   style="cursor: pointer;background-color: #e7e7e7;"/>
										</div>
									</div>
								</div>
							</form>
							<div class="project">
								<table id="reportedTable" lay-filter="reportedTable"></table>
							</div>
						</div>
						<div style="display: none;" class="theChildBox">
							<form class="layui-form query layui-row">
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
										<select name="planType" class="planType" lay-verify="required">
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
									<button type="button" class="layui-btn layui-btn-sm query_btn search">查询</button>
								</div>
							</form>
							<div id="theChildPlanBox">
								<table id="theChildPlan" lay-filter="theChildPlan"></table>
							</div>
							<div id="targetTableBox">
								<table id="targetTable" lay-filter="targetTable"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="barDemo">
			<div class="clearfix isAgree">
				<%--				{{# if(authorityObject && authorityObject['25']){ }}--%>
				<%--				<a class="layui-btn layui-btn-sm " lay-event="disagree" style="float: right; margin-right: 45px;">退回</a>--%>
				<%--				{{# } }}--%>
				<%--				{{# if(authorityObject && authorityObject['33']){ }}--%>
				<%--				<a class="layui-btn layui-btn-sm " lay-event="agree" style="float: right; margin-right: 10px;">同意</a>--%>
				<%--				{{# } }}--%>
			</div>
		</script>
		
		<script type="text/html" id="childDemo">
			<div>
				<span style="display: inline-block;width: 72%"><i class="layui-icon layui-icon-next" style="color: green"></i><span
						class="titleSp" style="color: blue"></span></span>
				
				<span class="child_opt_box">
					{{# if(authorityObject && authorityObject['25']){ }}
					<a class="layui-btn layui-btn-sm " lay-event="disagree" style="float: right; margin-left: 10px;">退回</a>
					{{# } }}
					{{# if(authorityObject && authorityObject['33']){ }}
					<a class="layui-btn layui-btn-sm " lay-event="agree" style="float: right;">同意</a>
					{{# } }}
					<a class="layui-btn layui-btn-sm" lay-event="delete" style="float: right;">删除</a>
					<a class="layui-btn layui-btn-sm" lay-event="edit" style="float: right">编辑</a>
					<a class="layui-btn layui-btn-sm" lay-event="add" style="float: right;">新增</a>
					<a class="layui-btn layui-btn-sm export_link" lay-event="export" style="float: right;">导出</a>
				</span>
			</div>
		</script>
		
		<script type="text/javascript">
			//定义点击排序后变颜色
			var colorChange_up=''
			var colorChange_down=''


            resizeQuery();

            window.onresize = function () {
                resizeQuery();
            }

            initAuthority();
            var user_id = '';

            var dictionaryObj = {
                PLAN_SYCLE: {},
                PLAN_TYPE: {},
                UNIT: {},
                PLAN_PHASE: {},
                CONTROL_LEVEL: {},
                CGCL_TYPE: {},
                RENWUJIHUA_TYPE: {},
                TG_TYPE: {},
                ORGANIZATION_TYPE: {},
                PLAN_RATE: {}
            }
            var dictionaryStr = 'PLAN_SYCLE,PLAN_TYPE,UNIT,PLAN_PHASE,CONTROL_LEVEL,CGCL_TYPE,RENWUJIHUA_TYPE,TG_TYPE,ORGANIZATION_TYPE,PLAN_RATE';
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

            function init() {
                layui.use(['element', 'form', 'table', 'treeTable', 'soulTable', 'laydate', 'treeSelect', 'eleTree', 'dropdown'], function () {
                    var form = layui.form,
                        table = layui.table,
                        element = layui.element,
                        laydate = layui.laydate,
                        treeTable = layui.treeTable,
                        treeSelect = layui.treeSelect,
                        eleTree = layui.eleTree,
                        dropdown = layui.dropdown;
                    soulTable = layui.soulTable;

                    var reportedTable = null;
                    var insTb = null;

                    $('.query [name="planType"]').append(dictionaryObj['PLAN_TYPE']['str']);
                    $('.query [name="planCycle"]').append(dictionaryObj['PLAN_SYCLE']['str']);

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

                    // 计划期间年度列表
                    var allYear = '';

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

                    $('#query_user').on('click',function () {
                        user_id = 'query_user';
                        $.popWindow('/common/selectUser?0');
                    });
					$('#query_dept').on('click',function () {
						dept_id = 'query_dept';
						$.popWindow('/common/selectDept');
					});
                    
                    // 更多查询
	                $('.more_query').on('click',function () {
                        var isShow = $(this).attr('isshow');
                        if (isShow == 0) {
                            $(this).children().removeClass('layui-icon-down').addClass('layui-icon-up');
                            $('.hide_query').show();
                            $(this).attr('isshow', 1);
                        } else {
                            $(this).children().removeClass('layui-icon-up').addClass('layui-icon-down');
                            $('.hide_query').hide();
                            $(this).attr('isshow', 0);
                        }
                    });

                    // 外层查询
                    $('.search_one').on('click',function () {
                        var data = {};
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
							data['belongtoUnits'] = $('#query_dept').attr('deptid')
						}else{
							data['belongtoUnits'] = '';
						}

                        initReportedTable(1, $('#agreeStatus').val(), data);
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
					$('#resetBtn').on('click',function () {
						//清空选人/部门控件
						$('#query_user').attr('user_id','')
						$('#query_dept').attr('deptid','')
					})

                    // 切换未审批、已审批
                    element.on('tab(reportTabs)', function (data) {
                        $('.theChildBox').hide();
                        $('.theParentBox').show();
                        switch (data.index) {
                            case 0:
                                // 重置查询表单
                                $('#resetBtn').trigger('click');
                                $('#resetChildBtn').trigger('click');
                                initReportedTable(1, 4);
                                $('.isAgree').show();
                                $('#agreeStatus').val(4);
                                break;
                            case 1:
                                // 重置查询表单
                                $('#resetBtn').trigger('click');
                                $('#resetChildBtn').trigger('click');
                                initReportedTable(1, 5);
                                $('.isAgree').hide();
                                $('#agreeStatus').val(5);
                                break;
                        }
                    });

                    initReportedTable(1, 4);

                    function initReportedTable(apprivalStatus, agreeStatus, searchData) {
                        var whereData = {
                            apprivalStatus: apprivalStatus,
                            agreeStatus: agreeStatus,
	                        targetOrItem: 2,
                            _: new Date().getTime()
                        }

                        if (!!searchData) {
                            whereData = $.extend({}, whereData, searchData);
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
                                            return '<a projectId=' + d.projectId + ' style="' + style + '">' + d.planName +function () {
												if(d.modify==1){
													return  '<span style="color: red">(修编)</span>'
												}else{
													return ''
												}
											}()+ '</a>'
                                        }
                                    },
                                    {
                                        field: 'agreeStatus', title: '审批状态', templet: function (d) {
                                            if (d.agreeStatus == 3) {
                                                return '<a style="color: red;cursor: pointer;text-decoration: underline;" class="back_detail" returnComments="' + isShowNull(d.returnComments) + '" questionName="' + isShowNull(d.questionName) + '">退回</a>'
                                            } else if (d.agreeStatus == 1) {
                                                return '待审批';
                                            } else if (d.agreeStatus == 2) {
                                                return '同意';
                                            } else {
                                                return '待审批';
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
                                    {field: 'dutyUserName', title: '责任人'},
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
                                where: whereData,
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    msgName: 'msg',
                                    countName: 'totleNum',
                                    dataName: 'obj'
                                },
                                request: {
                                    pageName: 'page' //页码的参数名称，默认：page
                                    , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                },
                                done: function (res, curr, count) {
                                    if ($('.layui-tab-title .layui-this').text() != '已审批计划') {
                                        $('.noApproved').html(count)
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
                            reportedTable.reload({
                                where: whereData,
                                cur: {
                                    page: 1
                                },
                                done: function (res, curr, count) {
                                    if ($('.layui-tab-title .layui-this').text() != '已审批计划') {
                                        $('.noApproved').html(count)
                                    }
                                    soulTable.render(this);
                                    resizeQuery();
                                }
                            });
                        }
                    }

                    //监听单元格编辑事件
                    table.on('tool(reportedTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        switch (layEvent) {
                            case 'nameLink':
								//清空切换时排序高亮
								colorChange_up=false
								colorChange_down=false
                                var title = $(this).text();
                                var id = data.planClass == 1 ? data.belongtoProj : data.belongtoDept;
                                var targetIdOrTaskId = data.planClass == 3 ? data.planItemIds || '' : data.tgIds || '';
                                var datas = {
                                    _: new Date().getTime(),
                                    planId: data.planId
                                }
                                initTaskTable(data.planClass, datas, function () {
                                    $('.titleSp').text(title);
                                    $('.theChildBox').show();
                                    $('.theParentBox').hide();
                                    if ($('#agreeStatus').val() == 5) {
                                        $('.export_link').siblings().hide();
                                    }
                                    $('#planClass').val(data.planClass);
                                    $('#planId').val(data.planId);
                                    $('#projectOrDeptId').val(id);
                                    $('#targetIdOrTaskId').val(targetIdOrTaskId);
                                });
                                break;
                        }
                    });

                    /**
                     * 加载关键任务、子任务方法
                     * @param type (类型)
                     * @param id (参数)
                     * @param fn (回调函数)
                     */
                    function initTaskTable(type, id, fn) {
                        //type--1主项 2职能 3子任务
                        if (type == 1) {
                            var cols = [[
                                {type: 'checkbox'},
	                            {type: 'numbers', title: '序号', align: 'left', width: 100},
                                {
                                    field: 'tgName', title: '子项目/关键任务名称', minWidth: 300, templet: function (d) {
                                        if (d.projectName) {
                                            return '<span>【项目】' + d.projectName + '</span>'
                                        } else if (d.pbagName) {
                                            return '<span>【子项目】' + d.pbagName + '</span>'
                                        } else if (d.tgName) {
                                            return '<span class="target_detail" tgId="' + d.tgId + '" style="color: blue;cursor: pointer;">【关键任务】' + d.tgName + '</span>'
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                                {
                                    field: 'controlLevel',
                                    title: '关注等级',
                                    minWidth: 100,
                                    templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || '';
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
                                    field: 'dutyUserName', title: '责任人', minWidth: 130, templet: function (d) {
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
                                    field: 'planContinuedDate', title: '计划工期', minWidth: 100, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return d.planContinuedDate || '';
                                        }
                                    }
                                }
                                , {
                                    field: 'planStartDate', title: '计划开始时间', minWidth: 130, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return format(d.planStartDate || '');
                                        }
                                    }
                                }
                                , {
                                    field: 'planEndDate', title: '计划完成时间', minWidth: 130, templet: function (d) {
                                        if (d.tgId == '' || d.tgId == undefined) {
                                            return '';
                                        } else {
                                            return format(d.planEndDate || '');
                                        }
                                    }
                                }
                                , {
                                    field: 'resultStandard', title: '完成标准', minWidth: 130, templet: function (d) {
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
                                // {field: 'tgNo', title: '关键任务编号', minWidth: 300}
                                , {
                                    field: 'tgName', title: '关键任务名称', minWidth: 400, templet: function (d) {
                                        return '<span class="target_detail" tgId="' + d.tgId + '" style="color: blue;cursor:pointer;">' + (d.tgName || '') + '</span>'
                                    }
                                }
                                , {
                                    field: 'planSycle', title: '周期类型', minWidth: 100, templet: function (d) {
                                        return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || '';
                                    }
                                }
                                , {
                                    field: 'tgType', title: '关键任务类型', minWidth: 100, templet: function (d) {
                                        return dictionaryObj['TG_TYPE']['object'][d.tgType] || '';
                                    }
                                }
                                , {field: 'dutyUserName', title: '责任人', minWidth: 130}
                                , {
                                    field: 'mainCenterDeptName', title: '责任部门', minWidth: 150, templet: function (d) {
                                        return (d.mainCenterDeptName || '').replace(/,$/, '');
                                    }
                                }
                                , {field: 'planContinuedDate', title: '计划工期', minWidth: 100}
                                , {
                                    field: 'planStartDate', title: '计划开始时间', minWidth: 130, templet: function (d) {
                                        return format(d.planStartDate);
                                    }
                                }
                                , {
                                    field: 'planEndDate', title: '计划完成时间', minWidth: 130, templet: function (d) {
                                        return format(d.planEndDate);
                                    }
                                }
                                , {field: 'resultStandard', title: '完成标准', minWidth: 130}
                                , {field: 'riskPoint', title: '风险点', minWidth: 130}
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
                                , {field: 'difficultPoint', title: '难度点', minWidth: 130}
                                , {field: 'tgDesc', title: '关键任务描述', minWidth: 150}
								, {field: 'hardDegree', title: '难度系数', minWidth: 150}
                            ]]
                            var childName = "children"
                        } else if (type == 3) {
                            var cols = [[
                                {type: 'checkbox'},
	                            {type: 'numbers', title: '序号', align: 'left', width: 100},
                                // {field: 'taskNo', title: '编号', minWidth: 300},
                                {
                                    field: 'taskName',
                                    title: '子任务名称',
                                    minWidth: 400,
                                    templet: function (d) {
                                        return '<span class="task_detail" planItemId="' + d.planItemId + '" style="color: blue;cursor:pointer;">' + (d.taskName || '') + '</span>';
                                    }
                                },
                                {
                                    field: 'planSycle', title: '周期类型', minWidth: 100, templet: function (d) {
                                        return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                                    }
                                },
                                {
                                    field: 'taskType', title: '任务来源', minWidth: 100, templet: function (d) {
                                        return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || '';
                                    }
                                },
                                // {
                                //     field: 'planStage', title: '计划阶段', templet: function (d) {
                                //         return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                                //     }
                                // },
                                // {field: 'designQuantity', title: '设计量'},
                                // {field: 'itemQuantity', title: '工程量'},
                                // {
                                //     field: 'itemQuantityNuit', title: '单位', templet: function (d) {
                                //         return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || ''
                                //     }
                                // },
                                {field: 'dutyUserName', minWidth: 130, title: '负责人'},
                                {
                                    field: 'mainCenterDeptName', title: '责任部门', minWidth: 150, templet: function (d) {
                                        return (d.mainCenterDeptName || '').replace(/,$/, '');
                                    }
                                },
                                {field: 'planContinuedDate', title: '计划工期', minWidth: 100},
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
                                    field: 'resultStandard', title: '完成标准', minWidth: 130
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
                                    field: 'taskDesc', title: '子任务描述', minWidth: 150,
                                }
								, {field: 'hardDegree', title: '难度系数', minWidth: 150}
                            ]]
                            var childName = "items"
                        }
                        insTb = treeTable.render({
                            elem: '#theChildPlan'
                            , url: '/plcPlan/selectByPlanId'
                            , where: id
                            , toolbar: '#childDemo'
                            , defaultToolbar: ['']
	                        , height: 'full-230'
                            , tree: {
                                iconIndex: 1,
                                // isPidData: true,
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
							done:function () {
                            	if(type==3){
									$('#theChildPlanBox thead th').eq(5).find('.ew-tree-table-cell-content').html('<span style="cursor: move;">负责人</span><span class="layui-table-sort layui-inline"><i class="layui-edge layui-table-sort-asc sort" title="升序"></i><i class="layui-edge layui-table-sort-desc sort" title="降序"></i></span>')
								}
								//给选中高亮
								if(colorChange_up){
									$('.layui-table-sort-asc').css('border-bottom-color','#666')
								}else if(colorChange_down){
									$('.layui-table-sort-desc').css('border-top-color','#666')
								}
							}
                        });
                        if (fn) {
                            fn();
                        }
                    }

					//监听责任人排序
					$(document).on('click','.sort',function () {
						if($(this).attr('title')=='升序'){
							var orderBy=1
							colorChange_up=true
							colorChange_down=false
						}else{
							var orderBy=2
							colorChange_down=true
							colorChange_up=false
						}
						var title = $('.titleSp').text();
						insTb.reload({
							where:{
								orderBy:orderBy //排序方式
							},
						})
						$('.titleSp').text(title);

					})

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
                                questionNames.forEach(function (item) {
                                    checkEleStr += '<li style="padding: 5px;">' + item + '</li>';
                                });
                                $('#checkTgOrTask').html(checkEleStr);
                            }
                        });
                    });

                    //子表-表标点击事件
                    $(document).on('click', '.titleSp', function () {
                        $('.theChildBox').hide();
                        $('.theParentBox').show();
                    });

                    // 树表头部点击事件
                    treeTable.on('toolbar(theChildPlan)', function (obj) {
                        var planClass = $('#planClass').val();
                        var planId = $('#planId').val();
                        var checkStatus = insTb.checkStatus();
                        switch (obj.event) {
                            case 'edit':
                                var dataArr = [];
                                var tip = '';
                                // 主项计划
                                if (planClass == 1) {
                                    checkStatus.forEach(function (v, i) {
                                        if (v.tgId) {
                                            dataArr.push(v);
                                        }
                                    });
                                    tip = '请选择一项关键任务！';
                                } else if (planClass == 2) { // 职能计划
                                    dataArr = checkStatus;
                                    tip = '请选择一项关键任务！';
                                } else if (planClass == 3) { // 子任务计划
                                    dataArr = checkStatus;
                                    tip = '请选择一项子任务！';
                                }

                                if (dataArr.length != 1) {
                                    layer.msg(tip, {icon: 0, time: 1000});
                                    return false;
                                }
                                var data = dataArr[0];
                                editTargetOrTask(data, planClass, planId, 2);
                                break;
                            case 'add':
                                editTargetOrTask('', planClass, planId, 1);
                                break;
                            case 'delete':
                                var dataObj = {};
                                var ids = [];
                                var tip = '';
                                var deleteUrl = '';
                                // 主项关键任务 和 职能关键任务
                                if (planClass == 1 || planClass == 2) {
                                    checkStatus.forEach(function (v, i) {
                                        if (v.tgId) {
                                            ids.push(v.tgId);
                                        }
                                    });
                                    dataObj.id = ids;
                                    deleteUrl = '/projectTarget/deleteContent';
                                    tip = '请选择至少一项关键任务！';
                                } else if (planClass == 3) { // 子任务计划
                                    checkStatus.forEach(function (v, i) {
                                        if (v.planItemId) {
                                            ids.push(v.planItemId);
                                        }
                                    });
                                    dataObj.planItemId = ids;
                                    deleteUrl = '/plcProjectItem/delete';
                                    tip = '请选择至少一项子任务！';
                                }

                                if (ids.length === 0) {
                                    layer.msg(tip, {icon: 0, time: 1000});
                                    return false;
                                }

                                layer.confirm('确定删除该条数据吗？', function () {
                                    $.ajax({
                                        url: deleteUrl,
                                        dataType: 'json',
                                        type: 'post',
                                        data: dataObj,
                                        traditional: true,
                                        success: function (res) {
                                            if (res.flag) {
                                                layer.msg('删除成功！', {icon: 1, time: 1000}, function () {
                                                    var title = $('.titleSp').text();
                                                    var datas = {
                                                        _: new Date().getTime(),
                                                        planId: planId
                                                    }
                                                    initTaskTable(planClass, datas, function () {
                                                        $('.titleSp').text(title);
                                                    });
                                                });
                                            } else {
                                                layer.msg('删除失败！', {icon: 2, time: 1000});
                                            }
                                        }
                                    });
                                });
                                break;
                            case 'agree':
                                isAgree(2, planId, planClass)
                                break;
                            case 'disagree':
                                isAgree(3, planId, planClass)
                                break;
	                        case 'export':
	                            insTb.exportData('csv');
	                            break;
                        }
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
                                                '      <td class="td_title">责任部门</td>\n' +
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
                                                }() + '</td>\n' +
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
                                                }() + '</td>\n' +
                                                '    </tr>\n' +
                                                '    <tr>\n' +
                                                '      <td class="td_title">难度点</td>\n' +
                                                '      <td colspan="1">' + isShowNull(taskData.difficultPoint) + '</td>\n' +
                                                '      <td class="td_title">风险点</td>\n' +
                                                '      <td colspan="3">' + isShowNull(taskData.riskPoint) + '</td>\n' +
                                                '    </tr>\n' +
													'<tr>' +
													'<td class="td_title">编制依据附件</td>' +
													'<td colspan="5">' +
													function () {
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
													}() +
													'</td>' +
													'</tr>' +
                                                '  </tbody>\n' +
                                                '</table>';
                                        }

                                        $('#task_detail').html(dayReport);
                                    }
                                })
                            }
                        })
                    });

                    function isAgree(type, planIds, planClass) {
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
                        if (type == 2) {
                            layer.confirm('确定同意审批吗？', function (index) {
                                layer.close(index);
                                $.ajax({
                                    url: '/plcPlan/updateStatusByIds',
                                    dataType: 'json',
                                    type: 'post',
                                    data: {planIds: planIds, agreeStatus: type,taskApproval:2,approvalDate:today,secondApprovalDate:today},
                                    success: function (res) {
                                        layer.close(index);
                                        if (res.flag) {
                                        	$.get('/plcOrg/getClassA',{planId:planIds},function (res) {
												if(res==1){
													layer.confirm('是否立即进行分配？', function (index) {
														layer.close(index);

														var dataArr = insTb.options.data;
														var tip = '暂无可分配的关键任务'
														var ids = [];
														var targetOrTask = 1;

														if (planClass == 1) {
															ids = getTargetId(dataArr, 'tgId');
														} else if (planClass == 2) {
															if (dataArr && dataArr.length > 0) {
																dataArr.forEach(function (item) {
																	ids.push(item.tgId);
																});
															}
														} else if (planClass == 3) {
															targetOrTask = 2;
															ids = getTargetId(dataArr, 'planItemId');
															tip = '暂无可分配的子任务';
														}

														if (ids.length === 0) {
															layer.msg(tip, {icon: 0, time: 2000}, function () {
																$('.theChildBox').hide();
																$('.theParentBox').show();
																initReportedTable(1, 4);
															});
															return false;
														}else{
															/*点击确定直接打开分配确认页面*/
															window.location.reload()
															$('.one .two_menu .two .sanji li[menu_tid="741601"]',parent.document).trigger('click')
														}

														/* layer.open({
                                                             type: 1,
                                                             title: '批量分配',
                                                             btn: ['确定', '取消'],
                                                             area: ['400px', '300px'],
                                                             content: ['<div style="margin-top: 50px;padding: 20px 30px;">',
                                                                 '<input type="text" class="layui-input" id="setDutyUser" readonly style="display: inline-block;width: 250px;" />',
                                                                 '<a style="margin-left: 10px;color: #1E9FFF; cursor: pointer;" id="addDutyUser">添加</a>',
                                                                 '<a style="margin-left: 10px;color: #1E9FFF; cursor: pointer;" id="clearDutyUser">清空</a>',
                                                                 '</div>'].join(''),
                                                             success: function () {
                                                                 $('#addDutyUser').on('click', function () {
                                                                     user_id = 'setDutyUser';
                                                                     $.popWindow('/common/selectUser?0');
                                                                 });
                                                                 $('#clearDutyUser').on('click', function () {
                                                                     $('#setDutyUser').val('');
                                                                     $('#setDutyUser').attr('user_id', '');
                                                                 });
                                                             },
                                                             yes: function (index) {
                                                                 var userId = $('#setDutyUser').attr('user_id') || '';

                                                                 if (!userId) {
                                                                     layer.msg('请选择责任人！', {icon: 0, time: 1000});
                                                                     return false;
                                                                 }

                                                                 updateTaskOrTarget(targetOrTask, {ids: ids.join(','), dutyUser: userId}, function (res) {
                                                                     if (res.flag) {
                                                                         layer.close(index);
                                                                         layer.msg('分配成功', {icon: 1, time: 1000});
                                                                     } else {
                                                                         layer.msg('分配失败', {icon: 2, time: 1000});
                                                                     }
                                                                 });
                                                             },
                                                             end: function () {
                                                                 $('.theChildBox').hide();
                                                                 $('.theParentBox').show();
                                                                 initReportedTable(1, 4);
                                                             }
                                                         });*/
													}, function () {
														$('.theChildBox').hide();
														$('.theParentBox').show();
														initReportedTable(1, 4);
													});
												}else{
													$('.theChildBox').hide();
													$('.theParentBox').show();
													initReportedTable(1, 4);
												}
											})
                                        } else {
                                            layer.msg('审批失败！', {icon: 2, time: 1000});
                                        }
                                    }
                                });
                            });
                        } else {
                            var questionName = '';
                            layer.open({
                                type: 1,
                                title: '退回上报计划',
                                btn: ['确定', '取消'],
                                area: ['600px', '550px'],
                                content: ['<div style="padding: 10px;">',
                                    '<p style="padding: 5px;font-size: 16px;">退回原因:</p>',
                                    '<textarea name="backReason" placeholder="请输入退回原因" rows="3" class="layui-textarea"></textarea>',
                                    '<p style="padding: 5px;font-size: 16px;">问题关键任务/子任务编码名称:</p>',
                                    '<ul id="checkTgOrTask" style="height: 250px; overflow-y: auto;"></ul>',
                                    '</div>'].join(''),
                                success: function () {
                                    var checkStatus = insTb.checkStatus();
                                    var checkEleStr = '';
                                    if (planClass == 1) {
                                        checkStatus.forEach(function (item) {
                                            if (!!item.tgId) {
                                                var str = '(' + item.tgNo + ')' + item.tgName;
                                                questionName += str + ',';
                                                checkEleStr += '<li style="padding: 5px;">' + str + '</li>';
                                            }
                                        });
                                    } else if (planClass == 2) {
                                        checkStatus.forEach(function (item) {
                                            var str = '(' + item.tgNo + ')' + item.tgName;
                                            questionName += str + ',';
                                            checkEleStr += '<li style="padding: 5px;">' + str + '</li>';
                                        });
                                    } else if (planClass == 3) {
                                        checkStatus.forEach(function (item) {
                                            var str = '(' + item.taskNo + ')' + item.taskName;
                                            questionName += str + ',';
                                            checkEleStr += '<li style="padding: 5px;">' + str + '</li>';
                                        });
                                    }

                                    $('#checkTgOrTask').html(checkEleStr);
                                },
                                yes: function (index) {
                                    var backReason = $('textarea[name="backReason"]').val().trim();

                                    if (!backReason) {
                                        layer.msg('请输入退回原因', {icon: 0, time: 1000});
                                        $('textarea[name="backReason"]').focus();
                                        return false;
                                    }

                                    // 保存退回意见和有问题的关键任务或子任务
                                    updatePlcPlan(planIds, {returnComments: backReason, questionName: questionName});

                                    $.post('/plcPlan/updateStatusByIds', {planIds: planIds, agreeStatus: type,approvalDate:today,secondApprovalDate:today}, function (res) {
                                        if (res.flag) {
                                            layer.close(index);
                                            layer.msg('退回成功', {icon: 1, time: 1000});
                                            $('.theChildBox').hide();
                                            $('.theParentBox').show();
                                            initReportedTable(1, 4);
                                        } else {
                                            layer.msg('退回失败', {icon: 2, time: 1000});
                                        }
                                    });
                                }
                            });
                        }
                    }

                    /**
                     * 新增、修改子任务和关键任务方法
                     * @param data (关键任务或子任务数据)
                     * @param planClass (1-主项关键任务，2-职能关键任务，3-计划子任务)
                     * @param planId (项目id)
                     */
                    function editTargetOrTask(data, planClass, planId, type) {
                        var projectOrDeptId = $('#projectOrDeptId').val();
                        editPlanTask(data, planClass, planId, type, projectOrDeptId);
                    }

                    /**
                     * 新增、修改计划子任务
                     * @param data (子任务数据)
                     * @param planClass (1-主项关键任务，2-职能关键任务，3-计划子任务)
                     * @param planId (项目id)
                     */
                    function editPlanTask(data, planClass, planId, type) {
                        var layerTitle = '';
                        var url = '';
                        if (type == 1) {
                            layerTitle = '新增子任务';
                            url = '/plcProjectItem/add';
                        } else {
                            layerTitle = '编辑子任务';
                            url = '/plcProjectItem/update';
                        }

                        layer.open({
                            type: 1,
                            title: layerTitle,
                            area: ['100%', '100%'],
                            maxmin: true,
                            min: function () {
                                $('.layui-layer-shade').hide()
                            },
                            btn: ['保存', '取消'],
                            btnAlign: 'c',
                            content: ['<form class="layui-form" id="planTaskForm" lay-filter="planTaskForm" style="padding-right: 10px;">',
                                //第一行
                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                                '    <label class="layui-form-label">编号<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block" style="position: relative;padding-right: 50px;">\n' +
                                '      <input type="text" name="taskNo" readonly style="background:#e7e7e7;display:inline-block" autocomplete="off" class="layui-input jinyong testNull" title="编号">\n' +
                                '<button type="button" class="layui-btn layui-btn-sm refresh" style="position: absolute;top: 4px;right:0;">刷新</button>' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">上级子任务<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block" style="position: relative; padding-right: 50px;">\n' +
                                '<div class="layui-unselect layui-form-select" id="parentTask" style="width: 100%;">\n' +
                                '  <div class="layui-select-title">\n' +
                                '      <input type="text" placeholder="已为一级子任务" id="topItem" readonly style="background:#e7e7e7;" value="已为一级子任务" class="layui-input layui-unselect">\n' +
                                '    <i class="layui-edge"></i>\n' +
                                '  </div>\n' +
                                '  <dl class="layui-anim layui-anim-upbit" data-role="menu">\n' +
                                '    <div class="eleTree" id="parentTaskTree" lay-filter="parentTaskTree"></div>' +
                                '  </dl>\n' +
                                '</div>' +
                                '      <input type="hidden" name="parentPlanItemId" id="parentPlanItemId" value="0" class="testNull" title="上级子任务">\n' +
                                '<button type="button" class="layui-btn layui-btn-sm" id="clearParentTask" style="position: absolute;top: 4px;right:0;">清空</button>' +
                                '    </div>\n' +
                                '  </div></div>' +
                                '</div>' +
                                //第二行
                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
                                '    <label class="layui-form-label">子任务名称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="taskName"  autocomplete="off" class="layui-input jinyong testNull" title="子任务名称">\n' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                '<div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">计划形式</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                ' <select name="planRate" lay-verify="required" >\n' +
                                '      </select>' +
                                '    </div>\n' +
                                '  </div></div>' +
                                '</div>' +
                                //第三行
                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">周期类型<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block planSycle">\n' +
                                ' <select name="planSycle" lay-verify="required" class="jinyong testNull" title="周期类型">\n' +
                                '      </select>' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">任务来源<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                ' <select name="taskType" lay-verify="required" class="jinyong testNull" title="任务来源">\n' +
                                '      </select>' +
                                '    </div>\n' +
                                '  </div> </div>' +
                                '</div>' +
                                //第六行
                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">负责人</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '  <textarea  type="text"  title="负责人" name="dutyUser" id="dutyUser" readonly  style="background:#e7e7e7;height: 45px;width:83%;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
                                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">责任部门</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '  <textarea  type="text" title="责任部门" name="mainCenterDept" id="mainCenterDept" readonly  style="background:#e7e7e7;height: 45px;width: 99%;text-indent:1em;border-radius: 4px;"></textarea>\n' +
								/*不允许修改责任部门2020.10.21*/
								/* '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
                                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +*/
                                '    </div>\n' +
                                '  </div> </div>' +
                                '</div>' +
                                //第七行
                                '<div class="layui-row">' +
                                ' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">计划开始时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" class="layui-input jinyong testNull" autocomplete="off" name="planStartDate" id="planStartDate" title="计划开始时间">' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                ' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">计划结束时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" class="layui-input jinyong testNull" autocomplete="off" name="planEndDate" id="planEndDate" title="计划结束时间">' +
                                '    </div>\n' +
                                '  </div> </div>' +
                                ' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">计划工期<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="planContinuedDate" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong testNull" title="计划工期">\n' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                '</div>' +
                                //第八行
                                '<div class="layui-row">' +
                                ' <div class="newAndEdit layui-col-xs12"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">完成标准<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="resultStandard"  autocomplete="off" class="layui-input jinyong testNull" title="完成标准">\n' +
                                '    </div>\n' +
                                '  </div> </div>' +
                                '</div>' +
                                //第九行
                                '<div class="layui-row">' +
                                ' <div class="newAndEdit layui-col-xs11"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">前置子任务</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="preTaskId" readonly  autocomplete="off" class="layui-input jinyong" style="background:#e7e7e7;">\n' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                ' <div class="newAndEdit layui-col-xs1"> <div class="layui-form-item">\n' +
                                '<button type="button" class="layui-btn settings" style="margin-left: 25px">设置</button>' +
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
                                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">难度点</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="difficultPoint"  autocomplete="off" class="layui-input jinyong">\n' +
                                '    </div>\n' +
                                '  </div> </div>' +
                                '</div>' +
                                //第十一行
                                '<div class="layui-row">' +
                                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">成果标准模板<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '<input type="text" name="resultDict" readonly title="成果标准模板" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
                                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="resultDictAdd">添加</a>\n' +
                                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="resultDictDel">清空</a>\n' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">协助部门</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '  <textarea  type="text" name="assistCompanyDepts" id="assistCompanyDepts" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                                '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="2" class="deptAdd">添加</a>\n' +
                                ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                '</div>' +
                                //第十三行
                                '<div class="layui-row">' +
                                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">难度系数<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                ' <select name="hardDegree" lay-verify="required"  title="难度系数"  class="jinyong testNull">\n' +
                                '<option value="1">1</option>' +
                                '<option value="2">2</option>' +
                                '<option value="3">3</option>' +
                                '<option value="4">4</option>' +
                                '<option value="5">5</option>' +
                                '<option value="6">6</option>' +
                                '<option value="7">7</option>' +
                                '<option value="8">8</option>' +
                                '<option value="9">9</option>' +
                                '<option value="10">10</option>' +
                                '      </select>' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                '</div>' +
                                //第十四行
                                '<div><div class="layui-form-item">' +
                                '    <label class="layui-form-label">子任务描述</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '<textarea name="taskDesc"  class="layui-textarea jinyong"></textarea>' +
                                '    </div>\n' +
                                '</div>' +
                                '</div>' +
                                //第十五行
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
                                '</div>',
                                '</form>'].join(''),
                            success: function () {
                                $('select[name="planSycle"]', $('#planTaskForm')).html(dictionaryObj['PLAN_SYCLE']['str']);
                                $('select[name="taskType"]', $('#planTaskForm')).html(dictionaryObj['RENWUJIHUA_TYPE']['str']);
                                $('select[name="planRate"]', $('#planTaskForm')).html(dictionaryObj['PLAN_RATE']['str']);

                                // 新增
                                if (type == 1) {
                                    //默认难度系数为5
                                    $('select[name="hardDegree"]', $('#planTaskForm')).val('5');
                                    //编号
                                    $.get('/ProjectInfo/getMaxNo', {model: 'projectItem'}, function (res) {
                                        $('#planTaskForm input[name="taskNo"]').val(res);
                                    });
                                    //新建时自动显示登录人和所属部门
                                    $.get('/user/userCookie', function (res) {
                                        if (res.flag) {
                                            $('#planTaskForm textarea[name=dutyUser]').val(res.object.userName);
                                            $('#planTaskForm textarea[name=dutyUser]').attr('user_id', res.object.userId);
                                            $('#planTaskForm textarea[name=mainCenterDept]').val(res.object.deptName);
                                            $('#planTaskForm textarea[name=mainCenterDept]').attr('deptId', res.object.deptId);
                                        }
                                    });
                                    //新建时默认周期类型为月度
                                    $('#planTaskForm select[name="planSycle"] option').each(function () {
                                        if ($(this).text() == '月度') {
                                            $('#planTaskForm select[name="planSycle"]').val($(this).val());
                                            form.render();
                                        }
                                    });
                                    //新建时默认任务来源为日常工作
                                    $('#planTaskForm select[name="taskType"] option').each(function () {
                                        if ($(this).text() == '日常工作') {
                                            $('#planTaskForm select[name="taskType"]').val($(this).val());
                                            form.render();
                                        }
                                    });
                                }
                                //点击刷新按钮
                                $('.refresh').on('click',function () {
                                    $.get('/ProjectInfo/getMaxNo', {model: 'projectItem'}, function (res) {
                                        $('#planTaskForm input[name="taskNo"]').val(res);
                                    });
                                });

                                //关联关键任务
                                $('.relationAdd', $('#planTaskForm')).on('click',function () {
                                    layer.open({
                                        type: 2,
                                        title: '添加关联关键任务',
                                        area: ['80%', '80%'],
                                        btn: ['确定', '取消'],
                                        content: '/plcProjectItem/relationTarget',
                                        yes: function (index, layero) {
                                            var iframeWin = window[layero.find('iframe')[0]['name']];

                                            var ids = iframeWin.leftArr.join();
                                            $.post('/projectTarget/selectByIds', {ids: ids}, function (res) {
                                                if (res.flag) {
                                                    var tgId = '';
                                                    var tgName = '';
                                                    var str = '<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 20px;">\n' +
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
                                                        '  <tbody>\n';
                                                    res.obj.forEach(function (v, i) {
                                                        tgId += v.tgId + ',';
                                                        tgName += v.tgName + ',';
                                                        str += '<tr>\n' +
                                                            '<td>' + isShowNull(v.tgName) + '</td>\n' +
                                                            '<td>' +(dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '')+ '</td>\n' +
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
                                                            '</tr>\n';
                                                    });
                                                    str += '</tbody></table>';
                                                    $('#planTaskForm input[name="tgId"]').val(tgName);
                                                    $('#planTaskForm input[name="tgId"]').attr('tgId', tgId);
                                                    $('#planTaskForm').append(str);
                                                    layer.close(index);
                                                }
                                            });
                                        }
                                    });
                                });
                                $('.relationDel').on('click',function () {
                                    $('#planTaskForm input[name="tgId"]').val('');
                                    $('#planTaskForm input[name="tgId"]').attr('tgId', '');
                                    $('#targetDetail').remove();
                                });
                                //设置
                                $('.settings', $('#planTaskForm')).on('click',function () {
                                    layer.open({
                                        type: 1,
                                        title: '前置子任务',
                                        area: ['80%', '70%'],
                                        btn: ['确定', '取消'],
                                        content: '<div style="margin-top: 15px" class="layui-form" id="taskSet">' +
                                            '<div class="layui-row" style="text-align: right;margin-right: 2%">' +
                                            '<div class="layui-col-xs4">' +
                                            '<div class="layui-form-item">\n' +
                                            '<label class="layui-form-label">年度:</label>\n' +
                                            '<div class="layui-input-block">\n' +
                                            '<select name="year" lay-filter="yearSet">\n' +
                                            '<option value="">请选择</option>\n' +
                                            '</select>\n' +
                                            '</div>\n' +
                                            '</div>' +
                                            '</div>' +
                                            '<div class="layui-col-xs4">' +
                                            '<div class="layui-form-item">\n' +
                                            '<label class="layui-form-label">月度:</label>\n' +
                                            '<div class="layui-input-block">\n' +
                                            '<select name="month">\n' +
                                            '</select>\n' +
                                            '</div>\n' +
                                            '</div>' +
                                            '</div>' +
                                            '<div class="layui-col-xs4">' +
                                            '<div class="layui-form-item">\n' +
                                            '<label class="layui-form-label">责任部门:</label>\n' +
                                            '<div class="layui-input-block">\n' +
                                            '<input type="text" name="mainCenterDept" readonly id="mainCenterDeptSet" autocomplete="off" class="layui-input"  readonly style="background:#e7e7e7;display: inline-block;width: 65%">' +
                                            '<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_taskSet_dept">添加</span>' +
                                            '<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_taskSet_dept">清空</span>' +
                                            '</div>\n' +
                                            '</div>' +
                                            '</div>' +
                                            '<button type="button" class="layui-btn layui-btn-sm addPreTask">增加</button></div>' +
                                            '<table class="layui-table preTaskTable" style="width: 98%;margin: 8px">\n' +
                                            '  <thead>\n' +
                                            '    <tr>\n' +
                                            '      <th>子任务名称</th>\n' +
                                            '      <th>类型</th>\n' +
                                            '      <th>延隔时间(天)</th>\n' +
                                            '    </tr> \n' +
                                            '  </thead>\n' +
                                            '  <tbody>\n' +
                                            '  </tbody>\n' +
                                            '</table>' +
                                            '</div>',
                                        success: function () {
                                            $('.add_taskSet_dept').on('click', function () {
                                                dept_id = 'mainCenterDeptSet';
                                                $.popWindow("/common/selectDept?0");
                                            });
                                            $('.clear_taskSet_dept').on('click', function () {
                                                $('#mainCenterDeptSet').val('');
                                                $('#mainCenterDeptSet').attr('deptId', '');
                                            });
                                            /***************************************************计划期间年度、月度*******************************************************/
                                                // 计划期间年度列表
                                            var allYear = '';
                                            // 获取计划期间年度列表
                                            $.get('/planPeroidSetting/selectAllYear', function (res) {
                                                if (res.object.length > 0) {
                                                    res.object.forEach(function (item) {
                                                        allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                                                    });
                                                }
                                                $('#taskSet [name="year"]').append(allYear);
                                                form.render('select');
                                            });

                                            // 获取月度
                                            form.on('select(yearSet)', function (data) {
                                                if (data.value) {
                                                    getPlanMonth(data.value, function (monthStr) {
                                                        $('#taskSet [name="month"]').html(monthStr);
                                                        form.render('select');
                                                    });
                                                } else {
                                                    $('#taskSet [name="month"]').html('<option value="">请选择</option>');
                                                    form.render('select');
                                                }
                                            });

                                            if ($('#planTaskForm input[name="preTaskId"]').attr('preTaskId')) {
                                                $.get('/plcProjectItem/selectQZById', {preTaskIds: $('#planTaskForm input[name="preTaskId"]').attr('preTaskId')}, function (res) {
                                                    if (res.flag) {
                                                        var data = res.obj
                                                        data.forEach(function (item, index) {
                                                            var str = ''
                                                            str += '    <tr class="trTask">\n' +
                                                                '      <td>' +
                                                                '  <select name="workItemName" lay-verify="required">\n' +
                                                                function () {
                                                                    var name = allTask()
                                                                    return name
                                                                }() +
                                                                '      </select>' +
                                                                '</td>\n' +
                                                                '      <td>' +
                                                                '  <select name="pretaskItemType" lay-verify="required">\n' +
                                                                '        <option value=""></option>\n' +
                                                                '        <option value="FS">完成-开始(FS)</option>\n' +
                                                                '        <option value="SS">开始-开始(SS)</option>\n' +
                                                                '        <option value="FF">完成-完成(FF)</option>\n' +
                                                                '        <option value="SF">开始-完成(SF)</option>\n' +
                                                                '      </select>' +
                                                                '</td>\n' +
                                                                '      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')"  name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
                                                                '    </tr>\n'
                                                            $('.preTaskTable tbody').append(str)
                                                            $('.trTask').eq(index).find('select[name="workItemName"]').val(item.planItemId)
                                                            $('.trTask').eq(index).find('select[name="pretaskItemType"]').val(item.pretaskItemType)
                                                            $('.trTask').eq(index).find('input[name="extendDates"]').val(item.extendDates)
                                                            form.render()
                                                        })
                                                    }
                                                })
                                            }
                                            $('.addPreTask').on('click',function () {
                                                var str = '    <tr class="trTask">\n' +
                                                    '      <td>' +
                                                    '  <select name="workItemName" lay-verify="required">\n' +
                                                    function () {
                                                        var year = $('#taskSet select[name="year"]').val() || ''
                                                        var month = $('#taskSet select[name="month"]').val() || ''
                                                        if ($('#mainCenterDeptSet').attr('deptId')) {
                                                            var mainCenterDept = $('#mainCenterDeptSet').attr('deptId').replace(/,$/, '')
                                                        } else {
                                                            var mainCenterDept = ''
                                                        }

                                                        var name = allTask(year, month, mainCenterDept)
                                                        return name
                                                    }() +
                                                    '      </select>' +
                                                    '</td>\n' +
                                                    '      <td>' +
                                                    '  <select name="pretaskItemType" lay-verify="required">\n' +
                                                    '        <option value=""></option>\n' +
                                                    '        <option value="FS">完成-开始(FS)</option>\n' +
                                                    '        <option value="SS">开始-开始(SS)</option>\n' +
                                                    '        <option value="FF">完成-完成(FF)</option>\n' +
                                                    '        <option value="SF">开始-完成(SF)</option>\n' +
                                                    '      </select>' +
                                                    '</td>\n' +
                                                    '      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')" value="0" name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
                                                    '    </tr>\n'
                                                $('.preTaskTable tbody').append(str)
                                                form.render()
                                            })
                                        },
                                        yes: function (index) {
                                            var arr = []
                                            var str = ''
                                            $('.trTask').each(function () {
                                                if ($(this).find('select[name="workItemName"]').val() && $(this).find('select[name="pretaskItemType"]').val() && $(this).find('input[name="extendDates"]').val()) {
                                                    var obj = {}
                                                    obj.planItemId = $(this).find('select[name="workItemName"]').val()
                                                    obj.workItemName = $(this).find('select[name="workItemName"] option:selected').text()
                                                    obj.pretaskItemType = $(this).find('select[name="pretaskItemType"]').val()
                                                    obj.extendDates = $(this).find('input[name="extendDates"]').val()
                                                    arr.push(obj)
                                                    str += obj.workItemName + ','
                                                }
                                            })
                                            $.ajax({
                                                url: '/plcProjectItem/insertPretask',
                                                data: JSON.stringify(arr),
                                                contentType: "application/json;charset=UTF-8",
                                                dataType: 'json',
                                                type: 'post',
                                                success: function (res) {
                                                    if (res.flag) {
                                                        $('#planTaskForm input[name="preTaskId"]').attr('preTaskId', res.data)
                                                        $('#planTaskForm input[name="preTaskId"]').val(str)
                                                        layer.close(index)
                                                    }
                                                }
                                            })
                                        }
                                    });
                                });
                                // 成果标准模板
                                $('.resultDictAdd', $('#planTaskForm')).on('click',function () {
                                    layer.open({
                                        type: 1,
                                        title: '添加成果标准模板',
                                        area: ['30%', '70%'],
                                        btn: ['确定', '取消'],
                                        content: '<div  class="layui-form result"  style="margin-top: 15px"></div>',
                                        success: function () {
                                            var cgclTypeObject = dictionaryObj['CGCL_TYPE']['object'];
                                            var str = '';
                                            for (var key in cgclTypeObject) {
                                                if (cgclTypeObject.hasOwnProperty(key)) {
                                                    str += '<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="' + cgclTypeObject[key] + '" title="' + cgclTypeObject[key] + '" value="' + key + '" lay-skin="primary"></div>';
                                                }
                                            }
                                            $('.result').html(str);
                                            form.render();

                                            var resultDict = $('#planTaskForm input[name="resultDict"]').attr('resultDict');
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
                                        yes: function (index) {
                                            var resultDict = ''
                                            var resultDictName = ''
                                            $('.result input').each(function () {
                                                if ($(this).prop('checked')) {
                                                    resultDict += $(this).val() + ','
                                                    resultDictName += $(this).attr('title') + ','
                                                }
                                            })
                                            $('#planTaskForm input[name="resultDict"]').val(resultDictName)
                                            $('#planTaskForm input[name="resultDict"]').attr('resultDict', resultDict)
                                            layer.close(index);
                                        }
                                    });
                                });
                                $('.resultDictDel', $('#planTaskForm')).on('click',function () {
                                    $('#planTaskForm input[name="resultDict"]').val('');
                                    $('#planTaskForm input[name="resultDict"]').attr('resultDict', '');
                                });

                                // 选择上级子任务
                                var instance = dropdown.render({
                                    dropdown: '#parentTask',
                                    toggle: '.layui-select-title',
                                    menu: '[data-role="menu"]',
                                    trigger: 'click',
                                    className: {
                                        dropdownShow: 'layui-form-selected',
                                        menuShow: ''
                                    }
                                });

                                // 此处渲染树
                                $.get('/plcPlan/selectByPlanId', {planId: $('#planId').val()}, function (res) {
                                    if (res.flag) {
                                        if (type == 2) {
                                            rebuildTaskTree(res.object, data.planItemId);
                                        }
                                        eleTree.render({
                                            elem: '#parentTaskTree',
                                            data: res.object,
                                            highlightCurrent: true,
                                            showLine: true,
                                            accordion: true,
	                                        expandOnClickNode: false,
                                            request: {
                                                name: "taskName",
                                                key: "planItemId",
                                                children: "items",
                                            },
                                            response: {
                                                statusName: 'flag',
                                                statusCode: true,
                                                dataName: "object"
                                            },
                                        });
                                    }
                                });

                                // 节点点击事件
                                eleTree.on("nodeClick(parentTaskTree)", function (d) {
                                    var nodeData = d.data.currentData;
                                    $('#parentPlanItemId').val(nodeData.planItemId);
                                    $('#topItem').val(nodeData.taskName);
                                    instance.hide();
                                });
                                
                                // 重置为一级子任务
	                            $('#clearParentTask').on('click',function(){
	                                $('#parentPlanItemId').val(0);
                                    $('#topItem').val('已为一级子任务');
	                            });

                                // 默认为一级
                                var parentId = 0;
                                if (data) {
                                    parentId = data.parentPlanItemId || 0;
                                    $('#parentPlanItemId').val(parentId);
                                }
                                var time_data = '';
                                $.ajax({
                                    url: '/plcProjectItem/itemNameByParentId',
                                    dataType: 'json',
                                    type: 'get',
                                    async: false,
                                    data: {parentId: parentId},
                                    success: function (res) {
                                        //判断是否已经是一级子任务
                                        if (res.object.taskName) {
                                            time_data = res.object;
                                            $('#topItem').val(res.object.taskName);
                                        } else {
                                            $('#topItem').val(res.object);
                                        }
                                    }
                                });
                                form.render();

                                if (type == 2) {
                                    //编辑回显
                                    $('.refresh').hide();

                                    form.val("planTaskForm", data);
                                    //关联关键任务
                                    if (data.tgIds) {
                                        var tgIds = data.tgIds;
                                        var tgId = '';
                                        var tgName = '';
                                        tgIds.forEach(function (item) {
                                            tgId += item.tgId + ',';
                                            tgName += item.tgName + ',';
                                        })
                                        $('#planTaskForm input[name="tgId"]').val(tgName);
                                        $('#planTaskForm input[name="tgId"]').attr('tgId', tgId);
                                        $.post('/projectTarget/selectByIds', {ids: tgId}, function (res) {
                                            if (res.flag) {
                                                var str = '<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 20px;">\n' +
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
                                                    '  <tbody>\n';
                                                res.obj.forEach(function (v, i) {
                                                    str += '<tr>\n' +
                                                        '<td>' + v.tgName + '</td>\n' +
                                                        '<td>' +(dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '') + '</td>\n' +
                                                        '<td>' + v.planStartDate + '</td>\n' +
                                                        '<td>' + v.planEndDate + '</td>\n' +
                                                        '<td>' + v.resultStandard + '</td>\n' +
                                                        '<td>' + function () {
                                                            if (v.tgDesc) {
                                                                return v.tgDesc
                                                            } else {
                                                                return ''
                                                            }
                                                        }() + '</td>\n' +
                                                        '</tr>\n'
                                                });
                                                str += '</tbody></table>';
                                                $('#planTaskForm').append(str);
                                            }
                                        });
                                    } else {
                                        $('#planTaskForm input[name="tgId"]').val('');
                                    }
                                    //前置子任务
                                    if (data.preTask) {
                                        $.get('/plcProjectItem/selectQZById', {preTaskIds: data.preTask}, function (res) {
                                            if (res.flag) {
                                                var dataPre = res.obj
                                                var preTaskName = ''
                                                dataPre.forEach(function (item, index) {
                                                    preTaskName += item.workItemName + ','
                                                })
                                                $('#planTaskForm input[name="preTaskId"]').val(preTaskName)
                                                $('#planTaskForm input[name="preTaskId"]').attr('preTaskId', data.preTask)
                                            }
                                        })
                                    }
                                    // 成果标准模板
                                    if (!!data.resultDict) {
                                        var resultDictList = data.resultDict.split(',');
                                        var resultDictName = '';
                                        resultDictList.forEach(function (item) {
                                            resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
                                        });
                                        $('#planTaskForm input[name="resultDict"]').val(resultDictName.replace(/,$/, ''));
                                        $('#planTaskForm input[name="resultDict"]').attr('resultDict', data.resultDict);
                                    }

                                    //主要负责人
                                    $('#dutyUser', $('#planTaskForm')).val(data.dutyUserName);
                                    $('#dutyUser', $('#planTaskForm')).attr('user_id', data.dutyUser);
                                    $('#mainCenterDept', $('#planTaskForm')).val(data.mainCenterDeptName);
                                    $('#mainCenterDept', $('#planTaskForm')).attr('deptid', data.mainCenterDept);
                                    $('#assistCompanyDepts', $('#planTaskForm')).val(data.assistCompanyDeptsName);
                                    $('#assistCompanyDepts', $('#planTaskForm')).attr('deptid', data.assistCompanyDepts);

                                    form.render();
                                }

                                if (time_data) {
                                    var min = time_data.planStartDate;
                                    var max = time_data.planEndDate;
                                    // 初始化计划开始时间
                                    var planStartLaydateConfig = {
                                        elem: '#planStartDate',
                                        min: min,
                                        max: max,
                                        done: function (value, date) {
                                            if ($('#planEndDate', $('#planTaskForm')).val()) {
                                                var planPeriod = !!value ? timeRange(value, $('#planEndDate', $('#planTaskForm')).val()) + '天' : '';
                                                $('input[name="planContinuedDate"]', $('#planTaskForm')).val(planPeriod);
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
                                        , trigger: 'click' //采用click弹出
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
                                            if ($('#planStartDate', $('#planTaskForm')).val()) {
                                                var planPeriod = !!value ? timeRange($('#planStartDate', $('#planTaskForm')).val(), value) + '天' : '';
                                                $('input[name="planContinuedDate"]', $('#planTaskForm')).val(planPeriod);
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
                                        , trigger: 'click' //采用click弹出
                                    }
                                    if (data && data.planStartDate) {
                                        planEndLaydateConfig.min = data.planStartDate;
                                    }
                                    var planEndLaydate = laydate.render(planEndLaydateConfig);
                                } else {
                                    // 初始化计划开始时间
                                    var planStartLaydateConfig = {
                                        elem: '#planStartDate',
                                        done: function (value, date) {
                                            if ($('#planEndDate', $('#planTaskForm')).val()) {
                                                var planPeriod = !!value ? timeRange(value, $('#planEndDate', $('#planTaskForm')).val()) + '天' : '';
                                                $('input[name="planContinuedDate"]', $('#planTaskForm')).val(planPeriod);
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
                                        , trigger: 'click' //采用click弹出
                                    }
                                    if (data && data.planEndDate) {
                                        planStartLaydateConfig.max = data.planEndDate;
                                    }
                                    var planStartLaydate = laydate.render(planStartLaydateConfig);

                                    // 初始化计划结束时间
                                    var planEndLaydateConfig = {
                                        elem: '#planEndDate',
                                        done: function (value, date) {
                                            if ($('#planStartDate', $('#planTaskForm')).val()) {
                                                var planPeriod = !!value ? timeRange($('#planStartDate', $('#planTaskForm')).val(), value) + '天' : '';
                                                $('input[name="planContinuedDate"]', $('#planTaskForm')).val(planPeriod);
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
                                        , trigger: 'click' //采用click弹出
                                    }
                                    if (data && data.planStartDate) {
                                        planEndLaydateConfig.min = data.planStartDate;
                                    }
                                    var planEndLaydate = laydate.render(planEndLaydateConfig);
                                }

                            },
                            yes: function (index) {
                                var loadingIndex = layer.load();
                                //必填项提示
                                for (var i = 0; i < $('.testNull').length; i++) {
                                    if ($('.testNull').eq(i).val() == '') {
                                        layer.close(loadingIndex);
                                        layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0, time: 1000});
                                        return false;
                                    }
                                }
                                var datas = $('#planTaskForm').serializeArray();

                                var obj = {}
                                datas.forEach(function (item) {
                                    obj[item.name] = item.value;
                                });
                                obj.dutyUser = $('#dutyUser', $('#planTaskForm')).attr('user_id') || '';
                                if ($('#mainCenterDept', $('#planTaskForm')).attr('deptid')) {
                                    obj.mainCenterDept = $('#mainCenterDept', $('#planTaskForm')).attr('deptid').replace(/,$/, '') || '';
                                }
                                obj.assistCompanyDepts = $('#assistCompanyDepts', $('#planTaskForm')).attr('deptid');

                                obj.tgId = $('#planTaskForm input[name="tgId"]').attr('tgid') || '';
                                obj.preTask = $('#planTaskForm input[name="preTaskId"]').attr('pretaskid') || '';
                                obj.resultDict = $('#planTaskForm input[name="resultDict"]').attr('resultDict');

                                if (type == 1) {
                                    obj.itemBelongDept = $('#projectOrDeptId').val();
                                } else {
                                    obj.planItemId = data.planItemId;
                                }

                                //判断计划形式
                                if ($('#planTaskForm [name="planRate"]').val() != '01') {
                                    layer.open({
                                        type: 1,
                                        title: '请填写重复次数',
                                        btn: ['确定', '取消'],
                                        area: ['420px', '240px'], //宽高
                                        content: '<div class="layui-form-item" style="width: 90%;margin-top: 20px">\n' +
                                            '    <label class="layui-form-label">重复次数<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="number" name="time" autocomplete="off" class="layui-input" style="display: inline-block;width:92%">次\n' +
                                            '    </div>\n' +
                                            '  </div>',
                                        yes: function () {
                                            if (!$('input[name="time"]')) {
                                                layer.msg('重复次数为必填项！', {icon: 0});
                                                return false
                                            }
                                            var time = $('input[name="time"]').val()
                                            obj.time = time
                                            if ($('#form [name="planRate"]').val() == '02') {
                                                obj.type = '02'
                                            } else if ($('#form [name="planRate"]').val() == '03') {
                                                obj.type = '03'
                                            } else if ($('#form [name="planRate"]').val() == '04') {
                                                obj.type = '04'
                                            } else if ($('#form [name="planRate"]').val() == '05') {
                                                obj.type = '05'
                                            }
                                            $.ajax({
                                                url: url,
                                                data: obj,
                                                dataType: 'json',
                                                type: 'post',
                                                success: function (res) {
                                                    layer.close(loadingIndex);
                                                    if (res.flag) {
                                                        if (type == 1) {
                                                            if (res.object == 1) {
                                                                layer.msg('编号重复，请点击刷新按钮重置编号！', {icon: 0, time: 1000});
                                                                return false;
                                                            } else {
                                                                layer.msg('新增成功！', {icon: 1, time: 1000});

                                                                var planItemIds = ($('#targetIdOrTaskId').val() || '') + res.object + ',';
                                                                updatePlcPlan(planId, {planItemIds:planItemIds});
                                                            }
                                                        } else {
                                                            layer.msg('修改成功！', {icon: 1, time: 1000});
                                                        }
                                                        layer.closeAll();
                                                        var title = $('.titleSp').text();
                                                        var datas = {
                                                            _: new Date().getTime(),
                                                            planId: planId
                                                        }
                                                        initTaskTable(planClass, datas, function () {
                                                            $('.titleSp').text(title);
                                                        });
                                                    } else {
                                                        if (type == 1) {
                                                            layer.msg('新增失败！', {icon: 2, time: 1000});
                                                        } else {
                                                            layer.msg('修改失败！', {icon: 2, time: 1000});
                                                        }
                                                    }
                                                }
                                            })
                                        }
                                    });
                                } else {
                                    obj.time = 1
                                    obj.type = '01'
                                    $.ajax({
                                        url: url,
                                        data: obj,
                                        dataType: 'json',
                                        type: 'post',
                                        success: function (res) {
                                            layer.close(loadingIndex);
                                            if (res.flag) {
                                                if (type == 1) {
                                                    if (res.object == 1) {
                                                        layer.msg('编号重复，请点击刷新按钮重置编号！', {icon: 0, time: 1000});
                                                        return false;
                                                    } else {
                                                        layer.msg('新增成功！', {icon: 1, time: 1000});
                                                        
                                                        var planItemIds = ($('#targetIdOrTaskId').val() || '') + res.object + ',';
	                                                    updatePlcPlan(planId, {planItemIds:planItemIds});
                                                    }
                                                } else {
                                                    layer.msg('修改成功！', {icon: 1, time: 1000});
                                                }
                                                layer.close(index);
                                                var title = $('.titleSp').text();
                                                var datas = {
                                                    _: new Date().getTime(),
                                                    planId: planId
                                                }
                                                initTaskTable(planClass, datas, function () {
                                                    $('.titleSp').text(title);
                                                });
                                            } else {
                                                if (type == 1) {
                                                    layer.msg('新增失败！', {icon: 2, time: 1000});
                                                } else {
                                                    layer.msg('修改失败！', {icon: 2, time: 1000});
                                                }
                                            }
                                        }
                                    });
                                }
                            }
                        });
                    }
                });
            }

            //将毫秒数转为yyyy-MM-dd格式时间
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
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

            // 重置查询区域布局
            function resizeQuery() {
                var queryWidth = $('.query ').width();
                $('.query_item').width(queryWidth / 8);
            }

            /**
             * 判断是否显示空
             * @param data
             */
            function isShowNull(data) {
                if (!!data) {
                    return data;
                } else {
                    return '';
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
                var days = parseInt(time / (1000 * 60 * 60 * 24)) + 1;
                return days;
            }

            /**
             * 获取主项关键任务id或子任务id
             */
            function getTargetId(data, key) {
                var tgIds = [];
                if (data && data.length > 0) {
                    data.forEach(function (item) {
                        if (!!item[key]) {
                            tgIds.push(item[key])
                        }

                        if (item.children && item.children.length > 0) {
                            tgIds.push.apply(tgIds, getTargetId(item.children, key));
                        }
                    });
                }
                return tgIds;
            }

            /**
             * 获取主项关键任务名称编号或子任务名称编号
             */
            function getTargetName(data, type) {
                var dataArr = [];
                if (data && data.length > 0) {
                    data.forEach(function (item) {

                        // 关键任务
                        if (type == 1) {
                            if (!!item.tgId) {
                                dataArr.push('(' + item.tgNo + ')' + item.tgName);
                            }
                        } else if (type == 2) { // 子任务
                            dataArr.push('(' + item.taskNo + ')' + item.taskName);
                        }

                        if (item.children && item.children.length > 0) {
                            dataArr.push.apply(dataArr, getTargetId(item.children, type));
                        }
                    });
                }
                return dataArr;
            }

            /**
             * 批量分配责任人
             * @param type (1-关键任务，2-子任务)
             * @param data (请求参数对象)
             * @param fn (回调函数)
             */
            function updateTaskOrTarget(type, data, fn) {
                var url = '';
                if (type == 1) {
                    url = '/projectTarget/updateContent';
                } else if (type == 2) {
                    url = '/plcProjectItem/updateByIds';
                }

                $.post(url, data, function (res) {
                    if (fn) {
                        fn(res);
                    }
                });
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

            /**
             * 修改上报信息
             * @param planId
             * @param data
             * @param fn
             */
            function updatePlcPlan(planId, data, fn) {
                var params = $.extend({}, {planId: planId}, data);

                $.post('/plcPlan/updatePlcPlan', params, function (res) {
                    if (fn) {
                        fn(res);
                    }
                });
            }

            //前置关键任务的项目下所有关键任务
            function allTarget(year, month, projectId) {
                var allTarget = ''
                $.ajax({
                    url: '/projectTarget/selectPre',
                    dataType: 'json',
                    type: 'get',
                    async: false,
                    data: {
                        year: year,
                        month: month,
                        projectId: projectId
                    },
                    success: function (res) {
                        var data = res.obj
                        var targetName = '<option value=""></option>'
                        data.forEach(function (item) {
                            targetName += '<option value="' + item.tgId + '">' + item.tgName + '</option>'
                        })
                        allTarget = targetName
                    }
                })
                return allTarget
            }
            
            // 重新构建子任务树，去掉自己和子级子任务
            function rebuildTaskTree(treeList, taskId) {
                if (!treeList || !treeList.length) {
                    return
                }
                for (let i = 0; i < treeList.length; i++) {
                    if (treeList[i].planItemId == taskId) {
                        treeList.splice(i, 1);
                        break;
                    }
                    rebuildTaskTree(treeList[i].items, taskId)
                }
            }

            //前置子任务的所有子任务
            function allTask(year, month, mainCenterDept) {
                var allTask = ''
                $.ajax({
                    url: '/plcProjectItem/selectAllItem',
                    dataType: 'json',
                    type: 'get',
                    async: false,
                    data: {
                        year: year,
                        month: month,
                        mainCenterDept: mainCenterDept,
                    },
                    success: function (res) {
                        var data = res.obj
                        var taskName = '<option value=""></option>'
                        data.forEach(function (item) {
                            taskName += '<option value="' + item.planItemId + '">' + item.taskName + '</option>'
                        })
                        allTask = taskName
                    }
                })
                return allTask
            }
		</script>
	</body>
</html>
