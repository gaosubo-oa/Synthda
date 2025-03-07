<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>

    <title><fmt:message code="license.category"/></title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>


    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
        }
        .item img {
            height: 35px;
        }
        .layui-layer-btn {
            text-align: center;
        }
        /*上传附件样式start*/
        .openFile input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }

        .bar {
            height: 18px;
            background: green;
        }

        /*上传附件样式end*/

    </style>

</head>
<body>
<div style="padding:10px">
    <div class="item">
        <img src="/img/infomater.png" alt="" style="margin: 4 5px 0 20px;">
        <span style="font-size: 22px;display: inline-block;vertical-align: middle;"><fmt:message code="license.category.management"/>
        </span>

    </div>
    <hr class="layui-bg-blue">
    <table id="tableList" lay-filter="tableList"></table>
</div>


<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="height: 30px;">
<%--        style="float:right;"--%>
        <button class="layui-btn layui-btn-sm layui-btn-normal "  lay-event="add"><fmt:message code="license.new"/></button>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit"><fmt:message code="license.edit"/></a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><fmt:message code="license.delete"/></a>
</script>


<script type="text/javascript">

    layui.use(['table', 'form','laydate'], function () {
        var table = layui.table,
            form = layui.form,
            laydate = layui.laydate

           var tableInt = table.render({
                elem: '#tableList',
                url: '/comlicenseType/queryAll',
                page: true,
                // height: 'full-80',
                toolbar: '#toolbarDemo',
                defaultToolbar: [''],
                cols: [[
                    {field: 'licenseTypeNo', title: '<fmt:message code="license.sortNo"/>'},
                    {field: 'licenseTypeName', title: '<fmt:message code="license.category.name"/>'},
                    {field: 'remark', title: '<fmt:message code="license.remarks"/>'},
                    {fixed: 'right', title:'<fmt:message code="license.operation"/>', toolbar: '#barDemo'}
                ]],
                parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.data,//解析数据列表
                         "count": res.totleNum, //解析数据长度
                    }
                },
            });
        //监听行工具事件
        table.on('tool(tableList)', function(obj){
            var data = obj.data;
            var licenseType = data.licenseType
            if(obj.event === 'edit'){
                newOrEdit(1,licenseType)
            }else if(obj.event === 'del'){
                layer.confirm('<fmt:message code="license.deleting.this"/>', function (index) {
                    $.ajax({
                        type: 'get',
                        url: '/comlicenseType/delete?licenseType=' + licenseType,
                        dataType: 'json',
                        success: function (res) {
                            if (res.msg === 'ok') {
                                layer.msg('<fmt:message code="license.delsucess"/>！', {icon: 1});
                                tableInt.reload()
                                layer.close(index);
                            }else{
                                $.layerMsg({content: '<fmt:message code="license.deleSucess"/>！', icon: 2})
                            }
                        }
                    })
                });
            }
        });

        // 普通表格头部工具条事件监听
        table.on('toolbar(tableList)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    newOrEdit(0)
                    break;
            }
        });

        //新建/编辑
        function newOrEdit(type,licenseType) {
            var title
            var url = ''
            if (type == '0') {
                title = '<fmt:message code="license.new"/>'
                url = '/comlicenseType/add'
            } else if (type == '1') {
                title = '<fmt:message code="license.edit"/>'
                url = '/comlicenseType/update'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['40%', '40%'],
                min: function () {
                    $('.layui-layer-shade').hide()
                },
                btn: ['<fmt:message code="license.save"/>', '<fmt:message code="license.cancel"/>'],
                content: ['<form class="layui-form" id="form" lay-filter="formTest" style="padding:10px">' +
                //内容start
                '  <div class="layui-form-item" style="margin-left: 10%">\n' +
                '    <label class="layui-form-label"><fmt:message code="license.category.name"/></label>\n' +
                '    <div class="layui-input-block" style="width: 50%">\n' +
                '      <input type="text" name="licenseTypeName" lay-verify="title" autocomplete="off" class="layui-input">\n' +
                '    </div>\n' +
                '  </div>\n'+
                '  <div class="layui-form-item" style="margin-left: 10%">\n' +
                '    <label class="layui-form-label"><fmt:message code="license.sortNo"/></label>\n' +
                '    <div class="layui-input-block"  style="width: 50%">\n' +
                '      <input type="text" name="licenseTypeNo" lay-verify="title" autocomplete="off"  oninput = "value=value.replace(/[^\\d]/g,\'\')" class="layui-input">\n' +
                '    </div>\n' +
                '  </div>\n'+
                '  <div class="layui-form-item" style="margin-left: 10%">\n' +
                '    <label class="layui-form-label"><fmt:message code="license.remarks"/></label>\n' +
                '    <div class="layui-input-block"  style="width: 50%">\n' +
                '      <input type="text" name="remark" lay-verify="title" autocomplete="off"  class="layui-input">\n' +
                '    </div>\n' +
                '  </div>\n'+
                '</form>'].join(''),
                success: function () {
                    //回显数据
                    if (type == 1) {
                        $.ajax({
                            url: '/comlicenseType/queryByTypeId',
                            type: 'get',
                            data: {licenseType: licenseType},
                            dataType: 'json',
                            success: function (res) {
                                form.val("formTest",res.data);
                            }
                        })
                    }
                    form.render()
                },
                yes: function (index) {
                    var datas = $('#form').serializeArray()
                    var obj = {}
                    datas.forEach(function (item, index) {
                        obj[item.name] = item.value
                    })

                    if (type == 1) {
                        obj.licenseType = licenseType
                    }

                    $.ajax({
                        url: url,
                        data: obj,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('<fmt:message code="license.modify"/>', {icon: 1});
                                layer.close(index);
                                tableInt.reload()
                            } else {
                                layer.msg('<fmt:message code="license.save.failed"/>！', {icon: 0});
                            }

                        }
                    })
                },
            })
        }

    });

</script>
</body>
</html>
