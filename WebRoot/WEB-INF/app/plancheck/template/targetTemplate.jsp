<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>关键任务模板</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
		<link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		<style>
            html,body {
                width: 100%;
                height: 100%;
            }

			.layui-disabled, .layui-disabled:hover {
				color: #797979 !important;
			}

			.ztree * {
				font-size: 11pt !important;
			}

			#questionTree li {
				border-bottom: 1px solid #ddd;
				line-height: 40px;
				padding-left: 10px;
				cursor: pointer;
				border-radius: 3px;
			}

			.select {
				background: #c7e1ff;
			}

			.layui-table-tool {
				min-height: 38px;
				padding: 2px 15px;
			}

			#leftHeight .layui-btn + .layui-btn {
				margin-left: 8px;
			}

			.query input, select {
				height: 35px;
			}

			.query button {
				float: left;
			}

			.layui-table-tool-temp {
				padding-right: 0px;
			}

			.query .layui-form-item {
				margin-bottom: 10px;
			}

			#editTab .layui-table-body input{
				height: 28px;
			}

		</style>
		<link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
		<script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>

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
		<%--<div style="padding-top: 10px;position: relative;">
			<img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:15px "><span
				style="margin-left: 49px;font-size: 20px;">关键任务模板</span>
		</div>
		<hr>--%>
		<form class="layui-form" action="" style="padding-top: 15px;box-sizing: border-box">
			<div class="query" style="display: flex">
				<div class="layui-form-item" style="margin-left: -17px">
					<label class="layui-form-label">关键任务名称:</label>
					<div class="layui-input-block">
						<input type="text" name="title" required
						       lay-verify="required" autocomplete="off" class="layui-input tgName">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">模板类型:</label>
					<div class="layui-input-block">
						<select name="dictName" class="dictName" lay-verify="required">
							<option value="">请选择</option>
						</select>
					</div>
				</div>
				<div class="authority_search" style="display: none;position: absolute;right: 8px;    width: 200px;">
					<button type="button" class="layui-btn layui-btn-sm search"
					        style="margin-left: 2%; width: 55px;">查询
					</button>
					<button type="button" class="layui-btn layui-btn-sm clear"
					        style="margin-left: 20px;width: 55px;">重置
					</button>
					<button type="button" class="layui-btn layui-btn-sm" style="margin-left: 20px"><i
							class="layui-icon layui-icon-spread-left icon"></i></button>
				</div>
			</div>
		</form>
		<div class="layui-fluid" id="LAY-app-message">
			<input type="hidden" id="sortId">
			<input type="hidden" id="tplTypeId">
			<div class="layui-row ">
				<div class="layui-lf" style="width:270px;float:left">
					<div class="layui-card">
						<div class="layui-card-body" id="leftHeight">
							<div style="margin-bottom:10px">
								<button type="button" class="layui-btn layui-btn-sm plan" id="addPlan" style="display: none;">新建</button>
								<button type="button" class="layui-btn layui-btn-sm plan" id="editPlan" style="display: none;">修改</button>
								<button type="button" class="layui-btn layui-btn-sm " id="delPlan" style="display: none;">删除</button>
								<button type="button" class="layui-btn layui-btn-sm " id="isDisable" style="display: none;">停用</button>
							</div>
							<span style="text-align: center;display: block;font-weight: bold;cursor: pointer;" class="question">关键任务模板</span>
							<ul id="questionTree" class="eleTree" lay-filter="questionTree"
							    style="overflow:auto;height:calc(100% - 30px)">
							</ul>

						</div>
					</div>
				</div>
				<div class="layui-rt" style="width:calc(100% - 270px);float:left">
					<div class="tishi" style="height: 100%;text-align: center;border: none;">
						<div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
						<h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧关键任务模板</h2>
					</div>
					<div class="layui-card rightHeight" style="padding-left: 10px;display: none">
						<table id="questionTable" lay-filter="questionTable"></table>
					</div>
				</div>
			</div>
		</div>

		<script type="text/html" id="toolbar">
			<div style="float: right;margin-left: 10px;">
<%--				{{# if(authorityObject && authorityObject['02']){ }}--%>
				<a class="layui-btn layui-btn-sm" lay-event="forceCheck" id="forceCheck">强制勾选</a>
<%--				{{# } }}--%>
				{{# if(authorityObject && authorityObject['02']){ }}
				<a class="layui-btn layui-btn-sm" lay-event="import" id="import">导入</a>
				{{# } }}
				{{# if(authorityObject && authorityObject['05']){ }}
				<a class="layui-btn layui-btn-sm" lay-event="edit" id="edit">修改</a>
				{{# } }}
				{{# if(authorityObject && authorityObject['04']){ }}
				<a class="layui-btn layui-btn-sm" lay-event="del" id="del">删除</a>
				{{# } }}
			</div>
		</script>
		<script type="text/html" id="toolbarDemoIn">
			<div class="layui-btn-container" style="height: 30px;">
				<button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
			</div>
		</script>
		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
		</script>

		<script>
            resizeSize();

            window.onresize = resizeSize;

            initAuthority();
            var dictionaryObj = {
                CONTROL_LEVEL: {},
                CGCL_TYPE: {},
                ORGANIZATION_TYPE: {},
                TG_TYPE: {},
                PLAN_PHASE: {},
				TG_GRADE: {},
				DUTY_TYPE:{},
            }
            var dictionaryStr = 'CONTROL_LEVEL,CGCL_TYPE,ORGANIZATION_TYPE,TG_TYPE,PLAN_PHASE,TG_GRADE,DUTY_TYPE';
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
            layui.use(['eleTree', 'table', 'layer', 'form', 'element', 'laydate', 'upload',], function () {
                var table = layui.table,
                    form = layui.form,
                    layer = layui.layer,
                    laydate = layui.laydate,
                    upload = layui.upload,
                    eleTree = layui.eleTree,
                    element = layui.element;
                form.render();

                //回显下拉框数据
				var selectData={}

                //点击停用/启用
                $('#isDisable').on("click",function () {
                    var tplTypeId = $('#tplTypeId').attr('tplTypeId')
                    var disableYn = $('#tplTypeId').attr('disableYn')
                    if (tplTypeId == '' || tplTypeId == undefined) {
                        layer.msg('请选择左侧一项!', {icon: 0});
                        return false
                    }
                    layer.confirm('确定' + $(this).text() + '&nbsp;&nbsp;' + $('#tplTypeId').attr('names') + '&nbsp;&nbsp;' + '吗？', function (index) {
                        $.ajax({
                            type: 'post',
                            url: '/TemplateType/updateById',
                            data: {tplTypeId: tplTypeId, disableYn: disableYn},
                            dataType: 'json',
                            success: function (res) {
                                if (res.flag == true) {
                                    layer.msg('保存成功!', {icon: 1});
                                    eleTreeLeft.reload()
                                    $('.tishi').show()
                                    $('.rightHeight').hide()
                                }
                            }
                        })
                    });
                })
                //项目类型
                $.ajax({
                    url: '/ProjectInfo/selectProjectTypeByNo',
                    dataType: 'json',
                    type: 'get',
                    success: function (res) {
                        var obj = res.data
                        var str = ''
                        for (var i = 0; i < obj.length; i++) {
                            str += '<option value="' + obj[i].dictId + '">' + obj[i].dictName + '</option>'
                        }
                        $('[name="dictName"]').append(str)
                        form.render('select');
                    }
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
                table.on('toolbar(questionTable)', function (obj) {
                    var checkStatus = table.checkStatus(obj.config.id);
                    if ($('#tplTypeId').attr('disableYn') == 1) {
                        layer.msg('请先启用左侧模板!');
                        return false;
                    }
                    if (obj.event == 'edit' && checkStatus.data.length != 1) {
                        layer.msg('请选择一项!');
                        return false;
                    }
                    switch (obj.event) {
                        case 'edit':
							var loadingIndex = layer.load();
                            var tgId = checkStatus.data[0].tgId
                            $.get('/TemplateItem/findTemplateById', {tgId: tgId}, function (res) {
								layer.close(loadingIndex);
                                var datas = res.object
                                layer.open({
                                    type: 1,
                                    title: '修改关键任务模板',
                                    area: ['100%', '100%'],
                                    maxmin: true,
                                    btn: ['保存', '取消'],
                                    min: function () {
                                        $('.layui-layer-shade').hide()
                                    },
                                    content: ['<form action="" class="layui-form"  id="editTab">' +
                                        //第一行
                                        '<div class="layui-row" style="margin-top:60px;"> ' +
                                        '<div class="layui-col-xs6"> ' +
                                        '<div class="layui-form-item" >\n' +
                                        '    <label class="layui-form-label">编号<span style="color: red; font-size: 20px;">*</span></label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '      <input type="text" name="tgNo" readonly style="background:#e7e7e7;" value="' + datas.tgNo + '" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                                        '   </div>' +
                                        '</div>\n' +
                                        '</div>\n' +
                                        '<div class="layui-col-xs6">' +
                                        '<div class="layui-form-item">' +
                                        '    <label class="layui-form-label">关键任务名称<span style="color: red; font-size: 20px;">*</span></label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '      <input type="text" name="tgName" value="' + datas.tgName + '" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
                                        '  </div>' +
                                        '</div>' +
                                        '</div>' +
                                        '</div>' +
                                        //第二行
                                        '<div class="layui-row" > ' +
                                        '<div class="layui-col-xs6"> ' +
                                        '<div class="layui-form-item" >\n' +
                                        '    <label class="layui-form-label">关注等级</label>\n' +
                                        '    <div class="layui-input-block">\n' +
											// '      <input type="checkbox" name="controlLevel" title="是" lay-skin="primary" checked>'+
                                        '           <select id="' + datas.controlLevel + '" name="controlLevel" lay-verify="required">\n' +
                                        '            </select>' +
                                        '    </div></div></div>\n' +
                                        '<div class="layui-col-xs6"> ' +
                                        '<div class="layui-form-item">' +
                                        '    <label class="layui-form-label">成果标准模板</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '<input type="text" name="resultDict" readonly style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input" >\n' +
                                        '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="resultDictAdd">添加</a>\n' +
                                        ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="resultDictDel">清空</a>\n' +
                                        '   </div></div></div></div>\n' +
                                        //第三行
                                        '<div class="layui-row" > ' +
                                        '<div class="layui-col-xs6"> ' +
                                        '<div class="layui-form-item" >\n' +
                                        '    <label class="layui-form-label">完成标准</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '      <input type="text" name="resultStandard"  value="' + function () {
                                            if (datas.resultStandard) {
                                                return datas.resultStandard
                                            } else {
                                                return ''
                                            }
                                        }() + '" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +

                                        '  </div></div></div>' +
                                        '<div class="layui-col-xs6"> ' +
                                        '<div class="layui-form-item" >\n' +
                                        '    <label class="layui-form-label">标准难度系数</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '      <input type="text" name="hardDegree"  value="' + function () {
                                            if (datas.hardDegree) {
                                                return datas.hardDegree
                                            } else {
                                                return ''
                                            }
                                        }() + '" lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +

                                        '  </div></div></div>' +
                                        '</div>' +
                                        //第四行
                                        '<div class="layui-row" >\n' +
                                        '<div class="layui-col-xs4">' +
										'<div class="layui-form-item" >' +
                                        '    <label class="layui-form-label" style="width: 100px;">中心责任部门</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '      <textarea  type="text" name="" id="mainCenterDept" readonly deptid="' + function () {
                                            if (datas.mainCenterDept) {
                                                return datas.mainCenterDept
                                            } else {
                                                return ''
                                            }
                                        }() + '" style="background:#e7e7e7;height: 45px;text-indent:1em;border-radius: 4px;">' + function () {
                                            if (datas.mainCenterDeptName) {
                                                return datas.mainCenterDeptName
                                            } else {
                                                return ''
                                            }
                                        }() + '</textarea>\n' +
                                        '        <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
                                        '        <a href="javascript:;" style="color:red;margin-left:5px" class="deptDel">清空</a>\n' +
                                        '   </div>' +
                                        '</div></div>' +
                                        '<div class="layui-col-xs4">' +
										'<div class="layui-form-item" >' +
                                        '    <label class="layui-form-label" style="width: 88px;">区域责任部门</label>\n' +
                                        '    <div class="layui-input-block" style="margin-left: 120px">\n' +
                                        '           <select name="mainAreaDept" lay-verify="required" id="mainAreaDept">\n' +
                                        '            </select>' +
                                        '      </div>' +
                                        '</div></div>' +
                                        '<div class="layui-col-xs4">' +
										'<div class="layui-form-item" >' +
                                        '    <label class="layui-form-label" style="width: 120px;">总承包部责任部门</label>\n' +
                                        '    <div class="layui-input-inline">\n' +
                                        '           <select name="mainProjectDept" lay-verify="required" id="mainProjectDept">\n' +
                                        '            </select>' +
                                        '  </div></div></div>' +
                                        '  </div>' +
										//第五行
										'<div class="layui-row"> <div class="layui-col-xs3" ><div class="layui-form-item" >\n' +
										'    <label class="layui-form-label">中心职责</label>\n' +
										'    <div class="layui-input-block ">\n' +
										'         <input type="text" name="centerDuty"  value="' + function () {
												if (datas.centerDuty) {
													return datas.centerDuty
												} else {
													return ''
												}
											}() + '"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
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
										'         <input type="text" name="areaDuty" value="' + function () {
												if (datas.areaDuty) {
													return datas.areaDuty
												} else {
													return ''
												}
											}() + '"   lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
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
										'<div class="layui-row"> <div class="layui-col-xs6" ><div class="layui-form-item" >\n' +
										'    <label class="layui-form-label">总承包部职责</label>\n' +
										'    <div class="layui-input-block ">\n' +
										'         <input type="text" name="projectDuty" value="' + function () {
												if (datas.projectDuty) {
													return datas.projectDuty
												} else {
													return ''
												}
											}() + '"  lay-verify="required" autocomplete="off" class="layui-input jinyong">\n' +
										'    </div>\n' +
										' </div></div>\n' +
										'<div class="layui-col-xs6"> ' +
										'<div class="layui-form-item" >\n' +
										'    <label class="layui-form-label">目标等级</label>\n' +
										'    <div class="layui-input-block">\n' +
										'           <select id="' + datas.tgGrade + '" name="tgGrade" lay-verify="required">\n' +
										'            </select>' +
										'    </div></div></div>\n' +
										'</div>\n' +
                                        //第六行
                                        '<div class="layui-row" > ' +
                                        '<div class="layui-col-xs6"> ' +
                                        '<div class="layui-form-item" >\n' +
                                        '    <label class="layui-form-label">计划阶段</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '           <select id="' + datas.planStage + '" name="planStage" lay-verify="required">\n' +
                                        '            </select>' +
                                        '    </div></div></div>\n' +
                                        '<div class="layui-col-xs6"> ' +
                                        '<div class="layui-form-item">' +
                                        '    <label class="layui-form-label">关键任务类型</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '           <select id="' + datas.tgType + '" name="tgType" lay-verify="required">\n' +
                                        '            </select>' +
                                        '   </div></div></div></div>\n' +
                                        //第七行
                                        '<div class="layui-row" > ' +
                                        '<div class="layui-col-xs6"> ' +
                                        '<div class="layui-form-item" >\n' +
                                        '    <label class="layui-form-label" style="width: 85px">是否强制勾选</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '        <input type="checkbox" name="forceCheck" title="强制勾选" lay-skin="primary" >\n' +
                                        '    </div></div></div>\n' +
                                        '</div>\n' +
										//第八行
										'<div class="layui-row" > ' +
										'   <table id="preTaskTable" lay-filter="preTaskTable"></table>'+
										'</div>' +
										'</form>'].join(''),
                                    success: function (res) {
                                        $('#editTab select[name="controlLevel"]').append(dictionaryObj['CONTROL_LEVEL']['str']);
                                        $('#editTab select[name="planStage"]').append(dictionaryObj['PLAN_PHASE']['str']);
                                        $('#editTab select[name="tgType"]').append(dictionaryObj['TG_TYPE']['str']);
										$('#editTab select[name="areaDutyType"]').html(areaDutyType);
										$('#editTab select[name="centerDutyType"]').html(centerDutyType);
                                        $('#mainAreaDept').html(mainAreaDept)
                                        $('#mainProjectDept').html(mainProjectDept)
                                        //目标等级
                                        $.ajax({
                                            url: '/Dictonary/selectDictionaryByNo',
                                            dataType: 'json',
                                            type: 'get',
                                            async: false,
                                            data: {dictNo: 'TG_GRADE'},
                                            success: function (res) {
                                                if (res.flag) {
                                                    var object = res.data
                                                    // var str = '<option value="">请选择</option>'
                                                    var str = ''
                                                    for (var i = 0; i < object.length; i++) {
                                                        str += '<option value="' + object[i].dictNo + '">' + object[i].dictName + '</option>'
                                                    }
                                                    $('[name="tgGrade"]').append(str)
                                                    $('[name="tgGrade"]').val($('[name="tgGrade"]').attr('id'))
                                                    $('[name="planStage"]').val($('[name="planStage"]').attr('id'))
                                                    $('[name="tgType"]').val($('[name="tgType"]').attr('id'))
                                                    $('[name="controlLevel"]').val($('[name="controlLevel"]').attr('id'))
                                                    form.render('select');
                                                }
                                            }
                                        });
                                        // 成果标准模板
                                        if (datas.resultDictList) {
                                            var resultDictList = datas.resultDictList
                                            var resultDict = ''
                                            var resultDictName = ''
                                            resultDictList.forEach(function (item) {
                                                resultDict += item.dictNo + ','
                                                resultDictName += item.dictName + ','
                                            })
                                            $('form input[name="resultDict"]').val(resultDictName)
                                            $('form input[name="resultDict"]').attr('resultDict', resultDict)
                                        }
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
                                        $('#mainAreaDept').val(datas.mainAreaDept)
                                        $('#mainProjectDept').val(datas.mainProjectDept)
										$('#centerDutyType').val(datas.centerDutyType)
										$('#areaDutyType').val(datas.areaDutyType)
                                        if (datas.forceCheck == 1) {
                                            $('[name="forceCheck"]').prop('checked', true)
                                        } else {
                                            $('[name="forceCheck"]').prop('checked', false)
                                        }
										/*//顶层关注回显
										if (datas.controlLevel == 1) {
											$('[name="controlLevel"]').prop('checked', true)
										} else {
											$('[name="controlLevel"]').prop('checked', false)
										}*/
                                        form.render()
										table.render({
											elem: '#preTaskTable',
											data:datas.preTargetList ? datas.preTargetList :[{}],
											toolbar: '#toolbarDemoIn',
											defaultToolbar: [''],
											limit:1000,
											cols: [[
												{type: 'numbers',title: '操作'},
												{field: 'workTargetName', title: '关键任务名称',width:400,templet:function (d) {
														return '<select name="workTargetName">'+allTarget($('#tplTypeId').attr('tplTypeId'))+'</select>'
													}},
												{field: 'pretaskItemType', title: '类型',templet:function (d) {
														return '  <select name="pretaskItemType">' +
																'        <option value=""></option>' +
																'        <option value="FS">完成-开始(FS)</option>' +
																'        <option value="SS">开始-开始(SS)</option>' +
																'        <option value="FF">完成-完成(FF)</option>' +
																'        <option value="SF">开始-完成(SF)</option>' +
																'      </select>'
													}},
												{field: 'extendDates', title: '延隔时间（天）',templet:function (d) {
														return '<input type="text" preTgId="'+(d.preTgId || '')+'" oninput = "value=value.replace(/[^\\d]/g,\'\')" name="extendDates" class="layui-input" style="height: 100%;" value="'+(d.extendDates || 0)+'">'
													}},
												{align:'center', toolbar: '#barDemo',title: '操作'}
											]],
											done:function (res) {
												/*防止下拉框显示不全*/
												$('#preTaskTable').next().find(".layui-table-body, .layui-table-box, .layui-table-cell").css('overflow','visible');

												//回显下拉框数据
												var $tr=$('#preTaskTable').next().find('.layui-table-body tr')
												//判断编辑前是否有数据
												if(datas.preTargetList){
													datas.preTargetList.forEach(function (v,i) {
														selectData[i]={
															tgId:v.tgId,
															pretaskItemType:v.pretaskItemType,
														}
													})
												}
												$tr.each(function (index) {
													if(selectData[index]){
														$(this).find('select[name="workTargetName"]').val(selectData[index].tgId)
														$(this).find('select[name="pretaskItemType"]').val(selectData[index].pretaskItemType)
														form.render()
													}
												})
											}
										});
                                    },
                                    yes: function (index) {
                                        var forceCheck
                                        if ($('input[name="forceCheck"]').prop('checked')) {
                                            forceCheck = 1
                                        } else {
                                            forceCheck = 0
                                        }
										/*var controlLevel
										if ($('input[name="controlLevel"]').prop('checked')) {
											controlLevel = 1
										} else {
											controlLevel = 0
										}*/
										/*************************************************前置任务保存Start***********************************************************/
										var arr = []
										var $tr=$('#preTaskTable').next().find('.layui-table-body tr')
										$tr.each(function () {
											if ($(this).find('select[name="workTargetName"]').val() && $(this).find('select[name="pretaskItemType"]').val() && $(this).find('input[name="extendDates"]').val()) {
												var obj = {}
												obj.tgId = $(this).find('select[name="workTargetName"]').val()
												obj.workTargetName = $(this).find('select[name="workTargetName"] option:selected').text()
												obj.pretaskItemType = $(this).find('select[name="pretaskItemType"]').val()
												obj.extendDates = $(this).find('input[name="extendDates"]').val()
												if($(this).find('input[name="extendDates"]').attr('preTgId')){
													obj.preTgId=$(this).find('input[name="extendDates"]').attr('preTgId')
												}
												arr.push(obj)
											}
										})
										var preTarget=''
										$.ajax({
											url: "/TemplateItem/insertPre",
											type: "post",
											dataType: "json",
											contentType: "application/json;charset=UTF-8",
											data:JSON.stringify(arr),
											async:false,
											success: function (res) {
												if (res.flag) {
													preTarget=res.obj1
												}
											}
										})
										/*************************************************前置任务保存End***********************************************************/
                                        $.ajax({
                                            url: "/TemplateItem/editTemplateById",
                                            type: "post",
                                            dataType: "json",
                                            data: {
                                                tgNo: $('#editTab input[name="tgNo"]').val(),
                                                tgName: $('#editTab input[name="tgName"]').val(),
                                                controlLevel: $('#editTab select[name="controlLevel"]').val(),
												tgGrade: $('#editTab select[name="tgGrade"]').val(),
                                                planStage: $('#editTab select[name="planStage"]').val(),
                                                tgType: $('#editTab select[name="tgType"]').val(),
                                                resultDict: $('#editTab input[name="resultDict"]').attr('resultDict'),
                                                resultStandard: $('#editTab [name="resultStandard"]').val(),
                                                mainCenterDept: $('#mainCenterDept').attr('deptid'),
                                                mainAreaDept: $('#mainAreaDept').val(),
                                                mainProjectDept: $('#mainProjectDept').val(),
                                                tgId: tgId,
                                                forceCheck: forceCheck,
												centerDuty: $('#editTab input[name="centerDuty"]').val(),
												areaDuty: $('#editTab input[name="areaDuty"]').val(),
												projectDuty: $('#editTab input[name="projectDuty"]').val(),
												areaDutyType:$('#editTab select[name="areaDutyType"]').val(),
												centerDutyType:$('#editTab select[name="centerDutyType"]').val(),
												preTarget:preTarget
                                            },
                                            success: function (res) {
                                                if (res.flag) {
                                                	//清空下拉框数据
													selectData={}
                                                    $.layerMsg({content: "保存成功", icon: 1}, function () {
                                                        // window.location.reload();
                                                        layer.close(index)
                                                        questionTable.config.where._ = new Date().getTime();
                                                        questionTable.reload()
                                                    })
                                                }
                                            }
                                        })
                                    },
									btn2: function(index, layero){
										//清空下拉框数据
										selectData={}
									},
									cancel: function(index, layero){
										//清空下拉框数据
										selectData={}
									},
								})
                            })

                            break;
                        case 'import':
                            layer.open({
                                type: 1,
                                area: ['45%', '60%'], //宽高
                                title: '导入关键任务',
                                maxmin: true,
                                btn: ['保存', '退出'],
                                content: '<div style="margin: 20px auto;">' +
                                    '<form class="layui-form" action="">\n' +
									/*筛选条件*/
									'  <div class="layui-form-item">\n' +
									'    <label class="layui-form-label">目标等级</label>\n' +
									'    <div class="layui-input-block">\n' +
									'      <select name="tgGrade" lay-filter="tgGrade">' +
									'			<option value="">请选择</option>'+
									'      </select>\n' +
									'    </div>\n' +
									'  </div>'+
                                    '<span style="text-align: center;display: inherit;font-size: 17px;">关键任务名称</span>\n' +
                                    '<div class="layui-form-item">' +
                                    '<div class="layui-input-block workIds" style="margin-left: 40px;">' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>',
                                success: function () {
									$('select[name="tgGrade"]').append(dictionaryObj['TG_GRADE']['str']);
                                    $.ajax({
                                        url: '/WorkItem/seldWorkItem',
                                        data: {
                                            useFlag: false,
											warehousingYn:1
                                        },
                                        dataType: 'json',
                                        success: function (res) {
                                            var str = ''
                                            for (var i = 0; i < res.obj.length; i++) {
                                                str += '<input type="checkbox" lay-skin="primary" id="' + res.obj[i].tgId + '" title="' + res.obj[i].tgName + '"><br/>'
                                            }
                                            $('.workIds').html(str)
                                            form.render();
                                        }
                                    })
									form.on('select(tgGrade)', function(data){
										// console.log(data.value); //得到被选中的值
										$.get('/WorkItem/seldWorkItem',{useFlag:false,warehousingYn:1,tgGrade:data.value},function (res) {
											var str = ''
											for (var i = 0; i < res.obj.length; i++) {
												str += '<input type="checkbox" lay-skin="primary" id="' + res.obj[i].tgId + '" title="' + res.obj[i].tgName + '"><br/>'
											}
											$('.workIds').html(str)
											form.render();
										})
									});

//
                                },
                                yes: function (index, layero) {
                                    var workIds = new Array();
                                    $('form input[type=checkbox]:checked').each(function () {
                                        workIds.push(parseInt($(this).attr('id')));
                                    });
                                    $.ajax({
                                        url: '/TemplateItem/initializeTemplate',
                                        data: {
                                            workIds: workIds,
                                            tplTypeId: $('#addPlan').attr('tplTypeId')
                                        },
                                        traditional: true,
                                        dataType: 'json',
                                        success: function (res) {
                                            if (res.flag) {
                                                layer.msg("导入成功", {icon: 1})
                                                layer.close(index);
                                                questionTable.reload({})
                                            }
                                        }
                                    })
                                }
                            });
                            break;
                        case 'del':
                            if (!checkStatus.data.length) {
                                layer.msg('请至少选择一项！', {icon: 0});
                                return false
                            }
                            var tgId = []
                            checkStatus.data.forEach(function (v, i) {
                                tgId.push(v.tgId)
                            })
                            // console.log(projectId)
                            layer.confirm('确定删除该条数据吗？', function (index) {
                                // console.log(projectId);
                                $.ajax({
                                    url: '/TemplateItem/delTemplateById',
                                    dataType: 'json',
                                    type: 'post',
                                    data: {tgId: tgId},
                                    traditional: true,
                                    success: function (res) {
                                        if (res.flag) {
                                            layer.msg('删除成功！', {icon: 1});
                                        } else {
                                            layer.msg('删除失败！', {icon: 0});
                                        }
                                        layer.close(index)
                                        questionTable.config.where._ = new Date().getTime();
                                        questionTable.reload()
                                    }
                                })
                            });
                            break;
						case 'forceCheck':
							if (!checkStatus.data.length) {
								layer.msg('请至少选择一项！', {icon: 0});
								return false
							}
							var tgId = []
							checkStatus.data.forEach(function (v, i) {
								tgId.push(v.tgId)
							})
							// console.log(projectId)
							layer.confirm('确定强制勾选吗？', function (index) {
								// console.log(projectId);
								$.ajax({
									url: '/TemplateItem/upCheck',
									dataType: 'json',
									type: 'post',
									data: {tgId: tgId,forceCheck:1},
									traditional: true,
									success: function (res) {
										if (res.flag) {
											layer.msg('保存成功！', {icon: 1});
										} else {
											layer.msg('保存失败！', {icon: 0});
										}
										layer.close(index)
										questionTable.config.where._ = new Date().getTime();
										questionTable.reload()
									}
								})
							});
							break;
                    }
                });
				//内部上方按钮显示
				table.on('toolbar(preTaskTable)', function (obj) {
					switch (obj.event) {
						case 'add':
							//遍历表格获取每行数据进行保存
							var $tr=$('#preTaskTable').next().find('tbody tr')
							var oldDataArr=[]
							$tr.each(function (index) {
								var oldDataObj={
									workTargetName:$(this).find('select[name="workTargetName"]').val(),
									pretaskItemType:$(this).find('select[name="pretaskItemType"]').val(),
									extendDates:$(this).find('input[name="extendDates"]').val(),
									preTgId:$(this).find('input[name="extendDates"]').attr('preTgId')
								}
								oldDataArr.push(oldDataObj)
								//用于保存下拉框数据
								selectData[index]={
									tgId:$(this).find('select[name="workTargetName"]').val(),
									pretaskItemType:$(this).find('select[name="pretaskItemType"]').val(),
								}
							})
							var addRowData = {};
							oldDataArr.push(addRowData);
							table.reload('preTaskTable', {
								data: oldDataArr
							});
							break;
					}
				});
				//内部删行操作
				table.on('tool(preTaskTable)', function(obj) {
					var data = obj.data;
					var layEvent = obj.event;
					var tr = obj.tr;
					if(layEvent === 'del'){
						obj.del();
						if(data.preTgId){
							$.post('/TemplateItem/delPre',{preTgId:data.preTgId},function (res) {
							})
						}
						//遍历表格获取每行数据进行保存
						var $tr=$('#preTaskTable').next().find('tbody tr')
						var oldDataArr=[]
						$tr.each(function (index) {
							var oldDataObj={
								workTargetName:$(this).find('select[name="workTargetName"]').val(),
								pretaskItemType:$(this).find('select[name="pretaskItemType"]').val(),
								extendDates:$(this).find('input[name="extendDates"]').val(),
								preTgId:$(this).find('input[name="extendDates"]').attr('preTgId')
							}
							oldDataArr.push(oldDataObj)
							//用于保存下拉框数据
							selectData[index]={
								tgId:$(this).find('select[name="workTargetName"]').val(),
								pretaskItemType:$(this).find('select[name="pretaskItemType"]').val(),
							}
						})
						table.reload('preTaskTable', {
							data: oldDataArr
						});
					}
				});
                $('.clear').on("click",function () {
                    $('input').val('');
                    $('select').val('');
                    form.render();
                });
                var eleTreeLeft = eleTree.render({
                    elem: '#questionTree'  //绑定元素
                    , url: '/TemplateType/findAllType',
                    showCheckbox: false,
                    showLine: true,
                    request: { // 修改数据为组件需要的数据
                        name: "typeName", // 显示的内容
                        key: "parentTypeId", // 节点id
                        parentId: 'parentTypeId', // 节点父id
                        isLeaf: "isLeaf",// 是否有子节点
                        children: 'son',
                    },
                    response: { // 修改响应数据为组件需要的数据
                        statusName: "flag",
                        statusCode: true,
                        dataName: "object"
                    }
                    , highlightCurrent: true,
                });

                var questionTable = table.render({
                    elem: '#questionTable'
                    , url: '/TemplateItem/findTemplateByTypeId'
                    , where: {
                        useFlag: true
                    }
                    , page: true //开启分页
                    , limit: 50
                    , height: 'full-180'
                    , toolbar: '#toolbar'
                    , defaultToolbar: ['']
                    , cols: [[ //表头
                        {type: 'checkbox'}
                        , {type: 'numbers', title: '序号',}
                        , {field: 'tgNo', title: '关键任务编号', width: 200}
                        , {field: 'tgName', title: '关键任务名称', event: 'detail', style: 'cursor: pointer;', width: 350}
                        , {
                            field: 'controlLevel', title: '关注等级', width: 150, templet: function (d) {
								return dictionaryObj['CONTROL_LEVEL']['object'][d.controlLevel] || ''
                            }
                        }
						, {
							field: 'tgGrade', title: '目标等级', width: 150, templet: function (d) {
								return dictionaryObj['TG_GRADE']['object'][d.tgGrade] || ''
							}
						}
                        , {field: 'resultStandard', title: '完成标准', width: 250}
                        , {field: 'hardDegree', title: '标准难度系数', width: 100}
                        , {
                            field: 'resultDict', title: '成果标准模板', width: 250, templet: function (d) {
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
                            field: 'mainCenterDeptName', title: '中心责任部门', width: 250, templet: function (d) {
                                if (d.mainCenterDeptName) {
                                    return d.mainCenterDeptName.replace(/,$/, '')
                                } else {
                                    return ''
                                }
                            }
                        }
                        , {
                            field: 'mainAreaDept', title: '区域责任部门', width: 250, templet: function (d) {
                                return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainAreaDept] || ''
                            }
                        }
                        , {
                            field: 'mainProjectDept', title: '总承包部责任部门', width: 250, templet: function (d) {
                                return dictionaryObj['ORGANIZATION_TYPE']['object'][d.mainProjectDept] || ''
                            }
                        }
						, {field: 'centerDuty', title: '中心职责', width: 100}
						, {
							field: 'centerDutyType', title: '中心职责类型', width: 100, templet: function (d) {
								return dictionaryObj['DUTY_TYPE']['object'][d.centerDutyType] || ''
							}
						}
						, {field: 'areaDuty', title: '区域职责', width: 100}
						, {
							field: 'areaDutyType', title: '区域职责类型', width: 100, templet: function (d) {
								return dictionaryObj['DUTY_TYPE']['object'][d.areaDutyType] || ''
							}
						}
						, {field: 'projectDuty', title: '总承包部职责', width: 130}
                        , {
                            field: 'planStage', title: '计划阶段', width: 200, templet: function (d) {
                                return dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                            }
                        }
                        , {
                            field: 'tgType', title: '关键任务类型', width: 200, templet: function (d) {
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
                    ]], parseData: function (res) {
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
                    done: function () {
                        if ($('#tplTypeId').attr('disableYn') == 1) {
                            $('#import').css({
                                'cursor': 'not-allowed',
                                'background': '#C1C1C1'
                            })
                            $('#edit').css({
                                'cursor': 'not-allowed',
                                'background': '#C1C1C1'
                            })
                            $('#del').css({
                                'cursor': 'not-allowed',
                                'background': '#C1C1C1'
                            })
							$('#forceCheck').css({
								'cursor': 'not-allowed',
								'background': '#C1C1C1'
							})
                        }
                    }
                });

                function allUnSelect(database) {
                    $.each(database, function (index, item) {
                        item.checked = false;
                        if (item.children.length) {
                            $.each(item.children, function (index2, item2) {
                                if (item2.checked) {
                                    item2.checked = false;
                                }
                            })
                        }
                    })
                }

                // 节点点击事件
                eleTree.on("nodeClick(questionTree)", function (d) {
                    //1是启用，2是禁用
                    if (d.data.currentData.disableYn == 1) {
                        $('#isDisable').text('停用')
                        $('#tplTypeId').attr('disableYn', 2)
                    } else {
                        $('#isDisable').text('启用')
                        $('#tplTypeId').attr('disableYn', 1)
                    }
                    // console.log(d)
                    //所属上级
                    $('#tplTypeId').attr('tplTypeId', d.data.currentData.tplTypeId)
                    $('#tplTypeId').attr('names', d.data.currentData.typeName)
                    $('#addPlan').attr('tplTypeId', d.data.currentData.tplTypeId)
                    $('#editPlan').attr('parentTypeId', d.data.currentData.parentTypeId)
                    $('#editPlan').attr('tplTypeId', d.data.currentData.tplTypeId)
                    $('#editPlan').attr('typeNo', d.data.currentData.typeNo)
                    $('#editPlan').attr('tplType', d.data.currentData.tplType)
                    $('#editPlan').attr('typeName', d.data.currentData.typeName)
                    $('#editPlan').attr('tplTypeDesc', d.data.currentData.tplTypeDesc)
                    $('#editPlan').attr('level', d.data.currentData.level)
                    $('#delPlan').attr('tplTypeId', d.data.currentData.tplTypeId)
                    if (d.data.currentData.parentTypeId != 0) {
                        $('.layui-rt .rightHeight').show()
                        $('.tishi').hide()
                        questionTable.reload({
                            url: '/TemplateItem/findTemplateByTypeId'
                            , where: {
                                typeId: d.data.currentData.tplTypeId,
                                useFlag: true,
                                _: new Date().getTime()
                            }
                        })
                    } else {
                        $('.layui-rt .rightHeight').hide()
                        $('.tishi').show()
                    }
                });
                //条件查询
                $('.search').on("click",function () {
                    questionTable.reload({
                        url: '/TemplateItem/selTemplate',
                        where: {
                            tgName: $('.tgName').val(),
                            tplType: $('.dictName').val(),
                            useFlag: true,
                            _: new Date().getTime()
                        }
                    })
                })
                //删除树
                $('#delPlan').on("click",function () {
                    var tplTypeId = $(this).attr('tplTypeId')
                    layer.confirm('确定删除该模板吗？', function (index) {
                        $.ajax({
                            url: '/TemplateType/delById',
                            dataType: 'json',
                            type: 'post',
                            data: {
                                tplTypeId: tplTypeId
                            },
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('删除成功！', {icon: 1});
                                    // layer.close(index)
                                    eleTreeLeft.reload()
                                } else {
                                    layer.msg('删除失败！', {icon: 2});
                                }
                            }
                        })
                    });
                })
                //新建/编辑树
                $('.plan').on("click",function () {
                    var title = '';
                    if ($(this).text() == '新建') {
                        title = '新建模板'
                    } else {
                        var tplTypeId = $('#editPlan').attr('tplTypeId');
                        var typeNo = $('#editPlan').attr('typeNo');
                        var tplType = $('#editPlan').attr('tplType');
                        var typeName = $('#editPlan').attr('typeName');
                        var tplTypeDesc = $('#editPlan').attr('tplTypeDesc');
                        var level = $('#editPlan').attr('level');
                        title = '修改模板'
                    }
                    layer.open({
                        type: 1,
                        title: title,
                        area: ['520px', '450px'],
                        btn: ['保存', '退出'],
                        content: '<div style="padding: 20px;">' +
                            '<form class="layui-form" action="" lay-filter="example">' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label">编号<b style="color: red">*</b></label>' +
                            ' <div class="layui-input-block">' +
                            ' <input type="text" name="typeNo" lay-verify="title" autocomplete="off"  class="layui-input testNull" title="编号" readonly style="background:#e7e7e7;">' +
                            ' </div>' +
                            ' </div>' +
                            ' <div class="layui-form-item">' +
                            ' <label class="layui-form-label">模板名称<b style="color: red">*</b></label>' +
                            '<div class="layui-input-block">' +
                            '<input type="type" name="typeName" autocomplete="off" class="layui-input testNull" title="模板名称" >' +
                            ' </div>' +
                            ' </div>' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label">模板类型<b style="color: red">*</b></label>' +
                            ' <div class="layui-input-block">' +
                            '  <select name="tplType" id="tplType" lay-filter="tplType" class="testNull" title="模板类型">' +
                            '   <option value="">请选择</option>' +
                            ' </select>' +
                            ' </div>' +
                            ' </div>' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label">所属上级<b style="color: red">*</b></label>' +
                            ' <div class="layui-input-block">' +
                            '<input type="type" name="parentName" autocomplete="off" class="layui-input testNull" title="所属上级" readonly style="background:#e7e7e7;">' +
                            ' </div>' +
                            ' </div>' +
                            '<div class="layui-form-item">' +
                            '<label class="layui-form-label" style="padding: 0;width: 100px;">模板类型描述</label>' +
                            ' <div class="layui-input-block">' +
                            '<textarea type="type" style="height: 60px" name="tplTypeDesc" autocomplete="off" class="layui-input"></textarea>' +
                            ' </select>' +
                            ' </div>' +
                            ' </div>' +
							' <div class="layui-form-item">' +
							' <label class="layui-form-label">初始化层级<b style="color: red">*</b></label>' +
							'<div class="layui-input-block">' +
							'<input type="number" name="level" autocomplete="off" class="layui-input testNull" title="初始化层级" >' +
							' </div>' +
							' </div>' +
                            '</form></div>'
                        , success: function () {
                            //编号
                            if (title == '新建模板') {
                                $.get('/ProjectInfo/getMaxNo', {model: 'templateType'}, function (res) {
                                    $('input[name="typeNo"]').val(res)
                                })
                            }
                            //项目类型
                            $.ajax({
                                url: '/ProjectInfo/selectProjectTypeByNo',
                                dataType: 'json',
                                type: 'get',
                                success: function (res) {
                                    var obj = res.data
                                    var str = ''
                                    for (var i = 0; i < obj.length; i++) {
                                        str += '<option value="' + obj[i].dictId + '">' + obj[i].dictName + '</option>'
                                    }
                                    $('[name="tplType"]').append(str)
                                    // if (tplTypeId != '' && tplTypeId != undefined) {
                                    if (title == '修改模板') {
                                        $('[name="typeNo"]').val(typeNo);
                                        $('[name="typeName"]').val(typeName);
                                        $('[name="tplTypeDesc"]').text(tplTypeDesc);
                                        $('#tplType').val(tplType)
										$('[name="level"]').val(level);
                                    }
                                    form.render('select');
                                }
                            });
                            if (title == '新建模板') {
                                //所属上级
                                var tplTypeId
                                if ($('#tplTypeId').attr('tplTypeId') && $('.eleTree-node-content-active').length == 1) {
                                    tplTypeId = $('#tplTypeId').attr('tplTypeId')
                                } else {
                                    tplTypeId = 0
                                }
                                $.get('/TemplateType/selectNameByParentId', {tplTypeId: tplTypeId}, function (res) {
                                    $('input[name="parentName"]').val(res.data)
                                })
                            } else if (title == '修改模板') {
                                var parentTypeId = $('#editPlan').attr('parentTypeId')
                                $.get('/TemplateType/selectNameByParentId', {tplTypeId: parentTypeId}, function (res) {
                                    $('input[name="parentName"]').val(res.data)
                                })
                            }

                        }, yes: function (index) {
                            //必填项提示
                            for (var i = 0; i < $('.testNull').length; i++) {
                                if ($('.testNull').eq(i).val() == '') {
                                    layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                                    return false
                                }
                            }
                            var url = ''
                            if (tplTypeId != '' && tplTypeId != undefined) {
                                url = '/TemplateType/updateById'
                            } else {
                                url = '/TemplateType/insertType'
                            }
                            var data;
                            if ($('#addPlan').attr('tplTypeId') != '' && $('#addPlan').attr('tplTypeId') !== undefined && title == '修改模板') {
                                data = {
                                    tplTypeId: $('#addPlan').attr('tplTypeId'),
                                    typeNo: $('[name="typeNo"]').val(),
                                    typeName: $('[name="typeName"]').val(),
                                    tplType: $('[name="tplType"]').val(),
                                    tplTypeDesc: $('[name="tplTypeDesc"]').val(),
									level: $('[name="level"]').val()
                                }
                            } else if ($('#addPlan').attr('tplTypeId') != '' && $('#addPlan').attr('tplTypeId') !== undefined && title == '新建模板') {
                                data = {
                                    parentTypeId: $('#addPlan').attr('tplTypeId'),
                                    typeNo: $('[name="typeNo"]').val(),
                                    typeName: $('[name="typeName"]').val(),
                                    tplType: $('[name="tplType"]').val(),
                                    tplTypeDesc: $('[name="tplTypeDesc"]').val(),
									level: $('[name="level"]').val()
                                }
                            } else {
                                data = {
                                    typeNo: $('[name="typeNo"]').val(),
                                    typeName: $('[name="typeName"]').val(),
                                    tplType: $('[name="tplType"]').val(),
                                    tplTypeDesc: $('[name="tplTypeDesc"]').val(),
									level: $('[name="level"]').val()
                                }
                            }
                            $.ajax({
                                url: url,
                                dataType: 'json',
                                type: 'post',
                                data: data,
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('保存成功！', {icon: 1});
                                        layer.close(index)
                                        eleTreeLeft.reload()
                                    } else {
                                        layer.msg('保存失败！', {icon: 2});
                                    }
                                }
                            })
                        }

                    })

                });

				//前置关键任务的项目下所有关键任务
				function allTarget(typeId) {
					var allTarget = ''
					$.ajax({
						url: '/TemplateItem/findTemplateByTypeId',
						dataType: 'json',
						type: 'get',
						async: false,
						data: {
							typeId: typeId,
							useFlag:false
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

            })

            // 初始化页面操作权限
            function initAuthority() {
                // 是否设置页面权限
                if (authorityObject) {
                    // 检查查询权限
                    if (authorityObject['09']) {
                        $('.authority_search').show();
                    }
                    // 检查新增权限
                    if (authorityObject['01']) {
                        $('#addPlan').show();
                    }
                    // 检查修改权限
                    if (authorityObject['05']) {
                        $('#editPlan').show();
                    }
                    // 检查删除权限
                    if (authorityObject['04']) {
                        $('#delPlan').show();
                    }
                    // 检查停用权限
                    if (authorityObject['23']) {
                        $('#isDisable').show();
                    }
                }
            }

            function resizeSize() {
                $('#leftHeight').height($(window).height() - 160);
                $('.rightHeight').height($(window).height() - 140);
            }

		</script>

	</body>
</html>
