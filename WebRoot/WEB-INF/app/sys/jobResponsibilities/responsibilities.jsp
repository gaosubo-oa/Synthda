<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/1/15
  Time: 10:39
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
		<title>职责管理</title>
		
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		
		<script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
		<script type="text/javascript" src="/js/base/base.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
		
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
				padding-top: 46px;
				box-sizing: border-box;
			}
			
			.wrapper {
				position: relative;
				width: 100%;
				height: 100%;
				padding: 8px;
				box-sizing: border-box;
			}
			
			.wrap_left {
				position: relative;
				float: left;
				width: 230px;
				height: 100%;
				padding-right: 10px;
				box-sizing: border-box;
			}
			
			.wrap_right {
				position: relative;
				height: 100%;
				margin-left: 230px;
				overflow: auto;
			}
			
			.header {
				position: absolute;
				top: 0px;
				left: 0px;
				width: 100%;
				height: 45px;
				border-bottom: 1px solid #999;
				background: #fff;
				overflow: hidden;
				z-index: 2;
			}
			
			.list_item {
				position: relative;
				height: 32px;
				line-height: 32px;
				padding: 0 20px;
				cursor: pointer;
			}
			
			.list_item.active {
				background-color: #d6f3ff;
			}
			
			.list_item.active:before {
				position: absolute;
				top: 0;
				left: 0;
				content: "";
				height: 100%;
				width: 5px;
				background-color: #3f73c4;
			}
			
			.list_item:hover {
				background-color: #d6f3ff;
			}
			
			.list_item:hover:before {
				position: absolute;
				top: 0;
				left: 0;
				content: "";
				height: 100%;
				width: 5px;
				background-color: #3f73c4;
			}
			
			.wrap_left .left_form {
				position: relative;
				overflow: hidden;
			}
			
			.left_form .layui-input {
				height: 35px;
				padding-right: 25px;
			}
			
			.tree_module {
				position: absolute;
				top: 45px;
				right: 10px;
				bottom: 0;
				left: 10px;
				overflow: auto;
				box-sizing: border-box;
				border-right: 1px solid #ccc;
			}
			
			.eleTree-node-content {
				overflow: hidden;
				word-break: break-all;
				white-space: nowrap;
				text-overflow: ellipsis;
			}
			
			.search_icon {
				position: absolute;
				top: 0;
				right: 0;
				height: 35px;
				width: 25px;
				padding-top: 8px;
				text-align: center;
				cursor: pointer;
				box-sizing: border-box;
			}
			
			.search_icon:hover {
				color: #0aa3e3;
			}
			
			.label_item {
				padding: 8px 0;
				text-align: center;
			}
			
			.label_ttile {
				display: inline-block;
				width: 100px;
				text-align: left;
			}
			
			.label_con {
				display: inline-block;
				width: 40%;
				min-width: 300px;
				border-bottom: 1px solid #eee;
				text-align: left;
			}

            .button_box {
                padding-bottom: 5px;
                border-bottom: 1px solid #eee;
            }

            .content {
                position: absolute;
                top: 35px;
                left: 0;
                right: 0;
                bottom: 0;
                overflow: auto;
            }

            .scorll_bar {
                position: absolute;
                top: 35px;
                right: 0;
	            bottom: 0;
                width: 30px;
                background-color: #fff;
                z-index: 1;
            }

            .content fieldset {
	            margin-top: 10px;
                border: none;
                border-top: 1px solid #eee;
            }

            .history_box .label_con {
	            border: none;
            }
		</style>
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftId">
			<div class="header">
				<div class="headImg" style="padding-top: 7px">
					<span style="font-size:22px; margin-left:10px; color:#494d59; margin-top: 2px">
						<img style="margin-left:1.5%; margin-top: -3px;" src="/img/commonTheme/theme6/icon_summary.png">
						<span style="margin-left: 10px">职责管理</span>
					</span>
				</div>
			</div>
			<div class="wrapper">
				<div class="wrap_left" style="border-right: 1px solid #ccc;">
					<div class="list_module">
						<ul class="list_ul"></ul>
					</div>
				</div>
				<div class="wrap_right">
					<div class="wrap_left" style="width: 300px; padding: 0 10px;">
						<div class="left_form">
							<div class="search_icon">
								<i class="layui-icon layui-icon-search"></i>
							</div>
							<input type="text" name="title" id="search_project" placeholder="请输入职责名称" autocomplete="off" class="layui-input"/>
						</div>
						<div class="tree_module">
							<div id="leftTree" class="eleTree" lay-filter="leftTree"></div>
						</div>
					</div>
					<div class="wrap_right" style="margin-left: 300px;">
						<div class="button_box">
							<button id="new" type="button" class="layui-btn layui-btn-sm">新增</button>
							<button id="edit" type="button" class="layui-btn layui-btn-sm layui-btn-warm">编辑</button>
							<button id="del" type="button" class="layui-btn layui-btn-sm layui-btn-danger">删除</button>
							<a href="/sys/responsibilitiesDetails" target="_blank" type="button" class="layui-btn layui-btn-sm layui-btn-normal">统计列表</a>
						</div>
						<div class="content">
							<fieldset class="layui-elem-field">
								<legend>基本信息</legend>
							</fieldset>
							<div class="base_info">
								<div class="label_item">
									<div class="label_ttile"><span>职责名称：</span></div>
									<div class="label_con"><span class="duty_name"></span></div>
								</div>
								<div class="label_item">
									<div class="label_ttile"><span>职责类型：</span></div>
									<div class="label_con"><span class="duty_type"></span></div>
								</div>
								<div class="label_item">
									<div class="label_ttile"><span>上级职责：</span></div>
									<div class="label_con"><span class="duty_parent"></span></div>
								</div>
								<div class="label_item">
									<div class="label_ttile"><span>职责等级：</span></div>
									<div class="label_con"><span class="duty_grade"></span></div>
								</div>
								<div class="label_item duty_desc_box" style="display: none;">
									<div class="label_ttile"><span>关联岗位：</span></div>
									<div class="label_con"><span class="job_ids"></span></div>
								</div>
								<div class="label_item duty_desc_box" style="display: none;">
									<div class="label_ttile"><span>详细职责描述：</span></div>
									<div class="label_con">
										<pre class="duty_desc"></pre>
									</div>
								</div>
							</div>
							<fieldset class="layui-elem-field">
								<legend>历史版本</legend>
							</fieldset>
							<div class="history_box">
								<ul class="layui-timeline history_ul"></ul>
							</div>
						</div>
					</div>
					<div class="scorll_bar"></div>
				</div>
			</div>
		</div>
		
		<script>
			var jobsList = [];
			var btnLock = true;
			// 获取全部岗位
			$.get('/position/selectUserJob', function(res) {
			    if (res.flag) {
			        jobsList = res.obj;
			    }
			    btnLock = false;
			});

            layui.use(['eleTree', 'form', 'xmSelect'], function () {
                var form = layui.form,
                    eleTree = layui.eleTree,
                    xmSelect = layui.xmSelect;

                var dutyInfo = null;
                var dutyTreeData = [];
                var eleTreeObj = null;

                $.get('/code/getCode?parentNo=INSTITUTION_SORT_LEVEL', function (res) {
                    var str = '';
                    if (res.flag && res.obj.length > 0) {
                        res.obj.forEach(function (item) {
                            str += '<li class="list_item" code_no="' + item.codeNo + '" code_name="' + item.codeName + '"><span>' + item.codeName + '</span></li>';
                        });
                        projectLeft(res.obj[0].codeNo);
                        $('#leftId').attr('codeNo', res.obj[0].codeNo);
                        $('#leftId').attr('codeName', res.obj[0].codeName);
                    }
                    $('.list_ul').html(str);
                    $('.list_item').eq(0).addClass('active');
                });
                $(document).on('click', '.list_item', function () {
                    $(this).siblings().removeClass('active');
                    $(this).addClass('active');
                    var codeNo = $(this).attr('code_no');
                    var codeName = $(this).attr('code_name');
                    projectLeft(codeNo);
                    $('#leftId').attr('codeNo', codeNo);
                    $('#leftId').attr('codeName', codeName);
                    $('#search_project').val('');
                });

                // 加载树
                function projectLeft(codeNo, dutyName) {
                    dutyName = dutyName ? dutyName : '';
                    var loadingIndex = layer.load();
                    clearContent();
                    $.get('/userJobDuty/getUserJobDutyTree', {dutyType: codeNo, dutyName: dutyName}, function (res) {
                        layer.close(loadingIndex);
                        if (res.flag) {
                            dutyTreeData = res.data;
                            eleTreeObj = eleTree.render({
                                elem: '#leftTree',
                                data: dutyTreeData,
                                highlightCurrent: true,
                                showLine: true,
                                defaultExpandAll: true,
                                request: {
                                    name: 'dutyName',
                                    children: "child",
                                }
                            });
                        }
                    });
                }

                // 树节点点击事件
                eleTree.on("nodeClick(leftTree)", function (d) {
                    dutyInfo = JSON.parse(JSON.stringify(d.data.currentData));

                    getDutyHistory(dutyInfo);

                    $('#leftId').attr('dutyId', dutyInfo.dutyId);
                    $('.duty_name').text(dutyInfo.dutyName);
                    $('.duty_type').text($('#leftId').attr('codeName'));

                    $('.duty_grade').text(dutyInfo.dutyGrade);

                    if (dutyInfo.isFinalNode == 0) {
                        $('.duty_desc_box').show(function () {
                            $('.duty_desc').text(dutyInfo.dutyDesc);
                            $('.job_ids').text(dutyInfo.jobNames);
                        });
                    } else {
                        $('.duty_desc_box').hide();
                    }
                    var parentNode = searchTree(dutyInfo.dutyParent, dutyTreeData);
                    $('.duty_parent').text(parentNode ? parentNode.dutyName : '顶级职责');
                });

                var searchTimer = null;
                $('#search_project').on('input propertychange', function () {
                    clearTimeout(searchTimer);
                    searchTimer = null;
                    var val = $(this).val();
                    searchTimer = setTimeout(function () {
                        var codeNo = $('#leftId').attr('codeNo');
                        projectLeft(codeNo, val);
                        clearTimeout(searchTimer);
                        searchTimer = null;
                    }, 500);
                });

                // 新增职责
                $('#new').on('click', function () {
                    newOrEdit(1);
                });
                // 编辑职责
                $('#edit').on('click', function () {
                    if (btnLock) {
                        return false;
                    }
                    var dutyId = $('#leftId').attr('dutyId');
                    if (!dutyId || !dutyInfo) {
                        layer.msg('请选择需要编辑的职责！', {icon: 0, time: 2000});
                        return false;
                    }
                    newOrEdit(2);
                });
                // 删除职责
                $('#del').on('click', function () {
                    var dutyId = $('#leftId').attr('dutyId');
                    if (!dutyId || !dutyInfo) {
                        layer.msg('请选择需要删除的职责！', {icon: 0, time: 2000});
                        return false;
                    }
                    layer.confirm('确定删除该职责吗？', function (index) {
                        $.post('/userJobDuty/delUserJobDuty', {dutyId: dutyId}, function (res) {
                            layer.close(index);
                            if (res.flag) {
                                layer.msg('删除成功！', {icon: 1});
                                var codeNo = $('#leftId').attr('codeNo');
                                projectLeft(codeNo);
                                dutyInfo = null;
                                $('#leftId').attr('dutyId', '');
                            } else {
                                layer.msg('删除失败！', {icon: 2});
                            }
                        })
                    });
                });

                function newOrEdit(type) {
                    var title = '';
                    var url = '';
                    var str = '';
                    if (type == 1) {
                        title = '新增职责';
                        url = '/userJobDuty/addUserJobDuty';
                    } else if (type == 2) {
                        title = '编辑职责';
                        url = '/userJobDuty/updateUserJobDuty';
                        if (dutyInfo.isFinalNode == 0) {
                            str = '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label" style="width: 95px;padding-left: 0;">关联岗位</label>\n' +
                                '                       <div class="layui-input-block">' +
                                '                       <div id="userJobs" class="xm-select-demo" style="width: 100%;"></div>' +
                                '                       </div>' +
                                '                   </div>' +
                                '                   <div class="layui-form-item">' +
                                '                       <label class="layui-form-label" style="width: 95px;padding-left: 0;">详细职责描述</label>\n' +
                                '                       <div class="layui-input-block">' +
                                '                       <textarea name="dutyDesc" rows="5" placeholder="详细职责描述" class="layui-textarea"></textarea>' +
                                '                       </div>' +
                                '                   </div>';
                        }
                    }
                    var dutyId = dutyInfo ? dutyInfo.dutyId : '';
                    var newData = getData(dutyTreeData, dutyId);
                    var codeNo = $('#leftId').attr('codeNo');
                    var codeName = $('#leftId').attr('codeName');
                    var dutyParent = null;
                    var userJobs = null;

                    layer.open({
                        type: 1,
                        title: title,
                        area: ['70%', '80%'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<form class="layui-form" style="padding: 20px 200px;">' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label">职责类型</label>\n' +
                            '                       <div class="layui-input-block">\n' +
                            '                       <input type="text" value="' + codeName + '" readonly autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label">职责名称<span style="font-weight: 600; font-size: 16px; color: red;">*</span></label>\n' +
                            '                       <div class="layui-input-block">\n' +
                            '                       <input type="text" name="dutyName" autocomplete="off" class="layui-input">\n' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label">上级职责</label>\n' +
                            '                       <div class="layui-input-block">\n' +
                            '                       <div id="dutyParent" class="xm-select-demo" style="width: 100%;"></div>' +
                            '                       </div>\n' +
                            '                   </div>' +
                            '                   <div class="layui-form-item">\n' +
                            '                       <label class="layui-form-label">职责等级<span style="font-weight: 600; font-size: 16px; color: red;">*</span></label>\n' +
                            '                       <div class="layui-input-block">\n' +
                            '                       <input type="text" name="dutyGrade" autocomplete="off" class="layui-input input_number">\n' +
                            '                       </div>\n' +
                            '                   </div>' + str +
                            '</form>',
                        success: function () {
                            form.render();

                            dutyParent = xmSelect.render({
                                el: '#dutyParent',
                                filterable: true,
                                radio: true,
                                clickClose: true,
                                toolbar: {
                                    show: true,
                                },
                                name: 'dutyParent',
                                prop: {
                                    name: 'dutyName',
                                    value: 'dutyId'
                                },
                                data: newData
                            });

                            if (type == 2) {
                                $('input[name="dutyName"]').val(dutyInfo.dutyName);
                                $('input[name="dutyGrade"]').val(dutyInfo.dutyGrade);
                                $('textarea[name="dutyDesc"]').val(dutyInfo.dutyDesc);
                                dutyParent.setValue([dutyInfo.dutyParent]);

                                if (dutyInfo.isFinalNode == 0) {
                                    userJobs = xmSelect.render({
                                        el: '#userJobs',
                                        filterable: true,
                                        toolbar: {
                                            show: true,
                                        },
                                        name: 'jobIds',
                                        prop: {
                                            name: 'jobName',
                                            value: 'jobId'
                                        },
                                        data: jobsList
                                    });
                                    var jobArr = (dutyInfo.jobIds || '').split(',');
                                    userJobs.setValue(jobArr);
                                }
                            }
                        },
                        yes: function (index) {
                            var loadIndex = layer.load();

                            var data = {
                                dutyName: $('input[name="dutyName"]').val(),
                                dutyType: codeNo,
                                dutyGrade: $('input[name="dutyGrade"]').val(),
                                dutyParent: dutyParent.getValue('valueStr') || '0'
                            }

                            if (type == 2) {
                                data.dutyId = dutyInfo.dutyId;
                                if (dutyInfo.isFinalNode == 0) {
                                    data.dutyDesc = $('textarea[name="dutyDesc"]').val();
                                    data.jobIds = userJobs.getValue('valueStr') || '';
                                }
                            }

                            if (!data.dutyName) {
                                layer.msg('请输入职责名称！', {icon: 0, time: 1500});
                                layer.close(loadIndex);
                                return false;
                            }

                            if (!data.dutyGrade) {
                                layer.msg('请输入职责等级！', {icon: 0, time: 1500});
                                layer.close(loadIndex);
                                return false;
                            }

                            $.post(url, data, function (res) {
                                layer.close(loadIndex);
                                if (res.flag) {
                                    layer.msg('保存成功！', {icon: 1, time: 1500});
                                    layer.close(index);
                                    projectLeft(codeNo);
                                } else {
                                    layer.msg('保存失败！', {icon: 2, time: 1500});
                                }
                            });
                        }
                    });
                }

                /**
                 * 获取历史版本
                 * @param dutyInfo
                 */
                function getDutyHistory(dutyInfo) {
                    $.get('/userJobDuty/getUserJobDutyHistory', {dutyId: dutyInfo.dutyId}, function (res) {
                        var str = '';
                        if (res.flag && res.object.length > 0) {
                            res.object.forEach(function (item) {
                                var str1 = '';
								if (dutyInfo.isFinalNode == 0) {
								    str1 = '<div>' +
								        '<div class="label_ttile"><span>关联岗位：</span></div>' +
								        '<div class="label_con"><span>' + (item.jobNames || '') + '</span></div>' +
								        '</div>' +
								        '<div style="overflow: hidden;">' +
								        '<div class="label_ttile" style="float: left;"><span>详细职责描述：</span></div>' +
								        '<div class="label_con">' +
								        '<pre>' + (item.dutyDesc || '') + '</pre>' +
								        '</div>' +
								        '</div>';
								}
                                str += '<li class="layui-timeline-item">' +
                                    '<i class="layui-icon layui-timeline-axis">&#xe63f;</i>' +
                                    '<div class="layui-timeline-content layui-text">' +
                                    '<h3 class="layui-timeline-title">' + format(item.createTime) + '</h3>' +
                                    '<div>' +
                                    '<div class="label_ttile"><span>职责名称：</span></div>' +
                                    '<div class="label_con"><span>' + (item.dutyName || '') + '</span></div>' +
                                    '</div>' +
                                    '<div>' +
                                    '<div class="label_ttile"><span>职责类型：</span></div>' +
                                    '<div class="label_con"><span>' + ($('#leftId').attr('codeName') || '') + '</span></div>' +
                                    '</div>' +
                                    '<div>' +
                                    '<div class="label_ttile"><span>上级职责：</span></div>' +
                                    '<div class="label_con"><span>' + function () {
                                        var parentNode = searchTree(item.dutyParent, dutyTreeData);
                                        return parentNode ? parentNode.dutyName : '顶级职责';
                                    }() + '</span></div>' +
                                    '</div>' +
                                    '<div>' +
                                    '<div class="label_ttile"><span>职责等级：</span></div>' +
                                    '<div class="label_con"><span>' + (item.dutyGrade || '') + '</span></div>' +
                                    '</div>' + str1 +
                                    '</div>' +
                                    '</li>';
                            });
                        }
                        $('.history_ul').html(str);
                    });
                }
            });

            //监听键盘事件，部门排序只能输入数字
            $(document).on('keypress', '.input_number', function (e) {
                var key = window.event ? e.keyCode : e.which;

                if (!((key > 95 && key < 106) || (key > 47 && key < 58) || key == 8 || key == 9 || key == 13 || key == 37 || key == 39)) {
                    return false;
                }
            })
            // 监听输入内容
            $(document).on('input propertychange', '.input_number', function (event) {
                var value = parseInt($(this).val());
                if (isNaN(value)) {
                    $(this).val('');
                } else {
                    $(this).val(value);
                }
            });

            function getData(data, filterId, parentStr) {
                var arr = []
                if (!!data && data.length > 0) {
                    data.forEach(function (item) {
                        if (filterId != item.dutyId) {
                            var obj = {
                                dutyId: item.dutyId,
                                dutyName: parentStr ? parentStr + '/' + item.dutyName : item.dutyName
                            }
                            arr.push(obj)
                            if (item.child && item.child.length > 0) {
                                var childArr = getData(item.child, filterId, item.dutyName);
                                arr = arr.concat(childArr);
                            }
                        }
                    })
                }
                return arr;
            }

            /**
             * 查找树结构指定节点
             * @param tree (树数据)
             * @param dutyId (节点id)
             * @returns {any|null}
             */
            function searchTree(dutyId, tree) {
                var node = null;
                if (tree && tree.length > 0) {
                    for (var i = 0; i < tree.length; i++) {
                        if (tree[i].dutyId == dutyId) {
                            node = tree[i];
                            break;
                        } else {
                            if (tree[i].child && tree[i].child.length > 0) {
                                node = searchTree(dutyId, tree[i].child);
                            }
                        }
                    }
                }
                return node;
            }

            function clearContent() {
                $('.duty_name').text('');
                $('.duty_type').text('');
                $('.duty_grade').text('');
                $('.duty_desc').text('');
                $('.job_ids').text('');
                $('.duty_desc_box').hide();
                $('.duty_parent').text('');
                $('.history_ul').empty();
            }

            /**
             * 将毫秒数转为yyyy-MM-dd格式时间
             * @param t
             * @returns {string|*}
             */
            function format(t) {
                if (t) {
                    return new Date(t).Format("yyyy年MM月dd hh:mm");
                } else {
                    return '';
                }
            }
		</script>
	</body>
</html>
