<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/11/26
  Time: 15:51
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
<!DOCTYPE html>
<html>
	<head>
		<title>目标审批</title>
		
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
				padding: 0 20px;
				box-sizing: border-box;
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
			
			.layui-table-view {
				margin: 0;
			}
			
			.td_title {
				width: 200px;
				text-align: right;
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
		
		</style>
	</head>
	<body>
		<div class="container">
			<div class="layui-tab layui-tab-brief" lay-filter="tab" style="margin: 0;">
				<ul class="layui-tab-title">
					<li class="layui-this" opttype="0">待审批</li>
					<li opttype="1">已审批</li>
				</ul>
				<div class="layui-tab-content" style="padding: 0px;">
					<div class="search_module">
						<form class="layui-form clearfix search_form" lay-filter="searchForm">
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
										<input type="text" name="sourcesDeptIds" readonly id="sourcesDeptIds" class="layui-input choose_dept"
										       placeholder="选择部门"
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
						<table id="tableList" lay-filter="tableList"></table>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 已考核、未考核头部工具条 -->
		<script type="text/html" id="assessmentBar">
			<div style="position:absolute;right: 1%">
				<a class="layui-btn layui-btn-sm assessment" lay-event="assessment" style="margin-left: 15px;">审批</a>
				<a class="layui-btn layui-btn-sm" lay-event="export" style="float: right;margin-right: 10px;">导出</a>
			</div>
		</script>
		
		<script>
            layui.use(['form', 'table', 'element'], function () {
                var layuiForm = layui.form,
                    layuiTable = layui.table,
                    layuiElement = layui.element;

                // 控制审批按钮
                var submitLock = false

                layuiForm.render()

                var tableInit = null

                initTable(0)

                function initTable(approvalStatus) {
                    var edit = true
                    if (approvalStatus == 1) {
                        edit = false
                    }
                    tableInit = layuiTable.render({
                        elem: '#tableList',
                        url: '/targetApproval/selectApprovalData',
                        page: true,
                        limit: 10,
                        height: 'full-130',
                        toolbar: '#assessmentBar',
                        defaultToolbar: [''],
                        where: {
                            approvalStatus: approvalStatus // 默认加载未审批数据
                        },
                        cols: [[
                            {type: 'checkbox', fixed: 'left'},
                            {
                                field: 'approvalName', title: '名称', minWidth: 200, templet: function (d) {
                                    return '<span class="name_link" approvalId="' + d.approvalId + '" style="color: #0A5FA2;cursor: pointer;text-decoration: underline;">' + d.approvalName + '</span>'
                                }
                            },
                            {
                                field: 'approvalStatus', title: '审批状态', minWidth: 120, templet: function (d) {
                                    var str = ''
                                    if (d.approvalStatus == '0') {
                                        str = '待审核'
                                    } else if (d.approvalStatus == '1') {
                                        str = '同意'
                                    } else if (d.approvalStatus == '2') {
                                        str = '不同意'
                                    }
                                    return str
                                }
                            },
							{field: 'apprivalComment', title: '审批意见', minWidth: 150, edit: edit},
                            {field: 'tarBelongDeptName', title: '所属部门', minWidth: 120},
                            {field: 'belongYear', title: '所属年度', minWidth: 120},
                            {field: 'planClass', title: '审批类型', minWidth: 120},
                            {field: 'auditer', title: '责任人', minWidth: 120},
                        ]],
                        request: {
                            pageName: 'page',
                            limitName: 'pageSize'
                        },
                        response: {
                            statusName: 'flag',
                            statusCode: true,
                            msgName: 'msg',
                            countName: 'totleNum',
                            dataName: 'obj'
                        },
                        done: function () {
                            if (approvalStatus == 1) {
                                $('.assessment').hide()
                            }
                        }
                    })
                }

                layuiElement.on('tab(tab)', function (data) {
                    initTable(data.index)
                });

                // 监听表格头部工具条点击事件
                layuiTable.on('toolbar(tableList)', function (obj) {
                    var checkData = layuiTable.checkStatus(obj.config.id).data;
                    switch (obj.event) {
                        case 'assessment':
                            if (submitLock) {
                                return false
                            }

                            if (checkData.length == 0) {
                                layer.msg('请选择需要审批的数据！', {icon: 0, time: 2000})
                                submitLock = false
                                return false
                            }

                            var confirmIndex = layer.confirm('是否审批已选数据？', {
                                btn: ['同意', '<span style="color: #f00;">不同意</span>', '取消'] //按钮
                            }, function () {
                                updateFunc(checkData, 1, confirmIndex)
                            }, function () {
                                updateFunc(checkData, 2, confirmIndex)
                            });
                            break
                    }
                })

                // 监听表格单元格编辑
                layuiTable.on('edit(tableList)', function (obj) {

                    var field = obj.field

                    var data = [{
                        approvalId: obj.data.approvalId,
                        [field]: obj.value
                    }]

                    $.ajax({
                        url: '/targetApproval/updateApprivalStatus',
                        type: 'POST',
                        contentType: "application/json",
                        data: JSON.stringify(data),
                        success: function (res) {
                            if (res.flag) {
                                //同步更新缓存对应的值
                                obj.update({
                                    [field]: obj.value
                                });
                            } else {
                                layer.msg('修改失败', {icon: 2, time: 1500})
                            }
                        },
                        error: function () {
                            layer.msg('修改失败', {icon: 2, time: 1500})
                        }
                    })
                })

                $(document).on('click', '.name_link', function () {
                    var approvalId = $(this).attr('approvalId')
                    layer.open({
                        type: 1,
                        title: '目标详情',
                        area: ['100%', '100%'],
                        content: [
                            '<div style="padding: 10px 20px;">',
                            '<table id="targetTable" lay-filter="targetTable"></table>',
                            '</div>'
                        ].join(''),
                        success: function () {
                            tableInit = layuiTable.render({
                                elem: '#targetTable',
                                url: '/targetManage/queryByApprovalId',
                                defaultToolbar: [''],
                                where: {approvalId: approvalId},
                                cols: [[
                                    {type: 'checkbox', fixed: 'left'},
                                    {
                                        field: 'tgName', title: '任务名称', minWidth: 200, templet: function (d) {
                                            return '<span class="target_name_link" tgId="' + d.tgId + '" style="color: #0A5FA2;cursor: pointer;text-decoration: underline;">' + d.tgName + '</span>'
                                        }
                                    },
									{field: 'annualTarget', title: '年度目标值（万元）', width: 120,templet:function (d) { if (d.annualTarget){return numFormat(d.annualTarget)}else {return ''} }},
									{field: 'firstQuarterTarget', title: '一季度目标（万元）', width: 120,templet:function (d) { if (d.firstQuarterTarget){return numFormat(d.firstQuarterTarget)}else {return ''} }},
									{field: 'secondQuarterTarget', title: '二季度目标（万元）', width: 120,templet:function (d) { if (d.secondQuarterTarget){return numFormat(d.secondQuarterTarget)}else {return ''} } },
									{field: 'thirdQuarterTarget', title: '三季度目标（万元）', width: 120,templet:function (d) { if (d.thirdQuarterTarget){return numFormat(d.thirdQuarterTarget)}else {return ''} }},
									{field: 'fourQuarterTarget', title: '四季度目标（万元）', width: 120,templet:function (d) { if (d.fourQuarterTarget){return numFormat(d.fourQuarterTarget)}else {return ''} }},
                                    {field: 'sourcesDeptName', title: '数据来源部门', width: 120},
                                    {field: 'belongDeptName', title: '所属部门', minWidth: 120},
                                    {field: 'tgTypeParent', title: '一级指标类型', minWidth: 120},
                                    {field: 'tgType', title: '二级指标类型', minWidth: 120},
                                    {field: 'individualWeight', title: '单项权重', width: 120,templet:function (d) { return d.individualWeight+'%' }},
                                    {field: 'individualScore', title: '单项分值', width: 120},
                                    {field: 'tempDesc', title: '指标说明', width: 150}
                                ]],
                                request: {
                                    pageName: 'page',
                                    limitName: 'pageSize'
                                },
                                response: {
                                    statusName: 'flag',
                                    statusCode: true,
                                    msgName: 'msg',
                                    dataName: 'data'
                                },
                                done: function (res) {
                                	if (!res.data[0].firstQuarterTarget) {
										$("[data-field='firstQuarterTarget']").css('display','none'); //关键代码
									}
									if (!res.data[0].secondQuarterTarget) {
										$("[data-field='secondQuarterTarget']").css('display','none'); //关键代码
									}
									if (!res.data[0].thirdQuarterTarget) {
										$("[data-field='thirdQuarterTarget']").css('display','none'); //关键代码
									}
									if (!res.data[0].fourQuarterTarget) {
										$("[data-field='fourQuarterTarget']").css('display','none'); //关键代码
									}
                                    $('.target_name_link').on('click', function () {
                                        var tgId = $(this).attr('tgId')
                                        var title = $(this).text()
                                        layer.open({
                                            type: 1,
                                            title: '目标详情',
                                            area: ['70%', '90%'],
                                            content: [
                                                '<div style="padding: 10px 20px;">',
                                                '<h3 style="text-align: center; font-size: 20px;">' + title + '</h3>',
                                                '<table class="layui-table tg_table"></table>',
                                                '</div>'
                                            ].join(''),
                                            success: function () {
                                                $.get('/targetManage/getChildTarByTgId', {tgId: tgId}, function (res) {
                                                    if (res.flag && res.data) {
                                                        var tgData = res.data
                                                        var str = [
                                                            '<tr>' +
                                                            '<td class="td_title">目标名称:</td><td>' + checkNull(tgData.tgName) + '</td>' +
                                                            '<td class="td_title">编号:</td><td>' + checkNull(tgData.tgNo) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">分项权重:</td><td>' + addData(checkNull(tgData.itemWeight)) + '</td>' +
                                                            '<td class="td_title">目标类型:</td><td>' + checkNull(tgData.tgType) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">单项权重:</td><td>' + addData(checkNull(tgData.individualWeight)) + '</td>' +
                                                            '<td class="td_title">单项分值:</td><td>' + checkNull(tgData.individualScore) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">一季度目标（万元）:</td><td>' + checkNull(tgData.firstQuarterTarget) + '</td>' +
                                                            '<td class="td_title">一季度完成值（万元）:</td><td>' + checkNull(tgData.firstQuarterFinish) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">二季度目标（万元）:</td><td>' + checkNull(tgData.secondQuarterTarget) + '</td>' +
                                                            '<td class="td_title">二季度完成值（万元）:</td><td>' + checkNull(tgData.secondQuarterFinish) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">三季度目标（万元）:</td><td>' + checkNull(tgData.thirdQuarterTarget) + '</td>' +
                                                            '<td class="td_title">三季度完成值（万元）:</td><td>' + checkNull(tgData.thirdQuarterFinish) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">四季度目标（万元）:</td><td>' + checkNull(tgData.fourQuarterTarget) + '</td>' +
                                                            '<td class="td_title">四季度完成值（万元）:</td><td>' + checkNull(tgData.fourQuarterFinish) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">年度目标值（万元）:</td><td>' + checkNull(tgData.annualTarger) + '</td>' +
                                                            '<td class="td_title">年度完成值（万元）:</td><td>' + checkNull(tgData.annualFinish) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">数据来源部门:</td><td>' + checkNull(tgData.sourcesDeptName) + '</td>' +
                                                            '<td class="td_title">数据复核部门:</td><td>' + checkNull(tgData.checkDeptName) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">年度:</td><td>' + checkNull(tgData.belongYear) + '</td>' +
                                                            '<td class="td_title">一级指标类型:</td><td>' + checkNull(tgData.tgTypeParent) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">所属部门:</td><td>' + checkNull(tgData.belongDeptName) + '</td>' +
                                                            '<td class="td_title">目标执行状态:</td><td>' + function () {
                                                                var str = ''
                                                                if (tgData.tgStatus == 0) {
                                                                    str = '编辑'
                                                                } else if (tgData.tgStatus == 1) {
                                                                    str = '分解'
                                                                } else if (tgData.tgStatus == 2) {
                                                                    str = '季度填报'
                                                                } else if (tgData.tgStatus == 3) {
                                                                    str = '年度填报'
                                                                }
                                                                return str
                                                            }() + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">指标说明:</td><td colspan="3">' + checkNull(tgData.tempDesc) + '</td>' +
                                                            '</tr>',
                                                            '<tr>' +
                                                            '<td class="td_title">支撑材料:</td><td colspan="3">' + checkFile(tgData.attachments) + '</td>' +
                                                            '</tr>',
                                                        ]

                                                        $('.tg_table').html(str.join(''))
                                                    }
                                                })
                                            }
                                        })
                                    })
                                }
                            })
                        }
                    })
                })

				// 数值转换为千分位用逗号分隔
				function numFormat(num) {
					num=num.toString().split(".");  // 分隔小数点
					var arr=num[0].split("").reverse();  // 转换成字符数组并且倒序排列
					var res=[];
					for(var i=0,len=arr.length;i<len;i++){
						if(i%3===0&&i!==0){
							res.push(",");   // 添加分隔符
						}
						res.push(arr[i]);
					}
					res.reverse(); // 再次倒序成为正确的顺序
					if(num[1]){  // 如果有小数的话添加小数部分
						res=res.join("").concat("."+num[1]);
					}else{
						res=res.join("");
					}
					return res;
				}

                function updateFunc(checkData, approvalStatus, confirmIndex) {
                    submitLock = true
                    var updateData = []
                    checkData.forEach(function (item) {
                        var obj = {
                            approvalId: item.approvalId,
                            approvalStatus: approvalStatus
                        }
                        updateData.push(obj)
                    })

                    $.ajax({
                        url: '/targetApproval/updateApprivalStatus',
                        type: 'POST',
                        contentType: "application/json",
                        data: JSON.stringify(updateData),
                        success: function (res) {
                            layer.close(confirmIndex)
                            if (res.flag) {
                                layer.msg('审批成功', {icon: 1, time: 1500})
                                initTable(0)
                            } else {
                                layer.msg('审批失败', {icon: 2, time: 1500})
                            }
                            submitLock = false
                        },
                        error: function () {
                            layer.close(confirmIndex)
                            layer.msg('审批失败', {icon: 2, time: 1500})
                            submitLock = false
                        }
                    })
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
            })

            function checkNull(val) {
                return !!val ? val : ''
            }
            function addData(data) {
				return data+'%'
			}
		</script>
	</body>
</html>
