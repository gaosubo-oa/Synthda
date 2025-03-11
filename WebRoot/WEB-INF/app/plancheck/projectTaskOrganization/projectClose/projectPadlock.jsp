<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-05-05
  Time: 11:05
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
<!DOCTYPE html >
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>项目关闭</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css?2019101815.40">
    <link rel="stylesheet" href="/lib/layui/layui/css/treeTable.css?2019101815.17">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/modules/layer/default/layer.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <style>
        hr{
            margin: 5px 0px;
        }
        .query .layui-form-item{
            width: 16%;
            margin-bottom: -5px;
            margin-top: 5px;
        }
        .query .layui-form-label{
            width: 60px;
        }
        .query .layui-input-block{
            margin-left: 90px;
            width: 120px;
        }
        .inputs .layui-form-select .layui-input{
            height: 35px; !important;
        }
        .query button{
            width: 70px;
        }
        .icon{
            background: #009688;
            display: inline-block;
            width: 40px;
            height: 30px;
            margin-top: 5px;
            margin-left: 20px;
            font-size: 25px;
            text-align: center;
            color: #fff;
            border-radius: 2px;
        }
        .laytable-cell-1-0-3,.laytable-cell-3-0-3{
            width: 400px !important;

        }
        .layui-table-tool{
            padding: 0;
            min-height: 38px;
            height: 38px;
        }
        tbody>tr{
            height: 38px;
        }
        .layui-table-cell{
            text-overflow:inherit;
        }
        .ew-tree-table-tool-right{
            display: none;
        }
        .ew-tree-table .ew-tree-table-tool{
            padding-right: 0 !important;
        }
        .query{
            position: relative;
        }
        .search,.clear,.icon{
            position: absolute;
        }
        .search{
            right: 151px;;
        }
        .clear{
            right: 59px;
        }
        .icon{
            right: 0;
        }
    </style>
</head>

<div class="container">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin: 0;padding-top: 5px;">
        <div class="layui-tab-content" style="padding: 0px 8px">
            <div class="layui-tab-item layui-show">
                <form class="layui-form" action="">
                    <div class="query" style="display: flex; margin-left: -18px;">
                        <div class="layui-form-item">
                            <label class="layui-form-label">项目名称</label>
                            <div class="layui-input-block">
                                <input style="height: 35px" type="text" name="projectName" required  lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item inputs">
                            <label class="layui-form-label" >所属单位</label>
                            <div class="layui-input-block" >
                                <select  name="deptName" class="deptName" lay-verify="required" >
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-form-item inputs">
                            <label class="layui-form-label" >项目地点</label>
                            <div class="layui-input-block" >
                                <input style="height: 35px" type="text" name="projectPlace" required  lay-verify="required" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item inputs">
                            <label class="layui-form-label" >项目类型</label>
                            <div class="layui-input-block" >
                                <select  name="projectType" class="projectType" lay-verify="required" >
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label" style="position: relative; top: 5px;">中标时间</label>
                            <div class="layui-input-inline" style="width: 120px; position: relative;top: 5px;">
                                <input style="height: 35px" type="text" name="wDate" class="layui-input wDate" id="test11" required lay-verify="required" autocomplete="off" placeholder="">
                            </div>
                        </div>

                        <button type="button" class="layui-btn layui-btn-sm search" style="margin-left: 3%;margin-top: 5px;">查询</button>
                        <button type="button" class="layui-btn layui-btn-sm clear" style="margin-left: 20px;margin-top: 5px;">重置</button>
                        <i class="layui-icon layui-icon-spread-left icon"></i>
                    </div>
                </form>
                <div class="project">
                    <table id="project" lay-filter="project"></table>
                </div>
                <div style="display: none" class="theChildPlan">
                    <table id="theChildPlan" lay-filter="theChildPlan"></table>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="barDemo">
    <div style="position:absolute;right: 0%; margin-top: 3px">
        <a class="layui-btn layui-btn-sm" lay-event="">经验总结</a>
        <a class="layui-btn layui-btn-sm" lay-event="">归档</a>
        <a class="layui-btn layui-btn-sm" lay-event="">转模板</a>
    </div>
</script>
<script type="text/html" id="childDemo">
    <div >
        <span style="font-size: 20px;"><i class="layui-icon layui-icon-prev" style="color: green;margin-right: 9px;"></i><span class="titleSp"></span></span>
        <a class="layui-btn layui-btn-sm" style="float: right;margin-left: 10px;" lay-event="disagree">经验总结</a>
        <a class="layui-btn layui-btn-sm" style="float: right;margin-left: 10px;" lay-event="consent">归档</a>
        <a class="layui-btn layui-btn-sm" style="float: right;margin-left: 10px;" lay-event="consent">转模板</a>
    </div>
</script>

<script>
    var projectStatus
    layui.use(['treeTable', 'table', 'layer', 'form', 'element', 'laydate', 'upload',], function () {
        var table = layui.table,
            form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            upload = layui.upload,
            treeTable = layui.treeTable,
            element = layui.element;
        layui.form.render();
        //年范围
        laydate.render({
            elem: '#year'
            , type: 'year'
        });
        //自定义格式
        laydate.render({
            elem: '#test11'
            ,format: 'yyyy年MM月dd日'
        });
        //年月范围
        laydate.render({
            elem: '#month'
            , type: 'month'
        });
        // 所属单位的ajax
        $.ajax({
            url: '/department/getDeptTop',
            dataType: 'json',
            type: 'get',
            success: function (res) {
                var obj = res.obj
                var str = ''
                for (var i = 0; i < obj.length; i++) {
                    str += '<option value="' + obj[i].deptId + '">' + obj[i].deptName + '</option>'
                }
                $('.deptName').append(str)
                form.render('select');
            }
        })
        // 计划类型的ajax
        $.ajax({
            url: '/Dictonary/selectDictionaryByNo?dictNo=PLAN_TYPE',
            // url: '/Dictonary/selectDictionaryByNo?dictNo=PROJECT_TYPE',
            dataType: 'json',
            type: 'get',
            success: function (res) {
                var obj = res.data
                var str = ''
                for (var i = 0; i < obj.length; i++) {
                    str += '<option value="' + obj[i].dictId + '">' + obj[i].dictName + '</option>'
                }
                $('[name="projectType"]').append(str)
                form.render('select');
            }
        })
        // 项目类型的ajax
        $.ajax({
            // url: '/Dictonary/selectDictionaryByNo?dictNo=PLAN_TYPE',
            url: '/Dictonary/selectDictionaryByNo?dictNo=PROJECT_TYPE',
            dataType: 'json',
            type: 'get',
            success: function (res) {
                var obj = res.data
                var str = ''
                for (var i = 0; i < obj.length; i++) {
                    str += '<option value="' + obj[i].dictNo + '">' + obj[i].dictName + '</option>'
                }
                $('[name="projectType"]').append(str)
                form.render('select');
            }
        })
        element.on('tab(docDemoTabBrief)', function (elem) {

            if (elem.index == 0) {
                $('.rep').text('上报')
            } else if (elem.index == 1) {
                $('.rep').text('计划调整')
            }
        });
        var projectTable = table.render({
            elem: '#project'
            , url: '/ProjectInfo/ProjectCloseSearch?projectStatus=1'
            // , url: '/ProjectInfo/ProjectCloseSearch' //数据接口
            , page: true //开启分页
            , toolbar: '#barDemo'
            , defaultToolbar: ['']
            , cols: [[ //表头
                {type: 'checkbox'}
                , {field: 'orderId', title: '序号', width: 60, align: 'center'}
                , {field: 'projectNo', title: '项目编号', width: 150, align: 'center'}
                , {
                    field: 'projectName',
                    title: '项目名称',
                    align: 'center',
                    event: 'projectDetail',
                    style: 'cursor: pointer;',//手
                    templet: function (d) {
                        return '<a class="nameClick" style="color: blue;text-decoration: underline;">' + d.projectName + '</a>'
                    }
                }
                , {field: 'projectAbbreviation', title: '项目简称', width: 150, align: 'center'}
                , {field: 'projectPlace', title: '项目地点', width: 150, align: 'center'}
                // , {field: 'deptName', title: '所属单位', width: 150, align: 'center'}
                , {field: 'ownerUnit', title: '所属单位', width: 150, align: 'center'}
                , {field: 'statrtTime', title: '计划开始时间', width: 150, align: 'center'}
                , {field: 'endTime', title: '计划结束时间', width: 150, align: 'center'}
                , {field: 'contractDuration', title: '计划工期', width: 150, align: 'center'}
                , {field: 'projectTypeName', title: '项目类型', width: 150, align: 'center'}
                , {field: 'projectManage', title: '项目经理', width: 150, align: 'center'}
                //      ,{title: '操作',align:'center', toolbar: '#barDemo',width:260}
            ]]
        });

        $(document).on('click', '.nameClick', function () {
            // var projectId = $(this).attr('projectId')
            //  initTaskTable(projectId)
            $('.titleSp').text($(this).text())
            $('.theChildPlan').show();
            $('.project').hide();
        });

        //监听行单击事件（双击事件为：rowDouble）
        table.on('row(project)', function(obj) {
            var data = obj.data;
            var projectId = data.projectId
            initTaskTable(projectId)
            console.log(data)
        });

        function initTaskTable(projectId) {
            console.log(projectId)
            treeTable.render({
                elem: '#theChildPlan'
                , url: '/plcProjectBag/queryBag'
                , where: {
                    parentPbagId:0,
                    projectId:projectId,
                }
                , page: true //开启分页
                , toolbar: '#childDemo'
                , defaultToolbar: ['']
                , tree: {
                    iconIndex: 2,
                    isPidData: true,
                    idName: 'id',
                    childName: 'children'
                }
                , cols: [[ //表头
                    {type: 'checkbox'},
                    {type: 'numbers', title: '序号', width: 70},
                    {field: 'tgNo', title: '编码'},
                    {
                        field: 'pbagName', title: '项目名称', width: 200,align: 'center', templet: function (d) {
                            return '<span class="pbagName"  id="' + d.id + '">' + d.pbagName + '</span>'
                        }}
                    , {field: 'dutyUser', title: '完成量'}
                    , {field: 'dutyDeptName', title: '单位'}
                    , {field: 'controlLevel', title: '关注等级'}
                    , {field: 'pbagTarget', title: '前置子任务'}
                    , {field: 'planBeginDate', title: '计划开始时间',templet: function(d){
                            return format(d.planBeginDate)
                        }}, {field: 'planEndDate', title: '计划结束时间',templet: function(d){
                            return format(d.planEndDate)
                        }}, {field: 'planPeriod', title: '计划工期'}
                    , {field: 'resultStandard', title: '完成标准', edit: 'text'}
                ]], parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.obj //解析数据列表
                    };
                },
            });
        }

        table.on('toolbar(project)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            if (checkStatus.data.length == 0) {
                layer.msg('最少选中一项!');
                return false;
            }
            var ids = ''
            for (var i = 0; i < checkStatus.data.length; i++) {
                ids += checkStatus.data[i].projectId + ','
            }
            switch (obj.event) {
                case 'consent':
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['500px', '240px'], //宽高
                        title: '意见标签',
                        content: '<div>' +
                            '<textarea style="width:498px;height: 118px;" class="targetApprivalComment"></textarea></div>',
                        btn: ['确定', '取消'],
                        yes: function (index) {
                            $.ajax({
                                url: '/ProjectInfo/updateStatus',
                                data: {
                                    ids: ids,
                                    targetApprivalStatus: 1,
                                    targetApprivalComment: $('.targetApprivalComment').val()
                                },
                                dataType: 'json',
                                success: function (res) {
                                    layer.closeAll();
                                    $.layerMsg({content: '成功！', icon: 1});
                                }
                            })
                        }
                    })
                    break;
                case 'disagree':
                    layer.open({
                        type: 1,
                        skin: 'layui-layer-rim', //加上边框
                        area: ['500px', '240px'], //宽高
                        title: '意见标签',
                        content: '<div>' +
                            '<textarea style="width:498px;height: 118px;"></textarea></div>',
                        btn: ['确定', '取消'],
                        yes: function (index) {
                            $.ajax({
                                url: '/ProjectInfo/updateStatus',
                                data: {
                                    ids: ids,
                                    targetApprivalStatus: 2,
                                    targetApprivalComment: $('.targetApprivalComment').val()
                                },
                                dataType: 'json',
                                success: function (res) {
                                    layer.closeAll();
                                    $.layerMsg({content: '成功！', icon: 1});
                                }
                            })
                        }
                    })
                    break;
            }
        });
        $('.clear').on('click',function () {
            $('input').val('');
            $('select').val('');
            form.render();
        });

        $(document).on('click', '.titleSp', function () {
            $('.theChildPlan').hide();
            $('.project').show();
        });
        $('.show').on('click',function () {
            $('.theChildPlan').hide();
            $('.project').show();
        });
        //项目查询
        $('.search').on('click',function () {
            projectTable.reload({
                url:'/ProjectInfo/ProjectCloseSearch?projectStatus=3',
                where:{
                    projectName:$('input[name="projectName"]').val(),
                    projectPlace:$('input[name="projectPlace"]').val(),
                    //所属单位
                    ownerUnit:$('.deptName').val(),
                    projectType:$('.projectType').val(),
                    wDate:$('#wDate').val()
                }
            })
        })
        //将毫秒数转为yyyy-MM-dd格式时间
        function format(t) {
            if (t) return new Date(t).Format("yyyy-MM-dd");
            else return ''
        }
    })

</script>
</body>
</html>
