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
    <title>部门预算变更表单操作</title>

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
    </style>
</head>
<body>
<div class="container">
    <input type="hidden" id="leftId" class="layui-input">
    <div class="wrapper">
        <div style="position: relative">
            <div class="table_box" style="padding: 10px">
                <table id="managementBudgetTable" lay-filter="managementBudgetTable"></table>
            </div>
        </div>
    </div>
</div>

<%--修编中编辑--%>
<script type="text/html" id="revisionBarDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="edit">编辑</a>
</script>

<script>
    var budgetYear =  $.GetRequest()['budgetYear'] || '';
    var deptId = $.GetRequest()['deptId'] || '';

    var dictionaryObj = {
        CONTROL_TYPE: {},
        BUDGET_YEAR: {},
    }
    var dictionaryStr = 'CONTROL_TYPE,BUDGET_YEAR';
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


        managementBudgetTable=layTable.render({
            elem: '#managementBudgetTable',
            url:'/plbDeptBudget/getEdit',
            cols: [[
                {field: 'tgNo', title: '部门预算编号',},
                {field: 'tgName', title: '部门预算名称',},
                {field: 'budgetMoney', title: '预算金额', },
                {field: 'budgetYear', title: '预算年度',templet:function (d) {
                        return dictionaryObj['BUDGET_YEAR']['object'][d.budgetYear] || '';
                    }},
                {field: 'approvalStatus', title: '审批状态',templet: function (d) {
                        if (d.approvalStatus == '0') {
                            return '待审批';
                        } else if (d.approvalStatus == '1') {
                            return '批准';
                        } else if (d.approvalStatus == '2') {
                            return '不批准';
                        }else {
                            return ''
                        }
                    }},
                {title:'操作', width:100,align:'center', toolbar: '#revisionBarDemo'}
            ]],
            limit:1000,
            where:{budgetYear:budgetYear,flag:1,deptId:deptId},
            parseData: function (res) { //res 即为原始返回的数据
                return {
                    "code": 0, //解析接口状态
                    "data": res.data, //解析数据列表
                };
            },
        });

        //工具条事件
        layTable.on('tool(managementBudgetTable)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）

            if(layEvent === 'edit'){ //编辑
                addOrEdit(3,data)
            }
        });

        /**
         * 新增/编辑方法
         * @param type (1-新增，2-编辑,3-修编)
         * @param data (编辑时的预算信息)
         */
        function addOrEdit(type, data) {
            var title = '';
            var url = '';
            var deptId = $('#leftId').attr('deptId');
            if (type == 1) {
                title = '新增预算'
                url = '/plbDeptBudget/insert'
            } else if (type == 2) {
                title = '编辑预算'
                url = '/plbDeptBudget/update'
            }
            else if (type == 3) {
                title = '编辑预算'
                url = '/plbDeptBudget/updateRevision'
            }

            layer.open({
                type: 1,
                title: title,
                area: ['100%', '100%'],
                btn: ['保存', '取消'],
                btnAlign: 'c',
                content: ['<div class="layer_wrap"><div class="layui-collapse">',
                    /* region 预算 */
                    '<div class="layui-colla-item"><h2 class="layui-colla-title">预算</h2>' +
                    '<div class="layui-colla-content layui-show layui-form order_base_info" lay-filter="formTest">',
                    /* region 第一行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">部门预算编号<span class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="tgNo" autocomplete="off" readonly style="background: #e7e7e7" class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">部门预算名称<span class="field_required">*</span></label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="tgName" autocomplete="off"  class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    /* region 第二行 */
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">预算金额</label>' +
                    '<div class="layui-input-block form_block">' +
                    '<input type="text" name="budgetMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '<div class="layui-col-xs6" style="padding: 0 5px">' +
                    '<div class="layui-form-item">' +
                    '<label class="layui-form-label form_label">预算年度</label>' +
                    '<div class="layui-input-block form_block">' +
                    '<select id="budgetYear" name="budgetYear"></select>' +
                    '</div>' +
                    '</div>' +
                    '</div>',
                    '</div>',
                    /* endregion */
                    '</div>' +
                    '</div>',
                    /* endregion */
                    /* region 预算明细 */
                    '<div class="layui-colla-item"><h2 class="layui-colla-title">预算明细</h2>' +
                    '<div class="layui-colla-content layui-show mtl_info">' +
                    '<div id="detailModule"><table id="detailTable" lay-filter="detailTable"></table></div>' +
                    '</div>' +
                    '</div>',
                    /* endregion */
                    '</div></div>'].join(''),
                success: function () {
                    //预算年度
                    $('#budgetYear').html(dictionaryObj['BUDGET_YEAR']['str'])
                    layForm.render()

                    var materialDetailsTableData = [];

                    // 编辑时显示数据
                    if (type == 2 ||type == 3) {
                        layForm.val("formTest", data);
                        materialDetailsTableData = data.plbDeptBudgetListWithBLOBs;
                    }else{
                        // 获取自动编号
                        getAutoNumber({autoNumber: 'plbDeptBudget'}, function(res) {
                            $('input[name="tgNo"]', $('.order_base_info')).val(res);
                        });
                        $('.refresh_no_btn').show().on('click', function() {
                            getAutoNumber({autoNumber: 'plbDeptBudget'}, function(res) {
                                $('input[name="tgNo"]', $('.order_base_info')).val(res);
                            });
                        });
                    }


                    renderDetailTable();

                    layElement.render();

                    // 初始化预算明细列表
                    function renderDetailTable() {
                        layTable.render({
                            elem: '#detailTable',
                            data: materialDetailsTableData,
                            toolbar: '#toolbarDemoIn',
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [[
                                {type: 'numbers', title: '序号',},
                                {
                                    field: 'budgetItemId',
                                    title: '预算科目',
                                    minWidth: 120,
                                    event: 'chooseBudgetItemId',
                                    templet: function (d) {
                                        return '<input type="text" name="budgetItemId" budgetItemId="'+(d.budgetItemId || '')+'"  value="'+(d.budgetItemName || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" >'
                                    }
                                },
                                {
                                    field: 'budgetMoney', title: '预算金额', minWidth: 120, templet: function (d) {
                                        return '<input type="number" name="budgetMoney" autocomplete="off" class="layui-input budgetMoneyItem" style="height: 100%" value="' + (d.budgetMoney || '') + '">'
                                    }
                                },
                                {
                                    field: 'controlType',
                                    title: '控制方式',
                                    minWidth: 120,
                                    event: 'chooseControlType',
                                    templet: function (d) {
                                        return '<input type="text" name="controlType" controlType="'+d.controlType+'"  readonly autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" value="'+(dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '')+'" >'
                                    }
                                },
                                {
                                    field: 'createStandard', title: '编制标准', minWidth: 120, templet: function (d) {
                                        return '<input type="text" name="createStandard" autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createStandard || '') + '">'
                                    }
                                },
                                {
                                    field: 'createRemark', title: '编制说明', minWidth: 120, templet: function (d) {
                                        return '<input type="text" name="createRemark" autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createRemark || '') + '">'
                                    }
                                },
                                {
                                    field: 'remark', title: '备注', minWidth: 120, templet: function (d) {
                                        return '<input type="text" name="remark" deptBudgetListId="'+(d.deptBudgetListId || '')+'" autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.remark || '') + '">'
                                    }
                                },
                                {align: 'center', toolbar: '#barDemo', title: '操作', width: 100}
                            ]]
                        });
                    }
                },
                yes: function (index) {
                    var loadIndex = layer.load();
                    // 材料订单数据
                    var obj = {
                        tgNo: $('.order_base_info input[name="tgNo"]').val(),
                        tgName: $('.order_base_info input[name="tgName"]').val(),
                        budgetMoney: $('.order_base_info input[name="budgetMoney"]').val(),
                        budgetYear: $('#budgetYear').val(),
                    }

                    // 材料明细数据
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var materialDetailsArr = [];
                    $tr.each(function () {
                        var materialDetailsObj = {
                            budgetItemId: $(this).find('input[name="budgetItemId"]').attr('budgetItemId'), // 预算科目Id
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
                    }

                    $.ajax({
                        url: url,
                        data: JSON.stringify(obj),
                        dataType: 'json',
                        contentType: "application/json;charset=UTF-8",
                        type: 'post',
                        success: function (res) {
                            layer.close(loadIndex);
                            if (res.flag) {
                                layer.msg('保存成功！', {icon: 1});
                                layer.close(index);
                                if(type==3){
                                    managementBudgetTable.config.where._ = new Date().getTime();
                                    managementBudgetTable.reload();
                                }else{

                                }
                            } else {
                                layer.msg('保存失败！', {icon: 2});
                            }
                        }
                    });
                },
            });
        }

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
    });
</script>
</body>
</html>