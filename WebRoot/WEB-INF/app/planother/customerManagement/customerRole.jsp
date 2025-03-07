

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>知识库-客户角色管理</title>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20190817.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/js/limstree.js?v=2019080601" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <%--<script type="text/javascript" src="/lims/layer/layer.js?20201106"></script>--%>


    <style>
        .layui-card-header {
            border-bottom: 1px solid #eee;
        }

        .inbox {
            padding: 10px;
            padding-right: 30px;
        }

        .deptinput {
            display: inline-block;
            width: 75%;
        }

        .layui-btn {
            margin-left: 10px;
        }

        .layui-btn .layui-icon {
            margin-right: 0px;
        }

        .red {
            color: red;
            font-size: 16px;
        }

        .layui-form-label {
            padding: 8px 15px;
        }
        .laytable-cell-1-0-4,.laytable-cell-1-0-5{
            overflow: visible;
        }
        #addTableDiv .laytable-cell-2-0-3{
            overflow: visible;
        }

    </style>
    <style>
        /*  lr 添加   */
        #addTableButton ,#ready{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
        }
        #syncactive{
            width: 90px;
            margin-top: 20px;
            margin-left: 16px;
        }
        #deleteButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
            background-color: #ff5722;
        }
        #saveTbleButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 89%;
            display: none;
        }
        .layui-table-sort{
            margin-left: -5px;
        }
        #outTableButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
        }
        #redTableButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
        }
    </style>
    <style>

        .layui-btn {
            margin-left: 10px;
        }
        .inbox{
            padding: 10px;
            padding-right: 30px;
        }
        .layui-btn .layui-icon {
            margin-right: 0px;
        }

        #addTableButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
        }
        #deleteButton{
            width: 70px;
            margin-top: 20px;
            margin-left: 16px;
            background-color: #ff5722;
        }
        #saveTbleButton{
            width: 70px;
            margin-top: 20px;
            display: none;
            position: absolute;
            right: 3%;
        }

        .layui-collapse{
            margin-top: 15px;
        }

        .layui-table, .layui-table-view{
            margin: 0;
        }

        .laytable-cell-2-0-2{
            overflow: visible !important;
        }

        .laytable-cell-2-0-4{
            overflow: visible !important;
        }
        .layui-table-box {
            overflow: visible !important;
        }

        /*.layui-table-body {*/
        /*    overflow: visible !important;*/
        /*}*/
        .layui-colla-item{
            position: relative;
        }
        .gnbox{
            position: absolute;
            right: 5px;
            top:12px;
            margin-right: 10px;
            z-index: 88;
        }

        .ydel{
            margin-left: 5px;
        }

        .deptinput{
            display: inline-block;
            width: 75%;
        }
        .layui-btn{
            margin-left: 10px;
        }
        .layui-btn .layui-icon{
            margin-right: 0px;
        }
        td .layui-form-select {
            margin-top: -10px;
            margin-left: -15px;
            margin-right: -15px;
        }
        .red{
            color: red;
            font-size: 16px;
        }
        .layui-form-label{
            padding: 8px 15px;
        }
        #addTableDivp td[data-field="columnName"] .layui-table-cell .layui-input.layui-unselect,
        #addTableDiv td[data-field="columnName"] .layui-table-cell .layui-input.layui-unselect{
            height: 100%;
        }
        .layui-table-click{
            background-color: inherit;
        }
        .bgss{
            background-color: #e8f4fc;
        }
        .layui-disabled, .layui-disabled:hover{
            color: rgb(102, 102, 102)!important;
        }
        .layui-treeSelect .ztree li span.button.switch{
            top: -10px!important;
        }
        .disable{
            pointer-events: none;
            cursor: not-allowed!important;
        }
        .disabled:hover{
            cursor:not-allowed!important;
        }

        .eleTree-node-content-label{
            display: inline-block;
            width:99%!important;
        }
        .ele1 div.eleTree-node:nth-child(1){
            overflow: hidden;
        }

        .eleTree-node-content-label{
            display: inline-block;
            width:99%!important;
        }
        .ele1 div.eleTree-node:nth-child(1){
            overflow: hidden;
        }
        #addTableDivp td[data-field="columnName"] .layui-table-cell,
        #addTableDiv td[data-field="columnName"] .layui-table-cell{
            overflow: visible !important;
        }
        /*.layui-form-select dl dd, .layui-form-select dl dt{*/
        /*line-height: 21px;*/
        /*}*/
        .disable{
            pointer-events: none;
            cursor: default;
        }

        .textAreaBox{
            width: 100%;
            max-width: 100%;
            cursor: pointer;
            margin: 0px;
            overflow-y:visible;
            min-height: 37px;
        }
    </style>
</head>
<body>


<div class="mbox">
    <div class="layui-card">
        <div class="layui-card-body" id="addTableDivp">
            <table id="Settlement" lay-filter="SettlementFilter"></table>
        </div>
    </div>
</div>

<script type="text/html" id="barOperation">
    <a data-type="1" class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="info">详情</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script type="text/html" id="toolbar">
    <a data-type="0" class="layui-btn layui-btn-sm" lay-event="add">新增</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del2">删除</a>
</script>

<script type="text/javascript">
    var data=[];

    layui.use(['table', 'layer', 'form','treeSelect','eleTree'], function () {
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var treeSelect = layui.treeSelect;
        var eleTree = layui.eleTree;

        //第一个实例
        var tableIns = table.render({
            elem: '#Settlement'
            ,url: '/clientRole/getAllRoleColumn' //数据接口
            ,page: true //开启分页
            ,toolbar:'#toolbar'
            ,cols: [[ //表头
                {type: 'checkbox'}
                ,{type: 'numbers', title: '序号', width: 50}
                ,{field: 'roleName', title: '角色名称',width: 100}
                ,{field: 'roleName', title: '授权开始时间',width: 120}
                ,{field: 'roleName', title: '授权结束时间',width: 120}
                ,{field: 'roleName', title: '是否允许线上咨询',width: 150}
                ,{field: 'roleName', title: '线上咨询开始时间',width: 150}
                ,{field: 'roleName', title: '线上咨询结束时间',width: 150}
                ,{field: 'roleName', title: '是否允许浏览知识模板',width: 180}
                ,{field: 'roleName', title: '开始浏览时间',width: 120}
                ,{field: 'roleName', title: '结束浏览时间',width: 120}
                ,{width:180, title: '操作',align:'center',toolbar:'#barOperation',fixed:'right'}
            ]]
            ,limit:10
            ,done:function(obj){

            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.data //解析数据列表
                };
            }
        });

        //头工具栏事件
        table.on('toolbar(SettlementFilter)', function(obj){
            //var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 1
                        ,title: ['新增', 'font-size:18px;']
                        ,maxmin:true
                        ,area: ['80%', '80%'] //宽高
                        ,btn:['保存','关闭']
                        ,content:'<div id="boxfo" class="layui-form" style="width: 100%;margin: 0 auto;">'+
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">角色名称</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                            '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div><br>\n' +
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">授权开始时间</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">授权结束时间</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                            '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">是否允许线上咨询</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div><br>\n' +
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">线上咨询开始时间</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                            '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">线上咨询结束时间</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">是否允许浏览知识模板</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                            '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div><br>\n' +
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">开始浏览时间</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                            '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                            '    <div class="layui-inline" style="width: 98%;">\n' +
                            '        <label class="layui-form-label" style="width: 30%;">结束浏览时间</label>\n' +
                            '        <div class="layui-input-inline" style="width: 55%;">\n' +
                            '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                            '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</div>\n' +
                        '</div>'
                        ,success: function () {

                        }
                        ,yes: function (index, layero) {
                            var childData = $(layero).find("iframe")[0].contentWindow.getDate();
                            $.ajax({
                                url: '/pubOrgManage/addOrg',
                                dataType: 'json',
                                type: 'post',
                                data: childData,
                                success: function (res) {
                                    if (res.code === 0 || res.code === "0") {
                                        layer.msg(res.msg, {icon: 1});
                                        tabInit.reload()
                                        layer.close(index)
                                    } else {
                                        layer.msg(res.msg, {icon: 0});
                                    }
                                }
                            })
                        }, btn2: function (index, layero) {
                            layer.close(index);
                        }
                    });
                    break;
                case 'del2':
                    var data = table.checkStatus("clientCustomer").data;
                    if(data.length>0){
                        layer.confirm('确定要删除吗', function(index){
                            var ids = "";
                            for(var i=0;i<data.length;i++){
                                ids+=data[i].orgId+","
                            }
                            $.ajax({
                                url:'/pubOrgManage/delOrg',
                                data:{ids:ids},
                                success:function(res){
                                    layer.msg(res.msg);
                                    tabInit.reload()
                                }
                            })
                            layer.close(index);
                        });
                    }else{
                        layer.msg('请选中后删除');
                    }
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(SettlementFilter)', function(obj){
            var data = obj.data;
            console.log(obj)
            if(obj.event === 'edit'){
                console.log(obj.data.orgId)
                layer.open({
                    type: 1
                    ,title: ['编辑', 'font-size:18px;']
                    ,maxmin:true
                    ,area: ['80%', '80%'] //宽高
                    ,btn:['保存','关闭']
                    ,content: '<div id="boxfo" class="layui-form" style="width: 100%;margin: 0 auto;">'+
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">角色名称</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div><br>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">授权开始时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">授权结束时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">是否允许线上咨询</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div><br>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">线上咨询开始时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">线上咨询结束时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">是否允许浏览知识模板</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div><br>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">开始浏览时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">结束浏览时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '</div>'
                    ,success: function () {

                    }
                    ,yes: function (index, layero) {
                        var childData = $(layero).find("iframe")[0].contentWindow.getDate();
                        $.ajax({
                            url: '/pubOrgManage/editOrg?orgId=' + data.orgId,
                            dataType: 'json',
                            type: 'post',
                            data: childData,
                            success: function (res) {
                                if (res.code === 0 || res.code === "0") {
                                    //layer.msg("更新成功",{icon:1});
                                    layer.msg(res.msg, {icon: 1});
                                    tabInit.reload()
                                    layer.close(index)
                                } else {
                                    //layer.msg("更新成功",{icon:1});
                                    layer.msg(res.msg, {icon: 0});
                                }
                            }
                        })
                    }, btn2: function (index, layero) {
                        layer.close(index);
                    }
                });
            }else if(obj.event === 'info'){
                layer.open({
                    type: 1
                    ,title: ['详情', 'font-size:18px;']
                    ,maxmin:true
                    ,area: ['80%', '80%'] //宽高
                    ,btn:['关闭']
                    ,content: '<div id="boxfo" class="layui-form" style="width: 100%;margin: 0 auto;">'+
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">角色名称</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div><br>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">授权开始时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">授权结束时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">是否允许线上咨询</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div><br>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">线上咨询开始时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">线上咨询结束时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">是否允许浏览知识模板</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div><br>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">开始浏览时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="planingNo" lay-verify="required" name="planingNo" autocomplete="off" class="layui-input disab">\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '<div class="layui-form-item" style="width: 47%;margin:10px 0;display: inline-block">\n' +
                        '    <div class="layui-inline" style="width: 98%;">\n' +
                        '        <label class="layui-form-label" style="width: 30%;">结束浏览时间</label>\n' +
                        '        <div class="layui-input-inline" style="width: 55%;">\n' +
                        '            <input type="text" id="projectName"  lay-verify="required" autocomplete="off" style="height: 38px !important;" class="layui-input disab">\n' +
                        '            <%--<select id="projectName" name="projectName"></select>--%>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</div>\n' +
                        '</div>'
                    ,success: function () {

                    }
                    ,yes: function(index, layero){
                        layer.close(index)
                    }
                });
            }else if(obj.event === 'del') {
                var data = table.checkStatus("clientCustomer").data;
                layer.confirm('确定要删除吗', function (index) {
                    var ids = "";
                    for (var i = 0; i < data.length; i++) {
                        ids += data[i].orgId + ","
                    }
                    $.ajax({
                        url: '/pubOrgManage/delOrg',
                        data: {ids: ids},
                        success: function (res) {
                            layer.msg(res.msg);
                            tabInit.reload()
                        }
                    })
                    layer.close(index);
                });
            }
        });
    });
    //判断是否是undefined
    function undefind_nullStr(value) {
        if(value==undefined){
            return ""
        }
        return value
    }

</script>

</body>


</html>