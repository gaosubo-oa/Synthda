<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-11-03
  Time: 10:52
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
		<title>目标编辑</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
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
			
			.container {
				position: relative;
				width: 100%;
				height: 100%;
			}
			
			.con_left {
				float: left;
				width: 230px;
				height: 100%;
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
			
			.foldIcon {
				/*display: none;*/
				position: absolute;
				left: -11px;
				top: 42%;
				font-size: 30px;
				cursor: pointer;
			}
			
			.layui-btn-container {
				position: relative;
			}
			
			.layui-layer-btn {
				text-align: center;
			}
		
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId" value="">
			<form class="layui-form" style="padding-top: 10px">
				<div class="query layui-row">
					<div class="layui-col-xs2">
						<div class="layui-form-item">
							<label class="layui-form-label">指标名称</label>
							<div class="layui-input-block">
								<input style="height: 35px" type="text" name="tgName" autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-xs2">
						<div class="layui-form-item">
							<label class="layui-form-label">指标类型</label>
							<div class="layui-input-block">
								<select name="tgType"></select>
							</div>
						</div>
					</div>
					<div class="layui-col-xs2">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 90px">数据来源部门</label>
							<div class="layui-input-block" style="margin-left: 120px">
								<input type="text" id="query_sourcesDeptId" readonly placeholder="请选择" style="cursor: pointer; background-color: #e7e7e7;"
								       autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-xs2">
						<div class="layui-form-item">
							<label class="layui-form-label" style="width: 90px">数据复核部门</label>
							<div class="layui-input-block" style="margin-left: 120px">
								<input type="text" id="query_checkDeptId" readonly placeholder="请选择" style="cursor: pointer; background-color: #e7e7e7;"
								       autocomplete="off" class="layui-input">
							</div>
						</div>
					</div>
					<div class="layui-col-xs2" style="margin-top: 5px;">
						<button type="reset" class="layui-btn layui-btn-sm reset" style="float: right;">重置</button>
						<button type="button" class="layui-btn layui-btn-sm" id="query_data" style="float: right;margin-right: 10px">查询</button>
					</div>
				</div>
			</form>
			<div style="padding: 0px 20px;" class="clearfix">
				<div class="con_left">
					<div class="eleTree ele1" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeft"></div>
				</div>
				<div class="con_right">
					<div class="tishi" style="height: 100%;text-align: center;border: none;">
						<div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
						<h2 class="tishi_tip" style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧部门</h2>
					</div>
					<div class="table_box" style="display: none;">
						<table id="demoTreeTb" lay-filter="demoTreeTb"></table>
						<i class="layui-icon layui-icon-left foldIcon" title="折叠"></i>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="toolbarDemo">
			<div class="layui-btn-container" style="height: 30px;">
				<div style="position:absolute;top: 0px;right:-65px;">
					<button class="layui-btn layui-btn-sm" lay-event="import">模板导入</button>
					<button class="layui-btn layui-btn-sm" lay-event="add">新增</button>
					<button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
					<button class="layui-btn layui-btn-sm" lay-event="del">删除</button>
					<button class="layui-btn layui-btn-sm" lay-event="submit" style="margin-right: 0;">提交</button>
					<button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px ;">导出</button>
				</div>
			</div>
		</script>
		
		<script type="text/javascript">
            $('.eleTree').height($(window).height() - 130);
            var dept_id = '';
            var dictionaryObj = {
                INDICATOR_TYPE: {},
                INDICATOR_TYPE_PARENT: {}
            }
            var indicatorType = []
            var dictionaryStr = 'INDICATOR_TYPE,INDICATOR_TYPE_PARENT';
            // 获取数据字典数据
            $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: '<option value="">请选择</option>'}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName;
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>';
                                if (dict == 'INDICATOR_TYPE') {
                                    indicatorType.push(item)
                                }
                            });
                        }
                    }
                }
                init();
            });
            //点击按钮收缩
            $('.foldIcon').click(function () {
                if ($(this).hasClass('layui-icon-left')) {
                    $(this).attr('title', '展开');
                    $('.con_left').hide();
                    $('.con_right').css({
                        'width': '100%',
                        'margin-left': '5px'
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

            // 初始化页面
            function init() {
                layui.use(['form', 'eleTree', 'table'], function () {
                    var form = layui.form,
                        eleTree = layui.eleTree,
                        table = layui.table;

                    var insTree = null;
                    var tableIns = null;
                    //数据来源部门
                    $('#query_sourcesDeptId').click(function () {
                        dept_id = 'query_sourcesDeptId';
                        $.popWindow('/common/selectDept');
                    });
                    //数据复核部门
                    $('#query_checkDeptId').click(function () {
                        dept_id = 'query_checkDeptId';
                        $.popWindow('/common/selectDept');
                    });
                    $('.query [name="tgType"]').html(dictionaryObj['INDICATOR_TYPE']['str'])
                    form.render()
                    window.onresize = function () {
                        $('.eleTree').height($(window).height() - 130);
                    }

                    //加载左侧部门树
                    projectLeft('')

                    // 节点点击事件
                    eleTree.on("nodeClick(projectLeft)", function (d) {
                        var currentData = d.data.currentData;
                        // if (currentData.deptParent == 0) {
                        //     $('.tishi').show(0, function () {
                        //         $('.tishi_tip').text('请选择下级部门');
                        //     });
                        //     $('.table_box').hide();
                        //     $('#leftId').val('');
                        //     tableIns = null;
                        // } else {
                        //     if (currentData.isPermission == 1) {
                        //         $('.tishi').hide();
                        //         $('.table_box').show();
                        //         $('#leftId').val(currentData.deptId);
                        //         $('#leftId').attr('deptName', currentData.contractorName);
                        //         tableShow(currentData.deptId);
                        //     } else {
                        //         $('.tishi').show(0, function () {
                        //             $('.tishi_tip').text('暂无权限访问');
                        //         });
                        //         $('.table_box').hide();
                        //         $('#leftId').val('');
                        //         tableIns = null;
                        //     }
                        // }
                        if (currentData.isPermission == 1) {
                            $('.tishi').hide();
                            $('.table_box').show();
                            $('#leftId').val(currentData.deptId);
                            $('#leftId').attr('deptName', currentData.contractorName);
                            tableShow(currentData.deptId);
                        } else {
                            $('.tishi').show(0, function () {
                                $('.tishi_tip').text('暂无权限访问');
                            });
                            $('.table_box').hide();
                            $('#leftId').val('');
                            tableIns = null;
                        }
                    });

                    // 表格头部工具条事件
                    table.on('toolbar(demoTreeTb)', function (obj) {
                        var checkStatus = table.checkStatus(obj.config.id);

                        switch (obj.event) {
                            // 提交
                            case 'import':
                                importData($('#leftId').val())
                                break;
                            // 新增
                            case 'add':
                                creat(0)
                                break;
                            // 编辑
                            case 'edit':
                                if (checkStatus.data.length != 1) {
                                    layer.msg('请选择一项！', {icon: 0});
                                    return false
                                }
                                creat(1, checkStatus.data[0])
                                break;
                            // 删除
                            case 'del':
                                if (!checkStatus.data.length) {
                                    layer.msg('请至少选择一项！', {icon: 0});
                                    return false
                                }
                                var tgIds = ''
                                checkStatus.data.forEach(function (v, i) {
                                    tgIds += v.tgId + ','
                                })
                                layer.confirm('确定删除该条数据吗？', function (index) {
                                    $.ajax({
                                        url: '/targetManage/delete',
                                        dataType: 'json',
                                        type: 'post',
                                        data: {tgIds: tgIds},
                                        success: function (res) {
                                            if (res.flag) {
                                                layer.msg('删除成功！', {icon: 1});
                                            } else {
                                                layer.msg('删除失败！', {icon: 0});
                                            }
                                            layer.close(index)
                                            tableIns.config.where._ = new Date().getTime();
                                            tableIns.reload()
                                        }
                                    })
                                });
                                break;
                            //提交
                            case 'submit':
                                if (!checkStatus.data.length) {
                                    layer.msg('请至少选择一项！', {icon: 0});
                                    return false
                                }
                                var tgIds = ''
                                checkStatus.data.forEach(function (v) {
                                    tgIds += v.tgId + ','
                                })

                                layer.open({
                                    type: 1,
                                    title: '提交目标',
                                    area: ['500px', '400px'],
                                    btn: ['提交', '取消'],
                                    content: '<form class="layui-form" id="submitForm" style="margin-top: 75px;padding-right: 20px;">' +
                                        '<div class="layui-form-item">\n' +
                                        '    <label class="layui-form-label">名称:</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '      <input type="text" name="approvalName" readonly class="layui-input">\n' +
                                        '    </div>\n' +
                                        '  </div>' +
                                        '<div class="layui-form-item">\n' +
                                        '    <label class="layui-form-label">年度:</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '      <select name="year" lay-filter="year"></select>\n' +
                                        '    </div>\n' +
                                        '  </div>' +
                                        '<div class="layui-form-item">\n' +
                                        '    <label class="layui-form-label">审批人:</label>\n' +
                                        '    <div class="layui-input-block approvedUser" style="line-height: 36px">\n' +
                                        '    </div>\n' +
                                        '  </div>' +
                                        '</form>',
                                    success: function () {
                                        var deptName = $('#leftId').attr('deptName') || ''
                                        var str = deptName + '- -经营目标责任书'
                                        $('#submitForm [name="approvalName"]').val(str)

                                        // 获取年度
                                        $.get('/planPeroidSetting/selectAllYear', function (res) {
                                            var str = '<option value="">请选择</option>'
                                            if (res.object && res.object.length > 0) {
                                                res.object.forEach(function (item) {
                                                    str += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                                                })
                                            }
                                            $('#submitForm [name="year"]').html(str)
                                            form.render()
                                        })

                                        form.on('select(year)', function (data) {
                                            var str = deptName + '-' + data.value + '-经营目标责任书'
                                            $('#submitForm [name="approvalName"]').val(str)
                                            form.render()
                                        });

                                        //获取审批人显示
                                        $.get('/targetManage/selectApprover', {tgIds: tgIds}, function (res) {
                                            if (res.flag) {
                                                $('.approvedUser').text(res.data.replace(/,$/, ''))
                                            }
                                        })
                                    },
                                    yes: function (index) {
                                        if (!$('#submitForm [name="year"]').val().trim()) {
                                            layer.msg('请选择年度', {icon: 0, time: 1500})
                                            return false
                                        }

                                        $.ajax({
                                            url: '/targetManage/submitList',
                                            dataType: 'json',
                                            type: 'post',
                                            data: {
                                                tgIds: tgIds,
                                                belongDeptId: $('#leftId').val(),
                                                approvalName: $('#submitForm [name="approvalName"]').val(),
                                                year: $('#submitForm [name="year"]').val()
                                            },
                                            success: function (res) {
                                                if (res.flag && res.data == 0) {
                                                    layer.msg('提交成功！', {icon: 1});
                                                } else if (res.flag && res.data == 1) {
                                                    layer.msg('无法获取组织负责人，请先配置后再提交！', {icon: 0});
                                                } else {
                                                    layer.msg('提交失败！', {icon: 0});
                                                }
                                                layer.close(index)
                                                tableIns.config.where._ = new Date().getTime();
                                                tableIns.reload()
                                            }
                                        })
                                    }
                                })
                                break;
                            case 'export':
                                var tgName = $('.query [name="tgName"]').val();
                                var tgType = $('.query [name="tgType"]').val();
                                var sourcesDeptIds = $('#query_sourcesDeptId').attr('deptid');
                                var checkDeptIds = $('#query_checkDeptId').attr('deptid');
                                var tgStatus = 0;
                                var belongDeptId = $('#leftId').val();
                                var url = '/targetManage/tarEditExport?belongDeptId=' + belongDeptId + '&tgName=' + tgName + '&tgType=' + tgType + '&sourcesDeptIds=' + sourcesDeptIds
                                    + '&checkDeptIds=' + checkDeptIds + '&tgStatus=' + tgStatus;
                                console.log(url);
                                window.location.href = url
                                break;
                        }
                    });

                    /**
                     * 左侧部门列表加载方法
                     * @param[Number] projOrgId (部门id)
                     */
                    function projectLeft(projOrgId) {
                        insTree = eleTree.render({
                            elem: '.ele1',
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
                        });
                    }

                    /**
                     * 右侧关键任务列表加载方法
                     * @param[Number] deptId (部门id)
                     */
                    function tableShow(deptId) {
                        tableIns = table.render({
                            elem: '#demoTreeTb',
                            url: '/targetManage/queryAll',
                            page: true,
                            toolbar: '#toolbarDemo',
                            defaultToolbar: ['filter'],
                            cols: [[ //表头
                                {type: 'checkbox'}
                                , {type: 'numbers', title: '序号',}
                                , {
                                    field: 'tgType', title: '一级指标类型', width: 120, templet: function (d) {
                                        return dictionaryObj['INDICATOR_TYPE_PARENT']['object'][d.tgTypeParent] || ''
                                    }
                                }
                                , {
                                    field: 'tgType', title: '二级指标类型', width: 120, templet: function (d) {
                                        return dictionaryObj['INDICATOR_TYPE']['object'][d.tgType] || ''
                                    }
                                }
                                , {
                                    field: 'tgName',
                                    title: '指标名称',
                                    width: 200,
                                    event: 'nameLink',
                                    templet: function (d) {
                                        return '<span style="color: #0000ff;text-decoration: underline;cursor: pointer;">' + d.tgName + '</span>'
                                    }
                                }
                                , {
                                    field: 'itemWeight', title: '分项权重', width: 120, templet: function (d) {
                                        return d.itemWeight + '%'
                                    }
                                }
                                , {
                                    field: 'individualWeight', title: '单项权重', width: 120, templet: function (d) {
                                        return d.individualWeight + '%'
                                    }
                                }
                                , {field: 'individualScore', title: '单项分值', width: 120}
                                , {
                                    field: 'annualTarget', align: 'right',edit: 'text', title: '年度目标值（万元）', width: 180, templet: function (d) {
                                        if (d.annualTarget) {
                                            var num = d.annualTarget;
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
                                        } else {
                                            return '';
                                        }
                                    }
                                }
                                , {field: 'sourcesDeptName', title: '数据来源部门', width: 120,}
                                , {field: 'checkDeptName', title: '数据复核部门', width: 150,}
                                , {field: 'tempDesc', title: '指标说明', width: 150}
                                , {field: 'apprivalStatus', title: '状态', width: 120,}
                            ]],
                            where: {
                                belongDeptId: deptId,
                                _: new Date().getTime(),
                                tgStatus: 0
                            },
                            request: {
                                limitName: 'pageSize'
                            },
                            parseData: function (res) { //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data, //解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            }
                        });
                    }

                    // 监听列表事件
                    table.on('tool(demoTreeTb)', function (obj) {
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
                                            '<tr><td class="td_title">指标名称</td><td>' + isShowNull(targetData.tgName) + '</td><td class="td_title">指标类型</td><td>' + (dictionaryObj['INDICATOR_TYPE']['object'][targetData.tgType] || '') + '</td></tr>',
                                            '<tr><td class="td_title">分项权重</td><td>' + addData(isShowNull(targetData.itemWeight)) + '</td><td class="td_title">年度</td><td>' + isShowNull(targetData.belongYear) + '</td></tr>',
                                            '<tr><td class="td_title">单项权重</td><td>' + addData(isShowNull(targetData.individualWeight)) + '</td><td class="td_title">单项分值</td><td>' + isShowNull(targetData.individualScore) + '</td></tr>',
                                            '<tr><td class="td_title">年度目标值（万元）</td><td>' + isShowNull(targetData.annualTarget) + '</td><td class="td_title">年度完成值</td><td>' + isShowNull(targetData.annualFinish) + '</td></tr>',
                                            '<tr><td class="td_title">一季度目标</td><td>' + isShowNull(targetData.firstQuarterTarget) + '</td><td class="td_title">一季度完成值</td><td>' + isShowNull(targetData.firstQuarterFinish) + '</td></tr>',
                                            '<tr><td class="td_title">二季度目标</td><td>' + isShowNull(targetData.secondQuarterTarget) + '</td><td class="td_title">二季度完成值</td><td>' + isShowNull(targetData.secondQuarterFinish) + '</td></tr>',
                                            '<tr><td class="td_title">三季度目标</td><td>' + isShowNull(targetData.thirdQuarterTarget) + '</td><td class="td_title">三季度完成值</td><td>' + isShowNull(targetData.thirdQuarterFinish) + '</td></tr>',
                                            '<tr><td class="td_title">四季度目标</td><td>' + isShowNull(targetData.fourQuarterTarget) + '</td><td class="td_title">四季度完成值</td><td>' + isShowNull(targetData.fourQuarterFinish) + '</td></tr>',
                                            '<tr><td class="td_title">数据来源部门</td><td>' + isShowNull(targetData.sourcesDeptName) + '</td><td class="td_title">数据复核部门</td><td>' + isShowNull(targetData.checkDeptName) + '</td></tr>',
                                            '<tr><td class="td_title">所属部门</td><td>' + isShowNull(targetData.belongDeptName) + '</td><td class="td_title">指标说明</td><td>' + isShowNull(targetData.tempDesc) + '</td></tr>',
                                            '<tr><td class="td_title">支撑材料</td><td colspan="3">' + checkFile(targetData.attachmentList) + '</td></tr>',
                                            '</table></div>'].join('')
                                    })
                                }
                            })
                        }
                    })

                    table.on('edit(demoTreeTb)', function (obj) {
                        var data = obj.data
                        var field = obj.field

                        var arr = []
                        arr.push({
                            tgId: data.tgId,
                            [field]: obj.value
                        })
                        $.ajax({
                            url: '/targetManage/saveUpdate',
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
                                } else {
                                    layer.msg('修改失败')
                                }
                            }
                        })

                    });

                    //新增编辑共用方法
                    function creat(type, data) {
                        var title
                        var url = ''
                        if (type == '0') {
                            title = '新增'
                            url = '/targetManage/insert'
                        } else if (type == '1') {
                            title = '编辑'
                            url = '/targetManage/saveUpdate'
                        } else {
                            title = '查看'
                        }
                        layer.open({
                            type: 1,
                            title: title,
                            area: ['80%', '70%'],
                            maxmin: true,
                            min: function () {
                                $('.layui-layer-shade').hide()
                            },
                            btn: ['确定', '取消'],
                            content: '<form class="layui-form" id="form" lay-filter="formTest">' +
                                '<input type="hidden" id="belongDeptId" name="belongDeptId" value="">' +
                                //第一行
                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                                '    <label class="layui-form-label" style="width: 85px;padding: 9px 12px;">一级指标类型</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '        <select name="tgTypeParent" lay-filter="tgTypeParent"></select>' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                //第二行
                                '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                                '    <label class="layui-form-label" style="width: 85px;padding: 9px 12px;">二级指标类型</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '        <select name="tgType"></select>' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                '</div>' +

                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">指标名称</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="tgName" autocomplete="off" class="layui-input">\n' +
                                '    </div>\n' +
                                '  </div></div>' +
                                '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">年度</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '        <select name="belongYear"></select>' +
                                '    </div>\n' +
                                '  </div></div>' +
                                '</div>' +

                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">单项权重</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="number" name="individualWeight"  autocomplete="off" class="layui-input" ><span style=" position: absolute; top: 1%; right: 6%;color: #333; display: table-cell;white-space: nowrap; padding: 7px 10px;">%</span>\n\n' +
                                '    </div>\n' +
                                '<label class="layui-form-label">分项权重</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="number" name="itemWeight"  autocomplete="off" class="layui-input" ><span style=" position: absolute; top: 1%; right: 6%;color: #333; display: table-cell;white-space: nowrap; padding: 7px 10px;">%</span>\n\n' +
                                '    </div>\n' +
                                '  </div></div>' +
                                '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">单项分值</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="individualScore" autocomplete="off" class="layui-input">\n' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                '</div>' +
                                //第三行
                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">年度目标值（万元）</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="number" name="annualTarget" autocomplete="off" class="layui-input">\n' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label" style="padding: 9px 12px;width: 85px">数据来源部门</label>' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="sourcesDeptId" id="sourcesDeptId" autocomplete="off" class="layui-input" style="background:#e7e7e7;display: inline-block;width: 83%" readonly>\n' +
                                '      <span style="margin-left: 2px; color: red; cursor: pointer;" class="deptAdd" chooseNum="1">添加</span>' +
                                '      <span style="margin-left: 5px; color: blue; cursor: pointer;" class="deptDel">清空</span>' +
                                '    </div>\n' +
                                '  </div> </div>' +
                                '</div>' +
                                //第四行
                                '<div class="layui-row">' +
                                '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label" style="padding: 9px 12px;width: 85px">数据复核部门</label>\n' +
                                '    <div class="layui-input-block">' +
                                '      <input type="text" class="layui-input" autocomplete="off" name="checkDeptId" id="checkDeptId" style="background:#e7e7e7;display: inline-block;width: 83%" readonly>' +
                                '      <span style="margin-left: 2px; color: red; cursor: pointer;" class="deptAdd" chooseNum="1">添加</span>' +
                                '      <span style="margin-left: 5px; color: blue; cursor: pointer;" class="deptDel">清空</span>' +
                                '    </div>\n' +
                                '  </div>' +
                                '  </div>' +
                                ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                                '    <label class="layui-form-label">指标说明</label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="text" name="tempDesc"  autocomplete="off" class="layui-input">\n' +
                                '    </div>\n' +
                                '  </div> </div>' +
                                '</div>' +

                                '</form>',
                            success: function () {
                                $('#belongDeptId', $('#form')).val($('#leftId').val());
                                // $('#form [name="tgType"]').html(dictionaryObj['INDICATOR_TYPE']['str'])
                                $('#form [name="tgTypeParent"]').html(dictionaryObj['INDICATOR_TYPE_PARENT']['str'])

                                form.render()
                                form.on('select(tgTypeParent)', function (data) {
                                    var vaule = data.value
                                    if (indicatorType.length > 0) {
                                        var str = '<option value="">请选择</option>'
                                        indicatorType.forEach(function (item) {
                                            if (item.facility == vaule) {
                                                str += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                            }
                                        })
                                        $('#form [name="tgType"]').html(str)
                                        form.render('select')
                                    }
                                });
                                // 获取年度
                                $.get('/planPeroidSetting/selectAllYear', function (res) {
                                    var str = '<option value="">请选择</option>'
                                    if (res.object && res.object.length > 0) {
                                        res.object.forEach(function (item) {
                                            str += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                                        })
                                    }
                                    $('#form [name="belongYear"]').html(str)
                                    form.render()
                                })
                                if (type == '1') {
                                    //给表单赋值
                                    form.val("formTest", data);
                                    $('#sourcesDeptId').val(data.sourcesDeptName)
                                    $('#sourcesDeptId').attr('deptid', data.sourcesDeptId)
                                    $('#checkDeptId').val(data.checkDeptName)
                                    $('#checkDeptId').attr('deptid', data.checkDeptId)

                                    if (data.tgTypeParent) {
                                        if (indicatorType.length > 0) {
                                            var str = '<option value="">请选择</option>'
                                            indicatorType.forEach(function (item) {
                                                if (item.facility == data.tgTypeParent) {
                                                    str += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                                                }
                                            })
                                            $('#form [name="tgType"]').html(str)
                                        }
                                    }
                                }
                            },
                            yes: function (index) {
                                var datas = $('#form').serializeArray()
                                var obj = {}
                                datas.forEach(function (item, index) {
                                    obj[item.name] = item.value
                                })
                                //获取数据来源部门的id
                                if ($('#sourcesDeptId').attr('deptid')) {
                                    obj.sourcesDeptId = $('#sourcesDeptId').attr('deptid').replace(/,$/, '')
                                }
                                //获取数据复核部门的id
                                if ($('#checkDeptId').attr('deptid')) {
                                    obj.checkDeptId = $('#checkDeptId').attr('deptid').replace(/,$/, '')
                                }
                                if (type == 1) {
                                    obj.tgId = data.tgId
                                }
                                if (type == 0) {
                                    $.ajax({
                                        url: url,
                                        data: obj,
                                        dataType: 'json',
                                        type: 'post',
                                        success: function (res) {
                                            layer.msg('新增成功！', {icon: 1});
                                            layer.close(index)
                                            tableIns.config.where._ = new Date().getTime();
                                            tableIns.reload()
                                        }
                                    })
                                } else {
                                    var arr = []
                                    arr.push(obj)
                                    $.ajax({
                                        url: url,
                                        data: JSON.stringify(arr),
                                        dataType: 'json',
                                        type: 'post',
                                        contentType: "application/json;charset=UTF-8",
                                        success: function (res) {
                                            if (res.flag) {
                                                layer.msg('修改成功！', {icon: 1});
                                                layer.close(index)
                                                tableIns.config.where._ = new Date().getTime();
                                                tableIns.reload()
                                            }
                                        }
                                    })
                                }
                            }
                        })
                    }

                    //导入
                    function importData(belongDeptId) {
                        var projectItemTable = null;
                        layer.open({
                            type: 1,
                            title: '导入',
                            btn: ['确定', '取消'],
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
                                '<table id="projectItemTable" lay-filter="projectItemTable">' +
                                '</table>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                            success: function () {
                                // 初始化左侧关键任务模板树
                                var targetModuleTree = eleTree.render({
                                    elem: '.target_module_tree',
                                    url: '/targetManage/getTarTempParentName',
                                    highlightCurrent: true,
                                    showLine: true,
                                    request: { // 修改数据为组件需要的数据
                                        name: "typeName", // 显示的内容
                                        key: "typeId", // 节点id
                                        parentId: 'parentTypeId', // 节点父id
                                        isLeaf: "isLeaf",// 是否有子节点
                                        children: 'son',
                                    },
                                    response: { // 修改响应数据为组件需要的数据
                                        statusName: "flag",
                                        statusCode: true,
                                        dataName: "data"
                                    }
                                });

                                // 模板树节点点击
                                eleTree.on("nodeClick(targetModuleTree)", function (d) {
                                    if (projectItemTable) {
                                        projectItemTable.reload({
                                            where: {
                                                typeId: d.data.currentData.typeId,
                                                useFlag: true,
                                                _: new Date().getTime()
                                            },
                                            page: {
                                                curr: 1
                                            }
                                        });
                                    } else {
                                        projectItemTable = table.render({
                                            elem: '#projectItemTable',
                                            url: '/targetManage/getTarTempName',
                                            page: true,
                                            cols: [[
                                                {type: 'checkbox'},
                                                {field: 'tempName', align: 'left', title: '关键任务模板名称'}
                                            ]],
                                            where: {
                                                typeId: d.data.currentData.typeId,
                                                useFlag: true,
                                                _: new Date().getTime()
                                            },
                                            parseData: function (res) {
                                                return {
                                                    "code": 0, //解析接口状态
                                                    "data": res.data,//解析数据列表
                                                    "count": res.totleNum, //解析数据长度
                                                };
                                            },
                                            request: {
                                                pageName: 'page' //页码的参数名称，默认：page
                                                , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                            }
                                        });
                                    }
                                });
                            },
                            yes: function (index) {
                                layer.open({
                                    type: 1,
                                    title: '年度',
                                    btn: ['确定', '取消'],
                                    area: ['45%', '35%'],
                                    maxmin: true,
                                    content: '<div class="layui-form" id="formYear">' +
                                        ' <div class="layui-form-item">\n' +
                                        '    <label class="layui-form-label">年度</label>\n' +
                                        '    <div class="layui-input-block">\n' +
                                        '      <select name="belongYear">\n' +
                                        '      </select>\n' +
                                        '    </div>\n' +
                                        '  </div>' +
                                        '</div>',
                                    success: function () {
                                        // 获取年度
                                        $.get('/planPeroidSetting/selectAllYear', function (res) {
                                            var str = ''
                                            if (res.object && res.object.length > 0) {
                                                res.object.forEach(function (item) {
                                                    str += '<option value="' + item.periodYear + '">' + item.periodYear + '</option>'
                                                })
                                            }
                                            $('#formYear [name="belongYear"]').html(str)
                                            form.render()
                                        })
                                    },
                                    yes: function (index) {
                                        if (projectItemTable) {
                                            var checkStatus = table.checkStatus('projectItemTable');
                                            if (checkStatus.data.length > 0) {
                                                var loadingIndex = layer.load();
                                                var obj = {}
                                                var ttaskId = []
                                                checkStatus.data.forEach(function (v, i) {
                                                    ttaskId.push(v.tempId)
                                                })
                                                obj.tempId = ttaskId;
                                                obj.belongDeptId = belongDeptId;
                                                obj.year = $('#formYear [name="belongYear"]').val()
                                                console.log(obj);
                                                $.ajax({
                                                    url: '/targetManage/tempInsert',
                                                    dataType: 'json',
                                                    type: 'post',
                                                    data: obj,
                                                    traditional: true,
                                                    success: function (res) {
                                                        layer.close(loadingIndex);
                                                        if (res.flag) {
                                                            layer.close(index);
                                                            layer.msg('模板导入成功！', {icon: 1, time: 1000});
                                                        } else {
                                                            layer.msg('模板导入失败！', {icon: 2, time: 1000});
                                                        }
                                                        layer.closeAll();
                                                        layer.close(index);
                                                        tableIns.reload();
                                                    }
                                                })
                                            } else {
                                                layer.msg('请选择任务模板', {icon: 0, time: 1000});
                                            }
                                        } else {
                                            layer.msg('请选择任务模板', {icon: 0, time: 1000});
                                        }

                                    }
                                });

                            }
                        });
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

                    function addData(data) {
                        return data + '%'
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

                    //查询功能
                    $('#query_data').on('click', function () {
                        var params = {
                            tgName: $('.query [name="tgName"]').val(),
                            tgType: $('.query [name="tgType"]').val(),
                            sourcesDeptIds: $('#query_sourcesDeptId').attr('deptid'),
                            checkDeptIds: $('#query_checkDeptId').attr('deptid'),
                            _: new Date().getTime(),
                            belongDeptId: $('#leftId').val(),
                            tgStatus: 0
                        }
                        tableIns.reload({
                            where: params
                            , page: {
                                curr: 1 //重新从第 1 页开始
                            }
                            , parseData: function (res) { //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data, //解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            }
                        });
                    })
                    //重置功能
                    $('.reset').click(function () {
                        $('#query_sourcesDeptId').val('');
                        $('#query_sourcesDeptId').attr('deptid', '');
                        $('#query_checkDeptId').val('');
                        $('#query_checkDeptId').attr('deptid', '');
                        tableIns.reload({
                            where: {
                                tgName: $('.query [name="tgName"]').val(),
                                tgType: $('.query [name="tgType"]').val(),
                                sourcesDeptIds: $('#query_sourcesDeptId').attr('deptid'),
                                checkDeptIds: $('#query_checkDeptId').attr('deptid'),
                                _: new Date().getTime(),
                                belongDeptId: $('#leftId').val(),
                                tgStatus: 0
                            }
                            , page: {
                                curr: 1 //重新从第 1 页开始
                            }
                            , parseData: function (res) { //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data, //解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            }
                        });
                    })
                });
            }

            //选部门控件添加
            $(document).on('click', '.deptAdd', function () {
                var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : ''
                dept_id = $(this).siblings('input').attr('id')
                $.popWindow("/common/selectDept" + chooseNum);
            })
            //选部门控件删除
            $(document).on('click', '.deptDel', function () {
                var deptId = $(this).siblings('input').attr('id')
                $('#' + deptId).val('')
                $('#' + deptId).attr('deptid', '')
            })
		</script>
	</body>
</html>
