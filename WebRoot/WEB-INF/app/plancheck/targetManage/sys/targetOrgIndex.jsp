<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-04-16
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
    <title>组织机构</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <style>
        html, body {
            height: 100%;
            background: #fff;
        }

        hr {
            margin: 5px 0px;
        }

        .query .layui-input-block {
            margin-left: 114px;
        }

        .layui-input-block {
            margin-left: 154px;
        }

        .layui-form-label {
            width: 122px;
        }

        .layui-table-view {
            margin-left: 11px;
        }

        .layui-table-view .layui-table td, .layui-table-view .layui-table th {
            padding: 3px 0px;
        }

        .layui-table-tool {
            min-height: 40px;
            padding: 5px 15px;
        }

        .layui-form-item {
            /*width: 49%;*/
            margin-bottom: 8px;
        }

        /*  .newAndEdit{
              display: flex;
          }*/
        .layui-layer-btn {
            text-align: center;
        }

        .openFile input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }

        .layui-btn-container {
            position: relative;
        }

        .query .layui-form-item {
            margin-bottom: -5px;
        }

        .query .layui-form-label {
            width: 60px;
            padding: 9px 0px;
        }

        .inputs .layui-form-select .layui-input {
            height: 35px !important;
        }

        .layui-textarea {
            min-height: 80px;
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

        .con_left {
            float: left;
            width: 230px;
            /*height: 100%;*/
            margin-top: 10px;
            /*overflow-y: auto;*/
        }

        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
            position: relative;
        }

        .foldIcon {
            display: none;
            position: absolute;
            left: -10px;
            top: 42%;
            font-size: 30px;
            cursor: pointer;
        }

        .select {
            background: #c7e1ff;
        }

        .con_left ul li {
            padding: 5px;
        }

        .con_left input {
            height: 35px;
        }

        .layui-table-tool-self {
            top: 4px;
        }

        .layui-col-xs2 {
            width: 21%;
        }
    </style>

    <%--    <script type="text/javascript">
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
        </script>--%>

</head>
<body>
<input type="hidden" id="projOrgId">
<div>
    <div style="padding: 0px 8px;" class="clearfix">
        <div class="con_left">
            <div style="margin-bottom:10px;text-align: center">
                <%--                <input type="hidden" id="deptId">--%>
                <button type="button" class="layui-btn layui-btn-sm " id="import" style="display: none;">导入</button>
                <button type="button" class="layui-btn layui-btn-sm " id="isDisable" style="display: none;">禁用</button>
                <button type="button" class="layui-btn layui-btn-sm " id="del" style="display: none;">删除</button>
                <button type="button" class="layui-btn layui-btn-sm " id="edit">编辑</button>
            </div>
            <div style="text-align: center;background: #f2f2f2;height: 30px;line-height: 30px;font-size: 17px;font-weight: bold;">
                组织机构
            </div>
            <div class="eleTree ele1" style="margin-top: 10px;height: 650px;overflow-x: auto;"
                 lay-filter="organizationLeft"></div>
        </div>
        <div class="con_right">
            <div class="tishi" style="height: 100%;text-align: center;border: none;">
                <div style="width:100%;padding-top:10%;"><img style="margin-top: 2%;text-align: center;"
                                                              src="/img/noData.png" alt=""></div>
                <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧组织</h2>
            </div>
            <form class="rightContent layui-form" style="display: none" lay-filter="rightContent">
                <div class="layui-row" style="margin-top: 5%">
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">组织类型<span
                                    style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>
                            <div class="layui-input-block">
                                <select name="orgType" lay-verify="required" class="testNull" title="组织类型">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs6">
                        <div class="layui-form-item principalUser_select" style="display: none;">
                            <label class="layui-form-label">组织负责人<span
                                    style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>
                            <div class="layui-input-block">
                                <select name="principalUser" class="testNull" lay-verify="required">
                                </select>
                            </div>
                        </div>
                        <div class="layui-form-item principalUser_text" style="display: none;">
                            <label class="layui-form-label">组织负责人<span
                                    style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>
                            <div class="layui-input-inline">
                                <input type="text" style="background-color: #e7e7e7;" readonly id="principalUser"
                                       class="layui-input testNull" title="组织负责人" class="layui-input">
                            </div>
                            <div class="layui-form-mid layui-word-aux" t_id="principalUser" is_more="1">
                                <a href="javascript:;" style="color: blue;" class="add_user">添加</a>
                                <a href="javascript:;" style="color: red;" class="clear_role">清空</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row" style="margin: 15px auto">
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">上级单位审核</label>
                            <%--                                <div class="layui-input-block">--%>
                            <%--                                    <select name="planUser" lay-verify="required"  title="上级单位审核"  lay-filter="planUser" >--%>
                            <%--                                    </select>--%>
                            <%--                                </div>--%>
                            <div class="layui-input-inline">
                                <input type="text" style="background-color: #e7e7e7;" readonly id="planUser"
                                       class="layui-input testNull" title="上级单位审核" class="layui-input">
                            </div>
                            <div class="layui-form-mid layui-word-aux" t_id="planUser" is_more="1">
                                <a href="javascript:;" style="color: blue;" class="add_user">添加</a>
                                <a href="javascript:;" style="color: red;" class="clear_role">清空</a>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label">分管领导审核</label>
                            <%--                                <div class="layui-input-block">--%>
                            <%--                                    <select name="budgetUser" lay-verify="required" title="预算负责人"   lay-filter="budgetUser">--%>
                            <%--                                    </select>--%>
                            <%--                                </div>--%>
                            <div class="layui-input-inline">
                                <input type="text" style="background-color: #e7e7e7;" readonly id="budgetUser"
                                       class="layui-input testNull" title="分管领导审核" class="layui-input">
                            </div>
                            <div class="layui-form-mid layui-word-aux" t_id="budgetUser" is_more="1">
                                <a href="javascript:;" style="color: blue;" class="add_user">添加</a>
                                <a href="javascript:;" style="color: red;" class="clear_role">清空</a>
                            </div>
                        </div>
                    </div>
                    <%--                        <div class="layui-col-xs6">--%>
                    <%--                            <div class="layui-form-item">--%>
                    <%--                                <label class="layui-form-label">计划负责人电话</label>--%>
                    <%--                                <div class="layui-input-block">--%>
                    <%--                                    <input type="text" name="planPhone" required title="计划负责人电话"  lay-verify="required"  autocomplete="off" class="layui-input">--%>
                    <%--                                </div>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                </div>
                <%--                    <div class="layui-row">--%>
                <%--                        <div class="layui-col-xs6">--%>
                <%--                            <div class="layui-form-item">--%>
                <%--                                <label class="layui-form-label">预算负责人</label>--%>
                <%--                                <div class="layui-input-block">--%>
                <%--                                    <select name="budgetUser" lay-verify="required" title="预算负责人"   lay-filter="budgetUser">--%>
                <%--                                    </select>--%>
                <%--                                </div>--%>
                <%--                            </div>--%>
                <%--                        </div>--%>
                <%--                        <div class="layui-col-xs6">--%>
                <%--                            <div class="layui-form-item">--%>
                <%--                                <label class="layui-form-label">预算负责人电话</label>--%>
                <%--                                <div class="layui-input-block">--%>
                <%--                                    <input type="text" name="budgetPhone" required title="预算负责人电话"  lay-verify="required" autocomplete="off" class="layui-input">--%>
                <%--                                </div>--%>
                <%--                            </div>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>
                <div class="layui-row">
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 140px;padding: 9px 5px">是否显示在项目信息</label>
                            <div class="layui-input-block">
                                <select name="showInfo" lay-verify="required">
                                    <option value="1">是</option>
                                    <option value="2">否</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs6">
                        <div class="layui-form-item">
                            <label class="layui-form-label" style="width: 140px;padding: 9px 5px">考核小组人员</label>
                            <div class="layui-input-block">
                                <div class="layui-input-inline">
                                    <input type="text" style="background-color: #e7e7e7;" readonly
                                           id="assessmentTeamUsers" class="layui-input testNull" title="考核小组人员"
                                           class="layui-input">
                                </div>
                                <div style="float: left; margin-top: 20px;" t_id="assessmentTeamUsers">
                                    <a href="javascript:;" style="margin-left: 10px; color: blue;"
                                       class="add_user">添加</a>
                                    <a href="javascript:;" style="margin-left: 10px; color: red;"
                                       class="clear_user">清空</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="font-size: 18px; padding: 10px">授权其他组织或人员查阅</div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 140px;padding: 9px 5px">授权部门</label>
                    <div class="layui-input-block">
                            <textarea placeholder="请选择授权部门" id="privDept" readonly class="layui-textarea"
                                      style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
                        <div style="float: left; margin-top: 20px;" t_id="privDept">
                            <a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_dept">添加</a>
                            <a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_dept">清空</a>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 140px;padding: 9px 5px">授权角色</label>
                    <div class="layui-input-block">
                            <textarea placeholder="请选择授权角色" id="privRole" readonly class="layui-textarea"
                                      style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
                        <div style="float: left; margin-top: 20px;" t_id="privRole">
                            <a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_role">添加</a>
                            <a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_role">清空</a>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 140px;padding: 9px 5px">授权人员</label>
                    <div class="layui-input-block">
                            <textarea placeholder="请选择授权人员" id="privUser" readonly class="layui-textarea"
                                      style="float: left;width: 70%; background-color: #e7e7e7;"></textarea>
                        <div style="float: left; margin-top: 20px;" t_id="privUser">
                            <a href="javascript:;" style="margin-left: 10px; color: blue;" class="add_user">添加</a>
                            <a href="javascript:;" style="margin-left: 10px; color: red;" class="clear_user">清空</a>
                        </div>
                    </div>
                </div>
                <div style="text-align: center;margin-top: 6%">
                    <button type="button" class="layui-btn save" style="display: none;">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>

    initAuthority();
    var dept_id = '';
    var priv_id = '';
    var user_id = '';
    var importFlag = false;

    var insTree
    $('.con_left').height($(document).height() - 160);
    layui.use(['form', 'eleTree'], function () {
        var form = layui.form;
        var eleTree = layui.eleTree;
        var dictionaryObj = {ORG_TYPE: {}, ORGANIZATION_TYPE: {}}
        var dictionaryStr = 'ORG_TYPE,ORGANIZATION_TYPE'
        // 获取数据字典数据
        $.ajax({
            url: '/Dictonary/selectDictionaryByDictNos',
            dataType: 'json',
            type: 'get',
            data: {dictNos: dictionaryStr},
            async: false,
            success: function (res) {
                if (res.flag) {
                    for (var dict in dictionaryObj) {
                        dictionaryObj[dict] = {object: {}, str: '<option value="">请选择</option>'}
                        if (res.object[dict]) {
                            res.object[dict].forEach(function (item) {
                                dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                                dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                            })
                        }
                    }
                }
            }
        })
        // $('.orgnizeType').html(dictionaryObj['ORG_TYPE']['str'])
        $('select[name="orgType"]').html(dictionaryObj['ORG_TYPE']['str'])
        form.render('select');
        //导入
        $('#import').click(function () {
            // dept_id = $(this).siblings('input').attr('id');
            dept_id = $(this).attr('id');
            importFlag = true;
            $.popWindow("/common/selectDept");
        })

        /**
         * 左侧组织机构树
         */
        function leftShow() {
            insTree = eleTree.render({
                elem: '.ele1',
                url: '/plcTargetOrg/selectAll?' + '&_=' + new Date().getTime(),
                highlightCurrent: true,
                showLine: true,
                accordion: true,
                request: {
                    name: "contractorName", // 显示的内容
                    key: "deptId", // 节点id
                    children: "orgList",
                },
                response: {
                    statusName: 'flag',
                    statusCode: true,
                    dataName: "obj"
                },
            });
        }

        leftShow()
        // 节点点击事件
        eleTree.on("nodeClick(organizationLeft)", function (d) {
            // console.log(d.data);    // 点击节点对于的数据
            var loadindIndex = layer.load(0);
            var data = d.data.currentData
            $('#projOrgId').val(data.projOrgId)
            $('.tishi').hide()
            $('.rightContent').show()
            //判断是否禁用，1是启用，0是禁用
            if (data.disableYn == 1) {
                $('#isDisable').text('禁用')
                $('#isDisable').attr('disableYn', 0)
                $('#isDisable').attr('names', data.contractorName)
                $('select[name="orgType"]').prop('disabled', false)
                $('select[name="principalUser"]').prop('disabled', false)
                $('select[name="planUser"]').prop('disabled', false)
                $('input[name="planPhone"]').prop('disabled', false)
                $('select[name="budgetUser"]').prop('disabled', false)
                $('input[name="budgetPhone"]').prop('disabled', false)
                $('select[name="showInfo"]').prop('disabled', false)
                form.render('select')
            } else {
                $('#isDisable').text('启用')
                $('#isDisable').attr('disableYn', 1)
                $('#isDisable').attr('names', data.contractorName)
                $('select[name="orgType"]').prop('disabled', true)
                $('select[name="principalUser"]').prop('disabled', true)
                $('select[name="planUser"]').prop('disabled', true)
                $('input[name="planPhone"]').prop('disabled', true)
                $('select[name="budgetUser"]').prop('disabled', true)
                $('input[name="budgetPhone"]').prop('disabled', true)
                $('select[name="showInfo"]').prop('disabled', true)
                form.render('select')
            }
            $.ajax({
                type: 'get',
                url: '/department/getChDept',
                dataType: 'json',
                data: {deptId: data.deptId},
                // async: false,
                success: function (res) {
                    if (res.flag) {
                        var obj = res.obj
                        var str = ''
                        for (var i = 0; i < obj.length; i++) {
                            if (obj[i].userId) {
                                str += '<option value="' + obj[i].userId + '" phone="' + obj[i].mobilNo + '">' + obj[i].userName + '</option>'
                            }
                        }

                        if (!str) {
                            $('.principalUser_select').hide();
                            $('.principalUser_text').show();
                        } else {
                            $('.principalUser_select').show();
                            $('.principalUser_text').hide();
                        }
                        str = '<option value="">请选择</option>' + str;
                        $('select[name="principalUser"]').html(str);
                        // $('select[name="planUser"]').html(str)
                        // $('select[name="budgetUser"]').html(str)
                        form.render('select');
                    }
                    $.get('/plcTargetOrg/queryId', {projOrgId: data.projOrgId}, function (res) {
                        layer.close(loadindIndex);
                        //判断该数据是否被保存过
                        if (res.object.principalUser) {
                            form.val('rightContent', res.object);
                            form.render()
                        } else {
                            $('form')[0].reset()
                        }
                        if ($('.principalUser_select').is(":hidden")) {
                            $('#principalUser').attr('user_id', res.object.principalUser || '');
                            $('#principalUser').val(res.object.principalUserName || '');
                        } else {
                            $('select[name="principalUser"]').val();
                        }
                        $('#planUser').attr('user_id', res.object.planUser || '');
                        $('#planUser').val(res.object.planUserName || '');
                        $('#budgetUser').attr('user_id', res.object.budgetUser || '');
                        $('#budgetUser').val(res.object.budgetUserName || '');
                        $('#privUser').val(res.object.userPrivName || '');
                        $('#privUser').attr('user_id', res.object.userPriv || '');
                        $('#assessmentTeamUsers').val(res.object.assessmentTeamUsersName || '');
                        $('#assessmentTeamUsers').attr('user_id', res.object.assessmentTeamUsers || '');
                        $('#privDept').val(res.object.deptPrivName || '');
                        $('#privDept').attr('deptid', res.object.deptPriv || '');
                        $('#privRole').val(res.object.rolePrivName || '');
                        $('#privRole').attr('privid', res.object.rolePriv || '');
                        $('[name="orgType"]').val(res.object.orgType || '');
                        form.render()
                    })
                }
            });
            /* //最高级部门不显示右侧信息
             if(data.deptParent==0){
                 $('.tishi').show()
                 $('.rightContent').hide()
                 $('#projOrgId').val('')
             }else{

             }*/
        })
        form.on('select(planUser)', function (data) {
            var phone = $('select[name="planUser"] option:selected').attr('phone')
            $('input[name="planPhone"]').val(phone)
        });
        form.on('select(budgetUser)', function (data) {
            var phone = $('select[name="budgetUser"] option:selected').attr('phone')
            $('input[name="budgetPhone"]').val(phone)
        });
        //点击保存
        $('.save').click(function () {
            if ($('#isDisable').attr('disableyn') == 1) {
                layer.msg('请先启用' + '&nbsp;&nbsp;' + $('#isDisable').attr('names') + '&nbsp;&nbsp;' + '!', {icon: 0});
                return false
            }
            //必填项提示
            // for(var i=0;i<$('.testNull').length;i++){
            //     if($('.testNull').eq(i).val()==''){
            //         layer.msg($('.testNull').eq(i).attr('title')+'为必填项！', {icon: 0});
            //         return false
            //     }
            // }

            var userPriv = $('#privUser').attr('user_id') || '';
            var deptPriv = $('#privDept').attr('deptid') || '';
            var rolePriv = $('#privRole').attr('privid') || '';
            var principalUser = '';
            var assessmentTeamUsers = $('#assessmentTeamUsers').attr('user_id') || '';
            if ($('.principalUser_select').is(":hidden")) {
                principalUser = ($('#principalUser').attr('user_id') || '').replace(/,$/, '');
            } else {
                principalUser = $('select[name="principalUser"]').val()
            }
            var params = {
                orgType: $('select[name="orgType"]').val(),
                principalUser: principalUser,
                planUser: ($('#planUser').attr('user_id') || '').replace(/,$/, ''),
                // planPhone:$('input[name="planPhone"]').val(),
                budgetUser: ($('#budgetUser').attr('user_id') || '').replace(/,$/, ''),
                // budgetPhone:$('input[name="budgetPhone"]').val(),
                showInfo: $('select[name="showInfo"]').val(),
                projOrgId: $('#projOrgId').val(),
                userPriv: userPriv,
                deptPriv: deptPriv,
                rolePriv: rolePriv,
                assessmentTeamUsers: assessmentTeamUsers
            }
            $.post('/plcTargetOrg/update', params, function (res) {
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1});
                }
            })
        })
        //点击禁用/启用
        $('#isDisable').click(function () {
            var projOrgId = $('#projOrgId').val()
            var disableYn = $('#isDisable').attr('disableYn')
            if (projOrgId == '' || projOrgId == undefined) {
                layer.msg('请选择左侧一项!', {icon: 0});
                return false
            }
            layer.confirm('确定' + $(this).text() + '&nbsp;&nbsp;' + $(this).attr('names') + '&nbsp;&nbsp;' + '吗？', function (index) {
                $.ajax({
                    type: 'post',
                    url: '/plcTargetOrg/disableYn',
                    data: {projOrgId: projOrgId, disableYn: disableYn},
                    dataType: 'json',
                    success: function (res) {
                        if (res.flag == true) {
                            layer.msg('保存成功!', {icon: 1});
                            insTree.reload()
                            $('.tishi').show()
                            $('.rightContent').hide()
                        }
                    }
                })
            });
        })
        //点击删除
        $('#del').click(function () {
            var projOrgId = $('#projOrgId').val()
            if (projOrgId == '' || projOrgId == undefined) {
                layer.msg('请选择左侧一项!', {icon: 0});
                return false
            }
            layer.confirm('确定删除' + '&nbsp;&nbsp;' + $('#isDisable').attr('names') + '&nbsp;&nbsp;' + '吗？', function (index) {
                $.post('/plcTargetOrg/delete', {projOrgId: projOrgId}, function (res) {
                    if (res.flag) {
                        layer.msg('删除成功!', {icon: 1});
                        insTree.reload()
                        $('.tishi').show()
                        $('.rightContent').hide()
                    }
                })
            });
        })
        //点击编辑
        $('#edit').click(function () {
            var projOrgId = $('#projOrgId').val()
            if (projOrgId == '' || projOrgId == undefined) {
                layer.msg('请选择左侧一项!', {icon: 0});
                return false
            }
            layer.open({
                type: 1,
                title: '编辑',
                area: ['40%', '30%'],
                btn: ['确定', '取消'],
                content: '<div  class="layui-form"  style="margin-top: 15px">' +
                    '  <div class="layui-form-item" style="width: 88%">\n' +
                    '    <label class="layui-form-label">组织机构名称</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="contractorName" value="' + $('#isDisable').attr('names') + '" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '</div>',
                yes: function (index, layero) {
                    $.post('/plcTargetOrg/update', {
                        projOrgId: projOrgId,
                        contractorName: $('input[name="contractorName"]').val()
                    }, function (res) {
                        if (res.flag) {
                            layer.msg('修改成功!', {icon: 1});
                            layer.close(index)
                            insTree.reload()
                            $('.tishi').show()
                            $('.rightContent').hide()
                        }
                    })
                }
            })
        })
    });

    // 添加授权部门
    $(document).on('click', '.add_dept', function () {
        dept_id = $(this).parent().attr('t_id');
        importFlag = false;
        $.popWindow("/common/selectDept");
    });
    // 清空授权部门
    $(document).on('click', '.clear_dept', function () {
        var id = $(this).parent().attr('t_id')
        $('#' + id).val('');
        $('#' + id).attr('deptid', '');
    });

    // 添加授权角色
    $(document).on('click', '.add_role', function () {
        priv_id = $(this).parent().attr('t_id');
        $.popWindow("/common/selectPriv");
    });
    // 清空授权角色
    $(document).on('click', '.clear_role', function () {
        var id = $(this).parent().attr('t_id')
        $('#' + id).val('');
        $('#' + id).attr('privid', '');
    });

    // 添加授权人员
    $(document).on('click', '.add_user', function () {
        user_id = $(this).parent().attr('t_id');
        var chooseType = $(this).parent().attr('is_more') == 1 ? 0 : '';
        $.popWindow("/common/selectUser?" + chooseType);
    });
    // 清空授权人员
    $(document).on('click', '.clear_user', function () {
        var id = $(this).parent().attr('t_id')
        $('#' + id).val('');
        $('#' + id).attr('user_id', '');
    });

    /**
     * 导入后的方法
     * @param deptIds  部门id
     */
    function importLeft(deptIds) {
        if (importFlag) {
            $.post('/plcTargetOrg/inserts', {deptIds: deptIds}, function (res) {
                if (res.flag) {
                    layer.msg('导入成功！', {icon: 1});
                    insTree.reload()
                    $('#import').attr('deptid', '')
                    $('#privDept').attr('deptid', '');
                    $('#privUser').attr('user_id', '');
                    $('#privRole').attr('privid', '');
                    $('.tishi').show()
                    $('.rightContent').hide()
                }
            });
        }
    }

    // 初始化页面操作权限
    function initAuthority() {
        $('#import').show();
        $('#del').show();
        $('.save').show();
        $('#isDisable').show();
        // 是否设置页面权限
        /*if (authorityObject) {
            // 检查导入权限
            if (authorityObject['02']) {
                $('#import').show();
            }
            // 检查删除权限
            if (authorityObject['04']) {
                $('#del').show();
            }
            // 检查保存权限
            if (authorityObject['17']) {
                $('.save').show();
            }
            // 检查禁用权限
            if (authorityObject['23']) {
                $('#isDisable').show();
            }
        }*/
    }
</script>

</body>

</html>
