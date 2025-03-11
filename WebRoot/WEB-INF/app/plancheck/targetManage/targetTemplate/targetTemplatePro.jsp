<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/11/30
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<title>指标管理模板</title>
		
		<meta charset="utf-8">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js"></script>
		
		<style>
			html, body {
				width: 100%;
				height: 100%;
				background: #fff;
				overflow-x: hidden;
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
				padding: 0 20px;
				box-sizing: border-box;
			}
			
			.content {
				position: absolute;
				top: 45px;
				left: 0;
				right: 0;
				bottom: 0;
				padding: 10px 20px;
			}
			
			.con_left {
				position: relative;
				float: left;
				width: 230px;
				height: 100%;
			}
			
			#questionTree {
				position: absolute;
				top: 60px;
				right: 0;
				bottom: 20px;
				left: 0;
				
				margin-top: 10px;
				
				overflow: auto;
			}
			
			.con_right {
				position: relative;
				float: left;
				width: calc(100% - 230px);
				height: 100%;
				padding-left: 10px;
				box-sizing: border-box;
			}
			
			.con_right .layui-table-view {
				margin: 0;
			}
			
			/* 查询表单样式 START */
			.search_module {
				position: relative;
			}
			
			.query_item {
				float: left;
				width: 25%;
			}
			
			.search_form input, select {
				height: 35px;
			}
			
			.search_form .layui-form-label {
				width: 80px;
				height: 35px;
				padding: 0 10px;
				line-height: 35px;
				box-sizing: border-box;
			}
			
			.search_form .layui-form-item {
				height: 35px;
				margin: 0;
				clear: none;
			}
			
			.search_form .layui-input-block {
				margin-left: 80px;
			}
			
			.search_form .query_button_group {
				margin-top: 2px;
				padding-left: 20px;
				box-sizing: border-box;
			}
			
			.search_form .query_btn {
				float: right;
				width: 55px;
				margin-right: 20px;
				margin-left: 0;
			}
			
			/* 查询表单样式 EDN */
			
			.layui-table-tool {
				min-height: 38px;
				height: 38px;
				padding: 0;
				box-sizing: border-box;
			}
			
			.layui-table-tool-temp {
				padding: 3px 15px;
				height: 38px;
			}
			
			.con_right .layui-form-checkbox[lay-skin=primary] {
				top: 5px !important;
			}

			.workIds .layui-form-checkbox[lay-skin=primary]{
				height: 30px !important;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="template" value="">
			<div class="search_module">
				<form class="layui-form clearfix search_form" lay-filter="searchForm">
					<div class="clearfix" style="padding: 5px 0;">
						<div class="layui-form-item query_item">
							<label class="layui-form-label">模板名称:</label>
							<div class="layui-input-block">
								<input type="text" name="tempName" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item query_item">
							<label class="layui-form-label" style="line-height: normal;">一级指标类型:</label>
							<div class="layui-input-block">
								<select name="tempTypeParent" lay-filter="tempTypeParent">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
						<div class="layui-form-item query_item">
							<label class="layui-form-label" style="line-height: normal;">二级指标类型:</label>
							<div class="layui-input-block">
								<select name="tempType">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
						<div class="query_button_group query_item">
							<button type="button" id="searchBtn" class="layui-btn layui-btn-sm">查询</button>
							<button type="reset" id="resetBtn" class="layui-btn layui-btn-sm">重置</button>
						</div>
					</div>
				</form>
			</div>
			<div class="content">
				<div class="con_left">
					<div style="margin-bottom:10px">
						<button type="button" class="layui-btn layui-btn-sm plan" is_add="1" id="addPlan">新建</button>
						<button type="button" class="layui-btn layui-btn-sm plan" is_add="2" id="editPlan">修改</button>
						<button type="button" class="layui-btn layui-btn-sm " id="delPlan">删除</button>
						<button type="button" class="layui-btn layui-btn-sm " id="isDisable">停用</button>
					</div>
					<span style="text-align: center;display: block;font-weight: bold;cursor: pointer;" class="question">指标管理模板</span>
					<%--项目机构和项目信息--%>
					<div id="questionTree" lay-filter="questionTree" class="eleTree" style="overflow-x: auto;margin-top: 10px;"></div>
				</div>
				<div class="con_right">
					<div class="tishi" style="height: 100%;text-align: center;border: none;">
						<div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
						<h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧指标管理模板</h2>
					</div>
					<div class="question_table" style="height: 100%; padding-left: 10px; display: none">
						<table id="questionTable" lay-filter="questionTable"></table>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="toolbar">
			<div style="float: right;margin-left: 10px;">
				<a class="layui-btn layui-btn-sm" lay-event="add" id="add">新增</a>
				<a class="layui-btn layui-btn-sm" lay-event="forceCheck" id="forceCheck">强制勾选</a>
				<a class="layui-btn layui-btn-sm" lay-event="import" id="import">导入</a>
				<a class="layui-btn layui-btn-sm" lay-event="edit" id="edit">修改</a>
				<a class="layui-btn layui-btn-sm" lay-event="del" id="del">删除</a>
			</div>
		</script>
		
		<script>
            var dictionaryObj = {
                INDICATOR_TYPE: {},
                INDICATOR_TYPE_PARENT: {}
            }
            var indicatorType = []
            var dictionaryStr = 'INDICATOR_TYPE,INDICATOR_TYPE_PARENT';
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: '<option value="">请选择</option>'}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                if (dict == 'INDICATOR_TYPE') {
                                    indicatorType.push(item)
                                }
                            })
                        }
                    }
                }
                initPage()
            })

            function initPage() {
                layui.use(['eleTree', 'table', 'layer', 'form', 'xmSelect'], function () {
                    var layer = layui.layer,
                        layuiForm = layui.form,
                        layuiTable = layui.table,
                        xmSelect = layui.xmSelect,
                        eleTree = layui.eleTree,
					    table = layui.table;

                    $('.search_form [name="tempTypeParent"]').html(dictionaryObj['INDICATOR_TYPE_PARENT']['str'])

                    layuiForm.on('select(tempTypeParent)', function (data) {
                        var vaule = data.value
                        if (indicatorType.length > 0) {
                            var str = '<option value="">请选择</option>'
                            indicatorType.forEach(function (item) {
                                if (item.facility == vaule) {
                                    str += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                }
                            })
                            $('.search_form [name="tempType"]').html(str)
                            layuiForm.render('select')
                        }
                    })

                    layuiForm.render()

                    var eleTreeLeft = eleTree.render({
                        elem: '#questionTree',  //绑定元素
                        url: '/TargetTemplateType/findAllType',
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
                        },
                        highlightCurrent: true,
                    })

                    var questionTable = layuiTable.render({
                        elem: '#questionTable',
                        url: '/TargetTemplate/findTemplateByTypeId',
                        where: {
                            useFlag: true
                        },
                        page: true, //开启分页
                        limit: 50,
                        height: 'full-100',
                        toolbar: '#toolbar',
                        defaultToolbar: [''],
                        cols: [[
                            {type: 'checkbox', fixed: 'left'},
                            {field: 'tempId', title: '序号'},
                            {field: 'tempNo', title: '指标编号', width: 200},
							{
								field: 'tempTypeParent', title: '一级指标类型', width: 120, templet: function (d) {
									return dictionaryObj['INDICATOR_TYPE_PARENT']['object'][d.tempTypeParent] || ''
								}
							},
							{
								field: 'tempType', title: '二级指标类型', width: 120, templet: function (d) {
									return dictionaryObj['INDICATOR_TYPE']['object'][d.tempType] || ''
								}
							},
                            {field: 'tempName', title: '指标名称', event: 'detail', style: 'cursor: pointer;', width: 130},
							{field: 'itemWeight',edit:'text', title: '分项权重', width: 100,
								templet:function(d){
								if (d.itemWeight==undefined){
									return "";
								} else {
									return d.itemWeight+'%';
								}
								}},
							{field: 'individualWeight',edit:'text', title: '单项权重', width: 100
								,templet:function (d) {
								if (d.individualWeight == undefined){
									return "";}
								else {
									return d.individualWeight+'%';
								}
								}},
							{field: 'individualScore',edit:'text', title: '单项分值', width: 100},
                            {field: 'tempDesc', title: '指标说明', width: 350},
                            {field: 'sourcesDeptName', title: '数据来源部门', width: 100},
                            {field: 'checkDeptName', title: '数据复核部门', width: 100},
                            {
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
                        ]],
                        parseData: function (res) {
                            return {
                                "code": 0, //解析接口状态
                                "data": res.obj,//解析数据列表
                                "count": res.totleNum, //解析数据长度
                            }
                        },
                        request: {
                            pageName: 'page', //页码的参数名称，默认：page
                            limitName: 'pageSize' //每页数据量的参数名，默认：limit
                        },
                        done: function () {
                            if ($('#typeId').attr('disableYn') == 1) {
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
                    })

                    // 点击查询
                    $('#searchBtn').click(function () {
                        var templateData = $('#template').get(0).data

                        if (templateData && templateData.parentTypeId != 0) {
                            var $selectEle = $('.search_form [name]');

                            var searchData = {
                                typeId: templateData.typeId,
                                useFlag: true,
                                _: new Date().getTime()
                            }

                            $selectEle.each(function () {
                                var key = $(this).attr('name')
                                var value = $(this).val()
                                searchData[key] = value
                            })

                            questionTable.reload({
                                where: searchData,
                                page: {
                                    curr: 1
                                }
                            })
                        }
                    })

                    // 节点点击事件
                    eleTree.on("nodeClick(questionTree)", function (d) {
                        var data = d.data.currentData
                        // 1是启用，2是禁用
                        if (data.disableYn == 1) {
                            $('#isDisable').text('停用')
                        } else {
                            $('#isDisable').text('启用')
                        }

                        $('#template').get(0).data = data
                        $('#template').val(data.typeId)

                        if (data.parentTypeId != 0) {
                            $('.question_table').show()
                            $('.tishi').hide()
                            questionTable.reload({
                                where: {
                                    typeId: data.typeId,
                                    useFlag: true,
                                    _: new Date().getTime()
                                },
                                page: {
                                    curr: 1
                                }
                            })
                        } else {
                            $('.question_table').hide()
                            $('.tishi').show()
                        }
                    })
                    // 新建/编辑树
                    $('.plan').click(function () {
                        var btnType = $(this).attr('is_add')
                        var title = '';
                        var templateData = null
                        var parentType = null
                        // 判断新增还是修改
                        if (btnType == '1') {
                            title = '新建模板'
                        } else {
                            title = '修改模板'
                            templateData = $('#template').get(0).data

                            if (!templateData) {
                                layer.msg('请选择需要修改的模板', {icon: 0, time: 1500})
                                return false
                            }
                        }
                        layer.open({
                            type: 1,
                            title: title,
                            area: ['600px', '480px'],
                            btn: ['保存', '退出'],
                            content: ['<div style="padding: 20px;">' +
                            '<form class="layui-form" id="editForm" lay-filter="example">',
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
                                '  <select name="tplType" lay-filter="tplType" class="testNull" title="模板类型">' +
                                '   <option value="">请选择</option>' +
                                ' </select>' +
                                ' </div>' +
                                ' </div>' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label">所属上级</label>' +
                                ' <div class="layui-input-block">' +
                                '<div id="parentTypeId" class="xm-select-demo" style="width: 100%;"></div>' +
                                ' </div>' +
                                ' </div>' +
                                '<div class="layui-form-item">' +
                                '<label class="layui-form-label" style="padding: 0;width: 100px;">模板类型描述</label>' +
                                ' <div class="layui-input-block">' +
                                '<textarea name="tplTypeDesc" rows="3" class="layui-textarea"></textarea>' +
                                ' </select>' +
                                ' </div>' +
                                ' </div>',
                                '</form></div>'].join(''),
                            success: function () {
                                // 获取项目类型
                                $.get('/ProjectInfo/selectProjectTypeByNo', function (res) {
                                    $.get('/TargetTemplateType/findAllType', function (res) {
                                        var parentTypeArr = initTreeData(res.object, (templateData ? templateData.typeId : ''))

                                        parentType = xmSelect.render({
                                            el: '#parentTypeId',
                                            tree: {
                                                show: true,
                                                strict: false,
                                                expandedKeys: [-1],
                                            },
                                            toolbar: {
                                                show: false,
                                            },
                                            name: 'parentTypeId',
                                            prop: {
                                                name: 'typeName',
                                                value: 'typeId',
                                                children: 'child'
                                            },
                                            on: function (data) {
                                                if (data.isAdd) {
                                                    return data.change.slice(0, 1)
                                                }
                                            },
                                            data: parentTypeArr
                                        })

                                        if (btnType == '1') {
                                            var parentTypeId = $('#template').val()
                                            parentType.setValue([parentTypeId]);
                                            // 新建模板，获取编号
                                            $.get('/ProjectInfo/getMaxNo', {model: 'templateTargetType'}, function (res) {
                                                $('#editForm [name="typeNo"]').val(res)
                                            })
                                        } else if (btnType == '2') {
                                            $('#editForm [name="typeNo"]').val(templateData.typeNo);
                                            $('#editForm [name="typeName"]').val(templateData.typeName);
                                            $('#editForm [name="tplTypeDesc"]').text(templateData.tplTypeDesc);
                                            $('#editForm [name="tplType"]').val(templateData.tplType)
                                            var parentTypeId = templateData.parentTypeId == 0 ? '' : templateData.parentTypeId
                                            parentType.setValue([parentTypeId]);
                                        }
                                    })

                                    var obj = res.data
                                    var str = ''
                                    for (var i = 0; i < obj.length; i++) {
                                        str += '<option value="' + obj[i].dictId + '">' + obj[i].dictName + '</option>'
                                    }
                                    $('[name="tplType"]').html(str)

                                    layuiForm.render('select');
                                })
                            },
                            yes: function (index) {
                                // 必填项提示
                                var $testEles = $('.testNull')
                                for (var i = 0; i < $testEles.length; i++) {
                                    if ($testEles.eq(i).val() == '') {
                                        layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                                        return false
                                    }
                                }

                                var $dataEle = $('#editForm [name]');

                                var data = {};

                                $dataEle.each(function () {
                                    var key = $(this).attr('name')
                                    var value = $(this).val()
                                    data[key] = value
                                })
                                data.parentTypeId = data.parentTypeId ? data.parentTypeId : 0
                                var url = ''
                                if (btnType == '2') {
                                    url = '/TargetTemplateType/updateById'
                                    data.typeId = templateData.typeId
                                } else {
                                    url = '/TargetTemplateType/insertType'
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
                    })
                    // 删除树
                    $('#delPlan').click(function () {
                        var typeId = $('#template').val()
                        if (!typeId) {
                            layer.msg('请选择需要删除的模板', {icon: 0, time: 1500})
                            return false
                        }
                        layer.confirm('确定删除该模板吗？', function (index) {
                            $.ajax({
                                url: '/TargetTemplateType/delById',
                                dataType: 'json',
                                type: 'post',
                                data: {
                                    typeId: typeId
                                },
                                success: function (res) {
                                    if (res.flag) {
                                        layer.msg('删除成功！', {icon: 1, time: 1500})
                                        eleTreeLeft.reload()
                                    } else {
                                        layer.msg('删除失败！', {icon: 2, time: 1500})
                                    }
                                }
                            })
                        });
                    })
                    // 点击停用/启用
                    $('#isDisable').click(function () {
                        var typeData = $('#template').get(0).data
                        if (!typeData) {
                            layer.msg('请选择需要操作的模板', {icon: 0, time: 1500})
                            return false
                        }
                        var disableYn = typeData.disableYn == 1 ? 2 : 1
                        layer.confirm('确定' + $(this).text() + '&nbsp;&nbsp;' + typeData.typeName + '&nbsp;&nbsp;' + '吗？', function (index) {
                            $.ajax({
                                type: 'post',
                                url: '/TargetTemplateType/updateById',
                                data: {typeId: typeData.typeId, disableYn: disableYn},
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

                    layuiTable.on('toolbar(questionTable)', function (obj) {
                        var checkStatus = layuiTable.checkStatus(obj.config.id)
                        var templateData = $('#template').get(0).data
                        if (templateData.disableYn == 2) {
                            layer.msg('请先启用左侧模板!')
                            return false
                        }
                        if (obj.event == 'edit' && checkStatus.data.length != 1) {
                            layer.msg('请选择一项需要操作的数据!', {icon: 0, time: 1500})
                            return false
                        }
                        switch (obj.event) {
                            case 'edit':
                                if (checkStatus.data.length != 1) {
                                    layer.msg('请选择一项需要操作的数据!', {icon: 0, time: 1500})
                                    return false
                                }
                                var tempId = checkStatus.data[0].tempId
                                $.get('/TargetTemplate/findTemplateById', {tgId: tempId}, function (res) {
                                    var datas = res.object
                                    layer.open({
                                        type: 1,
                                        title: '修改指标管理模板',
                                        area: ['100%', '100%'],
                                        maxmin: true,
                                        btn: ['保存', '取消'],
                                        min: function () {
                                            $('.layui-layer-shade').hide()
                                        },
                                        content: ['<form lay-filter="updateForm" class="layui-form" id="editTab" style="padding: 0 10px">',
                                            '<div class="layui-row" style="margin-top: 30px;"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">序号<span style="color: red; font-size: 20px;">*</span></label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="text" name="tempId" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                                            '    </div>' +
                                            '</div></div></div>\n',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">指标编号<span style="color: red; font-size: 20px;">*</span></label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="text" name="tempNo" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong">\n' +
                                            '    </div>' +
                                            '</div></div></div>\n',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">指标名称</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="text" name="tempName" autocomplete="off" class="layui-input jinyong">\n' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">指标说明</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <textarea name="tempDesc" autocomplete="off" class="layui-textarea jinyong"></textarea>\n' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">一级指标</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '        <select name="tempTypeParent" lay-filter="tempTypeParent2"></select>' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">二级指标</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '        <select name="tempType"></select>' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">分项权重</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="text" name="itemWeight" autocomplete="off" class="layui-input jinyong"><span style=" position: absolute; top: 1%; right: 6%;color: #333; display: table-cell;white-space: nowrap; padding: 7px 10px;">%</span>\n\n' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">单项权重</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="text" name="individualWeight" autocomplete="off" class="layui-input jinyong"><span style=" position: absolute; top: 1%; right: 6%;color: #333; display: table-cell;white-space: nowrap; padding: 7px 10px;">%</span>\n\n' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label">单项分值</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="text" name="individualScore" autocomplete="off" class="layui-input jinyong">\n' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item">\n' +
                                            '    <label class="layui-form-label" style="width: 95px;padding-left: 0;">数据来源部门</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="text" name="sourcesDeptId" id="sourcesDeptId" class="layui-input" readonly style="background:#e7e7e7;height: 45px;text-indent:1em;border-radius: 4px;">' +
                                            '        <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
                                            '        <a href="javascript:;" style="color:red;margin-left:5px" class="deptDel">清空</a>\n' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row"> ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item" >\n' +
                                            '    <label class="layui-form-label" style="width: 95px;padding-left: 0;">数据复核部门</label>\n' +
                                            '    <div class="layui-input-block">\n' +
                                            '      <input type="text" name="checkDeptId" id="checkDeptId" class="layui-input" readonly style="background:#e7e7e7;height: 45px;text-indent:1em;border-radius: 4px;">' +
                                            '        <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
                                            '        <a href="javascript:;" style="color:red;margin-left:5px" class="deptDel">清空</a>\n' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '<div class="layui-row" > ' +
                                            '<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
                                            '<div class="layui-form-item">\n' +
                                            '    <label class="layui-form-label" style="width: 85px">是否强制勾选</label>\n' +
                                            '    <div class="layui-input-block" style="height: 36px;">\n' +
                                            '        <input type="checkbox" name="forceCheck" title="强制勾选" lay-skin="primary" >\n' +
                                            '    </div>' +
                                            '</div></div></div>',
                                            '</form>'].join(''),
                                        success: function () {
                                            $('#editTab [name="tempType"]').html(dictionaryObj['INDICATOR_TYPE']['str'])
                                            $('#editTab [name="tempTypeParent"]').html(dictionaryObj['INDICATOR_TYPE_PARENT']['str'])

                                            if (datas.forceCheck == 1) {
                                                $('#editTab [name="forceCheck"]').prop('checked', true)
                                            } else {
                                                $('#editTab [name="forceCheck"]').prop('checked', false)
                                            }

                                            layuiForm.val("updateForm", datas)
	                                        
	                                        $('#editTab [name="sourcesDeptId"]').val(datas.sourcesDeptName || '')
	                                        $('#editTab [name="sourcesDeptId"]').attr('deptid', datas.sourcesDeptId || '')
	                                        
	                                        $('#editTab [name="checkDeptId"]').val(datas.checkDeptName || '')
	                                        $('#editTab [name="checkDeptId"]').attr('deptid', datas.checkDeptId || '')

                                            layuiForm.render()

                                            layuiForm.on('select(tempTypeParent2)', function (data) {
                                                var vaule = data.value
                                                if (indicatorType.length > 0) {
                                                    var str = '<option value="">请选择</option>'
                                                    indicatorType.forEach(function (item) {
                                                        if (item.facility == vaule) {
                                                            str += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                                        }
                                                    })
                                                    $('#editTab [name="tempType"]').html(str)
                                                    layuiForm.render('select')
                                                }
                                            })
                                        },
                                        yes: function (index) {
                                            var forceCheck
                                            if ($('input[name="forceCheck"]').prop('checked')) {
                                                forceCheck = 1
                                            } else {
                                                forceCheck = 0
                                            }
                                            $.ajax({
                                                url: "/TargetTemplate/editTemplateById",
                                                type: "post",
                                                dataType: "json",
                                                data: {
                                                    tempId: $('#editTab [name="tempId"]').val(),
                                                    tempNo: $('#editTab [name="tempNo"]').val(),
													tempName: $('#editTab [name="tempName"]').val(),
                                                    tempDesc: $('#editTab [name="tempDesc"]').val(),
                                                    tempType: $('#editTab [name="tempType"]').val(),
													tempTypeParent: $('#editTab [name="tempTypeParent"]').val(),
                                                    itemWeight: $('#editTab [name="itemWeight"]').val(),
                                                    individualWeight: $('#editTab [name="individualWeight"]').val(),
                                                    individualScore: $('#editTab [name="individualScore"]').val(),
                                                    sourcesDeptId: $('#sourcesDeptId').attr('deptid').replace(/,$/, ''),
                                                    checkDeptId: $('#checkDeptId').attr('deptid').replace(/,$/, ''),
                                                    forceCheck: forceCheck
                                                },
                                                success: function (res) {
                                                    if (res.flag) {
                                                        $.layerMsg({content: "保存成功", icon: 1}, function () {
                                                            layer.close(index)
                                                            questionTable.config.where._ = new Date().getTime();
                                                            questionTable.reload()
                                                        })
                                                    }
                                                }
                                            })
                                        }
                                    })
                                })
                                break
							case 'add':
								insertTemplate(add);
								break;
                            case 'import':
                                layer.open({
                                    type: 1,
                                    area: ['45%', '60%'], //宽高
                                    title: '导入关键任务',
                                    maxmin: true,
                                    btn: ['保存', '退出'],
                                    content: '<div style="margin: 20px auto;">' +
                                        '<form class="layui-form">\n' +
                                        '<span style="text-align: center;display: inherit;font-size: 17px;">关键任务名称</span>\n' +
                                        '<div class="layui-form-item">' +
                                        '<div class="layui-input-block workIds" style="margin-left: 40px;">' +
                                        '</div>' +
                                        '</div>' +
                                        '</form></div>',
                                    success: function () {
                                        $.ajax({
                                            url: '/targetItem/getTarTempName',
                                            data: {
                                                useFlag: false,
                                                warehousingYn: 1
                                            },
                                            dataType: 'json',
                                            success: function (res) {
                                                var str = ''
                                                for (var i = 0; i < res.data.length; i++) {
                                                    str += '<input type="checkbox" lay-skin="primary" id="' + res.data[i].tempId + '" title="' + res.data[i].tempName + '"><br/>'
                                                }
                                                $('.workIds').html(str)
                                                layuiForm.render()
                                            }
                                        })
                                    },
                                    yes: function (index) {
                                        var workIds = new Array()
                                        $('form input[type=checkbox]:checked').each(function () {
                                            workIds.push(parseInt($(this).attr('id')))
                                        });
                                        $.ajax({
                                            url: '/TargetTemplate/initializeTemplate',
                                            data: {
                                                workIds: workIds,
                                                typeId: templateData.typeId
                                            },
                                            traditional: true,
                                            dataType: 'json',
                                            success: function (res) {
                                                if (res.flag) {
                                                    layer.msg("导入成功", {icon: 1, time: 1500})
                                                    layer.close(index)
                                                    questionTable.reload({})
                                                }
                                            }
                                        })
                                    }
                                });
                                break;
                            case 'del':
                                if (!checkStatus.data.length) {
                                    layer.msg('请至少选择一项！', {icon: 0})
                                    return false
                                }
                                var tgId = []
                                checkStatus.data.forEach(function (v, i) {
                                    tgId.push(v.tempId)
                                })
                                layer.confirm('确定删除该条数据吗？', function (index) {
                                    $.ajax({
                                        url: '/TargetTemplate/delTemplateById',
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
                                })
                                break
                            case 'forceCheck':
                                if (!checkStatus.data.length) {
                                    layer.msg('请至少选择一项！', {icon: 0});
                                    return false
                                }
                                var tgId = []
                                checkStatus.data.forEach(function (v, i) {
                                    tgId.push(v.tgId)
                                })
                                layer.confirm('确定强制勾选吗？', function (index) {
                                    $.ajax({
                                        url: '/TargetTemplate/upCheck',
                                        dataType: 'json',
                                        type: 'post',
                                        data: {tgId: tgId, forceCheck: 1},
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
                                break
                        }
                    })

					table.on('edit(questionTable)', function (obj) {
						var data = obj.data
						var field = obj.field

						var arr = []
						arr.push({
							tempId: data.tempId,
							[field]: obj.value
						})
						$.ajax({
							url: '/TargetTemplate/editTemplateByIds',
							data: JSON.stringify(arr),
							dataType: 'json',
							type: 'post',
							contentType: "application/json;charset=UTF-8",
							success: function (res) {
								if (res.flag) {
									//同步更新缓存对应的值
									obj.update({
										[field]: obj.value
									});
									layer.msg('修改成功')
								} else {
									layer.msg('修改失败')
								}
							}
						})

					});

					function insertTemplate(type){
						layer.open(
									{
										type: 1,
										title: '新增目标模板',
										area: ['80%', '70%'],
										maxmin:true,
										min: function(){
											$('.layui-layer-shade').hide()
										},
										btn:['确定','取消'],
										content:['<form lay-filter="updateForm" class="layui-form" id="editTab" style="padding: 0 10px">',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item" >\n' +
											'    <label class="layui-form-label">指标名称</label>\n' +
											'    <div class="layui-input-block">\n' +
											'      <input type="text" name="tempName" autocomplete="off" class="layui-input jinyong">\n' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item" >\n' +
											'    <label class="layui-form-label">指标说明</label>\n' +
											'    <div class="layui-input-block">\n' +
											'      <textarea name="tempDesc" autocomplete="off" class="layui-textarea jinyong"></textarea>\n' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item" >\n' +
											'    <label class="layui-form-label">一级指标</label>\n' +
											'    <div class="layui-input-block">\n' +
											'        <select name="tempTypeParent" lay-filter="tempTypeParent2"></select>' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item" >\n' +
											'    <label class="layui-form-label">二级指标</label>\n' +
											'    <div class="layui-input-block">\n' +
											'        <select name="tempType"></select>' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item" >\n' +
											'    <label class="layui-form-label">分项权重</label>\n' +
											'    <div class="layui-input-block">\n' +
											'      <input type="text" name="itemWeight" autocomplete="off" class="layui-input jinyong"><span style=" position: absolute; top: 1%; right: 6%;color: #333; display: table-cell;white-space: nowrap; padding: 7px 10px;">%</span>\n\n' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item" >\n' +
											'    <label class="layui-form-label">单项权重</label>\n' +
											'    <div class="layui-input-block">\n' +
											'      <input type="text" name="individualWeight" autocomplete="off" class="layui-input jinyong"><span style=" position: absolute; top: 1%; right: 6%;color: #333; display: table-cell;white-space: nowrap; padding: 7px 10px;">%</span>\n\n' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item" >\n' +
											'    <label class="layui-form-label">单项分值</label>\n' +
											'    <div class="layui-input-block">\n' +
											'      <input type="text" name="individualScore" autocomplete="off" class="layui-input jinyong">\n' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item">\n' +
											'    <label class="layui-form-label" style="width: 95px;padding-left: 0;">数据来源部门</label>\n' +
											'    <div class="layui-input-block">\n' +
											'      <input type="text" name="sourcesDeptId" id="sourcesDeptId" class="layui-input" readonly style="background:#e7e7e7;height: 45px;text-indent:1em;border-radius: 4px;">' +
											'        <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
											'        <a href="javascript:;" style="color:red;margin-left:5px" class="deptDel">清空</a>\n' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row"> ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item" >\n' +
											'    <label class="layui-form-label" style="width: 95px;padding-left: 0;">数据复核部门</label>\n' +
											'    <div class="layui-input-block">\n' +
											'      <input type="text" name="checkDeptId" id="checkDeptId" class="layui-input" readonly style="background:#e7e7e7;height: 45px;text-indent:1em;border-radius: 4px;">' +
											'        <a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="deptAdd">添加</a>\n' +
											'        <a href="javascript:;" style="color:red;margin-left:5px" class="deptDel">清空</a>\n' +
											'    </div>' +
											'</div></div></div>',
											'<div class="layui-row" > ' +
											'<div class="layui-col-xs6 layui-col-xs-offset3"> ' +
											'<div class="layui-form-item">\n' +
											'    <label class="layui-form-label" style="width: 85px">是否强制勾选</label>\n' +
											'    <div class="layui-input-block" style="height: 36px;">\n' +
											'        <input type="checkbox" name="forceCheck" title="强制勾选" lay-skin="primary" >\n' +
											'    </div>' +
											'</div></div></div>',
											'</form>'].join(''),
										success: function () {
											$('#editTab [name="tempType"]').html(dictionaryObj['INDICATOR_TYPE']['str'])
											$('#editTab [name="tempTypeParent"]').html(dictionaryObj['INDICATOR_TYPE_PARENT']['str'])

											layuiForm.render()

											layuiForm.on('select(tempTypeParent2)', function (data) {
												var vaule = data.value
												if (indicatorType.length > 0) {
													var str = '<option value="">请选择</option>'
													indicatorType.forEach(function (item) {
														if (item.facility == vaule) {
															str += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
														}
													})
													$('#editTab [name="tempType"]').html(str)
													layuiForm.render('select')
												}
											})
										},
										yes:function (index) {
											var templateData = $('#template').get(0).data;
											var sourcesDeptId=$('#sourcesDeptId').attr('deptid') ? $('#sourcesDeptId').attr('deptid').replace(/,$/, '') : ''
											var checkDeptId=$('#checkDeptId').attr('deptid') ? $('#checkDeptId').attr('deptid').replace(/,$/, '') : ''
											var forceCheck
											if ($('input[name="forceCheck"]').prop('checked')) {
												forceCheck = 1
											} else {
												forceCheck = 0
											}
											$.ajax({
												url: '/TargetTemplate/saveTemplate',
												type: "post",
												dataType: "json",
												data: {
													tempName: $('#editTab [name="tempName"]').val(),
													tempDesc: $('#editTab [name="tempDesc"]').val(),
													tempType: $('#editTab [name="tempType"]').val(),
													tempTypeParent: $('#editTab [name="tempTypeParent"]').val(),
													itemWeight: $('#editTab [name="itemWeight"]').val(),
													individualWeight: $('#editTab [name="individualWeight"]').val(),
													individualScore: $('#editTab [name="individualScore"]').val(),
													sourcesDeptId: sourcesDeptId,
													checkDeptId: checkDeptId ,
													forceCheck: forceCheck,
													typeId:templateData.typeId
												},
												success: function (res) {
													if (res.flag) {
														$.layerMsg({content: "保存成功", icon: 1}, function () {
															layer.close(index)
															questionTable.config.where._ = new Date().getTime();
															questionTable.reload()
														})
													}
												}
											})
										}
									}
							)
					}

                    // 选部门控件添加
                    $(document).on('click', '.deptAdd', function () {
                        var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
                        dept_id = $(this).siblings('input').attr('id');
                        $.popWindow("/common/selectDept" + chooseNum);
                    })
                    // 选部门控件删除
                    $(document).on('click', '.deptDel', function () {
                        var deptId = $(this).siblings('input').attr('id');
                        $('#' + deptId).val('');
                        $('#' + deptId).attr('deptid', '');
                    })
                })
            }

            // 处理编辑模板时上级模板去除自己和下级
            function initTreeData(data, filterId) {
                var newArr = []
                if (data && data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].typeId == filterId) {
                            continue
                        }
                        var obj = {
                            parentTypeId: data[i].parentTypeId,
                            typeId: data[i].typeId,
                            typeName: data[i].typeName,
                        }
                        if (data[i].son && data[i].son.length > 0) {
                            obj.child = initTreeData(data[i].son, filterId)
                        }
                        newArr.push(obj)
                    }
                }
                return newArr
            }
		</script>
	</body>
</html>
