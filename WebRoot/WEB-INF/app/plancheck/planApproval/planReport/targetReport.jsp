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
		<title>关键任务上报</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css">
		
<%--		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
		<script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--		<script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
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
			
			.query {
				margin-top: 20px;
			}
			
			.titleSp {
				padding-left: 10px;
				font-size: 18px;
			}
			
			.query input, select {
				height: 30px;
			}
			
			.ew-tree-table-tool-right {
				display: none;
			}
			
			.project .layui-table-tool-temp {
				padding: 0;
			}
			
			.project .layui-table-tool-self .layui-inline{
				margin-top: -3px;
			}
		</style>
	
	</head>
	<body>
		<div class="container">
			<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
				<ul class="layui-tab-title">
					<li class="layui-this">未上报计划(<span class="reported">5</span>)</li>
					<li>已上报计划</li>
				</ul>
				<div class="layui-tab-content" style="padding: 0px 8px">
					<div class="layui-tab-item layui-show">
						<form class="layui-form query" style="display: flex">
							<div class="layui-form-item">
								<label class="layui-form-label" style="margin-top: -5px">所属单位:</label>
								<div class="layui-input-block">
									<select name="ownerUnit" class="deptName" lay-verify="required">
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="layui-form-item inputs">
								<label class="layui-form-label" style="margin-top: -5px">计划类型:</label>
								<div class="layui-input-block">
									<select name="planType" class="planType" lay-verify="required">
										<option value="">请选择</option>
									</select>
								</div>
							
							</div>
							<div class="layui-form-item inputs">
								<label class="layui-form-label"
								       style="margin-top: -5px; width: 50px;">年度:</label>
								<div class="layui-input-block" style=" margin-left: 85px;">
									<input type="text" id="year" name="title" required lay-verify="required"
									       autocomplete="off" class="layui-input">
								</div>
							</div>
							<div class="layui-form-item inputs">
								<label class="layui-form-label"
								       style="margin-top: -5px; width: 50px;">月度:</label>
								<div class="layui-input-block" style=" margin-left: 85px;">
									<input type="text" id="month" name="title" required lay-verify="required"
									       autocomplete="off" class="layui-input">
								</div>
							</div>
							<button type="button" class="layui-btn layui-btn-sm search"
							        style="margin-left: 2%; width: 55px;">查询
							</button>
							<button type="button" class="layui-btn layui-btn-sm clear"
							        style="margin-left: 20px;width: 55px;">重置
							</button>
							<button type="button" class="layui-btn layui-btn-sm" style="margin-left: 20px">
								<i class="layui-icon layui-icon-spread-left icon"></i>
							</button>
						</form>
						<div class="project">
							<table id="parentTable" lay-filter="parentTable"></table>
						</div>
						<div style="display: none" class="theChildPlan">
							<table id="theChildPlan" lay-filter="theChildPlan"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="barDemo">
			<div class="clearfix">
				<a class="layui-btn layui-btn-sm rep" lay-event="rep" style="float: right; margin-right: 45px;">上报</a>
			</div>
		</script>
		
		<script type="text/html" id="childDemo">
			<div>
				<span><i class="layui-icon layui-icon-next" style="color: green"></i><span
						class="titleSp"></span></span>
				<a class="layui-btn layui-btn-sm" lay-event="del" style="float: right;margin-left: 10px;">删除</a>
				<a class="layui-btn layui-btn-sm" lay-event="edit" style="float: right">编辑</a>
				<a class="layui-btn layui-btn-sm" lay-event="rep" style="float: right">上报</a>
			</div>
		</script>
		
		<script type="text/javascript">

            layui.use(['treeTable', 'table', 'layer', 'form', 'element', 'laydate', 'upload',], function () {
                var table = layui.table,
                    form = layui.form,
                    layer = layui.layer,
                    laydate = layui.laydate,
                    upload = layui.upload,
                    treeTable = layui.treeTable,
                    element = layui.element;
                layui.form.render();
                //年范围
                laydate.render({
                    elem: '#year'
                    , type: 'year'
                });

                //年月范围
                laydate.render({
                    elem: '#month'
                    , type: 'month'
                });
                
                // 所属单位的ajax
                $.ajax({
                    url: '/department/getDeptTop',
                    dataType: 'json',
                    type: 'get',
                    success: function (res) {
                        var obj = res.obj
                        var str = ''
                        for (var i = 0; i < obj.length; i++) {
                            str += '<option value="' + obj[i].deptName + '">' + obj[i].deptName + '</option>'
                        }
                        $('.deptName').append(str);
                        form.render('select');
                    }
                });
                
                // 计划类型的ajax
                $.ajax({
                    url: '/Dictonary/selectDictionaryByNo?dictNo=PLAN_TYPE',
                    dataType: 'json',
                    type: 'get',
                    success: function (res) {
                        var obj = res.data
                        var str = ''
                        for (var i = 0; i < obj.length; i++) {
                            str += '<option value="' + obj[i].dictId + '">' + obj[i].dictName + '</option>'
                        }
                        $('[name="planType"]').append(str)
                        form.render('select');
                    }
                });
                 
                // 上报、未上报导航切换
                element.on('tab(docDemoTabBrief)', function (elem) {
                    switch (elem.index) {
						case 0: // 未上报计划
						    $('.rep').text('上报');
						    break;
	                    case 1: // 已上报计划
	                        $('.rep').text('计划调整');
	                        break;
                    }
                });
                
                //父表
                var projectTable = null;
                
                initParentTable(0);

                // 加载父数据
                function initParentTable(type) {
                    projectTable = table.render({
                        elem: '#parentTable',
                        url: '/ProjectInfo/selectPro', //数据接口
                        page: true, //开启分页
                        toolbar: '#barDemo',
                        defaultToolbar: ['filter'],
                        cols: [[ //表头
                            {type: 'checkbox'}
                            , {
                                field: 'projectName',
                                title: '名称',
                                align: 'center',
                                event: 'detail',
                                width: 500,
                                style: 'cursor: pointer;'
                                , templet: function (d) {
                                    return '<a class="nameClick" projectId=' + d.projectId + ' style="color: blue;text-decoration: underline;">' + d.projectName + '</a>'
                                }
                            }
                            , {field: 'projectTypeName', title: '类型'}
                            , {field: 'planSycle', title: '周期类型'}
                            , {field: 'ownerUnit', title: '所属单位'}
                            , {
                                field: 'statrtTime', title: '年度', templet: function (d) {
                                    if (d.statrtTime != '' && d.statrtTime != undefined) {
                                        var time = d.statrtTime.split("-")[0]
                                        return time
                                    } else {
                                        return ''
                                    }
                                }
                            }
                            , {
                                field: 'statrtTime', title: '月度', templet: function (d) {
                                    if (d.statrtTime != '' && d.statrtTime != undefined) {
                                        var time = d.statrtTime.split("-")[1]
                                        return time
                                    } else {
                                        return ''
                                    }
                                }
                            }
                            , {field: 'projectStatus', title: '当前审批环节'}
                        ]],
                        where: {
                            targetApprivalStatus: type,
	                        _: new Date().getTime()
                        }
                    });
                }

                //子表
                function initTaskTable(projectId) {
                    treeTable.render({
                        elem: '#theChildPlan'
                        , url: '/plcProjectBag/queryBagTarget'
                        , where: {
                            parentPbagId: 0,
                            projectId: 58
                        }
                        , page: true //开启分页
                        , toolbar: '#childDemo'
                        , defaultToolbar: ['']
                        , tree: {
                            iconIndex: 3,
                            isPidData: true,
                            idName: 'id',
                            childName: 'children'
                        }
                        , cols: [[
                            {type: 'checkbox'},
                            {type: 'numbers', title: '序号', width: 70},
                            {field: 'tgNo', title: '编码'},
                            {
                                field: 'tgName', title: '关键任务/子任务名称', width: 400, templet: function (d) {
                                    if (d.tgId == '' || d.tgId == undefined) {
                                        return '<span class="pbagName" id="' + d.id + '">' + d.pbagName + '</span>'
                                    } else {
                                        return '<span class="pbagName" id="' + d.id + '"><a>【关键任务】</a>' + d.tgName + '</span>'
                                    }
                                }
                            }
                            , {field: 'dutyUser', title: '完成量'}
                            , {field: 'dutyDeptName', title: '单位'}
                            , {field: 'controlLevel', title: '关注等级'}
                            , {field: 'pbagTarget', title: '前置子任务'}
                            , {
                                field: 'planBeginDate', title: '计划开始时间', templet: function (d) {
                                    return format(d.planBeginDate)
                                }
                            }, {
                                field: 'planEndDate', title: '计划结束时间', templet: function (d) {
                                    return format(d.planEndDate)
                                }
                            }, {field: 'planPeriod', title: '计划工期'}
                            , {field: 'resultStandard', title: '完成标准', edit: 'text'}

                        ]], parseData: function (res) { //res 即为原始返回的数据
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj //解析数据列表
                            };
                        },
                    });
                }

                table.on('toolbar(theChildPlan)', function (obj) {
                    var checkStatus = table.checkStatus(obj.config.id);
                    if (checkStatus.data.length == 0) {
                        layer.msg('最少选中一项!');
                        return false;
                    }
                    switch (obj.event) {
                        case 'del':
                            var projectId = []
                            checkStatus.data.forEach(function (v, i) {
                                projectId.push(v.projectId)
                            })
                            layer.confirm('确定删除该条数据吗？', function (index) {
                                $.ajax({
                                    url: '/ProjectInfo/delProjectInfo',
                                    dataType: 'json',
                                    type: 'post',
                                    data: {projectId: projectId},
                                    traditional: true,
                                    success: function (res) {
                                        if (res.flag) {
                                            layer.msg('删除成功！', {icon: 1});
                                        } else {
                                            layer.msg('删除失败！', {icon: 0});
                                        }
                                        layer.close(index)
                                        tableIns.reload()
                                    }
                                })
                            });
                            break;
                        case 'edit':
                            $.get('/ProjectInfo/selectProjectInfoById', {projectId: projectId}, function (res) {
                                var datas = res.obj
                                layer.open({
                                    type: 1,
                                    title: '项目详情',
                                    area: ['100%', '100%'],
                                    maxmin: true,
                                    min: function () {
                                        $('.layui-layer-shade').hide()
                                    },
                                    content: '<div style="padding: 0px 10px"><table class="layui-table" style="margin: 8px 0px;">\n' +
                                        '<colgroup>\n' +
                                        '    <col width="10%">\n' +
                                        '    <col width="40%">\n' +
                                        '    <col width="10%">\n' +
                                        '    <col width="40%">\n' +
                                        '  </colgroup>' +
                                        '  <tbody>\n' +
                                        '    <tr>\n' +
                                        '      <td>项目编号</td>\n' +
                                        '      <td>' + isUndefined(datas.projectNo) + '</td>\n' +
                                        '      <td>项目名称</td>\n' +
                                        '      <td>' + isUndefined(datas.projectName) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>项目类型</td>\n' +
                                        // '      <td>'+isUndefined(datas.projectType)+'</td>\n' +
                                        '      <td>' + function () {
                                            if (datas.projectType) {
                                                for (var i = 0; i < projectType.length; i++) {
                                                    if (projectType[i].dictNo == datas.projectType) {
                                                        return projectType[i].dictName
                                                    }
                                                }
                                            } else {
                                                return ''
                                            }

                                        }() + '</td>\n' +
                                        '      <td>项目简称</td>\n' +
                                        '      <td>' + isUndefined(datas.projectAbbreviation) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>是否是公司重点</td>\n' +
                                        '      <td>' + function () {
                                            if (datas.importantYn == 0) {
                                                return '否'
                                            } else if (datas.importantYn == 1) {
                                                return '是'
                                            } else {
                                                return ''
                                            }
                                        }() + '</td>\n' +
                                        '      <td>项目编码</td>\n' +
                                        '      <td>' + isUndefined(datas.projectCode) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>项目地点</td>\n' +
                                        '      <td>' + isUndefined(datas.projectPlace) + '</td>\n' +
                                        '      <td>所属区域</td>\n' +
                                        '      <td>' + isUndefined(datas.respectiveRegionName) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>业主单位</td>\n' +
                                        '      <td>' + isUndefined(datas.ownerUnit) + '</td>\n' +
                                        '      <td>业主联系人</td>\n' +
                                        '      <td>' + isUndefined(datas.ownerName) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>业主联系电话</td>\n' +
                                        '      <td>' + isUndefined(datas.ownerPhone) + '</td>\n' +
                                        '      <td>监理单位</td>\n' +
                                        '      <td>' + isUndefined(datas.manageUnit) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>监理联系人</td>\n' +
                                        '      <td>' + isUndefined(datas.manageName) + '</td>\n' +
                                        '      <td>监理联系电话</td>\n' +
                                        '      <td>' + isUndefined(datas.managePhone) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>合同总金额</td>\n' +
                                        '      <td>' + isUndefined(datas.contractMoney) + '</td>\n' +
                                        '      <td>合同总工期</td>\n' +
                                        '      <td>' + isUndefined(datas.contractDuration) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>计划开始时间</td>\n' +
                                        '      <td>' + isUndefined(datas.statrtTime) + '</td>\n' +
                                        '      <td>计划结束时间</td>\n' +
                                        '      <td>' + isUndefined(datas.endTime) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>项目经理</td>\n' +
                                        '      <td>' + isUndefined(datas.projectManage) + '</td>\n' +
                                        '      <td>项目经理联系电话</td>\n' +
                                        '      <td>' + isUndefined(datas.projectManagePhone) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>项目总工</td>\n' +
                                        '      <td>' + isUndefined(datas.projectChief) + '</td>\n' +
                                        '      <td>项目总工电话</td>\n' +
                                        '      <td>' + isUndefined(datas.projectChiefPhone) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>中标日期</td>\n' +
                                        '      <td>' + isUndefined(datas.winningDate) + '</td>\n' +
                                        '      <td>编制人</td>\n' +
                                        '      <td>' + isUndefined(datas.createUserName) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>计划模板</td>\n' +
                                        '      <td>' + isUndefined(datas.mainPlanTpl) + '</td>\n' +
                                        '      <td>所属上级机构</td>\n' +
                                        '      <td>' + isUndefined(datas.belongDept) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>验收标准</td>\n' +
                                        '      <td>' + isUndefined(datas.acceptStandard) + '</td>\n' +
                                        '      <td>总承包部</td>\n' +
                                        '      <td>' + isUndefined(datas.contractDept) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>施工内容</td>\n' +
                                        '      <td>' + isUndefined(datas.workContent) + '</td>\n' +
                                        '      <td>分解次数</td>\n' +
                                        '      <td>' + isUndefined(datas.breakTimes) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>实际开始时间</td>\n' +
                                        '      <td>' + isUndefined(datas.realBeginDate) + '</td>\n' +
                                        '      <td>实际完工时间</td>\n' +
                                        '      <td>' + isUndefined(datas.realEndDate) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>项目进展</td>\n' +
                                        '      <td>' + function () {
                                            if (datas.projectStatus == 0) {
                                                return '在建'
                                            } else if (datas.projectStatus == 1) {
                                                return '收尾'
                                            } else if (datas.projectStatus == 2) {
                                                return '竣工'
                                            } else if (datas.projectStatus == 3) {
                                                return '关闭'
                                            } else {
                                                return ''
                                            }
                                        }() + '</td>\n' +
                                        '      <td>项目概述</td>\n' +
                                        '      <td>' + isUndefined(datas.projectDesc) + '</td>\n' +
                                        '    </tr>\n' +
                                        '    <tr>\n' +
                                        '      <td>附件</td>\n' +
                                        '      <td colspan="3">' + function () {
                                            var strs1 = '';
                                            for (var i = 0; i < datas.attachmentList.length; i++) {
                                                strs1 += '<div class="dech" deUrl="' + encodeURI(datas.attachmentList[i].attUrl) + '"><a href="/download?' + encodeURI(datas.attachmentList[i].attUrl) + '" NAME="' + datas.attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + datas.attachmentList[i].attachName + '</a><input type="hidden" class="inHidden" value="' + datas.attachmentList[i].aid + '@' + datas.attachmentList[i].ym + '_' + datas.attachmentList[i].attachId + ',"></div>';
                                            }
                                            return strs1
                                        }() + '</td>\n' +
                                        '    </tr>\n' +
                                        '  </tbody>\n' +
                                        '</table></div>',
                                })
                            })
                            break;
                        case 'rep':
                            alert('上报')
                            break;
                    }
                });
                
                table.on('toolbar(parentTable)', function (obj) {
                    var checkStatus = table.checkStatus(obj.config.id);
                    switch (obj.event) {
                        case 'rep':
                            if (checkStatus.data.length == 0) {
                                layer.msg('最少选中一项!', {icon: 0, time: 1000});
                                return false;
                            }
                            var ids = '';
                            checkStatus.data.forEach(function(item){
                                ids += item.projectId + ',';
                            });
                            
                            $.post('/ProjectInfo/updateStatusByIds', {pInfoIds: ids, targetApprivalStatus: 1}, function(res){
                                if (res.flag) {
                                    layer.msg('上报成功', {icon: 1, time: 1000});
                                    projectTable.config.where._ = new Date().getTime();
	                                projectTable.reload();
                                } else {
                                    layer.msg('上报失败', {icon: 2, time: 1000});
                                }
                            });
                            break;
                    }
                });
                
                $('.clear').on('click',function () {
                    $('input').val('');
                    $('select').val('');
                    form.render();
                });
                
                //父表-项目名称点击事件
                $(document).on('click', '.nameClick', function () {
                    var projectId = $(this).attr('projectId')
                    initTaskTable(projectId)
                    $('.titleSp').text($(this).text())
                    $('.theChildPlan').show();
                    $('.project').hide();
                });
                
                //子表-表标点击事件
                $(document).on('click', '.titleSp', function () {
                    $('.theChildPlan').hide();
                    $('.project').show();
                });
                
                //条件查询
                $('.search').on('click',function () {
                    projectTable.reload({
                        url: '/ProjectInfo/selectPro',
                        where: {
                            projectName: $('.tgName').val(),
                            mainCenterDept: $('.deptName').val(),
                            year: $('#date').val(),
                            month: $('#month').val(),
                            planType: $('.planType').val()
                        }
                    });
                });

                //将毫秒数转为yyyy-MM-dd格式时间
                function format(t) {
                    if (t) return new Date(t).Format("yyyy-MM-dd");
                    else return ''
                }
            })
		
		</script>
	</body>
</html>
