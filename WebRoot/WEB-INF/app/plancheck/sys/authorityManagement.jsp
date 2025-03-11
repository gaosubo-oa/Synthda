<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/7/16
  Time: 11:18
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
		<title>权限管理</title>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		
		<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
		<link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
		<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
		<script type="text/javascript" src="/lib/layui/layui/layui.all.js?<%=datetime%>"></script>
		<script type="text/javascript" src="/lib/layui/layui/global.js?<%=datetime%>"></script>
		<script type="text/javascript" src="/js/base/base.js?<%=datetime%>"></script>
		
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
		</style>
		
<%--		<script type="text/javascript">--%>
<%--            var funcUrl = location.pathname;--%>
<%--            var authorityObject = null;--%>
<%--            if (funcUrl) {--%>
<%--                $.ajax({--%>
<%--                    type: 'GET',--%>
<%--                    url: '/plcPriv/findPermissions',--%>
<%--                    data: {--%>
<%--                        funcUrl: funcUrl--%>
<%--                    },--%>
<%--                    dataType: 'json',--%>
<%--                    async: false,--%>
<%--                    success: function (res) {--%>
<%--                        if (res.flag) {--%>
<%--                            if (res.object && res.object.length > 0) {--%>
<%--                                authorityObject = {}--%>
<%--                                res.object.forEach(function (item) {--%>
<%--                                    authorityObject[item] = item;--%>
<%--                                });--%>
<%--                            }--%>
<%--                        }--%>
<%--                    },--%>
<%--                    error: function () {--%>

<%--                    }--%>
<%--                });--%>
<%--            }--%>
<%--		</script>--%>
	
	</head>
	<body>
		<div class="container">
			<input type="hidden" id="leftTreeId">
			<input type="hidden" id="leftTreeName">
		<%--	<div class="header">
				<div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px">
						<img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt="">
						<span style="margin-left: 10px">权限设置</span>
					</span>
				</div>
			</div>
			<hr>--%>
			
			<div class="content">
				<div style="padding: 0px 20px;" class="clearfix">
					<div class="con_left">
						<div class="layui-card">
							<div class="layui-card-header" style="font-size: 20px;">计划考核</div>
							<div class="layui-card-body">
								<!-- 左侧计划考核菜单 -->
								<div class="eleTree left_tree" lay-filter="leftTree"></div>
							</div>
						</div>
					</div>
					<div class="con_right">
						<div class="layui-card">
							<div class="layui-card-header" style="font-size: 18px;">
								<h4 class="menu_name">菜单名称</h4>
							</div>
							<div class="layui-card-body" id="rightContent" style="box-sizing: border-box;overflow: hidden;">
								<div class="tip" style="height: 100%;text-align: center;border: none;">
									<div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;" src="/img/noData.png" alt=""></div>
									<h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧子级菜单</h2>
								</div>
								<div class="card_content" style="display: none;height: 100%; overflow-y: auto;">
									<form class="layui-form authority_add">
										<div class="layui-form-item">
											<label class="layui-form-label">权限</label>
											<div class="layui-input-block option_check_box">
												<p><input type="checkbox" class="priv_option_all" lay-skin="primary" title="全选" lay-filter="checkOptionAll"></p>
												<p class="plan_check_option"></p>
											</div>
										</div>
										<div class="layui-form-item">
											<label class="layui-form-label">授权部门</label>
											<div class="layui-input-block clearfix" style="overflow: hidden;">
												<textarea placeholder="请选择授权部门" id="privDept" readonly class="layui-textarea"
												          style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
												<div style="float: left; margin-top: 20px;" t_id="privDept">
													<a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_dept">添加</a>
													<a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_dept">清空</a>
												</div>
											</div>
										</div>
										<div class="layui-form-item">
											<label class="layui-form-label">授权角色</label>
											<div class="layui-input-block clearfix" style="overflow: hidden;">
												<textarea placeholder="请选择授权角色" id="privRole" readonly class="layui-textarea"
												          style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
												<div style="float: left; margin-top: 20px;" t_id="privRole">
													<a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_role">添加</a>
													<a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_role">清空</a>
												</div>
											</div>
										</div>
										<div class="layui-form-item">
											<label class="layui-form-label">授权人员</label>
											<div class="layui-input-block clearfix" style="overflow: hidden;">
												<textarea placeholder="请选择授权人员" id="privUser" readonly class="layui-textarea"
												          style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
												<div style="float: left; margin-top: 20px;" t_id="privUser">
													<a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_user">添加</a>
													<a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_user">清空</a>
												</div>
											</div>
										</div>
										<div class="layui-form-item">
											<button type="button" class="layui-btn" id="saveBtn" style="margin-left: 40%;">保存</button>
											<button type="reset" class="layui-btn" id="resetBtn">重置</button>
										</div>
									</form>
									<table id="optionTable" lay-filter="optionTable"></table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/html" id="optionBar">
<%--			{{#  if(authorityObject && authorityObject['05']){ }}--%>
			<a class="layui-btn layui-btn-xs" lay-event="update">编辑</a>
<%--			{{#  } }}--%>
<%--			{{#  if(authorityObject && authorityObject['04']){ }}--%>
			<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="delete">删除</a>
<%--			{{#  } }}--%>
		</script>
		
		<script type="text/javascript">
			
			// initAuthority();
			
			resizeSize();
			
			window.onresize = resizeSize;

            var dept_id = '';
            var priv_id = '';
            var user_id = '';

            layui.use(['table', 'form', 'eleTree'], function () {
                var table = layui.table,
                    form = layui.form,
                    eleTree = layui.eleTree;

                var optionTable = null;
                var optionStr = '';
                
                form.render();

                // 添加授权部门
                $(document).on('click', '.add_dept', function(){
                    dept_id = $(this).parent().attr('t_id');
                    $.popWindow("/common/selectDept?allDept=1");
                });
                // 清空授权部门
	            $(document).on('click', '.clear_dept', function(){
	                var id = $(this).parent().attr('t_id')
                    $('#'+id).val('');
                    $('#'+id).attr('deptid', '');
	            });

                // 添加授权角色
	            $(document).on('click', '.add_role', function(){
	                priv_id = $(this).parent().attr('t_id');
                    $.popWindow("/common/selectPriv");
	            });
                // 清空授权角色
	            $(document).on('click', '.clear_role', function(){
	                var id = $(this).parent().attr('t_id')
                    $('#'+id).val('');
                    $('#'+id).attr('privid', '');
	            });

                // 添加授权人员
	            $(document).on('click', '.add_user', function(){
	                user_id = $(this).parent().attr('t_id');
                    $.popWindow("/common/selectUser");
	            });
                // 清空授权人员
	            $(document).on('click', '.clear_user', function(){
	                var id = $(this).parent().attr('t_id')
                    $('#'+id).val('');
                    $('#'+id).attr('user_id', '');
	            });
				
	            // 全选
	            form.on('checkbox(checkOptionAll)', function(data){
	                var $parent = $(data.elem).parents('.option_check_box');
	                $parent.find('.priv_option').prop('checked', data.elem.checked);
	                form.render();
                });
	            
	            // 单选
                form.on('checkbox(checkOption)', function (data) {
                    var $parent = $(data.elem).parents('.option_check_box');
                    if (data.elem.checked) {
                        var count = $parent.find('.priv_option:checked').length;
                        if (count == $parent.find('.priv_option').length) {
                            $parent.find('.priv_option_all').prop("checked", true);
                        }else{
                            $parent.find('.priv_option_all').prop("checked", false);
                        }
                    } else {
                        $parent.find('.priv_option_all').prop('checked', false);
                    }
                    form.render();
                });
	            
                // 保存对应菜单权限设置
                $('#saveBtn').on("click",function (event) {
                    var loadingIndex = layer.load();
                    //阻止默认浏览器动作(W3C) 
                    if (event && event.preventDefault) {
                        event.preventDefault();
                    } else {//IE中阻止函数器默认动作的方式
                        window.event.returnValue = false;
                    }
                    
                    var privStr = '';
                    var $checkOptions = $('.priv_option:checked');
                    
                    $checkOptions.each(function(index, ele){
                        var optionNo = $(ele).attr('name');
                        privStr += optionNo + ',';
                    });
	                
                    var funcId = $('#leftTreeId').val(); // 菜单id
                    var funcName = $('#leftTreeName').val(); // 菜单名称
                    var userPriv = $('#privUser').attr('user_id') || '';
                    var deptPriv = $('#privDept').attr('deptid') || '';
                    var rolePriv = $('#privRole').attr('privid') || '';

                    var data = {
                        funcId: funcId,
                        funcName: funcName,
                        privStr: privStr,
                        userPriv: userPriv,
                        deptPriv: deptPriv,
                        rolePriv: rolePriv
                    };

                    $.post('/plcPriv/add', data, function (res) {
                        layer.close(loadingIndex);
						if (res.flag) {
						    layer.msg('保存成功', {icon: 1, time: 1000});
						    $('#resetBtn').trigger('click');
						    initOptionTable(funcId);
						} else {
						    layer.msg('保存失败', {icon: 2, time: 1000});
						}
                    });
                });
                
                // 重置表单
                $('#resetBtn').on("click",function () {
                    $('#privUser').attr('user_id', '');
                    $('#privUser').val('');
                    $('#privDept').attr('deptid', '');
                    $('#privDept').val('');
                    $('#privRole').attr('privid', '');
                    $('#privRole').val('');
                });

                // 获取计划考核所有菜单
                $.get('/findChildMenu?id=74', function (res) {
                    if (res.flag) {
                        eleTree.render({
                            elem: '.left_tree',
                            data: res.obj,
                            highlightCurrent: true,
                            showLine: true,
                            accordion: true, // 手风琴效果
                            request: {
                                name: 'name',
                                children: "child",
                            }
                        });
                    }
                });

                // 树节点点击事件
                eleTree.on("nodeClick(leftTree)", function (d) {
                    var currentData = d.data.currentData;
                    if (currentData.child && currentData.child.length > 0) {
						$('.menu_name').text(currentData.name);
                        $('#leftTreeId').val('');
                        $('#leftTreeName').val('');
	                    $('.tip').show();
                        $('.card_content').hide();
                    } else {
                        $('.tip').hide();
                        $('.card_content').show();
                        $('.menu_name').text(currentData.name + '权限设置');
                        $('#leftTreeId').val(currentData.fId);
                        $('#leftTreeName').val(currentData.name);
                        initForm(currentData.fId);
                        initOptionTable(currentData.fId);
                    }
                });
	            
                /**
                 * 初始化权限列表
                 * @param funcId (菜单id)
                 */
                function initOptionTable(funcId) {
                    if (!optionTable) {
                        optionTable = table.render({
                            elem: '#optionTable',
                            url: '/plcPriv/query',
                            page: true,
                            limit: 5,
                            limits: [5, 10, 20],
                            cols: [[
                                {field: 'funcName', title: '功能菜单', width: 160},
                                {field: 'privStrName', title: '权限'},
                                {field: 'deptPrivName', title: '授权部门'},
                                {field: 'rolePrivName', title: '授权角色'},
                                {field: 'userPrivName', title: '授权用户'},
                                {title: '操作', fixed: 'right', align: 'center', width: 120, toolbar: '#optionBar'}
                            ]],
                            where: {
                                funcId: funcId,
                                _: new Date().getTime()
                            },
                            request: {
                                limitName: 'pageSize'
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                countName: 'totleNum',
                                dataName: 'obj'
                            }
                        });
                    } else {
                        optionTable.reload({
                            where: {
                                funcId: funcId,
                                _: new Date().getTime()
                            },
                            page: {
                                curr: 1
                            }
                        });
                    }
                }
                
                table.on('tool(optionTable)', function(obj){
					var data = obj.data;
                    switch (obj.event) {
                        case 'update':
                            layer.open({
                                type: 1,
                                title: '修改权限',
                                area: ['900px', '700px'],
                                btn: ['保存', '取消'],
                                content: '<div id="editOptionBox" style="width: 80%;margin: 0 auto;"><form class="layui-form">' +
                                    '<div class="layui-form-item">' +
                                    '<label class="layui-form-label">权限</label>' +
                                    '<div class="layui-input-block option_check_box">' +
                                    '<p><input type="checkbox" class="priv_option_all" lay-skin="primary" lay-filter="checkOptionAll" title="全选"></p>' +
                                    '<p class="plan_check_option"></p>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div class="layui-form-item">' +
                                    '<label class="layui-form-label">授权部门</label>' +
                                    '<div class="layui-input-block clearfix" style="overflow: hidden;">' +
                                    '<textarea placeholder="请选择授权部门" id="editPrivDept" readonly class="layui-textarea" style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>' +
                                    '<div style="float: left; margin-top: 20px;" t_id="editPrivDept">' +
                                    '<a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_dept">添加</a>' +
                                    '<a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_dept">清空</a>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div class="layui-form-item">' +
                                    '<label class="layui-form-label">授权角色</label>' +
                                    '<div class="layui-input-block clearfix" style="overflow: hidden;">' +
                                    '<textarea placeholder="请选择授权角色" id="editPrivRole" readonly class="layui-textarea" style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>' +
                                    '<div style="float: left; margin-top: 20px;" t_id="editPrivRole">' +
                                    '<a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_role">添加</a>' +
                                    '<a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_role">清空</a>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '<div class="layui-form-item">' +
                                    '<label class="layui-form-label">授权人员</label>' +
                                    '<div class="layui-input-block clearfix" style="overflow: hidden;">' +
                                    '<textarea placeholder="请选择授权人员" id="editPrivUser" readonly class="layui-textarea" style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>' +
                                    '<div style="float: left; margin-top: 20px;" t_id="editPrivUser">' +
                                    '<a href="javascript:;" style="margin-left: 10px; color: blue;"  class="add_user">添加</a>' +
                                    '<a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_user">清空</a>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</form></div>',
                                success: function () {
                                    
                                    $('#editOptionBox .plan_check_option').html(optionStr);
                                    
                                    if (data.privStr) {
                                        var privStrArr = data.privStr.replace(/,$/, '').split(',');
                                        for (var i = 0; i < privStrArr.length; i++) {
                                            $('#editOptionBox .priv_option[name="' + privStrArr[i] + '"]').prop('checked', true);
                                        }
                                        
                                        if ($('#editOptionBox .priv_option').length == $('#editOptionBox .priv_option:checked').length) {
                                            $('#editOptionBox .priv_option_all').prop('checked', true);
                                        }
                                    }
                                    
                                    $('#editPrivDept').val(data.deptPrivName);
                                    $('#editPrivDept').attr('deptid', data.deptPriv);

                                    $('#editPrivRole').val(data.rolePrivName);
                                    $('#editPrivRole').attr('privid', data.rolePriv);

                                    $('#editPrivUser').val(data.userPrivName);
                                    $('#editPrivUser').attr('user_id', data.userPriv);
                                    
                                    form.render();

                                },
                                yes: function (index) {
                                    var loadingIndex = layer.load();

                                    var privStr = '';
                                    var $checkOptions = $('#editOptionBox .priv_option:checked');

                                    $checkOptions.each(function (index, ele) {
                                        var optionNo = $(ele).attr('name');
                                        privStr += optionNo + ',';
                                    });
	                                
                                    var userPriv = $('#editPrivUser').attr('user_id') || '';
                                    var deptPriv = $('#editPrivDept').attr('deptid') || '';
                                    var rolePriv = $('#editPrivRole').attr('privid') || '';

                                    var dataObj = {
                                        plcPrivId: data.plcPrivId,
                                        privStr: privStr,
                                        userPriv: userPriv,
                                        deptPriv: deptPriv,
                                        rolePriv: rolePriv
                                    };

                                    $.post('/plcPriv/update', dataObj, function (res) {
                                        layer.close(loadingIndex);
                                        if (res.flag) {
                                            layer.close(index);
                                            layer.msg('保存成功', {icon: 1, time: 1000});
                                            initOptionTable(data.funcId);
                                        } else {
                                            layer.msg('保存失败', {icon: 2, time: 1000});
                                        }
                                    });
                                }
                            });
                            break;
                        case 'delete':
                            layer.confirm('删除该条权限设置？', function (index) {
                                $.get('/plcPriv/delete', {plcPrivId: data.plcPrivId}, function (res) {
                                    layer.close(index);
                                    if (res.flag) {
                                        layer.msg('删除成功', {icon: 1, time: 1000});
                                        initOptionTable(data.funcId);
                                    } else {
                                        layer.msg('删除失败', {icon: 2, time: 1000});
                                    }
                                });
                            });
                            break;
                    }

                });

                // 获取菜单对应的所有操作
                function initForm(funcId) {
                    $.get('/Dictonary/selectByNoAndFaclity', {facility: funcId}, function (res) {
                        if (res.flag) {
                            optionStr = '';
                            var funcOpPriv = res.object;

                            if (funcOpPriv && funcOpPriv.length > 0) {
                                funcOpPriv.forEach(function (item) {
                                    optionStr += '<input type="checkbox" class="priv_option" name="' + item.dictNo + '" lay-skin="primary" title="' + item.dictName + '" lay-filter="checkOption">'
                                });
                            }

                            $('.plan_check_option').html(optionStr);
                            $('.priv_option_all').prop("checked", false);
                            $('#resetBtn').trigger('click');
                            form.render();
                        }
                    });
                }
                
            });
            
            // 初始化页面操作权限
            // function initAuthority() {
            //     // 是否设置页面权限
            //     if (authorityObject) {
            //         // 检查保存权限
            //         if (authorityObject['17']) {
            //             $('.authority_add').show();
            //         }
            //     }
            // }
            
            function resizeSize() {
                var height = $(window).height();
                $('.content').height(height - 61);
                $('#rightContent').height(height - 124);
            }
            
		</script>
	
	</body>
</html>
