<%--
  Created by IntelliJ IDEA.
  User: 小小木
  Date: 2022/2/17
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>部门预算变更查看详情页面</title>
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
    <script src="../js/jquery/jquery.cookie.js"></script>

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
            box-sizing: border-box;
        }

        .wrapper {
            position: absolute;
            top: 0;
            left: 0;
            bottom: 60px;
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            overflow: auto;
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
        .footer {
            position: absolute;
            left: 0;
            bottom: 0;
            width: 100%;
            height: 60px;
            line-height: 60px;
            text-align: center;
            background-color: #fff;
        }
    </style>
</head>
<body>
<div class=" container">
    <div class="wrapper">
        <div class="layui-collapse">
            <div class="layui-colla-item"><h2 class="layui-colla-title">预算</h2>
                <form class="layui-colla-content layui-show layui-form order_base_info" lay-filter="formTest" id="formTest">
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
                                    <select id="budgetYear" name="budgetYear"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="layui-colla-item"><h2 class="layui-colla-title">预算明细</h2>
                <div class="layui-colla-content layui-show mtl_info">
                    <div id="detailModule"><table id="detailTable" lay-filter="detailTable"></table></div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer" >
        <button type="button" class="layui-btn layui-btn-normal" id="saveBtn">保存</button>
    </div>
</div>


<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add" >加行</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" >删行</a>
</script>
<script>
    // var type=getUrlParam('type');
    var type = $.GetRequest()['type'] || ''
    // var reviseId=getUrlParam('reviseId');
    var reviseId = $.GetRequest()['reviseId'] || '';
    console.log(reviseId)
    var runId=getUrlParam('runId');
    var _disabled=$.GetRequest()['disabled'] || '';

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
            initData();
        }
    });

    var formData;
    var materialDetailsTableData;
    //预算明细表
    var cols=[
        {type: 'numbers', title: '序号',},
        {
            field: 'rbsItemId',
            title: '预算科目名称',
            minWidth: 120,
            templet: function (d) {
                return '<input type="text" name="rbsItemId"  rbsItemId="'+(d.rbsItemId || '')+'" value="'+(d.rbsItemName || '')+'"  readonly autocomplete="off" class="layui-input" style="height: 100%;" >'
            }
        },
        {
            field: 'cbsId',
            title: '会计科目名称',
            minWidth: 120,
            templet: function (d) {
                return '<input type="text" name="cbsId" cbsId="'+(d.cbsId || '')+'"   value="'+(d.cbsName || '')+'"  readonly autocomplete="off" class="layui-input '+(type == '2' ? '' : 'cbsIdChoose')+'" style="height: 100%; cursor: pointer;" >'
            }
        },
        {
            field: 'budgetMoney', title: '预算金额', minWidth: 120, templet: function (d) {
                return '<input type="number" name="budgetMoney" '+(type==2 ? 'readonly' : '')+' autocomplete="off" class="layui-input budgetMoneyItem" style="height: 100%" value="' + (d.budgetMoney || '') + '">'
            }
        },
        {
            field: 'controlType',
            title: '控制方式',
            minWidth: 120,
            event: type==4 ? '' : 'chooseControlType',
            templet: function (d) {
                return '<input type="text" name="controlType" controlType="'+(d.controlType || '')+'"   autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" value="'+(dictionaryObj['CONTROL_TYPE']['object'][d.controlType] || '')+'" >'
            }
        },
        {
            field: 'createStandard', title: '编制标准', minWidth: 120, templet: function (d) {
                return '<input type="text" name="createStandard" '+(type==2 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createStandard || '') + '">'
            }
        },
        {
            field: 'createRemark', title: '编制说明', minWidth: 120, templet: function (d) {
                return '<input type="text" name="createRemark" '+(type==2 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.createRemark || '') + '">'
            }
        },
        {
            field: 'remark', title: '备注', minWidth: 120, templet: function (d) {
                return '<input type="text" name="remark" '+(type==2 ? 'readonly' : '')+' deptBudgetListId="'+(d.deptBudgetListId || '')+'" autocomplete="off" class="layui-input" style="height: 100%" value="' + (d.remark || '') + '">'
            }
        },
    ]
    function initData(){
        layui.use(['form','table',],function(){
            var form=layui.form;
            var table=layui.table;
            //预算年度
            $('#budgetYear').html(dictionaryObj['BUDGET_YEAR']['str'])
            form.render()
            if(reviseId){
                $.ajax({
                    url:'/plbDeptBudget/getDataByReviseId?reviseId='+reviseId,
                    async:false,
                    success:function(res){
                        formData=res.data
                        materialDetailsTableData=res.data.plbDeptBudgetListWithBLOBs
                    }
                })
                form.val("formTest", formData);
                $('#saveBtn').hide();
                table.render({
                    elem: '#detailTable',
                    data: materialDetailsTableData,
                    toolbar: '#toolbarDemoIn',
                    defaultToolbar: [''],
                    limit: 1000,
                    cols: [cols],
                });
                $('.addRow').hide();
                $('input').attr('disabled',true);
                $('select').attr('disabled',true);
            }else if(runId){
                $.ajax({
                    url:'/plbDeptBudget/getEditByRunId?runId='+runId,
                    success:function(res){
                        cols.push({align: 'center', toolbar: '#barDemo', title: '操作', width: 100})
                        formData=res.data;
                        materialDetailsTableData=formData[0].plbDeptBudgetListWithBLOBs;
                        form.val("formTest", formData[0]);
                        table.render({
                            elem: '#detailTable',
                            data: materialDetailsTableData,
                            toolbar: '#toolbarDemoIn',
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols],
                            done:function(){

                            }
                        });

                        form.render();
                    }
                })
            }
            // 内部加行按钮
            table.on('toolbar(detailTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        layer.open({
                            type: 1,
                            title: '选择RBS',
                            area: ['60%', '70%'],
                            maxmin: true,
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: ['<div style="padding: 0px 10px">'+
                            '<div class="query_module_in layui-form layui-row" style="padding:10px">\n' +
                            '                <div class="layui-col-xs3">\n' +
                            '                    <input type="text" name="cbsName" placeholder="会计科目名称" autocomplete="off" class="layui-input">\n' +
                            '                </div>\n' +
                            '                <div class="layui-col-xs3" style="margin-left: 10px">\n' +
                            '                    <input type="text" name="rbsItemName" placeholder="预算科目名称" autocomplete="off" class="layui-input">\n' +
                            '                </div>\n' +
                            '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                            '                    <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                            '                </div>\n' +
                            '</div>' +
                            '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                            '</div>'].join(''),
                            success: function () {
                                loadMtlTable();

                                function loadMtlTable(cbsName,rbsItemName) {
                                    table.render({
                                        elem: '#materialsTable',
                                        url: '/plbRbsItem/selectAll',
                                        where: {
                                            rbsTypeId: '01',
                                            useFlag:true,
                                            cbsName:cbsName,
                                            rbsItemName:rbsItemName
                                        },
                                        page: true,
                                        response: {
                                            statusName: 'flag',
                                            statusCode: true,
                                            msgName: 'msg',
                                            countName: 'totleNum',
                                            dataName: 'data'
                                        },
                                        cols: [[
                                            {type: 'checkbox', title: '选择'},
                                            {field: 'cbsName', title: '会计科目名称'},
                                            {field: 'rbsItemName', title: '预算科目名称'},
                                            {field:'rbsTypeName',title:'科目类型'},
                                        ]]
                                    });
                                }

                                $(document).on('click','.inSearchData',function () {
                                    var cbsName=$('.query_module_in [name="cbsName"]').val()
                                    var rbsItemName=$('.query_module_in [name="rbsItemName"]').val()
                                    loadMtlTable(cbsName,rbsItemName);
                                });
                            },
                            yes: function (index) {
                                var checkStatus = table.checkStatus('materialsTable');
                                if (checkStatus.data.length > 0) {
                                    var trData = checkStatus.data;

                                    //遍历表格获取每行数据进行保存
                                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                                    var oldDataArr = []
                                    $tr.each(function () {
                                        var oldDataObj = {
                                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                                            budgetMoney: $(this).find('input[name="budgetMoney"]').val(), // 预算金额
                                            rbsUnit: $(this).find('[data-field="rbsUnit"] span').attr('rbsUnit'), // 单位
                                            controlType: $(this).find('input[name="controlType"]').attr('controlType'), // 控制方式
                                            createStandard: $(this).find('input[name="createStandard"]').val(), // 编制标准
                                            createRemark: $(this).find('input[name="createRemark"]').val(), // 编制说明
                                            remark: $(this).find('input[name="remark"]').val(), // 备注
                                            deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                                        }
                                        oldDataArr.push(oldDataObj);
                                    });
                                    /*var addRowData = {};
                                    oldDataArr.push(addRowData);*/
                                    //具体明细可多选
                                    trData.forEach(function (item) {
                                        var addRowData={
                                            rbsItemId: item.rbsItemId,//rbsId
                                            rbsItemName: item.rbsItemName,//rbs名称
                                            cbsId: item.cbsId,// cbsId
                                            cbsName: item.cbsName,//cbs名称
                                            rbsUnit: item.rbsUnit,//单位
                                        }
                                        oldDataArr.push(addRowData)
                                    })
                                    table.reload('detailTable', {
                                        data: oldDataArr
                                    });

                                    layer.close(index);
                                } else {
                                    layer.msg('请选择一项！', {icon: 0});
                                }
                            }
                        });
                        break;
                }
            });
            // 内部删行操作
            table.on('tool(detailTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                var $tr = obj.tr;
                if (layEvent === 'del') {
                    obj.del();
                    if (data.deptBudgetListId) {
                        $.get('/plbDeptBudget/deleteListId', {deptBudgetListId: data.deptBudgetListId}, function (res) {

                        });
                    }
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            rbsItemId: $(this).find('input[name="rbsItemId"]').attr('rbsItemId'), // rbsId
                            rbsItemName: $(this).find('input[name="rbsItemId"]').val(), // rbsId名称
                            cbsId: $(this).find('input[name="cbsId"]').attr('cbsId'), // cbsId
                            cbsName: $(this).find('input[name="cbsId"]').val(), // cbsId名称
                            budgetMoney: $(this).find('input[name="budgetMoney"]').val(), // 预算金额
                            rbsUnit: $(this).find('[data-field="rbsUnit"] span').attr('rbsUnit'), // 单位
                            controlType: $(this).find('input[name="controlType"]').attr('controlType'), // 控制方式
                            createStandard: $(this).find('input[name="createStandard"]').val(), // 编制标准
                            createRemark: $(this).find('input[name="createRemark"]').val(), // 编制说明
                            remark: $(this).find('input[name="remark"]').val(), // 备注
                            deptBudgetListId: $(this).find('input[name="remark"]').attr('deptBudgetListId'), // 预算明细主键
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    table.reload('detailTable', {
                        data: oldDataArr
                    });
                }else if (layEvent === 'chooseControlType') {
                    layer.open({
                        type: 1,
                        title: '选择控制方式',
                        area: ['400px', '400px'],
                        btn: ['确定', '取消'],
                        btnAlign: 'c',
                        content: '<div style="padding: 0 10px"><table id="chooseQualityRequirement" lay-filter="chooseQualityRequirement"></table></div>',
                        success: function () {
                            var dataArr = []
                            $.each(dictionaryObj['CONTROL_TYPE']['object'], function (k, o) {
                                var obj = {
                                    qualityRequirement: k,
                                    qualityRequirementStr: o
                                }
                                dataArr.push(obj);
                            });
                            table.render({
                                elem: '#chooseQualityRequirement',
                                data: dataArr,
                                cols: [[
                                    {type: 'radio', title: '选择'},
                                    {field: 'qualityRequirementStr', title: '控制方式'}
                                ]]
                            });
                        },
                        yes: function (index) {
                            var checkStatus = table.checkStatus('chooseQualityRequirement');
                            if (checkStatus.data.length > 0) {
                                $tr.find('input[name="controlType"]').val(checkStatus.data[0].qualityRequirementStr);
                                $tr.find('input[name="controlType"]').attr('controlType', checkStatus.data[0].qualityRequirement);
                                layer.close(index);
                            } else {
                                layer.msg('请选择一项！', {icon: 0, time: 2000});
                            }
                        }
                    });
                }
            });
            $('#saveBtn').click(function(){
                var obj = {};
                var datas = $('#formTest').serializeArray();
                datas.forEach(function (item) {
                    obj[item.name] = item.value;
                });
                obj.deptBudgetId=formData[0].deptBudgetId
                obj.reviseId=formData[0].reviseId
                obj.deptId=formData[0].deptId

                obj.runId= Number(runId)
                //预算明细表
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
                $.ajax({
                    url: '/plbDeptBudget/updateRevision',
                    data: JSON.stringify(obj),
                    dataType: 'json',
                    contentType: "application/json;charset=UTF-8",
                    type: 'post',
                    success: function (res) {
                        if (res.flag) {
                            layer.msg('保存成功！', {icon: 1});

                        } else {
                            layer.msg('保存失败！', {icon: 2});
                        }
                    }
                });
            })
            form.render()
        })
    }



    function getUrlParam(name){
        var reg = new RegExp(name +"=(.*?)((?=&|$))"); //构造一个含有目标参数的正则表达式对象
        var r = parent.location.href.match(reg); //匹配目标参数
        if (r!=null) return unescape(r[1]); return null; //返回参数值
    }
</script>
</body>
</html>
