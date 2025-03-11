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
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>分仓库管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../js/sys/citys.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .mbox{
            padding: 8px;
        }
        .top{
            margin-bottom: 10px;
        }
        .bg{
            background-color: #e6e6e6;
        }
        .p2 span {
            font-size: 14px;
            background-color: #2b7fe0;
            padding: 4px 18px;
            border-radius: 3px;
            color: #fff;
            cursor: pointer;
        }
        .newpop .list_group {
            margin: 20px 0;
        }
        .list_group .toryList {
            display: inline-block;
            margin-right: 20px;
            width: 100px;
            height: 26px;
        }
        .list_group .save_w {
            width: 412px;
            height: 28px;
            border:1px solid #ccc;
            border-radius: 3px;
        }
        .layui-icon{
            font-size: 23px;
            cursor:pointer;
        }
        .bg{
            background-color: #e6e6e6;
        }
    </style>
</head>
<body>
<div class="mbox">
    <div style="padding: 20px 0px 6px 13px;">
        <button type="button" class="layui-btn layui-btn-sm add">增加分仓库</button>
        <button type="button" class="layui-btn layui-btn-sm update">修改分仓库</button>
        <button type="button" class="layui-btn layui-btn-sm del">删除分仓库</button>
        <button type="button" class="layui-btn layui-btn-sm query">查询</button>
        <button type="button" class="layui-btn layui-btn-sm">全部记录</button>
        <button type="button" class="layui-btn layui-btn-sm">导出EXCEL</button>
        <button type="button" class="layui-btn layui-btn-sm">打印</button>
    </div>
    <div>
        <table id="subWarehouse" lay-filter="subWarehouse"></table>
    </div>
</div>


<script>
    var warehouseId; //定义当前行得id值
    layui.use(['table','form'], function(){
        var table = layui.table;
        var form=layui.form;
        //第一个实例
        var tableInts=table.render({
            elem: '#subWarehouse'
            ,url:'/invWarehouse/selectInvInfo'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }],
            parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.obj //解析数据列表
                };
            }
            ,title: '用户数据表'
            ,cols: [[ //表头
                {field: 'warehouseName', title: '仓库名称', }
                ,{field: 'warehousePerson', title: '负责人',}
                ,{field: 'warehousePhone', title: '联系电话',}
                ,{field: 'warehouseAdress', title: '仓库地址',}
                ,{field: 'warehouseDefault', title: '默认仓库',templet:function(d){
                        if(d.warehouseDefault=="0"){
                            return '否'
                        }else if(d.warehouseDefault=="1"){
                            return '是'
                        }
                    }}
                ,{field: 'warehouseRemarks', title: '备注',}
            ]]
            ,page: true
        });

        /*点击当前行数据*/
        table.on('row(subWarehouse)', function (obj) {
            var data = obj.data
            console.log(data)
            warehouseId = data.warehouseId
            $(this).addClass('bg').siblings().removeClass('bg')
        })
        /*修正分仓库管理*/
        $('update').on('click',function(){
            layer.open({
                title: '新增分仓库',
                shade: 0.3,
                area:['550px','350px'],
                content: '<div class="newpop">' +
                    '<div class="list_group">' +
                    '<label for="sortNum" class="toryList">仓库名称:</label>' +
                    '<input type="text" id="warehouseName" class="save_w"></div>' +
                    '<div class="list_group"><label for="catalog" class="toryList">仓库联系人:</label>' +
                    '<input type="text" id="warehousePerson" class="save_w"></div>' +
                    '<div class="list_group"><label for="path" class="toryList">联系人电话:</label>' +
                    '<input type="text" id="warehousePhone" class="save_w">' +
                    '</div>' +

                    '<div class="list_group">' +
                    '<label for="defaultSort" class="toryList">所属省市 :</label>' +
                    '<select name="province" style="width:200px;border-radius: 3px;height: 28px" id="province" class="province">'+
                    '</select>' +
                    '<select name="city" style="width:200px;border-radius: 3px;margin-left: 10px;height: 28px" id="city" class="city">' +
                    '</select>' +
                    '</div>'+
                    '<div class="list_group"><label for="maxcap" class="toryList"> 仓库地址:</label>' +
                    '<input type="text" id="warehouseAdress" class="save_w" value=""></div>' +
                    '<div class="list_group"><label for="maxcap" class="toryList"> 备注:</label>' +
                    '<textarea name="warehouseRemarks" id="warehouseRemarks" style="width: 412px;height: 50px;vertical-align: middle;border-radius: 3px" cols="30" rows="10"></textarea></div>' +
                    '</div>',
                area: ['600px','470px'],
                btn: ['确认', '返回'],
                yes: function () {
                    var data = {
                        warehouseName: $('#warehouseName').val(),
                        warehousePerson: $('#warehousePerson').val(),
                        warehousePhone: $('#warehousePhone').val(),
                        province: $('#province').val(),
                        city: $('#city').val(),
                        warehouseAdress: $('#warehouseAdress').val(),
                        warehouseRemarks: $('#warehouseRemarks').val()
                    }
                    $.ajax({
                        url: '/invWarehouse/insertInvHouse',
                        type: 'get',
                        dataType: 'json',
                        data: data,
                        success: function (data) {
                            if (data.flag) {
                                layer.msg('添加成功。', {icon: 6})
                                tableInts.reload()
                            }else {
                                $.layerMsg({content:'添加失败',icon:2});
                            }
                        }
                    })
                },success:function(){
                    var sheng = '<option value="">请选择</option>'
                    for(var i=0;i<json.provinces.length;i++){
                        sheng += '<option value="'+json.provinces[i].name+'">'+json.provinces[i].name+'</option>'
                    }
                    $('#province').html(sheng);
                    $('#province').on('change',function(){
                        var prov = $(this).val();
                        var citys = '<option value="">请选择</option>'
                        for(var i=0;i<json.provinces.length;i++){
                            if(json.provinces[i].name == prov){

                                if(json.provinces[i].citys!=""&&json.provinces[i].citys!=undefined){
                                    for(var j=0;j<json.provinces[i].citys.length;j++){
                                        citys += '<option value="'+json.provinces[i].citys[j]+'">'+json.provinces[i].citys[j]+'</option>'
                                    }
                                }
                                //
                            }
                        }
                        $('#city').html(citys);
                    })
                }
            })
        })

        /*新增分仓库*/
        $(".add").on('click',function () {
            layer.open({
                title: '修改分仓库',
                shade: 0.3,
                area:['550px','350px'],
                content: '<div class="newpop">' +
                    '<div class="list_group">' +
                    '<label for="sortNum" class="toryList">仓库名称:</label>' +
                    '<input type="text" id="warehouseName" class="save_w"></div>' +
                    '<div class="list_group"><label for="catalog" class="toryList">仓库联系人:</label>' +
                    '<input type="text" id="warehousePerson" class="save_w"></div>' +
                    '<div class="list_group"><label for="path" class="toryList">联系人电话:</label>' +
                    '<input type="text" id="warehousePhone" class="save_w">' +
                    '</div>' +

                    '<div class="list_group">' +
                    '<label for="defaultSort" class="toryList">所属省市 :</label>' +
                    '<select name="province" style="width:200px;border-radius: 3px;height: 28px" id="province" class="province">'+
                    '</select>' +
                    '<select name="city" style="width:200px;border-radius: 3px;margin-left: 10px;height: 28px" id="city" class="city">' +
                    '</select>' +
                    '</div>'+
                    '<div class="list_group"><label for="maxcap" class="toryList"> 仓库地址:</label>' +
                    '<input type="text" id="warehouseAdress" class="save_w" value=""></div>' +
                    '<div class="list_group"><label for="maxcap" class="toryList"> 备注:</label>' +
                    '<textarea name="warehouseRemarks" id="warehouseRemarks" style="width: 412px;height: 50px;vertical-align: middle;border-radius: 3px" cols="30" rows="10"></textarea></div>' +
                    '</div>',
                area: ['600px','470px'],
                btn: ['确认', '返回'],
                yes: function () {
                    var data = {
                        warehouseName: $('#warehouseName').val(),
                        warehousePerson: $('#warehousePerson').val(),
                        warehousePhone: $('#warehousePhone').val(),
                        province: $('#province').val(),
                        city: $('#city').val(),
                        warehouseAdress: $('#warehouseAdress').val(),
                        warehouseRemarks: $('#warehouseRemarks').val()
                    }
                    $.ajax({
                        url: '/invWarehouse/insertInvHouse',
                        type: 'get',
                        dataType: 'json',
                        data: data,
                        success: function (data) {
                            if (data.flag) {
                                layer.msg('添加成功。', {icon: 6})
                                tableInts.reload()
                            }else {
                                $.layerMsg({content:'添加失败',icon:2});
                            }
                        }
                    })
                },success:function(){
                    var sheng = '<option value="">请选择</option>'
                    for(var i=0;i<json.provinces.length;i++){
                        sheng += '<option value="'+json.provinces[i].name+'">'+json.provinces[i].name+'</option>'
                    }
                    $('#province').html(sheng);
                    $('#province').on('change',function(){
                        var prov = $(this).val();
                        var citys = '<option value="">请选择</option>'
                        for(var i=0;i<json.provinces.length;i++){
                            if(json.provinces[i].name == prov){

                                if(json.provinces[i].citys!=""&&json.provinces[i].citys!=undefined){
                                    for(var j=0;j<json.provinces[i].citys.length;j++){
                                        citys += '<option value="'+json.provinces[i].citys[j]+'">'+json.provinces[i].citys[j]+'</option>'
                                    }
                                }
                                //
                            }
                        }
                        $('#city').html(citys);
                    })
                }
            })
        })
        //查询
        $('.query').on('click',function () {
            layer.open({
                type: 1 //Page层类型
                ,area: ['500px', '260px']
                ,title: '仓库查询'
                ,maxmin: true //允许全屏最小化
                ,content:'<div class="layui-form">' +
                    '<div style="margin-left:20px;margin-top: 8px;"><i class="layui-icon layui-icon-help" style="color: red"></i><span>查询提示</span></div>'+
                    ' <div class="layui-input-block" style="margin-left: 20px;width:470px">\n' +
                    '      <textarea name="desc" placeholder="您可以输入仓库名称，负责人，联系电话，仓库地址，备注进行查询" class="layui-textarea" style="height: 40px;min-height: 20px;"></textarea>\n' +
                    '    </div>'+
                    ' <div class="layui-form-item" style="width: 350px;margin-left:20px;margin-top: 15px;">\n' +
                    '    <label class="layui-form-label" style="width: 100px;padding: 9px 0px;">请输入查询内容</label>\n' +
                    '    <div class="layui-input-block">\n' +
                    '      <input type="text" name="title" required  lay-verify="required" placeholder="请输入查询内容" autocomplete="off" class="layui-input">\n' +
                    '    </div>\n' +
                    '  </div>'+
                    '</div>'
                ,btn: ['确定','取消']
                ,success:function () {
                    form.render()
                }
            });
        })

        $('.del').on('click',function(){
            $.ajax({
                url: "/invWarehouse/deleteInvById",
                type: 'get',
                dataType: "JSON",
               data:{warehouseId:warehouseId},
                success:function(){
                    tableInts.reload()
                }
            })

        })
    });
</script>
</body>
</html>