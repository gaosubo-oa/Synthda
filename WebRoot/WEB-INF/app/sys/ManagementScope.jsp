<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>按模块设置管理范围</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <%--<link rel="stylesheet" type="text/css" href="../css/base.css"/>--%>
</head>
<style>
    body {
        background-color: #f5f5f5;
    }

    #cont_left ul {
        margin: 0px 0px 10px 0px;
    }

    #userTree {
        width: 210px !important;
        background: #9ac5e8;
        float: left;
    }

    .right {
        width: calc(100% - 230px) !important;
        display: inline-block;
        float: left;
        margin-left: 20px;
    }

    .right .tit {
        height: 30px;
        background: #c4de83;
        border: 1px #9cb269 solid;
        font-weight: bold;
        color: #383838;
        line-height: 30px;
        padding: 0px;
        padding-left: 5px;
    }

    .save {
        margin-left: 10px;
        width: 75px;
        height: 30px;
        background: #f2f2f2;
        border: 1px solid #ccc;
        border-radius: 2px;
        margin-left: 10px;
        background: #1a73e8;
        line-height: 30px;
    }

    .otherModules {
        display: inline-block;
        width: 80%;
    }

    .otherModules li {
        margin-right: 20px;
        float: left;
        min-height: 30px;
    }
    .layui-form-checkbox i{
        border:none !important;
    }
</style>
<body>
<div class="mbox">
    <%--添加内容--%>
    <div class="content">
        <div class="sync-tree sync-user-tree">
            <div id="userTree">
                <div class="cont_left" id="cont_left">
                    <ul>
                        <li class="pick" style="display: block;">
                        </li>
                    </ul>
                </div>
            </div>
            <div class="right">
                <div class="tit">
                    <span class="titname"></span>-<span class="description"></span>
                </div>
                <div>
                    <form class="layui-form" action="" id="formTest" lay-filter="formTest">
                        <%--第一个--%>
                        <div class="layui-form-item" style="margin-top: 10px;">
                            <div class="layui-block">
                                <label class="layui-form-label">人员范围：</label>
                                <div class="layui-input-inline">
                                    <select name="deptPriv" lay-filter="deptPriv">
                                        <option value="">请选择</option>
                                        <option value="0">本部门</option>
                                        <option value="1">全体</option>
                                        <option value="2">指定部门</option>
                                        <option value="3">指定人员</option>
                                        <option value="4">本人</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <%--                            指定部门--%>
                        <div class="layui-form-item demt" style="display: none">
                            <div class="layui-form-item">
                                <div class="layui-form-item" style="width: 100%;margin-top: 10px;">
                                    <span class="fl" style="margin-top: 6px;margin-left: 24px;margin-right: 12px;">指定部门：</span>
                                    <textarea id="demt" deptid="" cols="40" rows="3" readonly
                                              style="vertical-align: middle"></textarea>
                                    <a href="javascript:;" style="color: green" class="adddemt">添加</a>
                                    <a href="javascript:;" style="color: red" class="clear">清空</a>
                                </div>
                            </div>
                        </div>
                        <%--指定人员 --%>
                        <div class="layui-form-item personnel" style="display: none">
                            <div class="layui-form-item" style="width: 100%;margin-top: 10px;">
                                <span class="fl" style="margin-top: 6px;margin-left: 35px;margin-left: 24px;margin-right: 12px;">指定人员：</span>
                                <textarea id="personnel" name="userId" user_id="" cols="40" rows="3"
                                          readonly style="vertical-align: middle"></textarea>
                                <a href="javascript:;" style="color: green" class="adddPersonnel">添加</a>
                                <a href="javascript:;" style="color: red" class="clearPersonnel">清空</a>
                            </div>
                        </div>

                        <%--                            人员角色--%>
                        <div class="layui-form-item">
                            <div class="layui-block ">
                                <label class="layui-form-label">人员角色：</label>
                                <div class="layui-input-inline">
                                    <select name="rolePriv" class="rolePriv" lay-filter="rolePriv">
                                        <option value="">请选择</option>
                                        <option value="0">低角色得用户</option>
                                        <option value="1">同角色和低角色的用户</option>
                                        <option value="2">所有角色的用户</option>
                                        <option value="3">指定角色的用户</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <%--                            指定角色--%>
                        <div class="layui-form-item managementRole"  style="display: none">
                            <div class="layui-form-item" style="width: 100%;margin-top: 10px;">
                                <span class="fl" style="margin-top: 6px;margin-left: 35px;margin-left: 24px;margin-right: 12px;">指定角色：</span>
                                <textarea id="managementRole" privid="" cols="40" rows="3" readonly
                                          style="vertical-align: middle"></textarea>
                                <a href="javascript:;" style="color: green" class="roleAdd">添加</a>
                                <a href="javascript:;" style="color: red" class="roleClear">清空</a>
                            </div>
                        </div>
                        <%--                            说明--%>
                        <div>
                            <div class="layui-form-item" style="margin-top: 10px;">
                                <span class="fl" style="margin-top: 6px;">说明：</span>
                                <span class="titname"></span><span class="moduleName"></span>
                            </div>
                        </div>
                        <div class="tit OtherUsers">
                            以上设置应用到其它模块、其他用户 >>
                        </div>
                        <div class="cont" style="display: none">
                            <div class="layui-form-item" style="margin-top: 10px;">
                                <span class="fl" style="margin-top: 6px;vertical-align: top">应用到其他模块：</span>
                                <ul class="otherModules">
                                </ul>
                            </div>
                            <div class="tit">
                                应用到其他用户（必须同时满足以下的部门、角色限制）
                            </div>
                            <div>
                                <%--所在部门--%>
                                <div class="layui-form-item">
                                    <div class="layui-form-item" style="width: 100%;margin-top: 10px;">
                                        <span class="fl" style="margin-top: 6px;">所在部门：</span>
                                        <textarea id="department" deptid="" cols="40" rows="3" readonly
                                                  style="vertical-align:middle"></textarea>
                                        <a href="javascript:;" style="color: green" class="addDept">添加</a>
                                        <a href="javascript:;" style="color: red" class="clearDept">清空</a>
                                    </div>
                                </div>
                                <%--所属角色：	--%>
                                <div class="layui-form-item">
                                    <div class="layui-form-item" style="width: 100%;margin-top: 10px;">
                                        <span class="fl" style="margin-top: 6px;">所属角色：</span>
                                        <textarea id="roles" privid="" cols="40" rows="3" readonly
                                                  style="vertical-align:middle"></textarea>
                                        <a href="javascript:;" style="color: green" class="addrole">添加</a>
                                        <a href="javascript:;" style="color: red" class="clearRole">清空</a>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </form>
                    <div style="text-align: center;margin-top: 20px">
                        <button type="button" class="layui-btn save" style="margin-left: 10px;">保存</button>
                        <button type="button" class="layui-btn layui-btn-sm save" id="closeAll">关闭</button>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            layui.use(['form', 'layer'], function () {
                var form = layui.form;
                var layer = layui.layer
                form.render()   //刷新表单
                var moduleId = ''
                var moduleIdStr = ''
                var applyModules = ''
                function GetQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]);
                    return null;
                }
                // 给标题赋值
                $('.titname').html(parent.opener.names)
                $('#userTree').on('click', '.liFun', function () {
                    moduleId = $(this).attr('moduleId')
                    leftEcho($(this).attr('moduleId'),$(this).attr('description'),$(this).attr('moduleName'))
                })
                loadSidebar1($('.pick'), 0)

                //左侧的树图
                function loadSidebar1(target, deptId) {
                    $.ajax({
                        url: '/modulePriv/queryModules?moduleId=11',
                        type: 'get',
                        data: {
                            deptId: deptId
                        },
                        dataType: 'json',
                        success: function (data) {
                            var str = '';
                            data.object.forEach(function (v, i) {
                                if (v.description) {
                                    str += '<li class="liFun"  moduleId="' + v.moduleId + '" userId="' + v.userId + '"  description="' + v.description + '"  moduleName="' + v.moduleName + '"><span data-types="1"  data-numtrue="1" ' +
                                        'onclick= "imgDown_s(' + v.moduleId + ',this)"  style="height:35px;line-height:35px;padding-left: 30px" deptid="' + v.deptId + '" class="firsttr childdept"><span class=""></span><img src="/img/sys/dapt_right.png" alt="" style="margin-left: 12px;width: 8px;height: 14px;margin-top: -3px;margin-right: 4px;"><a href="javascript:void(0)" class="dynatree-title" title="' + v.description + '">' + v.description + '</a></span><ul style="display:none;" class="dpetWhole0"></ul></li>';
                                }
                            })
                            target.append(str);

                        }
                    })
                }

                //点击左侧的回显右侧的接口
                function leftEcho(moduleId,description,moduleName) {
                    $('.description').html(description)
                    $('.moduleName').html(moduleName)
                    $.ajax({
                        url: '/modulePriv/queryModulePrivSingle?moduleId=11',
                        type: 'get',
                        data: {
                            uid: GetQueryString('userId'),
                            moduleId: moduleId
                        },
                        dataType: 'json',
                        success: function (data) {
                            //回显右侧是form
                            if (data.object) {
                                $("select[name='deptPriv']").val(data.object.deptPriv)
                                $(".rolePriv").val(data.object.rolePriv)
                                $('#demt').val(data.object.deptName)
                                $("#demt").attr('deptId', data.object.deptId);
                                $('#personnel').val(data.object.userName)
                                $("#personnel").attr('user_id', data.object.userId);
                                //指定角色回显
                                $('#managementRole').val(data.object.privName)
                                $("#managementRole").attr('privid', data.object.privId);
                                //回显选人框显示和隐藏
                                if ($('#demt').attr('deptid') != "" && data.object.deptPriv == '2') {
                                    $('.demt').show()
                                }else {
                                    $('.demt').hide()
                                }
                                if ($('#personnel').attr('user_id') != "" && data.object.deptPriv == '3') {
                                    $('.personnel').show()
                                }else {
                                    $('.personnel').hide()
                                }
                                if ($('#managementRole').attr('privid') != "" && data.object.rolePriv == '3') {
                                    $('.managementRole').show()
                                }else{
                                    $('.managementRole').hide()
                                }

                                let str = ''
                                //回显应用到其它模块
                                data.object.otherModulePrivs.forEach(function (item) {
                                    if (item) {
                                        str += '<li><input type="checkbox" lay-filter="test" name="checkbox" value="' + item.moduleId + '" style="width:13px;height:13px;vertical-align: sub"/>' +
                                            ' <span>' + item.description + '</span></li>'
                                    }
                                    $('.otherModules').html(str);
                                })
                            } else {
                                // 清空数据
                                $("#formTest")[0].reset();
                                $('.demt').hide()
                                $('.personnel').hide()
                                $('.managementRole').hide()
                            }
                            layui.form.render();
                        }
                    })
                }

                //指定部门
                $('.adddemt').click(function () {
                    dept_id = "demt";
                    $.popWindow("../../common/selectDept");
                });
                // 清空
                $('.clear').click(function () {
                    $('#demt').removeAttr('deptid');
                    $('#demt').attr('deptno', '');
                    $('#demt').removeAttr('deptname');
                    $('#demt').val('');
                });
                //指定人员
                $('.adddPersonnel').click(function () {
                    user_id = 'personnel';
                    $.popWindow("/common/selectUser");
                })
                $('.clearPersonnel').click(function () {
                    $("#personnel").val("");
                    $("#personnel").attr('username', '');
                    $("#personnel").attr('dataid', '');
                    $("#personnel").attr('user_id', '');
                    $("#personnel").attr('userprivname', '');
                })


                //所在部门
                $('.addDept').click(function () {
                    dept_id = "department";
                    $.popWindow("../../common/selectDept");
                });
                // 清空
                $('.clearDept').click(function () {
                    $('#department').removeAttr('deptid');
                    $('#department').attr('deptno', '');
                    $('#department').removeAttr('deptname');
                    $('#department').val('');
                });


                //指定角色添加
                $(".roleAdd").on("click", function () {
                    priv_id = 'managementRole';
                    $.popWindow("../../common/selectPriv?1");
                });
                //指定角色删除
                $('.roleClear').click(function () {
                    $('#managementRole').removeAttr('userpriv');
                    $('#managementRole').removeAttr('privid');
                    $('#managementRole').attr('dataid', '');
                    $('#managementRole').val('');
                });

                //所属角色添加
                $(".addrole").on("click", function () {
                    priv_id = 'roles';
                    $.popWindow("../../common/selectPriv?1");
                });
                //所属角色删除
                $('.clearRole').click(function () {
                    $('#roles').removeAttr('userpriv');
                    $('#roles').removeAttr('privid');
                    $('#roles').attr('dataid', '');
                    $('#roles').val('');
                });
                //监听人员范围改变事件
                form.on("select(deptPriv)", function (data) {
                    if (data.value == '2') {
                        $('.demt').show()
                        $('.personnel').hide()
                    } else if (data.value == '3') {
                        $('.personnel').show()
                        $('.demt').hide()
                    } else {
                        $('.demt').hide()
                        $('.personnel').hide()
                    }
                });
                //监听人员角色改变事件
                form.on("select(rolePriv)", function (data) {
                    if (data.value == '3') {
                        $('.managementRole').show()
                    } else {
                        $('.managementRole').hide()
                    }
                })

                //应用到其他模块
                form.on("checkbox(test)",function(data){
                    moduleIdStr += data.value+','
                    applyModules =  moduleIdStr.substring(0,moduleIdStr.length-1)
                })

                var flag = true
                $(".OtherUsers").on("click", function () {
                    if (flag) {
                        $('.cont').show()
                        flag = false
                    } else {
                        $('.cont').hide()
                        flag = true
                    }
                })

                //保存的接口
                $('.save').click(function () {
                    if (moduleId) {
                        $.ajax({
                            url: '/modulePriv/saveModulePriv?moduleId=11',
                            type: "get",
                            dataType: "json",
                            data: {
                                uid: GetQueryString('userId'),
                                moduleId: moduleId,
                                deptPriv: $("select[name='deptPriv']").val(),
                                rolePriv: $(".rolePriv").val(),
                                deptId: $('#demt').attr('deptid'),
                                userId: $('#personnel').attr('user_id'),
                                privId: $('#managementRole').attr('privid'),
                                applyModules:applyModules,
                                applyDepts: $('#department').attr('deptid'),
                                applyPrivs: $('#roles').attr('privid')
                            },
                            success: function (data) {
                                window.close();
                            }
                        })
                    } else {
                        layer.msg('请先选择左侧，在保存', {time: 1000, icon: 2})
                    }

                })
                //返回按钮
                $('#closeAll').click(function () {
                    window.close();
                })
            })


        </script>
    </div>
</body>
</html>
