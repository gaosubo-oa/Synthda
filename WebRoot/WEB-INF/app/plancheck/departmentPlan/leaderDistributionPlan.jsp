<%--
  Created by IntelliJ IDEA.
  User: 刘松
  Date: 2020/5/11
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>领导分配计划</title>
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
    .con_left {
        float: left;
        width: 230px;
        height: 100%;
    }
    .left_List .left_List_item{
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
    .project_info {
        float: left;
        width: calc(100% - 270px);
        box-shadow: 0 0px 5px 0 rgba(0,0,0,.1);
        border-radius: 3px;
        margin-left:20px;
    }
    #all{
        padding:10px;
    }
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <div class="headImg" style="padding-top: 10px">
            <span style="font-size:22px;margin-left:10px;color:#494d59;margin-top: 2px"><img style="margin-left:1.5%" src="../img/commonTheme/theme6/icon_summary.png" alt=""><span style="margin-left: 10px">领导分配计划</span></span>
        </div>
    </div>
    <hr>
    <%--筛选查询--%>
    <form class="layui-form" action="">
        <div class="query" style="display: flex" >
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: -5px">子任务名称</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: -5px">关注等级</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: -5px">周期类型</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: -5px">计划类型</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: -5px">所属部门</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="margin-top: -5px">子任务状态</label>
                <div class="layui-input-block">
                    <input style="height: 30px;width: 80px" type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>

            <button type="button" class="layui-btn layui-btn-sm" style="margin-left:8%">查询</button>
        </div>
    </form>
    <hr style="margin-top: -8px">
    <div id="all">
        <%--左侧树--%>
        <div class="con_left">
            <div class="layui-card" style="height: 100%;">
                <div class="layui-card-body" style="height: 100%; padding-bottom: 20px; box-sizing: border-box;">
                    <ul id="projectList" class="left_List" lay-filter="projectList" style="overflow:auto; height:100%">
                    </ul>
                </div>
            </div>
        </div>
        <%--右侧数据--%>
        <div class="project_info">
            <div class="layui-card-body clearfix">
                <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                    <ul class="layui-tab-title">
                        <li class="layui-this">领导分配关键任务</li>
                        <li>领导分配子任务</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item">
                            <table id="targetTable" lay-filter="targetTable"></table>
                        </div>
                        <div class="layui-tab-item">
                            <table id="taskTable" lay-filter="taskTable"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

</body>
<%--js--%>
<script>
    var elTree, targetTable,taskTable,table,layer,laydate,form,eleTree;
    layui.use(["table",'eleTree','layer','form','laydate'],function(){
        table = layui.table;
        eleTree = layui.eleTree;
        layer = layui.layer;
        form = layui.form;
        laydate = layui.laydate;
//        初始化左侧树
        elTree = eleTree.render({
            elem: '#projectList',
            showLine: true, // 显示连接线
            url: '/department/getChDeptfq',
            //expandOnClickNode: false, // 禁止点击节点关闭显示子节点
            highlightCurrent: true, // 选中高亮
            where:{
                deptId:0
            },
            request: { // 修改数据为组件需要的数据
                name: "deptName", // 显示的内容
                key: "deptId", // 节点id
                parentId: 'deptParent', // 节点父id
                isLeaf: 'isLeaf', // 是否有子节点
                children:'child',
            },
            response: { // 修改响应数据为组件需要的数据
                statusName: "flag",
                statusCode: true,
                dataName: "obj"
            },
        })
//        树节点点击事件
        eleTree.on('nodeClick(projectList)',function (obj) {
//            渲染右侧的表格
            console.log(1)
            targetTableInit();
            taskTableInit();
        })
//        领导分配关键任务表格
        function targetTableInit(data) {
            targetTable = table.render({
                url:'',
                toolbar:'#toolbarDemo',
                elem:'#targetTable',
                cellMinWidth:150,
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": res.flag ? 0 : 1,
                        "msg": res.msg,
                        "data": res.obj
                    }
                },
                cols:[[
                    {field:'',title:'关键任务名称',align:'center'},
                    {field:'',title:'关键任务分类',align:'center'},
                    {field:'',title:'关键任务分类',align:'center'},
                    {field:'',title:'关键任务分类',align:'center'},
                    {field:'',title:'关键任务分类',align:'center'},
                    {field:'',title:'关键任务分类',align:'center'},
                    {field:'',title:'操作',toolbar:'#barDemo',align:'center'}
                ]]
            })
        }
//        领导分配子任务表格
        function taskTableInit(data) {
            taskTable = table.render({
                url:'',
                toolbar:'#toolbarDemo',
                elem:'#taskTable',
                cellMinWidth:150,
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": res.flag ? 0 : 1,
                        "msg": res.msg,
                        "data": res.obj
                    }
                },
                cols:[[
                    {field:'',title:'子任务名称',align:'center'},
                    {field:'',title:'子任务分类',align:'center'},
                    {field:'',title:'子任务分类',align:'center'},
                    {field:'',title:'子任务分类',align:'center'},
                    {field:'',title:'子任务分类',align:'center'},
                    {field:'',title:'子任务分类',align:'center'},
                    {field:'',title:'操作',toolbar:'#barDemo',align:'center'}
                ]]
            })
        }
    })
</script>
</html>
