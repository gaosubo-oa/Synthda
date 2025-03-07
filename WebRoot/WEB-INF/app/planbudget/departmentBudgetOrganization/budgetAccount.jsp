<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>部门预算科目</title>
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
    <script type="text/javascript" src="/js/planbudget/common.js?20210421"></script>
    <style>
        html, body {
            width: 100%;
            height: 100%;
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
            min-height: 38px;
            padding: 2px 15px;
        }

        #leftHeight .layui-btn + .layui-btn {
            margin-left: 8px;
        }

        .query input, select {
            height: 35px;
        }

        .query button {
            float: left;
        }

        .layui-table-tool-temp {
            padding-right: 0px;
        }

        .query .layui-form-item {
            margin-bottom: 10px;
        }

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .field_required {
            color: red;
            font-size: 16px;
        }
    </style>
    <link rel="stylesheet" href="/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script type="text/javascript" src="/lib/zTree_v3/js/jquery.ztree.all.min.js"></script>

</head>
<body>
<form class="layui-form" action="" style="padding-top: 15px;box-sizing: border-box">
    <div class="query" style="display: flex">
        <div class="layui-form-item" style="margin-left: -17px">
            <label class="layui-form-label">科目名称:</label>
            <div class="layui-input-block">
                <input type="text" name="wbsName" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="authority_search" style="position: absolute;right: 8px; width: 200px;">
            <button type="button" class="layui-btn layui-btn-sm search" style="margin-left: 2%; width: 55px;">查询
            </button>
            <button type="button" class="layui-btn layui-btn-sm clear" style="margin-left: 20px;width: 55px;">重置
            </button>
        </div>
    </div>
</form>
<div class="layui-fluid" id="LAY-app-message">
    <input type="hidden" id="wbsId">
    <div class="layui-row ">
        <div class="layui-lf" style="width:270px;float:left">
            <div class="layui-card">
                <div class="layui-card-body" id="leftHeight">
                    <div style="margin-bottom:10px">
                        <button type="button" class="layui-btn layui-btn-sm plan" id="addPlan">新建</button>
                        <button type="button" class="layui-btn layui-btn-sm plan" id="editPlan">修改</button>
                        <button type="button" class="layui-btn layui-btn-sm" id="delPlan">删除</button>
                    </div>
                    <span style="text-align: center;display: block;font-weight: bold;cursor: pointer;" class="question">部门科目父级类型模板</span>
                    <ul id="questionTree" class="eleTree" lay-filter="questionTree"
                        style="overflow:auto;height:calc(100% - 30px)">
                    </ul>
                </div>
            </div>
        </div>
        <div class="layui-rt" style="width:calc(100% - 270px);float:left">
            <div class="tishi" style="height: 100%;text-align: center;border: none;">
                <div style="width:100%;padding-top:12%;"><img style="margin-top: 2%;text-align: center;"
                                                              src="/img/noData.png" alt=""></div>
                <h2 style="margin: auto;text-align: center;font-size: 20px;font-weight: normal;">请选择左侧科目类型模板</h2>
            </div>
            <div class="layui-card rightHeight" style="padding-left: 10px;display: none">
                <table id="questionTable" lay-filter="questionTable"></table>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="toolbar">
    <div style="float: right;margin-left: 10px;">
        <a class="layui-btn layui-btn-sm" lay-event="add" id="add">新增</a>
        <a class="layui-btn layui-btn-sm" lay-event="edit" id="edit">修改</a>
        <a class="layui-btn layui-btn-sm" lay-event="del" id="del">删除</a>
    </div>
</script>

<script>
    resizeSize();
    window.onresize = resizeSize;
    var dictionaryObj = {
        ITEM_LEVEL:{},
        ITEM_DIRECTION:{},
        DEPT_ITEM_TYPE:{},
        CBS_UNIT:{}
    }
    var dictionaryStr = 'ITEM_LEVEL,ITEM_DIRECTION,DEPT_ITEM_TYPE,CBS_UNIT';

    //数据字典类型
    $.ajax({
        url: '/plbDictonary/selectDictionaryByDictNos',
        dataType: 'json',
        type: 'get',
        async: false,
        data: {plbDictNos: dictionaryStr},
        success: function (res) {
            if (res.flag) {
                for (var dict in dictionaryObj) {
                    dictionaryObj[dict] = {object: {}, str: '<option value=""></option>'}
                    if (res.object[dict]) {
                        res.object[dict].forEach(function (item) {
                            dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                            dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                        });
                    }
                }
            }
        }
    })

    layui.use(['eleTree', 'table', 'layer', 'form', 'element', 'laydate', 'upload',], function () {
        var table = layui.table,
            form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            upload = layui.upload,
            eleTree = layui.eleTree,
            element = layui.element;
        var questionTable = null
        form.render();
        table.on('toolbar(questionTable)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            if (obj.event == 'edit' && checkStatus.data.length != 1) {
                layer.msg('请选择一项!', {icon: 0});
                return false;
            }
            switch (obj.event) {
                case 'edit':
                    if (checkStatus.data.length != 1) {
                        layer.msg('请选择一项！', {icon: 0});
                        return false
                    }
                    newOrEdit(1, checkStatus.data[0])
                    break;
                case 'add':
                    newOrEdit(0)
                    break;
                case 'del':
                    if (!checkStatus.data.length) {
                        layer.msg('请至少选择一项！', {icon: 0});
                        return false
                    }
                    var ids = ''
                    checkStatus.data.forEach(function (v, i) {
                        ids += v.deptItemId + ','
                    })
                    layer.confirm('确定删除该条数据吗？', function (index) {
                        $.ajax({
                            url: '/plbDeptBudgetItem/delete',
                            dataType: 'json',
                            type: 'post',
                            data: {deptItemIds: ids},
                            success: function (res) {
                                if (res.flag) {
                                    layer.msg('删除成功！', {icon: 1});
                                } else {
                                    layer.msg('删除失败！', {icon: 0});
                                }
                                layer.close(index)
                                questionTable.config.where._ = new Date().getTime();
                                questionTable.reload()
                            }
                        })
                    });
                    break;
                default:
                    break;
            }
        });
        var eleTreeLeft = eleTree.render({
            elem: '#questionTree',  //绑定元素
            url: '/plbDeptBudgetItem/getParentList?isLastLevel=0',
            showCheckbox: false,
            showLine: true,
            request: { // 修改数据为组件需要的数据
                name: "itemName", // 显示的内容
                key: "deptItemId", // 节点id
                parentId: 'parentItemId', // 节点父id
                children: 'child',
            },
            response: { // 修改响应数据为组件需要的数据
                statusName: "flag",
                statusCode: true,
                dataName: "data"
            },
            highlightCurrent: true,
        });

        function rightTable(deptItemId) {
            // console.log(deptItemId)
            questionTable = table.render({
                elem: '#questionTable'
                , url: '/plbDeptBudgetItem/selectAll'
                , where: {
                    parentItemId: deptItemId
                }
                , page: true //开启分页
                , limit: 50
                , height: 'full-180'
                , toolbar: '#toolbar'
                , defaultToolbar: ['']
                , cols: [[ //表头
                    {type: 'checkbox'}
                    , {field: 'itemNo', title: '科目编号', width: 200}
                    , {field: 'itemName', title: '科目名称', width: 150}
                    , {
                        field: 'itemLevel', title: '级次',  templet: function (d) {
                            return dictionaryObj['ITEM_LEVEL']['object'][d.itemLevel] || ''
                        }
                    }
                    , {
                        field: 'itemDirection', title: '方向', width: 150, templet: function (d) {
                            return dictionaryObj['ITEM_DIRECTION']['object'][d.itemDirection] || ''
                        }
                    }
                    , {field: 'valuationUnit', title: '计量单位', width: 150, templet: function (d) {
                            return dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || ''
                        }}
                    , {field: 'remarks', title: '备注',}
                ]], parseData: function (res) {
                    return {
                        "code": 0, //解析接口状态
                        "data": res.data,//解析数据列表
                        "count": res.totleNum, //解析数据长度
                    };
                },
                request: {
                    pageName: 'page' //页码的参数名称，默认：page
                    , limitName: 'pageSize' //每页数据量的参数名，默认：limit
                }
            });
        }

        // 节点点击事件
        eleTree.on("nodeClick(questionTree)", function (d) {
            // console.log(d.data.currentData)
            //所属上级
            $('#wbsId').attr('wbsId', d.data.currentData.deptItemId)
            $('#wbsId').attr('names', d.data.currentData.itemName)
            $('#addPlan').attr('wbsId', d.data.currentData.deptItemId)
            $('#editPlan').attr('parentWbsId', d.data.currentData.parentItemId)
            $('#editPlan').attr('wbsId', d.data.currentData.deptItemId)
            $('#editPlan').attr('wbsNo', d.data.currentData.itemNo)
            $('#editPlan').attr('wbsName', d.data.currentData.itemName)
            $('#editPlan').attr('wbsType', d.data.currentData.itemType)
            $('#delPlan').attr('wbsId', d.data.currentData.deptItemId)
            $('.layui-rt .rightHeight').show()
            $('.tishi').hide()
            rightTable(d.data.currentData.deptItemId)
        });
        //条件查询
        $('.search').click(function () {
            if (questionTable) {
                questionTable.reload({
                    url: '/plbDeptBudgetItem/selectAll',
                    where: {
                        itemName: $('[name="wbsName"]').val(),
                        _: new Date().getTime()
                    }
                })
            }
        })
        $('.clear').click(function () {
            $('[name="wbsName"]').val('');
            form.render();
            if (questionTable) {
                questionTable.reload({
                    url: '/plbWbsType/getDataByCondition',
                    where: {
                        itemName: $('[name="wbsName"]').val(),
                        _: new Date().getTime(),
                        parentItemId: $('#wbsId').attr('wbsId')
                    }
                })
            }
        });
        //删除树
        $('#delPlan').click(function () {
            var wbsId = $(this).attr('wbsId')
            layer.confirm('确定删除该模板吗？', function (index) {
                $.ajax({
                    url: '/plbDeptBudgetItem/delete',
                    dataType: 'json',
                    type: 'post',
                    data: {
                        deptItemIds: wbsId
                    },
                    success: function (res) {
                        if (res.flag) {
                            layer.msg('删除成功！', {icon: 1});
                            eleTreeLeft.reload()
                        } else {
                            layer.msg('删除失败！', {icon: 2});
                        }
                    }
                })
            });
        })
        //左侧新建/编辑树
        $('.plan').click(function () {
            var title = '';
            var url = ''
            if ($(this).text() == '新建') {
                title = '新建'
                url = '/plbDeptBudgetItem/insert'
            } else {
                title = '编辑'
                url = '/plbDeptBudgetItem/update'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['520px', '450px'],
                btn: ['确定', '取消'],
                content: ['<div style="padding: 20px;">' +
                '<form class="layui-form" action="" id="form">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label" style="width: 85px">科目编号<b field="itemNo" class="field_required" style="color: red">*</b><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                ' <div class="layui-input-block" style="margin-left: 115px">' +
                ' <input type="text" name="itemNo" readonly style="background: #e7e7e7" autocomplete="off"  class="layui-input" >' +
                ' </div>' +
                ' </div>' +
                ' <div class="layui-form-item">' +
                ' <label class="layui-form-label">科目名称<b style="color: red">*</b></label>' +
                '<div class="layui-input-block">' +
                '<input type="type" name="wbsName" autocomplete="off" class="layui-input testNull" title="WBS名称" >' +
                ' </div>' +
                ' </div>' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label">所属上级<b style="color: red">*</b></label>' +
                ' <div class="layui-input-block">' +
                '<input type="type" name="parentName" autocomplete="off" class="layui-input testNull" title="所属上级" readonly style="background:#e7e7e7;">' +
                ' </div>' +
                ' </div>' +
                '</form></div>'].join(''),
                success: function () {
                    if (title == '新建') {
                        //所属上级
                        if ($('#wbsId').attr('wbsId') && $('.eleTree-node-content-active').length == 1) {
                            $('[name="parentName"]').val($('#wbsId').attr('names'))
                        } else {
                            $('[name="parentName"]').val('已为一级')
                        }

                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbDeptBudgetItem'}, function(res) {
                            $('input[name="itemNo"]', $('#form')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbDeptBudgetItem'}, function(res) {
                                $('input[name="itemNo"]', $('#form')).val(res);
                            });
                        });

                    } else if (title == '编辑') {
                        var parentWbsId = $('#editPlan').attr('parentWbsId')
                        if (parentWbsId != '0') {
                            $.get('/plbDeptBudgetItem/queryId', {deptBudgetId: parentWbsId}, function (res) {
                                $('input[name="parentName"]').val(res.data.itemName);
                            })
                        } else {
                            $('[name="parentName"]').val('已为一级')
                        }
                        $('#form [name="wbsNo"]').val($('#editPlan').attr('wbsNo'))
                        $('#form [name="wbsName"]').val($('#editPlan').attr('wbsName'))
                        form.render()
                    }
                }, yes: function (index) {
                    //必填项提示
                    for (var i = 0; i < $('.testNull').length; i++) {
                        if ($('.testNull').eq(i).val() == '') {
                            layer.msg($('.testNull').eq(i).attr('title') + '为必填项！', {icon: 0});
                            return false
                        }
                    }

                    if($('#form [name="itemNo"]').val().length>10){
                        layer.msg('科目编号的长度不能超过10位！', {icon: 0});
                        return false
                    }
                    var data = {
                        itemNo: $('#form [name="itemNo"]').val(),
                        itemName: $('#form [name="wbsName"]').val(),
                        isLastLevel: 0,
                    }
                    if (title == '编辑') {
                        data.deptItemId = $('#editPlan').attr('wbsId')
                    } else {
                        data.parentItemId = $('#wbsId').attr('wbsId') || 0
                    }
                    $.ajax({
                        url: url,
                        dataType: 'json',
                        type: 'post',
                        data: data,
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});
                                layer.close(index)
                                eleTreeLeft.reload()
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        }
                    })
                }

            })

        })

        //右侧新建/编辑
        function newOrEdit(type, data) {
            var title
            var url = ''
            if (type == '0') {
                title = '新建'
                url = '/plbDeptBudgetItem/insert'
            } else if (type == '1') {
                title = '编辑'
                url = '/plbDeptBudgetItem/update'
            }
            layer.open({
                type: 1,
                title: title,
                area: ['80%', '65%'],
                maxmin: true,
                min: function () {
                    $('.layui-layer-shade').hide()
                },
                btn: ['保存', '取消'],
                content: ['<form class="layui-form" id="formRight" lay-filter="formTest" style="padding-right: 15px">' +
                //内容start
                //第一行
                '           <div class="layui-row" style="margin-top: 10px">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">科目编号<span field="itemNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="itemNo" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">科目名称</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <input type="text" name="itemName" autocomplete="off" class="layui-input">\n' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第二行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">计量单位</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <select name="valuationUnit"></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +

                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">级次</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <select name="itemLevel"></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +
                '           </div>' +
                //第三行
                '           <div class="layui-row">' +
                '               <div class="layui-col-xs6">' +
                '                   <div class="layui-form-item">\n' +
                '                       <label class="layui-form-label">方向</label>\n' +
                '                       <div class="layui-input-block">\n' +
                '                       <select name="itemDirection"></select>' +
                '                       </div>\n' +
                '                   </div>' +
                '               </div>' +


                '           </div>' +
                //内容end
                '</form>'].join(''),
                success: function () {
                    $('[name="itemLevel"]').html(dictionaryObj['ITEM_LEVEL']['str'])
                    $('[name="itemDirection"]').html(dictionaryObj['ITEM_DIRECTION']['str'])
                    $('[name="valuationUnit"]').html(dictionaryObj['CBS_UNIT']['str'])
                    //回显数据
                    if (type == 1) {
                        form.val("formTest", data);
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbDeptBudgetItem'}, function(res) {
                            $('input[name="itemNo"]', $('#formRight')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbDeptBudgetItem'}, function(res) {
                                $('input[name="itemNo"]', $('#formRight')).val(res);
                            });
                        });
                    }
                    form.render()
                },
                yes: function (index) {
                    if($('#formRight [name="itemNo"]').val().length>100){
                        layer.msg('科目编号的长度不能超过10位！', {icon: 0});
                        return false
                    }
                    var datas = $('#formRight').serializeArray()
                    var obj = {}
                    datas.forEach(function (item, index) {
                        obj[item.name] = item.value
                    })

                    obj.isLastLevel = 1

                    if (type == 1) {
                        obj.deptItemId = data.deptItemId
                    }else{
                        obj.parentItemId=$('#wbsId').attr('wbsId')
                    }
                    $.ajax({
                        url: url,
                        data: obj,
                        dataType: 'json',
                        type: 'post',
                        success: function (res) {
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});
                                layer.close(index);
                                questionTable.config.where._ = new Date().getTime();
                                questionTable.reload()
                            } else {
                                layer.msg('保存失败！', {icon: 0});
                            }
                        }
                    })
                },
            })
        }
    })

    function resizeSize() {
        $('#leftHeight').height($(window).height() - 160);
        $('.rightHeight').height($(window).height() - 140);
    }

    /**
     * 将毫秒数转为yyyy-MM-dd格式时间
     * @param t (时间戳)
     * @returns {string}
     */
    function format(t) {
        if (t) {
            return new Date(t).Format("yyyy-MM-dd");
        } else {
            return '';
        }
    }

</script>

</body>
</html>


