<%--
  Created by IntelliJ IDEA.
  User: 张继斌
  Date: 2022/1/13
  Time: 10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商务资源管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.config.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/ueditor.all.js?20200919" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/ueditor/UEcontroller.js?20200919" type="text/javascript" charset="utf-8"></script>

    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js?20201221.1" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js?20201221.1" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    #layui-laydate2 .layui-laydate-header {
        display: none;
    }
    .select{
        background-color: #FBD4B4;
    }

    element.style {
        font-size: 18px;
        width: 30%;
    }
    .layui-form-label {
        float: left;
        display: block;
        padding: 9px 15px;
        font-weight: 400;
        line-height: 20px;
        text-align: right;
    }
    .layui-table-cell {
        font-size:14px;
        padding:0 5px;
        height:auto;
        overflow:visible;
        text-overflow:inherit;
        white-space:normal;
        word-break: break-all;
    }
    .layui-layer layui-layer-page  layer-anim{
        top:10% !important
    }
</style>
<body>
<div id="box" style="display: block">
    <div class="box2">
    </div>
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <ul class="layui-tab-title">
            <li id="shan" class="layui-this">资源管理</li>
            <li id="daiqueren">类别管理</li>
        </ul>
        <div class="layui-tab-content">
            <div id="one" class="layui-tab-item layui-show">
                <div style="height: 40px;">
                    <span style="font-size: 20px;font-weight: bold;display: inline-block;margin-top: 7px;">资源管理</span>
                        <button class="layui-btn" id="add1" style="float: right;display: inline-block" type="button">新建</button>
                </div>
                <table class="layui-hide" id="test" lay-filter="test"></table>
            </div>
            <div id="two" class="layui-tab-item two">
                <div style="height: 40px;">
                    <span style="font-size: 20px;font-weight: bold;display: inline-block;margin-top: 7px;">类别管理</span>
                        <button class="layui-btn" id="add2" style="float: right;display: inline-block" type="button">新建</button>
                </div>
                <table class="layui-hide" id="test1" lay-filter="test1"></table>
            </div>
        </div>
    </div>

</div>


</table>
<script id="barDemo" type="text/html">
    <div class="long">
        <a id="detail" lay-event="detail" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">详情</a>
        <a lay-event="edit" id="edit" style="color: blue;cursor:pointer; text-decoration:underline">编辑</a>
        <a lay-event="del" id="delete" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
    </div>

</script>
<script id="barDemos" type="text/html">
    <div class="long">
        <a id="detail1" lay-event="edit" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">修改</a>
        <a id="detail1" lay-event="del" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
    </div>
</script>
<script id="barDemoss" type="text/html">
    <div class="long">
        <a id="detail1" lay-event="edits" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">修改</a>
        <a id="detail1" lay-event="dels" data-index="i" style="color: blue;cursor:pointer; text-decoration:underline">删除</a>
    </div>
</script>
</body>
<script>
    for(var i =2010;i<=2040;i++){
        $("[name='yearSel']").append('<option value="' + i + '">' + i + '</option>');
    }
    layui.use(['form', 'table', 'element', 'layedit','eleTree'], function () {
        var table = layui.table
        var form = layui.form
        var element = layui.element
        var layedit = layui.layedit
        var eleTree = layui.eleTree
        var laydate = layui.laydate;
        var attendTypeId;
        var daiqueren;
        form.render()
        // 资源管理
        var meetTable=table.render({
            elem: '#test'
            , url: '/cdmResource/selectCdmResourcePackageAll?useFlag=true'
            , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                , layEvent: 'LAYTABLE_TIPS'
                , icon: 'layui-icon-tips'
            }]
            , title: '用户数据表'
            , cols: [[
                {field: 'packageName', title: '资源包名称', width:200}
                , {field: 'classId', title: '所属分类', width:125,templet: function(res){
                        if(res.className == undefined){
                            return  ''
                        }else{
                            return res.className
                        }
                    }}
                , {field: 'packagePrice', title: '资源包价格', width:100}
                , {field: 'packageDesc', title: '资源包描述', minWidth:600}
                , {field: 'registrationUnit', title: '报名单位',event:'1',minWidth:500,templet: function(res){
                    if(res.userName == undefined){
                        return  ''
                    }else{
                        return res.userName
                    }
                    }}
                , {field: '', title: '操作', toolbar: '#barDemoss',width:100}
            ]]
            , parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.totleNum, //解析数据长度
                    "data": res.obj, //解析数据列表
                };
            }
            ,done:function(res){

            }
            , page: true
        })
        // 类别管理
            table.render({
                elem: '#test1'
                , url: '/cdmResource/selectCdmResourceClassAll?useFlag=true'
                , defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                    title: '提示'
                    , layEvent: 'LAYTABLE_TIPS'
                    , icon: 'layui-icon-tips'
                }]
                , title: '用户数据表'
                , cols: [[
                    // , {field: 'id', title: 'ID', width: 80, fixed: 'left', unresize: true, sort: true}
                    {field: 'className', title: '资源分类名称', width:250}
                    , {field: 'classDesc', title: '分类描述', minWidth:700}
                    // , {field: 'jobManageId', title: '分类包含资源包', event:'type'}
                    , {field: 'registrationUnit', title: '报名单位', minWidth:600,templet: function(res){
                            if(res.userName == undefined){
                                return  ''
                            }else{
                                return res.userName
                            }
                        }}
                    , {field: '', title: '操作', toolbar: '#barDemos',width:100}
                ]]
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "msg": res.msg, //解析提示文本
                        "count": res.totleNum, //解析数据长度
                        "data": res.obj, //解析数据列表
                    };
                }
                ,done:function(res){
                    // $("td[data-field='jobManageId'] div").text('查看资源包')
                    // $("td[data-field='jobManageId'] div").css('color','blue');
                    // $("td[data-field='jobManageId'] div").css('cursor','pointer')
                }
                , page: true
            })
        table.on('tool(test)',function(data){
            var packageId = data.data.packageId
            var classId = data.data.classId
            if(data.event == 'edits'){
                layer.open({
                    type: 1,
                    area: ['62%', '80%'], //宽高
                    title: ['修改','font-size:20px'],
                    maxmin: false,
                    offset:"100px",
                    btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
                    content: '<div style="margin: 20px auto;">' +
                        '   <form class="layui-form" action="">\n' +
                        '       <div class="layui-form-item" style="width: 43%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 22%">排序号</label>\n' +
                        '               <div class="layui-input-inline" style="width:65%">\n' +
                        '                   <input type="number" name="orderNo"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 20%">资源包名称</label><span style="color: red">*</span>\n' +
                        '               <div class="layui-input-inline" style="width:70%">\n' +
                        '                   <input type="text" name="packageName"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        '       <div class="layui-form-item" style="width: 43%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 22%">所属分类</label><span style="color: red">*</span>\n' +
                        '               <div class="layui-input-inline" style="width:65%">\n' +
                        // '                   <input type="text" name="classId" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '                       <select name="classId" id="classId" class="classId"></select>' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 20%">资源包价格</label>\n' +
                        '               <div class="layui-input-inline" style="width:70%">\n' +
                        '                   <input type="text" name="packagePrice" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        '       <div class="layui-form-item" style="width: 88%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 89%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 12%">报名单位</label>\n' +
                        '               <div class="layui-input-inline" style="width:82%">\n' +
                        // '                   <input style="background-color: rgb(224,224,224)" readonly type="text" id="registrationUnit1" name="registrationUnit" placeholder="点击选择报名单位"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '                   <textarea style="background-color: rgb(224,224,224);height: 120px;" readonly type="text" name="registrationUnit" placeholder="" id="registrationUnit1" lay-verify="required|phone" autocomplete="off" class="layui-input"></textarea>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       <div style="font-size: 16px;display: inline-block;"><a href="javascript:" style="color: blue" class="clear" id="addUser1">选择</a>\n' +
                        '       <a href="javascript:" style="color: blue" class="clear" id="clearUser1">清空</a></div>\n' +
                        '       </div>\n' +

                        '       <div class="layui-form-item" style="width: 92%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 10%">资源包描述</label>\n' +
                        '               <div class="layui-input-inline" style="width:85%;height: 120px;">\n' +
                        '                   <textarea type="text" name="packageDesc" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input" style="height: 150px;"></textarea>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +

                        '   </form>' +
                        '</div>',
                    success: function () {
                        $.ajax({
                            url:'/cdmResource/selectCdmResourceClassAll',
                            type:'get',
                            async:false,
                            dataType:'json',
                            success:function(data){
                                var data = data.obj
                                var str = '<option></option>'
                                for(var i = 0;i<data.length;i++){
                                    str += '<option value="'+data[i].classId+'">'+data[i].className+'</option>'
                                }
                                $("#classId").html(str)
                                form.render()
                            }
                        });
                        $.ajax({
                            url:'/cdmResource/selectCdmResourcePackageByPackageId',
                            type:'get',
                            async:false,
                            data:{
                                packageId:packageId
                            },
                            dataType:'json',
                            success:function(obj){
                                var data = obj.object
                                if(data.packageName != undefined){
                                    $("input[name='packageName']").val(data.packageName)
                                }

                                $("input[name='packageName']").attr('packageId',data.packageId)
                                $("input[name='packagePrice']").val(data.packagePrice)
                                $("textarea[name='packageDesc']").text(data.packageDesc)
                                $("textarea[name='registrationUnit']").val(data.userName)
                                $("textarea[name='registrationUnit']").attr('user_id',data.registrationUnit)
                                $("input[name='orderNo']").val(data.orderNo)
                                if(data.classId != '' || data.classId != undefined) {
                                    $("#classId option[value=" + data.classId + "]").prop('selected', true)
                                }
                                form.render()
                            }
                        });
                        form.render()
                    },
                    yes: function () {
                        var packageName = $("input[name='packageName']").val()
                        var packagePrice = $("input[name='packagePrice']").val()
                        var packageDesc = $("textarea[name='packageDesc']").val()
                        var registrationUnit = $("textarea[name='registrationUnit']").attr('user_id')
                        var classId = $("select[name='classId']").val()
                        var packageId = $("input[name='packageName']").attr('packageId')
                        var orderNo = $("input[name='orderNo']").val()
                        if(packageName == undefined || packageName == ''){
                            layer.msg('资源包名称为必填项，请填写', {icon: 2});
                            return false
                        }
                        if(classId == undefined || classId == ''){
                            layer.msg('所属分类为必填项，请选择', {icon: 2});
                            return false
                        }

                        $.ajax({
                            url:'/cdmResource/updateCdmResourcePackageByPackageId',
                            type:'get',
                            data:{
                                packageName:packageName,
                                packagePrice:packagePrice,
                                packageDesc:packageDesc,
                                registrationUnit:registrationUnit,
                                classId:classId,
                                packageId:packageId,
                                orderNo:orderNo
                            },
                            dataType:'json',
                            success:function(obj){
                                if(obj.flag){

                                    layer.closeAll();
                                    layer.msg('修改成功', {icon: 1,offset:"300"});
                                    table.reload('test')
                                }else{
                                    layer.msg('修改失败', {icon: 2,offset:"300"});
                                }
                            }
                        });

                    },
                    btn2:function(index, layero){
                        layer.close(index);
                    }
                });

            }else if(data.event == 'dels'){
                layer.confirm('确定删除该数据吗？',{offset:"300"}, function(index){
                    $.ajax({
                        url:'/cdmResource/deleteCdmResourcePackageByPackageId',
                        type:'get',
                        dataType:'json',
                        data:{
                            packageId:packageId
                        },
                        success:function(data){
                            if(data.flag){

                                layer.closeAll();
                                layer.msg('删除成功', {icon: 1,offset:"300"});
                                table.reload('test')
                            }else{
                                layer.msg('删除失败', {icon: 2,offset:"300"});
                            }
                        }
                    });
                });

            }
        })
        table.on('tool(test1)',function(res){
            var classId = res.data.classId
            var packageId = res.data.packageId
            if(res.event == 'edit'){
                layer.open({
                    type: 1,
                    area: ['60%', '70%'], //宽高
                    title: ['修改','font-size:20px'],
                    maxmin: false,
                    offset:"100px",
                    btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
                    content: '<div style="margin: 20px auto;">' +
                        '   <form class="layui-form" action="">\n' +
                        '       <div class="layui-form-item" style="width: 43%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 22%">排序号</label>\n' +
                        '               <div class="layui-input-inline" style="width:65%">\n' +
                        '                   <input type="number" name="orderNo"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 30%">资源分类名称</label><span style="color: red">*</span>\n' +
                        '               <div class="layui-input-inline" style="width:60%">\n' +
                        '                   <input type="text" name="className"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +
                        // '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                        // '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        // '               <label class="layui-form-label" style="font-size: 18px;width: 20%">所属分类</label>\n' +
                        // '               <div class="layui-input-inline" style="width:70%">\n' +
                        // // '                   <input type="text" name="classId" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        // '                       <select name="classId" id="classId" class="classId"></select>' +
                        // '               </div>\n' +
                        // '           </div>\n' +
                        // '       </div>\n' +
                        '       <div class="layui-form-item" style="width: 88%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 89%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 12%">报名单位</label>\n' +
                        '               <div class="layui-input-inline" style="width:82%">\n' +
                        // '                   <input style="background-color: rgb(224,224,224)" readonly type="text" id="registrationUnit2" name="registrationUnit" placeholder="点击选择报名单位"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                        '                   <textarea style="background-color: rgb(224,224,224);height: 120px;" readonly type="text" name="registrationUnit" placeholder="" id="registrationUnit2" lay-verify="required|phone" autocomplete="off" class="layui-input"></textarea>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       <div style="font-size: 16px;display: inline-block;"><a href="javascript:" style="color: blue" class="clear" id="addUser2">选择</a>\n' +
                        '       <a href="javascript:" style="color: blue" class="clear" id="clearUser2">清空</a></div>\n' +
                        '       </div>\n' +
                        // '       <a href="javascript:" class="clear" id="addUser1">选择</a>\n' +
                        // '       <a href="javascript:" class="clear" id="clearUser2">清空</a>\n' +

                        '       <div class="layui-form-item" style="width: 92%;display: inline-block">\n' +
                        '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                        '               <label class="layui-form-label" style="font-size: 18px;width: 10%">分类描述</label>\n' +
                        '               <div class="layui-input-inline" style="width:85%;height: 120px;">\n' +
                        '                   <textarea type="text" name="classDesc" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input" style="height: 150px;"></textarea>\n' +
                        '               </div>\n' +
                        '           </div>\n' +
                        '       </div>\n' +

                        '   </form>' +
                        '</div>',
                    success: function () {
                        $.ajax({
                            url:'/cdmResource/selectCdmResourceClassByClassId',
                            type:'get',
                            async:false,
                            dataType:'json',
                            data:{
                              classId:classId
                            },
                            success:function(data){
                                $("input[name='className']").val(data.object.className)
                                $("input[name='orderNo']").val(data.object.orderNo)
                                $("input[name='className']").attr('classId',data.object.classId)
                                // if(data.object.registrationUnits != undefined){
                                //     $("input[name='registrationUnits']").val(data.object.userName)
                                //     $("input[name='registrationUnits']").attr('user_id',data.object.registrationUnits)
                                // }
                                if(data.object.registrationUnit != undefined){
                                    $("textarea[name='registrationUnit']").val(data.object.userName)
                                    $("textarea[name='registrationUnit']").attr('user_id',data.object.registrationUnit)
                                }
                                if(data.object.classDesc != undefined){
                                    $("textarea[name='classDesc']").val(data.object.classDesc)
                                }

                            }
                        });
                    },
                    yes: function () {
                        var className = $("input[name='className']").val()
                        var registrationUnit = $("textarea[name='registrationUnit']").attr('user_id')
                        var classDesc = $("textarea[name='classDesc']").val()
                        var orderNo = $("input[name='orderNo']").val()
                        var classId = $("input[name='className']").attr('classId')
                        if(className == undefined || className == ''){
                            layer.msg('资源分类名称为必填项，请填写', {icon: 2});
                            return false
                        }
                        $.ajax({
                            url:'/cdmResource/updateCdmResourceClassByClassId',
                            type:'get',
                            async:false,
                            dataType:'json',
                            data:{
                                classId:classId,
                                className:className,
                                classDesc:classDesc,
                                registrationUnit:registrationUnit,
                                orderNo:orderNo

                            },
                            success:function(data){
                                if(data.flag){
                                    layer.closeAll();
                                    layer.msg('修改成功', {icon: 1});

                                    table.reload('test1')
                                    table.reload('test')
                                }else{
                                    layer.msg('修改失败', {icon: 2});
                                }
                            }
                        });

                    },
                    btn2:function(index, layero){
                        layer.close(index);
                    }
                });
            }else if(res.event == 'del'){
                layer.confirm('确定删除该数据吗？', function(index){
                    $.ajax({
                        url:'/cdmResource/deleteCdmResourceClassByClassId',
                        type:'get',
                        dataType:'json',
                        data:{
                            classId:classId
                        },
                        success:function(data){
                            if(data.flag){

                                layer.closeAll();
                                layer.msg('删除成功', {icon: 1});
                                table.reload('test1')
                                table.reload('test')
                            }else{
                                layer.msg('删除失败', {icon: 2});
                            }
                        }
                    });
                });
            }
        })

        $(document).on('click','#add1',function(){
            layer.open({
                type: 1,
                area: ['60%', '60%'], //宽高
                title: ['新建','font-size:20px'],
                maxmin: false,
                offset:"100px",
                btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
                content: '<div style="margin: 20px auto;">' +
                    '   <form class="layui-form" action="">\n' +
                    '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               <label class="layui-form-label" style="font-size: 18px;width: 20%">排序号</label>\n' +
                    '               <div class="layui-input-inline" style="width:70%">\n' +
                    '                   <input type="number" name="orderNo"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               <label class="layui-form-label" style="font-size: 18px;width: 20%">资源包名称</label><span style="color: red">*</span>\n' +
                    '               <div class="layui-input-inline" style="width:70%">\n' +
                    '                   <input type="text" name="packageName"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               <label class="layui-form-label" style="font-size: 18px;width: 20%">所属分类</label><span style="color: red">*</span>\n' +
                    '               <div class="layui-input-inline" style="width:70%">\n' +
                    // '                   <input type="text" name="classId" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    '                       <select name="classId" id="classId" class="classId"></select>' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               <label class="layui-form-label" style="font-size: 18px;width: 20%">资源包价格</label>\n' +
                    '               <div class="layui-input-inline" style="width:70%">\n' +
                    '                   <input type="text" name="packagePrice" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    // '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    // '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    // '               <label class="layui-form-label" style="font-size: 18px;width: 20%">报名单位</label>\n' +
                    // '               <div class="layui-input-inline" style="width:70%">\n' +
                    // '                   <input style="background-color: rgb(224,224,224)" readonly type="text" id="registrationUnit3" name="registrationUnit" placeholder="点击选择报名单位"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    // '               </div>\n' +
                    // '           </div>\n' +
                    // '       </div>\n' +
                    // '       <a href="javascript:" class="clear" id="clearUser3">清空</a>\n' +
                    '       <div class="layui-form-item" style="width: 100%;display: inline-block">\n' +
                    '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               <label class="layui-form-label" style="font-size: 18px;width: 10%">资源包描述</label>\n' +
                    '               <div class="layui-input-inline" style="width:84%;height: 120px;">\n' +
                    '                   <textarea type="text" name="packageDesc" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input" style="height: 150px;"></textarea>\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </div>\n' +

                    '   </form>' +
                    '</div>',
                success: function () {
                    $.ajax({
                        url:'/cdmResource/selectCdmResourceClassAll',
                        type:'get',
                        async:false,
                        dataType:'json',
                        success:function(data){
                            var data = data.obj
                            var str = '<option></option>'
                            for(var i = 0;i<data.length;i++){
                                str += '<option value="'+data[i].classId+'">'+data[i].className+'</option>'
                            }
                            $("#classId").html(str)
                            form.render()
                        }
                    });
                    form.render()
                },
                yes: function () {

                    var packageName = $("input[name='packageName']").val()
                    var packagePrice = $("input[name='packagePrice']").val()
                    var packageDesc = $("textarea[name='packageDesc']").val()
                    // var registrationUnit = $("input[name='registrationUnit']").attr('user_id')
                    var classId = $("select[name='classId']").val()
                    var packageId = $("input[name='packageName']").attr('packageId')
                    var orderNo = $("input[name='orderNo']").val()
                    if(packageName == undefined || packageName == ''){
                        layer.msg('资源包名称为必填项，请填写', {icon: 2});
                        return false
                    }
                    if(classId == undefined || classId == ''){
                        layer.msg('所属分类为必填项，请选择', {icon: 2});
                        return false
                    }
                    $.ajax({
                        url:'/cdmResource/insertCdmResourcePackage',
                        type:'get',
                        data:{
                            packageName:packageName,
                            packagePrice:packagePrice,
                            packageDesc:packageDesc,
                            // registrationUnit:registrationUnit,
                            classId:classId,
                            // packageId:packageId,
                            orderNo:orderNo
                        },
                        dataType:'json',
                        success:function(obj){
                            if(obj.flag){

                                layer.closeAll();
                                layer.msg('新建成功', {icon: 1,offset:"300"});
                                table.reload('test')
                            }else{
                                layer.msg('新建失败', {icon: 2,offset:"300"});
                            }
                        }
                    });
                },
                btn2:function(index, layero){
                    layer.close(index);
                }
            });
        })
        $(document).on('click','#add2',function(){
            layer.open({
                type: 1,
                area: ['60%', '50%'], //宽高
                title: ['新建','font-size:20px'],
                maxmin: false,
                offset:"100px",
                btn: ['确&nbsp&nbsp定','取&nbsp&nbsp消'], //可以无限个按钮
                content: '<div style="margin: 20px auto;">' +
                    '   <form class="layui-form" action="">\n' +
                    '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               <label class="layui-form-label" style="font-size: 18px;width: 20%">排序号</label>\n' +
                    '               <div class="layui-input-inline" style="width:70%">\n' +
                    '                   <input type="number" name="orderNo"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               <label class="layui-form-label" style="font-size: 18px;width: 30%">资源分类名称</label><span style="color: red">*</span>\n' +
                    '               <div class="layui-input-inline" style="width:60%">\n' +
                    '                   <input type="text" name="className"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </div>\n' +
                    // '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    // '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    // '               <label class="layui-form-label" style="font-size: 18px;width: 20%">所属分类</label>\n' +
                    // '               <div class="layui-input-inline" style="width:70%">\n' +
                    // // '                   <input type="text" name="classId" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    // '                       <select name="classId" id="classId" class="classId"></select>' +
                    // '               </div>\n' +
                    // '           </div>\n' +
                    // '       </div>\n' +
                    // '       <div class="layui-form-item" style="width: 49%;display: inline-block">\n' +
                    // '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    // '               <label class="layui-form-label" style="font-size: 18px;width: 20%">报名单位</label>\n' +
                    // '               <div class="layui-input-inline" style="width:70%">\n' +
                    // '                   <input style="background-color: rgb(224,224,224)" readonly type="text" id="registrationUnit4" name="registrationUnit" placeholder="点击选择报名单位"  lay-verify="required|phone" autocomplete="off" class="layui-input">\n' +
                    // '               </div>\n' +
                    // '           </div>\n' +
                    // '       </div>\n' +
                    // '       <a href="javascript:" class="clear" id="clearUser4">清空</a>\n' +
                    '       <div class="layui-form-item" style="width: 100%;display: inline-block">\n' +
                    '           <div class="layui-inline" style="width: 100%;margin-right: 0;">\n' +
                    '               <label class="layui-form-label" style="font-size: 18px;width: 10%">分类描述</label>\n' +
                    '               <div class="layui-input-inline" style="width:84%;height: 120px;">\n' +
                    '                   <textarea type="text" name="classDesc" placeholder=""  lay-verify="required|phone" autocomplete="off" class="layui-input" style="height: 150px;"></textarea>\n' +
                    '               </div>\n' +
                    '           </div>\n' +
                    '       </div>\n' +

                    '   </form>' +
                    '</div>',
                success: function () {

                },
                yes: function () {

                    var orderNo= $("input[name='orderNo']").val()
                    var className= $("input[name='className']").val()
                    var classDesc= $("textarea[name='classDesc']").val()
                    if(className == undefined || className == ''){
                        layer.msg('资源分类名称为必填项，请填写', {icon: 2});
                        return false
                    }
                    // var registrationUnit = $("input[name='registrationUnit']").attr('user_id')
                    $.ajax({
                        url:'/cdmResource/insertCdmResourceClass',
                        type:'get',
                        data:{
                            classDesc:classDesc,
                            className:className,
                            orderNo:orderNo,
                            // registrationUnit:registrationUnit
                        },
                        dataType:'json',
                        success:function(obj){
                            if(obj.flag){

                                layer.closeAll();
                                layer.msg('新建成功', {icon: 1});
                                table.reload('test1')
                            }else{
                                layer.msg('新建失败', {icon: 2});
                            }
                        }
                    });
                },
                btn2:function(index, layero){
                    layer.close(index);
                }
            });
        })
        $(document).on('click','#addUser1',function(){
            user_id='registrationUnit1';
            $.popWindow("/common/selectUser");
        })
        $(document).on('click','#clearUser1',function(){
            $("#registrationUnit1").val("");
            $("#registrationUnit1").attr('username','');
            $("#registrationUnit1").attr('dataid','');
            $("#registrationUnit1").attr('user_id','');
            $("#registrationUnit1").attr('userprivname','');
        })
        $(document).on('click','#addUser2',function(){
            user_id='registrationUnit2';
            $.popWindow("/common/selectUser");
        })
        $(document).on('click','#clearUser2',function(){
            $("#registrationUnit2").val("");
            $("#registrationUnit2").attr('username','');
            $("#registrationUnit2").attr('dataid','');
            $("#registrationUnit2").attr('user_id','');
            $("#registrationUnit2").attr('userprivname','');
        })
        // $(document).on('click','#registrationUnit3',function(){
        //     user_id='registrationUnit3';
        //     $.popWindow("/common/selectUser");
        // })
        // $(document).on('click','#clearUser3',function(){
        //     $("#registrationUnit3").val("");
        //     $("#registrationUnit3").attr('username','');
        //     $("#registrationUnit3").attr('dataid','');
        //     $("#registrationUnit3").attr('user_id','');
        //     $("#registrationUnit3").attr('userprivname','');
        // })
        // $(document).on('click','#registrationUnit4',function(){
        //     user_id='registrationUnit4';
        //     $.popWindow("/common/selectUser");
        // })
        // $(document).on('click','#clearUser4',function(){
        //     $("#registrationUnit4").val("");
        //     $("#registrationUnit4").attr('username','');
        //     $("#registrationUnit4").attr('dataid','');
        //     $("#registrationUnit4").attr('user_id','');
        //     $("#registrationUnit4").attr('userprivname','');
        // })
    });


</script>
</html>
