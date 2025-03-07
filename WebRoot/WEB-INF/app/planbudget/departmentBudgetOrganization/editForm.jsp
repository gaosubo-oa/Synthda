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
    <title>部门预算编制表单操作</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script type="text/javascript" src="/js/common/fileupload.js"></script>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            background: #fff;
        }

        /*伪元素是行内元素 正常浏览器清除浮动方法*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
            visibility: hidden;
        }

        .clearfix {
            *zoom: 1; /*ie6清除浮动的方式 *号只有IE6-IE7执行，其他浏览器不执行*/
        }

        .container {
            position: relative;
            width: 100%;
            height: 100%;
            padding: 15px 0 10px;
            box-sizing: border-box;
        }

        .wrapper {
            position: relative;
            width: 100%;
            height: 100%;
            padding: 0 8px;
            box-sizing: border-box;
        }

        .wrap_left {
            position: relative;
            float: left;
            width: 230px;
            height: 100%;
            padding-right: 10px;
            box-sizing: border-box;
        }

        .wrap_left h2 {
            line-height: 35px;
            text-align: center;
        }

        .wrap_left .left_form {
            position: relative;
            overflow: hidden;
        }

        .left_form .layui-input {
            height: 35px;
            margin: 10px 0;
            padding-right: 25px;
        }

        .tree_module {
            position: absolute;
            top: 90px;
            right: 10px;
            bottom: 0;
            left: 0;
            overflow: auto;
            box-sizing: border-box;
        }

        .eleTree-node-content {
            overflow: hidden;
            word-break: break-all;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .search_icon {
            position: absolute;
            top: 10px;
            right: 0;
            height: 35px;
            width: 25px;
            padding-top: 8px;
            text-align: center;
            cursor: pointer;
            box-sizing: border-box;
        }

        .search_icon:hover {
            color: #0aa3e3;
        }

        .wrap_right {
            position: relative;
            height: 100%;
            margin-left: 230px;
            overflow: auto;
        }

        .query_module .layui-input {
            height: 35px;
        }

        /* region 图标样式 */
        .icon_img {
            font-size: 25px;
            cursor: pointer;
        }

        .icon_img:hover {
            color: #0aa3e3;
        }
        /* endregion */

        .form_label {
            float: none;
            padding: 9px 0;
            text-align: left;
            width: auto;
        }

        .form_block {
            margin: 0;
        }

        .field_required {
            color: red;
            font-size: 16px;
        }

        .layer_wrap .layui_col {
            width: 20% !important;
            padding: 0 5px;
        }

        /* region 上传附件样式 */
        .file_upload_box {
            position: relative;
            height: 22px;
            overflow: hidden;
        }
        .open_file {
            float: left;
            position:relative;
        }
        .open_file input[type=file] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
            opacity: 0;
        }

        .progress {
            float: left;
            width: 200px;
            margin-left: 10px;
            margin-top: 2px;
        }

        .bar {
            width: 0%;
            height: 18px;
            background: green;
        }

        .bar_text {
            float: left;
            margin-left: 10px;
        }
        /* endregion */

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <form class="layui-form" lay-filter="baseForm" id="baseForm" style="padding: 0px 10px">
            <div class="layui-collapse">
                <div class="layui-colla-item"><h2 class="layui-colla-title">预算</h2>
                    <div class="layui-colla-content layui-show layui-form order_base_info" lay-filter="formTest">
                        <div class="layui-row">
                            <div class="layui-col-xs6" style="padding: 0 5px">
                                <div class="layui-form-item">
                                    <label class="layui-form-label form_label">部门预算编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>
                                    <div class="layui-input-block form_block">
                                        <input type="text" name="tgNo" autocomplete="off" readonly style="background: #e7e7e7" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-xs6" style="padding: 0 5px">
                                <div class="layui-form-item">
                                    <label class="layui-form-label form_label">部门预算名称<span class="field_required">*</span></label>
                                    <div class="layui-input-block form_block">
                                        <input type="text" name="tgName" autocomplete="off"  class="layui-input">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-row">
                            <div class="layui-col-xs6" style="padding: 0 5px">
                                <div class="layui-form-item">
                                    <label class="layui-form-label form_label">预算金额</label>
                                    <div class="layui-input-block form_block">
                                        <input type="text" name="budgetMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-col-xs6" style="padding: 0 5px">
                                <div class="layui-form-item">
                                    <label class="layui-form-label form_label">预算年度</label>
                                    <div class="layui-input-block form_block">
                                        <input type="text" name="budgetYear" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">
                                        <%--                                    <select id="budgetYear" name="budgetYear"></select>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="layui-row">
                            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                                <ul class="layui-tab-title">
                                    <li  class="layui-this">科目表</li>
                                    <li style="display: none">工作计划</li>
                                    <li >直接编制</li>
                                </ul>
                                <div class="layui-tab-content" >
                                    <div class="layui-tab-item layui-show">
                                        <div id="subjectModule">
                                            <table id="subjectTable" lay-filter="subjectTable"></table>
                                        </div>
                                    </div>
                                    <div class="layui-tab-item content"></div>
                                    <div class="layui-tab-item mtl_info">
                                        <div id="detailModule">
                                            <table id="detailTable" lay-filter="detailTable"></table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">加行</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>


<%--修编中编辑--%>
<script type="text/html" id="revisionBarDemo">
    {{#  if(!disabled){ }}
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="edit">编辑</a>
    {{#  } }}
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script>
    var budgetYear =  $.GetRequest()['budgetYear'] || '';
    var deptId = $.GetRequest()['deptId'] || '';
    var runId = parent.$.GetRequest()['runId'] || '';
    var disabled = $.GetRequest()['disabled'] || '';
    var deptBudgetIdBack
    var dictionaryObj = {
        CONTROL_TYPE: {},
        BUDGET_YEAR: {},
        RBS_TYPE: {},
        RBS_CATEGORY: {},
        CBS_LEVEL: {},
        CBS_UNIT: {},
        CONTROL_MODE: {},
        RBS_UNIT: {},
    }
    var dictionaryStr = 'CONTROL_TYPE,BUDGET_YEAR,RBS_TYPE,RBS_CATEGORY,CBS_LEVEL,CBS_UNIT,CONTROL_MODE,RBS_UNIT';
    $.get('/plbDictonary/selectDictionaryByDictNos', {plbDictNos: dictionaryStr}, function (res) {
        if (res.flag) {
            for (var dict in dictionaryObj) {
                dictionaryObj[dict] = {object: {}, str: ''}
                if (res.object[dict]) {
                    res.object[dict].forEach(function (item) {
                        dictionaryObj[dict]['object'][item.plbDictNo] = item.dictName;
                        if(dict=='BUDGET_YEAR'){
                            dictionaryObj[dict]['str'] += '<option value=' + item.dictName + '>' + item.dictName + '</option>';
                        }else{
                            dictionaryObj[dict]['str'] += '<option value=' + item.plbDictNo + '>' + item.dictName + '</option>';
                        }
                    });
                }
            }
        }
    });

    layui.use(['form', 'table', 'soulTable', 'eleTree','element','laydate'], function () {
        var layForm = layui.form,
            layTable = layui.table,
            eleTree = layui.eleTree,
            soulTable = layui.soulTable,
            layElement = layui.element,
            laydate = layui.laydate;
        layForm.render();

        var managementBudgetTable = null;
        if (runId) {
            $.ajax({
                url: '/plbDeptBudget/queryByRunId?runId=' + runId+'&deptType=01',
                async: false,
                success: function (res) {
                    if (res.flag) {
                        formData = res.obj[0]
                    }
                }
            })
            var materialDetailsTableData = [];
            layForm.val('baseForm', formData);
            //预算年度
            $('#budgetYear').html(dictionaryObj['BUDGET_YEAR']['str'])



            materialDetailsTableData = formData.plbDeptBudgetListWithBLOBs || [];
            subjectTable(formData.deptBudgetId);


            layElement.on('tab(docDemoTabBrief)',function(tabData){
                switch (tabData.index) {
                    case 0:
                        if(deptBudgetIdBack){
                            $.get('/plbDeptBudget/queryId',{deptBudgetId:deptBudgetIdBack},function (res) {
                                layForm.val("formTest", res.object);
                                materialDetailsTableData = res.object.plbDeptBudgetListWithBLOBs || [];
                                renderDetailTable();
                            })
                        }

                        break;
                    case 1:
                        var index=layer.load()
                        if(deptBudgetIdBack){
                            $.get('/plbDeptBudget/queryId',{deptBudgetId:deptBudgetIdBack},function (res) {
                                layForm.val("formTest", res.object);
                                materialDetailsTableData = res.object.plbDeptBudgetListWithBLOBs || [];
                                renderDetailTable();
                            })
                        }
                        var obj = {
                            tgNo: $('.order_base_info input[name="tgNo"]').val(),
                            tgName: $('.order_base_info input[name="tgName"]').val(),
                            budgetMoney: $('.order_base_info input[name="budgetMoney"]').val(),
                            budgetYear: $('#budgetYear').val(),
                            deptType:'01'
                        }

                        // 材料明细数据
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var materialDetailsArr = [];
                        $tr.each(function () {
                            var materialDetailsObj = {
                                rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                                budgetMoney: $(this).find('input[name="budgetMoney"]').val(), // 预算金额
                                controlType: $(this).find('input[name="controlType"]').attr('controlType'), // 控制方式
                                createStandard: $(this).find('input[name="createStandard"]').val(), // 编制标准
                                createRemark: $(this).find('input[name="createRemark"]').val(), // 编制说明
                                remark: $(this).find('input[name="remark"]').val(), // 备注
                                deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                            }
                            if ($(this).find('.remark').attr('deptBudgetListId')) {
                                materialDetailsObj.deptBudgetListId = $(this).find('.remark').attr('deptBudgetListId');
                            }
                            materialDetailsArr.push(materialDetailsObj);
                        });
                        obj.plbDeptBudgetListWithBLOBs = materialDetailsArr;
                        if (type == 2  || type == 3) {
                            obj.deptBudgetId = data.deptBudgetId
                        }else if(type == 1){
                            obj.deptId = parseInt(deptId);
                            obj.deptBudgetId = deptBudgetIdBack
                        }
                        $.ajax({
                            url: url,
                            data: JSON.stringify(obj),
                            dataType: 'json',
                            contentType: "application/json;charset=UTF-8",
                            type: 'post',
                            success:function(res){
                                layer.close(index)
                                url = '/plbDeptBudget/update'
                                materialDetailsTableData = res.data.plbDeptBudgetListWithBLOBs || [];
                                var backData=res.data
                                deptBudgetIdBack=backData.deptBudgetId
                                if(res.flag){
                                    var pltDate=$('[name="budgetYear"]').val();
                                    var iframeSrc='/pltTaskInfo/pltDetailList?deptId='+deptId+'&pltDate'+pltDate+'&pltType=02'
                                    var innerHtml='<iframe style="width: 100%;height: 500px" src="'+iframeSrc+'"></iframe>'
                                    $('.content').html(innerHtml)
                                    renderDetailTable()
                                }
                            }
                        })
                        break;
                    case 2:
                        if(deptBudgetIdBack){
                            $.get('/plbDeptBudget/queryId',{deptBudgetId:deptBudgetIdBack},function (res) {
                                layForm.val("formTest", res.object);
                                materialDetailsTableData = res.object.plbDeptBudgetListWithBLOBs || [];
                                renderDetailTable();
                            })
                        }else{
                            renderDetailTable();
                        }

                        break;
                }
            })
            renderDetailTable();
            layElement.render();
            //初始化科目表
            function subjectTable(deptBudgetId){
                var cols=[
                    {type: 'numbers', title: '序号',},
                    {
                        field: 'rbsItemName',
                        title: '预算科目名称',
                        minWidth: 120,
                        templet: function (d) {
                            return '<span>'+isShowNull(d.rbsItemName)+'</span>'
                        }
                    },
                    {
                        field: 'cbsName',
                        title: '会计科目名称',
                        minWidth: 120,
                        templet: function (d) {
                            return '<span>'+isShowNull(d.cbsName)+'</span>'
                        }
                    },
                    {
                        field: 'budgetMoney', title: '本年预算金额', minWidth: 120, templet: function (d) {
                            return '<span>'+isShowNull(d.budgetMoney)+'</span>'
                        }
                    },
                ]
                if(type!=4){
                    cols.push({align: 'center', toolbar: '#subjectBarDemo', title: '明细', width: 100})
                }
                layTable.render({
                    elem: '#subjectTable',
                    url: '/plbDeptBudget/queryByDeptBudgetId?deptBudgetId='+deptBudgetId,
                    defaultToolbar: [''],
                    limit: 1000,
                    cols: [cols],
                    parseData:function(res){
                        return {
                            "code":0,
                            "data": res.object.plbDeptBudgetListWithBLOBs,
                        };
                    },
                    done:function () {
                        if(type==4){
                            $('.addRow').hide()
                        }
                    }
                });
            }
            // 初始化预算明细列表
            function renderDetailTable() {
                var cols=[
                    {type: 'numbers', title: '序号',},
                    {
                        field: 'rbsItemId',
                        title: '预算科目名称',
                        minWidth: 120,
                        templet: function (d) {
                            return '<input type="text" name="rbsItemId"  rbsItemId="'+(d.rbsItemId || '')+'"  value="'+(d.rbsItemName || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%;" >'
                        }
                    },
                    {
                        field: 'cbsId',
                        title: '会计科目名称',
                        minWidth: 120,
                        templet: function (d) {
                            return '<input type="text" name="cbsId" cbsId="'+(d.cbsId || '')+'"   value="'+(d.cbsName || '')+'"  readonly autocomplete="off" class="layui-input '+(type == '4' ? '' :'cbsIdChoose')+'" style="height: 100%; cursor: pointer;" >'
                        }
                    },
                    {
                        field: 'budgetMoney', title: '预算金额', minWidth: 120, templet: function (d) {
                            return '<input type="number" name="budgetMoney" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input budgetMoneyItem" style="height: 100%" value="' + (d.budgetMoney || '') + '">'
                        }
                    },
                    // {
                    //     field: 'rbsUnit', title: '单位', minWidth: 80, templet: function (d) {
                    //         return '<span rbsUnit="'+(d.rbsUnit || '')+'">'+(dictionaryObj['RBS_UNIT']['object'][d.rbsUnit] || '')+'</span>'
                    //     }
                    // },
                    {
                        field: 'controlType',
                        title: '控制方式',
                        minWidth: 120,
                        event: type==4 ? '' : 'chooseControlType',
                        templet: function (d) {
                            return '<input type="text" name="controlType" controlType="'+(d.controlType || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" value="'+(dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '')+'" >'
                        }
                    },
                    {
                        field: 'createStandard', title: '编制标准', minWidth: 120, templet: function (d) {
                            return '<input type="text" name="createStandard" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createStandard || '') + '">'
                        }
                    },
                    {
                        field: 'createRemark', title: '编制说明', minWidth: 120, templet: function (d) {
                            return '<input type="text" name="createRemark" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createRemark || '') + '">'
                        }
                    },
                    {
                        field: 'remark', title: '备注', minWidth: 120, templet: function (d) {
                            return '<input type="text" name="remark" '+(type==4 ? 'readonly' : '')+' deptBudgetListId="'+(d.deptBudgetListId || '')+'"  autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.remark || '') + '">'
                        }
                    },
                ]
                // if(type!=4){
                //     cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                // }
                layTable.render({
                    elem: '#detailTable',
                    data: materialDetailsTableData,
                    toolbar: '#toolbarDemoIn',
                    defaultToolbar: [''],
                    limit: 1000,
                    cols: [cols],
                    done:function () {
                        // if(type==4){
                        //     $('.addRow').hide()
                        // }
                        $('.addRow').hide()
                        $('input').attr('disabled','true')
                    }
                });
            }

            layForm.render();
        } else {
            layer.msg('获取信息失败！', {icon: 0});

        }


        //工具条事件
        layTable.on('tool(managementBudgetTable)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if(layEvent === 'edit'){ //编辑
                addOrEdit(2,data)
            }else if(layEvent === 'detail'){
                $.get('/plbDeptBudget/queryId',{deptBudgetId:data.deptBudgetId,deptType:'01'},function (res) {
                    addOrEdit(4,res.object)
                })
            }
        });




        //监听预算金额
        $(document).on('blur', '.budgetMoneyItem', function () {
            var $tr = $('.mtl_info').find('.layui-table-main tr');
            var budgetMoney=0
            $tr.each(function () {
                budgetMoney=accAdd(budgetMoney,$(this).find('input[name="budgetMoney"]').val())
            });
            $('.order_base_info [name="budgetMoney"] ').val(budgetMoney)
        });


        /*用来得到精确的加法结果
            *说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
            *调用：accAdd(arg1,arg2)
            *返回值：arg1加上arg2的精确结果
        */
        function accAdd(arg1,arg2){
            var r1,r2,m;
            try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
            try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
            m=Math.pow(10,Math.max(r1,r2))
            return (arg1*m+arg2*m)/m
        }

        $(document).on('click', '.cbsIdChoose', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择',
                area: ['70%', '80%'],
                maxmin: true,
                btn: ['确定', '取消'],
                btnAlign: 'c',
                content: ['<div class="container">',
                    '<div class="wrapper">',
                    '<div class="wrap_left">' +
                    '<div class="layui-form">' +
                    '<select id="mtlTypeTree" lay-filter="mtlTypeTree"></select>' +
                    '<div class="tree_module" style="top: 10px;">' +
                    '<div id="chooseMtlTree" class="eleTree" lay-filter="chooseMtlTree"></div>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="wrap_right">' +
                    '<div class="mtl_table_box" style="display: none;">' +
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
                    '<div class="mtl_no_data" style="text-align: center;">' +
                    '<div class="no_data_img">' +
                    '<img style="margin-top: 12%;" src="/img/noData.png">' +
                    '</div>' +
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧</p>' +
                    '</div>' +
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
                    // 树节点点击事件
                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                        var currentData = d.data.currentData;
                        if (currentData.cbsNo) {
                            $('.mtl_no_data').hide();
                            $('.mtl_table_box').show();
                            loadMtlTable(currentData.cbsNo);
                        } else {
                            $('.mtl_table_box').hide();
                            $('.mtl_no_data').show();
                        }
                    });

                    loadMtlType();

                    function loadMtlType() {
                        // 获取左侧树
                        $.get('/plbCbsType/getParentList', function (res) {
                            if (res.flag) {
                                eleTree.render({
                                    elem: '#chooseMtlTree',
                                    data: res.data,
                                    highlightCurrent: true,
                                    showLine: true,
                                    defaultExpandAll: true,
                                    request: {
                                        name: "cbsName", // 显示的内容
                                        key: "cbsNo", // 节点id
                                        parentId: 'parentCbsNo', // 节点父id
                                        isLeaf: "isLeaf",// 是否有子节点
                                        children: 'childList',
                                    }
                                });
                            }
                        });
                    }

                    function loadMtlTable(cbsNo) {
                        layTable.render({
                            elem: '#materialsTable',
                            url: '/plbCbsType/getCbsTypeList',
                            where: {
                                cbsNo:cbsNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            height: 'full-300',
                            cellMinWidth:100,
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'cbsNo', title: 'CBS编码', width: 200}
                                , {field: 'cbsName', title: 'CBS名称',  width: 150}
                                , {field: 'cbsLevel', title: 'CBS级别', width: 150,templet:function (d) {
                                        return dictionaryObj['CBS_LEVEL']['object'][d.cbsLevel] || ''
                                    }}
                                , {field: 'cbsUnit', title: 'CBS单位', width: 150,templet:function (d) { return dictionaryObj['CBS_UNIT']['object'][d.cbsUnit] || '' }}
                                , {field: 'controlMode', title: '控制方式',templet:function (d) { return dictionaryObj['CONTROL_MODE']['object'][d.controlMode] || '' }},

                            ]],
                            parseData: function (res) {
                                return {
                                    "code": 0, //解析接口状态
                                    "data": res.data,//解析数据列表
                                    "count": res.totleNum, //解析数据长度
                                };
                            },
                            request: {
                                pageName: 'page', //页码的参数名称，默认：page
                                limitName: 'pageSize' //每页数据量的参数名，默认：limit
                            },
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = layTable.checkStatus('materialsTable');
                    if (checkStatus.data.length > 0) {
                        var mtlData = checkStatus.data[0];
                        //部门预算编制中,每一个部门下，同一年份，一个科目只允许编制一次
                        /*var budgetYear=$('#budgetYear').val()
                        var cbsIds=mtlData.cbsId
                        $.get('/plbDeptBudget/checkCbs',{deptId:deptId,budgetYear:budgetYear,cbsIds:cbsIds},function (res) {
                            if(res.object > 0){
                                layer.msg('每一个部门下，同一年份，一个科目只允许编制一次！', {icon: 0, time: 2000});
                            }else{
                                _this.val(mtlData.cbsName);
                                _this.attr('cbsId',mtlData.cbsId);
                                layer.close(index);
                            }
                        })*/

                        _this.val(mtlData.cbsName);
                        _this.attr('cbsId',mtlData.cbsId);
                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }
            });
        });
    });
</script>
</body>
</html>