<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2022/3/8
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>设置自定义字段</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"  content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <script type="text/javascript" src="../../js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/lay/dest/layui.all.js"></script>
    <script src="../../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layui/layui/layui.js"></script>
</head>
<body>

<div class="myContract"style="width: 600px;position:absolute;left:30% ">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
        <div class="layui-tab-content">
            <div class="content" ><table class="layui-hide" id="plan" lay-filter="plan"></table></div>
        </div>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="add">新建</a>
</script>
<script type="text/html" id="barDemo1">
    <a class="layui-btn  layui-btn-xs" lay-event="update">修改</a>
    <a class="layui-btn layui-btn-xs" lay-event="del">删除</a>
</script>
</body>
<script>
    layui.use(['form', 'layedit', 'laydate','layedit','table'], function(){
        var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate
            ,layedit = layui.layedit
            ,table = layui.table;

        table.reload();
        table.render({
            elem: '#plan'
            ,url:'/code/getCode?parentNo=FIELDDEF'
            ,title:'自定义字段表'
            ,cols: [[
                {field:'codeName', title: '模块'}
                ,{fixed: 'right',title: '操作',toolbar: '#barDemo' }
            ]]
            ,parseData: function(res){ //res 即为原始返回的数据

                return {
                    "code": 0, //解析接口状态
                    "count": res.obj.length, //解析数据长度
                    "data": res.obj //解析数据列表
                };
            }
            ,page:true,
            done: function (res, curr) {
            },
        });

        //监听头工具栏事件
        table.on('tool(plan)', function(obj){

                    var data = obj.data;
                    var fieldNo='USERDEF';
                    var tabName=data.codeNo;
                if(obj.event=='add'){

                    layer.open({
                        type: 1, //宽高
                        title: '新建自定义字段',
                        area: ['500px', '80%'],
                        maxmin: true,
                        btn: ['保存', '取消'], //可以无限个按钮
                        content: '<div style="padding:8px"> ' +
                            '<form class="layui-form" action="" id="formTest2">\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                            '                <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>字段名称</label>\n' +
                            '                <div class="layui-input-inline">\n' +
                            '                    <input type="text" name="fieldName" id="fieldName"  autocomplete="off"   class="layui-input">\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                            '                <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>排序号</label>\n' +
                            '                <div class="layui-input-inline">\n' +
                            '                    <input type="text" name="orderNo" id="orderNo"  autocomplete="off"   class="layui-input">\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                            '                <label class="layui-form-label" style="width: 112px;">字段选项</label>\n' +
                            '                <div>\n' +
                            '<input type="checkbox" id="isGroup" value="1" lay-skin="primary"><span>是否作为排序字段</span>' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                            '                <label class="layui-form-label" style="width: 112px;">字段类型</label>\n' +
                            '                <div class="layui-input-inline">\n' +
                            '<select  id="stype" name="stype" lay-verify="required|type" lay-filter="search_type">\n' +
                            '<option value="T">单行输入框</option>' +
                            '<option value="MT">多行输入框</option>' +
                            '<option value="S">下拉菜单</option>' +
                            '<option value="R">单选框</option>' +
                            '<option value="C">多选框</option>' +
                            '</select>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%;display: none" id="xtdm1">\n' +
                            '                <label class="layui-form-label" style="width: 112px;">代码类型</label>\n' +
                            '                <div>\n' +
                            '<input type="radio" id="codeType" name="codeType" value="1" title="系统代码" checked lay-filter="together_send">' +
                            '<input type="radio" id="codeType" name="codeType" value="2" title="自定义选项" lay-filter="together_send">' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%;display: none" id="xtdm2">\n' +
                            '                <label class="layui-form-label" style="width: 112px;">字段类型</label>\n' +
                            '                <div class="layui-input-inline">\n' +
                            '<select  id="typeCode">\n' +
                            '</select>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%;display: none" id="zdyxx1">\n' +
                            '                <label class="layui-form-label" style="width: 112px;">选项名称</label>\n' +
                            '                <div class="layui-input-inline">\n' +
                            '                    <input type="textarea" name="typeName" id="typeName"  autocomplete="off"   class="layui-input"><span>显示的选项，必须用英文逗号隔开如:（选项1,选项2,选项3）</span>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%;display: none" id="zdyxx2">\n' +
                            '                <label class="layui-form-label" style="width: 112px;">选项的值</label>\n' +
                            '                <div class="layui-input-inline">\n' +
                            '                    <input type="textarea" name="typeValue" id="typeValue"  autocomplete="off"   class="layui-input"><span>选项对应存储的值，非重复的数字，必须用英文逗号隔开如:（1,2,3）</span>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                            '                <label class="layui-form-label" style="width: 112px;">字段选项</label>\n' +
                            '                <div >\n' +
                            '<input type="checkbox" id="isQuery" value="1" lay-skin="primary" ><span>是否作为查询字段</span>' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '    </form></div>',
                        success: function () {
                            table.reload();
                            $.ajax({
                                type: 'get',
                                url: '/code/syscode/getAllSysCode',
                                dataType: 'json',
                                success: function (json) {
                                    if (json.flag) {
                                        if (json.obj.length != 0) {
                                            var str = '';
                                            for (var i = 0; i < json.obj.length; i++) {
                                                str += '<option value="' + json.obj[i].codeNo + '">' + json.obj[i].codeName + '</option>'
                                            }
                                            $('#typeCode').append(str)
                                            form.render()
                                        }
                                    }
                                }
                            });
                            form.on('select(search_type)', function(data){
                                var stype = $('#stype').val();
                            if(stype == 'T'||stype == 'MT'){
                                $('#xtdm1').css('display','none');
                                $('#xtdm2').css('display','none');
                                table.reload();
                            }else{
                                $('#xtdm1').css('display','block');
                                $('#xtdm2').css('display','block');
                                table.reload();
                            };
                            });
                            form.on('radio(together_send)', function (data) {
                                var xtdm = data.value;
                                if(xtdm == '1'){
                                    $('#zdyxx1').css('display','none');
                                    $('#zdyxx2').css('display','none');
                                    $('#xtdm2').css('display','block');
                                    table.reload();
                                }else{
                                    $('#zdyxx1').css('display','block');
                                    $('#zdyxx2').css('display','block');
                                    $('#xtdm2').css('display','none');
                                    table.reload();
                                }

                            })

                        },
                        yes: function (index, layero) {
                            var fieldName = $('#fieldName').val();
                            var orderNo = $('#orderNo').val();
                            var stype = $('#stype').val();
                            var isQuery = 0;
                            if($('#isQuery').prop('checked')==true){

                                isQuery = 1;
                            }
                            var isGroup = 0;
                            if($('#isGroup').prop('checked')==true){

                                isGroup = 1;
                            }
                            var codeType1=document.getElementsByName("codeType");
                            for(var i=0;i<codeType1.length;i++){
                                if(codeType1[i].checked){
                                    var codeType = i+1;
                                    break;
                                }
                            }
                            var typeCode = $('#typeCode').val();
                            var typeName = $('#typeName').val();
                            var typeValue = $('#typeValue').val();
                            var reg = /^[0-9]+.?[0-9]*$/;
                            if ($('[name="fieldName"]').val() == '') {
                                layer.msg('请输入字段名称！', {icon: 2});
                                return false;
                            }else if ($('[name="orderNo"] ').val() == '') {
                                layer.msg('请输入排序号！', {icon: 2});
                                return false;
                            }
                            else if(reg.test(orderNo)== false){
                                layer.msg('排序号请输入数字！', {icon: 2});
                                return false;
                            }
                            var datas={
                                fieldName:fieldName,
                                orderNo:orderNo,
                                stype:stype,
                                isQuery:isQuery,
                                isGroup:isGroup,
                                codeType:codeType,
                                typeCode:typeCode,
                                typeName:typeName,
                                typeValue:typeValue,
                            }
                            $.ajax({
                                url: '/fieldSet/addFieldSet?tabName='+tabName+'',
                                dataType: 'json',
                                type: 'post',
                                data: datas,
                                success: function (data) {
                                    if (data.flag) {
                                        layer.msg('保存成功！', {icon: 1});
                                        table.reload();

                                    } else {
                                        $.layerMsg({content: data.msg, icon: 1});
                                       table.reload();
                                    }
                                }
                            })
                            layer.close(index);
                        }
                    })
                }
                else{
                    layer.open({
                        type: 1, //宽高
                        title: '编辑自定义字段',
                        area: ['700px', '80%'],
                        maxmin: true,
                        btn: ['取消'], //可以无限个按钮
                        content: '<div style="padding:8px"> ' +
                            '<form class="layui-form" action="" id="formTest2">\n' +
                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                                '<table id="test" lay-filter="test">' +
                            '</table>' +
                            '</div>'+
                            '    </form></div>',
                        success: function () {
                            table.reload();
                            table.render({
                                elem: '#test'
                                ,url:'/fieldSet/selectFieldSet?tabName='+tabName+''
                                ,title:'自定义字段表'
                                ,cols: [[
                                    {field:'fieldName', title: '字段名'},
                                    {field:'fieldNo', title: '排序号'},
                                    {field:'stypeName', title: '字段名称'},
                                    {fixed: 'right',title: '操作',toolbar: '#barDemo1' }
                                ]]
                                ,parseData: function(res){ //res 即为原始返回的数据

                                    return {
                                        "code": 0, //解析接口状态
                                        "count": res.obj.length, //解析数据长度
                                        "data": res.obj //解析数据列表
                                    };
                                }
                                ,page:true,
                                done: function (res, curr) {
                                },
                            });
                            table.on('tool(test)', function(obj){
                                var data=obj.data;
                                var tabName=data.tabName;
                                var fieldNo=data.fieldNo;
                                if(obj.event=='update'){
                                    layer.open({
                                        type: 1, //宽高
                                        title: '修改自定义字段',
                                        area: ['500px', '80%'],
                                        maxmin: true,
                                        btn: ['保存', '取消'], //可以无限个按钮
                                        content: '<div style="padding:8px"> ' +
                                            '<form class="layui-form" action="" id="formTest2">\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>字段名称</label>\n' +
                                            '                <div class="layui-input-inline">\n' +
                                            '                    <input type="text" name="fieldName" id="fieldName"  autocomplete="off"   class="layui-input">\n' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;"><span style="color: red;">*</span>排序号</label>\n' +
                                            '                <div class="layui-input-inline">\n' +
                                            '                    <input type="text" name="orderNo" id="orderNo"  autocomplete="off"   class="layui-input">\n' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;">字段选项</label>\n' +
                                            '                <div>\n' +
                                            '<input type="checkbox" id="isGroup" value="1" lay-skin="primary"><span>是否作为排序字段</span>' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;">字段类型</label>\n' +
                                            '                <div class="layui-input-inline">\n' +
                                            '<select  id="stype" name="stype" lay-verify="required|type" lay-filter="search_type">\n' +
                                            '<option value="T">单行输入框</option>' +
                                            '<option value="MT">多行输入框</option>' +
                                            '<option value="S">下拉菜单</option>' +
                                            '<option value="R">单选框</option>' +
                                            '<option value="C">多选框</option>' +
                                            '</select>\n' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%;display: none" id="xtdm1">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;">代码类型</label>\n' +
                                            '                <div>\n' +
                                            '<input type="radio" id="codeType" name="codeType" value="1" title="系统代码" checked lay-filter="together_send">' +
                                            '<input type="radio" id="codeType" name="codeType" value="2" title="自定义选项" lay-filter="together_send">' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%;display: none" id="xtdm2">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;">字段类型</label>\n' +
                                            '                <div class="layui-input-inline">\n' +
                                            '<select  id="typeCode" name="typeCode">\n' +
                                            '</select>\n' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%;display: none" id="zdyxx1">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;">选项名称</label>\n' +
                                            '                <div class="layui-input-inline">\n' +
                                            '                    <input type="textarea" name="typeName" id="typeName"  autocomplete="off"   class="layui-input"><span>显示的选项，必须用英文逗号隔开如:（选项1,选项2,选项3）</span>\n' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%;display: none" id="zdyxx2">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;">选项的值</label>\n' +
                                            '                <div class="layui-input-inline">\n' +
                                            '                    <input type="textarea" name="typeValue" id="typeValue"  autocomplete="off"   class="layui-input"><span>选项对应存储的值，非重复的数字，必须用英文逗号隔开如:（1,2,3）</span>\n' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '        <div class="layui-form-item" style="display: flex;width: 100%">\n' +
                                            '                <label class="layui-form-label" style="width: 112px;">字段选项</label>\n' +
                                            '                <div >\n' +
                                            '<input type="checkbox" id="isQuery" value="1" lay-skin="primary" ><span>是否作为查询字段</span>' +
                                            '                </div>\n' +
                                            '            </div>\n' +
                                            '    </form></div>',
                                        success: function () {
                                            table.reload();
                                            //系统代码 选项框获取
                                            $.ajax({
                                                type: 'get',
                                                url: '/code/syscode/getAllSysCode',
                                                dataType: 'json',
                                                success: function (json) {
                                                    if (json.flag) {
                                                        if (json.obj.length != 0) {
                                                            var str = '';
                                                            for (var i = 0; i < json.obj.length; i++) {
                                                                str += '<option value="' + json.obj[i].codeNo + '">' + json.obj[i].codeName + '</option>'
                                                            }
                                                            $('#typeCode').append(str)
                                                            form.render()
                                                        }
                                                    }
                                                }
                                            });
                                            //编辑回显
                                             $.ajax({
                                                 type: 'get',
                                                 url: '/fieldSet/selectFieldSet?tabName='+tabName+'&fieldNo=' + fieldNo,
                                                 dataType: 'json',
                                                 success: function (json) {
                                                     if(json.obj[0].stype == 'S'||json.obj[0].stype == 'R'||json.obj[0].stype == 'C'){
                                                         $('#xtdm1').css('display','block');

                                                         if(json.obj[0].codeType=='1'){
                                                             $("input[name='codeType']").get(0).checked=true;
                                                         $('#zdyxx1').css('display','none');
                                                         $('#zdyxx2').css('display','none');
                                                         $('#xtdm2').css('display','block');
                                                             form.render();
                                                     }else if(json.obj[0].codeType=='2'){
                                                             $("input[name='codeType']").get(1).checked=true;
                                                         $('#zdyxx1').css('display','block');
                                                         $('#zdyxx2').css('display','block');
                                                         $('#xtdm2').css('display','none');

                                                             form.render();
                                                     }
                                                     }else{
                                                         $('#xtdm1').css('display','none');
                                                     }
                                                     $('#fieldName').val(json.obj[0].fieldName);
                                                     $('#orderNo').val(json.obj[0].orderNo);
                                                     if(json.obj[0].isGroup==1){
                                                         $('#isGroup').attr({
                                                             checked:"checked"
                                                         })
                                                     }
                                                     if(json.obj[0].isQuery==1){
                                                         $('#isQuery').attr({
                                                             checked:"checked"
                                                         })
                                                     }
                                                     $('select[name="stype"]').find('option').each(function (i, n) {
                                                         if ($(this).val() == json.obj[0].stype) {
                                                             $(this).attr('selected', 'selected')
                                                             return false
                                                         }
                                                     })

                                                     $('select[name="typeCode"]').find('option').each(function (i, n) {
                                                         if ($(this).val() == json.obj[0].typeCode) {
                                                             $(this).attr('selected', 'selected')
                                                             return false
                                                         }
                                                     })
                                                     $('#typeName').val(json.obj[0].typeName);
                                                     $('#typeValue').val(json.obj[0].typeValue);

                                                 }
                                             });
                                            form.on('select(search_type)', function(data){
                                                var stype = $('#stype').val();
                                                if(stype == 'T'||stype == 'MT'){
                                                    $('#xtdm1').css('display','none');
                                                    $('#xtdm2').css('display','none');
                                                    $('#zdyxx1').css('display','none');
                                                    $('#zdyxx2').css('display','none');
                                                    form.render();
                                                }else{
                                                    $('#xtdm1').css('display','block');
                                                    $('#xtdm2').css('display','block');
                                                    form.render();
                                                };
                                            });
                                            form.on('radio(together_send)', function (data) {
                                                var xtdm = data.value;
                                                if(xtdm == '1'){
                                                    $('#zdyxx1').css('display','none');
                                                    $('#zdyxx2').css('display','none');
                                                    $('#xtdm2').css('display','block');
                                                    form.render();
                                                }else if(xtdm == '2'){
                                                    $('#zdyxx1').css('display','block');
                                                    $('#zdyxx2').css('display','block');
                                                    $('#xtdm2').css('display','none');
                                                    form.render();
                                                }

                                            })

                                        },
                                        yes: function (index, layero) {
                                            var fieldName = $('#fieldName').val();
                                            var orderNo = $('#orderNo').val();
                                            var stype = $('#stype').val();
                                            var codeType = $('#codeType').val();
                                            var isQuery = 0;
                                            if($('#isQuery').prop('checked')==true){

                                                isQuery = 1;
                                            }
                                            var isGroup = 0;
                                            if($('#isGroup').prop('checked')==true){
                                                isGroup = 1;
                                            }
                                            var typeCode = $('#typeCode').val();
                                            var typeName = $('#typeName').val();
                                            var typeValue = $('#typeValue').val();
                                            var codeType1=document.getElementsByName("codeType");
                                            for(var i=0;i<codeType1.length;i++){
                                                if(codeType1[i].checked){
                                                    var codeType = i+1;
                                                    break;
                                                }
                                            }
                                            var reg = /^[0-9]+.?[0-9]*$/;
                                            if ($('[name="fieldName"]').val() == '') {
                                                layer.msg('请输入字段名称！', {icon: 2});
                                                return false;
                                            }else if ($('[name="orderNo"] ').val() == '') {
                                                layer.msg('请输入排序号！', {icon: 2});
                                                return false;
                                            }
                                            else if(reg.test(orderNo)== false){
                                                layer.msg('排序号请输入数字！', {icon: 2});
                                                return false;
                                            }
                                            var datas={
                                                fieldName:fieldName,
                                                orderNo:orderNo,
                                                stype:stype,
                                                isQuery:isQuery,
                                                isGroup:isGroup,
                                                typeCode:typeCode,
                                                typeName:typeName,
                                                typeValue:typeValue,
                                                codeType:codeType,
                                            }
                                            $.ajax({
                                                url: '/fieldSet/updateFieldSet?tabName='+tabName+'&fieldNo=' + fieldNo,
                                                dataType: 'json',
                                                type: 'post',
                                                data: datas,
                                                success: function (data) {
                                                    if (data.flag) {
                                                        layer.msg('保存成功！', {icon: 1});
                                                        table.reload('test');

                                                    } else {
                                                        $.layerMsg({content: data.msg, icon: 1});
                                                       table.reload();
                                                    }
                                                }
                                            })
                                            layer.close(index);
                                        }
                                    })
                                }
                                else{
                                    layer.confirm('确定要删除该数据吗？', function (index) {
                                        $.ajax({
                                            url: '/fieldSet/deleteFieldSet',
                                            data: {
                                                tabName:tabName,
                                                fieldNo: data.fieldNo

                                            },
                                            dataType: 'json',
                                            type: 'get',
                                            success: function (res) {
                                                if (res.flag) {
                                                    layer.msg('删除成功', {icon: 1});
                                                    table.reload('test');
                                                }
                                                else{
                                                    layer.msg('删除失败', {icon: 1});
                                                    }
                                            }
                                        })
                                        layer.close(index);

                                    });}
                            })
                        },
                        yes: function (index, layero) {

                            layer.close(index);
                        }
                    })
                }
            });
        });
</script>
</html>
