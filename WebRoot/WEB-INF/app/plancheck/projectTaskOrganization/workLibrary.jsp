<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-06-17
  Time: 12:00
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
<!DOCTYPE html >
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>工作项库</title>
	<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
	<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
	<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
	<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
	    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
	<script type="text/javascript" src="/js/common/fileupload.js"></script>
<%--	<script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
	<script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>

	<style>
		html, body {
			background: #fff;
		}

		* {
			margin: 0px;
			padding: 0px;
		}

		.layui-layer-btn .layui-layer-btn0 {
			background-color: #009688;
			margin-top: 80px;
		}

		.layui-layer-btn .layui-layer-btn1 {
			background-color: #009688;
			color: white;
			margin-top: 80px;
			margin-left: 30px;
		}

		.layui-layer-btn a {
			height: 28px;
			line-height: 28px;
			margin: 5px 5px 0;
			padding: 0 15px;
			border: 1px solid #dedede;
			background-color: #fff;
			color: #333;
			border-radius: 2px;
			font-weight: 400;
			cursor: pointer;
			text-decoration: none;
		}

		.layui-form-item {
			width: 100%;
			margin-bottom: 8px;
		}

		/* .newAndEdit{
			 display: flex;
		 }*/
		.layui-layer-btn {
			text-align: center;
			margin-top: -40px;
			/*position: relative;*/
		}

		.layui-btn-container {
			position: relative;
		}

		.query .layui-form-label {
			width: 85px;
			padding: 9px 3px;
		}

		.query .layui-input-inline {
			margin-left: -15px;
		}

		.inputs .layui-form-select .layui-input {
			height: 35px !important;
			/*width: 50%;*/
		}

		.layui-table, .layui-table-view {
			margin: 0 0;
		}

		.query_form {
			padding: 10px 0;
			margin: 0;
		}

		.query_form .layui-form-item {
			clear: none;
			margin-bottom: 0px;
		}

		.layui-table-tool {
			min-height: 38px;
		}

		.layui-table tr {
			height: 38px;
		}

		.layui-input-block {
			margin-left: 125px;
		}

		.query .layui-input-block {
			margin-left: 95px;
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
	<div>
		<%--<div class="headImg" style="margin-top: 10px">
			<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img style="margin-left:1.5%"
			                                                                                 src="../img/commonTheme/theme6/icon_summary.png" alt=""><span
					class="headTitle" style="margin-left: 10px">工作项库</span></span>
		</div>
		<hr style="margin-bottom: 0;">--%>
		<%--tab切换子任务和关键任务--%>
		<div class="layui-tab layui-tab-brief" style="margin-top: 0;" lay-filter="docDemoTabBrief">
			<ul class="layui-tab-title">
				<li class="layui-this">关键任务</li>
				<li>子任务</li>
			</ul>
			<div class="layui-tab-content">
<%--				<form class="layui-form query_form" lay-filter="queryForm" action="">--%>
					<div class="query layui-form ">
						<div class="layui-row">
							<div class="layui-col-xs2" style="width: 15%">
								<div class="layui-form-item">
									<label class="layui-form-label" style="margin-left: -14px;">工作项名称</label>
									<div class="layui-input-block" style="margin-left: 81px;">
										<input style="height: 35px" type="text" id="tgNames" name="tgNames" required lay-verify="required" autocomplete="off"
										       class="layui-input">
									</div>
								</div>
							</div>
							<div class="layui-col-xs2" id="targetLevel" style="width: 15%">
								<div class="layui-form-item inputs">
									<label class="layui-form-label" style="width: 70px">关注等级</label>
									<div class="layui-input-block" style="margin-left: 76px">
										<select name="attionLevel" id="attionLevels" class="attionLevel" lay-verify="required">
											<option value="">请选择</option>
										</select>
									</div>
								</div>
							</div>
							<div class="layui-col-xs2" id="oneDept" style="width: 23%">
								<div class="layui-form-item">
									<label class="layui-form-label">中心责任部门</label>
									<div class="layui-input-block">
										<%--                                    <input style="height: 35px" type="text" id="mainDept" name="mainDept" required  lay-verify="required" autocomplete="off" class="layui-input">--%>
										<textarea type="text" name="queryMainCenterDept" id="queryMainCenterDept" readonly
										          style="background:#e7e7e7;height: 45px;width: 56%;text-indent:1em;border-radius: 4px;"></textarea>
										<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>
										<a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>
									</div>
								</div>
							</div>
							<div class="layui-col-xs2" id="twoDept">
								<div class="layui-form-item">
									<label class="layui-form-label">区域责任部门</label>
									<div class="layui-input-block">
										<%--                                    <input style="height: 35px" type="text" id="mainDept" name="mainDept" required  lay-verify="required" autocomplete="off" class="layui-input">--%>
										<select name="queryMainAreaDept" lay-verify="required" id="queryMainAreaDept">
										</select>
									</div>
								</div>
							</div>
							<div class="layui-col-xs2" id="threeDept">
								<div class="layui-form-item">
									<label class="layui-form-label" style="width: 115px">总承包部责任部门</label>
									<div class="layui-input-block" style="margin-left: 125px">
										<%--                                    <input style="height: 35px" type="text" id="mainDept" name="mainDept" required  lay-verify="required" autocomplete="off" class="layui-input">--%>
										<select name="queryMainProjectDept" lay-verify="required" id="queryMainProjectDept">
										</select>
									</div>
								</div>
							</div>
							<div class="layui-col-xs2 authority_search" style="width: 13%;display: none;text-align: right">
								<button type="button" class="layui-btn layui-btn-sm search" id="querys" style="margin-left: 8px;">查询</button>
								<button type="button" class="layui-btn layui-btn-sm clear" id="resets">重置</button>
								<%--<button button type="button" class="layui-btn layui-btn-sm">
									<i class="layui-icon layui-icon-spread-left icon"></i>
								</button>--%>
							</div>
						</div>
					</div>
<%--				</form>--%>
				<div style="padding: 1px 10px">
					<table id="demo" lay-filter="test"></table>
				</div>
			</div>
		</div>
	</div>
	<script type="text/html" id="toolbarDemo">
		<div class="layui-btn-container">
			<div style="position:absolute;top: 4px;right: -140px">
				<%--            <button class="layui-btn layui-btn-sm" lay-event="approve" id="selected">入库审批</button>--%>
				{{# if(authorityObject && authorityObject['01']){ }}
				<button class="layui-btn layui-btn-sm" lay-event="add" style="margin-left:10px;">新增</button>
				{{# } }}
				{{# if(authorityObject && authorityObject['05']){ }}
				<button class="layui-btn layui-btn-sm" lay-event="edit" style="margin-left:10px;">编辑</button>
				{{# } }}
				{{# if(authorityObject && authorityObject['04']){ }}
				<button class="layui-btn layui-btn-sm" lay-event="del" style="margin-left:10px;">删除</button>
				{{# } }}
			</div>
		</div>
	</script>

	<script>
        initAuthority()

        var table = null;
        var form = null;
        var tableIns = null;
        //重置
        $('#resets').on("click",function () {
            $('.layui-input').val('')
            var tgName = $("#tgNames").val()
            var controlLevel = $("#attionLevels").val()
            var mainCenterDept = $("#mainDept").val()
            if ($('.layui-tab-title .layui-this').text() == '关键任务') {
                tableIns.reload({
                    url: '/WorkItem/seldWorkItem',
                    where: {
                        tgName: tgName,
                        controlLevel: controlLevel,
                        mainCenterDept: mainCenterDept,
                        useFlag: true,
                        pageSize: 10,
                        _: new Date().getTime()
                    }
                    , page: {
                        curr: 1
                    }
                })
            } else {
                tableIns.reload({
                    url: '/TaskItem/seldWorkItem',
                    where: {
                        taskName: tgName,
                        controlLevel: controlLevel,
                        mainCenterDept: mainCenterDept,
                        useFlag: true,
                        pageSize: 10,
                        _: new Date().getTime()
                    }
                    , page: {
                        curr: 1
                    }
                })
            }
        })
        var dictionaryObj = {
            CONTROL_LEVEL: {},
            //RESULT_DESC:{},
            MAIN_CENTER_DEPT: {},
            MAIN_AREA_DEPT: {},
            MAIN_PROJECT_DEPT: {},
            WAREHOUSING_YN: {},
            CGCL_TYPE: {},
            ORGANIZATION_TYPE: {},
            TG_TYPE: {},
            PLAN_PHASE: {},
			TG_GRADE: {},
			DUTY_TYPE:{},
        }
        var dictionaryStr = 'CONTROL_LEVEL,RESULT_DESC,MAIN_CENTER_DEPT,MAIN_AREA_DEPT,MAIN_PROJECT_DEPT,WAREHOUSING_YN,CGCL_TYPE,ORGANIZATION_TYPE,TG_TYPE,PLAN_PHASE,TG_GRADE,DUTY_TYPE';
        var CGCL_TYPE = ''
        var mainAreaDept = '<option value="">请选择</option>'
        var mainProjectDept = '<option value="">请选择</option>'
        var centerDutyType = '<option value="">请选择</option>'
        var areaDutyType = '<option value="">请选择</option>'
        $.ajax({
            url: '/Dictonary/selectDictionaryByDictNos',
            dataType: 'json',
            type: 'get',
            async: false,
            data: {dictNos: dictionaryStr},
            success: function (res) {
                if (res.flag) {
                    if (res.object['CGCL_TYPE']) {
                        CGCL_TYPE = res.object['CGCL_TYPE']
                    }
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: ''}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                                //判断组织类型
                                if (item.facility == '区域责任部门') {
                                    mainAreaDept += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                } else if (item.facility == '总承包部责任部门') {
                                    mainProjectDept += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                }else if(item.parentNo == 'DUTY_TYPE'){
                                    centerDutyType += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                    areaDutyType += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                }
                                else {
                                    dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                }
                            })
                        }
                    }
                }
            }
        })
        $('#queryMainAreaDept').html(mainAreaDept)
        $('#queryMainProjectDept').html(mainProjectDept)
        // 刷新
        $(document).on('click', '.refurbish', function () {
            var model = ''
            if ($('.layui-tab-title .layui-this').text() == '关键任务') {
                model = 'workItem'
            } else if ($('.layui-tab-title .layui-this').text() == '子任务') {
                model = 'taskItems'
            }
            $.get('/ProjectInfo/getMaxNo', {model: model}, function (res) {
                $('form input[name="tgNo"]').val(res)
            })
        })

        layui.use(['table', 'form', 'element'], function () {
            table = layui.table;
            form = layui.form;
            element = layui.element;
            form.render()
            projectTable(0, '/WorkItem/seldWorkItem')

            element.on('tab(docDemoTabBrief)', function (data) {
                // console.log(data.index); //得到当前Tab的所在下标
                if (data.index == 0) {
                    $('#oneDept').show()
                    $('#twoDept').show()
                    $('#threeDept').show()
                    $('#targetLevel').show()
                    $('.authority_search').css({
                        'width': '13%',
                    })
                    projectTable(0, '/WorkItem/seldWorkItem')
                } else {
                    $('#oneDept').hide()
                    $('#twoDept').hide()
                    $('#threeDept').hide()
                    $('#targetLevel').hide()
                    $('.authority_search').css({
                        'width': '69%',
                    })
                    projectTable(1, '/TaskItem/seldWorkItem')
                }
            });
            // 获取数据字典数据
            $.ajax({
                url: '/Dictonary/selectDictionaryByNo',
                dataType: 'json',
                type: 'get',
                async: false,
                data: {dictNo: 'CONTROL_LEVEL'},
                success: function (res) {
                    if (res.flag) {
                        var object = res.data
                        var str = ''
                        for (var i = 0; i < object.length; i++) {
                            str += '<option value="' + object[i].dictNo + '">' + object[i].dictName + '</option>'
                        }
                        $('.attionLevel').append(str)
                        form.render('select');
                    }
                }
            });
            $('#form select[name="attionLevel"]').append(dictionaryObj['CONTROL_LEVEL']['str']);

            //表格渲染
            function projectTable(type, url) {
                var cols = ''
                if (type == 0) {
                    cols = [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号',}
                        , {field: 'tgNo', title: '工作项编号',}
                        , {field: 'tgName', title: '工作项名称', event: 'detail', style: 'cursor: pointer;'}
                        , {
                            field: 'controlLevel', title: '关注等级', templet: function (d) {
								return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                            }
                        }
						, {
							field: 'tgGrade', title: '目标等级', templet: function (d) {
								return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
							}
						}
                        , {field: 'resultStandard', title: '完成标准',}
                        , {field: 'hardDegree', title: '标准难度系数',}
                        , {
                            field: 'resultDict', title: '成果标准模板', templet: function (d) {
                                var resultDesc = ''
                                if (d.resultDictList) {
                                    d.resultDictList.forEach(function (item, index) {
                                        resultDesc += item.dictName + ','
                                    })
                                }
                                return resultDesc
                            }
                        }
                        , {
                            field: 'mainCenterDeptName', title: '中心责任部门', templet: function (d) {
                                if (d.mainCenterDeptName) {
                                    return d.mainCenterDeptName.replace(/,$/, '')
                                } else {
                                    return ''
                                }
                            }
                        }
						, {
							field: 'centerDutyType', title: '中心职责类型', templet: function (d) {
								return dictionaryObj['DUTY_TYPE']['object'][d.centerDutyType] || ''
							}
						}
                        , {
                            field: 'mainAreaDept', title: '区域责任部门', templet: function (d) {
                                return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
                            }
                        }
						, {
							field: 'areaDutyType', title: '区域职责类型', templet: function (d) {
								return dictionaryObj['DUTY_TYPE']['object'][d.areaDutyType] || ''
							}
						}
                        , {
                            field: 'mainProjectDept', title: '总承包部责任部门', templet: function (d) {
                                return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
                            }
                        }
                        , {
                            field: 'planStage', title: '计划阶段', templet: function (d) {
                                return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                            }
                        }
                        , {
                            field: 'tgType', title: '关键任务类型', templet: function (d) {
                                return dictionaryObj['TG_TYPE']['object'][d.tgType] || ''
                            }
                        }
                        , {
                            field: 'forceCheck', title: '是否强制勾选', width: 130, templet: function (d) {
                                if (d.forceCheck == 1) {
                                    return '是'
                                } else if (d.forceCheck == 0) {
                                    return '否'
                                } else {
                                    return ''
                                }
                            }
                        }
                    ]]
                } else {
                    cols = [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号',}
                        , {field: 'taskNo', title: '工作项编号',}
                        , {field: 'taskName', title: '工作项名称', event: 'detail', style: 'cursor: pointer;'}
                        , {field: 'resultStandard', title: '完成标准',}
                        , {
                            field: 'resultDict', title: '成果标准模板', templet: function (d) {
                                var resultDesc = ''
                                if (d.resultDictList) {
                                    d.resultDictList.forEach(function (item, index) {
                                        resultDesc += item.dictName + ','
                                    })
                                }
                                return resultDesc
                            }
                        }
                        , {field: 'hardDegree', title: '标准难度系数',}
                        /* ,{field: 'mainCenterDeptName', title: '中心责任部门',templet: function (d) {
								 if(d.mainCenterDeptName){
									 return d.mainCenterDeptName.replace(/,$/, '')
								 }else{
									 return ''
								 }
							 }}
						 ,{field: 'mainAreaDept', title: '区域责任部门',templet: function (d) {
								 return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
							 }}
						 ,{field: 'mainProjectDept', title: '总承包部责任部门',templet: function (d) {
								 return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
							 }}*/
                    ]]
                }
                tableIns = table.render({
                    elem: '#demo'
                    , url: url//数据接口
                    , toolbar: '#toolbarDemo'
                    , page: true
                    , height: 'full-220'
                    , limit: 50
                    , where: {
                        useFlag: true,
                        _: new Date().getTime()
                    }
                    , defaultToolbar: ['']
                    , cols: cols
                    , parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.obj,//解析数据列表
                            "count": res.totleNum, //解析数据长度
                        };
                    },
                    request: {
                        pageName: 'page' //页码的参数名称，默认：page
                        , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                });
            }

            //头工具栏事件
            table.on('toolbar(test)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id);  //获取选中行状态
                switch (obj.event) {
                    case 'add':
                        if ($('.layui-tab-title .layui-this').text() == '关键任务') {
                            creat('target', 0)
                        } else {
                            creat('item', 0)
                        }
                        break;
                    case 'edit':
                        if (checkStatus.data.length != 1) {
                            layer.msg('请选择一项！', {icon: 0});
                            return false
                        }
                        if ($('.layui-tab-title .layui-this').text() == '关键任务') {
                            creat('target', '1', checkStatus.data[0])
                        } else {
                            creat('item', '1', checkStatus.data[0])
                        }
                        break;
                    case 'del':
                        if (!checkStatus.data.length) {
                            layer.msg('请至少选择一项！', {icon: 0});
                            return false
                        }
                        if ($('.layui-tab-title .layui-this').text() == '关键任务') {
                            var url = '/WorkItem/delWorkItemById';
                            var tgId = [];
                            checkStatus.data.forEach(function (v, i) {
                                tgId.push(v.tgId);
                            });
                            var datas = {tgId: tgId}
                        } else {
                            var url = '/TaskItem/delWorkItemById';
                            var taskItemId = [];
                            checkStatus.data.forEach(function (v, i) {
                                taskItemId.push(v.taskItemId);
                            });
                            var datas = {taskItemId: taskItemId}
                        }
                        layer.confirm('确定删除该条数据吗？', function (index) {
                            $.ajax({
                                url: url,
                                dataType: 'json',
                                type: 'post',
                                data: datas,
                                traditional: true,
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('删除成功！', {icon: 1, area: ['60px', '100px']});
                                    } else {
                                        layer.msg('删除失败！', {icon: 0, area: ['60px', '100px']});
                                    }
                                    layer.close(index)
                                    tableIns.reload()
                                }
                            })
                        });
                        break;
                }
                ;
            });
            //监听工具条
            table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                if (layEvent === 'detail') { //查看
                    // creat('2',data)
                }
            });
        });

        //新增修改共用方法
        function creat(which, type, data) {
            var url
            var title
            if (which == 'target') {
                if (type == '0') {
                    url = '/WorkItem/saveWorkItem'
                    title = '新增工作项'
                } else if (type == '1') {
                    url = '/WorkItem/editWorkItemById'
                    title = '修改工作项'
                }
            } else if (which == 'item') {
                if (type == '0') {
                    url = '/TaskItem/saveWorkItem'
                    title = '新增工作项'
                } else if (type == '1') {
                    url = '/TaskItem/editWorkItemById'
                    title = '修改工作项'
                }
            }
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                maxmin: true,
                min: function () {
                    $('.layui-layer-shade').hide()
                },
                btn: ['保存', '退出'],
                content: '<form class="layui-form" id="form" lay-filter="formTest" style="margin: 0px 10px">' +
                    '<div class="newAndEdit layui-row" style="margin-top:60px;"><div class="layui-col-xs6" ><div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">编号<span style="color: red; font-size: 20px;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="tgNo"  id="tgNo" lay-verify="required" readonly style="background:#e7e7e7;width: 88%;display: inline-block" autocomplete="off" class="layui-input jinyong" style="width: 340px">\n' +
                    '        <a href="javascript:void(0);" style="color:#1E9FFF;font-size: 15px;" class="refurbish">刷新</a>\n' +
                    '    </div>\n' +
                    '  </div></div>' +
                    ' <div class="layui-col-xs6" ><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">工作项名称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="tgName"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                    '   </div> </div>\n' +
                    '  </div></div>' +
                    '<div class="newAndEdit layui-row"> <div class="layui-col-xs6" ><div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">完成标准</label>\n' +
                    '    <div class="layui-input-block ">\n' +
                    '         <input type="text" name="resultStandard"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    ' </div></div>\n' +
                    '<div class="layui-col-xs6" ><div class="layui-form-item" >' +
                    '    <label class="layui-form-label">标准难度系数</label>\n' +
                    '    <div class="layui-input-block ">\n' +
                    '         <input type="text" name="hardDegree" value="5" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '</div></div>' +
                    '</div>\n' +
					'<div class="newAndEdit layui-row">' +
					' <div class="layui-col-xs6" ><div class="layui-form-item">\n' +
					'    <label class="layui-form-label">成果标准模板</label>\n' +
					'    <div class="layui-input-block">\n' +
					'<input type="text" name="resultDict" readonly style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input" >\n' +
					'<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="resultDictAdd">添加</a>\n' +
					' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="resultDictDel">清空</a>\n' +
					'    </div></div>\n' +
					'  </div></div>' +
					'<div class="newAndEdit layui-row targetShow">' +
					'<div class="layui-col-xs6" > <div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">关注等级</label>\n' +
					'    <div class="layui-input-block">\n' +
						// '      <input type="checkbox" name="controlLevel" title="是" lay-skin="primary" checked>'+
					'           <select name="controlLevel"id="controlLevel" class="controlLevel">\n' +
					'            </select>' +
					'    </div>\n' +
					'  </div></div>' +
					' <div class="layui-col-xs6" ><div class="layui-form-item">\n' +
					'    <label class="layui-form-label">目标等级</label>\n' +
					'    <div class="layui-input-block">\n' +
						'           <select name="tgGrade" lay-verify="required" id="tgGrade" class="jinyong tgGrade">\n' +
						'            </select>' +
					'    </div></div>\n' +
					'  </div></div>' +
                    '<div class="newAndEdit layui-row" id="threeDeptNew" style="margin-top: 5px"> <div class="layui-col-xs4" > <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 110px">中心责任部门</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <textarea  type="text" name="mainCenterDept" id="mainCenterDept" readonly  style="background:#e7e7e7;height: 45px;width: 205px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '        <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
                    '        <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
                    '    </div>\n' +
                    '  </div></div>\n' +
                    ' <div class="layui-col-xs4" ><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 110px">区域责任部门</label>\n' +
                    '    <div class="layui-input-block" style="margin-left: 140px">\n' +
                    '           <select name="mainAreaDept" lay-verify="required" id="mainAreaDept">\n' +
                    '            </select>' +
                    /* '      <textarea  type="text" name="mainAreaDept" id="mainAreaDept" readonly  style="background:#e7e7e7;height: 45px;width: 205px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
					 '        <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
					 '        <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +*/
                    // '      </p>'+
                    '    </div>\n' +
                    '  </div></div>' +
                    '<div class="layui-col-xs4" > <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 113px">总承包部责任部门</label>\n' +
                    '    <div class="layui-input-block" style="margin-left: 145px">\n' +
                    '           <select name="mainProjectDept" lay-verify="required" id="mainProjectDept">\n' +
                    '            </select>' +
                    /*  '      <textarea  type="text" name="mainProjectDept" id="mainProjectDept" readonly  style="background:#e7e7e7;height: 45px;width: 205px;text-indent:1em;border-radius: 4px;"></textarea>\n' +
					  '        <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
					  '        <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +*/
                    '    </div></div>\n' +
                    '  </div></div>' +
					'<div class="newAndEdit layui-row targetShow"> <div class="layui-col-xs3" ><div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">中心职责</label>\n' +
					'    <div class="layui-input-block ">\n' +
					'         <input type="text" name="centerDuty"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					' </div></div>\n' +
						'<div class="layui-col-xs3" > <div class="layui-form-item">\n' +
						'    <label class="layui-form-label" style="width: 113px">中心职责类型</label>\n' +
						'    <div class="layui-input-block" style="margin-left: 145px">\n' +
						'           <select name="centerDutyType" lay-verify="required" id="centerDutyType" class="centerDutyType">\n' +
						'            </select>' +
						'    </div></div>\n' +
						'  </div>'+
					'<div class="layui-col-xs3" ><div class="layui-form-item" >' +
					'    <label class="layui-form-label">区域职责</label>\n' +
					'    <div class="layui-input-block ">\n' +
					'         <input type="text" name="areaDuty"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					'</div></div>' +
						'<div class="layui-col-xs3" > <div class="layui-form-item">\n' +
						'    <label class="layui-form-label" style="width: 113px">区域职责类型</label>\n' +
						'    <div class="layui-input-block" style="margin-left: 145px">\n' +
						'           <select name="areaDutyType" lay-verify="required" id="areaDutyType" class="areaDutyType">\n' +
						'            </select>' +
						'    </div></div>\n' +
						'  </div>'+
					'</div>\n' +
					'<div class="newAndEdit layui-row targetShow"> <div class="layui-col-xs6" ><div class="layui-form-item" >\n' +
					'    <label class="layui-form-label">总承包部职责</label>\n' +
					'    <div class="layui-input-block ">\n' +
					'         <input type="text" name="projectDuty"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
					'    </div>\n' +
					' </div></div>\n' +
					'</div>\n' +
                    '<div class="newAndEdit layui-row" id="targetSelect"><div class="layui-col-xs6" > <div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">计划阶段</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '           <select name="planStage" lay-verify="required" id="planStage">\n' +
                    '            </select>' +
                    '    </div>\n' +
                    '  </div></div>' +
                    ' <div class="layui-col-xs6" ><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">关键任务类型</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '           <select name="tgType" lay-verify="required" id="tgType" >\n' +
                    '            </select>' +
                    '    </div></div>\n' +
                    '  </div></div>' +
                    //第四行
                    '<div class="newAndEdit layui-row"><div class="layui-col-xs6" ><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">是否启用</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '        <input type="checkbox" name="warehousingYn" title="启用" lay-skin="primary" >\n' +
                    '    </div>\n' +
                    ' </div></div>' +
                    '<div class="layui-col-xs6" id="forceCheck"><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="width: 85px">是否强制勾选</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '        <input type="checkbox" name="forceCheck" title="强制勾选" lay-skin="primary" >\n' +
                    '    </div>\n' +
                    ' </div></div>' +
                    ' </div>' +
                    '</form>',
                success: function (res) {
                    if (which == 'target') {
                        $('#threeDeptNew').show()
                        $('#targetSelect').show()
                        $('#forceCheck').show()
                        $('.targetShow').show()
                    } else if (which == 'item') {
                        $('#threeDeptNew').hide()
                        $('#targetSelect').hide()
                        $('#forceCheck').hide()
                        $('.targetShow').hide()
                    }
                    $('#form select[name="controlLevel"]').append(dictionaryObj['CONTROL_LEVEL']['str']);
                    $('#form select[name="tgGrade"]').append(dictionaryObj['TG_GRADE']['str']);
                    $('#form select[name="mainAreaDept"]').append(mainAreaDept);
                    $('#form select[name="mainProjectDept"]').append(mainProjectDept);
                    $('#form select[name="planStage"]').append(dictionaryObj['PLAN_PHASE']['str']);
                    $('#form select[name="tgType"]').append(dictionaryObj['TG_TYPE']['str']);
					$('#form select[name="areaDutyType"]').append(areaDutyType);
					$('#form select[name="centerDutyType"]').append(centerDutyType);
                    form.render()
                    // 成果标准模板
                    $('.resultDictAdd').on("click",function () {
                        layer.open({
                            type: 1,
                            title: '添加成果标准模板',
                            area: ['30%', '70%'],
                            btn: ['确定', '取消'],
                            content: '<div  class="layui-form relation"  style="margin-top: 15px"></div>',
                            success: function () {
                                var data = CGCL_TYPE
                                var str = ''
                                for (var i = 0; i < data.length; i++) {
                                    str += '<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="' + data[i].dictName + '" title="' + data[i].dictName + '" value="' + data[i].dictNo + '" lay-skin="primary"> </div>'
                                }
                                $('.relation').html(str)
                                form.render()
                                var resultDict = $('form input[name="resultDict"]').attr('resultDict')
                                if (resultDict) {
                                    var resultDictArr = resultDict.replace(/,$/, '').split(',')
                                }
                                if (resultDictArr) {
                                    $('.relation input').each(function (index) {
                                        resultDictArr.forEach(function (v, i) {
                                            if ($('.relation input').eq(index).val() == v) {
                                                $('.relation input').eq(index).prop('checked', 'true')
                                                form.render()
                                            }
                                        })
                                    })
                                }
                            },
                            yes: function (index) {
                                var resultDict = ''
                                var resultDictName = ''
                                $('.relation input').each(function () {
                                    if ($(this).prop('checked')) {
                                        resultDict += $(this).val() + ','
                                        resultDictName += $(this).attr('title') + ','
                                    }
                                })
                                $('form input[name="resultDict"]').val(resultDictName)
                                $('form input[name="resultDict"]').attr('resultDict', resultDict)
                                layer.close(index);
                            }
                        })
                    })
                    $('.resultDictDel').on("click",function () {
                        $('form input[name="resultDict"]').val('')
                        $('form input[name="resultDict"]').attr('resultDict', '')
                    })
                    //编号
                    if (which == 'target') {
                        if (type == 0) {
                            $.get('/ProjectInfo/getMaxNo', {model: 'workItem'}, function (res) {
                                $('form input[name="tgNo"]').val(res)
                            })
                        }
                    } else if (which == 'item') {
                        if (type == 0) {
                            $.get('/ProjectInfo/getMaxNo', {model: 'taskItems'}, function (res) {
                                $('form input[name="tgNo"]').val(res)
                            })
                        }
                    }
                    form.render()

                    if (type == 1) {
                        if (which == 'target') {
                            form.val("formTest", data);
                        } else if (which == 'item') {
                            form.val("formTest", data);
                            $('#tgNo').val(data.taskNo)
                            $('[name="tgName"]').val(data.taskName)
                        }
                        $('#form #mainCenterDept').val(data.mainCenterDeptName);
                        $('#form #mainCenterDept').attr('deptid', data.mainCenterDept);
                        // 成果标准模板
                        if (data.resultDictList) {
                            var resultDictList = data.resultDictList
                            var resultDict = ''
                            var resultDictName = ''
                            resultDictList.forEach(function (item) {
                                resultDict += item.dictNo + ','
                                resultDictName += item.dictName + ','
                            })
                            $('form input[name="resultDict"]').val(resultDictName)
                            $('form input[name="resultDict"]').attr('resultDict', resultDict)
                        }
                        if (data.warehousingYn == 1) {
                            $('[name="warehousingYn"]').prop('checked', true)
                        } else {
                            $('[name="warehousingYn"]').prop('checked', false)
                        }
                        if (data.forceCheck == 1) {
                            $('[name="forceCheck"]').prop('checked', true)
                        } else {
                            $('[name="forceCheck"]').prop('checked', false)
                        }
						/*//顶层关注回显
						if (data.controlLevel == 1) {
							$('[name="controlLevel"]').prop('checked', true)
						} else {
							$('[name="controlLevel"]').prop('checked', false)
						}*/
                        form.render()
                    }
                },
                yes: function (index) {
                    var tgNo = $('input[name="tgNo"]').val();
                    var tgName = $('input[name="tgName"]').val();
                    var hardDegree = $('input[name="hardDegree"]').val();
                    var tgGrade = $('#tgGrade').val();
                    var resultDict = $('#form input[name="resultDict"]').attr('resultDict');
                    //console.log(resultDict);
                    var resultStandard = $('input[name="resultStandard"]').val();
                    var mainCenterDept = $('#form #mainCenterDept').attr('deptid');
                    var mainAreaDept = $('#mainAreaDept').val();
                    var mainProjectDept = $('#mainProjectDept').val();
                    var planStage = $('#planStage').val();
                    var tgType = $('#tgType').val();
					var centerDuty = $('input[name="centerDuty"]').val();
					var areaDuty = $('input[name="areaDuty"]').val();
					var projectDuty = $('input[name="projectDuty"]').val();
					var controlLevel = $('#controlLevel').val();
					var areaDutyType = $('#areaDutyType').val();
					var centerDutyType = $('#centerDutyType').val();
                    var warehousingYn
                    if ($('input[name="warehousingYn"]').prop('checked')) {
                        warehousingYn = 1
                    } else {
                        warehousingYn = 0
                    }
                    var forceCheck
                    if ($('input[name="forceCheck"]').prop('checked')) {
                        forceCheck = 1
                    } else {
                        forceCheck = 0
                    }
					/*//判断顶层关注是否被勾选
					var controlLevel
					if($('[name="controlLevel"]').prop('checked')){
						controlLevel = 1
					}else{
						controlLevel = 0
					}*/
                    if (which == 'target') {
                        var datas = {
                            tgNo: tgNo,
                            tgName: tgName,
                            hardDegree: hardDegree,
                            controlLevel: controlLevel,
							tgGrade: tgGrade,
                            resultDict: resultDict,
                            resultStandard: resultStandard,
                            mainCenterDept: mainCenterDept,
                            mainAreaDept: mainAreaDept,
                            mainProjectDept: mainProjectDept,
                            warehousingYn: warehousingYn,
                            planStage: planStage,
                            tgType: tgType,
                            forceCheck: forceCheck,
							centerDuty: centerDuty,
							areaDuty: areaDuty,
							projectDuty: projectDuty,
							areaDutyType: areaDutyType,
							centerDutyType: centerDutyType,
                        }
                    } else if (which == 'item') {
                        var datas = {
                            taskNo: tgNo,
                            taskName: tgName,
                            hardDegree: hardDegree,
                            resultDict: resultDict,
                            resultStandard: resultStandard,
                            warehousingYn: warehousingYn,
                        }
                    }

                    if (type == 1) {
                        if (which == 'target') {
                            datas.tgId = data.tgId
                        } else if (which == 'item') {
                            datas.taskItemId = data.taskItemId
                        }
                    }
                    if (tgName==""){
						layer.msg('请输入工作项名称！', {icon: 5, area: ['60px', '100px']});
						return
					}

                    $.ajax({
                        url: url,
                        data: datas,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            if (res.flag) {
                                if (type == 0) {
                                    layer.msg('新增成功！', {icon: 1, area: ['60px', '100px']});
                                    layer.close(index);
                                    tableIns.reload()
                                } else if (type == 1) {
                                    layer.msg('修改成功！', {icon: 1, area: ['60px', '100px']});
                                    layer.close(index);
                                    tableIns.reload()
                                }

                            }

                        }
                    })
                }

            })
        }

        //选部门控件添加
        $(document).on('click', '.deptAdd', function () {
            var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
            // console.log(chooseNum);
            dept_id = $(this).siblings('textarea').attr('id');
            $.popWindow("/common/selectDept" + chooseNum);
        });
        //选部门控件删除
        $(document).on('click', '.deptDel', function () {
            var deptId = $(this).siblings('textarea').attr('id');
            $('#' + deptId).val('');
            $('#' + deptId).attr('deptid', '');
        });

        //查询
        $("#querys").on("click", function () {
            var tgName = $("#tgNames").val()
            var controlLevel = $("#attionLevels").val()
            var mainCenterDept = $("#mainDept").val()
            if ($('.layui-tab-title .layui-this').text() == '关键任务') {
                tableIns.reload({
                    url: '/WorkItem/seldWorkItem',
                    where: {
                        tgName: tgName,
                        controlLevel: controlLevel,
                        mainCenterDept: mainCenterDept,
                        useFlag: true,
                        pageSize: 10,
                        _: new Date().getTime()
                    }
                    , page: {
                        curr: 1
                    }
                })
            } else {
                tableIns.reload({
                    url: '/TaskItem/seldWorkItem',
                    where: {
                        taskName: tgName,
                        controlLevel: controlLevel,
                        mainCenterDept: mainCenterDept,
                        useFlag: true,
                        pageSize: 10,
                        _: new Date().getTime()
                    }
                    , page: {
                        curr: 1
                    }
                })
            }
        });

        //将毫秒数转为yyyy-MM-dd格式时间
        function format(t) {
            if (t) return new Date(t).Format("yyyy-MM-dd");
            else return ''
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

