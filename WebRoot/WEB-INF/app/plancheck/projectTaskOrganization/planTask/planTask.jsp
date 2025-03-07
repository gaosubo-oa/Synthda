<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-06-08
  Time: 11:03
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
    <title>计划子任务</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>


    <style>

        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
            /*user-select: none;*/
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
            margin-top: 10px;
        }

        .left_List .left_List_item {
            width: 100%;
            line-height: 40px;
            padding-left: 10px;
            border-bottom: 1px solid #ddd;
            border-radius: 3px;
            overflow: hidden;
            box-sizing: border-box;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
            cursor: pointer;
        }

        .left_List .select {
            background: #c7e1ff;
        }

        .con_right {
            float: left;
            width: calc(100% - 230px);
            height: 100%;
            position: relative;
        }

        .project_tree_module {
            float: left;
            width: 255px;
            min-height: 50px;
            padding-right: 15px;
            box-sizing: border-box;
            height: 100%;
            overflow: hidden;
        }

        .project_info {
            float: left;
            width: calc(100% - 255px);
            box-shadow: 0 0px 5px 0 rgba(0, 0, 0, .1);
            border-radius: 3px;
        }

        .project_name {
            font-size: 18px;
            font-weight: 500;
        }

        .inputs input {
            height: 30px !important;
        }

        form {
            padding: 10px;
            margin-left: -20px;
        }

        .query .layui-form-item {
            margin-bottom: 0px;
        }

        .query .layui-input {
            height: 35px;
        }

        .query .layui-input-block {
            margin-top: 2px;
        }

        .foldIcon {
            display: none;
            position: absolute;
            left: -11px;
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

        .layui-btn-container {
            position: relative;
        }

        .layui-layer-btn {
            text-align: center;
        }
        form .layui-form-label{
            width: 122px;
        }
        form .layui-input-block{
            margin-left: 152px;
        }
        .ew-tree-table{
            margin-left: 10px !important;
        }
        .openFile input[type=file]{
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
        .con_left input{
            height: 35px;
        }
        .query .layui-form-label{
            padding: 9px 0px;
        }
        .query .layui-input-block{
            margin-left: 90px
        }
        .ew-tree-table .ew-tree-table-tool{
            padding: 6px 15px !important;
            min-height: 42px !important;
        }
        .ew-tree-table-tool-right{
            position: absolute;
            right: 12px;
            top: 6px;
        }
        .target_module_tree {
            position: absolute;
            top: 41px;
            right: 0;
            bottom: 0;
            left: 0;
            overflow-x: auto;
        }
        .project_item {
            position: absolute;
            top: 5px;
            right: 15px;
            bottom: 10px;
            left: 250px;
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
        .bar {
            height: 18px;
            background: green;
        }

        /*附件详情--start*/
        .operationDiv {
            display: none;
            position: absolute;
            top: -50px;
            left: 5px;
            background: #fff;
            box-shadow: 0 0 5px 0 rgb(0, 0, 0);
            border-radius: 5px;
        }
        .divShow {
            position: relative;
        }
        .divShow:hover .operationDiv {
            display: block;
        }
        /*附件详情--end*/
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
<div class="container" style="padding-top: 15px;box-sizing: border-box">
    <input type="hidden" id="leftId" class="layui-input">
 <%--   <div class="header">
        <div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img
                            style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span
                            style="margin-left: 10px">计划子任务</span></span>
        </div>
    </div>
    <hr>--%>
    <div class="query layui-row layui-form">
        <div class="layui-col-xs2" style="width: 237px">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 70px;padding: 9px 2px">子任务名称</label>
                <div class="layui-input-block" style="margin-left: 77px">
                    <input type="text" name="taskName" required lay-verify="required" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-col-xs2" style="width: 19%">
            <div class="layui-form-item">
                <label class="layui-form-label">周期类型</label>
                <div class="layui-input-block">
                    <select name="planSycle" lay-verify="required">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2" style="width: 19%">
            <div class="layui-form-item">
                <label class="layui-form-label">任务来源</label>
                <div class="layui-input-block">
                    <select name="taskType" lay-vfy="required">
                        <option value="">请选择</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2" style="width: 16%">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 50px">年度</label>
                <div class="layui-input-block" style="margin-left: 57px">
<%--                    <input type="text" name="year" id="year" lay-filter="year"  autocomplete="off" class="layui-input">--%>
                        <select name="year" lay-filter="year" >
                            <option value="">请选择</option>
                        </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2" style="width: 16%">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 50px">月度</label>
                <div class="layui-input-block" style="margin-left: 57px">
<%--                    <input type="text" name="month" id="month"  autocomplete="off" class="layui-input">--%>
                    <select name="month" lay-filter="month" >
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2 authority_search" style="margin-top: 5px;width: 11.5%;text-align: right;display: none;">
            <button type="button" class="layui-btn layui-btn-sm queryTask" style="margin-left: 10%;">查询</button>
            <button type="button" class="layui-btn layui-btn-sm" onclick="reset()" style="margin-left: 10%;">重置</button>
        </div>
    </div>
    <div style="padding: 0px 8px;" class="clearfix">
        <div class="con_left">
            <%--组织筛选--%>
            <div class="layui-form">
                <select name="deptName" lay-verify="required" lay-filter="deptName">
                </select>
            </div>
            <%--项目机构和项目信息--%>
            <div class="eleTree ele1" style="overflow-x: auto;margin-top: 10px;" lay-filter="projectLeft"></div>
        </div>
        <div class="con_right">
            <div class="tishi" style="height: 100%;text-align: center;border: none;">
                <div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;"
                                                              src="/img/noData.png" alt=""></div>
                <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧部门</h2>
            </div>
            <table id="demoTreeTb" lay-filter="demoTreeTb"></table>
            <i class="layui-icon layui-icon-left foldIcon" title="折叠"></i>
        </div>
    </div>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
		{{#  if(authorityObject && authorityObject['24']){ }}
        <button class="layui-btn layui-btn-sm " lay-event="import" style="margin-bottom:0px;">模板导入</button>
        {{#  } }}
		{{#  if(authorityObject && authorityObject['21']){ }}
        <button class="layui-btn layui-btn-sm " lay-event="report" style="margin-bottom:0px;">提交</button>
        {{#  } }}
        <%--暂时去掉修编和修编详情按钮--%>
        <%--{{#  if(authorityObject && authorityObject['06']){ }}
        <button class="layui-btn layui-btn-sm " lay-event="revision" style="margin-bottom:0px;">修编</button>
        {{#  } }}
        {{#  if(authorityObject && authorityObject['39']){ }}
        <button class="layui-btn layui-btn-sm " lay-event="revisionDetail" style="margin-bottom:0px;">修编详情</button>
        {{#  } }}--%>
        <div style="position:absolute;top: 0px;right:24px ">
		    {{#  if(authorityObject && authorityObject['11']){ }}
            <button class="layui-btn layui-btn-sm addLevel" lay-event="addLevel" style="margin-left:10px;">新增</button>
            {{#  } }}
		    {{#  if(authorityObject && authorityObject['12']){ }}
            <button class="layui-btn layui-btn-sm addNextLevel" lay-event="addNextLevel" style="margin-left:10px;">
                添加下一级
            </button>
            {{#  } }}
		    {{#  if(authorityObject && authorityObject['05']){ }}
            <button class="layui-btn layui-btn-sm edit" lay-event="edit" style="margin-left:10px;">编辑</button>
            {{#  } }}
		    {{#  if(authorityObject && authorityObject['04']){ }}
            <button class="layui-btn layui-btn-sm del" lay-event="del" style="margin-left:10px;">删除</button>
            {{#  } }}
            <button class="layui-btn layui-btn-sm export" lay-event="export" style="margin-left:10px;">导出</button>
<%--		    {{#  if(authorityObject){ }}--%>
<%--            <button class="layui-btn layui-btn-sm " lay-event="" style="margin-left:10px;">设置</button>--%>
<%--            {{#  } }}--%>
        </div>
    </div>
</script>
<script>

    //定义点击排序后变颜色
    var colorChange_up=''
    var colorChange_down=''
    
    initAuthority();
    
    var form
    $('.eleTree').height($(window).height() - 180)
    //选人控件添加---只能选择本部门人员
    $(document).on('click', '.userAdd', function () {
        var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : ''
        user_id = $(this).siblings('textarea').attr('id')
        $.popWindow("/projectTarget/selectOwnDeptUser" + chooseNum);
    })
    //选人控件删除
    $(document).on('click', '.userDel', function () {
        var userId = $(this).siblings('textarea').attr('id')
        $('#' + userId).val('')
        $('#' + userId).attr('user_id', '')
    })
    //选部门控件添加
    $(document).on('click', '.deptAdd', function () {
        var dutyUser=$(this).attr('dutyUser')
        $('#' + dutyUser).val('')
        $('#' + dutyUser).attr('user_id', '')
        var chooseNum = $(this).attr('chooseNum') == 1 ? '?0' : '';
        dept_id = $(this).siblings('textarea').attr('id');
        $.popWindow("/common/selectDept" + chooseNum);
    });
    //选部门控件删除
    $(document).on('click', '.deptDel', function () {
        var dutyUser=$(this).attr('dutyUser')
        $('#' + dutyUser).val('')
        $('#' + dutyUser).attr('user_id', '')
        var deptId = $(this).siblings('textarea').attr('id');
        $('#' + deptId).val('');
        $('#' + deptId).attr('deptid', '');
    });
    //删除附件
    $(document).on('click', '.deImgs',function(){
        var _this = this;
        var attUrl = $(this).parents('.dech').attr('deUrl');
        layer.confirm('确定删除该附件吗？', function(index){
            $.ajax({
                type: 'get',
                url: '/delete?'+attUrl,
                dataType: 'json',
                success:function(res){

                    if(res.flag == true){
                        layer.msg('删除成功', { icon:6});
                        $(_this).parent().remove();
                    }else{
                        layer.msg('删除失败', { icon:2});
                    }
                }
            })
        });

    });
    var dictionaryObj = {
        PBAG_NATURE: {},
        PBAG_CLASS: {},
        PBAG_TYPE: {},
        COST_TYPE: {},
        PBAG_LEVEL: {},
        ACCORDING: {},
        PLAN_SYCLE: {},
        TASK_TYPE: {},
        CUSTOMER_UNIT: {},
        WORKAREA_NAME: {},
        RENWUJIHUA_TYPE: {},
        PLAN_PHASE:{},
        CGCL_TYPE:{},
        UNIT:{},
        PLAN_RATE:{},
        CONTROL_LEVEL:{},
        TG_TYPE:{}
    }
    var dictionaryStr = 'PBAG_NATURE,PBAG_CLASS,PBAG_TYPE,COST_TYPE,PBAG_LEVEL,ACCORDING,PLAN_SYCLE,TASK_TYPE,CUSTOMER_UNIT,WORKAREA_NAME,RENWUJIHUA_TYPE,PLAN_PHASE,CGCL_TYPE,UNIT,PLAN_RATE,CONTROL_LEVEL,TG_TYPE'
    var CGCL_TYPE=''
    // 获取数据字典数据
    $.ajax({
        url: '/Dictonary/selectDictionaryByDictNos',
        dataType: 'json',
        type: 'get',
        async: false,
        data: {dictNos: dictionaryStr},
        success: function (res) {
            if (res.flag) {
                if(res.object['CGCL_TYPE']){
                    CGCL_TYPE=res.object['CGCL_TYPE']
                }
                for (var dict in dictionaryObj) {
                    if(dict=='PLAN_RATE'){
                        dictionaryObj[dict] = {object: {}, str: ''}
                    }else{
                        dictionaryObj[dict] = {object: {}, str: '<option value="">请选择</option>'}
                    }
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
    layui.use(['treeTable', 'form', 'eleTree', 'laydate','table'], function () {
        var treeTable = layui.treeTable;
        var eleTree = layui.eleTree;
        var laydate = layui.laydate;
        var table = layui.table;
        form = layui.form;
        var insTree
        var insTb
        $('.query select[name="planSycle"]').append(dictionaryObj['PLAN_SYCLE']['str'])
        $('.query select[name="taskType"]').append(dictionaryObj['RENWUJIHUA_TYPE']['str'])
        form.render();
        // 计划期间年度列表
        var allYear = '';
        // 获取计划期间年度列表
        $.get('/planPeroidSetting/selectAllYear', function(res) {
            if (res.object.length > 0) {
                res.object.forEach(function(item){
                    allYear += '<option value="'+item.periodYear+'">'+item.periodYear+'</option>'
                });
            }
            $('.query [name="year"]').append(allYear);
            form.render('select');
        });
        // 获取月度
        form.on('select(year)', function (data) {
            getPlanMonth(data.value, function (monthStr) {
                $('.query [name="month"]').html(monthStr);
                form.render('select');
            });
        });
        //左侧下拉框部门展示
        $.ajax({
            url: '/plcOrg/selectYJ',
            dataType: 'json',
            type: 'get',
            success: function (res) {
                var data = res.obj
                var str = '<option value="">请选择</option>'
                for (var i = 0; i < data.length; i++) {
                    str += '<option value="' + data[i].projOrgId + '">' + data[i].contractorName + '</option>'
                }
                $('.con_left [name="deptName"]').html(str)
                form.render()
                projectLeft('')
            }
        })
        //加监听左侧下拉框部门选择
        form.on('select(deptName)', function (data) {
            // console.log(data.value); //得到被选中的值
            projectLeft(data.value)
        });
        //左侧项目机构列表
        function projectLeft(projOrgId) {
            insTree = eleTree.render({
                elem: '.ele1',
                url: '/plcOrg/getTreeListByLoginer?projOrgId=' + projOrgId,
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
                    dataName: "object"
                },
            });
        }
        // 节点点击事件
        eleTree.on("nodeClick(projectLeft)", function (d) {
            //清空切换时排序高亮
            colorChange_up=false
            colorChange_down=false
            var currentData = d.data.currentData;
            // console.log(d.data);    // 点击节点对于的数据
            if((currentData.orgType=='01' || currentData.orgType=='02' || currentData.orgType=='03' || currentData.orgType=='04') && d.data.currentData.isPermission != '0'){
                $('.tishi').hide()
                $('.ew-tree-table').show()
                $('.foldIcon').show()
                treeTableShow(d.data.currentData.projOrgId)
                $('#leftId').attr('projOrgId',d.data.currentData.projOrgId)
                $('#leftId').attr('contractorName',d.data.currentData.contractorName)
                $('#leftId').attr('deptId',d.data.currentData.deptId)
            }else{
                $('.tishi').show()
                $('.ew-tree-table').hide()
                $('.foldIcon').hide()
            }
        })
        // 渲染树形表格
        function treeTableShow(projOrgId) {
            insTb = treeTable.render({
                elem: '#demoTreeTb',
                url: '/plcProjectItem/itemByDeptId?projOrgId=' + projOrgId+'&_='+new Date().getTime(),
                toolbar: '#toolbarDemo',
                tree: {
                    iconIndex: 1,           // 折叠图标显示在第几列
                    idName: 'planItemId',
                    childName: "items"
                },
                cols: [[
                    {type: 'checkbox'},
                    {
                        field: 'taskNo', title: '子任务编号',width:150
                    },
                     {field: 'examineStatus', title: '状态', width: 20,templet: function (d) {
                            if(d.examineStatus==1){
                                return  '<span class="examineStatus" examineStatus="'+d.examineStatus+'">正在审批中</span>'
                            }else if(d.examineStatus==2){
                                return   '<span class="examineStatus" examineStatus="'+d.examineStatus+'">同意</span>'
                            }else if(d.examineStatus==3){
                                return   '<span class="examineStatus" examineStatus="'+d.examineStatus+'">退回</span>'
                            }else if(d.examineStatus==4){
                                return   '<span class="examineStatus" examineStatus="'+d.examineStatus+'">已上报</span>'
                            }else{
                                return  '<span class="examineStatus">未提交</span>'
                            }
                        }},
                    {
                        field: 'taskName', title: '子任务名称', width: 300,style:"color:blue;cursor: pointer",templet: function (d) {
                            return  '<span class="taskDetail" planItemId="'+d.planItemId+'" parentPlanItemId="'+d.parentPlanItemId+'">'+d.taskName+'</span>'
                        }
                    },
                    {field: 'tgId', title: '关联关键任务', width: 150,templet: function (d) {
                            var tgIds=''
                            if(d.tgIds){
                                d.tgIds.forEach(function (item) {
                                    tgIds+=item.tgName+','
                                })
                                return tgIds.replace(/,$/, '')
                            }else{
                                return  ''
                            }
                        }},
                    {
                        field: 'planSycle', title: '周期类型', width: 100, templet: function (d) {
                            return dictionaryObj['PLAN_SYCLE']['object'][d.planSycle] || ''
                        }
                    },
                    {
                        field: 'taskType', title: '任务来源', width: 100, templet: function (d) {
                            return dictionaryObj['RENWUJIHUA_TYPE']['object'][d.taskType] || ''
                        }
                    },
                     /* {field: 'planStage', title: '计划阶段',templet: function(d){
                              return  dictionaryObj['PLAN_PHASE']['object'][d.planStage] || ''
                          }},
                    {field: 'designQuantity', title: '设计量'},
                    {field: 'itemQuantity', title: '工程量'},
                    {field: 'itemQuantityNuit', title: '单位',templet: function (d) {
                            return dictionaryObj['UNIT']['object'][d.itemQuantityNuit] || ''
                        }},*/
                     {field: 'dutyUserName', title: '负责人'},
                    {field: 'mainCenterDeptName', title: '责任部门',width: 120},
                    {field: 'assistCompanyDeptsName', title: '协助部门',width: 120},
                    {field: 'planContinuedDate', title: '计划工期',width: 80},
                    {
                        field: 'planStartDate', title: '计划开始时间', width: 120, templet: function (d) {
                            return format(d.planStartDate)
                        }
                    },
                    {
                        field: 'planEndDate', title: '计划结束时间', width: 120, templet: function (d) {
                            return format(d.planEndDate)
                        }
                    },
                    {
                        field: 'resultStandard', title: '完成标准', width: 130,
                    },
                    {field: 'preTask', title: '前置子任务', width: 150,templet: function (d) {
                            var preTasks=''
                            if(d.preTasks){
                                d.preTasks.forEach(function (item) {
                                    preTasks+=item.workItemName+','
                                })
                                return preTasks.replace(/,$/, '').split(',')
                            }else{
                                return  ''
                            }
                        }},
                    {field: 'riskPoint', title: '风险点', width: 120},
                    {field: 'difficultPoint', title: '难度点', width: 120},
                    {field: 'hardDegree', title: '难度系数', width: 120},
                    {
                        field: 'planType', title: '任务类型', width: 100, templet: function (d) {
                            return dictionaryObj['TG_TYPE']['object'][d.planType] || ''
                        }
                    },
                    {
                        field: 'taskDesc', title: '子任务描述', width: 120,
                    }
                ]],
                height: 'full-150',
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj //解析数据列表
                    };
                },
                done: function (res) {
                    // console.log(res)
                    // $('th[data-type="checkbox"] .ew-tree-table-cell').remove()
                    $('.ew-tree-table-tool-item').eq(1).hide()
                    $('.ew-tree-table-tool-item').eq(2).hide()
                    // $('.ew-tree-table-box').height($(window).height()-200)

                    //增加负责人的排序
                    $('thead th').eq(7).find('.ew-tree-table-cell-content').html('<span style="cursor: move;">负责人</span><span class="layui-table-sort layui-inline"><i class="layui-edge layui-table-sort-asc sort" title="升序"></i><i class="layui-edge layui-table-sort-desc sort" title="降序"></i></span>')
                    //给选中高亮
                    if(colorChange_up){
                        $('.layui-table-sort-asc').css('border-bottom-color','#666')
                    }else if(colorChange_down){
                        $('.layui-table-sort-desc').css('border-top-color','#666')
                    }
                }
            });
        }

        //监听责任人排序
        $(document).on('click','.sort',function () {
            if($(this).attr('title')=='升序'){
                var orderBy=1
                colorChange_up=true
                colorChange_down=false
            }else{
                var orderBy=2
                colorChange_down=true
                colorChange_up=false
            }
            insTb.reload({
                where:{
                    orderBy:orderBy //排序方式
                },
            })
        })

        // treeTableShow(58)
        treeTable.on('toolbar(demoTreeTb)', function (obj) {
            // console.log(obj)
            switch (obj.event) {
                case 'revision':
                    if(insTb.checkStatus().length==0){
                        layer.msg('请选择至少一项子任务！',{icon:0});
                        return false
                    }
                    for(var i=0;i<insTb.checkStatus().length;i++){
                        if(insTb.checkStatus()[i].examineStatus!=2){
                            layer.msg('该子任务还未同意，不可修编！', {icon: 0, time: 1000});
                            return false;
                        }
                    }
                    var planItemIds=revisionPlanItemId()
                    // console.log(planItemIds)
                    openRevision(planItemIds)
                    break;
                case 'revisionDetail':
                    if(insTb.checkStatus().length==0){
                        layer.msg('请选择至少一项子任务！',{icon:0});
                        return false
                    }
                    openRevisionDetail()
                    break;
                case 'import':
                    var projOrgId = $('#leftId').attr('projOrgId');
                    initProjectPlan(projOrgId);
                    break;
                case 'report':
                    if(insTb.checkStatus().length==0){
                        layer.msg('请选择至少一项子任务！',{icon:0});
                        return false
                    }
                    for(var i=0;i<insTb.checkStatus().length;i++){
                        if(!insTb.checkStatus()[i].planStartDate){
                            layer.msg('请将勾选的子任务中的“'+insTb.checkStatus()[i].taskName+'”的计划开始时间补充完整！',{icon:0});
                            return false
                        }
                    }
                    var planItemIds=''
                    insTb.checkStatus().forEach(function (v,i) {
                        planItemIds+=v.planItemId+','
                    })
                    shangbao(planItemIds)
                    break;
                case 'addLevel':
                    // console.log(insTb.checkStatus())
                    //添加平级，传父id
                    if ($('td .layui-form-checked').length > 1) {
                        // if($('.layui-form-checked').length!=1){
                        layer.msg('请选择一项子任务！', {icon: 0});
                        return false
                    }
                    //没有选择子项目时，可直接增加平级
                    if ($('td .layui-form-checked').length == 0) {
                        creat(0, 1, $('#leftId').attr('projOrgId'), 0)
                    }else{
                        creat(0, 1, $('#leftId').attr('projOrgId'), insTb.checkStatus()[0].parentPlanItemId)
                    }
                    //添加平级时需判断该层级是否时最高级子任务,若是最高级则传projOrgId，否则传空
                   /* if($('.layui-form-checked').length>0){
                        if(insTb.checkStatus()[0].parentPlanItemId==0){
                            creat(0, 1, $('#leftId').attr('projOrgId'), 0)
                        }else{
                            creat(0, 1, '', insTb.checkStatus()[0].parentPlanItemId)
                        }
                    }*/
                    break;
                case 'addNextLevel':
                    //添加下一级，传本身id
                    if ($('td .layui-form-checked').length != 1) {
                        layer.msg('请选择一项子任务！', {icon: 0});
                        return false
                    }
                    creat(0, 0, $('#leftId').attr('projOrgId'), insTb.checkStatus()[0].planItemId)
                    break;
                case 'edit':
                    if ($('td .layui-form-checked').length != 1) {
                        layer.msg('请选择一项子任务！', {icon: 0});
                        return false
                    }
                    if(insTb.checkStatus()[0].examineStatus==1){
                        layer.msg('该子任务正在审批中，不可编辑！', {icon: 0, time: 1000});
                        return false;
                    }else if(insTb.checkStatus()[0].examineStatus==2){
                        layer.msg('该子任务已同意，不可编辑！', {icon: 0, time: 1000});
                        return false;
                    }else if(insTb.checkStatus()[0].examineStatus==4){
                        layer.msg('该子任务已上报，不可编辑！', {icon: 0, time: 1000});
                        return false;
                    }
                    creat(1, '', '',insTb.checkStatus()[0].parentPlanItemId , insTb.checkStatus()[0].planItemId, insTb.checkStatus()[0])
                    break;
                case 'del':
                    // console.log(insTb.checkStatus())
                    if ($('td .layui-form-checked').length == 0) {
                        layer.msg('请至少选择一项子任务！', {icon: 0});
                        return false
                    }
                    var planItemId=[]
                    insTb.checkStatus().forEach(function (v,i) {
                        planItemId.push(v.planItemId)
                    })
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.ajax({
                            url: '/plcProjectItem/delete',
                            dataType: 'json',
                            type: 'post',
                            data: {planItemId: planItemId},
                            traditional:true,
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('删除成功！', {icon: 1});
                                } else {
                                    layer.msg('删除失败！', {icon: 0});
                                }
                                layer.close(index)
                                insTb.reload()
                            }
                        })
                    });
                    break;
                //导出
                case 'export':
                    $('.ew-tree-table-tool-right .ew-tree-table-tool-item').eq(1).trigger('click')
                    $('.ew-tree-table-tool-right .ew-tree-table-tool-item').eq(1).find('ul li').eq(1).trigger('click')
                    break;
            }
            ;
        });

        // 监听行双击事件
        treeTable.on('rowDouble(demoTreeTb)', function(obj){
            if(obj.data.examineStatus==1){
                layer.msg('该子任务正在审批中，不可编辑！', {icon: 0, time: 1000});
                return false;
            }else if(obj.data.examineStatus==2){
                layer.msg('该子任务已同意，不可编辑！', {icon: 0, time: 1000});
                return false;
            }else if(obj.data.examineStatus==4){
                layer.msg('该子任务已上报，不可编辑！', {icon: 0, time: 1000});
                return false;
            }
            creat(1, '', '',obj.data.parentPlanItemId , obj.data.planItemId, obj.data)
        });
        //修编时勾选的子任务id(只传最高级父元素的id)
        function revisionPlanItemId() {
            var arrId=[]
            var planItemIdArr=[]
            $('tbody td .layui-form-checked').each(function (index,item) {
                //判断是否有子集
                if($(this).parents('tr').attr('data-indent')!=0){
                    arrId.push($(this).parents('tr').prevAll('tr[data-indent="0"]').last().find('.taskDetail').attr('planItemId'))
                }else{
                    arrId.push($(this).parents('tr').find('.taskDetail').attr('planItemId'))
                }
            })
            //数组去重
            for(var i=0;i<arrId.length;i++){
                if(planItemIdArr.indexOf(arrId[i])==-1){
                    planItemIdArr.push(arrId[i])
                }
            }
            // console.log(pbagIdArr)
            var planItemId=planItemIdArr.join(',')
            return  planItemId
        }
        //修编
        function openRevision(planItemIds){
            $.post('/plcProjectItem/selectByIds',{ids:planItemIds,type:1},function (res) {
                  for(var i=0;i<res.object.length;i++){
                      if(!res.object[i].planStartDate){
                          layer.msg('请将勾选的子任务中的计划开始时间补充完整！', {icon: 0});
                          return false
                      }else if(!res.object[i].planEndDate){
                          layer.msg('请将勾选的子任务中的计划结束时间补充完整！', {icon: 0});
                          return false
                      }else if(!res.object[i].planContinuedDate){
                          layer.msg('请将勾选的子任务中的计划工期补充完整！', {icon: 0});
                          return false
                      }
                  }
                layer.open({
                    type: 1,
                    title: '修编',
                    area: ['80%', '70%'],
                    maxmin:true,
                    min: function(){
                        $('.layui-layer-shade').hide()
                    },
                    btn:['确定','取消'],
                    content: '<div>' +
                        '<table id="revisionTreetable" lay-filter="revisionTreetable"></table>'+
                        '</div>',
                    success:function () {
                        treeTable.render({
                            elem: '#revisionTreetable',
                            data: res.object,
                            tree: {
                                iconIndex: 1,           // 折叠图标显示在第几列
                                idName:'planItemId',
                                childName:"items"
                            },
                            cols: [[
                                {field: 'taskNo', title: '子任务编号',},
                                {field: 'taskName', title: '子任务名称',templet: function(d){
                                        return '<span  class="taskName" planItemId="'+d.planItemId+'" >'+ d.taskName +'</span>'
                                    }},
                                {field: 'planStartDate', title: '计划开始时间',templet: function(d){
                                        return '<input type="text" readonly class="layui-input treeTable_date_start" value="'+format(d.planStartDate)+'">'
                                    }},
                                {field: 'planEndDate', title: '计划结束时间',templet: function(d){
                                        return '<input type="text" readonly class="layui-input treeTable_date_end" value="'+format(d.planEndDate)+'">'
                                    }},
                                {field: 'planContinuedDate', title: '计划工期',templet: function(d){
                                        return '<span class="treeTable_planPeriod">'+d.planContinuedDate+'</span>'
                                    }},
                            ]],
                            done:function (res) {
                                var vars={}; //批量定义
                                $('.treeTable_date_start').each(function(index,item) {
                                    var varStart='start'+index;  //动态定义变量名
                                    $('.treeTable_date_start').eq(index).attr('number',index)
                                    vars[varStart]=laydate.render({
                                        elem:this
                                        ,trigger : 'click'
                                        ,btns: ['now', 'confirm']
                                        ,max: $(this).parents('tr').find('.treeTable_date_end').val()
                                        ,done: function (value, date) {
                                            var $tr = $(item).parents('tr')
                                            var planPeriod = timeRange(value, $tr.find('.treeTable_date_end').val()) + '天';
                                            $tr.find('.treeTable_planPeriod').text(planPeriod);
                                            var number=$('.treeTable_date_start').eq(index).attr('number')
                                            if (vars['end'+number].config.min) {
                                                vars['end'+number].config.min = {
                                                    year: date.year || 1900,
                                                    month: date.month - 1 || 0,
                                                    date: date.date || 1,
                                                }
                                            } else {
                                                vars['end'+number].min = value;
                                            }
                                        }
                                    });
                                });
                                $('.treeTable_date_end').each(function(index,item) {
                                    var varEnd='end'+index;  //动态定义变量名
                                    $('.treeTable_date_end').eq(index).attr('number',index)
                                    vars[varEnd]=laydate.render({
                                        elem:this
                                        ,trigger:'click'
                                        ,btns: ['now', 'confirm']
                                        ,min: $(this).parents('tr').find('.treeTable_date_start').val()
                                        ,done: function (value, date) {
                                            var $tr = $(item).parents('tr')
                                            var planPeriod = timeRange($tr.find('.treeTable_date_start').val(), value) + '天';
                                            $tr.find('.treeTable_planPeriod').text(planPeriod);
                                            var number=$('.treeTable_date_end').eq(index).attr('number')
                                            if (vars['start'+number].config.max) {
                                                vars['start'+number].config.max = {
                                                    year: date.year || 1900,
                                                    month: date.month - 1 || 0,
                                                    date: date.date || 1,
                                                }
                                            } else {
                                                vars['start'+number].max = value;
                                            }
                                        }
                                    });
                                });
                                // console.log(vars)
                                //在每次动态生成laydate组件时, laydate框架会给input输入框增加一个lay-key="1",
                                //这样就导致了多个laydate 的inpute框都有lay-key="1"这个属性。导致时间控件不起作用，
                                //需要把动态生成的lay-key属性删除
                                // $(".treeTable_date_start").removeAttr("lay-key");
                            }
                        });
                    },
                    yes:function (index) {
                        var arr=[]
                        $('#revisionTreetable').next().find('.ew-tree-table-box tr').each(function () {
                            if($(this).find('.treeTable_date_start').val() && $(this).find('.treeTable_date_end').val()){
                                var obj={}
                                obj.planStartDate=$(this).find('.treeTable_date_start').val()
                                obj.planEndDate=$(this).find('.treeTable_date_end').val()
                                obj.planContinuedDate=$(this).find('.treeTable_planPeriod').text()
                                obj.planItemId=$(this).find('.taskName').attr('planitemid')
                                arr.push(obj)
                            }
                        })
                        // console.log(arr)
                        $.ajax({
                            url:'/plcProjectItem/revision',
                            data:JSON.stringify(arr),
                            contentType:"application/json;charset=UTF-8",
                            dataType:'json',
                            type:'post',
                            success:function(res){
                                if(res.flag){
                                    layer.msg('修编成功！', {icon: 1});
                                    layer.close(index)
                                    insTb.reload()
                                }
                            }
                        })
                    }
                })
            })
        }
        //修编详情
        function  openRevisionDetail(){
            var planItemId=''
            $('tbody td .layui-form-checked').each(function (index,item) {
                planItemId+=$(this).parents('tr').find('.taskDetail').attr('planItemId')+','
            })
            $.post('/EditRecord/selectByPlanItemId',{planItemId:planItemId},function (res) {
                layer.open({
                    type: 1,
                    title: '修编详情',
                    area: ['80%', '70%'],
                    content: '<div id="revision_view"></div>',
                    success:function () {
                        var data=res.obj
                        if(res.flag && data.length>0){
                            data.forEach(function (item,index) {
                                if(item.length>0){
                                    var tableTitle='<table class="layui-table"><thead><tr>'+'<th nowrap="nowrap">子任务名称</th>'
                                    var str='<tbody><tr>'+'<td>'+function () {
                                        if(item.length>0){
                                            return  item[0].planItemName
                                        }else{
                                            return ''
                                        }
                                    }()+'</td>'
                                    var editArr=[]
                                    //对数据进行分割处理
                                    item.forEach(function (v,i) {
                                        if(i==0){
                                            var bEditContent=v.bEditContent.split('&')
                                            var aEditContent=v.aEditContent.split('&')
                                            editArr=editArr.concat(bEditContent).concat(aEditContent)
                                        }else{
                                            var aEditContent=v.aEditContent.split('&')
                                            editArr=editArr.concat(aEditContent)
                                        }
                                    })
                                    //对表头显示处理
                                    for(var i=0;i<item.length+1;i++){
                                        if(i==item.length){
                                            tableTitle+='<th nowrap="nowrap">计划开始时间</th>\n' +
                                                '      <th nowrap="nowrap">计划结束时间</th>\n' +
                                                '      <th nowrap="nowrap">计划工期</th></thead>'
                                        }else{
                                            tableTitle+='<th nowrap="nowrap">计划开始时间</th>\n' +
                                                '      <th nowrap="nowrap">计划结束时间</th>\n' +
                                                '      <th nowrap="nowrap">计划工期</th>'
                                        }
                                    }
                                    editArr.forEach(function (v,i) {
                                        if(i==editArr.length-1){
                                            str+='<td nowrap="nowrap">'+v+'</td></tr></tbody></table>'
                                        }else{
                                            str+='<td nowrap="nowrap">'+v+'</td>'
                                        }
                                    })
                                    /*  console.log(tableTitle)
                                      console.log(str)*/
                                    $('#revision_view').append(tableTitle+str)
                                }else{
                                    $('#revision_view').append('<p style="text-align: center">暂无修编详情</p>')
                                }
                            })
                        }
                    },
                })
            })
        }
        //判断是否全选
        treeTable.on('checkbox(demoTreeTb)', function(obj){
            /* console.log(obj.checked);  // 当前是否选中状态
             console.log(obj.data);  // 选中行的相关数据
             console.log(obj.type);  // 如果触发的是全选，则为：all，如果触发的是单选，则为：more*/
            if(obj.type=='more'){
                var checkbox=$('tbody td .layui-form-checkbox')
                for(var i=0;i<checkbox.length;i++){
                    if(!checkbox.eq(i).hasClass('layui-form-checked')){
                        $('thead th .layui-form-checkbox').removeClass('layui-form-checked')
                        return false
                    }else{
                        $('thead th .layui-form-checkbox').addClass('layui-form-checked')
                    }
                }
            }
        });
        //添加平级、添加下一级
        function creat(type, isLevel, itemBelongDept, parentPlanItemId,planItemId, data) {
            var title=''
            var url=''
            if (type == '0') {
                //判断是增加平级还是增加下一级
                if (isLevel) {
                    title = '计划子任务-添加'
                } else {
                    title = '计划子任务-添加下一级'
                }
                url = '/plcProjectItem/add'
            } else if (type == '1') {
                title = '编辑子任务'
                url = '/plcProjectItem/update'
            } else {
                title = '查看子任务'
            }
            if(type=='0'){
                layer.confirm('是否要关联关键任务？', {
                    btn: ['关联', '不关联', '取消'] //可以无限个按钮
                    ,btn3: function(index, layero){
                        //按钮【按钮三】的回调
                    }
                }, function(index, layero){
                    newAndEdit(type, isLevel, itemBelongDept, parentPlanItemId,planItemId, data,url,title,true)
                }, function(index){
                    newAndEdit(type, isLevel, itemBelongDept, parentPlanItemId,planItemId, data,url,title,false)
                });
            }else{
                newAndEdit(type, isLevel, itemBelongDept, parentPlanItemId,planItemId, data,url,title)
            }
        }

        function newAndEdit(type, isLevel, itemBelongDept, parentPlanItemId,planItemId, data,url,title,isRelation) {
            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                maxmin: true,
                min: function () {
                    $('.layui-layer-shade').hide()
                },
                btn: ['保存', '取消'],
                content: '<form class="layui-form" id="form" lay-filter="formTest">' +

                    //第十五行----关联关键任务
                    '<div class="layui-row" id="relationShow">' +
                    ' <div class="newAndEdit layui-col-xs12"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">关联关键任务<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '<input type="text" name="tgId" readonly style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input jinyong testRelationTarget" title="关联关键任务">\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="relationAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="relationDel">清空</a>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    '</div>' +

                    //第一行
                    '<div class="layui-row">' +
                    '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">编号<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="taskNo" readonly style="background:#e7e7e7;width:90%;display:inline-block" autocomplete="off" class="layui-input jinyong testNull" title="编号">\n' +
                    '<button type="button" class="layui-btn layui-btn-sm refresh">刷新</button>'+
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    '<div class="newAndEdit layui-col-xs6" style="margin-top:15px;"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">上级子任务名称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="topItem" readonly style="background:#e7e7e7;"  autocomplete="off" class="layui-input jinyong testNull" title="上级子任务名称">\n' +
                    '    </div>\n' +
                    '  </div></div>' +
                    '</div>' +
                    //第二行
                    '<div class="layui-row">' +
                    '<div class="newAndEdit layui-col-xs6"> <div class="layui-form-item" >\n' +
                    '    <label class="layui-form-label">子任务名称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="taskName"  autocomplete="off" class="layui-input jinyong testNull" title="子任务名称">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    '<div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                    // '    <label class="layui-form-label">关联关键任务</label>\n' +
                    '    <label class="layui-form-label">计划形式</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <select name="planRate" lay-verify="required" >\n' +
                    '      </select>'+
                    '    </div>\n' +
                    '  </div></div>' +
                    '</div>' +
                    //第三行
                    '<div class="layui-row">' +
                    '<div class="newAndEdit layui-col-xs4">  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">周期类型<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block planSycle">\n' +
                    ' <select name="planSycle" lay-verify="required" class="jinyong testNull" title="周期类型" >\n' +
                    '      </select>' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">任务来源<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <select name="taskType" lay-verify="required" class="jinyong testNull" title="任务来源">\n' +
                    '      </select>' +
                    '    </div>\n' +
                    '  </div> </div>' +
                    ' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">任务类型<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +   //取数据字典里的目标类型---TG_TYPE
                    '    <div class="layui-input-block">\n' +
                    /*' <select name="planType" lay-verify="required" class="jinyong testNull" title="任务类型">\n' +
                    '      </select>'+*/
                    '<input type="text" name="planType" id="tgType_add" readonly title="任务类型" style="background:#e7e7e7;width:70%;display:inline-block" autocomplete="off" class="layui-input testNull" >' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="tgTypeAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="tgTypeDel">清空</a>\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '  </div>'+
                    '</div>' +
                    //第四行
                    //第六行
                    '<div class="layui-row">' +
                    '<div class="newAndEdit layui-col-xs6">  <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">负责人</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '  <textarea  type="text"  title="负责人" name="dutyUser" id="dutyUser" readonly  style="background:#e7e7e7;height: 45px;width:83%;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" class="userAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="userDel">清空</a>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="newAndEdit layui-col-xs6"><div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">责任部门<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '  <textarea  type="text" title="责任部门" class="testNull" name="mainCenterDept" id="mainCenterDept" readonly  style="background:#e7e7e7;height: 45px;width: 99%;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    /*不允许修改责任部门2020.10.21*/
                    /*  '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="1" dutyUser="dutyUser" class="deptAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px"  dutyUser="dutyUser" class="deptDel">清空</a>\n' +*/
                    '    </div>\n' +
                    '  </div> </div>' +
                    '</div>' +

                    //第七行
                    '<div class="layui-row">' +
                    ' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">计划开始时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block appendStartTime">\n' +
                    '      <input type="text" class="layui-input jinyong testNull" autocomplete="off" name="planStartDate" id="planStartDate" title="计划开始时间">' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">计划结束时间<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block appendEndTime">\n' +
                    '      <input type="text" class="layui-input jinyong testNull" autocomplete="off" name="planEndDate" id="planEndDate" title="计划结束时间">' +
                    '    </div>\n' +
                    '  </div> </div>' +
                    ' <div class="newAndEdit layui-col-xs4"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">计划工期<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="planContinuedDate" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input jinyong testNull" title="计划工期">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    '</div>' +
                    //第八行
                    '<div class="layui-row">' +
                    ' <div class="newAndEdit layui-col-xs12"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">完成标准<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="resultStandard"  autocomplete="off" class="layui-input jinyong testNull" title="完成标准">\n' +
                    '    </div>\n' +
                    '  </div> </div>' +
                    '</div>' +
                    //第九行
                    '<div class="layui-row">' +
                    ' <div class="newAndEdit layui-col-xs11"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">前置子任务</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="preTaskId" readonly  autocomplete="off" class="layui-input jinyong" style="background:#e7e7e7;">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="newAndEdit layui-col-xs1"> <div class="layui-form-item">\n' +
                    '<button type="button" class="layui-btn settings" style="margin-left: 25px">设置</button>'+
                    '  </div> </div>' +
                    '</div>' +
                    //第十行
                    '<div class="layui-row">' +
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">风险点</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="riskPoint"  autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">难度点</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="difficultPoint"  autocomplete="off" class="layui-input jinyong">\n' +
                    '    </div>\n' +
                    '  </div> </div>' +
                    '</div>' +
                    //第十二行
                    '<div class="layui-row">' +
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">成果标准模板<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '<input type="text" name="resultDict" readonly title="成果标准模板" style="background:#e7e7e7;width:83%;display:inline-block" autocomplete="off" class="layui-input testNull" >\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="resultDictAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="resultDictDel">清空</a>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">协助部门</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '  <textarea  type="text" name="assistCompanyDepts" id="assistCompanyDepts" readonly  style="background:#e7e7e7;height: 45px;width: 83%;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" chooseNum="2" class="deptAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="deptDel">清空</a>\n' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    '</div>' +

                    //第十三行
                    '<div class="layui-row">' +
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">协助计划开始时间</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" class="layui-input" autocomplete="off" name="assistStartDate" id="assistStartDate">' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">协助计划结束时间</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" class="layui-input" autocomplete="off" name="assistEndDate" id="assistEndDate">' +
                    '    </div>\n' +
                    '  </div> </div>' +
                    '</div>' +

                    //第十三行
                    '<div class="layui-row">' +
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">难度系数<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    // '      <input type="text" name="hardDegree" title="难度系数"  autocomplete="off" class="layui-input jinyong testNull">\n' +
                    ' <select name="hardDegree" lay-verify="required"  title="难度系数"  class="jinyong testNull">\n' +
                    '<option value="1">1</option>'+
                    '<option value="2">2</option>'+
                    '<option value="3">3</option>'+
                    '<option value="4">4</option>'+
                    '<option value="5">5</option>'+
                    '<option value="6">6</option>'+
                    '<option value="7">7</option>'+
                    '<option value="8">8</option>'+
                    '<option value="9">9</option>'+
                    '<option value="10">10</option>'+
                    '      </select>'+
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    ' <div class="newAndEdit layui-col-xs6"> <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label" style="padding: 9px;width: 90px">提前几天提醒</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <select name="earlyWarning" lay-verify="required" class="jinyong">\n' +
                    '<option value="1">1</option>'+
                    '<option value="2">2</option>'+
                    '<option value="3">3</option>'+
                    '<option value="4">4</option>'+
                    '<option value="5">5</option>'+
                    '<option value="6">6</option>'+
                    '<option value="7">7</option>'+
                    '<option value="8">8</option>'+
                    '      </select>' +
                    '    </div>\n' +
                    '  </div>' +
                    '  </div>' +
                    '</div>' +
                    //第十四行
                    '<div><div class="layui-form-item">' +
                    '    <label class="layui-form-label">子任务描述</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '<textarea name="taskDesc"  class="layui-textarea jinyong"></textarea>' +
                    '    </div>\n' +
                    '</div>' +
                    '</div>' +

                    //第十五行
                    ' <div class="layui-form-item"  style="margin-top:15px">\n' +
                    '    <label class="layui-form-label" style="padding:3px 15px">编制依据附件:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <div id="fileContent">\n' +
                    '</div>\n' +
                    '<a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                    '<img src="../img/mg11.png" alt="">\n' +
                    '<span><fmt:message code="email.th.addfile"/></span>\n' +
                    '<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
                    '</a>\n' +
                    '<div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">\n' +
                    '<div class="bar" style="width: 0%;"></div>\n' +
                    '</div>\n' +
                    '<div class="barText" style="float: left;margin-left: 10px;"></div>'+
                    '</div>\n' +
                    '</div>' +

                    '</form>',
                success: function () {
                    //周期类型默认不可更改
                    $('#form select[name="planSycle"]').attr('disabled','disabled')
                    fileuploadFn('#fileupload', $('#fileContent'));
                    $('select[name="planSycle"]').html(dictionaryObj['PLAN_SYCLE']['str'])
                    $('select[name="taskType"]').html(dictionaryObj['RENWUJIHUA_TYPE']['str'])
                    $('select[name="planRate"]').html(dictionaryObj['PLAN_RATE']['str'])
                    // $('select[name="planType"]').html(dictionaryObj['TG_TYPE']['str'])
                    if(type==0){
                        //默认难度系数为5
                        $('select[name="hardDegree"]').val('5')
                        //默认提前几天提醒为3
                        $('select[name="earlyWarning"]').val('3')
                        //编号
                        $.get('/ProjectInfo/getMaxNo',{model:'projectItem'},function (res) {
                            $('form input[name="taskNo"]').val(res)
                        })
                        //新建时自动显示登录人和所属部门
                        $.get('/user/userCookie',{_:new Date().getTime()},function (res) {
                            if(res.flag){
                                $('#form textarea[name=dutyUser]').val(res.object.userName)
                                $('#form textarea[name=dutyUser]').attr('user_id',res.object.userId)
                                /*责任部门有时接口不返，取左侧部门名称和id*/
                                $('#form textarea[name=mainCenterDept]').val($('#leftId').attr('contractorName'))
                                $('#form textarea[name=mainCenterDept]').attr('deptId',$('#leftId').attr('deptId'))
                            }
                        })
                        //新建时默认周期类型为月度
                        $('#form select[name="planSycle"] option').each(function () {
                            if($(this).text()=='月度'){
                                $('#form select[name="planSycle"]').val($(this).val())
                                form.render()
                            }
                        })
                        //新建时 1.关联关键任务时默认任务来源为计划分解2.不关联关键任务时默认任务来源为日常工作
                        $('#form select[name="taskType"] option').each(function () {
                            if(isRelation){
                                if($(this).text()=='计划分解'){
                                    $('#form select[name="taskType"]').val($(this).val())
                                    form.render()
                                    return false
                                }
                            }else{
                                if($(this).text()=='日常工作'){
                                    $('#form select[name="taskType"]').val($(this).val())
                                    form.render()
                                    return false
                                }
                            }
                        })
                        /*判断新建时是否显示关联关键任务*/
                        if(isRelation){
                            $('#relationShow').show()
                        }else{
                            $('#relationShow').hide()
                        }
                    }
                    //点击刷新按钮
                    $('.refresh').on("click",function () {
                        $.get('/ProjectInfo/getMaxNo',{model:'projectItem'},function (res) {
                            $('form input[name="taskNo"]').val(res)
                        })
                    })
                    //关联关键任务
                    $('.relationAdd').on("click",function () {
                        layer.open({
                            type: 2,
                            title: '添加关联关键任务',
                            area: ['80%', '80%'],
                            btn: ['确定', '取消'],
                            // content:'<div  class="layui-form relation"  style="margin-top: 15px"></div>',
                            content:'/plcProjectItem/relationTarget',
                            success:function () {
                                /*var tgId=$('form input[name="tgId"]').attr('tgId')
                                if(tgId){
                                    var tgArr=tgId.replace(/,$/, '').split(',')
                                }
                                $.get('/projectTarget/getDropDown',function (res) {
                                    if(res.flag){
                                        if(res.obj && res.obj.length>0){
                                            var data=res.obj
                                            var str=''
                                            for(var i=0;i<data.length;i++){
                                                str+='<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+res.obj[i].tgName+'" title="'+res.obj[i].tgName+'" value="'+res.obj[i].tgId+'" lay-skin="primary"> </div>'
                                            }
                                            $('.relation').html(str)
                                            form.render()
                                            if(tgArr){
                                                $('.relation input').each(function (index) {
                                                    tgArr.forEach(function (v,i) {
                                                        if($('.relation input').eq(index).val()==v){
                                                            $('.relation input').eq(index).prop('checked','true')
                                                            form.render()
                                                        }
                                                    })
                                                })
                                            }
                                        }
                                    }
                                })*/
                            },
                            yes:function (index, layero) {
                                var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                                // console.log(iframeWin.leftArr)
                                var ids=iframeWin.leftArr.join()
                                $.post('/projectTarget/selectByIds',{ids:ids},function (res) {
                                    if(res.flag){
                                        var tgId=''
                                        var tgName=''
                                        var str='<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 20px;">\n' +
                                            '  <thead>\n' +
                                            '    <tr>\n' +
                                            '      <th>关键任务名称</th>\n' +
                                            '      <th>关注等级</th>\n' +
                                            '      <th>计划开始时间</th>\n' +
                                            '      <th>计划结束时间</th>\n' +
                                            '      <th>完成标准</th>\n' +
                                            '      <th>关键任务描述</th>\n' +
                                            '    </tr> \n' +
                                            '  </thead>\n' +
                                            '  <tbody>\n'
                                        res.obj.forEach(function (v,i) {
                                            tgId+=v.tgId+','
                                            tgName+=v.tgName+','
                                            str+= '<tr>\n' +
                                                '<td>'+isShowNull(v.tgName)+'</td>\n' +
                                                '<td>'+(dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '')+'</td>\n' +
                                                '<td>'+isShowNull(v.planStartDate)+'</td>\n' +
                                                '<td>'+isShowNull(v.planEndDate)+'</td>\n' +
                                                '<td>'+isShowNull(v.resultStandard)+'</td>\n' +
                                                '<td>'+function () {
                                                    if(v.tgDesc){
                                                        return v.tgDesc
                                                    }else{
                                                        return  ''
                                                    }
                                                }()+'</td>\n' +
                                                '</tr>\n'
                                        })
                                        str+='</tbody></table>'
                                        $('form input[name="tgId"]').val(tgName)
                                        $('form input[name="tgId"]').attr('tgId',tgId)
                                        $('form #targetDetail').remove()
                                        $('#relationShow').after(str)
                                        //关联关键任务时间
                                        $('#form .appendStartTime #planStartDate').remove()
                                        $('#form .appendEndTime #planEndDate').remove()
                                        $('#form .appendStartTime').append('<input type="text" class="layui-input jinyong testNull" autocomplete="off" name="planStartDate" id="planStartDate" title="计划开始时间">')
                                        $('#form .appendEndTime').append('<input type="text" class="layui-input jinyong testNull" autocomplete="off" name="planEndDate" id="planEndDate" title="计划结束时间">')
                                        var min=res.obj[0].planStartDate
                                        var max=res.obj[0].planEndDate
                                        // 初始化计划开始时间
                                        var planStartLaydateConfig = {
                                            elem: '#planStartDate',
                                            min: min,
                                            max: max,
                                            done: function (value, date) {
                                                if ($('#planEndDate').val()) {
                                                    var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
                                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                                }
                                                if (planEndLaydate.config.min) {
                                                    // 修改开始时间最大选择日期
                                                    planEndLaydate.config.min = {
                                                        year: date.year || 1900,
                                                        month: date.month - 1 || 0,
                                                        date: date.date || 1,
                                                    }
                                                } else {
                                                    planEndLaydateConfig.min = value;
                                                }
                                            }
                                            ,trigger: 'click' //采用click弹出
                                        }
                                        if (data && data.planEndDate) {
                                            planStartLaydateConfig.max = data.planEndDate;
                                        }
                                        var planStartLaydate = laydate.render(planStartLaydateConfig);

                                        // 初始化计划结束时间
                                        var planEndLaydateConfig = {
                                            elem: '#planEndDate',
                                            min: min,
                                            max: max,
                                            done: function (value, date) {
                                                if ($('#planStartDate').val()) {
                                                    var planPeriod = !!value ? timeRange($('#planStartDate').val(), value) + '天' : '';
                                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                                }
                                                if (planStartLaydate.config.max) {
                                                    // 修改开始时间最大选择日期
                                                    planStartLaydate.config.max = {
                                                        year: date.year || 2099,
                                                        month: date.month - 1 || 11,
                                                        date: date.date || 31,
                                                    }
                                                } else {
                                                    planStartLaydateConfig.max = value;
                                                }
                                            }
                                            ,trigger: 'click' //采用click弹出
                                        }
                                        if (data && data.planStartDate) {
                                            planEndLaydateConfig.min = data.planStartDate;
                                        }
                                        var planEndLaydate = laydate.render(planEndLaydateConfig);
                                        layer.close(index)
                                    }
                                })
                            }
                        })
                    })
                    $('.relationDel').on("click",function () {
                        $('form input[name="tgId"]').val('')
                        $('form input[name="tgId"]').attr('tgId','')
                        $('#targetDetail').remove()
                    })
                    //设置
                    $('.settings').on("click",function () {
                        layer.open({
                            type: 1,
                            title: '前置子任务',
                            area: ['80%', '70%'],
                            btn: ['确定', '取消'],
                            content:'<div style="margin-top: 15px" class="layui-form" id="taskSet">' +
                                '<div class="layui-row" style="text-align: right;margin-right: 2%">' +
                                '<div class="layui-col-xs4">' +
                                '<div class="layui-form-item">\n' +
                                '<label class="layui-form-label">年度:</label>\n' +
                                '<div class="layui-input-block">\n' +
                                '<select name="year" lay-filter="yearSet">\n' +
                                '<option value="">请选择</option>\n' +
                                '</select>\n' +
                                '</div>\n' +
                                '</div>'+
                                '</div>'+
                                '<div class="layui-col-xs4">' +
                                '<div class="layui-form-item">\n' +
                                '<label class="layui-form-label">月度:</label>\n' +
                                '<div class="layui-input-block">\n' +
                                '<select name="month">\n' +
                                '</select>\n' +
                                '</div>\n' +
                                '</div>'+
                                '</div>'+
                                '<div class="layui-col-xs4">' +
                                '<div class="layui-form-item">\n' +
                                '<label class="layui-form-label">责任部门:</label>\n' +
                                '<div class="layui-input-block">\n' +
                                '<input type="text" name="mainCenterDept" readonly id="mainCenterDeptSet" autocomplete="off" class="layui-input"  readonly style="background:#e7e7e7;display: inline-block;width: 65%">' +
                                '<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_taskSet_dept">添加</span>' +
                                '<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_taskSet_dept">清空</span>' +
                                '</div>\n' +
                                '</div>'+
                                '</div>'+
                                '<button type="button" class="layui-btn layui-btn-sm addPreTask">增加</button></div>'+
                                '<table class="layui-table preTaskTable" style="width: 98%;margin: 8px">\n' +
                                '  <thead>\n' +
                                '    <tr>\n' +
                                '      <th>子任务名称</th>\n' +
                                '      <th>类型</th>\n' +
                                '      <th>延隔时间(天)</th>\n' +
                                '    </tr> \n' +
                                '  </thead>\n' +
                                '  <tbody>\n' +
                                '  </tbody>\n' +
                                '</table>'+
                                '</div>',
                            success:function () {
                                //默认责任部门为当前左侧所选部门
                                $('#mainCenterDeptSet').val($('#leftId').attr('contractorName'))
                                $('#mainCenterDeptSet').attr('deptid',$('#leftId').attr('deptId'))
                                $('.add_taskSet_dept').on('click', function(){
                                    dept_id = 'mainCenterDeptSet';
                                    $.popWindow("/common/selectDept?0");
                                });
                                $('.clear_taskSet_dept').on('click', function(){
                                    $('#mainCenterDeptSet').val('');
                                    $('#mainCenterDeptSet').attr('deptId', '');
                                });
                                /***************************************************计划期间年度、月度*******************************************************/
                                    // 计划期间年度列表
                                var allYear = '';
                                // 获取计划期间年度列表
                                $.get('/planPeroidSetting/selectAllYear', function(res) {
                                    if (res.object.length > 0) {
                                        res.object.forEach(function(item){
                                            allYear += '<option value="'+item.periodYear+'">'+item.periodYear+'</option>'
                                        });
                                    }
                                    $('#taskSet [name="year"]').append(allYear);
                                    form.render('select');
                                    //新建时默认年度为当年、月度为当月
                                    $('#taskSet select[name="year"] option').each(function () {
                                        var nowYear=new Date().getFullYear()
                                        if($(this).text()==nowYear){
                                            $('#taskSet select[name="year"]').val($(this).val())
                                            form.render()
                                            getPlanMonth($(this).val(), function (monthSrt) {
                                                $('#taskSet select[name="month"]').html(monthSrt);
                                                form.render('select');
                                                //判断是否存在当月
                                                var nextMonth=new Date().getMonth()+1
                                                $('#taskSet select[name="month"] option').each(function () {
                                                    if(parseInt($(this).text())==nextMonth){
                                                        $('#taskSet select[name="month"]').val($(this).val())
                                                        form.render()
                                                    }
                                                })
                                            });
                                        }
                                    })
                                });

                                // 获取月度
                                form.on('select(yearSet)', function (data) {
                                    if (data.value) {
                                        getPlanMonth(data.value, function (monthStr) {
                                            $('#taskSet [name="month"]').html(monthStr);
                                            form.render('select');
                                        });
                                    } else {
                                        $('#taskSet [name="month"]').html('<option value="">请选择</option>');
                                        form.render('select');
                                    }
                                });


                                if($('form input[name="preTaskId"]').attr('preTaskId')){
                                    $.get('/plcProjectItem/selectQZById',{preTaskIds:$('form input[name="preTaskId"]').attr('preTaskId')},function (res) {
                                        if(res.flag){
                                            var data=res.obj
                                            data.forEach(function (item,index) {
                                                var str=''
                                                str+=   '    <tr class="trTask">\n' +
                                                    '      <td>' +
                                                    '  <select name="workItemName" lay-verify="required">\n' +
                                                    function () {
                                                        var name=allTask()
                                                        return name
                                                    }()+
                                                    '      </select>'+
                                                    '</td>\n' +
                                                    '      <td>' +
                                                    '  <select name="pretaskItemType" lay-verify="required">\n' +
                                                    '        <option value=""></option>\n' +
                                                    '        <option value="FS">完成-开始(FS)</option>\n' +
                                                    '        <option value="SS">开始-开始(SS)</option>\n' +
                                                    '        <option value="FF">完成-完成(FF)</option>\n' +
                                                    '        <option value="SF">开始-完成(SF)</option>\n' +
                                                    '      </select>'+
                                                    '</td>\n' +
                                                    '      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')"  name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
                                                    '    </tr>\n'
                                                $('.preTaskTable tbody').append(str)
                                                $('.trTask').eq(index).find('select[name="workItemName"]').val(item.planItemId)
                                                $('.trTask').eq(index).find('select[name="pretaskItemType"]').val(item.pretaskItemType)
                                                $('.trTask').eq(index).find('input[name="extendDates"]').val(item.extendDates)
                                                form.render()
                                            })
                                        }
                                    })
                                }
                                $('.addPreTask').on("click",function () {
                                    var str=   '    <tr class="trTask">\n' +
                                        '      <td>' +
                                        '  <select name="workItemName" lay-verify="required">\n' +
                                        function () {
                                            var year=$('#taskSet select[name="year"]').val() || ''
                                            var month=$('#taskSet select[name="month"]').val() || ''
                                            if($('#mainCenterDeptSet').attr('deptId')){
                                                var mainCenterDept=$('#mainCenterDeptSet').attr('deptId').replace(/,$/, '')
                                            }else{
                                                var mainCenterDept=''
                                            }

                                            var name=allTask(year,month,mainCenterDept)
                                            return name
                                        }()+
                                        '      </select>'+
                                        '</td>\n' +
                                        '      <td>' +
                                        '  <select name="pretaskItemType" lay-verify="required">\n' +
                                        '        <option value=""></option>\n' +
                                        '        <option value="FS">完成-开始(FS)</option>\n' +
                                        '        <option value="SS">开始-开始(SS)</option>\n' +
                                        '        <option value="FF">完成-完成(FF)</option>\n' +
                                        '        <option value="SF">开始-完成(SF)</option>\n' +
                                        '      </select>'+
                                        '</td>\n' +
                                        '      <td><input type="text" oninput = "value=value.replace(/[^\\d]/g,\'\')" value="0" name="extendDates" autocomplete="off" class="layui-input"></td>\n' +
                                        '    </tr>\n'
                                    $('.preTaskTable tbody').append(str)
                                    form.render()
                                })
                            },
                            yes:function (index) {
                                var arr=[]
                                var str=''
                                $('.trTask').each(function () {
                                    if($(this).find('select[name="workItemName"]').val() && $(this).find('select[name="pretaskItemType"]').val() && $(this).find('input[name="extendDates"]').val()){
                                        var obj={}
                                        obj.planItemId=$(this).find('select[name="workItemName"]').val()
                                        obj.workItemName=$(this).find('select[name="workItemName"] option:selected').text()
                                        obj.pretaskItemType=$(this).find('select[name="pretaskItemType"]').val()
                                        obj.extendDates=$(this).find('input[name="extendDates"]').val()
                                        arr.push(obj)
                                        str+=obj.workItemName+','
                                    }
                                })
                                $.ajax({
                                    url:'/plcProjectItem/insertPretask',
                                    data:JSON.stringify(arr),
                                    contentType:"application/json;charset=UTF-8",
                                    dataType:'json',
                                    type:'post',
                                    success:function(res){
                                        if(res.flag){
                                            $('form input[name="preTaskId"]').attr('preTaskId',res.data)
                                            $('form input[name="preTaskId"]').val(str)
                                            layer.close(index)
                                        }
                                    }
                                })
                            }
                        })
                    })
                    //成果标准模板
                    $('.resultDictAdd').on("click",function () {
                        layer.open({
                            type: 1,
                            title: '添加成果标准模板',
                            area: ['30%', '70%'],
                            btn: ['确定', '取消'],
                            content:'<div  class="layui-form result"  style="margin-top: 15px"></div>',
                            success:function () {
                                var data=CGCL_TYPE
                                var str=''
                                for(var i=0;i<data.length;i++){
                                    str+='<div class="layui-input-block" style="margin-left: 10%"><input type="checkbox" name="'+data[i].dictName+'" title="'+data[i].dictName+'" value="'+data[i].dictNo+'" lay-skin="primary"> </div>'
                                }
                                $('.result').html(str)
                                form.render()
                                var resultDict=$('form input[name="resultDict"]').attr('resultDict')
                                if(resultDict){
                                    var resultDictArr=resultDict.replace(/,$/, '').split(',')
                                }
                                if(resultDictArr){
                                    $('.result input').each(function (index) {
                                        resultDictArr.forEach(function (v,i) {
                                            if($('.result input').eq(index).val()==v){
                                                $('.result input').eq(index).prop('checked','true')
                                                form.render()
                                            }
                                        })
                                    })
                                }
                            },
                            yes:function (index) {
                                var resultDict=''
                                var resultDictName=''
                                $('.result input').each(function () {
                                    if($(this).prop('checked')){
                                        resultDict+=$(this).val()+','
                                        resultDictName+=$(this).attr('title')+','
                                    }
                                })
                                $('form input[name="resultDict"]').val(resultDictName)
                                $('form input[name="resultDict"]').attr('resultDict',resultDict)
                                layer.close(index);
                            }
                        })
                    })
                    $('.resultDictDel').on("click",function () {
                        $('form input[name="resultDict"]').val('')
                        $('form input[name="resultDict"]').attr('resultDict','')
                    })
                    if(data){
                        var parentId=data.parentPlanItemId || 0
                    }else{
                        var parentId=parentPlanItemId
                    }
                    var time_data=''
                    $.ajax({
                        url:'/plcProjectItem/itemNameByParentId',
                        dataType:'json',
                        type:'get',
                        async:false,
                        data:{parentId:parentId},
                        success:function(res){
                            //判断是否已经是一级子任务
                            if(res.object.taskName){
                                time_data=res.object
                                $('input[name="topItem"]').val(res.object.taskName)
                            }else{
                                $('input[name="topItem"]').val(res.object)
                            }
                        }
                    })
                    // $('select[name="planStage"]').html(dictionaryObj['PLAN_PHASE']['str'])
                    // $('select[name="resultDict"]').html(dictionaryObj['CGCL_TYPE']['str'])
                    // $('select[name="itemQuantityNuit"]').html(dictionaryObj['UNIT']['str'])
                    form.render()
                    //编辑回显
                    if (type == 1) {
                        $('.refresh').hide()
                        $('input[name="taskNo"]').css('width','100%')
                        // console.log(data)
                        form.val("formTest", data);
                        //关联关键任务
                        if(data.tgIds && data.tgIds.length>0){
                            $('#relationShow').show()
                            var tgIds=data.tgIds
                            var tgId=''
                            var tgName=''
                            tgIds.forEach(function (item) {
                                tgId+=item.tgId+','
                                tgName+=item.tgName+','
                            })
                            $('form input[name="tgId"]').val(tgName)
                            $('form input[name="tgId"]').attr('tgId',tgId)
                            $.ajax({
                                url: '/projectTarget/selectByIds',
                                type: 'post',
                                data:{ids:tgId},
                                dataType: 'json',
                                async: false,
                                success:function (res) {
                                    if(res.flag){
                                        var str='<table class="layui-table" id="targetDetail" style="width: 99%;margin-left: 20px;">\n' +
                                            '  <thead>\n' +
                                            '    <tr>\n' +
                                            '      <th>关键任务名称</th>\n' +
                                            '      <th>关注等级</th>\n' +
                                            '      <th>计划开始时间</th>\n' +
                                            '      <th>计划结束时间</th>\n' +
                                            '      <th>完成标准</th>\n' +
                                            '      <th>关键任务描述</th>\n' +
                                            '    </tr> \n' +
                                            '  </thead>\n' +
                                            '  <tbody>\n'
                                        res.obj.forEach(function (v,i) {
                                            str+= '<tr>\n' +
                                                '<td>'+v.tgName+'</td>\n' +
                                                '<td>'+(dictionaryObj['CONTROL_LEVEL']['object'][v.controlLevel] || '')+'</td>\n' +
                                                '<td>'+format(v.planStartDate)+'</td>\n' +
                                                '<td>'+format(v.planEndDate)+'</td>\n' +
                                                '<td>'+isShowNull(v.resultStandard)+'</td>\n' +
                                                '<td>'+function () {
                                                    if(v.tgDesc){
                                                        return v.tgDesc
                                                    }else{
                                                        return  ''
                                                    }
                                                }()+'</td>\n' +
                                                '</tr>\n'
                                        })
                                        str+='</tbody></table>'
                                        $('#relationShow').after(str)
                                    }
                                }
                            })
                        }else{
                            $('#relationShow').hide()
                        }
                        //前置子任务
                        if(data.preTask){
                            $.get('/plcProjectItem/selectQZById',{preTaskIds:data.preTask},function (res) {
                                if(res.flag){
                                    var dataPre=res.obj
                                    var preTaskName=''
                                    dataPre.forEach(function (item,index) {
                                        preTaskName+=item.workItemName+','
                                    })
                                    $('form input[name="preTaskId"]').val(preTaskName)
                                    $('form input[name="preTaskId"]').attr('preTaskId',data.preTask)
                                }
                            })
                        }
                        //成果标准模板
                        if(data.resultDictList){
                            var resultDictList=data.resultDictList
                            var resultDict=''
                            var resultDictName=''
                            resultDictList.forEach(function (item) {
                                resultDict+=item.dictNo+','
                                resultDictName+=item.dictName+','
                            })
                            $('form input[name="resultDict"]').val(resultDictName)
                            $('form input[name="resultDict"]').attr('resultDict',resultDict)
                        }
                        //主要负责人
                        $('#dutyUser').val(data.dutyUserName)
                        $('#dutyUser').attr('user_id', data.dutyUser)
                        $('#mainCenterDept').val(data.mainCenterDeptName)
                        $('#mainCenterDept').attr('deptid', data.mainCenterDept)
                        $('#assistCompanyDepts').val(data.assistCompanyDeptsName)
                        $('#assistCompanyDepts').attr('deptid', data.assistCompanyDepts)

                        $('#tgType_add').val(dictionaryObj['TG_TYPE']['object'][data.planType])
                        $('#tgType_add').attr('dictNo', data.planType)
                        /*  data.openNextTask == 1 ? $('[name="openNextTask"]').prop('checked', true) : $('[name="openNextTask"]').prop('checked', false)
                          data.isExam == 1 ? $('[name="isExam"]').prop('checked', true) : $('[name="isExam"]').prop('checked', false)*/
                        form.render()
                        //附件回显
                        var strs1 = '';
                        if(data.attachments4 && data.attachments4.length>0){
                            for (var i = 0; i < data.attachments4.length; i++) {
                                strs1 += '<div class="dech" deUrl="'+encodeURI(data.attachments4[i].attUrl)+'"><a href="/download?'+encodeURI(data.attachments4[i].attUrl)+'" NAME="' + data.attachments4[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + data.attachments4[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data.attachments4[i].aid + '@' + data.attachments4[i].ym + '_' + data.attachments4[i].attachId + ',"></div>';
                            }
                        }
                        $('#fileContent').append(strs1);
                    }
                    //根据是否关联关键任务来控制时间----关联关键任务的话，子任务时间受关键任务时间约束，反之则正常填写时间
                    if($('#targetDetail').length>0){
                        var min=$('#targetDetail td').eq(2).text()
                        var max=$('#targetDetail td').eq(3).text()
                        // 初始化计划开始时间
                        var planStartLaydateConfig = {
                            elem: '#planStartDate',
                            min: min,
                            max: max,
                            done: function (value, date) {
                                if ($('#planEndDate').val()) {
                                    var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                }
                                if (planEndLaydate.config.min) {
                                    // 修改开始时间最大选择日期
                                    planEndLaydate.config.min = {
                                        year: date.year || 1900,
                                        month: date.month - 1 || 0,
                                        date: date.date || 1,
                                    }
                                } else {
                                    planEndLaydateConfig.min = value;
                                }
                            }
                            ,trigger: 'click' //采用click弹出
                        }
                        if (data && data.planEndDate) {
                            planStartLaydateConfig.max = data.planEndDate;
                        }
                        var planStartLaydate = laydate.render(planStartLaydateConfig);

                        // 初始化计划结束时间
                        var planEndLaydateConfig = {
                            elem: '#planEndDate',
                            min: min,
                            max: max,
                            done: function (value, date) {
                                if ($('#planStartDate').val()) {
                                    var planPeriod = !!value ? timeRange($('#planStartDate').val(), value) + '天' : '';
                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                }
                                if (planStartLaydate.config.max) {
                                    // 修改开始时间最大选择日期
                                    planStartLaydate.config.max = {
                                        year: date.year || 2099,
                                        month: date.month - 1 || 11,
                                        date: date.date || 31,
                                    }
                                } else {
                                    planStartLaydateConfig.max = value;
                                }
                            }
                            ,trigger: 'click' //采用click弹出
                        }
                        if (data && data.planStartDate) {
                            planEndLaydateConfig.min = data.planStartDate;
                        }
                        var planEndLaydate = laydate.render(planEndLaydateConfig);
                    }else{
                        // 初始化计划开始时间
                        var planStartLaydateConfig = {
                            elem: '#planStartDate',
                            done: function (value, date) {
                                if ($('#planEndDate').val()) {
                                    var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                }
                                if (planEndLaydate.config.min) {
                                    // 修改开始时间最大选择日期
                                    planEndLaydate.config.min = {
                                        year: date.year || 1900,
                                        month: date.month - 1 || 0,
                                        date: date.date || 1,
                                    }
                                } else {
                                    planEndLaydateConfig.min = value;
                                }
                            }
                            ,trigger: 'click' //采用click弹出
                        }
                        if (data && data.planEndDate) {
                            planStartLaydateConfig.max = data.planEndDate;
                        }
                        var planStartLaydate = laydate.render(planStartLaydateConfig);

                        // 初始化计划结束时间
                        var planEndLaydateConfig = {
                            elem: '#planEndDate',
                            done: function (value, date) {
                                if ($('#planStartDate').val()) {
                                    var planPeriod = !!value ? timeRange($('#planStartDate').val(), value) + '天' : '';
                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                }
                                if (planStartLaydate.config.max) {
                                    // 修改开始时间最大选择日期
                                    planStartLaydate.config.max = {
                                        year: date.year || 2099,
                                        month: date.month - 1 || 11,
                                        date: date.date || 31,
                                    }
                                } else {
                                    planStartLaydateConfig.max = value;
                                }
                            }
                            ,trigger: 'click' //采用click弹出
                        }
                        if (data && data.planStartDate) {
                            planEndLaydateConfig.min = data.planStartDate;
                        }
                        var planEndLaydate = laydate.render(planEndLaydateConfig);
                    }

                    // 初始化协助计划开始时间
                    var assistStartDateConfig = {
                        elem: '#assistStartDate',
                        done: function (value, date) {
                            if (assistEndDateLaydate.config.min) {
                                // 修改开始时间最大选择日期
                                assistEndDateLaydate.config.min = {
                                    year: date.year || 1900,
                                    month: date.month - 1 || 0,
                                    date: date.date || 1,
                                }
                            } else {
                                assistEndDateConfig.min = value;
                            }
                        }
                        ,trigger: 'click' //采用click弹出
                    }
                    if (data && data.assistEndDate) {
                        assistStartDateConfig.max = data.assistEndDate;
                    }
                    var assistStartDateLaydate = laydate.render(assistStartDateConfig);

                    // 初始化协助计划结束时间
                    var assistEndDateConfig = {
                        elem: '#assistEndDate',
                        done: function (value, date) {
                            if (assistStartDateLaydate.config.max) {
                                // 修改开始时间最大选择日期
                                assistStartDateLaydate.config.max = {
                                    year: date.year || 2099,
                                    month: date.month - 1 || 11,
                                    date: date.date || 31,
                                }
                            } else {
                                assistStartDateConfig.max = value;
                            }
                        }
                        ,trigger: 'click' //采用click弹出
                    }
                    if (data && data.assistStartDate) {
                        assistEndDateConfig.min = data.assistStartDate;
                    }
                    var assistEndDateLaydate = laydate.render(assistEndDateConfig);


                    //以下代码暂不删除，备用（联动上下级任务时间控制）
                   /* if(time_data){
                        var min=time_data.planStartDate
                        var max=time_data.planEndDate
                        // 初始化计划开始时间
                        var planStartLaydateConfig = {
                            elem: '#planStartDate',
                            min: min,
                            max: max,
                            done: function (value, date) {
                                if ($('#planEndDate').val()) {
                                    var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                }
                                if (planEndLaydate.config.min) {
                                    // 修改开始时间最大选择日期
                                    planEndLaydate.config.min = {
                                        year: date.year || 1900,
                                        month: date.month - 1 || 0,
                                        date: date.date || 1,
                                    }
                                } else {
                                    planEndLaydateConfig.min = value;
                                }
                            }
                            ,trigger: 'click' //采用click弹出
                        }
                        if (data && data.planEndDate) {
                            planStartLaydateConfig.max = data.planEndDate;
                        }
                        var planStartLaydate = laydate.render(planStartLaydateConfig);

                        // 初始化计划结束时间
                        var planEndLaydateConfig = {
                            elem: '#planEndDate',
                            min: min,
                            max: max,
                            done: function (value, date) {
                                if ($('#planStartDate').val()) {
                                    var planPeriod = !!value ? timeRange($('#planStartDate').val(), value) + '天' : '';
                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                }
                                if (planStartLaydate.config.max) {
                                    // 修改开始时间最大选择日期
                                    planStartLaydate.config.max = {
                                        year: date.year || 2099,
                                        month: date.month - 1 || 11,
                                        date: date.date || 31,
                                    }
                                } else {
                                    planStartLaydateConfig.max = value;
                                }
                            }
                            ,trigger: 'click' //采用click弹出
                        }
                        if (data && data.planStartDate) {
                            planEndLaydateConfig.min = data.planStartDate;
                        }
                        var planEndLaydate = laydate.render(planEndLaydateConfig);
                    }else{
                        // 初始化计划开始时间
                        var planStartLaydateConfig = {
                            elem: '#planStartDate',
                            done: function (value, date) {
                                if ($('#planEndDate').val()) {
                                    var planPeriod = !!value ? timeRange(value, $('#planEndDate').val()) + '天' : '';
                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                }
                                if (planEndLaydate.config.min) {
                                    // 修改开始时间最大选择日期
                                    planEndLaydate.config.min = {
                                        year: date.year || 1900,
                                        month: date.month - 1 || 0,
                                        date: date.date || 1,
                                    }
                                } else {
                                    planEndLaydateConfig.min = value;
                                }
                            }
                            ,trigger: 'click' //采用click弹出
                        }
                        if (data && data.planEndDate) {
                            planStartLaydateConfig.max = data.planEndDate;
                        }
                        var planStartLaydate = laydate.render(planStartLaydateConfig);

                        // 初始化计划结束时间
                        var planEndLaydateConfig = {
                            elem: '#planEndDate',
                            done: function (value, date) {
                                if ($('#planStartDate').val()) {
                                    var planPeriod = !!value ? timeRange($('#planStartDate').val(), value) + '天' : '';
                                    $('input[name="planContinuedDate"]').val(planPeriod);
                                }
                                if (planStartLaydate.config.max) {
                                    // 修改开始时间最大选择日期
                                    planStartLaydate.config.max = {
                                        year: date.year || 2099,
                                        month: date.month - 1 || 11,
                                        date: date.date || 31,
                                    }
                                } else {
                                    planStartLaydateConfig.max = value;
                                }
                            }
                            ,trigger: 'click' //采用click弹出
                        }
                        if (data && data.planStartDate) {
                            planEndLaydateConfig.min = data.planStartDate;
                        }
                        var planEndLaydate = laydate.render(planEndLaydateConfig);
                    }*/

                },
                yes: function (index) {
                    //必填项提示
                    for(var i=0;i<$('.testNull').length;i++){
                        if($('.testNull').eq(i).val()==''){
                            layer.msg($('.testNull').eq(i).attr('title')+'为必填项！', {icon: 0});
                            return false
                        }
                    }
                    if($('.testRelationTarget').val()=='' && $('#relationShow').css('display')!= 'none'){
                        layer.msg('请选择关联关键任务！', {icon: 0});
                        return false
                    }
                    //判断任务来源，任务来源为【外部临时】时，编制依据附件为必填
                    if($('#form [name="taskType"] option:checked').text()=='外部临时' && $('.dech').length==0){
                        layer.msg('请上传编制依据附件！', {icon: 0});
                        return false
                    }

                    //判断协助部门不为空时，需填写协助开始时间和协助结束时间
                    if($('#assistCompanyDepts').attr('deptid') && !$('#assistStartDate').val()){
                        layer.msg('协助计划开始时间为必填项！', {icon: 0});
                        return false
                    }
                    if($('#assistCompanyDepts').attr('deptid') && !$('#assistEndDate').val()){
                        layer.msg('协助计划结束时间为必填项！', {icon: 0});
                        return false
                    }

                    var loadingIndex = layer.load(0);

                    var datas = $('#form').serializeArray()
                    // console.log(datas)
                    var obj = {}
                    datas.forEach(function (item, index) {
                        obj[item.name] = item.value
                    })
                    obj.dutyUser = $('#dutyUser').attr('user_id') || ''
                    if($('#mainCenterDept').attr('deptid')){
                        obj.mainCenterDept = $('#mainCenterDept').attr('deptid').replace(/,$/, '') || ''
                    }
                    obj.assistCompanyDepts = $('#assistCompanyDepts').attr('deptid')
                    /* obj.openNextTask = $('[name="openNextTask"]').prop('checked') ? 1 : 0
                     obj.isExam = $('[name="isExam"]').prop('checked') ? 1 : 0*/
                    obj.tgId=$('form input[name="tgId"]').attr('tgid') || ''
                    obj.preTask=$('form input[name="preTaskId"]').attr('pretaskid') || ''
                    obj.resultDict=$('form input[name="resultDict"]').attr('resultDict')

                    // console.log(obj)
                    obj.itemBelongDept = itemBelongDept
                    obj.parentPlanItemId = parentPlanItemId
                    obj.planItemId = planItemId
                    obj.planSycle = $('form select[name="planSycle"]').val()
                    //编制依据附件
                    var attachmentId4 = '';
                    var attachmentName4 = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId4 += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName4 += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId4=attachmentId4
                    obj.attachmentName4=attachmentName4

                    obj.planType = $('#form [name="planType"]').attr('dictNo') ? $('#form [name="planType"]').attr('dictNo').replace(/,$/,'') : ''

                    //判断计划形式
                    if($('#form [name="planRate"]').val()!='01'){
                        layer.close(loadingIndex);
                        layer.open({
                            type: 1,
                            title:'请填写重复次数',
                            btn:['确定','取消'],
                            area: ['420px', '240px'], //宽高
                            content: '<div class="layui-form-item" style="width: 90%;margin-top: 20px">\n' +
                                '    <label class="layui-form-label">重复次数<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                                '    <div class="layui-input-block">\n' +
                                '      <input type="number" name="time" autocomplete="off" class="layui-input" style="display: inline-block;width:92%">次\n' +
                                '    </div>\n' +
                                '  </div>',
                            yes:function (index) {
                                if(!$('input[name="time"]')){
                                    layer.msg('重复次数为必填项！', {icon: 0});
                                    return false
                                }
                                var time=$('input[name="time"]').val()
                                obj.time=time
                                if($('#form [name="planRate"]').val()=='02'){
                                    obj.type='02'
                                }else if($('#form [name="planRate"]').val()=='03'){
                                    obj.type='03'
                                }
                                else if($('#form [name="planRate"]').val()=='04'){
                                    obj.type='04'
                                }
                                else if($('#form [name="planRate"]').val()=='05'){
                                    obj.type='05'
                                }
                                $.ajax({
                                    url: url,
                                    data: obj,
                                    dataType: 'json',
                                    type: 'post',
                                    success: function (res) {
                                        if (type == 0) {
                                            if (res.flag && res.object==1) {
                                                layer.msg('编号重复，请点击刷新按钮重置编号！',{icon:0});
                                            }else if(res.flag){
                                                layer.msg('新增成功！', {icon: 1});
                                                layer.closeAll()
                                                insTb.reload()
                                            }
                                        } else if (type == 1) {
                                            if (res.flag) {
                                                layer.msg('修改成功！', {icon: 1});
                                                layer.close(index)
                                                insTb.reload()
                                            }
                                        }

                                    }
                                })
                            }
                        });
                    }else{
                        obj.time=1
                        obj.type='01'
                        $.ajax({
                            url: url,
                            data: obj,
                            dataType: 'json',
                            type: 'post',
                            success: function (res) {
                                layer.close(loadingIndex);
                                if (type == 0) {
                                    if (res.flag && res.object==1) {
                                        layer.msg('编号重复，请点击刷新按钮重置编号！',{icon:0});
                                    }else if(res.flag){
                                        layer.msg('新增成功！', {icon: 1});
                                        layer.closeAll()
                                        insTb.reload()
                                    }
                                } else if (type == 1) {
                                    if (res.flag) {
                                        layer.msg('修改成功！', {icon: 1});
                                        layer.close(index)
                                        insTb.reload()
                                    }
                                }

                            }
                        })
                    }
                },
                btn2:function (index) {
                    layer.closeAll()
                }
            })
        }

        /***
         * 模板导入
         * @param  projOrgId(左侧部门)
         */
        function initProjectPlan(projOrgId) {
            var projectItemTable = null;
            layer.open({
                type: 1,
                title: '模板导入',
                btn: ['保存', '退出'],
                area: ['60%', '85%'],
                maxmin: true,
                content: '<div style="position: relative;height: 100%; width: 100%;padding: 5px 10px;box-sizing: border-box;">' +
                    '<div class="target_module" style="position: relative;float: left;height: 100%; width: 230px;">' +
                    '<h3 style="padding: 10px 15px; text-align: center;">子任务模板</h3>' +
                    '<div class="eleTree target_module_tree" lay-filter="targetModuleTree"></div>' +
                    '</div>' +
                    '<div class="project_item">' +
                    '<h3 style="padding: 10px 15px; text-align: center;">子任务选择</h3>' +
                    '<div>' +
                    '<table id="projectItemTable" lay-filter="projectItemTable"></table>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                success: function () {
                    // 初始化左侧关键任务模板树
                    var targetModuleTree = eleTree.render({
                        elem: '.target_module_tree',
                        url: '/TaskTemplateType/findAllType',
                        highlightCurrent: true,
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
                    });

                    // 模板树节点点击
                    eleTree.on("nodeClick(targetModuleTree)", function (d) {
                        if (projectItemTable) {
                            projectItemTable.reload({
                                where: {
                                    ttaskTypeId: d.data.currentData.ttaskTypeId,
                                    useFlag:true,
                                    _:new Date().getTime()
                                },
                                page: {
                                    curr: 1
                                }
                            });
                        } else {
                            projectItemTable = table.render({
                                elem: '#projectItemTable',
                                url: '/TaskTemplateItem/findTemplateByTypeId',
                                page: true,
                                cols: [[
                                    {type: 'checkbox'},
                                    {field: 'taskName', align: 'left', title: '子任务名称'}
                                ]],
                                where: {
                                    ttaskTypeId: d.data.currentData.ttaskTypeId,
                                    useFlag:true,
                                    _:new Date().getTime()
                                },
                                parseData: function (res) {
                                    return {
                                        "code": 0, //解析接口状态
                                        "data": res.obj,//解析数据列表
                                        "count": res.totleNum, //解析数据长度
                                    };
                                },
                                request: {
                                    pageName: 'page' //页码的参数名称，默认：page
                                    ,limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                }
                            });
                        }
                    });
                },
                yes: function (index) {
                    if (projectItemTable) {
                        var checkStatus = table.checkStatus('projectItemTable');
                        if (checkStatus.data.length > 0) {
                            var loadingIndex = layer.load();
                            var obj = {}
                            var ttaskId=[]
                            checkStatus.data.forEach(function (v,i) {
                                ttaskId.push(v.ttaskId)
                            })
                            obj.ttaskId = ttaskId;
                            obj.projOrgId = projOrgId;
                            $.ajax({
                                url:'/plcProjectItem/insertImport',
                                dataType:'json',
                                type:'post',
                                data:obj,
                                traditional:true,
                                success:function(res){
                                    layer.close(loadingIndex);
                                    if (res.flag) {
                                        layer.close(index);
                                        layer.msg('初始化成功！', {icon: 1, time: 1000});
                                        insTb.reload();
                                    } else {
                                        layer.msg('初始化失败！', {icon: 2, time: 1000});
                                    }
                                }
                            })
                        } else {
                            layer.msg('请选择子任务', {icon: 0, time: 1000});
                        }
                    } else {
                        layer.msg('请选择子任务', {icon: 0, time: 1000});
                    }
                }
            });
        }
        //上报
        function shangbao(planItemIds){
            layer.open({
                type: 1,
                title: '提交',
                area: ['70%', '70%'],
                btn:['提交','取消'],
                content: '<form class="layui-form" id="formReport" lay-filter="formTestReport" style="margin-top:15px;margin-left: -40px">' +
                    //第一行
                    '<div class="layui-row">\n' +
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">计划编号<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="planNo" required  lay-verify="required" readonly style="background:#e7e7e7;"  autocomplete="off" class="layui-input testNull" title="计划编号" >\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">类型</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text"  required  lay-verify="required" value="子任务计划" readonly style="background:#e7e7e7;" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '</div>'+
                    //第二行
                    '<div class="layui-row">\n' +
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">周期类型<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <select name="planCycle" lay-verify="required"  class="testNull" title="周期类型" disabled>\n' +
                    '      </select>'+
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">年度<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <select name="planYear" lay-filter="planYear" class="testNull" title="年度">\n' +
                    '<option value="">请选择</option>'+
                    '      </select>'+
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '</div>'+
                    //第三行
                    '<div class="layui-row">\n' +
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">月度<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <select name="planMonth" lay-verify="required" class="testNull" title="月度">\n' +
                    '      </select>'+
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">子任务类型</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <select name="planType" lay-verify="required">\n' +
                    '      </select>'+
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '</div>'+
                    //第四行
                    '<div class="layui-row">\n' +
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">审批人<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                   /* '  <textarea  type="text" title="负责人" class="testNull" name="dutyUser" id="dutyUser" readonly  style="background:#e7e7e7;height: 45px;width: 70%;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="dutyUserAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="dutyUserDel">清空</a>\n'+*/
                    /*'<select name="dutyUser" lay-filter="dutyUser" class="testNull" title="负责人" lay-filter="dutyUser">' +
                    '<option value="">请选择</option>'+
                    '</select>' +*/
                    '<input type="text" name="dutyUser" readonly id="reportDutyUser" autocomplete="off" class="layui-input testNull" title="负责人" readonly style="background:#e7e7e7;display: inline-block;">' +
                  /*  '<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_report_user">添加</span>' +
                    '<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_report_user">清空</span>' +*/
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">所属单位<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    /*'  <textarea  type="text" title="所属单位" class="testNull" name="belongtoDept" id="belongtoDept" readonly  style="background:#e7e7e7;height: 45px;width: 70%;text-indent:1em;border-radius: 4px;"></textarea>\n' +
                    '<a href="javascript:;" style="color:#1E9FFF;margin-left:10px" class="belongtoDeptAdd">添加</a>\n' +
                    ' <a href="javascript:;" style="color:#1E9FFF;margin-left:5px" class="belongtoDeptDel">清空</a>\n'+*/
                    '<input type="text" name="belongtoUnit" readonly id="belongtoUnit" autocomplete="off" class="layui-input testNull" title="所属单位" readonly style="background:#e7e7e7;display: inline-block;">' +
                   /* '<span style="margin-left: 2px; color: red; cursor: pointer;" class="add_report_dept">添加</span>' +
                    '<span style="margin-left: 5px; color: blue; cursor: pointer;" class="clear_report_dept">清空</span>' +*/
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '</div>'+
                    //第五行
                    '<div class="layui-row">\n' +
                    '<div class="layui-col-xs6">\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">季度</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <select name="planQuarter" lay-verify="required">\n' +
                        '<option value="">请选择</option>'+
                        '<option value="1">1</option>'+
                        '<option value="2">2</option>'+
                        '<option value="3">3</option>'+
                        '<option value="4">4</option>'+
                    '      </select>'+
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '</div>'+
                    //第二行
                    '<div class="layui-row">\n' +
                    '<div>\n' +
                    '<div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">计划名称<span style="color:red;font-size: 25px;vertical-align: middle;">*</span></label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="planName" required  lay-verify="required"  autocomplete="off" class="layui-input testNull" title="计划名称" style="display: inline-block;width: 88%">\n' +
                    ' <button type="button" class="layui-btn layui-btn-sm autoPlanName" style="margin-left: 15px">生成名称</button>'+
                    '    </div>\n' +
                    '  </div>'+
                    '    </div>'+
                    '</div>'+

                    '<div class="layui-row">' +
                    '<div>'+
                    ' <div class="layui-form-item"  style="margin-top:15px">\n' +
                    '    <label class="layui-form-label" style="padding:2px 18px;">线下审批结果:</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    ' <div id="fileContent">\n' +
                    '</div>\n' +
                    '<a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                    '<img src="../img/mg11.png" alt="">\n' +
                    '<span><fmt:message code="email.th.addfile"/></span>\n' +
                    '<input type="file" multiple id="fileupload" data-url="/upload?module=plancheck" name="file">\n' +
                    '</a>\n' +
                    '<div class="progress" style="width: 200px;float: left;margin-left: 10px;margin-top: 2px;">\n' +
                    '<div class="bar" style="width: 0%;"></div>\n' +
                    '</div>\n' +
                    '<div class="barText" style="float: left;margin-left: 10px;"></div>'+
                    '</div>\n' +
                    '</div>' +
                    '</div>' +
                    '</div>' +


                    '</form>',
                success:function () {
                    fileuploadFn('#fileupload', $('#fileContent'));
                        /*自动生成计划名称*/
                    $('.autoPlanName').on("click",function () {
                        var belongtoUnitName=$('#belongtoUnit').val()
                        var planYearName=$('#formReport select[name="planYear"]').val()
                        var planMonthName=$('#formReport select[name="planMonth"]').val()
                        var planTypeName=$('#formReport select[name="planType"] option:selected').text()
                        $('#formReport input[name="planName"]').val(belongtoUnitName+'-'+planYearName+'年'+planMonthName+'月'+planTypeName+'计划')
                    })
                    //默认审批人为组织机构的组织负责人及所属部门
                    $.get('/plcOrg/queryIdByItem', {projOrgId:$('#leftId').attr('projOrgId')}, function (res) {
                        if(res.object){
                            $('#reportDutyUser').val(res.object.principalUserName || '')
                            $('#reportDutyUser').attr('user_id',res.object.principalUser || '')
                            $('#belongtoUnit').val(res.object.deptName || '')
                            $('#belongtoUnit').attr('deptid',res.object.deptId || '')
                        }
                    })
                    $('#formReport select[name="planCycle"]').html(dictionaryObj['PLAN_SYCLE']['str'])
                    $('#formReport select[name="planType"]').html(dictionaryObj['RENWUJIHUA_TYPE']['str'])
                    $('#formReport select[name="planYear"]').append(allYear);
                    form.render()

                    // 监听年度下拉框选择
                    form.on('select(planYear)', function (data) {
                        getPlanMonth(data.value, function (monthSrt) {
                            $('#formReport select[name="planMonth"]').html(monthSrt);
                            form.render('select');
                        });
                    });
                    $.get('/ProjectInfo/getMaxNo',{model:'plcPlan',planClass:3},function (res) {
                        $('input[name="planNo"]').val(res)
                    })
                    //显示负责人和所属单位
                   /* $.get('/user/userCookie',function (res) {
                        if(res.flag){
                            $('input[name=dutyUser]').val(res.object.userName)
                            $('input[name=dutyUser]').attr('userId',res.object.userId)
                            $('input[name=belongtoUnit]').val(res.object.deptName)
                            $('input[name=belongtoUnit]').attr('deptId',res.object.deptId)
                        }
                    })*/
                    //新建时默认周期类型为月度
                    $('#formReport select[name="planCycle"] option').each(function () {
                        if($(this).text()=='月度'){
                            $('#formReport select[name="planCycle"]').val($(this).val())
                            form.render()
                        }
                    })
                    /*暂时去除20200819*/
                    /*//新建时默认子任务类型为日常工作
                    $('#formReport select[name="planType"] option').each(function () {
                        if($(this).text()=='日常工作'){
                            $('#formReport select[name="planType"]').val($(this).val())
                            form.render()
                        }
                    })*/
                    //新建时默认年度为当年
                    $('#formReport select[name="planYear"] option').each(function () {
                        var nowYear=new Date().getFullYear()
                        if($(this).text()==nowYear){
                            $('#formReport select[name="planYear"]').val($(this).val())
                            form.render()
                            getPlanMonth($(this).val(), function (monthSrt) {
                                $('#formReport select[name="planMonth"]').html(monthSrt);
                                form.render('select');
                                //判断是否存在下月
                                var nextMonth=new Date().getMonth()+2
                                $('#formReport select[name="planMonth"] option').each(function () {
                                    if(parseInt($(this).text())==nextMonth){
                                        $('#formReport select[name="planMonth"]').val($(this).val())
                                        form.render()
                                    }
                                })
                            });
                        }
                    })
                    $('.add_report_user').on('click', function(){
                        user_id = 'reportDutyUser';
                        $.popWindow("/common/selectUser?0");
                    });
                    $('.clear_report_user').on('click', function(){
                        $('#reportDutyUser').val('');
                        $('#reportDutyUser').attr('user_id', '');
                        $('#belongtoUnit').val('');
                        $('#belongtoUnit').attr('deptId', '');
                    });
                    $('.add_report_dept').on('click', function(){
                        dept_id = 'belongtoUnit';
                        $.popWindow("/common/selectDept?0");
                    });
                    $('.clear_report_dept').on('click', function(){
                        $('#belongtoUnit').val('');
                        $('#belongtoUnit').attr('deptId', '');
                    });
                   /* var deptObject = {};
                    $.get('/plcOrg/ConditionsQuery?useFlag=0', function(res) {
                        var str = '';
                        if (res.flag && res.obj.length > 0) {
                            res.obj.forEach(function(item){
                                str += '<option value="'+item.principalUser.replace(/,$/, '')+'">'+item.principalUserName.replace(/,$/, '')+'</option>';
                                deptObject[item.principalUser.replace(/,$/, '')] = {deptId: item.deptId, deptName: item.deptName}
                            });
                        }
                        $('#formReport select[name="dutyUser"]').append(str);
                        form.render('select');
                        var val = $('#formReport select[name="dutyUser"]').val();
                        if(val){
                            var deptName = deptObject[val]['deptName'];
                            var deptId = deptObject[val]['deptId'];
                            $('#formReport [name="belongtoDept"]').val(deptName).attr('deptId', deptId);
                        }
                    });
                    // 监听负责人下拉框选择
                    form.on('select(dutyUser)', function (data) {
                        var deptName = deptObject[data.value]['deptName'];
                        var deptId = deptObject[data.value]['deptId'];
                        $('#formReport [name="belongtoDept"]').val(deptName).attr('deptId', deptId);
                    });*/
                   /* //负责人的添加
                    $(".dutyUserAdd").on("click",function(){
                        user_id = 'dutyUser';
                        $.popWindow("/common/selectUser?0");
                    });
                    //负责人的删除
                    $('.dutyUserDel').on("click",function () {
                        $('#dutyUser').attr("user_id","");
                        $('#dutyUser').val("");
                    });
                    //所属单位的添加
                    $(".belongtoDeptAdd").on("click",function(){
                        dept_id = 'belongtoDept';
                        $.popWindow("/common/selectDept?0");
                    });
                    //所属单位的删除
                    $('.belongtoDeptDel').on("click",function () {
                        $('#belongtoDept').attr("deptid","");
                        $('#belongtoDept').val("");
                    });*/
                },
                yes:function (index) {
                    //必填项提示
                    for(var i=0;i<$('.testNull').length;i++){
                        if(!$('.testNull').eq(i).val().trim()){
                            layer.msg($('.testNull').eq(i).attr('title')+'为必填项！', {icon: 0});
                            return false
                        }
                    }
                    var datas=$('#formReport').serializeArray()
                    // console.log(data)
                    var obj={}
                    datas.forEach(function (item,index) {
                        obj[item.name]=item.value
                    })
                    obj.planClass=3
                    obj.dutyUser=$('#formReport [name="dutyUser"]').attr('user_id');
                    obj.belongtoUnit= parseInt($('#formReport [name="belongtoUnit"]').attr('deptId').replace(/,$/, '') || '');
                    obj.belongtoDept=$('#leftId').attr('projOrgId')
                    obj.planItemIds=planItemIds
                    obj.planCycle = $('#formReport select[name="planCycle"]').val()
                    //线下审批结果
                    var attachmentId1 = '';
                    var attachmentName1 = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId1 += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName1 += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId1=attachmentId1
                    obj.attachmentName1=attachmentName1
                    // console.log(obj)
                    $.ajax({
                        url:'/plcPlan/addPlcPlan',
                        data:obj,
                        dataType:'json',
                        type:'post',
                        success:function(res){
                            if(res.flag){
                                if(res.msg.indexOf('没有符合的任务')!=-1){
                                    layer.msg(res.msg, {icon: 0});
                                }else{
                                    layer.msg('提交成功！', {icon: 1});
                                    layer.close(index);
                                    insTb.reload()
                                }
                            }

                        }
                    })
                },
                btn2:function (index) {
                    //必填项提示
                    for(var i=0;i<$('.testNull').length;i++){
                        if(!$('.testNull').eq(i).val().trim()){
                            layer.msg($('.testNull').eq(i).attr('title')+'为必填项！', {icon: 0});
                            return false
                        }
                    }
                    var datas=$('#formReport').serializeArray()
                    // console.log(data)
                    var obj={}
                    datas.forEach(function (item,index) {
                        obj[item.name]=item.value
                    })
                    obj.planClass=3
                    obj.dutyUser=$('#formReport [name="dutyUser"]').attr('user_id');
                    obj.belongtoUnit=parseInt($('#formReport [name="belongtoUnit"]').attr('deptId').replace(/,$/, '') || '');
                    obj.belongtoDept=$('#leftId').attr('projOrgId')
                    obj.planItemIds=planItemIds
                    obj.apprivalStatus=1
                    obj.planCycle = $('#formReport select[name="planCycle"]').val()
                    //线下审批结果
                    var attachmentId1 = '';
                    var attachmentName1 = '';
                    for (var i = 0; i < $('#fileContent .dech').length; i++) {
                        attachmentId1 += $('#fileContent .dech').eq(i).find('input').val();
                        attachmentName1 += $('#fileContent a').eq(i).attr('name');
                    }
                    obj.attachmentId1=attachmentId1
                    obj.attachmentName1=attachmentName1

                    var year = new Date().getFullYear();
                    var month = new Date().getMonth()+1;
                    var day = new Date().getDate();
                    if (month < 10) {
                        month = "0" + month;
                    }
                    if (day < 10) {
                        day = "0" + day;
                    }
                    var today = year+"-" + month + "-" + day;
                    obj.reportDate=today
                    // console.log(obj)
                    var isClose=''
                    $.ajax({
                        url:'/plcPlan/addPlcPlan',
                        data:obj,
                        dataType:'json',
                        type:'post',
                        async:false,
                        success:function(res){
                            if(res.flag){
                                if(res.msg.indexOf('没有符合的子任务')!=-1){
                                    isClose=true
                                    layer.msg(res.msg, {icon: 0});
                                }else{
                                    layer.msg('提交成功！', {icon: 1});
                                    layer.close(index);
                                    insTb.reload()
                                }
                            }

                        }
                    })
                    if(isClose){
                        return  false
                    }
                }
            })
        }


        //子任务详情
        $(document).on('click','.taskDetail',function () {
            var parentId=$(this).attr('parentPlanItemId') || 0
            $.get('/plcProjectItem/selectById',{planItemId:$(this).attr('planItemId')},function (res) {
                var data=res.data
                layer.open({
                    type: 1,
                    title: '子任务详情',
                    area: ['70%', '80%'],
                    maxmin: true,
                    min: function () {
                        $('.layui-layer-shade').hide()
                    },
                    content: '<div style="margin: 10px"><table class="layui-table child" style="margin: 10px 5px;width: 99%">\n' +
                        '  <colgroup>\n' +
                        '    <col width="150">\n' +
                        '    <col >\n' +
                        '    <col width="150">\n' +
                        '    <col >\n' +
                        '  </colgroup>'+
                        '  <tbody>\n' +
                        '    <tr>\n' +
                        '      <td>编号</td>\n' +
                        '      <td>'+isShowNull(data.taskNo)+'</td>\n' +
                        '      <td>上级子任务名称</td>\n' +
                        '      <td class="topItemDetail"></td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>子任务名称</td>\n' +
                        '      <td>'+isShowNull(data.taskName)+'</td>\n' +
                        '      <td>关联关键任务</td>\n' +
                        '      <td>'+function () {
                                    var tgIds=''
                                    if(data.tgIds){
                                        data.tgIds.forEach(function (item) {
                                            tgIds+=item.tgName+','
                                        })
                                        return tgIds.replace(/,$/, '')
                                    }else{
                                        return  ''
                                    }
                        }()+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>周期类型</td>\n' +
                        '      <td>'+isShowNull(dictionaryObj['PLAN_SYCLE']['object'][data.planSycle])+'</td>\n' +
                        '      <td>任务来源</td>\n' +
                        '      <td>'+isShowNull(dictionaryObj['RENWUJIHUA_TYPE']['object'][data.taskType])+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>负责人</td>\n' +
                        '      <td>'+function () {
                                if(data.dutyUserName){
                                    return isShowNull(data.dutyUserName.replace(/,$/, ''))
                                }else{
                                    return  ''
                                }
                        }()+'</td>\n' +
                        '      <td>责任部门</td>\n' +
                        '      <td>'+function () {
                                if(data.mainCenterDeptName){
                                    return isShowNull(data.mainCenterDeptName.replace(/,$/, ''))
                                }else{
                                    return  ''
                                }
                        }()+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>计划开始时间</td>\n' +
                        '      <td>'+function () {
                            if(data.planStartDate){
                                return format(data.planStartDate)
                            }else{
                                return  ''
                            }
                        }()+'</td>\n' +
                        '      <td>计划结束时间</td>\n' +
                        '      <td>'+function () {
                            if(data.planEndDate){
                                return format(data.planEndDate)
                            }else{
                                return  ''
                            }
                        }()+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>计划工期</td>\n' +
                        '      <td>'+isShowNull(data.planContinuedDate)+'</td>\n' +
                        '      <td>完成标准</td>\n' +
                        '      <td>'+isShowNull(data.resultStandard)+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>前置子任务</td>\n' +
                        '      <td>'+function () {
                            var preTasks=''
                            if(data.preTasks){
                                data.preTasks.forEach(function (item) {
                                    preTasks+=item.workItemName+','
                                })
                                return preTasks.replace(/,$/, '')
                            }else{
                                return  ''
                            }
                        }()+'</td>\n' +
                        '      <td>风险点</td>\n' +
                        '      <td>'+isShowNull(data.riskPoint)+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>难度点</td>\n' +
                        '      <td>'+isShowNull(data.difficultPoint)+'</td>\n' +
                        '      <td>成果标准模板</td>\n' +
                        '      <td>'+function () {
                            var resultDictList=''
                            if(data.resultDictList){
                                data.resultDictList.forEach(function (item) {
                                    resultDictList+=item.dictName+','
                                })
                                return resultDictList.replace(/,$/, '')
                            }else{
                                return  ''
                            }
                        }()+'</td>\n' +
                        '    </tr>\n' +
                        '    <tr>\n' +
                        '      <td>子任务描述</td>\n' +
                        '      <td>'+isShowNull(data.taskDesc)+'</td>\n' +
                        '      <td>协助部门</td>\n' +
                        '      <td>'+function () {
                            if(data.assistCompanyDeptsName){
                                return isShowNull(data.assistCompanyDeptsName.replace(/,$/, ''))
                            }else{
                                return  ''
                            }
                        }()+'</td>\n' +
                        '    </tr>\n' +
                        '<tr>' +
                        '<td class="td_title">提前几天提醒：</td><td>'+function () {
                            if(data.earlyWarning){
                                return data.earlyWarning+'天'
                            }else{
                                return ''
                            }
                        }()+'</td>' +
                        '      <td>任务类型</td>\n' +
                        '      <td>'+isShowNull(dictionaryObj['TG_TYPE']['object'][data.planType])+'</td>\n' +
                        '</tr>' +
                        '<tr><td class="td_title">编制依据附件：</td><td colspan="3">' +function () {
                            if (!!data.attachments4 && data.attachments4.length > 0) {
                                var str = '';

                                data.attachments4.forEach(function (item) {
                                    var attachName = item.attachName;
                                    var fileExtension = attachName.substring(attachName.lastIndexOf(".") + 1, attachName.length);//截取附件文件后缀
                                    var attName = encodeURI(attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                    var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                    var attachmentUrl = item.attUrl;
                                    attachmentUrl = attachmentUrl.substring(0, attachmentUrl.lastIndexOf("ATTACHMENT_NAME=")) + "ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension; //处理附件名字

                                    fileExtension = fileExtension.toLowerCase();

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
                                });

                                return str;
                            } else {
                                return '';
                            }
                        }()+ '</td></tr>' +
                        '  </tbody>\n' +
                        '</table></div>',
                    success:function () {
                        $.get('/plcProjectItem/itemNameByParentId',{parentId:parentId},function (res) {
                            $('.topItemDetail').html(res.object)
                        })
                    }
                })
            })
        })

        //查询
        $('.queryTask').on("click",function () {
            if(!$('#leftId').attr('projOrgId')){
                layer.msg('请先选择左侧部门！', {icon: 0});
                return false
            }
            var params={
                taskName:$('.query input[name="taskName"]').val(),
                planSycle:$('.query select[name="planSycle"]').val(),
                taskType:$('.query select[name="taskType"]').val(),
                year:$('.query select[name="year"]').val(),
                month:$('.query select[name="month"]').val(),
                itemBelongDept:$('#leftId').attr('projOrgId'),
                _:new Date().getTime()
            }
            insTb.reload({
                url:'/plcProjectItem/selectItemBy',
                where: params
            })
        })

        //任务类型-清空
        $(document).on('click','.tgTypeDel',function () {
            var id=$(this).siblings('input').attr('id')
            $('#'+id).val('')
            $('#'+id).attr('dictNo','')
        })

        $(document).on('click','.tgTypeAdd',function () {
            tgTypeSelect(1,$(this).siblings('input').attr('id'))
        })

        /*弹出层显示关键任务类型--tgType*/
        function tgTypeSelect(chooseNum,id) {
            var tgTypeChildren=null
            if($('#'+id).attr('dictNo')){
                var dictArr=$('#'+id).attr('dictNo').split(',')
                var dictNameArr=$('#'+id).val().split(',')
            }else{
                var dictArr=[]
                var dictNameArr=[]
            }
            layer.open({
                type: 1,
                title: '关键任务类型',
                btn: ['确定', '取消'],
                area: ['60%', '85%'],
                maxmin: true,
                content: '<div style="position: relative;height: 100%; width: 100%;padding: 5px 10px;box-sizing: border-box;">' +
                    '<div class="target_module" style="position: relative;float: left;height: 100%; width: 230px;">' +
                    '<h3 style="padding: 10px 15px; text-align: center;">关键任务类型父级</h3>' +
                    '<div class="tgTypeParent"><ul style="margin-top: 8px"></ul></div>' +
                    '</div>' +
                    '<div class="project_item">' +
                    '<h3 style="padding: 10px 15px; text-align: center;">关键任务类型子级</h3>' +
                    '<div>' +
                    '<table id="tgTypeChildren" lay-filter="tgTypeChildren"></table>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                success: function () {
                    // 初始化左侧关键任务类型
                    $.get('/Dictonary/selectDictionaryByNo',{dictNo:'TG_TYPE_PARENT'},function (res) {
                        var data=res.data
                        var str=''
                        for(var i=0;i<data.length;i++){
                            str+='<li dictNo="'+data[i].dictNo+'" style="text-align: center;padding: 3px">'+data[i].dictName+'</li>';
                        }
                        $('.tgTypeParent ul').html(str)
                    })
                    // 节点点击事件
                    $(document).on('click','.tgTypeParent ul li',function () {
                        $(this).addClass('select').siblings().removeClass('select')
                        var dictNo=$(this).attr('dictNo')
                        //判断是单选还是多选
                        if(chooseNum==1){
                            var chooseType='radio'
                        }else{
                            var chooseType='checkbox'
                        }
                        tgTypeChildren = table.render({
                            elem: '#tgTypeChildren',
                            url: '/Dictonary/getTgTypeByDictNo',
                            cols: [[
                                {type:chooseType},
                                {
                                    field: 'dictName', align: 'left', title: '关键任务类型', templet: function (d) {
                                        return '<span  class="initTgId" dictNo="' + d.dictNo + '" >' + d.dictName + '</span>'
                                    }
                                }
                            ]],
                            where: {
                                dictNo: dictNo,
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                msgName: 'msg',
                                dataName: 'obj'
                            },
                            done: function (res) {
                                $('#tgTypeChildren').next().find('.layui-table-header').remove()
                                //输入框选中的回显
                                //弹出页面选择后切换回显
                                if(dictArr.length>0){
                                    $('.initTgId').each(function (index) {
                                        dictArr.forEach(function (v, i) {
                                            if ($('.initTgId').eq(index).attr('dictNo') == v) {
                                                $('.initTgId').eq(index).parents('td').prev().find('input').prop('checked', 'true')
                                                form.render()
                                            }
                                        })
                                    })
                                }
                            }
                        });
                    })
                    table.on('radio(tgTypeChildren)', function(obj){
                        dictArr=[]
                        dictNameArr=[]
                        dictArr.push(obj.data.dictNo)
                        dictNameArr.push(obj.data.dictName)
                    });

                    //监听复选框
                    table.on('checkbox(tgTypeChildren)', function(obj){
                        if(obj.checked){
                            dictArr.push(obj.data.dictNo)
                            dictNameArr.push(obj.data.dictName)
                        }else{
                            for(var i = 0; i < dictArr.length; i++){
                                if(dictArr[i] ==obj.data.dictNo){
                                    dictArr.splice(i,1);
                                }
                            }
                            for(var i = 0; i < dictNameArr.length; i++){
                                if(dictNameArr[i] ==obj.data.dictName){
                                    dictNameArr.splice(i,1);
                                }
                            }
                        }
                    });
                },
                yes: function (index) {
                    var dictNo=''
                    var dictName=''
                    dictArr.forEach(function (v) {
                        dictNo += v+','
                    })
                    dictNameArr.forEach(function (v) {
                        dictName += v+','
                    })
                    $('#'+id).val(dictName)
                    $('#'+id).attr('dictNo',dictNo)
                    layer.close(index)
                }
            });
        }
    })
    //前置子任务的所有子任务
    function allTask(year,month,mainCenterDept){
        var allTask=''
        $.ajax({
            url:'/plcProjectItem/selectAllItem',
            dataType:'json',
            type:'get',
            async:false,
            data:{
                year:year,
                month:month,
                mainCenterDept:mainCenterDept,
            },
            success:function(res){
                var data=res.obj
                var taskName='<option value=""></option>'
                data.forEach(function (item) {
                    taskName+='<option value="'+item.planItemId+'">'+item.taskName+'</option>'
                })
                allTask=taskName
            }
        })
        return allTask
    }
    //点击按钮收缩
    $('.foldIcon').on("click",function () {
        if ($(this).hasClass('layui-icon-left')) {
            $(this).attr('title', '展开')
            $('.con_left').hide()
            $('.con_right').css({
                'width': '100%',
            })
            $(this).addClass('layui-icon-right').removeClass('layui-icon-left')
        } else {
            $(this).attr('title', '折叠')
            $('.con_left').show().css('width', '230px')
            $('.con_right').css({
                'width': 'calc(100% - 230px)',
                'margin-left': '0px'
            })
            $(this).addClass('layui-icon-left').removeClass('layui-icon-right')
        }

    })

    //判断是否该为空
    function isUndefined(data) {
        if (data == 1) {
            return '是'
        } else if (data == 0) {
            return '否'
        } else {
            return ''
        }
    }

    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if (t) return new Date(t).Format("yyyy-MM-dd");
        else return ''
    }

    //计算计划工期
    function timeRange(beginTime, endTime) {
        var t1 = new Date(beginTime)
        var t2 = new Date(endTime)
        var time = t2.getTime() - t1.getTime()
        var days = parseInt(time / (1000 * 60 * 60 * 24))+1
        return days
    }

    //重置功能
    function reset() {
        $('.query input[name="taskName"]').val('')
        $('.query select[name="planSycle"]').val('')
        $('.query select[name="taskType"]').val('')
        $('.query input[name="year"]').val('')
        $('.query input[name="month"]').val('')
        form.render()
    }

    //判断是否显示空
    function isShowNull(data) {
        if(data){
            return data
        }else{
            return ''
        }
    }

    /***
     * 获取计划期间月度
     * @param year (月度对应年份)
     * @param cb (回调函数)
     */
    function getPlanMonth(year, fn) {
        $.ajax({
            url: '/planPeroidSetting/showAllSet',
            dataType: 'json',
            type: 'get',
            data:{periodYear: year},
            async:false,
            success: function (res) {
                var str = '<option value="">请选择</option>';
                if (res.object.length > 0) {
                    res.object.forEach(function (item) {
                        str += '<option value="' + item.periodMonth + '">' + item.periodMonth + '</option>'
                    });
                }
                if (fn) {
                    fn(str);
                }
            }
        });
    }

   /* function checkOver(userId) {
        $.get('/hr/manage/selectOne', {userId: userId.replace(/,$/, '')}, function (res) {
            $('#form #mainCenterDept').val(res.deptName);
            $('#form #mainCenterDept').attr('deptId', res.deptId);
        });
    }*/
    
    // 初始化页面操作权限
    function initAuthority() {
        // 是否设置页面权限
        if (authorityObject) {
            // 检查保存权限
            if (authorityObject['09']) {
                $('.authority_search').show();
            }
        }
    }

    function checkOver(userId) {
        $.get('/hr/manage/selectOne', {userId: userId.replace(/,$/, '')}, function (res) {
            if($('#belongtoUnit').length>0){
                $('#belongtoUnit').val(res.deptName);
                $('#belongtoUnit').attr('deptId', res.deptId);
            }
            /*暂时不允许修改对应的责任部门2020.11.23*/
            /*else{
                $('#mainCenterDept').val(res.deptName);
                $('#mainCenterDept').attr('deptId', res.deptId);
            }*/
        });
    }

    //附件上传 方法
    var timer=null;
    function fileuploadFn(formId,element) {
        $(formId).fileupload({
            dataType:'json',
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                element.siblings('.progress').find('.bar').css(
                    'width',
                    progress + '%'
                );
                element.siblings('.barText').html(progress + '%');
                if(progress >= 100){  //判断滚动条到100%清除定时器
                    timer=setTimeout(function () {
                        element.siblings('.progress').find('.bar').css(
                            'width',
                            0 + '%'
                        );
                        element.siblings('.barText').html('');
                    },2000);

                }
            },
            done: function (e, data) {
                if(data.result.obj != ''){
                    var data = data.result.obj;
                    var str = '';
                    var str1 = '';
                    for (var i = 0; i < data.length; i++) {
                        var gs = data[i].attachName.split('.')[1];
                        if(gs == 'jsp'||gs == 'css'||gs == 'js'||gs == 'html'||gs == 'java'||gs == 'php' ){ //后缀为这些的禁止上传
                            str += '';
                            layer.alert('jsp、css、js、html、java文件禁止上传!',{},function(){
                                layer.closeAll();
                            });
                        }
                        else{
                            var fileExtension=data[i].attachName.substring(data[i].attachName.lastIndexOf(".")+1,data[i].attachName.length);//截取附件文件后缀
                            var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g,"%40").replace(/\#/g,"%23").replace(/\&/g,"%26").replace(/\//g,"%2F").replace(/\?/g,"%3F").replace(/\￥/g,"%ef%bf%a5").replace(/\$/g,"%24").replace(/\！/g,"%ef%bc%81").replace(/\（/g,"%ef%bc%88").replace(/\）/g,"%ef%bc%89").replace(/\…/g,"%e2%80%a6%e2%80%a6");
                            var fileExtensionName=attName.substring(0,attName.lastIndexOf("."));
                            var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0]+"&ATTACHMENT_NAME="+fileExtensionName+"."+fileExtension+"&FILESIZE="+data[i].size;

                            str += '<div class="dech" deUrl="' + deUrl+ '"><a href="/download?'+encodeURI(deUrl)+'" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                    }
                    element.append(str);
                }else{
                    layer.alert('添加附件大小不能为空!',{},function(){
                        layer.closeAll();
                    });
                }
            }
        });
    }

    function importLeft(val) {
        if (val && dept_id == 'assistCompanyDepts') {
            $.get('/plcOrg/checkDeptYN', {deptIds: val}, function(res){
                if (res != 1) {
                    layer.msg('选择的部门包含组织架构，请选择正确的部门！', {icon: 0});
                    $('#' + dept_id).val('');
                    $('#' + dept_id).attr('deptid', '');
                }
            });
        }
    }

</script>
</body>
</html>

