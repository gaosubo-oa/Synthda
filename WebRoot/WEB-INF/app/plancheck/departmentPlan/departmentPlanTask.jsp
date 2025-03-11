<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-05-07
  Time: 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>部门计划子任务</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>

    <style>
        html, body {
            height: 100%;
            width: 100%;
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

        .content {
            position: absolute;
            top: 61px;
            left: 0;
            bottom: 0;
            right: 0;
        }

        .con_left {
            float: left;
            width: 320px;
            height: 100%;
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
            width: calc(100% - 320px);
            height: 100%;
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

        .dept_name {
            font-size: 18px;
            font-weight: 500;
        }
        hr{
            margin: 5px 0px;
        }
        .layui-form-label{
            width: 115px;
        }
        .layui-input-block{
            margin-left: 145px;
        }
        .dept_input, .user_input {
            background-color: #ccc;
        }
        .choose_disabled {
            display: none;
        }
        .disabled {
            border: none;
            background-color: #fff !important;
        }
        .layui-form-item .layui-input-inline{
            width: 66%;
        }
        .layui-select-disabled .layui-disabled {
            border: none;
            cursor: default !important;
            /*color: #222 !important;*/
        }
        .layui-select-disabled .layui-edge {
            display: none;
        }

    </style>

</head>
<body>
<div class="container">
    <div class="header">
        <div class="headImg" style="padding-top: 10px">
					<span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img
                            style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span
                            style="margin-left: 10px">部门计划子任务</span></span>
        </div>
    </div>
    <hr>
    <%--筛选查询--%>
    <form class="layui-form" action="">
        <div class="query" style="display: flex" >
            <div class="layui-form-item" style="margin-left: -35px">
                <label class="layui-form-label" style="margin-top: -5px">子任务名称</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" style="margin-left: -35px">
                <label class="layui-form-label" style="margin-top: -5px">关注等级</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item" style="margin-left: -35px">
                <label class="layui-form-label" style="margin-top: -5px">周期类型</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item" style="margin-left: -35px">
                <label class="layui-form-label" style="margin-top: -5px">计划类型</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" style="margin-left: -35px">
                <label class="layui-form-label" style="margin-top: -5px">所属部门</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" style="margin-left: -35px">
                <label class="layui-form-label" style="margin-top: -5px">子任务状态</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <button type="button" class="layui-btn layui-btn-sm" style="margin-left:8%">查询</button>
        </div>
    </form>
    <hr style="margin-top: -8px">
    <div class="content clearfix" style="margin-top: 50px;">
        <div class="con_left">
            <div class="layui-card">
                <div class="layui-card-body"
                     style="height: 100%; padding-bottom: 20px; box-sizing: border-box;">
                    <div class="eleTree department_tree" style="height: 100%; overflow: auto;"
                         lay-filter="departmentData"></div>
                </div>
            </div>
        </div>
        <div class="con_right">
            <div class="layui-card" style="height: 100%;">
                <div class="layui-card-header dept_name"></div>
                <div class="layui-card-body clearfix">
                    <table id="targetTreeTb" lay-filter="targetTreeTb"></table>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- 子任务工具条 --%>
<%--<script type="text/html" id="targetBar">--%>
    <%--<a class="layui-btn layui-btn-sm" lay-event="detail">查看</a>--%>
    <%--<a class="layui-btn layui-btn-sm" lay-event="edit">编辑</a>--%>
    <%--<a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del">删除</a>--%>
<%--</script>--%>

<%-- 子任务头部工具条 --%>
<script type="text/html" id="targetToolBar">
    <%--<a class="layui-btn layui-btn-sm" lay-event="add">新增子任务</a>--%>
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">新增子任务</button>
        <div style="position:relative;margin-top: -40px;margin-left:75%">
            <button class="layui-btn layui-btn-sm" lay-event="inforAdd" style="margin-left:10px;">查看</button>
            <button class="layui-btn layui-btn-sm" lay-event="edit" style="margin-left:10px;">编辑</button>
            <button class="layui-btn layui-btn-sm" lay-event="del" style="margin-left:10px;">删除</button>
        </div>
    </div>
</script>

<script>
    var form,laydate,eleTree,treeTable
    var globalInfo = {}
    var dictionaryObj = {PLAN_TYPE: {}, PLAN_PHASE: {}, PLAN_RATE: {}, PLAN_LEVEL: {}, CONTROL_LEVEL: {}, ACCORDING: {}, PLAN_SYCLE: {}, TASK_TYPE: {}}
    var dictionaryStr = 'PLAN_TYPE,PLAN_PHASE,PLAN_RATE,PLAN_LEVEL,CONTROL_LEVEL,ACCORDING,PLAN_SYCLE,TASK_TYPE'
    // 获取数据字典数据
    $.get('/Dictonary/selectDictionaryByDictNos', {dictNos: dictionaryStr}, function(res){
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function(item){
                        dictionaryObj[dict]['object'][item.dictNo] = item.dictName
                        dictionaryObj[dict]['str'] += '<option value=' + item.dictNo + '>' + item.dictName + '</option>'
                    })
                }
            }
        }
    })
    // 选择部门
    $(document).on('click', '.choose_dept', function () {
        var chooseType = $(this).attr('choosetype') == 1 ? '?0' : ''
        dept_id = $(this).parent().attr('deptid')
        $.popWindow("../common/selectDept" + chooseType);
    })
    // 清空部门
    $(document).on('click', '.clear_dept', function () {
        var deptId = $(this).parent().attr('deptid')
        $('#' + deptId).val('')
        $('#' + deptId).attr('deptid', '')
    })
    // 选择用户
    $(document).on('click', '.choose_user', function () {
        var chooseType = $(this).attr('choosetype') == 1 ? '?0' : ''
        user_id = $(this).parent().attr('userid');
        $.ajax({
            url: '/imfriends/getIsFriends',
            type: 'get',
            dataType: 'json',
            data: {},
            success: function (obj) {
                if (obj.object == 1) {
                    $.popWindow("../common/selectUserIMAddGroup" + chooseType);
                } else {
                    $.popWindow("../common/selectUser" + chooseType);
                }
            },
            error: function (res) {
                $.popWindow("../common/selectUser" + chooseType);
            }
        })
    })
    // 清空用户
    $(document).on('click', '.clear_user', function () {
        var userId = $(this).parent().attr('userid')
        $('#' + userId).val('')
        $('#' + userId).attr('user_id', '')
    })

    layui.use([ 'layer', 'form', 'laydate', 'upload', 'eleTree', 'treeTable'], function () {
            form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            upload = layui.upload,
            eleTree = layui.eleTree,
            treeTable = layui.treeTable;

        var eTree = eleTree.render({
            elem: '.department_tree',
            showLine: true, // 显示连接线
            url: '/department/getChDeptfq',
            lazy: true, // 开启懒加载
            accordion: true,
            //expandOnClickNode: false, // 禁止点击节点关闭显示子节点
            highlightCurrent: true, // 选中高亮
            where: {
                deptId: 0
            },
            request: { // 修改数据为组件需要的数据
                name: "deptName", // 显示的内容
                key: "deptId", // 节点id
                parentId: 'deptParent', // 节点父id
                isLeaf: 'isLeaf' // 是否有子节点
            },
            response: { // 修改响应数据为组件需要的数据
                statusName: "flag",
                statusCode: true,
                dataName: "obj",
            },
            load: function (data, callback) { // 懒加载方法
                $.post('/department/getChDeptfq?deptId=' + data.deptId, function (res) {
                    res.obj.forEach(function (dept) {
                        dept.isLeaf = dept.isHaveCh === '1' ? false : true
                    })
                    callback(res.obj);//点击节点回调
                })
            }
        })

        // 树节点点击事件
        eleTree.on("nodeClick(departmentData)", function (d) {
            $('.dept_name').text(d.data.currentData.deptName)
            // 渲染表格
            var insTb = treeTable.render({
                elem: '#targetTreeTb',
                url: '/plcDeptTarget/query',
                toolbar: '#targetToolBar',
                defaultToolbar:false,
                tree: {
                    iconIndex: 1,           // 折叠图标显示在第几列
                    isPidData: true,        // 是否是id、pid形式数据
                    idName: 'tgId',  // id字段名称
                    pidName: 'parentTgId'     // pid字段名称
                }
                ,parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": res.flag ? 0 : 1,
                        "msg": res.msg,
                        "data": res.obj
                    }
                }
                ,cols: [[ //表头
                    {field: 'tgNo', title: '关键任务编号', minWidth: 110}
                    ,{field: 'tgName', title: '关键任务名称', minWidth: 150}
                    ,{field: 'parentTgId', title: '上级关键任务', minWidth: 90 }
                    ,{field: 'tgType', title: '关键任务类型', minWidth: 110}
                    ,{field: 'tgGrade', title: '关键任务等级', minWidth: 90}
                    ,{field: 'tgDesc', title: '关键任务说明', minWidth: 90}
                    ,{field: 'mainAreaDeptName', title: '一级监督部门', minWidth:150}
                    ,{field: 'mainProjectDeptName', title: '二级监督部门', minWidth:150}
                    ,{field: 'projectId', title: '所属项目名称' }
                    ,{field: 'pbagId', title: '所属子项目名称' }
                    ,{field: 'dutyUserName', title: '责任人', minWidth: 110}
                    ,{field: 'assistUserName', title: '协作人', minWidth: 110}
                    ,{field: 'mainCenterDeptName', title: '所属部门', minWidth:150}
                    ,{field: 'assistCompanyDeptName', title: '协助部门', minWidth:150}
                    ,{field: 'planType', title: '计划类型', minWidth: 110}
                    ,{field: 'planStage', title: '计划阶段', minWidth: 110}
                    ,{field: 'planRate', title: '计划形式', minWidth: 110}
                    ,{field: 'planLevel', title: '计划级次', minWidth: 110}
                    ,{field: 'controlLevel', title: '关注等级', minWidth: 110}
                    ,{field: 'according', title: '工作项依据', minWidth: 110}
                    ,{field: 'isKeypoint', title: '是否关键工作项', minWidth: 110}
                    ,{field: 'isResult', title: '是否提交成果', minWidth: 110}
                    ,{field: 'planSycle', title: '周期类型', minWidth: 110}
                    // ,{field: 'flowId', title: '审批流程', minWidth: 110}
                    ,{field: 'planStartDate', title: '计划开始时间',minWidth:120}
                    ,{field: 'planEndDate', title: '计划完成时间',minWidth:120}
                    ,{field: 'planContinuedDate', title: '计划工期', minWidth: 110}
                    ,{field: 'realStartDate', title: '实际开始时间',minWidth:120}
                    ,{field: 'realEndDate', title: '实际完成时间',minWidth:120}
                    ,{field: 'realContinuedDate', title: '实际工期', minWidth: 110}
                    ,{field: 'standardDegree', title: '标准难度系数', minWidth: 110}
                    ,{field: 'hardDegree', title: '难度系数', minWidth: 110}
                    ,{field: 'resultConfirm', title: '成果确认', minWidth: 110}
                    ,{field: 'resultDesc', title: '成果描述', minWidth: 110}
                    ,{field: 'finalResultDesc', title: '最终交付成果描述', minWidth: 110}
                    ,{field: 'unusualRes', title: '异常原因', minWidth: 110}
                    ,{field: 'unusualStuff', title: '异常支撑材料', minWidth: 110}
                    ,{field: 'qualityScore', title: '质量得分', minWidth: 110}
                    ,{field: 'taskStatus', title: '关键任务状态', minWidth: 110}
                    ,{field: 'taskPrecess', title: '关键任务进度', minWidth: 110}
                    ,{field: 'taskType', title: '关键任务类型', minWidth: 110}
                    ,{field: 'taskDesc', title: '关键任务说明', minWidth: 110}
                    ,{field: 'riskPoint', title: '风险点', minWidth: 110}
                    ,{field: 'difficultPoint', title: '难度点', minWidth: 110}
                    ,{field: 'endScore', title: '单项得分', minWidth: 110}
                    ,{field: 'resultStandard', title: '完成标准', minWidth: 110}
                    ,{field: 'itemQuantity', title: '工程量', minWidth: 110}
                    ,{field: 'itemQuantityNuit', title: '工程量单位', minWidth: 110}
                    // ,{fixed: 'right',title: '操作',align:'center', toolbar: '#targerBar', minWidth:170}
                ]]
                ,where: {
                    mainCenterDept: d.data.currentData.deptId,
                    time: new Date().getTime()
                }
            })
        })

        //监听事件
        treeTable.on('toolbar(targetTreeTb)', function(obj){
            switch(obj.event){
                case 'add':
                    creatTask(1)
                    break;
            };
        });
        //监听工具条
        treeTable.on('tool(targetTreeTb)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'detail'){ //查看
                creatTask(3,data)
            } else if(layEvent === 'del'){ //删除
                layer.confirm('确定删除该条数据吗？', function(index){

                });
            } else if(layEvent === 'edit'){ //编辑'
                creatTask(2,data)
            }
        });
    })
    // 子任务-查看、新增、编辑-共用方法
    function creatTask(type, tData) {
        var title = '',
            disabled = '',
            url = '';
        switch (type) {
            case 1:
                title = '添加子任务'
                url = '/deptItem/insert'
                break;
            case 2:
                title = '编辑子任务'
                url = '/deptItem/update'
                break;
            case 3:
                title = '查看子任务'
                disabled = 'disabled'
                break;
            default:
                return false
                break;
        }

        var taskLayer = layer.open({
            type: 1,
            title: title,
            area: ['100%', '100%'],
            maxmin: true,
            min: function () {
                $('.layui-layer-shade').hide()
            },
            btn: ['保存', '取消'],
            btnAlign: 'c',
            content: '<div id="taskFormBox" style="padding: 30px 50px 0 30px;">\n' +
                '        <form class="layui-form" id="taskForm" lay-filter="taskForm">\n' +
                '            <div class="layui-row">\n' +
                '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">子任务编码</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="taskNo" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">责任人</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input style="width: 75%" type="text" readonly id="dutyUser" name="dutyUser" autocomplete="off" class="layui-input ' + disabled + ' user_input">\n' +
                '                        </div>\n' +
                '                        <div style="margin-left: 80%;margin-top: -35px" class="layui-form-mid layui-word-aux choose_' + disabled + '" userid="dutyUser">\n' +
                '                            <a href="javascript:;" class="choose_user" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">所属部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input style="width: 75%" type="text" readonly id="mainCenterDept" name="mainCenterDept" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
                '                        </div>\n' +
                '                        <div style="margin-left: 80%;margin-top: -35px" class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainCenterDept">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">二级监督部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input style="width: 75%" type="text" readonly id="mainProjectDept" name="mainProjectDept" autocomplete="off" class="layui-input ' + disabled + ' user_input">\n' +
                '                        </div>\n' +
                '                        <div style="margin-left: 80%;margin-top: -35px" class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainProjectDept">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划类型</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planType" ' + disabled + ' name="planType" class="' + disabled + '" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划形式</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planRate" ' + disabled + ' name="planRate" class="' + disabled + '" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">关注等级</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="controlLevel" ' + disabled + ' name="controlLevel" class="' + disabled + '" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否关键工作项</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" ' + disabled + ' name="isKeypoint" value="1" title="是">\n' +
                '                            <input type="radio" ' + disabled + ' name="isKeypoint" value="0" title="否" checked>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">是否提交成果</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="radio" ' + disabled + ' name="isResult" value="1" title="是">\n' +
                '                            <input type="radio" ' + disabled + ' name="isResult" value="0" title="否" checked>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划开始时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="taskPlanStartDate" ' + disabled + ' name="planStartDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划工期</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="planContinuedDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">实际完成时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="taskRealEndDate" ' + disabled + ' name="realEndDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">标准难度系数</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="standardDegree" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">成果确认</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="resultConfirm" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">最终交付成果描述</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="finalResultDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">异常支撑材料</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="unusualStuff" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">子任务状态</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="taskStatus" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">子任务类型</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="taskType" ' + disabled + ' name="taskType" class="' + disabled + '" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">风险点</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="riskPoint" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">完成标准</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="resultStandard" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">工程量单位</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="itemQuantityNuit" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-upload" style="height: auto">\n' +
                '                        <div id="achievementsFiles" style="padding-left: 143px;"></div>\n' +
                '                        <label class="layui-form-label">成果文件：</label>\n' +
                '                        <div class="layui-input-block" id="achievements_box">\n' +
                '                        <button type="button" class="layui-btn layui-btn-primary" id="uploadAchievementsFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '                <div class="layui-col-xs6" style="padding: 0 20px;">\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">子任务名称</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="taskName" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">协作人</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input style="width: 75%" type="text" readonly id="assistUser" name="assistUser" autocomplete="off" class="layui-input ' + disabled + ' user_input">\n' +
                '                        </div>\n' +
                '                        <div style="margin-left: 80%;margin-top: -35px" class="layui-form-mid layui-word-aux choose_' + disabled + '" userid="assistUser">\n' +
                '                            <a href="javascript:;" class="choose_user" choosetype="2" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_user" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">一级监督部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input style="width: 75%" type="text" readonly id="mainAreaDept" name="mainAreaDept" autocomplete="off" class="layui-input ' + disabled + ' dept_input">\n' +
                '                        </div>\n' +
                '                        <div style="margin-left: 80%;margin-top: -35px" class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="mainAreaDept">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="1" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">协助部门</label>\n' +
                '                        <div class="layui-input-inline select_input">\n' +
                '                            <input style="width: 75%" type="text" readonly id="assistCompanyDepts" name="assistCompanyDepts" autocomplete="off" class="layui-input ' + disabled + ' user_input">\n' +
                '                        </div>\n' +
                '                        <div style="margin-left: 80%;margin-top: -35px" class="layui-form-mid layui-word-aux choose_' + disabled + '" deptid="assistCompanyDepts">\n' +
                '                            <a href="javascript:;" class="choose_dept" choosetype="2" style="color: blue;">添加</a>\n' +
                '                            <a href="javascript:;" class="clear_dept" style="color: red">删除</a>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划阶段</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planStage" ' + disabled + ' name="planStage" class="' + disabled + '" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划级次</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planLevel" ' + disabled + ' name="planLevel" class="' + disabled + '" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">工作项依据</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="according" ' + disabled + ' name="according" class="' + disabled + '" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">周期类型</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <select id="planSycle" ' + disabled + ' name="planSycle" class="' + disabled + '" lay-verify="required">\n' +
                '                                <option value=""></option>\n' +
                '                            </select>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">计划完成时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="taskPlanEndDate" ' + disabled + ' name="planEndDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">实际开始时间</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" id="taskRealStartDate" ' + disabled + ' name="realStartDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">实际工期</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="realContinuedDate" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">难度系数</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="hardDegree" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">成果描述</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="resultDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">异常原因</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="unusualRes" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">质量得分</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="qualityScore" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">子任务进度</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="taskPrecess" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">子任务说明</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="taskDesc" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">难度点</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="difficultPoint" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">单项得分</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="endScore" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">工程量</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input ' + disabled + ' type="text" name="itemQuantity" autocomplete="off" class="layui-input ' + disabled + '">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-upload" style="height: auto">\n' +
                '                        <div id="taskFiles" style="padding-left: 143px;"></div>\n' +
                '                        <label class="layui-form-label">子任务文件：</label>\n' +
                '                        <div class="layui-input-block" id="task_box">\n' +
                '                        <button type="button" class="layui-btn layui-btn-primary" id="uploadTaskFile" style="border: 0px;color:#3870d7;padding: 0;"><img src="/img/icon_uplod.png" style="margin-right: 5px;"><i style="display: none" class="layui-icon"></i>附件上传</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '            </div>\n' +
                '        </form>\n' +
                '    </div>',
            success: function () {
                $('#planType').append(dictionaryObj['PLAN_TYPE']['str'])
                $('#planStage').append(dictionaryObj['PLAN_PHASE']['str'])
                $('#planRate').append(dictionaryObj['PLAN_RATE']['str'])
                $('#planLevel').append(dictionaryObj['PLAN_LEVEL']['str'])
                $('#controlLevel').append(dictionaryObj['CONTROL_LEVEL']['str'])
                $('#according').append(dictionaryObj['ACCORDING']['str'])
                $('#planSycle').append(dictionaryObj['PLAN_SYCLE']['str'])
                $('#taskType').append(dictionaryObj['TASK_TYPE']['str'])
                form.render()
                // 处理时间显示
                // 计划开始时间
                laydate.render({
                    elem: '#taskPlanStartDate',
                    value: tData && tData.planStartDate ? new Date(tData.planStartDate) : ''
                })

                // 计划完成时间
                laydate.render({
                    elem: '#taskPlanEndDate',
                    value: tData && tData.planEndDate ? new Date(tData.planEndDate) : ''
                })

                // 实际开始时间
                laydate.render({
                    elem: '#taskRealStartDate',
                    value: tData && tData.realStartDate ? new Date(tData.realStartDate) : ''
                })

                // 实际完成时间
                laydate.render({
                    elem: '#taskRealEndDate',
                    value: tData && tData.realEndDate ? new Date(tData.realEndDate) : ''
                })

                if (type !== 1) {
                    form.val("taskForm", tData)

                    // 处理责任人显示
                    $('#dutyUser').val(tData ? tData.dutyUserName : '')
                    $('#dutyUser').attr('user_id', tData ? tData.dutyUser : '')
                    // 处理协作人显示
                    $('#assistUser').val(tData ? tData.assistUserName : '')
                    $('#assistUser').attr('user_id', tData ? tData.assistUser : '')
                    // 处理所属部门显示
                    $('#mainCenterDept').val(tData ? tData.mainCenterDeptName : '')
                    $('#mainCenterDept').attr('deptid', tData ? tData.mainCenterDept : '')
                    // 处理一级监督部门部门显示
                    $('#mainAreaDept').val(tData ? tData.mainAreaDeptName : '')
                    $('#mainAreaDept').attr('deptid', tData ? tData.mainAreaDept : '')
                    // 处理二级监督部门显示
                    $('#mainProjectDept').val(tData ? tData.mainProjectDeptName : '')
                    $('#mainProjectDept').attr('deptid', tData ? tData.mainProjectDept : '')
                    // 处理协助部门显示
                    $('#assistCompanyDepts').val(tData ? tData.assistCompanyDeptsName : '')
                    $('#assistCompanyDepts').attr('deptid', tData ? tData.assistCompanyDepts : '')

                    // 处理子任务文件附件显示
                    var attachments = tData ? tData.attachments || [] : []
                    var fileStr = ''
                    if (attachments.length > 0) {
                        attachments.forEach(function (attachment) {
                            var fileExtension = attachment.attachName.substring(attachment.attachName.lastIndexOf(".") + 1, attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6")
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachment.size
                            fileStr += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + attachment.attachName + '" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    // 处理成果文件附件显示
                    var attachments2 = tData ? tData.attachments2 || [] : []
                    var fileStr2 = ''
                    if (attachments2.length > 0) {
                        attachments2.forEach(function (attachment) {
                            var fileExtension = attachment.attachName.substring(attachment.attachName.lastIndexOf(".") + 1, attachment.attachName.length)//截取附件文件后缀
                            var attName = encodeURI(attachment.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6")
                            var fileExtensionName = attName.substring(0, attName.lastIndexOf("."))
                            var deUrl = attachment.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + attachment.size
                            fileStr2 += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + attachment.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + attachment.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + attachment.attachName + '" class="inHidden" value="' + attachment.aid + '@' + attachment.ym + '_' + attachment.attachId + ',"></div>'
                        })
                    }
                    if (type === 2) {
                        $('#taskFiles').html(fileStr)
                        $('#achievementsFiles').html(fileStr2)
                    } else {
                        $('#task_box').html(fileStr)
                        $('#achievements_box').html(fileStr2)
                        $('.layui-layer-btn').hide()
                    }
                }

                $('.layui-disabled').attr('placeholder', '').css('color', '#222')

                // 子任务文件附件上传
                upload.render({
                    elem: '#uploadTaskFile'
                    , url: '/upload?module=plancheck' //上传接口
                    , accept: 'file' //普通文件
                    , done: function (res) {
                        var data = res.obj[0];
                        var fileExtension = data.attachName.substring(data.attachName.lastIndexOf(".") + 1, data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data.size;
                        var str = '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + data.attachName + '" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';
                        $('#taskFiles').append(str);
                        layer.msg('上传成功', {icon: 6});
                    }
                })
                // 成果文件附件上传
                upload.render({
                    elem: '#uploadAchievementsFile'
                    , url: '/upload?module=plancheck' //上传接口
                    , accept: 'file' //普通文件
                    , done: function (res) {
                        var data = res.obj[0];
                        var fileExtension = data.attachName.substring(data.attachName.lastIndexOf(".") + 1, data.attachName.length);//截取附件文件后缀
                        var attName = encodeURI(data.attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                        var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                        var deUrl = data.attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data.size;
                        var str = '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data.attachName + '*"><img style="margin-top: -3px; margin-right: 3px;" src="/img/attachment_icon.png"/>' + data.attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" data-attachname="' + data.attachName + '" class="inHidden" value="' + data.aid + '@' + data.ym + '_' + data.attachId + ',"></div>';
                        $('#achievementsFiles').append(str);
                        layer.msg('上传成功', {icon: 6});
                    }
                })
            },
            yes: function () {
                var data = {}

                if (type === 3) {
                    layer.close(targetLayer)
                    return false
                } else if (type === 2) {
                    data['planItemId'] = tData.planItemId
                }

                var dataEle = $('#taskForm [name]').serializeArray()
                $.each(dataEle, function () {
                    data[this.name] = this.value
                })

                var dutyUser = $('#dutyUser').attr('user_id') || ''
                var assistUser = $('#assistUser').attr('user_id') || ''
                var mainCenterDept = $('#mainCenterDept').attr('deptid') || ''
                var mainAreaDept = $('#mainAreaDept').attr('deptid') || ''
                var mainProjectDept = $('#mainProjectDept').attr('deptid') || ''
                var assistCompanyDepts = $('#assistCompanyDepts').attr('deptid') || ''

                var attachmentId = ''
                var attachmentName = ''

                var $attachments = $('#taskFiles').find('input[type="hidden"]')
                $attachments.each(function () {
                    attachmentId += $(this).val()
                    attachmentName += $(this).data('attachname') + '*'
                })

                var attachmentId2 = ''
                var attachmentName2 = ''

                var $attachments2 = $('#achievementsFiles').find('input[type="hidden"]')
                $attachments.each(function () {
                    attachmentId2 += $(this).val()
                    attachmentName2 += $(this).data('attachname') + '*'
                })

                data['dutyUser'] = dutyUser
                data['assistUser'] = assistUser
                data['mainCenterDept'] = mainCenterDept
                data['mainAreaDept'] = mainAreaDept
                data['mainProjectDept'] = mainProjectDept
                data['assistCompanyDepts'] = assistCompanyDepts

                data['attachmentId'] = attachmentId
                data['attachmentName'] = attachmentName

                data['standardDegree'] = parseInt(data['standardDegree'] || 0)
                data['taskPrecess'] = parseInt(data['taskPrecess'] || 0)

                $.post(url, data, function (res) {
                    if (res.flag) {
                        layer.msg('保存成功', {icon: 1})
                        layer.close(taskLayer)
                        taskTable.reload({
                            url: '/plcProjectItem/query',
                            where: {
                                time: new Date().getTime(),
                                useFlag: true
                            },
                            page: {
                                curr: 1
                            }
                        })
                    } else {
                        layer.msg('保存失败', {icon: 2})
                    }
                })
            }
        })
    }


    //将毫秒数转为yyyy-MM-dd格式时间
    function format(t) {
        if (t) {
            return new Date(t).Format("yyyy-MM-dd")
        } else {
            return ''
        }
    }

</script>
</body>
</html>