<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-11-03
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ page import="java.util.*" %>
<%
	Long datetime = new Date().getTime(); // 获取系统时间
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
	<head>
		<title>目标分解</title>
		
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script src="../js/jquery/jquery.cookie.js"></script>
		<script type="text/javascript" src="/js/base/base.js?<%=datetime%>"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js?<%=datetime%>"></script>
		
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
			}
			
			.content {
				position: absolute;
				top: 45px;
				left: 0;
				right: 0;
				bottom: 0;
				padding: 0 20px;
			}
			
			.con_left {
				position: relative;
				float: left;
				width: 230px;
				height: 100%;
			}
			
			#projectTree {
				position: absolute;
				top: 40px;
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
				width: 20%;
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
			
			/*折叠按钮*/
			.foldIcon {
				/*display: none;*/
				position: absolute;
				left: -11px;
				top: 42%;
				font-size: 30px;
				cursor: pointer;
			}
		</style>
	
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId">
			<div class="search_module">
				<form class="layui-form clearfix search_form" lay-filter="searchForm">
					<input type="hidden" name="belongDeptId" value="">
					<div class="clearfix" style="padding: 5px 0;">
						<div class="layui-form-item query_item">
							<label class="layui-form-label">指标名称:</label>
							<div class="layui-input-block">
								<input type="text" name="tgName" autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item query_item">
							<label class="layui-form-label">指标类型:</label>
							<div class="layui-input-block">
								<select name="tgType">
									<option value="">请选择</option>
								</select>
							</div>
						</div>
						<div class="layui-form-item query_item">
							<label class="layui-form-label">数据来源:</label>
							<div class="layui-input-block">
								<input type="text" name="sourcesDeptIds" readonly id="sourcesDeptIds" class="layui-input choose_dept" placeholder="选择部门"
								       style="background-color: #ccc;border: none;cursor: pointer;">
							</div>
						</div>
						<div class="layui-form-item query_item">
							<label class="layui-form-label" style="line-height: normal;">数据复核部门:</label>
							<div class="layui-input-block">
								<input type="text" name="checkDeptIds" readonly id="checkDeptIds" class="layui-input choose_dept" placeholder="选择部门"
								       style="background-color: #ccc;border: none;cursor: pointer;">
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
					<%--组织筛选--%>
					<div class="layui-form">
						<select name="deptName" lay-filter="deptName"></select>
					</div>
					<%--项目机构和项目信息--%>
					<div id="projectTree" lay-filter="projectTree" class="eleTree" style="overflow-x: auto;margin-top: 10px;"></div>
				</div>
				<div class="con_right">
					<table id="tableObj" lay-filter="tableObj"></table>
					<i class="layui-icon layui-icon-left foldIcon" title="折叠"></i>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="toolbarDemo">
			<div class="layui-btn-container" style="height: 30px;">
				<div style="text-align: right;">
					<button class="layui-btn layui-btn-sm" lay-event="save" style="margin: 0 0 0 10px;">保存</button>
					<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin: 0 0 0 10px;">提交</button>
				</div>
			</div>
		</script>
		
		<script>

            var targetTypeData = null
            // 获取指标类型
            $.get('/targetItem/selectTempType?type=INDICATOR_TYPE', function (res) {
                targetTypeData = res.data
                initPage()
            })

            var targetTypeParentData = null
            // 获取指标类型
            $.get('/targetItem/selectTempType?type=INDICATOR_TYPE_PARENT', function (res) {
                targetTypeParentData = res.data
                initPage()
            })

            // 选择部门
            $('.choose_dept').on('click', function () {
                dept_id = $(this).attr('id')
                $.popWindow('/common/selectDept')
            })

            //点击按钮收缩
            $('.foldIcon').click(function () {
                if ($(this).hasClass('layui-icon-left')) {
                    $(this).attr('title', '展开');
                    $('.con_left').hide();
                    $('.con_right').css({
                        'width': '100%',
                    });
                    $(this).addClass('layui-icon-right').removeClass('layui-icon-left');
                } else {
                    $(this).attr('title', '折叠');
                    $('.con_left').show().css('width', '230px');
                    $('.con_right').css({
                        'width': 'calc(100% - 230px)',
                        'margin-left': '0px'
                    });
                    $(this).addClass('layui-icon-left').removeClass('layui-icon-right');
                }
            });

            // 加载页面
            function initPage() {
                layui.use(['form', 'eleTree', 'table'], function () {
                    var layuiForm = layui.form,
                        layuiEleTree = layui.eleTree,
                        layuiTable = layui.table

                    // 控制保存按钮
                    var saveLock = false
                    // 控制提交按钮
                    var submitLock = false

                    // 左侧树对象
                    var projectTree = null

                    // 表格对象
                    var tableObj = null

                    // 需要保存的数据
                    var saveUpdateData = []

                    initTable()

                    if (targetTypeData) {
                        var str = ''
                        targetTypeData.forEach(function (item) {
                            str += '<option value="' + item.dictNo + '">' + item.dictName + '</option>'
                        })
                        $('.search_module [name="tgType"]').append(str)
                    }

                    layuiForm.render()

                    // 查询
                    $('#searchBtn').on('click', function () {
                        var $selectEle = $('.search_form [name]');

                        var searchData = {}

                        $selectEle.each(function () {
                            var key = $(this).attr('name')
                            var value = $(this).val()
                            searchData[key] = value
                        })

                        searchData.sourcesDeptIds = $('#sourcesDeptIds').attr('deptid') || ''
                        searchData.checkDeptIds = $('#checkDeptIds').attr('deptid') || ''

                        initTable(searchData)
                    })

                    // 清空查询
                    $('#resetBtn').on('click', function () {
                        $('#sourcesDeptIds').attr('deptid', '')
                        $('#sourcesDeptIds').attr('deptname', '')
                        $('#checkDeptIds').attr('deptid', '')
                        $('#checkDeptIds').attr('deptname', '')
                    })

                    //左侧下拉框部门展示
                    $.get('/plcOrg/selectYJ', function (res) {
                        var data = res.obj;
                        var str = '<option value="">请选择</option>'
                        for (var i = 0; i < data.length; i++) {
                            str += '<option value="' + data[i].projOrgId + '">' + data[i].contractorName + '</option>'
                        }
                        $('.con_left [name="deptName"]').html(str)
                        layuiForm.render('select')
                        projectLeft()
                    })

                    //加监听左侧下拉框部门选择
                    layuiForm.on('select(deptName)', function (data) {
                        saveUpdateData = []
                        projectLeft(data.value);
                    });

                    /**
                     * 左侧部门列表加载方法
                     * @param projOrgId (部门id)
                     */
                    function projectLeft(projOrgId) {
                        projOrgId = projOrgId || ''
                        projectTree = layuiEleTree.render({
                            elem: '#projectTree',
                            url: '/plcTargetOrg/getTreeListByLoginer?projOrgId=' + projOrgId,
                            highlightCurrent: true,
                            showLine: true,
                            accordion: true, // 手风琴效果
                            request: {
                                name: "contractorName", // 显示的内容
                                key: "deptId", // 节点id
                                children: "orgList",
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                dataName: "object"
                            },
                        })
                    }

                    // 左侧树节点点击事件
                    layuiEleTree.on("nodeClick(projectTree)", function (d) {
                        var currentData = d.data.currentData
                        $('#leftId').val(currentData.deptId)
                        $('#leftId').attr('deptName', currentData.contractorName)
                        $('.search_module input[name="belongDeptId"]').val(currentData.deptId)
	                    
	                    if (saveUpdateData.length > 0) {
                            layer.confirm('是否保存表格数据？', function (index) {
                                saveForm(function () {
                                    layer.close(index)
                                    initTable({belongDeptId: currentData.deptId})
                                })
                            },function(){
                                initTable({belongDeptId: currentData.deptId})
                            })
	                    } else {
	                        initTable({belongDeptId: currentData.deptId})
	                    }
                    })

                    // 监听表格头部工具条点击事件
                    layuiTable.on('toolbar(tableObj)', function (obj) {
                        var checkData = layuiTable.checkStatus(obj.config.id).data;
                        switch (obj.event) {
                            case 'save':
                                saveForm(function () {
                                    layer.msg('保存成功', {icon: 1, time: 1000})
                                    tableObj.reload({
                                        page: {
                                            curr: 1 //重新从第 1 页开始
                                        }
                                    })
                                })
                                break
                            case 'submit':
                                if (submitLock) {
                                    return false
                                }
                                var tgIds = ''
                                checkData.forEach(function (item) {
                                    tgIds += item.tgId + ','
                                })
                                if (checkData.length > 0) {
                                    saveForm(function () {
                                        layer.open({
                                            type: 1,
                                            title: '提交',
                                            btn: ['提交', '取消'],
                                            area: ['500px', '400px'],
                                            content: '<form class="layui-form" id="submitForm" style="margin-top: 75px;padding-right: 20px;">' +
                                                '<div class="layui-form-item">\n' +
                                                '    <label class="layui-form-label">名称:</label>\n' +
                                                '    <div class="layui-input-block">\n' +
                                                '      <input type="text" name="approvalName" readonly class="layui-input">\n' +
                                                '    </div>\n' +
                                                '  </div>' +
                                                '<div class="layui-form-item">\n' +
                                                '    <label class="layui-form-label">审批人:</label>\n' +
                                                '    <div class="layui-input-block approvedUser" style="line-height: 36px">\n' +
                                                '    </div>\n' +
                                                '  </div>' +
                                                '</form>',
                                            success: function () {
                                                //获取名称年份显示
                                                $.get('/targetManage/getBelongYear', {tgIds: tgIds}, function (res) {
                                                    if (res.flag) {
                                                        var str = (res.data || '') + '年年度经营责任书分解'
                                                        $('#submitForm [name="approvalName"]').val(str)
                                                    } else {
                                                        layer.alert('选择的目标年份不统一，请重新选择！', {icon: 0}, function () {
                                                            layer.closeAll();
                                                        });
                                                    }
                                                })
                                                //获取审批人显示
                                                $.get('/targetManage/selectApprover', {tgIds: tgIds}, function (res) {
                                                    if (res.flag) {
                                                        $('.approvedUser').text(res.data.replace(/,$/, ''))
                                                    }
                                                })
                                            },
                                            yes: function (index) {
                                                submitLock = true
                                                $.ajax({
                                                    url: '/targetManage/submitList',
                                                    type: 'POST',
                                                    data: {
                                                        tgIds: tgIds,
                                                        belongDeptId: $('#leftId').val(),
                                                        approvalName: $('#submitForm [name="approvalName"]').val(),
                                                        year: $('#submitForm [name="year"]').val()
                                                    },
                                                    success: function (res) {
                                                        layer.close(index)
                                                        submitLock = false
                                                        if (res.flag && res.data == 0) {
                                                            layer.msg('提交成功', {icon: 1, time: 1000})
                                                            tableObj.reload({
                                                                page: {
                                                                    curr: 1 //重新从第 1 页开始
                                                                }
                                                            })
                                                        } else if (res.flag && res.data == 1) {
                                                            layer.msg('无法获取组织负责人，请先配置后再提交！', {icon: 0});
                                                        } else {
                                                            layer.msg(res.msg, {icon: 2, time: 1000})
                                                        }
                                                    },
                                                    error: function () {
                                                        submitLock = false
                                                        layer.msg('提交失败', {icon: 2, time: 1000})
                                                    }
                                                })
                                            }
                                        })
                                    })
                                } else {
                                    layer.msg('请选择需要提交的数据！', {icon: 0, time: 1000})
                                }
                                break
                        }
                    })

                    // 监听表格单元格编辑
                    layuiTable.on('edit(tableObj)', function (obj) {
                        var field = obj.field
                        var tgId = obj.data.tgId
                        var index = -1
                        for (var i = 0; i < saveUpdateData.length; i++) {
                            if (tgId == saveUpdateData[i].tgId) {
                                index = i
                                break
                            }
                        }

                        if (index > -1) {
                            saveUpdateData[index][field] = obj.value
                        } else {
                            var itemObj = {tgId: tgId}
                            itemObj[field] = obj.value
                            saveUpdateData.push(itemObj)
                        }
                    })

                    // 监听列表事件
                    layuiTable.on('tool(tableObj)', function (obj) {
                        var data = obj.data
                        if (obj.event === 'nameLink') {
                            $.get('/targetManage/getChildTarByTgId', {tgId: data.tgId}, function (res) {
                                if (res.flag && res.data) {
                                    var targetData = res.data

                                    layer.open({
                                        title: '目标详情',
                                        type: 1,
                                        area: ['70%', '90%'],
                                        maxmin: true,
                                        min: function () {
                                            $('.layui-layer-shade').hide()
                                        },
                                        content: ['<div><table class="layui-table">',
                                            '<colgroup><col width="150"><col><col width="150"><col></colgroup>',
                                            '<tr><td class="td_title">指标名称</td><td>' + isShowNull(targetData.tgName) + '</td><td class="td_title">指标类型</td><td>' + function () {
                                                var str = ''
                                                if (targetTypeData) {
                                                    for (var i = 0; i < targetTypeData.length; i++) {
                                                        if (targetTypeData[i].dictNo == targetData.tgType) {
                                                            str = targetTypeData[i].dictName
                                                            break
                                                        }
                                                    }
                                                }
                                                return str
                                            }() + '</td></tr>',
                                            '<tr><td class="td_title">分项权重</td><td>' + addData(isShowNull(targetData.itemWeight)) + '</td><td class="td_title">年度</td><td>' + isShowNull(targetData.belongYear) + '</td></tr>',
                                            '<tr><td class="td_title">单项权重</td><td>' + addData(isShowNull(targetData.individualWeight)) + '</td><td class="td_title">单项分值</td><td>' + isShowNull(targetData.individualScore) + '</td></tr>',
                                            '<tr><td class="td_title">年度目标值（万元）</td><td>' + isShowNull(targetData.annualTarget) + '</td><td class="td_title">年度完成值（万元）</td><td>' + isShowNull(targetData.annualFinish) + '</td></tr>',
                                            '<tr><td class="td_title">一季度目标（万元）</td><td>' + isShowNull(targetData.firstQuarterTarget) + '</td><td class="td_title">一季度完成值（万元）</td><td>' + isShowNull(targetData.firstQuarterFinish) + '</td></tr>',
                                            '<tr><td class="td_title">二季度目标（万元）</td><td>' + isShowNull(targetData.secondQuarterTarget) + '</td><td class="td_title">二季度完成值（万元）</td><td>' + isShowNull(targetData.secondQuarterFinish) + '</td></tr>',
                                            '<tr><td class="td_title">三季度目标（万元）</td><td>' + isShowNull(targetData.thirdQuarterTarget) + '</td><td class="td_title">三季度完成值（万元）</td><td>' + isShowNull(targetData.thirdQuarterFinish) + '</td></tr>',
                                            '<tr><td class="td_title">四季度目标（万元）</td><td>' + isShowNull(targetData.fourQuarterTarget) + '</td><td class="td_title">四季度完成值（万元）</td><td>' + isShowNull(targetData.fourQuarterFinish) + '</td></tr>',
                                            '<tr><td class="td_title">数据来源部门</td><td>' + isShowNull(targetData.sourcesDeptName) + '</td><td class="td_title">数据复核部门</td><td>' + isShowNull(targetData.checkDeptName) + '</td></tr>',
                                            '<tr><td class="td_title">所属部门</td><td>' + isShowNull(targetData.belongDeptName) + '</td><td class="td_title">指标说明</td><td>' + isShowNull(targetData.tempDesc) + '</td></tr>',
                                            '<tr><td class="td_title">支撑材料</td><td colspan="3">' + checkFile(targetData.attachmentList) + '</td></tr>',
                                            '</table></div>'].join('')
                                    })
                                }
                            })
                        }
                    })

                    // 加载表格数据
                    function initTable(searchObj) {
                        saveUpdateData = []
                        if (!searchObj) {
                            searchObj = {}
                        }
                        searchObj.tgStatus = 1
                        searchObj._ = new Date().getTime()
                        tableObj = layuiTable.render({
                            elem: '#tableObj',
                            url: '/targetManage/queryAll',
                            page: true,
                            limit: 50,
                            toolbar: '#toolbarDemo',
                            height: 'full-80',
                            defaultToolbar: [''],
                            cols: [[
                                {type: 'checkbox', fixed: 'left'},
                                {type: 'numbers', title: '序号',},
                                {
                                    field: 'tgName', title: '指标名称', minWidth: 200, event: 'nameLink', templet: function (d) {
                                        return '<span style="color: #0000ff;text-decoration: underline;cursor: pointer;">' + d.tgName + '</span>'
                                    }
                                }, {field: 'approvalStatus', title: '状态', width: 120,}, {
                                    field: 'tgType', title: '一级指标类型', minWidth: 130, templet: function (d) {
                                        var str = ''
                                        if (targetTypeParentData) {
                                            for (var i = 0; i < targetTypeParentData.length; i++) {
                                                if (targetTypeParentData[i].dictNo == d.tgTypeParent) {
                                                    str = targetTypeParentData[i].dictName
                                                    break
                                                }
                                            }
                                        }
                                        return str
                                    }
                                },
                                {
                                    field: 'tgType', title: '二级指标类型', minWidth: 130, templet: function (d) {
                                        var str = ''
                                        if (targetTypeData) {
                                            for (var i = 0; i < targetTypeData.length; i++) {
                                                if (targetTypeData[i].dictNo == d.tgType) {
                                                    str = targetTypeData[i].dictName
                                                    break
                                                }
                                            }
                                        }
                                        return str
                                    }
                                },
                                {
                                    field: 'itemWeight', title: '分项权重', minWidth: 110, templet: function (d) {
                                        return d.itemWeight + '%'
                                    }
                                },
                                {
                                    field: 'individualWeight', title: '单项权重', minWidth: 110, templet: function (d) {
                                        return d.individualWeight + '%'
                                    }
                                },
                                {field: 'individualScore', title: '单项分值', minWidth: 100},
                                {
                                    field: 'annualTarget', title: '年度目标值（万元）', minWidth: 180, templet: function (d) {
                                        if (d.annualTarget) {
                                            return numFormat(d.annualTarget)
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                                {
                                    field: 'firstQuarterTarget', title: '一季度目标（万元）', minWidth: 180, edit: true, templet: function (d) {
                                        if (d.firstQuarterTarget) {
                                            return numFormat(d.firstQuarterTarget)
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                                {
                                    field: 'secondQuarterTarget', title: '二季度目标（万元）', minWidth: 180, edit: true, templet: function (d) {
                                        if (d.secondQuarterTarget) {
                                            return numFormat(d.secondQuarterTarget)
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                                {
                                    field: 'thirdQuarterTarget', title: '三季度目标（万元）', minWidth: 180, edit: true, templet: function (d) {
                                        if (d.thirdQuarterTarget) {
                                            return numFormat(d.thirdQuarterTarget)
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                                {
                                    field: 'fourQuarterTarget', title: '四季度目标（万元）', minWidth: 180, edit: true, templet: function (d) {
                                        if (d.fourQuarterTarget) {
                                            return numFormat(d.fourQuarterTarget)
                                        } else {
                                            return ''
                                        }
                                    }
                                },
                            ]],
                            where: searchObj,
                            request: {
                                limitName: 'pageSize'
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'data'
                            }
                        });
                    }

                    /**
                     * 保存表单
                     * @param callback 请求成功的回调
                     */
                    function saveForm(callback) {
                        if (saveLock) {
                            return false
                        }
                        if (saveUpdateData.length > 0) {
                            saveLock = true
                            $.ajax({
                                url: '/targetManage/saveUpdate',
                                type: 'POST',
                                contentType: "application/json",
                                data: JSON.stringify(saveUpdateData),
                                success: function (res) {
                                    saveLock = false
                                    if (res.flag) {
                                        saveUpdateData = []
                                        if (callback) {
                                            callback(true)
                                        }
                                    } else {
                                        layer.msg('保存失败', {icon: 2, time: 1000})
                                    }
                                },
                                error: function () {
                                    saveLock = false
                                    layer.msg('保存失败', {icon: 2, time: 1000})
                                }
                            })
                        } else {
                            if (callback) {
                                callback(false)
                            }
                        }
                    }
                })
            }

            /**
             * 判断是否显示空
             * @param data
             */
            function isShowNull(data) {
                if (!!data || data == 0) {
                    return data
                } else {
                    return ''
                }
            }

            function checkFile(files) {
                if (!!files && files.length > 0) {
                    var str = '';

                    files.forEach(function (item) {
                        var attachName = item.attachName
                        var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length) // 截取附件文件后缀
                        var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6")
                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."))
                        var attachmentUrl = item.attUrl
                        attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                        fileExtension = fileExtension.toLowerCase()

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
                    })

                    return str
                } else {
                    return ''
                }
            }

            function addData(data) {
                return data + '%'
            }

            // 数值转换为千分位用逗号分隔
            function numFormat(num) {
                num = num.toString().split(".");  // 分隔小数点
                var arr = num[0].split("").reverse();  // 转换成字符数组并且倒序排列
                var res = [];
                for (var i = 0, len = arr.length; i < len; i++) {
                    if (i % 3 === 0 && i !== 0) {
                        res.push(",");   // 添加分隔符
                    }
                    res.push(arr[i]);
                }
                res.reverse(); // 再次倒序成为正确的顺序
                if (num[1]) {  // 如果有小数的话添加小数部分
                    res = res.join("").concat("." + num[1]);
                } else {
                    res = res.join("");
                }
                return res;
            }
		
		</script>
	
	</body>
</html>
