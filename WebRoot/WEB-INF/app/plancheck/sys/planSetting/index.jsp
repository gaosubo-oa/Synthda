<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>计划期间设置</title>
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
        .ztree *{
            font-size: 11pt!important;
        }
        #questionTree li{
            border-bottom:1px solid #ddd;
            line-height: 40px;
            padding-left: 10px;
            cursor:pointer;
            border-radius: 3px;
        }
        .select{
            background: #c7e1ff;
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>
    <%--    <link rel="stylesheet" href="/duplopages/manage/standard/form/css/treeselect.css"/>--%>
</head>
<body>
<div style="margin-top: 5px;position: relative;">
    <img src="../../img/addcodemain.png" style="position: absolute;left: 22px;top:4px "><span style="margin-left: 49px;font-size: 20px;">计划期间设置</span>
</div>
<%--蓝色分割线--%>
<hr class="layui-bg-blue" style="height: 5px">
<div class="layui-fluid" id="LAY-app-message">
    <input type="hidden" id="sortId">
    <div class="layui-row ">
        <div class="layui-lf" style="width:250px;float:left">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight" style="height:650px;">
                    <div style="margin-bottom:10px">
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="addPlan" >新建</button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm add" id="editPlan"  >修改</button>
                        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm del"  id="delPlan"  >删除</button>
                    </div>
                    <ul id="questionTree"  style="overflow:auto;height:100%">
                        <li class="select" >2020年</li>
                        <li >2019年</li>
                        <li >2018年</li>
                        <li >2017年</li>
                        <li >2016年</li>
                    </ul>

                </div>
            </div>
        </div>
        <div class="layui-rt " style="width:calc(100% - 250px);float:left">
            <div class="layui-card rightHeight" style="padding-left: 11px;">

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
                                    <%--<div style="line-height: 38px;">--%>
                                    <%--<img style="    width: 23px;" src="/img/plancheck/icon.png" alt="" >--%>
                                    <%--<span id="title" style="    font-size: 14pt;vertical-align: middle">计划期间设置</span>--%>
                                    <%--</div>--%>
                                    <%--                    <div style="text-align: right">--%>
                                    <%--                       --%>
                                    <%--                    </div>--%>
                                    <fieldset class="layui-elem-field">
                                        <legend>计划期间查询</legend>
                                        <div class="layui-field-box">
                                            <form class="layui-form" action="">

                                                <div class="layui-form-item">
                                                    <div class="layui-inline" style="">
                                                        <label class="layui-form-label" style="width:80px;">年份</label>
                                                        <div class="layui-input-inline" style="width: 150px;">
                                                            <input type="text" value="2020" id="year" name="price_min" placeholder="" autocomplete="off"  class="layui-input user">
                                                        </div>
                                                    </div>
                                                    <div class="layui-inline">
                                                        <button type="button" class="layui-btn search layui-btn-sm">查询</button>
                                                        <%--<button type="button" class="layui-btn  layui-btn-sm" id="addMonth">新增</button>--%>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </fieldset>
                                        <div class="layui-inline">
                                            <button type="button" class="layui-btn layui-btn-sm layui-btn-primary " id="addMonth" lay-event="add">新增</button>
                                        </div>
                                    <div>
                                        <table id="questionTable" lay-filter="questionTable-table"></table>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<script id="toolbar" type="text/html" lay-filter="btn">--%>
                    <%--<button type="button" class="layui-btn layui-btn-sm layui-btn-primary " id="addMonth" lay-event="add">新增</button>--%>
                <%--</script>--%>
                    <script id="barOperation" type="text/html" lay-filter="toolBtn">
                        <button type="button" class="layui-btn  layui-btn-xs layui-btn-danger "  lay-event="del">删除</button>
                    </script>
                </div>
            </div>
        </div>
    </div>
    <script id="barOperation" type="text/html" lay-filter="toolBtn">
        <%--        <button type="button" class="layui-btn  layui-btn-xs"  lay-event="preview">预览</button>--%>
        <button type="button" class="layui-btn  layui-btn-xs layui-btn-danger "  lay-event="del">删除</button>
    </script>
</div>
</body>
</html>
<script>
    var form
    var height = $(window).height()
    $('#leftHeight').height(height-30)
    $('.rightHeight').height(height-30)
    var type = $.GetRequest().type;
    var dataType = $.GetRequest().dataType;
    var shitiType=''
    $('#questionTree li').click(function(){
        var url = $(this).attr('url');
        $(this).addClass('select').siblings().removeClass('select')
        $('iframe').attr('src',url)
    })
    layui.use(['table','layer','laydate','form','element','eleTree'], function(){
        var table = layui.table;
        var layer = layui.layer;
        form = layui.form;
        var laydate = layui.laydate;
        var eleTree = layui.eleTree;
        var element = layui.element;

        form.render();



    })

    //左侧新建
    $('#addPlan').click(function(){
        create(0,'')
    })
    $('#editPlan').click(function(){
        var id = $('.select').attr('id');
        create(1,id)
    })
    //    新建编辑共有函数
    function create(type,id){
        if(type=='0'){
            var title = '添加字典'
            // var url = '/planTtemplate/savePlanTemp'
        }else{
            var title = '编辑'
            // var url = '/planTtemplate/upPlanTemp'
        }
        layer.open({
            type: 1,
            title: title,
            shadeClose: true,
            btn:['确定','取消'],
            shade: 0.5,
            maxmin: true, //开启最大化最小化按钮
            area: ['500px', '300px'],
            content:' <div class="layui-form" >' +
                '<div class="layui-form-item"style="width: 80%;margin-top: 8%;">\n' +
                '    <label class="layui-form-label">字典名称:</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="title" required  lay-verify="required" placeholder="请输入字典名称" autocomplete="off" class="layui-input">\n' +
                '    </div>\n' +
                '  </div>' +
                '<div class="layui-form-item" style="width: 80%;">\n' +
                '    <label class="layui-form-label">备注说明:</label>\n' +
                '    <div class="layui-input-block">\n' +
                '      <input type="text" name="title" required  lay-verify="required" placeholder="请输入备注说明" autocomplete="off" class="layui-input">\n' +
                '    </div>\n' +
                '  </div>' +
                '</div>',
            success:function(){

                if(type==1){
                    $.ajax({
                        url:'/planTtemplate/selectPlanTempById',
                        type:'get',
                        data:{plteId:id},
                        dataType:'json',
                        success:function(res){
                            $('[name="tempExplain"]').val(res.object.tempExplain),
                                $('[name="tempNo"]').val(res.object.tempNo),
                                $('[name="remarks"]').val(res.object.remarks),
                                $('[name="tempName"]').val(res.object.tempName),
                                /*$('[name="businessType"]').val(res.object.businessType),
                               $('[name="projectType"]').val(res.object.projectType),
                                $('[name="projectScale"]').val(res.object.projectScale)*/
                                $('[name="businessType"] option:contains(' + res.object.businessType+ ')').attr("selected",true);
                            $('[name="projectType"] option:contains(' + res.object.projectType + ')').attr("selected",true);
                            $('[name="projectScale"] option:contains(' + res.object.projectScale + ')').attr("selected",true);
                            form.render();
                        }
                    })
                }
                form.render();
            },
            yes:function(){
                var data={
                    tempExplain:$('[name="tempExplain"]').val(),
                    tempNo:$('[name="tempNo"]').val(),
                    remarks:$('[name="remarks"]').val(),
                    tempName:$('[name="tempName"]').val(),
                    /*  businessType:$('[name="businessType"]').val(),
                      projectType:$('[name="projectType"]').val(),
                      projectScale:$('[name="projectScale"]').val()*/
                    businessType:$('[name="businessType"] option:selected').text(),
                    projectType:$('[name="projectType"] option:selected').text(),
                    projectScale:$('[name="projectScale"] option:selected').text()
                }
                if(type==1){
                    data.plteId = id
                }
                $.ajax({
                    url:url,
                    data:data,
                    dataType:'json',
                    type:'get',
                    success:function(res){
                        if(res.flag){
                            layer.msg('保存成功',{icon:1});
                            getlis();
                            layer.closeAll();
                        }
                    }
                })
            },
            cancel:function(index){

            }
        });
    }
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

        var periodYear = document.getElementById("year").value
        var tableObj=table.render({
            elem: '#questionTable'
            ,url: '/planPeroidSetting/showAllSet'  //数据接口
            ,data: {
                periodYear: periodYear,
            }
           , parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.object //解析数据列表

                };
            }
            ,toolbar:'#toolbar'
            ,cols: [[ //表头
                {field: 'periodMonth',align:'center', title: '月份'}
                ,{field: 'startDate',align:'center', title: '起始时间'}
                ,{field: 'endDate',align:'center', title: '终止时间'}
                ,{fixed: 'right',fixed:'right', title: '操作',align:'center', toolbar: '#barOperation'}
            ]]
            ,limit:12
            ,success:function(res) {
            }

        });


        //查询
        $('.search').click(function() {
            var periodYear = document.getElementById("year").value
            if (periodYear !== undefined) {
                table.render({
                    elem: '#questionTable'
                    , url: '/planPeroidSetting/showAllSet?periodYear='+periodYear   //数据接口
                    , parseData: function(res){ //res 即为原始返回的数据
                            return {
                                "code":0, //解析接口状态
                                "data": res.object //解析数据列表
                                };
                                }
                    ,toolbar:'#toolbar'
                    ,cols: [[ //表头
                        {field: 'periodMonth',align:'center', title: '月份'}
                        ,{field: 'startDate',align:'center', title: '起始时间'}
                        ,{field: 'endDate',align:'center', title: '终止时间'}
                        ,{fixed: 'right',fixed:'right', title: '操作',align:'center', toolbar: '#barOperation'}
                    ]]
                });
            }
        })
        // $('.search').click(function(){
        //         var periodYear = document.getElementById("year").value
        //
        //         $.ajax({
        //             type: 'post',
        //             url: '/planPeroidSetting/showAllSet',
        //             dataType: 'json',
        //             data: {
        //                 periodYear: periodYear,
        //             }
        //             , parseData: function(res){ //res 即为原始返回的数据
        //         return {
        //             "code":0, //解析接口状态
        //             "data": res.object //解析数据列表
        //
        //             };
        //             },
        //             success: function (res) {
        //
        //             }
        //         })
        //     })

        // })


        // 监听工具条
        // table.on('toolbar(questionTable-table)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        //     var data = obj.data; //获得当前行数据
        //     var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
        //     var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
        //     if(layEvent === 'del'){ //删除
        //         layer.confirm('确定删除吗', function(index){
        //             $.ajax({
        //                 type: 'post',
        //                 url: '/planPeroidSetting/deletePlanPeriodSet',
        //                 dataType: 'json',
        //                 data:{periodId:data.periodId},
        //                 success: function (res) {
        //                     if(res.msg){
        //                         layer.msg('删除成功！', {icon: 1});
        //                         tableIns.reload()
        //                     }
        //                 }
        //             })
        //             layer.close(index);
        //
        //         });
        //
        //     }
        // });

        // 监听操作工具条
        table.on('tool(questionTable-table)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
            if(layEvent === 'del'){ //删除
                layer.confirm('确定要删除吗?', function(index){
                    $.ajax({
                        type: 'post',
                        url: '/planPeroidSetting/deletePlanPeriodSet',
                        dataType: 'json',
                        data:{periodId:data.periodId},
                        success: function (res) {
                            if(res.msg){
                                layer.msg('删除成功！', {icon: 1});
                                tableIns.reload()
                            }
                        }
                    })
                    layer.close(index);

                });

            }



        });

        //    新增
        $('#addMonth').click(function () {
            var periodYear = document.getElementById("year").value
            layer.open({
                type: 1,
                title: '新增',
                area: ['453px', '300px'],
                btn:['确定','取消']
                // ,toolbar:'#toolbar'
                ,maxmin:true,
                        content:'<div class="layui-card"><form class="layui-form" action="" style="margin-top: 45px;\n' +
                            '    border: none;\n' +
                            '    padding-bottom: 30px;">\n' +

                            ' <div class="layui-form-item">\n' +
                            '    <label class="layui-form-label">起始日期</label>\n' +
                            '    <div class="layui-input-block" style="width: 207px;">\n' +
                            '      <input type="text" class="layui-input" id="startDate" style="display: inline-block;width: 190px;">\n' +
                            '    </div>\n' +
                            '  </div>'+
                            ' <div class="layui-form-item">\n' +
                            '    <label class="layui-form-label">终止日期</label>\n' +
                            '    <div class="layui-input-block" style="width: 207px;">\n' +
                            '      <input type="text" class="layui-input" id="endDate" style="display: inline-block;width: 190px;">\n' +
                            '    </div>\n' +
                            '  </div>'+
                            '</form></div>',
                success:function () {
                    form.render()
                    laydate.render({
                        elem: '#startDate' //指定元素
                    })
                    laydate.render({
                        elem: '#endDate' //指定元素
                    });
                }
                ,yes:function (index) {
                    var startDate = document.getElementById("startDate").value
                    var endDate = document.getElementById("endDate").value
                    params={
                        startDate:startDate,
                        endDate:endDate,

                    }
                    $.ajax({
                        type: 'post',
                        url: '/planPeroidSetting/insertPlanPeriodSet?periodYear='+periodYear,
                    dataType: 'json',
                        data:params,
                        success: function (res) {
                            if(res.msg){
                                layer.msg('新增成功！', {icon: 1});
                                layer.close(index);
                                tableIns.reload()
                            }
                        }

                    })
                }
            });
        })




        //删除
        // function publicDeletes(url,ids,tableIns,table){
        //     layer.confirm('确定要删除吗?', {icon: 3, title:'提示'}, function(index){
        //         var data={
        //             ids:ids
        //         }
        //         var res=toAjaxT(url,data);
        //         layer.msg(res.msg)
        //         if(res.code==0){
        //             try {
        //                 if (ids.substring(ids.length - 1) == ",") {
        //                     ids = ids.substring(0, ids.length - 1);
        //                 }
        //                 var dataSize = ids.split(",");
        //                 var dataAll = table.cache[tableIns.config.id];
        //                 if (dataAll.length == dataSize.length) {
        //                     //得到当前页
        //                     var page = $(".layui-laypage-skip .layui-input").val();
        //
        //                     if (page > 1) {
        //                         tableIns.reload({
        //                             page: {
        //                                 curr: page - 1 //重新从第 1 页开始
        //                             }}
        //                         );
        //                     }else{
        //                         tableIns=tableIns.reload();
        //                     }
        //                 } else {
        //                     tableIns=tableIns.reload();
        //                 }
        //             } catch (e) {
        //                 tableIns.reload();
        //             }
        //         }
        //         layer.close(index);
        //     });
        // }
    })
</script>