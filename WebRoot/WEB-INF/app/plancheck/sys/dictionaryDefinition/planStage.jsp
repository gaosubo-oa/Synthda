<%--
  Created by IntelliJ IDEA.
  User: gsb
  Date: 2019/11/22
  Time: 17:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .layui-form-label{width:100px;}
        .layui-input-block{margin-left:130px;}
        .layui-disabled, .layui-disabled:hover{color: #797979 !important;}
        .layui-table-header .layui-table{
            width:100%
        }
        .layui-table-view .layui-table{
            width:100%
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
    <%--    <link rel="stylesheet" href="/duplopages/manage/standard/form/css/treeselect.css"/>--%>
</head>
<body>
<div class="layui-fluid" id="LAY-app-message">
    <input type="hidden" id="sortId">
    <div class="layui-row ">

        <div class="layui-card" style="width:100%;">
            <div class="layui-card">
                <style>
                    .layui-card-header .layui-icon{
                        top:auto !important;
                    }
                </style>
                <div id="queryarea_searchView"></div>


                <div class="layui-card-body">
                    <div style="line-height: 38px;">
                        <img style="    width: 23px;" src="/img/plancheck/icon.png" alt="" >
                        <span id="title" style="    font-size: 14pt;vertical-align: middle">计划阶段</span>
                    </div>
                    <table id="questionTable" lay-filter="questionTable-table"></table>
                </div>
            </div>
        </div>
    </div>
    <script id="toolbar" type="text/html" lay-filter="btn">
        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="add" lay-event="add">新建</button>
        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm del" id="del"  lay-event="del">删除</button>
        <%--        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm import" id="import" lay-event="import">导入</button>--%>
        <%--        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm import" id="outport" lay-event="outport">导出</button>--%>
    </script>
    <script id="barOperation" type="text/html" lay-filter="toolBtn">
        <%--        <button type="button" class="layui-btn  layui-btn-xs"  lay-event="preview">预览</button>--%>
        <button type="button" class="layui-btn  layui-btn-xs"  lay-event="edit">编辑</button>
        <button type="button" class="layui-btn  layui-btn-xs layui-btn-danger "  lay-event="del">删除</button>
    </script>
</div>
</body>
</html>
<script>
    var height = $(window).height()
    $('#leftHeight').height(height-30)


    layui.use(['table','layer','laydate','form','element','eleTree'], function(){
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var laydate = layui.laydate;
        var eleTree = layui.eleTree;
        var element = layui.element;
        laydate.render({
            elem: '#year' //指定元素
            ,type: 'year'
        });
        laydate.render({
            elem: '#month' //指定元素
            ,type: 'month'
        });
        form.render();



        //    获取右侧列表
        var tableObj=table.render({
            elem: '#questionTable'
            // ,url: '/exaQuestions/selectQuestion' //数据接口
            ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['prev', 'page', 'next',  'skip','count','limit',]//自定义分页布局
                ,limits:[5,10,15,20,25,30,35,40,45,50]
                ,limit:5
                ,first: false //不显示首页
                ,last: false //不显示尾页
            } //开启分页
            ,data:[{data1:'前期经营',data2:'',data3:''},
                {data1:'设计',data2:'',data3:''},
                {data1:'施工',data2:'',data3:''},
                {data1:'验收',data2:'',data3:''}]
            ,toolbar:'#toolbar'
            ,cols: [[ //表头
                {type: 'numbers', title: '序号',width:60}
                ,{field: 'data1', title: '计划类别名称'}
                ,{field: 'data2', title: '备注'}
                ,{field: 'data3', title: '功能'}
                ,{fixed: 'right',fixed:'right', title: '操作',align:'center', toolbar: '#barOperation'}
            ]]
            ,limit:10
            ,done:function(res) {

            }
        });

        //搜索
        $('.search').click(function(){
            var  currentPage=1;
            var userid=''
            if($('#user').attr('dataid')!=''&&$('#user').attr('dataid')!=undefined){
                userid = $('#user').attr('dataid').replace(',','')
            }
            table.reload('questionTable',{
                url : '/exaQuestions/selectQuestion',
                data:{page:currentPage},
                page:{
                    curr:currentPage
                },
                where:{
                    sortId:$('#sortId').val(),
                    eqSubject:$('.tigan').val(),
                    eqType:$('.ndType').val(),
                    eqStatus:$('.stType').val(),
                    createId:userid
                }
            })
        })


        //监听工具条
        table.on('toolbar(questionTable-table)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if(layEvent === 'add'){ //新建
                create(0,$('#sortId').val(),'')
            } else if(layEvent === 'del'){ //删除
                var data = table.checkStatus('questionTable').data;
                if(data.length>0){
                    var ids=''
                    for(var i=0;i<data.length;i++){
                        ids+= data[i].eqId+','
                    }
                    publicDeletes("/exaQuestions/deleteQuestion",ids,tableObj,table);
                }else{
                    layer.msg('未选中行',{icon:6})
                }

            } else if(layEvent === 'import'){ //导入
                var sortId = $('#sortId').val();
                layer.open({
                    type: 1,
                    title: '导入',
                    shadeClose: true,
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['403px', '300px'],
                    btn:['确定','取消'],
                    content:'<form id="ajaxform" method="post" class="layui-form" action="/exaQuestions/importQuestion"  enctype="multipart/form-data">\n' +
                        ' <div class="layui-form-item">\n' +
                        '    <label class="layui-form-label">下载导入模板:</label>\n' +
                        '    <div class="layui-input-block" style="line-height: 38px;">\n' +
                        '       <a href="javascript:;" id="download" style="color: #1E9FFF">试题导入模板下载</a>\n' +
                        '    </div>\n' +
                        '  </div>'+
                        ' <div class="layui-form-item">\n' +
                        '    <label class="layui-form-label">选择导入文件:</label>\n' +
                        '    <div class="layui-input-block" style="line-height: 38px;">\n' +
                        '       <input type="file" name="file" value="请选择文件"/>\n' +
                        '    </div>\n' +
                        '  </div>'+
                        '    </form>',
                    success:function(){
                        form.render();
                        $('#download').click(function(){
                            window.location.href=encodeURI('/file/jdProject/试题导入模板.xls')
                        })
                    },
                    yes:function(index){
                        if ($('input[name="file"]').val() == "") {
                            layer.msg("请选择要导入的文件！", {icon: 2});
                            return false;
                        }
                        $('#ajaxform').ajaxSubmit({
                            dataType: 'json',
                            success:function (res) {
                                if(res.code==0){
                                    layer.msg('导入成功',{icon:1});
                                }else {
                                    layer.msg('导入失败',{icon:2});
                                }
                                layer.close(index)
                            }
                        })
                    }
                });

            }
        });

        //监听操作工具条
        table.on('tool(questionTable-table)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'preview'){ //预览
                var eqId = data.eqId;
                layer.open({
                    type: 2,
                    title: '预览',
                    shadeClose: true,
                    shade: 0.5,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['893px', '90%'],
                    content:'/tbExamList/preview?id='+eqId,
                });
            } else if(layEvent === 'del'){ //删除
                var eqId = data.eqId;
                publicDeletes("/exaQuestions/deleteQuestion",eqId,tableObj,table);
            } else if(layEvent === 'edit'){ //编辑
                var eqId = data.eqId;
                create(1,$('#sortId').val(),eqId)
            }
        });

        //    新建编辑共有函数
        function create(type,sortId,id){
            if(type=='0'){
                var title = '新建'
            }else{
                var title = '编辑'
            }
            layer.open({
                type: 1,
                title: title,
                shadeClose: true,
                btn:['确定','取消'],
                shade: 0.5,
                maxmin: true, //开启最大化最小化按钮
                area: ['453px', '300px'],
                content:'<div class="layui-card"><form class="layui-form" action="" style="margin-top: 10px;\n' +
                    '    border: none;\n' +
                    '    padding-bottom: 30px;">\n' +

                    ' <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">字典名称</label>\n' +
                    '    <div class="layui-input-block" style="width: 207px;">\n' +
                    '      <input type="text" name="title" id="" required  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    ' <div class="layui-form-item">\n' +
                    '    <label class="layui-form-label">备注说明</label>\n' +
                    '    <div class="layui-input-block" style="width: 207px;">\n' +
                    '      <input type="text" name="title" required id=""  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '</form></div>',
                success:function(){
                    form.render();

                },
                cancel:function(index){

                }
            });
        }

        //        删除
        function publicDeletes(url,ids,tableIns,table){
            layer.confirm('确定要删除吗?', {icon: 3, title:'提示'}, function(index){
                var data={
                    ids:ids
                }
                var res=toAjaxT(url,data);
                layer.msg(res.msg)
                if(res.code==0){
                    try {
                        if (ids.substring(ids.length - 1) == ",") {
                            ids = ids.substring(0, ids.length - 1);
                        }
                        var dataSize = ids.split(",");
                        var dataAll = table.cache[tableIns.config.id];
                        if (dataAll.length == dataSize.length) {
                            //得到当前页
                            var page = $(".layui-laypage-skip .layui-input").val();

                            if (page > 1) {
                                tableIns.reload({
                                    page: {
                                        curr: page - 1 //重新从第 1 页开始
                                    }}
                                );
                            }else{
                                tableIns=tableIns.reload();
                            }
                        } else {
                            tableIns=tableIns.reload();
                        }
                    } catch (e) {
                        tableIns.reload();
                    }
                }
                layer.close(index);
            });
        }
    })
</script>