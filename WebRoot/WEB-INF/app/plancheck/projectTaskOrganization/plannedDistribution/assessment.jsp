<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-06-03
  Time: 9:54
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
		
		<title>分配确认</title>
		<meta charset="UTF-8">
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
		
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/eleTree.css">
		<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/treeTable.css">

		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui_v2.5.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		
		<style>
			html, body {
				width: 100%;
				height: 100%;
				background: #fff;
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
			
			.item {
				font-size: 22px;
				margin-left: 10px;
				color: #494d59;
				margin-top: 2px
			}
			
			.query .layui-form-item {
				height: 35px;
				margin: 0;
				clear: none;
			}
			
			.query_item {
				float: left;
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
			
			.query .layui-input-block input {
				height: 35px;
			}
			
			.sty {
				margin: 2px 0px 0px 52px;
			}
			
			.layui-table, .layui-table-view {
				margin: 0 0;
			}
			
			#leftHeight {
				height: 350px;
			}
			
			#questionTree li {
				border-bottom: 1px solid #ddd;
				line-height: 20px;
				padding: 5px 0 5px 10px;
				cursor: pointer;
				border-radius: 3px;
			}
			
			.select {
				background: #c7e1ff;
			}
			.buttonSelect {
				background: #c7e1ff;
			}
			
			.planBtom {
				height: 1px;
				border: 0;
				clear: both;
			}
			
			.ew-tree-table-tool-right {
				display: none;
			}
			
			.distri {
				float: right;
			}
			
			.layui-icon-close {
				display: none;
			}
			
			.tree_table .ew-tree-table {
				margin: 0;
			}
			
			.divShow {
				position: relative;
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
				width: 150px;
			}
			
			.layui-table-view .layui-table {
				width: 100%;
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
		<%--<div class="headImg" style="padding-top: 10px">
			<span class="item">
				<img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt="">
				<span class="headTitle" style="margin-left: 10px">分配考核</span>
			</span>
		</div>
		<hr>--%>
		<div class="layui-fluid" id="LAY-app-message" style="position: absolute; top: 10px; right: 0;bottom: 0;left: 0;">
			<div class="layui-row" style="height: 100%;">
				<div class="layui-tab layui-tab-brief" lay-filter="docDemo" style="position: relative;height: 100%;">
					<ul class="layui-tab-title target_tabs">
						<li class="layui-this wei" opttype="1">未分配<span class="weiNum" style="color: red"></span></li>
						<li class="assigned" opttype="2">已分配</li>
					</ul>
					<div class="layui-tab-content" style="padding: 0px;position: absolute;top: 41px;right: 0;bottom: 0;left:0;">
						<div class="layui-tab-item layui-show" style="height: 100%;">
							<%--筛选查询--%>
							<form class="layui-form query_one query" style="padding: 5px 0;">
								<div class="clearfix" style="padding: 5px 0;">
									<div class="layui-form-item query_item">
										<label class="layui-form-label">计划名称</label>
										<div class="layui-input-block">
											<input type="text" name="planName" autocomplete="off" class="layui-input">
										</div>
									</div>
									<div class="layui-form-item query_item">
										<label class="layui-form-label">项目名称</label>
										<div class="layui-input-block">
											<select name="belongtoProj" lay-verify="required">
												<option value="">请选择</option>
											</select>
										</div>
									</div>
									<div class="layui-form-item query_item">
										<label class="layui-form-label">所属单位</label>
										<div class="layui-input-block">
											<input type="text" name="belongtoUnits" id="belongtoUnits" placeholder="请选择"
											       style="background-color: #e7e7e7;cursor:pointer;" required readonly class="layui-input">
										</div>
									</div>
									<div class="authority_search query_item" style="display: none;height: 35px;line-height: 32px;padding-left: 15px;">
										<button type="button" class="layui-btn layui-btn-sm more_query" isshow="0">
											<i class="layui-icon layui-icon-down" style="margin: 0;"></i>
										</button>
										<button type="button" id="" class="layui-btn layui-btn-sm search">查询</button>
										<button type="reset" class="layui-btn layui-btn-sm clear">重置</button>
									</div>
								</div>
								<div class="clearfix hide_query" style="display: none;padding: 5px 0;">
									<div class="layui-form-item query_item">
										<label class="layui-form-label">计划类型</label>
										<div class="layui-input-block">
											<select name="planClass" lay-verify="required">
												<option value="">请选择</option>
												<option value="1">主项计划</option>
												<option value="2">职能计划</option>
												<option value="3">计划子任务</option>
											</select>
										</div>
									</div>
									<div class="layui-form-item query_item">
										<label class="layui-form-label">年度</label>
										<div class="layui-input-block">
											<select name="planYear" lay-filter="planYear">
												<option value="">请选择</option>
											</select>
										</div>
									</div>
									<div class="layui-form-item query_item">
										<label class="layui-form-label">月度</label>
										<div class="layui-input-block">
											<select name="planMonth">
												<option value="">请选择</option>
											</select>
										</div>
									</div>
								</div>
							</form>
							<div class="layui-lf" style="width:250px;float:left">
								<div class="layui-card">
									<div class="layui-card-body" id="leftHeight" style="padding: 0;overflow:auto;">
										<div class="clearfix">
											<ul id="buttonShow" style="float: left;width:25px;text-align: center">
												<li showType="1" style="cursor: pointer;">关键任务<span id="targetNum" style="color: red"></span></li>
												<li class="buttonSelect" style="cursor: pointer;" showType="2">子任务<span id="taskNum" style="color: red"></span></li>
												<li style="cursor: pointer;">协助子任务<span id="assistNum" style="color: red"></span></li>
											</ul>
											<ul id="questionTree" style="float: left;width:calc(100% - 25px)"></ul>
										</div>
									<%--	<div style="padding: 15px 0px;text-align: center">
											<button type="button" class="layui-btn layui-btn-sm" id="assistTarget">部门协助关键任务</button>
											<button type="button" class="layui-btn layui-btn-sm" id="assistItem">部门协助子任务</button>
										</div>--%>
									</div>
								</div>
							</div>
							<div class="layui-rt" lay-filter="docDemoTabBrief" style="width:calc(100% - 250px);float:left;min-height: 500px;padding-left: 5px;box-sizing: border-box">
								<div id="tishi" style="height: 100%;text-align: center;border: none;display: none;">
									<div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
									<h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">暂无数据</h2>
								</div>
								<div id="dataBox" style="min-height: 450px;">
									<div class="tree_table" style="display: none">
										<table id="treeTableList" lay-filter="treeTableList"></table>
									</div>
									<div class="table_list" style="display: none">
										<table id="tableList" lay-filter="tableList"></table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 已分配、未分配头部工具条 -->
		<script type="text/html" id="distributeBar">
			<div style="position:absolute;right: 1%;">
				{{# if($('.layui-this').text()=='已分配'){ }}
				<a class="layui-btn layui-btn-sm distri closePlan" lay-event="closePlan" style="margin-left: 15px;">关闭</a>
				{{# } }}
				{{# if(authorityObject && authorityObject['40']){ }}
				<a class="layui-btn layui-btn-sm distri" lay-event="distributeOver" id="distributeOver" style="margin-left: 15px;">分配完成</a>
				{{# } }}
				{{# if(authorityObject && authorityObject['26']){ }}
				<a class="layui-btn layui-btn-sm distri" lay-event="distribute" id="appointUser">指定责任人</a>
				{{# } }}
				<a class="layui-btn layui-btn-sm distri saveDistribute" lay-event="saveDistribute">保存</a>
			</div>
		</script>
		
		<script type="text/javascript">
			//定义点击排序后变颜色
			var colorChange_up=''
			var colorChange_down=''
			tabNum()
			/*整体保存的list*/
			var saveALLDataList=[]
			
			resizeSize();
			
			window.onresize = resizeSize;

            initAuthority();
            
            var dept_id = '';

            var dictionaryObj = {
                UNIT: {},
                CONTROL_LEVEL: {},
                RENWUJIHUA_TYPE: {},
                TG_TYPE: {},
                PLAN_SYCLE: {},
                PLAN_PHASE: {},
	            targetData: {},
	            CGCL_TYPE: {}
            }
            var dictionaryStr = 'UNIT,CONTROL_LEVEL,RENWUJIHUA_TYPE,TG_TYPE,PLAN_SYCLE,PLAN_PHASE,targetData,CGCL_TYPE';
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
                // init();
            });

            var responsible = null;

            layui.use(['table', 'layer', 'form', 'element', 'treeTable', 'laydate'], function () {
                var table = layui.table,
                    form = layui.form,
                    layer = layui.layer,
                    element = layui.element,
                    treeTable = layui.treeTable,
                    laydate = layui.laydate;

                form.render();

                var initTreeTable = null;
                var tableList = null;

                var tableTimer = null;

                //点击最左侧筛选关键任务、子任务、协助子任务
				$('#buttonShow').on('click', 'li', function () {
					//清空切换时排序高亮
					colorChange_up=false
					colorChange_down=false
					var _this=$(this)
					var status = $('.target_tabs').children('.layui-this').attr('opttype');
					if(saveALLDataList.length>0){
						var planId = $('.select').attr('planId');
						layer.confirm('确定保存吗？', function (index) {
							var type=''
							//判断是关键任务还是子任务---1、2是关键任务，3是子任务
							if($('.select').attr('planclass')==3){
								type=2
							}else if($('.select').attr('planclass')==1 || $('.select').attr('planclass')==2){
								type=1
							}
							saveTaskOrTarget(type,saveALLDataList,function (res) {
								saveALLDataList=[]
								layer.close(index);
								if (res.flag) {
									layer.msg('保存成功', {icon: 1, time: 1000});
								} else {
									layer.msg('保存失败', {icon: 2, time: 1000});
								}
								_this.addClass('buttonSelect').siblings().removeClass('buttonSelect');
								if(_this.attr('showType')){
									$('#questionTree').show()
									$('.layui-lf').width('250px')
									$('.layui-rt').width('calc(100% - 250px)')
									leftPlanShow(status)
								}else{
									$('.layui-lf').width('30px')
									$('.layui-rt').width('calc(100% - 30px)')
									$('.table_list').show();
									$('.tree_table').hide();
									$('#questionTree').hide()
									distributeTable(status,'','')
								}
							})
						},function () {
							saveALLDataList=[]
							_this.addClass('buttonSelect').siblings().removeClass('buttonSelect');
							if(_this.attr('showType')){
								$('#questionTree').show()
								$('.layui-lf').width('250px')
								$('.layui-rt').width('calc(100% - 250px)')
								leftPlanShow(status)
							}else{
								$('.layui-lf').width('30px')
								$('.layui-rt').width('calc(100% - 30px)')
								$('.table_list').show();
								$('.tree_table').hide();
								$('#questionTree').hide()
								distributeTable(status,'','')
							}
						});
					}else{
						_this.addClass('buttonSelect').siblings().removeClass('buttonSelect');
						if(_this.attr('showType')){
							$('#questionTree').show()
							$('.layui-lf').width('250px')
							$('.layui-rt').width('calc(100% - 250px)')
							$('#questionTree').show()
							leftPlanShow(status)
						}else{
							$('.layui-lf').width('30px')
							$('.layui-rt').width('calc(100% - 30px)')
							$('.table_list').show();
							$('.tree_table').hide();
							$('#questionTree').hide()
							distributeTable(status,'','')
						}
					}
					$('#tishi').hide();
					$('#dataBox').show();
				});

                /**
                 * 未分配、已分配左侧显示计划
                 * @param status (状态)
                 * @param searchObj (查询字段)
                 * @returns {string}
                 */
                function leftPlanShow(status, searchObj) {
                    var searchData = {status: status, taskApproval: 2}
                    if (searchObj) {
                        searchData = searchObj;
                    }
                    //判断是关键任务还是子任务-----1是关键任务，2是子任务
					if($('.buttonSelect').attr('showType')==1){
						searchData.flag=1
					}else if($('.buttonSelect').attr('showType')==2){
						searchData.flag=2
					}
                    
                    $.get('/plcPlan/getAll', searchData, function (res) {
                        if (res.flag) {
                            var data = res.object;
                            var str = '';
                            if (data.length > 0) {
                                $('#tishi').hide();
                                $('#dataBox').show();
                                var planClass = data[0].planClass;
                                var planId = data[0].planId;
                                for (var i = 0; i < data.length; i++) {
                                    // 默认选中第一个
                                    if (i == 0) {
                                        str += '<li class="select"  planId="' + data[i].planId + '" planClass="' + data[i].planClass + '">' + function () {
                                            if (status == 1) {
                                                return '<span style="color: red;">(' + data[i].dutySize + ')</span>';
                                            } else {
                                                return '';
                                            }
                                        }() + data[i].planName + '</li>';
                                    } else {
                                        str += '<li planId="' + data[i].planId + '" planClass="' + data[i].planClass + '">' + function () {
                                            if (status == 1) {
                                                return '<span style="color: red;">(' + data[i].dutySize + ')</span>';
                                            } else {
                                                return '';
                                            }
                                        }() + data[i].planName + '</li>';
                                    }
                                }

                                // 加载选中第一个的数据(默认显示未分配)
                                if (planClass == 1 || planClass == 3) {
                                    $('.table_list').hide();
                                    $('.tree_table').show();
                                } else {
                                    $('.table_list').show();
                                    $('.tree_table').hide();
                                }
                                distributeTable(status, planId, planClass);
                            } else if($('#questionTree').css('display')!='none'){
                                $('#tishi').show();
                                $('#dataBox').hide();
                            }
                            $('#questionTree').html(str);
                           /* if (status == 1) {
								tabNum()
                            }else{
								$('#targetNum').text('')
								$('#taskNum').text('')
								$('#assistNum').text('')
							}*/
                        }
                    });
                }

                // 默认展示未分配
                leftPlanShow(1);

                // 左侧计划列表点击事件
                $('#questionTree').on('click', 'li', function () {
					//清空切换时排序高亮
					colorChange_up=false
					colorChange_down=false
					var _this=$(this)
                	if(saveALLDataList.length>0){
						var planClass = $('.select').attr('planClass');
						var planId = $('.select').attr('planId');
						var status = $('.target_tabs').children('.layui-this').attr('opttype');
						layer.confirm('确定保存吗？', function (index) {
							var type=''
							//判断是关键任务还是子任务---1、2是关键任务，3是子任务
							if($('.select').attr('planclass')==3){
								type=2
							}else if($('.select').attr('planclass')==1 || $('.select').attr('planclass')==2){
								type=1
							}
							saveTaskOrTarget(type,saveALLDataList,function (res) {
								saveALLDataList=[]
								layer.close(index);
								if (res.flag) {
									layer.msg('保存成功', {icon: 1, time: 1000});
									distributeTable(status, planId, planClass);
								} else {
									layer.msg('保存失败', {icon: 2, time: 1000});
								}
							})
						},function () {
							saveALLDataList=[]
							_this.addClass('select').siblings().removeClass('select');
							// 获取 未分配-1、已分配-2、待考核-3、已考核类型-4
							var status = $('.target_tabs').children('.layui-this').attr('opttype');
							// 计划类型 主项关键任务-1、职能关键任务-2、计划子任务-3
							var planClass = $('.select').attr('planClass');
							// 计划上报id
							var planId = $('.select').attr('planId');

							if (planClass == 1 || planClass == 3) {
								$('.table_list').hide();
								$('.tree_table').show();
							} else {
								$('.table_list').show();
								$('.tree_table').hide();
							}

							if (status == 1 || status == 2) {
								distributeTable(status, planId, planClass);
							}
						});
					}else{
						$(this).addClass('select').siblings().removeClass('select');

						// 获取 未分配-1、已分配-2、待考核-3、已考核类型-4
						var status = $('.target_tabs').children('.layui-this').attr('opttype');
						// 计划类型 主项关键任务-1、职能关键任务-2、计划子任务-3
						var planClass = $('.select').attr('planClass');
						// 计划上报id
						var planId = $('.select').attr('planId');

						if (planClass == 1 || planClass == 3) {
							$('.table_list').hide();
							$('.tree_table').show();
						} else {
							$('.table_list').show();
							$('.tree_table').hide();
						}

						if (status == 1 || status == 2) {
							distributeTable(status, planId, planClass);
						}
					}
                });

                getProjectInfo(1);

                // 选择所属单位
                $('#belongtoUnits').on('click', function(){
                    dept_id = 'belongtoUnits';
                    $.popWindow('/common/selectDept');
                });

                // 获取计划期间年度列表
                $.get('/planPeroidSetting/selectAllYear', function (res) {
                    var allYear = '';
                    if (res.object.length > 0) {
                        res.object.forEach(function (item) {
                            allYear += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                        });
                    }
                    $('.query [name="planYear"]').append(allYear);
                    form.render('select');
                });

                // 获取月度
                form.on('select(planYear)', function (data) {
                    if (data.value) {
                        getPlanMonth(data.value, function (monthStr) {
                            $('.query [name="planMonth"]').html(monthStr);
                            form.render('select');
                        });
                    } else {
                        $('.query [name="planMonth"]').html('<option value="">请选择</option>');
                        form.render('select');
                    }
                });
                
                // 更多查询
	            $('.more_query').on("click",function(){
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
                
                // 查询
                $('.search').on("click",function () {
                    var planClass = $('.select').attr('planClass');
                    var planId = $('.select').attr('planId');
                    var status = '';
                    if ($(this).attr('id') == '' || $(this).attr('id') == undefined) {
                        status = 1
                    } else {
                        status = $(this).attr('id');
                    }

                    var searchObj = {
                        status: status
                    }
                    
                    $(this).parents('.query').find('[name]').each(function(ele){
                        var key = $(this).attr('name');
                        var value = $(this).val();
                        
                        searchObj[key] = value;
                    });

                    if (status == 1 || status == 2) {
                        searchObj.belongtoUnits = ($('#belongtoUnits').attr('deptid') || '').replace(/,$/, '');
                        leftPlanShow(status, searchObj);
                    }
                });

                // 重置
                $('.clear').on("click",function () {
                    var status = $('.target_tabs').children('.layui-this').attr('opttype');
                    
                    // 清空所属单位
                    $('#belongtoUnits').val('');
                    $('#belongtoUnits').attr('deptid', '');
                    $('#belongtoUnits').attr('deptname', '');
                    
                    // 重置月份
	                $('.query [name="planMonth"]').html('<option value="">请选择</option>');
	                
	                form.render('select');
	                
	                if (status == 1 || status == 2) {
                        leftPlanShow(status);
                    }
                });

                // 切换tabs
                element.on('tab(docDemo)', function (elem) {
					if(saveALLDataList.length>0){
						var planClass = $('.select').attr('planClass');
						var planId = $('.select').attr('planId');
						var status = $('.target_tabs').children('.layui-this').attr('opttype');
						layer.confirm('确定保存吗？', function (index) {
							var type=''
							//判断是关键任务还是子任务---planclass1、2是关键任务，3是子任务
							if($('.select').attr('planclass')==3 && $('.layui-lf').css('display')!='none'){
								type=2
							}else if(($('.select').attr('planclass')==1 || $('.select').attr('planclass')==2 )&& $('.layui-lf').css('display')!='none'){
								type=1
							}
							saveTaskOrTarget(type,saveALLDataList,function (res) {
								saveALLDataList=[]
								layer.close(index);
								if (res.flag) {
									layer.msg('保存成功', {icon: 1, time: 1000});
								} else {
									layer.msg('保存失败', {icon: 2, time: 1000});
								}
								$('#buttonShow li').eq(0).addClass('buttonSelect').siblings().removeClass('buttonSelect')
								$('#buttonShow li').eq(0).trigger('click')
							})
						},function () {
							saveALLDataList=[]
							$('#tishi').hide();
							$('#dataBox').show();

							$('#questionTree').html();
							$('#treeTableList').siblings().remove();
							$('#tableList').siblings().remove();

							$('.clear').trigger('click');

							if (elem.index == 0 || elem.index == 1) {
								$('.query_two').hide();
								$('.query_one').show();
								$('.layui-lf').show();
								$('.layui-rt').css('width', 'calc(100% - 250px)');
								if (elem.index == 0) {
									$('#test').attr('class', 1);
									$('.search').attr('id', 1);
									getProjectInfo(1);
								} else if (elem.index == 1) {
									$('#test').attr('class', 2);
									$('.search').attr('id', 2);
									getProjectInfo(2);
								}
							} else {
								$('.query_one').hide();
								$('.query_two').show();
								$('.layui-lf').hide();
								$('.table_list').show();
								$('.tree_table').hide();
								$('.layui-rt').css('width', '100%');
								getProjectInfo();
								if (elem.index == 2) {
									$('.search').attr('id', 3);
								} else if (elem.index == 3) {
									$('.search').attr('id', 4);
								}
							}
						});
					}else{
						$('#tishi').hide();
						$('#dataBox').show();

						$('#questionTree').html();
						$('#treeTableList').siblings().remove();
						$('#tableList').siblings().remove();

						// $('.clear').trigger('click');

						if (elem.index == 0 || elem.index == 1) {
							$('#buttonShow li').eq(0).click()
							$('.query_two').hide();
							$('.query_one').show();
							$('.layui-lf').show();
							$('.layui-rt').css('width', 'calc(100% - 250px)');
							if (elem.index == 0) {
								$('#test').attr('class', 1);
								$('.search').attr('id', 1);
								getProjectInfo(1);
							} else if (elem.index == 1) {
								$('#test').attr('class', 2);
								$('.search').attr('id', 2);
								getProjectInfo(2);
							}
						}
					}
					if (elem.index == 0) {
						tabNum()
					}else{
						$('#targetNum').text('')
						$('#taskNum').text('')
						$('#assistNum').text('')
					}
                });

                // 监听树列表头部点击事件
                treeTable.on('toolbar(treeTableList)', function (obj) {
                    var planClass = $('.select').attr('planClass');
                    var planId = $('.select').attr('planId');
                    var status = $('.target_tabs').children('.layui-this').attr('opttype');

                    var ids = '';
                    var isClose = false;
                    var isOver = false;
                    initTreeTable.checkStatus().forEach(function (v, i) {
                        if (v.socoreId) {
                            ids += (v.socoreId) + ',';
                        } else {
                            if (planClass == 3) {
                                ids += (v.planItemId) + ',';
                            } else {
                                if (v.tgId) {
                                    ids += (v.tgId) + ',';
                                }
                            }
                        }

                        //判断计划能否被关闭
						if(v.taskStatus==5 || v.taskStatus==6){
							isOver=true
						}

						if (v.taskStatus == 7 || v.taskStatus == 8) {
						    isClose = true
						}

                    });

                    if (!ids && obj.event!='saveDistribute') {
                        layer.msg('请至少选择一项关键任务或子任务！', {icon: 0, time: 1000});
                        return false
                    }

                    switch (obj.event) {
                        case 'distribute':
                            layer.open({
                                type: 1,
                                title: '分配责任人',
                                area: ['30%', '60%'],
                                content: '<form style="margin-top: 20px">' +
                                    '<div class="layui-inline share">\n' +
                                    '                    <label class="layui-form-label" id="mainCenterUser">中心责任部门责任人</label>\n' +
                                    '                    <div class="layui-input-inline">\n' +
                                    '                        <textarea  id="dutyUser" class="layui-textarea"> </textarea>\n' +
                                    '                    </div>\n' +
                                    '                    <a href="javascript:;" style="color:#1E9FFF" type="dutyUser" class="addExecute">添加</a>\n' +
                                    '                    <a href="javascript:;" style="color:#1E9FFF" type="dutyUser" class="clearExecute">清空</a>\n' +
                                    '                </div>' +
										'<div id="moreDutyUser" style="display: none">' +
										'<div class="layui-inline share" style="margin: 5px 0px">\n' +
										'                    <label class="layui-form-label">区域责任部门责任人</label>\n' +
										'                    <div class="layui-input-inline">\n' +
										'                        <textarea  id="mainAreaUser"  class="layui-textarea"> </textarea>\n' +
										'                    </div>\n' +
										'                    <a href="javascript:;" style="color:#1E9FFF"  type="mainAreaUser" class="addExecute">添加</a>\n' +
										'                    <a href="javascript:;" style="color:#1E9FFF" type="mainAreaUser" class="clearExecute">清空</a>\n' +
										'                </div>' +
										'<div class="layui-inline share">\n' +
										'                    <label class="layui-form-label">总承包部责任部门责任人</label>\n' +
										'                    <div class="layui-input-inline">\n' +
										'                        <textarea  id="mainProjectUser"  class="layui-textarea"> </textarea>\n' +
										'                    </div>\n' +
										'                    <a href="javascript:;" style="color:#1E9FFF" type="mainProjectUser" class="addExecute">添加</a>\n' +
										'                    <a href="javascript:;" style="color:#1E9FFF" type="mainProjectUser" class="clearExecute">清空</a>\n' +
										'                </div>' +
										'</div>'+
                                    '</form>',
                                btn: ['确认', '返回'],
                                success: function (layero) {
									if($('.buttonSelect').attr('showtype')== 1){
										$('#moreDutyUser').show()
									}else{
										$('#moreDutyUser').hide()
										$('#mainCenterUser').text('责任人')
									}
                                    //责任人点击添加的按钮
                                    $(".addExecute").on("click", function () {
                                    	var userId=$(this).attr('type')
                                        user_id =userId;
                                        $.popWindow("/projectTarget/selectOwnDeptUser?0");
                                    });

                                    $('.clearExecute').on("click",function () {
										var userId=$(this).attr('type')
                                        $("#"+userId).val("");
										$("#"+userId).attr('username', '');
										$("#"+userId).attr('dataid', '');
										$("#"+userId).attr('user_id', '');
										$("#"+userId).attr('userprivname', '');
                                    });
                                },
                                yes: function (index) {

                                    var dutyUser = $('#dutyUser').attr('user_id')
                                    var mainAreaUser = $('#mainAreaUser').attr('user_id')
                                    var mainProjectUser = $('#mainProjectUser').attr('user_id')
                                    if($('#moreDutyUser').css('display')!='none'){
										if (!dutyUser && !mainAreaUser && !mainProjectUser) {
											layer.msg('请至少选择一个责任人！', {icon: 0, time: 1000});
											return false;
										}
									}else{
										if (!dutyUser) {
											layer.msg('请选择责任人！', {icon: 0, time: 1000});
											return false;
										}
									}

                                    var type = 1;
                                    var data = {ids: ids}

                                    if (planClass == 3) {
                                        type = 2;
                                        data.dutyUser = dutyUser;
                                    }

                                    //判断是主项关键任务还是子任务
									if($('.buttonSelect').attr('showtype')== 1){
										var arr=[]
										var $tr=$('.layui-form-checked').parents('tr')
										$tr.each(function () {
											var obj={}
											obj.tgId=$(this).find('.target_detail').attr('tgid')
											if($(this).find('input[class="search"]').length>0){
												obj.dutyUser=dutyUser
											}
											if($(this).find('input[class="search2"]').length>0){
												obj.mainAreaUser=mainAreaUser
											}
											if($(this).find('input[class="search3"]').length>0){
												obj.mainProjectUser=mainProjectUser
											}
											arr.push(obj)
										})
										// console.log(arr);
										$.ajax({
											url:'/projectTarget/batchDutyUser',
											data:JSON.stringify(arr),
											contentType:"application/json;charset=UTF-8",
											dataType:'json',
											type:'post',
											success:function(res){
												layer.close(index);
												if (res.flag) {
													layer.msg('保存成功', {icon: 1, time: 1000});
													if (status == 1 || status == 2) {
														distributeTable(status, planId, planClass);
													}
												} else {
													layer.msg('保存失败', {icon: 2, time: 1000});
												}
											}
										})
									}else{
										updateTaskOrTarget(type, data, function (res) {
											layer.close(index);
											if (res.flag) {
												layer.msg('保存成功', {icon: 1, time: 1000});
												if (status == 1 || status == 2) {
													distributeTable(status, planId, planClass);
												}
											} else {
												layer.msg('保存失败', {icon: 2, time: 1000});
											}
										});
									}
                                }
                            });
                            break;
                        case 'distributeOver':
							/*在分配完成前判断责任人是否已经被分配*/
							var isPass=''
							if(planClass==1 && $('#questionTree').css('display')!='none'){
								var planTargetPass=true
								/*中心责任部门责任人*/
								$('.tree_table .layui-form-checked').parents('tr').find('.getusername .search').each(function () {
									if(!$(this).attr('user_id')){
										layer.msg('请选择'+$(this).attr('titleName')+'的中心责任部门责任人', {icon: 0, time: 2000});
										isPass=true
										planTargetPass=false
										return false
									}
								})
								if(planTargetPass){
									/*区域责任部门责任人*/
									$('.tree_table .layui-form-checked').parents('tr').find('.getusername2 .search2').each(function () {
										if(!$(this).attr('user_id')){
											layer.msg('请选择'+$(this).attr('titleName')+'的区域责任部门责任人', {icon: 0, time: 2000});
											isPass=true
											planTargetPass=false
											return false
										}
									})
								}
								if(planTargetPass){
									/*总承包部责任部门责任人*/
									$('.tree_table .layui-form-checked').parents('tr').find('.getusername3 .search3').each(function () {
										if(!$(this).attr('user_id')){
											layer.msg('请选择'+$(this).attr('titleName')+'的总承包部责任部门责任人', {icon: 0, time: 2000});
											isPass=true
											return false
										}
									})
								}
							}else if(planClass==3 && $('#questionTree').css('display')!='none'){
								/*责任人*/
								$('.tree_table .layui-form-checked').parents('tr').find('.getusername .search').each(function () {
									if(!$(this).attr('user_id')){
										layer.msg('请选择'+$(this).attr('titleName')+'的责任人', {icon: 0, time: 2000});
										isPass=true
										return false
									}
								})
							}
							if(isPass){
								return false
							}
                            layer.confirm('选中数据分配完成？', function (index) {
                                var type = planClass == 3 ? 2 : 1;
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
                                var data = {ids: ids, allocationStatus: 1,allocationDate:today}
                                /*在分配完成前保存修改的数据*/
								saveTaskOrTarget(type,saveALLDataList,function (res) {
									saveALLDataList=[]
									layer.close(index);
								})
								if(type==1){
									var allocationStatusList=[]
									$('.tree_table .layui-form-checked').parents('tr').each(function () {
										var obj = {
											tgId: $(this).find('.target_detail').attr('tgId')
										}
										if($(this).find('.getusername .search').length > 0){
											obj.allocationStatus=1
											obj.centerAllocationDate=today
										}
										if($(this).find('.getusername2 .search2').length > 0){
											obj.areaAllocationStatus=1
											obj.areaAllocationDate=today
										}
										if($(this).find('.getusername3 .search3').length > 0){
											obj.projectAllocationStatus=1
											obj.projectAllocationDate=today
										}
										allocationStatusList.push(obj)
									})
									saveTaskOrTarget(type,allocationStatusList,function (res) {
										if (res.flag) {
											layer.msg('保存成功', {icon: 1, time: 1000});
											/*  distributeTable(status, planId, planClass);
                                              tabNum()*/
											window.location.reload()
										} else {
											layer.msg('保存失败', {icon: 2, time: 1000});
										}
									})
								}else{
									updateTaskOrTarget(type, data, function (res) {
										if (res.flag) {
											layer.msg('保存成功', {icon: 1, time: 1000});
											/*  distributeTable(status, planId, planClass);
                                              tabNum()*/
											window.location.reload()
										} else {
											layer.msg('保存失败', {icon: 2, time: 1000});
										}
									});
								}
                            });
                            break;
						case 'saveDistribute':
							if(saveALLDataList.length==0){
								layer.msg('暂无修改后保存的内容！', {icon: 0, time: 1000});
								return false
							}
							layer.confirm('确定保存吗？', function (index) {
								var type=''
								//判断是主项关键任务还是子任务---1是主项关键任务，3是子任务
								if($('.select').attr('planclass')==3){
									type=2
								}else if($('.select').attr('planclass')==1){
									type=1
								}
								/*var saveList=[]
								//判断是主项关键任务还是子任务---1是主项关键任务，3是子任务
								if($('.select').attr('planclass')==3){
									type=2
									$('.ew-tree-table-box tr').each(function () {
										var obj={}
										if($(this).find('.search').attr('planItemId')){
											obj.planItemId=$(this).find('.search').attr('planItemId')
										}
										if($(this).find('.search').attr('user_id')){
											obj.dutyUser=$(this).find('.search').attr('user_id').replace(/,$/,'')
										}else{
											obj.dutyUser=''
										}
										obj.hardDegree=$(this).find('.hard_degree').val()
										saveList.push(obj)
									})
									// console.log(saveList)
								}else if($('.select').attr('planclass')==1){
									type=1
									$('.ew-tree-table-box tr').each(function () {
										var obj={}
										if($(this).find('.search').attr('tgId') !='undefined'){
											obj.tgId=$(this).find('.search').attr('tgId')
											if($(this).find('.search').attr('user_id')){
												obj.dutyUser=$(this).find('.search').attr('user_id').replace(/,$/,'')
											}else{
												obj.dutyUser=''
											}
											if($(this).find('.search2').attr('user_id')){
												obj.mainAreaUser=$(this).find('.search2').attr('user_id').replace(/,$/,'')
											}else{
												obj.mainAreaUser=''
											}
											if($(this).find('.search3').attr('user_id')){
												obj.mainProjectUser=$(this).find('.search3').attr('user_id').replace(/,$/,'')
											}else{
												obj.mainProjectUser=''
											}
											obj.hardDegree=$(this).find('.hard_degree').val()
										}
										saveList.push(obj)
									})

								}*/
								saveTaskOrTarget(type,saveALLDataList,function (res) {
									saveALLDataList=[]
									layer.close(index);
									if (res.flag) {
										if(res.msg.indexOf('已经提交审核')!=-1){
											layer.msg(res.msg, {icon: 1, time: 1000});
										}else{
											layer.msg('保存成功', {icon: 1, time: 1000});
										}
										distributeTable(status, planId, planClass);
									} else {
										layer.msg('保存失败', {icon: 2, time: 1000});
									}
								})
							});
							break;
						case 'closePlan':
							if(isOver){
								layer.msg('该计划已完成！', {icon: 0, time: 3000});
								return  false
							}
							if(isClose){
								layer.msg('该计划已关闭或暂停！', {icon: 0, time: 3000});
								return  false
							}
							layer.open({
								type: 1,
								title: '关闭计划',
								area: ['30%', '60%'],
								content: '<div class="layui-form-item">\n' +
										'    <label class="layui-form-label">异常原因</label>\n' +
										'    <div class="layui-input-block">\n' +
										'      <input type="text" name="unusualStuff" autocomplete="off" class="layui-input">\n' +
										'    </div>\n' +
										'  </div>',
								btn: ['确认', '取消'],
								yes: function (index) {
									var planItemIds=''
									var tgIds=''
									if (planClass == 3) {
										planItemIds = ids
									} else {
										tgIds = ids
									}
									var data = {tgIds: tgIds, planItemIds: planItemIds,unusualStuff:$('[name="unusualStuff"]').val()}
									closeTaskOrTarget(data,function (res) {
										if (res.flag) {
											layer.msg('关闭成功', {icon: 1, time: 1000});
											window.location.reload()
										} else {
											layer.msg('关闭失败', {icon: 2, time: 1000});
										}
									})
								}
							});
							break;
                    }
                });

                // 普通表格头部工具条事件监听
                table.on('toolbar(tableList)', function (obj) {
                    var planClass = $('.select').attr('planClass');
                    var checkStatus = table.checkStatus(obj.config.id);
                    if (obj.event!='saveDistribute' && checkStatus.data.length == 0) {
                        layer.msg('最少选中一项关键任务/子任务!', {icon: 0, time: 1000});
                        return false;
                    }
                    var ids = '';
                    var isClose = false;
                    var isOver = false;

                    for (var i = 0; i < checkStatus.data.length; i++) {
                        if (checkStatus.data[i].socoreId) {
                            ids += checkStatus.data[i].socoreId + ',';
                        } else if(checkStatus.data[i].tgId){
                            ids += checkStatus.data[i].tgId + ',';
                        }else if(checkStatus.data[i].planItemId){
							ids += checkStatus.data[i].planItemId + ',';
						}

						//判断计划能否被关闭
						if(checkStatus.data[i].taskStatus==5 || checkStatus.data[i].taskStatus==6){
							isOver=true
						}

						if(checkStatus.data[i].taskStatus==7 || checkStatus.data[i].taskStatus==8){
							isClose=true
						}
                    }

                    switch (obj.event) {
                        case 'distribute':
                            layer.open({
                                type: 1,
                                title: '分配责任人',
                                area: ['450px', '250px'],
                                content: '<form style="margin-top: 20px">' +
                                    '<div class="layui-inline share">\n' +
                                    '                    <label class="layui-form-label"><span style="color: red;">*</span>责任人</label>\n' +
                                    '                    <div class="layui-input-inline">\n' +
                                    '                        <textarea  id="rescueUser" user_id="" class="layui-textarea"> </textarea>\n' +
                                    '                    </div>\n' +
                                    '                    <a href="javascript:;" style="color:#1E9FFF" class="addExecute">添加</a>\n' +
                                    '                    <a href="javascript:;" style="color:#1E9FFF" class="clearExecute">清空</a>\n' +
                                    '                </div>' +
                                    '</form>',
                                btn: ['确认', '返回'],
                                success: function () {
                                    $(".addExecute").on("click", function () {
                                        user_id = "rescueUser";
                                        $.popWindow("/projectTarget/selectOwnDeptUser?0");
                                    });

                                    $('.clearExecute').on("click",function () {
                                        $("#rescueUser").val("");
                                        $("#rescueUser").attr('username', '');
                                        $("#rescueUser").attr('dataid', '');
                                        $("#rescueUser").attr('user_id', '');
                                        $("#rescueUser").attr('userprivname', '');
                                    });
                                },
                                yes: function (index) {

                                    var userId = $('#rescueUser').attr('user_id') || '';

                                    if (!userId) {
                                        layer.msg('请选择责任人！', {icon: 0, time: 1000});
                                        return false;
                                    }

									//判断是职能关键任务还是协助子任务
									if (planClass == 2 && $('#questionTree').css('display')!='none') {
										var type = 1
									} else {
										var type = 2
									}
                                    // updateTaskOrTarget(1, {ids: ids, userId: userId}, function (res) {
                                    updateTaskOrTarget(type, {ids: ids, dutyUser: userId}, function (res) {
                                        layer.close(index);
                                        if (res.flag) {
                                            layer.msg('保存成功', {icon: 1, time: 1000});
                                            tableList.config.where._ = new Date().getTime();
                                            tableList.reload();
                                        } else {
                                            layer.msg('保存失败', {icon: 2, time: 1000});
                                        }
                                    });
                                }
                            });
                            break;
                        case 'distributeOver':
							/*在分配完成前判断责任人是否已经被分配*/
							var isPass=''
							if(planClass==2 && $('#questionTree').css('display')!='none'){
								/*责任人*/
								$('.table_list .layui-form-checked').parents('tr').find('.getusername .search').each(function () {
									if(!$(this).attr('user_id')){
										layer.msg('请选择'+$(this).attr('titleName')+'的责任人', {icon: 0, time: 2000});
										isPass=true
										return false
									}
								})
							}else{
								/*协作人*/
								$('.table_list .layui-form-checked').parents('tr').find('.getusername .search').each(function () {
									if(!$(this).attr('user_id')){
										layer.msg('请选择'+$(this).attr('titleName')+'的协作人', {icon: 0, time: 2000});
										isPass=true
										return false
									}
								})
							}
							if(isPass){
								return false
							}
                            layer.confirm('选中数据分配完成？', function (index) {
                                //判断是职能关键任务还是协助子任务
                                if (planClass == 2 && $('#questionTree').css('display')!='none') {
                                    var type = 1
                                } else {
                                    var type = 3
                                }
                                // var type = planClass == 3 ? 2 : 1;
                                var data = {ids: ids, allocationStatus: 1}
                                if(type==1){
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
                                	data.centerAllocationDate=today
								}
								/*在分配完成前保存修改的数据*/
								if(saveALLDataList.length>0){
									saveTaskOrTarget(type,saveALLDataList,function (res) {
										saveALLDataList=[]
										layer.close(index);
									})
								}
								if(type==1){
									updateTaskOrTarget(type, data, function (res) {
										if (res.flag) {
											layer.msg('保存成功', {icon: 1, time: 1000});
											/*  tableList.config.where._ = new Date().getTime();
                                              tableList.reload();
                                              tabNum()*/
											window.location.reload()
										} else {
											layer.msg('保存失败', {icon: 2, time: 1000});
										}
									});
								}else{
									var assistDataList=[]
									checkStatus.data.forEach(function (v) {
										assistDataList.push({
											assistId:v.assistId,
											allocationStatus:1
										})
									})
									saveTaskOrTarget(type,assistDataList,function (res) {
										layer.close(index);
										if (res.flag) {
											layer.msg('保存成功', {icon: 1, time: 1000});
											/*  tableList.config.where._ = new Date().getTime();
                                              tableList.reload();
                                              tabNum()*/
											window.location.reload()
										} else {
											layer.msg('保存失败', {icon: 2, time: 1000});
										}
									})
								}
                            });
                            break;
						case 'saveDistribute':
							if(saveALLDataList.length==0){
								layer.msg('暂无修改后保存的内容！', {icon: 0, time: 1000});
								return false
							}
							layer.confirm('确定保存吗？', function (index) {
								var type=''
								if($('.select').attr('planclass')==2 && $('#questionTree').css('display')!='none'){
									type=1
								}else{
									type=3
								}
								/*var saveList=[]
								//判断是分配还是考核----2是职能
								if($('.select').attr('planclass')==2 && $('.layui-lf').css('display')!='none'){
									type=1
									$('.layui-table-main tr').each(function () {
										var obj={}
										if($(this).find('.search').attr('tgid')){
											obj.tgId=$(this).find('.search').attr('tgid')
										}
										if($(this).find('.search').attr('user_id')){
											obj.dutyUser=$(this).find('.search').attr('user_id').replace(/,$/,'')
										}else{
											obj.dutyUser=''
										}
										obj.hardDegree=$(this).find('.hard_degree').val()
										saveList.push(obj)
									})
									// console.log(saveList)
								}else{
									type=3
									$('.layui-table-main tr').each(function () {
										var obj={}
										if($(this).find('.change_progress').attr('socoreId')){
											obj.socoreId=$(this).find('.change_progress').attr('socoreId')
											obj.taskPrecess=$(this).find('.change_progress').val()
											obj.qualityScore=$(this).find('.change_score').val()
											obj.apprivalComment=$(this).find('.change_comment').val()
										}
										saveList.push(obj)
									})
								}*/
								saveTaskOrTarget(type,saveALLDataList,function (res) {
									saveALLDataList=[]
									layer.close(index);
									if (res.flag) {
										layer.msg('保存成功', {icon: 1, time: 1000});
										tableList.config.where._ = new Date().getTime();
										tableList.reload();
									} else {
										layer.msg('保存失败', {icon: 2, time: 1000});
									}
								})
							});
							break;
						case 'closePlan':
							if(isOver){
								layer.msg('该计划已完成！', {icon: 0, time: 3000});
								return  false
							}
							if(isClose){
								layer.msg('该计划已关闭或暂停！', {icon: 0, time: 3000});
								return  false
							}
							layer.open({
								type: 1,
								title: '关闭计划',
								area: ['30%', '35%'],
								content: '<div class="layui-form-item" style="width: 95%;margin-top: 15px">\n' +
										'    <label class="layui-form-label">异常原因</label>\n' +
										'    <div class="layui-input-block">\n' +
										'      <input type="text" name="unusualStuff" autocomplete="off" class="layui-input">\n' +
										'    </div>\n' +
										'  </div>',
								btn: ['确认', '取消'],
								yes: function (index) {
									var planItemIds=''
									var tgIds=''
									if (planClass == 3) {
										planItemIds = ids
									} else {
										tgIds = ids
									}
									var data = {tgIds: tgIds, planItemIds: planItemIds,unusualStuff:$('[name="unusualStuff"]').val()}
									closeTaskOrTarget(data,function (res) {
										if (res.flag) {
											layer.msg('关闭成功', {icon: 1, time: 1000});
											window.location.reload()
										} else {
											layer.msg('关闭失败', {icon: 2, time: 1000});
										}
									})
								}
							});
							break;
                    }
                });

                // 监听未分配、已分配难度系数单元格编辑
                $(document).on('blur', '.hard_degree', function () {
                    var planId = $('.select').attr('planId');
                    var status = $('.target_tabs').children('.layui-this').attr('opttype');
                    var planClass = $('.select').attr('planClass');

                    var ids = $(this).attr('ids');
                    var value = $(this).val().trim();
                    var taskType = $(this).attr('taskType');
                    var taskPrecess = $(this).attr('taskPrecess') || 0;
                    var qualityScore = $(this).attr('qualityScore') || 0;

                    if (value == '' || value == '0') {
                        return false;
                    }

                    var data = {
                        hardDegree: value,
                        qualityScore: qualityScore,
                        taskPrecess: taskPrecess
                    }
                    if (taskType == 1) {
                        data.tgId = ids;
                    } else {
                        data.planItemId = ids;
                    }
                    var index = -1;
                    for(var i=0;i<saveALLDataList.length;i++){
						if(saveALLDataList[i].tgId && saveALLDataList[i].tgId==data.tgId){
							index = i;
						}else if(saveALLDataList[i].planItemId && saveALLDataList[i].planItemId==data.planItemId){
							index = i;
						}
						break
					}
                    if (index >= 0) {
						saveALLDataList[index].hardDegree=data.hardDegree
					} else {
                    	if(data.tgId){
							saveALLDataList.push({tgId:data.tgId,hardDegree:data.hardDegree})
						}else{
							saveALLDataList.push({planItemId:data.planItemId,hardDegree:data.hardDegree})
						}

					}
                });

                /***
                 * 已分配、未分配列表加载方法
                 * @param status (1-未分配，2-已分配)
                 * @param planId (计划上报id)
                 * @param planClass (计划上报类型 1-主项关键任务，2-职能关键任务，3-计划子任务)
                 * @param searchObj (查询条件对象)
                 */
                function distributeTable(status, planId, planClass, searchObj) {
                    var cols = null;
                    var toolBar = '#distributeBar';
                    if (planClass == 1) {
                        cols = [[
                            {type: 'checkbox'},
                         /*   {
                                field: 'tgNo', title: '编号', minWidth: 300, align: 'left', templet: function (d) {
                                    if (d.projectNo) {
                                        return '<span>' + d.projectNo + '</span>'
                                    } else if (d.bagNumber) {
                                        return '<span>' + d.bagNumber + '</span>'
                                    } else if (d.tgNo) {
                                        return '<span>' + d.tgNo + '</span>'
                                    } else {
                                        return ''
                                    }
                                }
                            },*/
                            {
                                field: 'tgName', title: '子项目/关键任务名称', minWidth: 400, align: 'left', templet: function (d) {
                                    if (d.projectName) {
                                        return '<span><a>【项目】</a>' + d.projectName + '</span>'
                                    } else if (d.pbagName) {
                                        return '<span><a>【子项目】</a>' + d.pbagName + '</span>'
                                    } else if (d.tgName) {
                                        if (status == 2) {
                                            return '<span tgId="' + d.tgId + '" class="target_detail" planClass="1" style="color: blue;cursor: pointer">【关键任务】' + d.tgName + '</span>'
                                        } else {
                                            return '<span tgId="' + d.tgId + '" class="target_detail" planClass="1" style="color: blue;cursor: pointer">【关键任务】' + d.tgName + '</span>'
                                        }

                                    } else {
                                        return ''
                                    }
                                }
                            },
                            {
                                field: 'dutyUserName', title: '中心责任部门责任人', minWidth: 170, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '<span class="search" tgId="' + d.tgId + '"></span>';
                                    } else {
                                        if (authorityObject && authorityObject['26']) {
                                            //判断是否可编辑
                                            if (d.isEdit.mainCenterUser && d.mainCenterDeptName) {
                                                return '<div class="username getusername" style="z-index:99999">' +
                                                    ' <input titleName="'+'【关键任务】'+d.tgName+'" id="targer_' + d.tgId + '" class="search" tgId="' + d.tgId + '" value="' + (d.dutyUserName || '') + '" user_id="' + (d.dutyUser || '') + '" type="text" name="parentId" style="width: 100%;height: 27px;border:none;background: #fff" disabled placeholder="搜索用户"/>' +
                                                    '<span style="padding: 5px;color: #999;cursor: pointer;margin-left:-26px"><i class="layui-icon layui-icon-username remind"></i></span>' +
                                                    '</div>' +
                                                    '</div>'
                                            } else {
                                                return '<span  class="search" tgId="' + d.tgId + '">'+(d.dutyUserName || '' )+'</span>';
                                            }
                                        } else {
											return '<span  class="search" tgId="' + d.tgId + '">'+(d.dutyUserName || '') +'</span>';
                                        }
                                    }
                                }
                            },
	                        {
	                            field: 'mainCenterDeptName', title: '中心责任部门', minWidth: 150, align: 'cneter'
	                        },
                            {
                                field: 'mainAreaUserName', title: '区域责任部门责任人', minWidth: 150, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '<span class="search2" tgId="' + d.tgId + '"></span>';
                                    } else {
                                        if (authorityObject && authorityObject['26']) {
                                            if (d.isEdit.mainAreaUser && d.mainAreaDeptName) {
                                                return '<div class="username getusername2" style="z-index:99999">' +
                                                    ' <input titleName="'+'【关键任务】'+d.tgName+'" id="targerArea_' + d.tgId + '" class="search2" tgId="' + d.tgId + '" value="' + (d.mainAreaUserName || '') + '" user_id="' + (d.mainAreaUser || '') + '" type="text" name="parentId" style="width: 100%;height: 27px;border:none;background: #fff" disabled placeholder="搜索用户"/>' +
                                                    '<span style="padding: 5px;color: #999;cursor: pointer;margin-left:-26px"><i class="layui-icon layui-icon-username remind"></i></span>' +
                                                    '</div>' +
                                                    '</div>'
                                            } else {
                                                return '<span class="search2" tgId="' + d.tgId + '">'+(d.mainAreaUserName || '')+'</span>';
                                            }
                                        } else {
                                            return '<span class="search2" tgId="' + d.tgId + '">'+(d.mainAreaUserName || '')+'</span>';
                                        }
                                    }
                                }
                            },
	                        {
	                            field: 'mainAreaDeptName', title: '区域责任部门', minWidth: 150, align: 'cneter'
	                        },
                            {
                                field: 'mainProjectUserName', title: '总承包部责任部门责任人', minWidth: 180, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
										return '<span class="search3" tgId="' + d.tgId + '"></span>';
                                    } else {
                                        if (authorityObject && authorityObject['26']) {
                                            if (d.isEdit.mainProjectUser && d.mainProjectDeptName) {
                                                return '<div class="username getusername3" style="z-index:99999">' +
                                                    ' <input titleName="'+'【关键任务】'+d.tgName+'" id="targerProject_' + d.tgId + '" class="search3" tgId="' + d.tgId + '" value="' + (d.mainProjectUserName || '') + '" user_id="' + (d.mainProjectUser || '') + '" type="text" name="parentId" style="width: 100%;height: 27px;border:none;background: #fff" disabled placeholder="搜索用户"/>' +
                                                    '<span style="padding: 5px;color: #999;cursor: pointer;margin-left:-26px"><i class="layui-icon layui-icon-username remind"></i></span>' +
                                                    '</div>' +
                                                    '</div>'
                                            } else {
                                                return '<span class="search3" tgId="' + d.tgId + '">'+(d.mainProjectUserName || '')+'</span>';
                                            }
                                        } else {
                                            return '<span class="search3" tgId="' + d.tgId + '">'+(d.mainProjectUserName || '')+'</span>';
                                        }
                                    }
                                }
                            },
	                        {
	                            field: 'mainProjectDeptName', title: '总承包部责任部门', minWidth: 150, align: 'center'
	                        },
                            {
                                field: 'hardDegree', title: '难度系数', minWidth: 100, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '';
                                    } else {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            return '<input class="layui-input number_input hard_degree" fieldName="hardDegree" taskPrecess="' + (d.taskPrecess || 0) + '" qualityScore="' + (d.qualityScore || 0) + '" taskType="1" ids="' + d.tgId + '" type="text" value="' + d.hardDegree + '">';
                                        } else {
                                            return d.hardDegree || '';
                                        }
                                    }
                                }
                            },
                            {
                                field: 'planStartDate', title: '计划开始时间', minWidth: 150, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '';
                                    } else {
										return format(d.planStartDate);
                                        /*if (authorityObject && authorityObject['26']) {
                                            var startDateStr = '<input type="text" class="layui-input table_date_start" readonly taskType="1" ids="' + d.tgId + '" enddate="'+(d.planEndDate || '')+'" value="' + d.planStartDate + '">';
                                            return startDateStr;
                                        } else {
                                            return format(d.planStartDate);
                                        }*/
                                    }
                                }
                            },
                            {
                                field: 'planEndDate', title: '计划结束时间', minWidth: 150, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '';
                                    } else {
										return format(d.planEndDate);
                                        /*if (authorityObject && authorityObject['26']) {
                                            var planEndDateStr = '<input type="text" class="layui-input table_date_end" readonly taskType="1" ids="' + d.tgId + '" startdate="'+(d.planStartDate || '')+'" value="' + d.planEndDate + '">';
                                            return planEndDateStr;
                                        } else {
                                            return format(d.planEndDate);
                                        }*/
                                    }
                                }
                            },
                            {
                                field: 'planContinuedDate', title: '计划工期', minWidth: 100, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '';
                                    } else {
                                        return d.planContinuedDate || '';
                                    }
                                }
                            },
	                        {
                                field: 'itemQuantity', title: '工程量', minWidth: 100, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '';
                                    } else {
                                        return d.itemQuantity || '';
                                    }
                                }
                            },
                            {
                                field: 'itemQuantityNuit', title: '单位', minWidth: 120, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '';
                                    } else {
                                        return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || '';
                                    }
                                }
                            },
                            {
                                field: 'controlLevel', title: '关注等级', minWidth: 120, align: 'left', templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '';
                                    } else {
                                        return dictionaryObj['UNIT']['object'][d.controlLevel] || '';
                                    }
                                }
                            },
                        ]];
                    } else if (planClass == 2 || planClass == 4) {
                        //职能关键任务--planClass=2     协助关键任务planClass=4
                        if (planClass == 2) {
                            cols = [[
                                {type: 'checkbox'},
                                // {field: 'tgNo', title: '编码', minWidth: 200, align: 'left'},
                                {
                                    field: 'tgName', title: '关键任务名称', minWidth: 400, align: 'left', templet: function (d) {
                                        if (status == 2) {
                                            return '<span tgId="' + d.tgId + '" class="target_detail" style="color: blue;cursor: pointer">' + d.tgName + '</span>'
                                        } else {
                                            return '<span tgId="' + d.tgId + '" class="target_detail" style="color: blue;cursor: pointer">' + d.tgName + '</span>'
                                        }
                                    }
                                },
                                {
                                    field: 'dutyUserName', title: '责任人', minWidth: 130, align: 'left',sort: true
                                    , templet: function (d) {
                                        if (authorityObject && authorityObject['26']) {
                                            return '<div class="username getusername" style="z-index:99999">' +
                                                '<input titleName="'+d.tgName+'" id="target_' + d.tgId + '" class="search" user_id="' + (d.dutyUser || '') + '" tgId="' + d.tgId + '" value="' + (d.dutyUserName || '') + '" type="text" name="parentId" style="width: 100%;height: 27px;border:none;background: #fff" disabled placeholder="搜索用户"/>' +
                                                '<span style="padding: 5px;color: #999;cursor: pointer;margin-left:-26px"><i class="layui-icon layui-icon-username remind"></i></span>' +
                                                '</div>' +
                                                '</div>';
                                        } else {
                                            return '<span class="search" tgId="' + d.tgId + '">'+(d.dutyUserName || '')+'</span>';
                                        }
                                    }
                                },
	                            {
                                    field: 'hardDegree',
                                    title: '难度系数',
                                    minWidth: 120,
                                    align: 'left',
                                    templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            return '<input class="layui-input number_input hard_degree" user_id="' + (d.dutyUser || '') + '" taskPrecess="' + (d.taskPrecess || 0) + '" qualityScore="' + (d.qualityScore || 0) + '" fieldName="hardDegree" taskType="1" ids="' + d.tgId + '" style="height: 100%;" type="text" value="' + d.hardDegree + '">';
                                        } else {
                                            return d.hardDegree || '';
                                        }
                                    }
                                },
                                {
                                    field: 'planStartDate', title: '计划开始时间', minWidth: 150, templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            var startDateStr = '<input type="text" class="layui-input table_date_start" style="height: 100%;" readonly taskType="1" ids="' + d.tgId + '" enddate="'+(d.planEndDate || '')+'" value="' + d.planStartDate + '">';
                                            return startDateStr;
                                        } else {
                                            return format(d.planStartDate);
                                        }
                                    }
                                },
                                {
                                    field: 'planEndDate', title: '计划结束时间', minWidth: 150, templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            var planEndDateStr = '<input type="text" class="layui-input table_date_end" style="height: 100%;" readonly taskType="1" ids="' + d.tgId + '" startdate="'+(d.planStartDate || '')+'" value="' + d.planEndDate + '">';
                                            return planEndDateStr;
                                        } else {
                                            return format(d.planEndDate);
                                        }
                                    }
                                },
                                {field: 'planContinuedDate', title: '计划工期', minWidth: 150},
                                {field: 'itemQuantity', title: '工程量', minWidth: 100, align: 'left'},
                                {
                                    field: 'itemQuantityNuit', title: '单位', minWidth: 100, align: 'left', templet: function (d) {
                                        return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || '';
                                    }
                                }
                            ]];
                        } else if (planClass == 4) {
                            cols = [[
                                {type: 'checkbox'},
                                // {field: 'tgNo', title: '编码', minWidth: 200, align: 'left'},
                                {
                                    field: 'tgName', title: '关键任务名称', minWidth: 400, align: 'left', templet: function (d) {
                                        if (status == 2) {
                                            return '<span tgId="' + d.tgId + '" class="target_detail" style="color: blue;cursor: pointer">' + d.tgName + '</span>'
                                        } else {
                                            return '<span>' + d.tgName + '</span>'
                                        }
                                    }
                                },
                                {
                                    field: 'assistUserName', title: '协助人', minWidth: 130, align: 'left',sort: true
                                    , templet: function (d) {
                                        if (authorityObject && authorityObject['26']) {
                                            return '<div class="username getusername" style="z-index:99999">' +
                                                '<input id="targetAssist_' + d.tgId + '" class="search" tgId="' + d.tgId + '" value="' + (d.assistUserName || '') + '" type="text" name="parentId" style="width: 100%;height: 27px;border:none;background: #fff" disabled placeholder="搜索用户"/>' +
                                                '<span style="padding: 5px;color: #999;cursor: pointer;margin-left:-26px"><i class="layui-icon layui-icon-username remind"></i></span>' +
                                                '</div>' +
                                                '</div>';
                                        } else {
                                            return d.assistUserName || '';
                                        }
                                    }
                                },
                                {
                                    field: 'hardDegree',
                                    title: '难度系数',
                                    minWidth: 120,
                                    align: 'left',
                                    templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            return '<input class="layui-input number_input hard_degree" taskPrecess="' + (d.taskPrecess || 0) + '" qualityScore="' + (d.qualityScore || 0) + '" fieldName="hardDegree" taskType="1" ids="' + d.tgId + '" style="height: 100%;" type="text" value="' + d.hardDegree + '">';
                                        } else {
                                            return d.hardDegree || '';
                                        }
                                    }
                                },
                                {
                                    field: 'planStartDate', title: '计划开始时间', minWidth: 150, templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            var startDateStr = '<input type="text" class="layui-input table_date_start" style="height: 100%;" readonly taskType="1" ids="' + d.tgId + '" enddate="'+(d.planEndDate || '')+'" value="' + d.planStartDate + '">';
                                            return startDateStr;
                                        } else {
                                            return format(d.planStartDate);
                                        }
                                    }
                                },
                                {
                                    field: 'planEndDate', title: '计划结束时间', minWidth: 150, templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            var planEndDateStr = '<input type="text" class="layui-input table_date_end" style="height: 100%;" readonly taskType="1" ids="' + d.tgId + '" startdate="'+(d.planStartDate || '')+'" value="' + d.planEndDate + '">';
                                            return planEndDateStr;
                                        } else {
                                            return format(d.planEndDate);
                                        }
                                    }
                                },
                                {field: 'planContinuedDate', title: '计划工期', minWidth: 150},
	                            {field: 'itemQuantity', title: '工程量', minWidth: 100, align: 'left'},
                                {
                                    field: 'itemQuantityNuit', title: '单位', minWidth: 100, align: 'left', templet: function (d) {
                                        return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || '';
                                    }
                                }
                            ]];
                        }

                    } else if (planClass == 3 || planClass == 5) {
                        //子任务--planClass=3    协助子任务planClass=5
                        if (planClass == 3) {
                            cols = [[
                                {type: 'checkbox'},
                                // {field: 'taskNo', title: '编码', minWidth: 300, align: 'left'},
                                {
                                    field: 'taskName', title: '子任务名称', minWidth: 300, align: 'left', templet: function (d) {
                                        if (status == 2) {
                                            return '<span planItemId="' + d.planItemId + '" class="task_detail" style="color: blue;cursor: pointer">' + d.taskName + '</span>'
                                        } else {
                                            return '<span planItemId="' + d.planItemId + '" class="task_detail" style="color: blue;cursor: pointer">' + d.taskName + '</span>'
                                        }
                                    }
                                },
                                {
                                    field: 'dutyUserName', title: '责任人', minWidth: 130, align: 'left', templet: function (d) {
                                        if (d.planItemId) {
                                            if (authorityObject && authorityObject['26']) {
                                                return '<div class="username getusername" style="z-index:99999">' +
                                                    '<input titleName="'+d.taskName+'" id="task_' + d.planItemId + '" class="search" planItemId="' + d.planItemId + '"  value="' + (d.dutyUserName || '') + '" user_id="' + (d.dutyUser || '') + '" type="text" name="parentId" style="width: 100%;height: 27px;border:none;background: #fff" disabled placeholder="搜索用户"/>' +
                                                    '<span style="padding: 5px;color: #999;cursor: pointer;margin-left:-26px"><i class="layui-icon layui-icon-username remind"></i></span>' +
                                                    '</div>' +
                                                    '</div>';
                                            } else {
                                                return '<span class="search" planItemId="' + d.planItemId + '" >'+(d.dutyUserName || '')+'</span>';
                                            }
                                        } else {
                                            return '';
                                        }
                                    }
                                },
                                {
                                    field: 'hardDegree', title: '难度系数', minWidth: 100, align: 'left', templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            return '<input class="layui-input number_input hard_degree" taskPrecess="' + (d.taskPrecess || 0) + '" qualityScore="' + (d.qualityScore || 0) + '" fieldName="hardDegree" taskType="2" ids="' + d.planItemId + '" type="text" value="' + d.hardDegree + '">';
                                        } else {
                                            return d.hardDegree || '';
                                        }
                                    }
                                },
                                {
                                    field: 'planStartDate', title: '计划开始时间', minWidth: 150, align: 'left', templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            var startDateStr = '<input type="text" class="layui-input table_date_start" readonly taskType="2" ids="' + d.planItemId + '" enddate="'+(d.planEndDate || '')+'" value="' + d.planStartDate + '">';
                                            return startDateStr;
                                        } else {
                                            return format(d.planStartDate);
                                        }
                                    }
                                },
                                {
                                    field: 'planEndDate', title: '计划结束时间', minWidth: 150, align: 'left', templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            var planEndDateStr = '<input type="text" class="layui-input table_date_end" readonly taskType="2" ids="' + d.planItemId + '" startdate="'+(d.planStartDate || '')+'" value="' + d.planEndDate + '">';
                                            return planEndDateStr;
                                        } else {
                                            return format(d.planEndDate);
                                        }
                                    }
                                },
                                {field: 'planContinuedDate', title: '计划工期', minWidth: 100, align: 'left'}
                            ]];
                        } else if (planClass == 5) {
                            cols = [[
                                {type: 'checkbox'},
                                // {field: 'taskNo', title: '编码', minWidth: 300, align: 'left'},
                                {
                                    field: 'taskName', title: '子任务名称', minWidth: 300, align: 'left', templet: function (d) {
                                        if (status == 2) {
                                            return '<span planItemId="' + d.planItemId + '" class="task_detail" style="color: blue;cursor: pointer">' + d.taskName + '</span>'
                                        } else {
                                            return '<span>' + d.taskName + '</span>'
                                        }
                                    }
                                },
                                {
                                    field: 'assistUserName', title: '协作人', minWidth: 130, align: 'left',sort: true, templet: function (d) {
                                        if (d.planItemId) {
                                            if (authorityObject && authorityObject['26']) {
                                                return '<div class="username getusername" style="z-index:99999">' +
                                                    '<input id="taskAssist_' + d.planItemId + '" class="search" planItemId="' + d.planItemId + '"  value="' + (d.assistUserName || '') + '" user_id="' + (d.assistUser || '') + '" type="text" name="parentId" style="width: 100%;height: 27px;border:none;background: #fff" disabled placeholder="搜索用户"/>' +
                                                    '<span style="padding: 5px;color: #999;cursor: pointer;margin-left:-26px"><i class="layui-icon layui-icon-username remind"></i></span>' +
                                                    '</div>' +
                                                    '</div>';
                                            } else {
                                                return d.assistUserName || '';
                                            }
                                        } else {
                                            return '';
                                        }
                                    }
                                },
                                {
                                    field: 'hardDegree', title: '难度系数', minWidth: 100, align: 'left', templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            return '<input class="layui-input number_input hard_degree" taskPrecess="' + (d.taskPrecess || 0) + '" qualityScore="' + (d.qualityScore || 0) + '" fieldName="hardDegree" taskType="2" ids="' + d.planItemId + '" type="text" value="' + d.hardDegree + '">';
                                        } else {
                                            return d.hardDegree || '';
                                        }
                                    }
                                },
                                {
                                    field: 'planStartDate', title: '计划开始时间', minWidth: 150, align: 'left', templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            var startDateStr = '<input type="text" class="layui-input table_date_start" readonly taskType="2" ids="' + d.planItemId + '" enddate="'+(d.planEndDate || '')+'" value="' + d.planStartDate + '">';
                                            return startDateStr;
                                        } else {
                                            return format(d.planStartDate);
                                        }
                                    }
                                },
                                {
                                    field: 'planEndDate', title: '计划结束时间', minWidth: 150, align: 'left', templet: function (d) {
                                        if (authorityObject && authorityObject['26'] && $('.layui-this').text().indexOf('未') != -1) {
                                            var planEndDateStr = '<input type="text" class="layui-input table_date_end" readonly taskType="2" ids="' + d.planItemId + '" startdate="'+(d.planStartDate || '')+'" value="' + d.planEndDate + '">';
                                            return planEndDateStr;
                                        } else {
                                            return format(d.planEndDate);
                                        }
                                    }
                                },
                                {field: 'planContinuedDate', title: '计划工期', minWidth: 100, align: 'left'}
                            ]];
                        }
                    }else{
						cols = [[
							{type: 'checkbox'},
							{
								field: 'taskName', title: '子任务名称', minWidth: 300, align: 'left', templet: function (d) {
									if (d.planItemId) {
										return '<span planItemId="' + d.planItemId + '" class="task_detail" style="color: blue;cursor: pointer">' + d.taskName + '</span>'
									} else {
										return ''
									}
								}
							},
							{
								field: 'assistUserName', title: '协作人', minWidth: 130, align: 'left',sort: true, templet: function (d) {
									if (d.planItemId) {
										if (authorityObject && authorityObject['26']) {
											return '<div class="username getusername" style="z-index:99999">' +
													'<input titleName="'+d.taskName+'" id="taskAssist_' + d.assistId + '" class="search" assistId="' + d.assistId + '"  value="' + (d.assistUserName || '') + '" user_id="' + (d.assistUser || '') + '" type="text" name="parentId" style="width: 100%;height: 27px;border:none;background: #fff" disabled placeholder="搜索用户"/>' +
													'<span style="padding: 5px;color: #999;cursor: pointer;margin-left:-26px"><i class="layui-icon layui-icon-username remind"></i></span>' +
													'</div>' +
													'</div>';
										} else {
											return d.assistUserName || '';
										}
									} else {
										return '';
									}
								}
							},
							{field: 'assistDeptName', title: '协作部门', minWidth: 120, align: 'left'},
							/*{
								field: 'hardDegree', title: '难度系数', minWidth: 100, align: 'left', templet: function (d) {
									if (authorityObject && authorityObject['26']) {
										return '<input class="layui-input number_input hard_degree" taskPrecess="' + (d.taskPrecess || 0) + '" qualityScore="' + (d.qualityScore || 0) + '" fieldName="hardDegree" taskType="2" ids="' + d.planItemId + '" type="text" value="' + d.hardDegree + '">';
									} else {
										return d.hardDegree || '';
									}
								}
							},*/
							// {
							//     field: 'controlLevel', title: '关注等级', minWidth: 100, align: 'left', templet: function (d) {
							//         return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || '';
							//     }
							// },
							{
								field: 'planStartDate', title: '计划开始时间', minWidth: 150, align: 'left', templet: function (d) {
									return format(d.planStartDate);
									/*if (authorityObject && authorityObject['26']) {
										var startDateStr = '<input type="text" class="layui-input table_date_start" readonly taskType="2" ids="' + d.planItemId + '" enddate="'+(d.planEndDate || '')+'" value="' + d.planStartDate + '">';
										return startDateStr;
									} else {
										return format(d.planStartDate);
									}*/
								}
							},
							{
								field: 'planEndDate', title: '计划结束时间', minWidth: 150, align: 'left', templet: function (d) {
									return format(d.planEndDate);
									/*if (authorityObject && authorityObject['26']) {
										var planEndDateStr = '<input type="text" class="layui-input table_date_end" readonly taskType="2" ids="' + d.planItemId + '" startdate="'+(d.planStartDate || '')+'" value="' + d.planEndDate + '">';
										return planEndDateStr;
									} else {
										return format(d.planEndDate);
									}*/
								}
							},
							{field: 'planContinuedDate', title: '计划工期', minWidth: 100, align: 'left'}
						]];
					}
                    initTableList(status, planId, planClass, cols, toolBar, searchObj);
                }

                /**
                 * 加载关键任务、子任务列表实际方法
                 * @param status (1-未分配, 2-已分配, 3-未考核, 4-已考核)
                 * @param planId (计划上报id)
                 * @param planClass (计划上报类型 1-主项关键任务，2-职能关键任务，3-计划子任务)
                 * @param cols (列表显示的列)
                 * @param toolBar (列表头部对应的工具条)
                 * @param searchObj (查询条件对象)
                 */
                function initTargetOrTaskTable(status, planId, planClass, cols, toolBar, searchObj) {
                    if (status == 1 || status == 2) {
                        if (planClass == 1 || planClass == 3) {
                            if (planClass == 1) {
                                var childName = "children"
                            } else if (planClass == 3) {
                                var childName = "items"
                            }
                            initTreeTable = treeTable.render({
                                elem: '#treeTableList'
                                , url: '/plcPlan/selectByPlanIdAndPer'
                                , where: {planId: planId, status: status,_:new Date().getTime()}
                                , toolbar: toolBar
                                , defaultToolbar: ['']
                                , tree: {
                                    iconIndex: 1,
                                    // isPidData: true,
                                    idName: 'planItemId',
                                    childName: childName,
                                    openName: 'open',
		                            onlyIconControl: true
                                }
                                , cols: cols
	                            , height: 'full-125'
                                , parseData: function (res) { //res 即为原始返回的数据
                                    return {
                                        "code": 0, //解析接口状态
                                        "data": res.object //解析数据列表
                                    };
                                },
                                done: function (res) {
                                    //只在未分配显示该按钮
                                    if (status != 1) {
                                        $('#distributeOver').hide()
                                    }
                                    //项目关键任务不显示关闭按钮
									if(planClass==1){
										$('.closePlan').hide()
									}
                                    // 责任人的选人控件
                                    $('.getusername').on("click",function () {
                                        user_id = $(this).children('.search').attr('id');
                                        $.popWindow("/projectTarget/selectOwnDeptUser?0");
                                    });
									$('.getusername2').on("click",function () {
										user_id = $(this).children('.search2').attr('id');
										$.popWindow("/projectTarget/selectOwnDeptUser?0");
									});
									$('.getusername3').on("click",function () {
										user_id = $(this).children('.search3').attr('id');
										$.popWindow("/projectTarget/selectOwnDeptUser?0");
									});

                                    // 选择时间控件
                                    var $tableTrEles = $('#treeTableList').next().find('.ew-tree-table-box tr');
                                    
                                    $tableTrEles.each(function () {
                                        var tableDateStartEle = $(this).find('.table_date_start').get(0);
                                        if (tableDateStartEle) {
                                            var enddate = $(tableDateStartEle).attr('enddate') || '2099-12-31';
                                            var startDatePickConfig = {
                                                elem: tableDateStartEle,
                                                format: 'yyyy-MM-dd',
                                                btns: ['now', 'confirm'],
                                                max: enddate,
                                                done: function (value, date) {
                                                    var taskType = this.elem[0].getAttribute("taskType");
                                                    var ids = this.elem[0].getAttribute("ids");
                                                    
                                                    var $tr = $(tableDateStartEle).parents('tr').eq(0);
                                                    var planPeriod = timeRange(value, $tr.find('.table_date_end').eq(0).val()) + '天';
                                                    
                                                    var index = -1;
                                                    for (var i = 0; i < saveALLDataList.length; i++) {
                                                        if (saveALLDataList[i].tgId && saveALLDataList[i].tgId == ids) {
                                                            index = i;
                                                        } else if (saveALLDataList[i].planItemId && saveALLDataList[i].planItemId == ids) {
                                                            index = i;
                                                        }
                                                        break;
                                                    }
                                                    if (index >= 0) {
                                                        saveALLDataList[index].planStartDate = value;
                                                        saveALLDataList[index].planContinuedDate = planPeriod;
                                                    } else {
                                                        if (taskType == 1) {
                                                            saveALLDataList.push({tgId: ids, planStartDate: value, planContinuedDate: planPeriod})
                                                        } else {
                                                            saveALLDataList.push({planItemId: ids, planStartDate: value, planContinuedDate: planPeriod})
                                                        }
                                                    }

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

                                            var tableDateEndEle = $(this).find('.table_date_end').get(0);
                                            var startdate = $(tableDateEndEle).attr('startdate') || '1900-01-01';
                                            var endDatePickConfig = {
                                                elem: tableDateEndEle,
                                                format: 'yyyy-MM-dd',
                                                btns: ['now', 'confirm'],
                                                min: startdate,
                                                done: function (value, date) {
                                                    var taskType = this.elem[0].getAttribute("taskType");
                                                    var ids = this.elem[0].getAttribute("ids");
                                                    
                                                    var $tr = $(tableDateEndEle).parents('tr').eq(0);
                                                    var planPeriod = timeRange($tr.find('.table_date_start').eq(0).val(), value) + '天';

                                                    var index = -1;
                                                    for (var i = 0; i < saveALLDataList.length; i++) {
                                                        if (saveALLDataList[i].tgId && saveALLDataList[i].tgId == ids) {
                                                            index = i;
                                                        } else if (saveALLDataList[i].planItemId && saveALLDataList[i].planItemId == ids) {
                                                            index = i;
                                                        }
                                                        break;
                                                    }
                                                    if (index >= 0) {
                                                        saveALLDataList[index].planEndDate = value;
                                                        saveALLDataList[index].planContinuedDate = planPeriod;
                                                    } else {
                                                        if (taskType == 1) {
                                                            saveALLDataList.push({tgId: ids, planEndDate: value, planContinuedDate: planPeriod});
                                                        } else {
                                                            saveALLDataList.push({planItemId: ids, planEndDate: value, planContinuedDate: planPeriod});
                                                        }
                                                    }
	                                                
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
                                        }
                                    });

                                    //判断是关键任务还是子任务
									if(planClass == 1){
										$('.tree_table thead th').eq(2).find('.ew-tree-table-cell-content').html('<span style="cursor: move;">中心责任部门责任人</span><span class="layui-table-sort layui-inline"><i class="layui-edge layui-table-sort-asc sort" title="升序"></i><i class="layui-edge layui-table-sort-desc sort" title="降序"></i></span>')
									}else if(planClass == 3){
										$('.tree_table thead th').eq(2).find('.ew-tree-table-cell-content').html('<span style="cursor: move;">责任人</span><span class="layui-table-sort layui-inline"><i class="layui-edge layui-table-sort-asc sort" title="升序"></i><i class="layui-edge layui-table-sort-desc sort" title="降序"></i></span>')
									}
									//给选中高亮
									if(colorChange_up){
										$('.layui-table-sort-asc').css('border-bottom-color','#666')
									}else if(colorChange_down){
										$('.layui-table-sort-desc').css('border-top-color','#666')
									}

								}
                            });
                        } else if (planClass == 2) {
							var url = '/plcPlan/selectByPlanIdAndPer'
							var whereData = {planId: planId, status: status,_:new Date().getTime()}
							var request = {
								pageName: 'page' //页码的参数名称，默认：page
								, limitName: 'limit' //每页数据量的参数名，默认：limit
							}
							var parseData = function (res) {
								if (status == 1) {
									if (res.totleNum != null) {
										// $("#unabsorbed").html("(" + res.totleNum + ")");
									}
								}
								return {
									"code": 0, //解析接口状态
									"data": res.object,//解析数据列表
									// "count": res.totleNum //解析数据长度
								}
							}
                            tableList = table.render({
                                elem: '#tableList',
                                url: url,
                                // page: true,
                                limit: 50,
	                            height: 'full-125',
                                width: '100%',
                                toolbar: toolBar,
                                defaultToolbar: [''],
                                where: whereData,
                                cols: cols,
								autoSort: false, //禁用前端自动排序。注意：该参数为 layui 2.4.4 新增
                                parseData: parseData,
                                request: request,
                                done: function () {
                                    //只在未分配显示该按钮
                                    if (status != 1) {
                                        $('#distributeOver').hide()
                                    }
                                    //责任人的选人控件
                                    $('.getusername').on("click",function () {
                                        user_id = $(this).children('.search').attr('id');
                                        $.popWindow("/projectTarget/selectOwnDeptUser?0");
                                    });
                                    var $parent = $(this.elem).parent();
                                    $parent.find('.layui-table-box .layui-table-body tr').find('.divShow').parent().css('height', 'auto');

                                    // 选择时间控件
                                    var $tableTrEles = $('#tableList').next().find('.layui-table-box .layui-table-main tr');

                                    $tableTrEles.each(function () {
                                        var tableDateStartEle = $(this).find('.table_date_start').get(0);
                                        if (tableDateStartEle) {
                                            var enddate = $(tableDateStartEle).attr('enddate') || '2099-12-31';
                                            var startDatePickConfig = {
                                                elem: tableDateStartEle,
                                                format: 'yyyy-MM-dd',
                                                btns: ['now', 'confirm'],
                                                max: enddate,
                                                done: function (value, date) {
                                                    var taskType = this.elem[0].getAttribute("taskType");
                                                    var ids = this.elem[0].getAttribute("ids");

                                                    var $tr = $(tableDateStartEle).parents('tr').eq(0);
                                                    var planPeriod = timeRange(value, $tr.find('.table_date_end').eq(0).val()) + '天';

                                                    var index = -1;
                                                    for (var i = 0; i < saveALLDataList.length; i++) {
                                                        if (saveALLDataList[i].tgId && saveALLDataList[i].tgId == ids) {
                                                            index = i;
                                                        } else if (saveALLDataList[i].planItemId && saveALLDataList[i].planItemId == ids) {
                                                            index = i;
                                                        }
                                                        break;
                                                    }
                                                    if (index >= 0) {
                                                        saveALLDataList[index].planStartDate = value;
                                                        saveALLDataList[index].planContinuedDate = planPeriod;
                                                    } else {
                                                        if (taskType == 1) {
                                                            saveALLDataList.push({tgId: ids, planStartDate: value, planContinuedDate: planPeriod})
                                                        } else {
                                                            saveALLDataList.push({planItemId: ids, planStartDate: value, planContinuedDate: planPeriod})
                                                        }
                                                    }

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

                                            var tableDateEndEle = $(this).find('.table_date_end').get(0);
                                            var startdate = $(tableDateEndEle).attr('startdate') || '1900-01-01';
                                            var endDatePickConfig = {
                                                elem: tableDateEndEle,
                                                format: 'yyyy-MM-dd',
                                                btns: ['now', 'confirm'],
                                                min: startdate,
                                                done: function (value, date) {
                                                    var taskType = this.elem[0].getAttribute("taskType");
                                                    var ids = this.elem[0].getAttribute("ids");

                                                    var $tr = $(tableDateEndEle).parents('tr').eq(0);
                                                    var planPeriod = timeRange($tr.find('.table_date_start').eq(0).val(), value) + '天';

                                                    var index = -1;
                                                    for (var i = 0; i < saveALLDataList.length; i++) {
                                                        if (saveALLDataList[i].tgId && saveALLDataList[i].tgId == ids) {
                                                            index = i;
                                                        } else if (saveALLDataList[i].planItemId && saveALLDataList[i].planItemId == ids) {
                                                            index = i;
                                                        }
                                                        break;
                                                    }
                                                    if (index >= 0) {
                                                        saveALLDataList[index].planEndDate = value;
                                                        saveALLDataList[index].planContinuedDate = planPeriod;
                                                    } else {
                                                        if (taskType == 1) {
                                                            saveALLDataList.push({tgId: ids, planEndDate: value, planContinuedDate: planPeriod})
                                                        } else {
                                                            saveALLDataList.push({planItemId: ids, planEndDate: value, planContinuedDate: planPeriod})
                                                        }
                                                    }

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
                                        }
                                    });
                                }
                            });
                        }else{
							tableList = table.render({
								elem: '#tableList',
								url: '/plcProjectItem/getAssist',
								page: true,
								limit: 50,
								height: 'full-125',
								width: '100%',
								toolbar: toolBar,
								defaultToolbar: [''],
								where: {flag: 1, status: status, useFlag: true,_:new Date().getTime()},
								cols: cols,
								autoSort: false, //禁用前端自动排序。注意：该参数为 layui 2.4.4 新增
								parseData: function (res) {
									if (status == 1) {
										if (res.totleNum != null) {
											// $("#unabsorbed").html("(" + res.totleNum + ")");
										}
									}
									return {
										"code": 0, //解析接口状态
										"data": res.object,//解析数据列表
										// "count": res.totleNum //解析数据长度
										"count": res.totleNum, //解析数据长度
									}
								},
								request: {
									pageName: 'page' //页码的参数名称，默认：page
									, limitName: 'pageSize' //每页数据量的参数名，默认：limit
								},
								done: function () {
									//只在未分配显示该按钮
									if (status != 1) {
										$('#distributeOver').hide()
									}
									//责任人的选人控件
									$('.getusername').on("click",function () {
										user_id = $(this).children('.search').attr('id');
										$.popWindow("/projectTarget/selectOwnDeptUser?0");
									});
									var $parent = $(this.elem).parent();
									$parent.find('.layui-table-box .layui-table-body tr').find('.divShow').parent().css('height', 'auto');

									//协助子任务中不显示指定责任人按钮
									$('#appointUser').hide()
								}
							});
						}
                    }
                }

                /**
                 * 加载关键任务、子任务列表中间方法 (设置定时器，防止暴力点击加载列表错误)
                 * @param status (1-未分配, 2-已分配, 3-未考核, 4-已考核)
                 * @param planId (计划上报id)
                 * @param planClass (计划上报类型 1-主项关键任务，2-职能关键任务，3-计划子任务)
                 * @param cols (列表显示的列)
                 * @param toolBar (列表头部对应的工具条)
                 * @param searchObj (查询条件对象)
                 */
                function initTableList(status, planId, planClass, cols, toolBar, searchObj) {
                    clearTimeout(tableTimer);
                    tableTimer = null;
                    tableTimer = setTimeout(function () {
                        initTargetOrTaskTable(status, planId, planClass, cols, toolBar, searchObj);
                    }, 300);
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
					if($('.tree_table').css('display')!='none'){
						initTreeTable.reload({
							where:{
								orderBy:orderBy //排序方式
							},
						})
					}
				})
				//监听排序事件
				table.on('sort(tableList)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
					// console.log(obj.type); //当前排序类型：desc（降序）、asc（升序）、null（空对象，默认排序）
					if(obj.type=='asc'){
						var orderBy=1
					}else{
						var orderBy=2
					}
					tableList.reload({
						where:{
							_: new Date().getTime(),
							orderBy:orderBy //排序方式
						}
					});
				});

                // 修改单个责任人的方法
                responsible = function () {

                    var planId = $('.select').attr('planId');
                    var status = $('.target_tabs').children('.layui-this').attr('opttype');
                    var tgEle = $('#' + user_id)[0].attributes.tgId;
                    var planItemEle = $('#' + user_id)[0].attributes.planItemId;
                    var assistIdEle = $('#' + user_id)[0].attributes.assistId;
                    var planClass = $('.select').attr('planClass');

                    var type = 1;
                    var data = {}

                    if (tgEle) {
                        type = 1;
                        data = {
							tgId: tgEle.value,
                            // ids: tgEle.value,
                            // userId: $('#' + user_id)[0].attributes.user_id.value
                            // dutyUser: $('#' + user_id)[0].attributes.user_id.value
                        }
                        //判断是哪个部门负责人
                        if ($('#' + user_id).attr('id').indexOf('Area') > 0) {
                            data.mainAreaUser = $('#' + user_id)[0].attributes.user_id.value
                        } else if ($('#' + user_id).attr('id').indexOf('Project') > 0) {
                            data.mainProjectUser = $('#' + user_id)[0].attributes.user_id.value
                        } else if ($('#' + user_id).attr('id').indexOf('Assist') > 0) {
                            data.assistUser = $('#' + user_id)[0].attributes.user_id.value
                        } else {
                            data.dutyUser = $('#' + user_id)[0].attributes.user_id.value
                        }
                    } else if (planItemEle) {
                        type = 2;
                        data = {
							planItemId: planItemEle.value,
                            // ids: planItemEle.value,
                            // dutyUser: $('#' + user_id)[0].attributes.user_id.value
                        }
                        //判断是子任务还是协助子任务
                        if ($('#' + user_id).attr('id').indexOf('Assist') > 0) {
                            data.assistUser = $('#' + user_id)[0].attributes.user_id.value
                        } else {
                            data.dutyUser = $('#' + user_id)[0].attributes.user_id.value
                        }
                    }else if(assistIdEle){
						type = 3;
						data = {
							assistId: assistIdEle.value,
						}
						//判断是子任务还是协助子任务
						if ($('#' + user_id).attr('id').indexOf('Assist') > 0) {
							data.assistUser = $('#' + user_id)[0].attributes.user_id.value ? $('#' + user_id)[0].attributes.user_id.value.replace(/,$/,'') : ''
						} else {
							data.dutyUser = $('#' + user_id)[0].attributes.user_id.value
						}
					}
					if (tgEle || planItemEle || assistIdEle) {
						var index = -1;
						for(var i=0;i<saveALLDataList.length;i++){
							if(saveALLDataList[i].tgId && saveALLDataList[i].tgId==data.tgId){
								index = i;
							}else if(saveALLDataList[i].planItemId && saveALLDataList[i].planItemId==data.planItemId){
								index = i;
							}else if(saveALLDataList[i].assistId && saveALLDataList[i].assistId==data.assistId){
								index = i;
							}
							break
						}
						if (index >= 0) {
							//判断是哪个部门负责人
							if ($('#' + user_id).attr('id').indexOf('Area') > 0) {
								saveALLDataList[index].mainAreaUser = $('#' + user_id)[0].attributes.user_id.value
							} else if ($('#' + user_id).attr('id').indexOf('Project') > 0) {
								saveALLDataList[index].mainProjectUser = $('#' + user_id)[0].attributes.user_id.value
							} else if ($('#' + user_id).attr('id').indexOf('Assist') > 0) {
								saveALLDataList[index].assistUser = $('#' + user_id)[0].attributes.user_id.value ? $('#' + user_id)[0].attributes.user_id.value.replace(/,$/,'') : ''
							} else {
								saveALLDataList[index].dutyUser = $('#' + user_id)[0].attributes.user_id.value
							}
						} else {
							saveALLDataList.push(data)
						}
						// console.log(saveALLDataList)
					}
                }

                //查看关键任务和填报详情
                $(document).on('click', '.target_detail', function () {
                    var tgId = $(this).attr('tgId')
	                var planClass = $(this).attr('planClass') || ''
                    $.ajax({
                        url: '/ProjectDaily/selectProjectDailyByItemId',
                        dataType: 'json',
                        type: 'get',
                        data: {tgId: tgId},
                        success: function (res) {
                            var data = res.data;
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
                                        dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">关键任务详情</h3><table class="layui-table">' +
                                            '<tbody>' +
                                            '<tr>' +
                                            '<td class="td_title">关键任务编号</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.tgNo) + '</td>' +
                                            '<td class="td_title">关键任务名称</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.tgName) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">关注等级</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['CONTROL_LEVEL']['object'][targetData.controlLevel]) + '</td>' +
                                            '<td class="td_title">周期类型</td>' +
                                            '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][targetData.planSycle]) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">关键任务类型</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['TG_TYPE']['object'][targetData.tgType]) + '</td>' +
                                            '<td class="td_title">计划阶段</td>' +
                                            '<td colspan="3">' + isShowNull(dictionaryObj['PLAN_PHASE']['object'][targetData.planStage]) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">设计量</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.designQuantity) + '</td>' +
                                            '<td class="td_title">工程量</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.itemQuantity) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">单位</td>' +
                                            '<td colspan="1">' + isShowNull(dictionaryObj['UNIT']['object'][targetData.itemQuantityNuit]) + '</td>' +
                                            '<td class="td_title">完成标准</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.resultStandard) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">负责人</td>' +
                                            '<td colspan="1">' + isShowNull(targetData.dutyUserName).replace(/,$/, '') + '</td>' +
                                            '<td class="td_title">中心责任部门</td>' +
                                            '<td colspan="3">' + isShowNull(targetData.mainCenterDeptName).replace(/,$/, '') + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
		                                        function () {
													if(planClass == 1) {
													    return '<tr>' +
				                                            '<td class="td_title">区域责任部门责任人\n</td>' +
				                                            '<td colspan="1">' + isShowNull(targetData.mainAreaUserName).replace(/,$/, '') + '</td>' +
				                                            '<td class="td_title">区域责任部门</td>' +
				                                            '<td colspan="3">' + isShowNull(targetData.mainAreaDeptName).replace(/,$/, '') + '</td>' +
				                                            '</tr>' +
						                                    '<tr>' +
				                                            '<td class="td_title">总承包部责任部门责任人</td>' +
				                                            '<td colspan="1">' + isShowNull(targetData.mainProjectUserName).replace(/,$/, '') + '</td>' +
				                                            '<td class="td_title">总承包部责任部门</td>' +
				                                            '<td colspan="3">' + isShowNull(targetData.mainProjectDeptName).replace(/,$/, '') + '</td>' +
				                                            '</tr>';
													} else {
													    return ''
													}
                                                }()+
                                            '<td class="td_title">计划开始时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.planStartDate) {
                                                    return format(targetData.planStartDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">计划结束时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.planEndDate) {
                                                    return format(targetData.planEndDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">计划工期</td>' +
                                            '<td>' + isShowNull(targetData.planContinuedDate) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">实际开始时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.realStartDate) {
                                                    return format(targetData.realStartDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">实际结束时间</td>' +
                                            '<td>' +
                                            function () {
                                                if (targetData.realEndDate) {
                                                    return format(targetData.realEndDate)
                                                } else {
                                                    return ''
                                                }
                                            }() +
                                            '</td>' +
                                            '<td class="td_title">实际工期</td>' +
                                            '<td>' + isShowNull(targetData.realContinuedDate) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">难度系数</td>' +
                                            '<td>' + isShowNull(targetData.hardDegree) + '</td>' +
                                            '<td class="td_title">风险点</td>' +
                                            '<td>' + isShowNull(targetData.riskPoint) + '</td>' +
                                            '<td class="td_title">难度点</td>' +
                                            '<td>' + isShowNull(targetData.difficultPoint) + '</td>' +
                                            '</tr>' +
		                                    '<tr>' +
	                                        '<td class="td_title">成果标准模板</td>' +
	                                        '<td colspan="5">' +
		                                        function(){
	                                                var resultDictName = '';
			                                        if (!!targetData.resultDict) {
			                                            var resultDictList = targetData.resultDict.split(',');
			                                            
			                                            resultDictList.forEach(function (item) {
			                                                resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
			                                            });
			                                        }
			                                        
			                                        return resultDictName.replace(/,$/, '');
	                                            }()+
	                                        '</td>' +
	                                        '</tr>'+
                                            '<tr>' +
                                            '<td class="td_title">需提交的成果材料</td>' +
                                            '<td colspan="5">' +
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
                                            '<td colspan="5">' + isShowNull(targetData.unusualRes) + '</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                            '<td class="td_title">异常原因材料</td>' +
                                            '<td colspan="5">' +
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
												'<td colspan="5">' +
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
                                    // dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">关键任务填报信息</h3>';
                                    // for (var i = 0; i < data.length; i++) {
                                    //     dayReport += '<table class="layui-table" style="margin-bottom: 5px">\n' +
                                    //         '  <tbody>\n' +
                                    //         '    <tr>\n' +
                                    //         '      <td class="td_title">每日填报人</td>\n' +
                                    //         '      <td>' + empty(data[i].ctreateUserName) + '</td>\n' +
                                    //         '      <td class="td_title">时间</td>\n' +
                                    //         '      <td>' + empty(data[i].ctreateTime) + '</td>\n' +
                                    //         '    </tr>\n' +
                                    //         '    <tr>\n' +
                                    //         '      <td class="td_title">增加协作人</td>\n' +
                                    //         '      <td>' + empty(data[i].assistUserName) + '</td>\n' +
                                    //         '      <td class="td_title">当日完成量</td>\n' +
                                    //         '      <td>' + function () {
                                    //             if (data[i].assistUserName || data[i].transfer) {
                                    //                 return '—'
                                    //             } else {
                                    //                 return data[i].tadayProgress + '%'
                                    //             }
                                    //         }() + '</td>\n' +
                                    //         '    </tr>\n' +
                                    //         '    <tr>\n' +
                                    //         '      <td class="td_title">转办</td>\n' +
                                    //         '      <td colspan="3">' + empty(data[i].transfer) + '</td>\n' +
                                    //         '    </tr>\n' +
                                    //         '    <tr>\n' +
                                    //         '      <td class="td_title">进展日志</td>\n' +
                                    //         '      <td colspan="3">' + empty(data[i].tadayDesc) + '</td>\n' +
                                    //         '    </tr>\n' +
                                    //         '  </tbody>\n' +
                                    //         '</table>'
                                    // }
                                    $('#target_detail').append(dayReport)
                                }
                            })
                        }
                    })
                });
                //查看子任务和填报详情
                $(document).on('click', '.task_detail', function () {
                    var planItemId = $(this).attr('planItemId')
					$.ajax({
						url: '/ProjectDaily/selectProjectDailyByItemId',
						dataType: 'json',
						type: 'get',
						data: {planItemId: planItemId},
						success: function (res) {
							var taskData = res.object;
							var data = res.data

							layer.open({
								type: 1,
								title: '子任务和填报详情',
								area: ['70%', '90%'],
								maxmin: true,
								min: function () {
									$('.layui-layer-shade').hide()
								},
								content: '<div id="task_detail" style="margin:10px"></div>',
								success: function () {
									var dayReport = '';

									if (!!taskData) {
										dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;">子任务详情</h3><table class="layui-table">\n' +
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
														return '';
													}
												}() + '</td>\n' +
												'    </tr>\n' +
												'    <tr>\n' +
												'      <td class="td_title">周期类型</td>\n' +
												'      <td colspan="1">' + isShowNull(dictionaryObj['PLAN_SYCLE']['object'][taskData.planSycle]) + '</td>\n' +
												'      <td class="td_title">子任务类型</td>\n' +
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
												'<tr>' +
												'<td class="td_title">成果标准模板</td>' +
												'<td colspan="5">' +
												function () {
													var resultDictName = '';
													if (!!taskData.resultDict) {
														var resultDictList = taskData.resultDict.split(',');

														resultDictList.forEach(function (item) {
															resultDictName += (!!dictionaryObj['CGCL_TYPE']['object'][item] ? dictionaryObj['CGCL_TYPE']['object'][item] + ',' : '');
														});
													}

													return resultDictName.replace(/,$/, '');
												}() +
												'</td>' +
												'</tr>' +
												'    <tr>\n' +
												'      <td class="td_title">需提交的成果材料</td>\n' +
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
												}() + '</td>\n' +
												'    </tr>\n' +
												'    </tr>\n' +
												'  </tbody>\n' +
												'</table>';

										if (taskData.plcAssistList.length > 0) {
											dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">协助子任务信息</h3>';
											taskData.plcAssistList.forEach(function (obj) {
												dayReport += '<table class="layui-table" style="margin-bottom: 5px;">\n' +
														'  <tbody>\n' +
														'    <tr>\n' +
														'      <td class="td_title">协助人</td>\n' +
														'      <td colspan="1">' + isShowNull(obj.assistUserName) + '</td>\n' +
														'      <td class="td_title">协助部门</td>\n' +
														'      <td colspan="3">' + isShowNull(obj.assistDeptName) + '</td>\n' +
														'    </tr>\n' +
														'    <tr>\n' +
														'      <td class="td_title">完成状态</td>\n' +
														'      <td colspan="1">' + isShowNull(obj.taskStatus) + '</td>\n' +
														'      <td class="td_title">任务进度</td>\n' +
														'      <td colspan="3">' + isShowNull(obj.taskPrecess) + '</td>\n' +
														'    </tr>\n' +
														'    <tr>\n' +
														'      <td class="td_title">计划开始时间</td>\n' +
														'      <td colspan="1">' + format(obj.planStartDate) + '</td>\n' +
														'<td class="td_title">计划完成时间</td>\n' +
														'      <td colspan="3">' + format(obj.planEndDate) + '</td>\n' +
														'    </tr>\n' +
														'    <tr>\n' +
														'      <td class="td_title">实际完成时间</td>\n' +
														'      <td colspan="3">' + format(obj.realEndDate) + '</td>\n' +
														'    </tr>\n' +
														'    <tr>\n' +
														'      <td class="td_title">最终成果材料</td>\n' +
														'      <td colspan="5">' + function () {
															if (!!obj.attachments1 && obj.attachments1.length > 0) {
																var str = '';

																obj.attachments1.forEach(function (item) {
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
														'      <td class="td_title">异常原因</td>\n' +
														'      <td colspan="3">' + isShowNull(obj.unusualStuff) + '</td>\n' +
														'    </tr>\n' +
														'    <tr>\n' +
														'      <td class="td_title">异常支撑材料</td>\n' +
														'      <td colspan="5">' + function () {
															if (!!obj.attachments2 && obj.attachments2.length > 0) {
																var str = '';

																obj.attachments2.forEach(function (item) {
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
														'  </tbody>\n' +
														'</table>'
											})
										}
									}

									dayReport += '<h3 style="line-height: 30px;font-size: 20px;text-align: center;margin-top: 10px;">子任务填报信息</h3>';
									for (var i = 0; i < data.length; i++) {
										dayReport += '<table class="layui-table" style="margin-bottom: 5px;">\n' +
												'  <tbody>\n' +
												'    <tr>\n' +
												'      <td class="td_title">每日填报人</td>\n' +
												'      <td>' + isShowNull(data[i].ctreateUserName) + '</td>\n' +
												'      <td class="td_title">时间</td>\n' +
												'      <td>' + isShowNull(data[i].ctreateTime) + '</td>\n' +
												'    </tr>\n' +
												'    <tr>\n' +
												'      <td class="td_title">增加协作人</td>\n' +
												'      <td>' + isShowNull(data[i].assistUserName) + '</td>\n' +
												'      <td class="td_title">当日完成量</td>\n' +
												'      <td>' + function () {
													if (data[i].assistUserName || data[i].transfer) {
														return '—'
													} else {
														return data[i].tadayProgress + '%'
													}
												}() + '</td>\n' +
												'    </tr>\n' +
												'    <tr>\n' +
												'      <td class="td_title">转办</td>\n' +
												'      <td colspan="3">' + isShowNull(data[i].transfer) + '</td>\n' +
												'    </tr>\n' +
												'    <tr>\n' +
												'      <td class="td_title">进展日志</td>\n' +
												'      <td colspan="3">' + isShowNull(data[i].tadayDesc) + '</td>\n' +
												'    </tr>\n' +
												'  </tbody>\n' +
												'</table>'
									}
									$('#task_detail').append(dayReport)
								}
							})
						}
					})
                });
                
                /**
                 * 获取查询项目的数据
                 * @param status (1-未分配，2-已分配)
                 * @param fn (回调函数)
                 */
                function getProjectInfo(status, fn){
                    var searchObj = {}
                    if (status) {
                        searchObj.status = status;
                    }
                    $.get('/plcPlan/getProjectInfos', searchObj, function (res) {

                        var str = '<option value="">请选择</option>';
                        
                        if (res.flag && res.object.length > 0) {
                            res.object.forEach(function (item) {
                                str += '<option value="' + item.belongtoProj + '">' + item.projectName + '</option>';
                            });
                        }
                        
                        $('[name="belongtoProj"]').html(str);
                        
                        form.render('select');
                        
                        if (fn) {
                            fn(res);
                        }
                    });
                }
            });

            /**
             * 获取年度对应月度信息
             * @param year (所属年)
             * @param fn (回调函数)
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
             * 将毫秒数转为yyyy-MM-dd格式时间
             * @param t (时间戳)
             * @returns {string}
             */
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy-MM-dd");
                } else {
                    return '';
                }
            }

            /**
             * 编辑单元格保存方法
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
                } else {
                    url = '/PlcAssessScore/updateStatus'
                }

                $.post(url, data, function (res) {
                    if (fn) {
                        fn(res);
                    }
                });
            }

			/**
			 * 关闭计划方法
			 * @param data (请求参数对象)
			 * @param fn (回调函数)
			 */
			function closeTaskOrTarget(data, fn) {
				$.post('/projectTarget/updateTarItemEnd', data, function (res) {
					if (fn) {
						fn(res);
					}
				});
			}
			/**
			 * 整体保存方法
			 * @param type (1-关键任务，2-子任务,3-协助子任务（单独一张表）)
			 * @param data (请求参数对象)
			 * @param fn (回调函数)
			 */
			function saveTaskOrTarget(type, data, fn) {
				var url = '';
				if (type == 1) {
					url = '/projectTarget/updateList';
				} else if (type == 2) {
					url = '/plcProjectItem/updateList';
				}else{
					url = '/plcAssist/updateList';
				}
				$.ajax({
					url:url,
					data:JSON.stringify(data),
					contentType:"application/json;charset=UTF-8",
					dataType:'json',
					type:'post',
					success:function(res){
						if (fn) {
							fn(res);
						}
					}
				})
			}

            //监听键盘事件，只能输入数字
            $(document).on('keypress', '.number_input', function (e) {
                var key = window.event ? e.keyCode : e.which;

                if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                    return false;
                }
            });
            // 监听输入内容
            $(document).on('input propertychange', '.number_input', function (event) {
                var value = parseInt($(this).val());
                // 判断是否为难度系数
                var eleClass = $(this).hasClass('hard_degree');
                if (isNaN(value)) {
                    $(this).val('');
                } else {
                    // 难度系数最大值为10
                    if (eleClass) {
                        value = value > 10 ? 10 : value;
                    } else { // 进度、质量得分最大值为100
                        value = value > 100 ? 100 : value;
                    }
                    $(this).val(value);
                }
            });

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

            //判断返回是否为空
            function empty(esName) {
                if (esName != undefined) {
                    return esName
                } else {
                    return ''
                }
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

            function resizeSize() {
                var height = $(window).height();
                $('#leftHeight').height(height - 125);
                
                // 重置查询区域布局
                var queryWidth = $('.query ').width();
                $('.query_item').width((queryWidth - 20) / 4);
            }

			//获取顶部切换栏数量和左侧数量显示
			function tabNum() {
				var status = $('.target_tabs').children('.layui-this').attr('opttype');
				if(status==1){
					$.get('/plcPlan/getAllSize', {status: 1,page:1,pageSize:50,useFlag: false,taskApproval:2}, function (res) {
						$('.weiNum').text('('+(parseInt(res[1] || 0)+parseInt(res[2] || 0)+parseInt(res[3] || 0))+')')
						if($('.target_tabs').children('.layui-this').attr('opttype')==1){
							$('#targetNum').text('('+(res[1] || 0)+')')
							$('#taskNum').text('('+(res[2] || 0)+')')
							$('#assistNum').text('('+(res[3] || 0)+')')
						}else{
							$('#targetNum').text('')
							$('#taskNum').text('')
							$('#assistNum').text('')
						}
					});
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
		
		</script>
	</body>
</html>