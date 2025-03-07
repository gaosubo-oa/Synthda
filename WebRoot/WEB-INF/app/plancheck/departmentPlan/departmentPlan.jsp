
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>部门计划</title>
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

    </style>

</head>
<body>
<div class="container">
    <div class="header">
        <div class="headImg" style="padding-top: 10px">
            <span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt="">
                <span style="margin-left: 10px">部门计划</span>
            </span>
        </div>
    </div>
    <hr>
    <%--筛选查询--%>
    <form class="layui-form" action="">
        <div class="query" style="display: flex" >
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: -5px">年度</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 150px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" >
                <label class="layui-form-label" style="margin-top: -5px">月度</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 150px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item" >
                <label class="layui-form-label" style="margin-top: -5px">所属部门</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 150px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: -5px">类型（项目/关键任务/子任务）</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 150px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" >
                <label class="layui-form-label" style="margin-top: -5px">计划类型</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 150px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <%--<button type="button" class="layui-btn layui-btn-sm" style="margin-left:8%">查询</button>--%>
        </div>
        <div class="query" style="display: flex;margin-top: -20px" >

            <div class="layui-form-item" >
                <label class="layui-form-label" style="margin-top: -5px">关键任务类型</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 150px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item" >
                <label class="layui-form-label" style="margin-top: -5px">关键任务状态</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width:  150px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" >
                <label class="layui-form-label" style="margin-top: -5px">子任务状态</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 150px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <button type="button" class="layui-btn layui-btn-sm" style="margin-left:8%">查询</button>
        </div>
    </form>
    <hr style="margin-top: -8px">
    <div class="content clearfix" style="margin-top:100px">
        <div class="con_left">
            <div class="layui-card">
                <div class="layui-card-body" style="height: 100%; padding-bottom: 20px; box-sizing: border-box;">
                    <div id="eleTrees" class="eleTree department_tree" style="height: 100%; overflow: auto;" lay-filter="departmentData">

                    </div>
                </div>
            </div>
        </div>
        <div class="con_right">
            <div class="layui-card" style="height: 100%;">
                <div class="layui-card-header dept_name"></div>
                <div class="layui-card-body clearfix" style="height: calc(100% - 43px); box-sizing: border-box; padding-bottom: 20px;">
                    <div id="tab" class="layui-tab layui-tab-brief" style="padding: 0 20px;display: none" lay-filter="planSycleTab">
                        <ul class="layui-tab-title">
                            <li class="layui-this">部门整体计划</li>
                            <li>部门年度计划</li>
                            <li>部门季度计划</li>
                            <li>部门月度计划</li>
                        </ul>
                        <div class="layui-tab-content">
                            <div class="layui-tab-item layui-show">
                                <table id="targetTreeTb"></table>
                            </div>
                            <div class="layui-tab-item">
                                <table id="demoTreeYear"></table>
                            </div>
                            <div class="layui-tab-item">
                                <table id="demoTreeSeason"></table>
                            </div>
                            <div class="layui-tab-item">
                                <table id="demoTreeMonth"></table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- 子任务工具条 --%>
<%--<script type="text/html" id="targetBar">--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>--%>
    <%--<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
<%--</script>--%>

<%-- 子任务头部工具条 --%>
<%--<script type="text/html" id="targetToolBar">--%>
    <%--<a class="layui-btn layui-btn-xs" lay-event="add">新增关键任务</a>--%>
<%--</script>--%>

<script>

    var globalInfo = {}

    layui.use(['table', 'layer', 'form', 'laydate', 'upload', 'eleTree', 'treeTable'], function () {
        var table = layui.table,
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
                dataName: "obj"
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

        var divArr = $('#eleTrees div ');
        console.log(divArr)

        // 树节点点击事件
        eleTree.on("nodeClick(departmentData)", function (d) {
            $("#tab").show()

            $('.dept_name').text(d.data.currentData.deptName)

            //整体计划
            var insTb = treeTable.render({
                elem: '#targetTreeTb',
                url: '/plcDeptTarget/query',
                // toolbar: '#targetToolBar',
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
                ,cols: [[
                    {type: 'numbers'},
                    {field: 'tgName', title: '名称'},
                    {field: 'tgNo', title: '负责人'},
                    {field: 'mainAreaDeptName', title: '所属部门'},
                    {field: 'planContinuedDate', title: '计划工期'},
                    {
                        field: 'planStartDate', title: '计划开始时间', templet: function (d) {
                            return format(d.planStartDate)
                        }
                    },
                    {
                        field: 'planEndDate', title: '计划结束时间', templet: function (d) {
                            return format(d.planEndDate)
                        }
                    },
                    // {fixed: 'right', title: '操作', align: 'center', toolbar: '#targetBar'}
                ]]
                ,where: {
                    mainCenterDept: d.data.currentData.deptId,
                    time: new Date().getTime()
                }
            })
            //年度计划
            var insTbs = treeTable.render({
                elem: '#demoTreeYear',
                url: '/plcDeptTarget/query',
                // toolbar: '#targetToolBar',
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
                ,cols: [[
                    {type: 'numbers'},
                    {field: 'tgName', title: '名称'},
                    {field: 'tgNo', title: '负责人'},
                    {field: 'mainAreaDeptName', title: '所属部门'},
                    {field: 'planContinuedDate', title: '计划工期'},
                    {
                        field: 'planStartDate', title: '计划开始时间', templet: function (d) {
                            return format(d.planStartDate)
                        }
                    },
                    {
                        field: 'planEndDate', title: '计划结束时间', templet: function (d) {
                            return format(d.planEndDate)
                        }
                    },
                    // {fixed: 'right', title: '操作', align: 'center', toolbar: '#targetBar'}
                ]]
                ,where: {
                    mainCenterDept: d.data.currentData.deptId,
                    time: new Date().getTime()
                }
            })
            //季度计划
            var instbs = treeTable.render({
                elem: '#demoTreeSeason',
                url: '/plcDeptTarget/query',
                // toolbar: '#targetToolBar',
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
                ,cols: [[
                    {type: 'numbers'},
                    {field: 'tgName', title: '名称'},
                    {field: 'tgNo', title: '负责人'},
                    {field: 'mainAreaDeptName', title: '所属部门'},
                    {field: 'planContinuedDate', title: '计划工期'},
                    {
                        field: 'planStartDate', title: '计划开始时间', templet: function (d) {
                            return format(d.planStartDate)
                        }
                    },
                    {
                        field: 'planEndDate', title: '计划结束时间', templet: function (d) {
                            return format(d.planEndDate)
                        }
                    },
                    // {fixed: 'right', title: '操作', align: 'center', toolbar: '#targetBar'}
                ]]
                ,where: {
                    mainCenterDept: d.data.currentData.deptId,
                    time: new Date().getTime()
                }
            })
            //月度计划
            var instb = treeTable.render({
                elem: '#demoTreeMonth',
                url: '/plcDeptTarget/query',
                // toolbar: '#targetToolBar',
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
                ,cols: [[
                    {type: 'numbers'},
                    {field: 'tgName', title: '名称'},
                    {field: 'tgNo', title: '负责人'},
                    {field: 'mainAreaDeptName', title: '所属部门'},
                    {field: 'planContinuedDate', title: '计划工期'},
                    {
                        field: 'planStartDate', title: '计划开始时间', templet: function (d) {
                            return format(d.planStartDate)
                        }
                    },
                    {
                        field: 'planEndDate', title: '计划结束时间', templet: function (d) {
                            return format(d.planEndDate)
                        }
                    },
                    // {fixed: 'right', title: '操作', align: 'center', toolbar: '#targetBar'}
                ]]
                ,where: {
                    mainCenterDept: d.data.currentData.deptId,
                    time: new Date().getTime()
                }
            })
        })

    })


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
