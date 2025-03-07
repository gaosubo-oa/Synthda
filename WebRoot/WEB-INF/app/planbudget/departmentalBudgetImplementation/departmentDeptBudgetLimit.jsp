<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>岗级预算限额</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/common.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/layui/layui/layui.js"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layui/layui/js/baseCode/base.js?v=2019080918:09" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <style>
        /*.layui-form-label {*/
        /*    width: 100px;*/
        /*}*/

        /*.form_block {*/
        /*    margin: 0;*/
        /*}*/
        /*.form_label {*/
        /*    float: none;*/
        /*    padding: 9px 0;*/
        /*    text-align: left;*/
        /*    width: auto;*/
        /*}*/

        .layui-input-block {
            margin-left: 130px;
        }

        .layui-disabled, .layui-disabled:hover {
            color: #797979 !important;
        }

        .ztree * {
            font-size: 11pt !important;
        }

        #questionTree li {
            border-bottom: 1px solid #ddd;
            line-height: 40px;
            padding-left: 10px;
            cursor: pointer;
            border-radius: 3px;
        }

        .select {
            background: #c7e1ff;
        }

        .layui-table-tool {
            min-height: 40px;
            padding: 5px 15px;
        }

        /*.layui-form-item {*/
        /*    margin: 0px;*/
        /*}*/
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>

</head>
<body>
<div class="layui-fluid" id="LAY-app-message-1">
    <input type="hidden" id="sortId-1">
    <div class="layui-row ">
        <div class="layui-lf" style="width:250px;float:left">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight">
                    <div style="margin-bottom:10px;text-align: left;font-weight: bold;font-size: 20px;";>
                        岗级预算限额
                    </div>
                    <div style="margin-bottom:10px;text-align: center;font-weight: bold;font-size: 20px;border-bottom: 1px solid #ddd;border-top: 1px solid #ddd;line-height: 40px">岗位级别</div>
                    <ul id="questionTree"
                        style="position: absolute;overflow:auto;top:88px;right: 15px;bottom: 0;left: 15px;">
                    </ul>
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="display: none">
            <label class="layui-form-label">1标题</label>
            <div class="layui-input-block">
                <input type="text" id="plbPeriodId" required lay-verify="required" placeholder="" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-rt rightHeight" style="width:calc(100% - 250px);float:left;">
            <div class="layui-card" style="height: 100%;padding-left: 11px;">
                <div class="layui-fluid" id="LAY-app-message" style="padding: 0;">
                    <input type="hidden" id="sortId">
                    <div class="layui-row ">

                        <div class="layui-card" style="width:100%;">
                            <div class="layui-card">
                                <style>
                                    .layui-card-header .layui-icon {
                                        top: auto !important;
                                    }
                                </style>
                                <div id="queryarea_searchView">
                                </div>
                                <div class="layui-card-body">
                                    <div class="layui-form-item">
                                        <div class="layui-inline" style="">
                                            <label class="layui-form-label" id="limitTitle"
                                                   style="padding: 9px 5px;width: 600px">
                                                <span style="font-size: 25px; font-weight: bold;float: left;margin-left: 20px;">一级</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div>
                                        <table id="questionTable" lay-filter="questionTable-table"></table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script id="barOperation" type="text/html" lay-filter="toolBtn">
    <button type="button" class="layui-btn layui-btn-xs " lay-event="edit">编辑</button>
    <button type="button" class="layui-btn  layui-btn-xs layui-btn-danger " lay-event="del">删除</button>
</script>
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">新增</button>
        <button class="layui-btn layui-btn-sm" lay-event="edit">编辑</button>
        <button class="layui-btn layui-btn-sm" lay-event="del">删除</button>

    </div>
    <div style="position:absolute;top: 10px;right:60px;">
        <button class="layui-btn layui-btn-sm" lay-event="export" style="margin-left:10px;"><img
                src="/img/planCheck/导出.png" style="width: 20px;height: 20px;margin-top: -4px;">导出
        </button>
    </div>
</script>
</body>
</html>
<script>
    resizeSize();

    window.onresize = resizeSize;
    var form = null;

    var dictionaryObj = {
        COST_TYPE: {},
        LIMIT_TYPE: {},
        RIDE_STANDARD: {},
    }
    var dictionaryStr = 'COST_TYPE,LIMIT_TYPE,RIDE_STANDARD';
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                    });
                }
            }
        }
    });

    //渲染左侧数据
    function getlis() {
        var dictionaryStr = 'LIMIT_LEVEL';
        $.ajax({
            url: '/code/getCode?parentNo=JOB_LEVEL',
            type: 'get',
            dataType: 'json',
            success: function (res) {
                var data = res.obj;
                var str = ''
                for (var i = 0; i < data.length; i++) {

                    if (i == 0) {
                        str += '<li class="select" style="text-align: center;" plbDictNo="' + data[i].codeNo + '"   plbDictId="' + data[i].codeId + '">' + data[i].codeName + '</li>'
                        $('#limitTitle').find('span').text(data[0].codeName);
                    } else {
                        str += '<li style="text-align: center;" plbDictNo="' + data[i].codeNo + '"  plbDictId="' + data[i].codeId + '" >' + data[i].codeName + '</li>'
                    }
                }
                $('#questionTree').html(str);
                passLimit();
            }
        })
    }

    getlis();

    function passLimit() {
        layui.use(['table', 'layer', 'laydate', 'form', 'element', 'eleTree'], function () {
            var table = layui.table;
            var layer = layui.layer;
            form = layui.form;
            var laydate = layui.laydate;
            var eleTree = layui.eleTree;
            var element = layui.element;
            form.render();
            $('#questionTree').on('click', 'li', function (res) {
                $(this).addClass('select').siblings().removeClass('select');
                var limitTitle = $('.select').text();
                $('#limitTitle').find('span').text(limitTitle);
                var limitLevel = $('.select').attr('plbDictNo')
                if (limitLevel !== undefined) {
                    tableIns.reload({
                        where: { //设定异步数据接口的额外参数，任意设
                            limitLevel: limitLevel
                        }
                    });
                }
            })
            //右侧表格渲染
            var tableIns = table.render({
                elem: '#questionTable'
                , url: '/plbDeptBudgetLimit/selectAll'  //数据接口
                , where: {
                    limitLevel: $('.select').attr('plbDictNo'),
                }
                , parseData: function (res) { //res 即为原始返回的数据
                    return {
                        "code": 0, //解析接口状态
                        "data": res.data, //解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                }
                , page: true //开启分页
                , height: 'full-100'
                , toolbar: '#toolbar'
                , defaultToolbar: ['']
                , cols: [[ //表头
                    {type: 'checkbox'},
                    {field: 'costType', align: 'center', title: '费用类型', templet: function (d) {
                            return dictionaryObj['COST_TYPE']['object'][d.costType] || ''
                        }}
                    , {field: 'limitType', align: 'center', title: '限额类型', templet: function (d) {
                            return dictionaryObj['LIMIT_TYPE']['object'][d.limitType] || ''
                        }}
                    , {field: 'limitMoney', align: 'center', title: '限额'}
                    , {field: 'rideStandard', align: 'center', title: '乘坐标准', templet: function (d) {
                            return dictionaryObj['RIDE_STANDARD']['object'][d.rideStandard] || ''
                        }}
                ]]
                , limit: 10
                , request: {
                    pageName: 'page' //页码的参数名称，默认：page
                    , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                }
            });
            //监听事件
            table.on('toolbar(questionTable-table)', function (obj) {
                var checkStatus = table.checkStatus(obj.config.id);
                switch (obj.event) {
                    case 'add':
                        add(0)
                        break;
                }
                ;
            });
            table.on('toolbar(questionTable-table)', function (obj) {

                var checkStatus = table.checkStatus(obj.config.id);
                switch (obj.event) {
                    case 'add':
                        add(0)
                        break;
                    case 'edit':
                        if (checkStatus.data.length != 1) {
                            layer.msg('请选择一项！', {icon: 0});
                            return false
                        }
                        add(1, checkStatus.data[0])
                        break;
                    case 'del':
                        if (!checkStatus.data.length) {
                            layer.msg('请至少选择一项！', {icon: 0});
                            return false
                        }
                        var limitId = ''
                        checkStatus.data.forEach(function (v, i) {
                            limitId += v.limitId + ','
                        })
                        layer.confirm('确定删除该条数据吗？', function (index) {
                            $.post('/plbDeptBudgetLimit/delete', {limitIds: limitId}, function (res) {
                                if (res.flag) {
                                    layer.msg('删除成功！', {icon: 1});
                                } else {
                                    layer.msg('删除失败！', {icon: 0});
                                }
                                layer.close(index)
                                tableIns.config.where._ = new Date().getTime();
                                tableIns.reload()
                            })
                        });
                        break;
                    case 'export':
                        window.location.href = '/plbMtlPlan/outCurrentPageData?mtlPlanIds=' + exportData
                        break;
                }
            });

            function add(type, editData) {
                var title
                var url
                if (type == 0) {
                    title = '新增'
                    url = '/plbDeptBudgetLimit/insert'
                } else if (type == 1) {
                    title = '编辑'
                    url = '/plbDeptBudgetLimit/update'
                }
                layer.open({
                    type: 1,
                    title: title,
                    area: ['500px', '470px'],
                    btn: ['确定', '取消']
                    , maxmin: true,
                    content: '<div><form class="layui-form" action="" style="margin-top: 45px;\n' +
                        '    border: none;\n' +
                        '    padding-bottom: 30px;">\n' +

                        '               <div class="layui-col-xs8" style="width: 400px">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">费用类型</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                        <select name="costType" id="costType"></select>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '               <div class="layui-col-xs4" style="width: 400px">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">限额类型</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                        <select name="limitType" id="limitType"></select>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +

                        ' <div class="layui-form-item" style="margin-top: 15px;">\n' +
                        '    <label class="layui-form-label">限额</label>\n' +
                        '    <div class="layui-input-block" style="width: 270px;">\n' +
                        '      <input type="text" class="layui-input" id="limitMoney"  style="display: inline-block;">\n' +
                        '    </div>\n' +
                        '  </div>' +
                        '               <div class="layui-col-xs4" style="width: 400px">' +
                        '                   <div class="layui-form-item">\n' +
                        '                       <label class="layui-form-label form_label">乘坐标准</label>\n' +
                        '                       <div class="layui-input-block form_block">\n' +
                        '                        <select name="rideStandard" id="rideStandard"></select>' +
                        '                       </div>\n' +
                        '                   </div>' +
                        '               </div>' +
                        '</form></div>',
                    success: function () {

                        $('[name="costType"]').html(dictionaryObj['COST_TYPE']['str'])
                        $('[name="limitType"]').html(dictionaryObj['LIMIT_TYPE']['str'])
                        $('[name="rideStandard"]').html(dictionaryObj['RIDE_STANDARD']['str'])
                        //编辑回显
                        if (type == '1') {
                            $('#costType').val(editData.costType)
                            $('#limitType').val(editData.limitType)
                            $('#limitMoney').val(editData.limitMoney)
                            $('#rideStandard').val(editData.rideStandard)
                        }
                        form.render();
                    }
                    , yes: function (index) {
                        var costType = document.getElementById("costType").value
                        var limitType = document.getElementById("limitType").value
                        var limitMoney = document.getElementById("limitMoney").value
                        var rideStandard = document.getElementById("rideStandard").value
                        //var limitId =
                        var limitLevel = $('.select').attr('plbDictNo')
                        var params = {
                            costType: costType,
                            limitType: limitType,
                            limitMoney: limitMoney,
                            rideStandard: rideStandard,
                            limitLevel: limitLevel
                        }
                        if (type == 1) {
                            params.limitId = editData.limitId
                        }
                        $.ajax({
                            type: 'post',
                            url: url,
                            dataType: 'json',
                            data: params,
                            success: function (res) {
                                $('#query').trigger('click');
                                if (res.msg) {
                                    if (type == 0) {
                                        layer.msg('新增成功！', {icon: 1});
                                        layer.close(index);
                                        tableIns.reload()
                                    } else {
                                        layer.msg('修改成功！', {icon: 1});
                                        layer.close(index);
                                        tableIns.reload()
                                    }

                                }
                            }
                        })
                    }
                });
            }
        });
    }


    function resizeSize() {
        var height = $(window).height()
        $('#leftHeight').height(height-25)
    }

</script>