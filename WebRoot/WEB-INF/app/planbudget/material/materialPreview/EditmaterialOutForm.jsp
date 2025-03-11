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
    <title>材料出库表单操作</title>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

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
    <%--    <script type="text/javascript" src="/js/common/fileupload.js"></script>--%>
    <script type="text/javascript" src="/js/planbudget/common.js?20210413"></script>
    <script src="../js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108301508"></script>
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
            padding: 0 8px;
            box-sizing: border-box;
        }

        /* region 左侧样式 */
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
        /* endregion */

        /* region 右侧样式 */
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

        /* endregion */

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

        .refresh_no_btn {
            display: none;
            margin-left: 2%;
            color: #00c4ff !important;
            font-weight: 600;
            cursor: pointer;
        }
        .layui-col-xs6{
            width: 20%;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="wrapper">

    </div>
    <%--<div style="text-align: center;margin-top: 35px;">
        <button class="layui-btn layui-btn-normal" id="save">保存</button>
    </div>--%>
</div>

<script type="text/html" id="toolbarDemoIn">
    <div class="layui-btn-container" style="height: 30px;">
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">选择出库材料</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>


<script>
    var runId =  $.GetRequest()['runId'] || '';
    var disabled = $.GetRequest()['disabled'] || '';
    var dictionaryObj = {
        CONTROL_MODE: {},
        CBS_UNIT: {},
        MATERIALOUT_TYPE:{}
    }
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,MATERIALOUT_TYPE';
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
            init()
        }
    });
    var orgFlag = isOrg("yongli");
    function init() {
        layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;
            var soulTable = layui.soulTable;
            var eleTree = layui.eleTree;
            var xmSelect = layui.xmSelect;

            var str=['<div class="layui-collapse" id="leftId">\n' +
            /* region 材料计划 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">基本信息</h2>\n' +
            '    <div class="layui-colla-content layui-show plan_base_info">' +
            '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
            /* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">出库单编号<span field="mtlStockOutNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="mtlStockOutNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">项目名称<span field="projectName" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="projectName" id="projectName" readonly autocomplete="off" class="layui-input" style="cursor: pointer;background: #e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">出库仓库<span field="warehouseId" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <select name="warehouseId"></select>' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">领料人<span field="stockOutReceiver" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="stockOutReceiver" autocomplete="off" class="layui-input">' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">出库日期<span field="stockOutDate" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="stockOutDate" readonly id="stockOutDate" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' +
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">出库数量<span field="stockOutQuantity" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="stockOutQuantity" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">出库金额</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="outMoney" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '                    <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
            '                        <div class="layui-form-item">\n' +
            '                            <label class="layui-form-label form_label">出库类型<span field="materialOutType" class="field_required">*</span></label>\n' +
            '                            <div class="layui-input-block form_block">\n' +
            '                                <select name="materialOutType" id="materialOutType" lay-filter="test">\n' +
            '                                </select>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">备注</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="remark" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' +
            /* endregion */
            /* region 第三行 */
            // '           <div class="layui-row">' +
            // '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            // '                   <div class="layui-form-item">\n' +
            // '                       <label class="layui-form-label form_label">备注</label>\n' +
            // '                       <div class="layui-input-block form_block">\n' +
            // '                       <input type="text" name="demo"  autocomplete="off" class="layui-input">\n' +
            // '                       </div>\n' +
            // '                   </div>' +
            // '               </div>' +
            // '           </div>' +
            /* endregion */
            /* region 第四行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            //'                       <label class="layui-form-label form_label">附件</label>' +
            '                       <div class="layui-input-block form_block">' +
            '<div class="file_module">' +
            '<div id="fileContent" class="file_content"></div>' +
            '<div class="file_upload_box">' +
            '<a href="javascript:;" class="open_file">' +
            '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件'+function (){if(orgFlag){return "<span field=\"attachmentId\" class=\"field_required\">*</span>"}else{return ""}}()+'</span>' +
            '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
            '</a>' +
            '<div class="progress" id="progress">' +
            '<div class="bar"></div>\n' +
            '</div>' +
            '<div class="bar_text"></div>' +
            '</div>' +
            '</div>' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>',
                /* endregion */

                '       </form>' +
                '    </div>\n' +
                '  </div>\n' +
                /* endregion */
                /* region 出库明细 */
                '  <div class="layui-colla-item">\n' +
                '    <h2 class="layui-colla-title">出库明细</h2>\n' +
                '    <div class="layui-colla-content mtl_info layui-show">' +
                '       <div>' +
                '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
                '      </div>' +
                '    </div>\n' +
                '  </div>\n' +
                /* endregion */
                '</div>'].join('')
            $('.wrapper').html(str)
            element.render();

            fileuploadFn('#fileupload', $('#fileContent'));

            //出库类型
            $('[name="materialOutType"]').append(dictionaryObj['MATERIALOUT_TYPE']['str']);
            form.render();
            //回显数据
            $.get('/plbMtlStockOut/getStockOutByRunId', {runId: runId}, function (res) {
                if (res.flag) {
                    var data=res.data

                    //回显项目名称
                    getProjName('#projectName',data.projId);
                    $('#leftId').attr('projId',data.projId)

                    form.val("formTest", data);

                    //附件
                    if (data.attachments && data.attachments.length > 0) {
                        var fileArr = data.attachments;
                        $('#fileContent').append(echoAttachment(fileArr));
                    }

                    var materialDetailsTableData = data.plbMtlStockOutListWithBLOBs ? data.plbMtlStockOutListWithBLOBs : []

                    //材料出库主键id
                    $('.plan_base_info input[name="mtlStockOutNo"]').attr('mtlStockOutId',data.mtlStockOutId)

                    $.get('/plbWarehouse/selectAll', {useFlag: false,projId:data.projId}, function (res) {
                        var obj=res.obj
                        if (res.flag) {
                            // var warehouseStr='<option value=""></option>'
                            var warehouseStr='';
                            obj.forEach(function (item,index) {
                                warehouseStr+='<option value=' + item.warehouseId + '>' + item.warehouseName + '</option>'
                            })
                            $('select[name="warehouseId"]').html(warehouseStr)
                            form.render()
                            //回显仓库下拉框

                            $('select[name="warehouseId"]').val(data.warehouseId);

                            form.render()
                        }
                    });


                    element.render();
                    form.render();
                    laydate.render({
                        elem: '#businessDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.businessDate) : new Date
                    });
                    laydate.render({
                        elem: '#stockOutDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.stockOutDate) : ''
                    });

                    var cols=[
                        {field: 'mtlStockInNo', title: '入库单编号',width: 150},
                        {field: 'wbsName', title: 'WBS', width: 200,templet: function (d) {
                                return '<span wbsId="'+(d.wbsId || '')+'">'+(d.wbsName || '')+'</span>'
                            }},
                        {field: 'rbsName', title: 'RBS', width: 200,templet: function (d) {
                                return '<span rbsId="'+(d.rbsId || '')+'">'+(d.rbsName || '')+'</span>'
                            }},
                        {field: 'cbsName', title: 'CBS', width: 150,templet: function (d) {
                                return '<span cbsId="'+(d.cbsId || '')+'">'+(d.cbsName || '')+'</span>'
                            }},
                        {field: 'mtlName', title: '材料名称', width: 150,},
                        {field: 'mtlStandard', title: '材料规格',width: 150},
                        // {field: 'valuationUnit', title: '单位',width: 150},
                        {
                            field: 'valuationUnit', title: '单位', width: 90, templet: function (d) {
                                // if(d.controlType!=undefined&&d.controlType=="01"){
                                //     return '<input type="text" name="valuationUnit" mtlValuationUnit="'+(d.valuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                                // }else{
                                //     return '<input type="text" name="valuationUnit" mtlValuationUnit="'+(d.valuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '') + '">'
                                // }
                                return '<input type="text" name="valuationUnit" valuationUnit="'+(d.valuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '">'
                            }
                        },
                        {field: 'stockInQuantity', title: '入库数量',width: 150},
                        {field: 'issuedQuantity', title: '已出库数量',width: 150},
                        {field: 'onWayOutAmount', title: '在途中出库数量',width: 150},
                        // {field: 'outInTotal', title: '累计调拨数量',width: 150},
                        // {field: 'onWayOutInAmount', title: '在途中调拨数量',width: 150},
                        {
                            field: 'stockOutQuantity', title: '本次出库数量*', width: 200,templet: function (d) {
                                return '<input type="number" name="stockOutQuantity" '+(type==4 ? 'readonly' : '')+' stockOutListId="'+(d.stockOutListId || '')+'" stockInListId="'+(d.stockInListId || '')+'" class="layui-input stockOutQuantityItem" style="height: 100%;" value="' + (d.stockOutQuantity ? retainDecimal(d.stockOutQuantity,3) : '') + '">'
                            }
                        },
                        {field: 'taxPeice', title: '含税单价',width: 150},
                        {field: 'noTaxPeice', title: '不含税单价',width: 150},
                        {field: 'taxRate', title: '税率',width: 80},
                        {
                            field: 'taxMoney', title: '含税总价',width: 150,templet: function (d) {
                                return '<input type="text" name="taxMoney" readonly autocomplete="off" class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.taxMoney || '') + '">'
                            }
                        },
                        {
                            field: 'noTaxMoney', title: '不含税总价',width: 150, templet: function (d) {
                                return '<input type="text" name="noTaxMoney" readonly autocomplete="off" class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.noTaxMoney || '') + '">'
                            }
                        },
                        {
                            field: 'usePlace', title: '需用部位',width: 150, templet: function (d) {
                                return '<input type="text" name="usePlace" '+(type==4 ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%;" value="' + (d.usePlace || '') + '">'
                            }
                        },
                        {field: 'stockInDate', title: '入库日期',minWidth: 110}
                    ]

                    if(disabled == '0'){
                        cols.push({align: 'center', toolbar: '#barDemo',fixed:'right', title: '操作', width: 100})
                    }
                    table.render({
                        elem: '#materialDetailsTable',
                        data: materialDetailsTableData,
                        toolbar: '#toolbarDemoIn',
                        defaultToolbar: [''],
                        limit: 1000,
                        cols: [cols],
                        done:function () {
                            if(disabled == '1'){
                                $('.addRow').hide()
                                $('[name="stockOutReceiver"]').attr('disabled',true)
                                $('[name="stockOutDate"]').attr('disabled',true)
                                $('select[name="warehouseId"]').attr("disabled",true);
                                $('.deImgs').hide()
                                $('.file_upload_box').hide();
                                $('[name="materialOutType"]').attr("disabled",true);
                                //$('#save').hide()
                            }
                        }
                    });
                } else {
                    layer.msg('获取信息失败！', {icon: 2});
                }
            });

            // 内部加行按钮
            table.on('toolbar(materialDetailsTable)', function (obj) {
                switch (obj.event) {
                    case 'add':
                        var warehouseId=$("select[name='warehouseId']").val();
                        if(warehouseId==""||warehouseId==undefined){
                            layer.msg('请选择出库仓库！', {icon: 0});
                            return false
                        }
                        layer.open({
                            type: 1,
                            title: '选择出库材料',
                            area: ['100%', '100%'],
                            btn: ['确定', '取消'],
                            btnAlign: 'c',
                            content: ['<div class="layui-form" style="padding:0px 10px">' +
                            '<div class="query_module layui-form layui-row" style="padding:10px">\n' +
                            '                <div class="layui-col-xs2">\n' +
                            '                    <input type="text" name="orderNo" placeholder="订单编号" autocomplete="off" class="layui-input">\n' +
                            '                </div>\n' +
                            '                <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                            '                    <button type="button" class="layui-btn layui-btn-sm InSearchData">查询</button>\n' +
                            '                </div>\n' +
                            '</div>' +
                            '<div>' +
                            '     <table id="tableDemoIn" lay-filter="tableDemoIn"></table>\n' +
                            '     <div id="downBox">\n' +
                            '         <table id="tableDemoInDown" lay-filter="tableDemoInDown"></table>\n' +
                            '      </div>' +
                            '</div>' +
                            '</div>'].join(''),
                            success: function () {
                                table.render({
                                    elem: '#tableDemoIn',
                                    url: '/plbMtlStockIn/getDataByConditionPlus?warehouseId='+warehouseId+'&showStockInSum=showStockInSum&auditerStatus=2&projId='+$('#leftId').attr('projId'),
                                    cols: [[
                                        {field: 'mtlStockInNo', title: '入库单编号',},
                                        {field: 'warehouseName', title: '仓库名称',},
                                        {field: 'customerName', title: '客商单位名称',},
                                        {
                                            field: 'stockInDate', title: '入库日期', templet: function (d) {
                                                return format(d.stockInDate);
                                            }
                                        },
                                        {field: 'stockInTotal', title: '入库总数量',},
                                        {field: 'sumDeliveryQuantity', title: '已出库总数量',},
                                        {field: 'onWayOutAmount', title: '在途中出库数量',width: 150,templet: function (d) {
                                                return d.onWayOutAmount || 0
                                            }},
                                        {field: 'outInTotal', title: '累计调拨数量',width: 150,templet: function (d) {
                                                return d.outInTotal || 0
                                            }},
                                        {field: 'onWayOutInAmount', title: '在途中调拨数量',width: 150,templet: function (d) {
                                                return d.onWayOutInAmount || 0
                                            }},
                                        {field: 'stockInDate', title: '入库日期',minWidth: 110}
                                    ]],
                                    height: 'full-430',
                                    page: true,
                                    where: {
                                        projId: $('#leftId').attr('projId'),
                                    },
                                    parseData: function (res) { //res 即为原始返回的数据
                                        return {
                                            "code": 0, //解析接口状态
                                            "data": res.data, //解析数据列表
                                            "count": res.totleNum, //解析数据长度
                                        };
                                    },
                                    request: {
                                        limitName: 'pageSize' //每页数据量的参数名，默认：limit
                                    },
                                });
                            },
                            yes: function (index) {

                                var checkStatus = table.checkStatus('tableDemoInDown'); //获取选中行状态
                                var data = checkStatus.data;  //获取选中行数据

                                //判断是否选择数据
                                if (data.length == 0) {
                                    layer.msg('请选择一项！', {icon: 0});
                                    return false
                                }

                                //遍历表格获取每行数据进行保存
                                var $tr = $('.mtl_info').find('.layui-table-main tr');
                                var oldDataArr = [];
                                $tr.each(function () {
                                    var oldDataObj = {
                                        mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                                        mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell').text(),
                                        mtlStockInNo: $(this).find('[data-field="mtlStockInNo"] .layui-table-cell').text(),
                                        taxPeice: $(this).find('[data-field="taxPeice"] .layui-table-cell').text(),
                                        noTaxPeice: $(this).find('[data-field="noTaxPeice"] .layui-table-cell').text(),
                                        taxRate: $(this).find('[data-field="taxRate"] .layui-table-cell').text(),
                                        stockOutQuantity: $(this).find('input[name="stockOutQuantity"]').val(),
                                        taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                                        noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                                        usePlace: $(this).find('input[name="usePlace"]').val(),
                                        stockInListId: $(this).find('input[name="stockOutQuantity"]').attr('stockInListId'),
                                        stockInQuantity: $(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),//入库数量
                                        issuedQuantity: $(this).find('[data-field="issuedQuantity"] .layui-table-cell').text(),//已出库数量
                                        wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                                        wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                                        cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                                        cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                                        valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),//单位
                                        onWayOutAmount: $(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text(),//在途中出库数量
                                        outInTotal: $(this).find('[data-field="outInTotal"] .layui-table-cell').text(),//累计调拨数量
                                        onWayOutInAmount: $(this).find('[data-field="onWayOutInAmount"] .layui-table-cell').text(),//在途中调拨数量
                                        stockInDate: $(this).find('[data-field="stockInDate"] .layui-table-cell').text()//入库日期
                                    }
                                    if ($(this).find('input[name="stockOutQuantity"]').attr('stockOutListId')) {
                                        oldDataObj.stockOutListId = $(this).find('input[name="stockOutQuantity"]').attr('stockOutListId');
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                /*var addRowData = {
                                    mtlName: data[0].mtlName,
                                    mtlStandard: data[0].mtlStandard,
                                    mtlStockInNo: data[0].mtlStockInNo,
                                    taxPeice: data[0].stockInPrice,
                                    noTaxPeice: data[0].noTaxPeice,
                                    taxRate: data[0].taxRate,
                                    taxMoney: data[0].taxMoney,
                                    noTaxMoney: data[0].noTaxMoney,
                                    stockInListId: data[0].stockInListId,
                                };
                                oldDataArr.push(addRowData);*/
                                //具体明细可多选
                                data.forEach(function (item) {
                                    var addRowData={
                                        mtlName: item.mtlName,
                                        mtlStandard: item.mtlStandard,
                                        mtlStockInNo: item.mtlStockInNo,
                                        taxPeice:retainDecimal(item.taxPeice,3),
                                        noTaxPeice: retainDecimal(item.noTaxPeice,8),
                                        /*taxMoney:retainDecimal(item.taxMoney,2),
                                        noTaxMoney: retainDecimal(item.noTaxMoney,2),*/
                                        taxRate: dictionaryObj['TAX_RATE']['object'][item.taxRate] || '',
                                        stockInListId: item.stockInListId,
                                        stockInQuantity: retainDecimal(item.stockInQuantity,3) || 0, //本次入库数量
                                        issuedQuantity: retainDecimal(item.sumDeliveryQuantity,3) || 0, //已出库数量
                                        usePlace: item.usePlace, //需用部位
                                        wbsName: item.wbsName,
                                        wbsId: item.wbsId,
                                        rbsName: item.rbsName,
                                        rbsId: item.rbsId,
                                        cbsName: item.cbsName,
                                        controlType:item.controlType,
                                        cbsId: item.cbsId,
                                        valuationUnit: item.mtlValuationUnit,//单位
                                        onWayOutAmount: retainDecimal(item.onWayOutAmount,3) || 0,//在途中出库数量
                                        outInTotal: retainDecimal(item.outInTotal,3) || 0,//累计调拨数量
                                        onWayOutInAmount: retainDecimal(item.onWayOutInAmount,3) || 0,//在途中调拨数量
                                        stockInDate: item.stockInDate//入库日期
                                    }
                                    oldDataArr.push(addRowData)
                                })
                                table.reload('materialDetailsTable', {
                                    data: oldDataArr
                                });
                                layer.close(index)
                            },
                        })
                        break;
                }
            });
            // 内部删行操作
            table.on('tool(materialDetailsTable)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;
                if (layEvent === 'del') {
                    obj.del();
                    if (data.stockOutListId) {
                        $.get('/plbMtlStockOutList/delete', {stockOutListId: data.stockOutListId}, function (res) {

                        });
                    }
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                            mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell').text(),
                            mtlStockInNo: $(this).find('[data-field="mtlStockInNo"] .layui-table-cell').text(),
                            taxPeice: $(this).find('[data-field="taxPeice"] .layui-table-cell').text(),
                            noTaxPeice: $(this).find('[data-field="noTaxPeice"] .layui-table-cell').text(),
                            taxRate: $(this).find('[data-field="taxRate"] .layui-table-cell').text(),
                            stockOutQuantity: $(this).find('input[name="stockOutQuantity"]').val(),
                            taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                            noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                            usePlace: $(this).find('input[name="usePlace"]').val(),
                            stockInListId: $(this).find('input[name="stockOutQuantity"]').attr('stockInListId'),
                            stockInQuantity: $(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),//入库数量
                            issuedQuantity: $(this).find('[data-field="issuedQuantity"] .layui-table-cell').text(),//已出库数量
                            wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                            wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                            cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                            cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                            valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),//单位
                            onWayOutAmount: $(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text(),//在途中出库数量
                            outInTotal: $(this).find('[data-field="outInTotal"] .layui-table-cell').text(),//累计调拨数量
                            onWayOutInAmount: $(this).find('[data-field="onWayOutInAmount"] .layui-table-cell').text(),//在途中调拨数量
                            stockInDate: $(this).find('[data-field="stockInDate"] .layui-table-cell').text()//入库日期
                        }
                        if ($(this).find('input[name="stockOutQuantity"]').attr('stockOutListId')) {
                            oldDataObj.stockOutListId = $(this).find('input[name="stockOutQuantity"]').attr('stockOutListId');
                        }
                        oldDataArr.push(oldDataObj);
                    });
                    table.reload('materialDetailsTable', {
                        data: oldDataArr
                    });
                }
            });
            //监听行单击事件
            table.on('row(tableDemoIn)', function (obj) {
                // console.log(obj.data) //得到当前行数据
                var data = obj.data
                $('#downBox').show()
                obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
                obj.tr.attr('mtlContractId', data.mtlContractId)
                tableShowDown(data.mtlStockInId)
            });

            //出库明细表格
            function tableShowDown(mtlStockInId) {
                table.render({
                    elem: '#tableDemoInDown',
                    url: '/plbMtlStockIn/getChildList',
                    cellMinWidth:150,
                    cols: [[
                        {type: 'checkbox'},
                        {field: 'mtlStockInNo', title: '入库单编号',},
                        {field: 'wbsName', title: 'WBS',},
                        {field: 'cbsName', title: 'CBS',},
                        {field: 'mtlName', title: '材料名称',},
                        {field: 'mtlStandard', title: '材料规格',},
                        {field: 'stockInQuantity', title: '本次入库数量',},
                        {field: 'sumSurplusQuantity', title: '剩余库存量',},
                        {field: 'onWayOutAmount', title: '在途中出库数量',width: 150,templet: function (d) {
                                return d.onWayOutAmount || 0
                            }},
                        {field: 'outInTotal', title: '累计调拨数量',width: 150,templet: function (d) {
                                return d.outInTotal || 0
                            }},
                        {field: 'onWayOutInAmount', title: '在途中调拨数量',width: 150,templet: function (d) {
                                return d.onWayOutInAmount || 0
                            }},
                        {field: 'sumDeliveryQuantity', title: '已出库数量',},
                        {field: 'stockInPrice', title: '含税单价',},
                        {field: 'noTaxPeice', title: '不含税单价',},
                        {field: 'taxRate', title: '税率',},
                        {field: 'stockInDate', title: '入库日期',minWidth: 110}
                    ]],
                    height: 'full-430',
                    page: true,
                    where: {
                        mtlStockInId: mtlStockInId,
                    },
                    parseData: function (res) { //res 即为原始返回的数据
                        return {
                            "code": 0, //解析接口状态
                            "data": res.data, //解析数据列表
                            "count": res.totleNum, //解析数据长度
                        };
                    },
                    request: {
                        limitName: 'pageSize' //每页数据量的参数名，默认：limit
                    },
                });
            }

            //监听本次出库数量
            $(document).on('blur', '.stockOutQuantityItem', function () {
                if(disabled == '1'){
                    return false
                }

                //出库数量不能大于入库数量
                if(Number($(this).val()) > Number($(this).parents('tr').find('td[data-field="stockInQuantity"]').text())){
                    $(this).val('')
                    layer.msg('出库数量不能大于入库数量！', {icon: 0, time: 1500});
                    return false
                }

                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var stockOutQuantity=0
                var taxPeice=0
                $tr.each(function () {
                    stockOutQuantity=accAdd(stockOutQuantity,$(this).find('input[name="stockOutQuantity"]').val())

                    //var p1=($(this).find('input[name="stockOutQuantity"]').val() || 0) * ($(this).find('td[data-field="taxPeice"]').text() || 0)
                    var p1=mul(($(this).find('input[name="stockOutQuantity"]').val() || 0) , ($(this).find('td[data-field="taxPeice"]').text()))     || 0;
                    taxPeice=accAdd(taxPeice,p1)
                });
                $('#baseForm [name="stockOutQuantity"] ').val(retainDecimal(stockOutQuantity,3))
                $('#baseForm [name="outMoney"] ').val(retainDecimal(taxPeice,2))

                //计算含税总价和不含税总价
                if($(this).val() && $(this).parents('tr').find('td[data-field="taxPeice"]').text()){
                    var taxMoney=mul(($(this).val() || 0) , ($(this).parents('tr').find('td[data-field="taxPeice"]').text() || 0))
                    $(this).parents('tr').find('input[name="taxMoney"]').val(retainDecimal(taxMoney,3))
                }
                if($(this).val() && $(this).parents('tr').find('td[data-field="noTaxPeice"]').text()){
                    var noTaxMoney=mul(($(this).val() || 0) , ($(this).parents('tr').find('td[data-field="noTaxPeice"]').text() || 0))
                    $(this).parents('tr').find('input[name="noTaxMoney"]').val(retainDecimal(noTaxMoney,3))
                }
            });


            /*用来得到精确的加法结果
           *说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
           *调用：accAdd(arg1,arg2)
           *返回值：arg1加上arg2的精确结果
       */
            /*function accAdd(arg1,arg2){
                var r1,r2,m;
                try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
                try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
                m=Math.pow(10,Math.max(r1,r2))
                return (arg1*m+arg2*m)/m
            }*/


        });
    }

    function childFunc(){
        if(disabled&&disabled=='1'){
            return false
        }

        var lock=false
        //基本信息数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });
        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;
        //出库明细数据
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var materialDetailsArr = [];
        $tr.each(function () {
            //入库数量-已出库数量-在途中出库数量-本次出库数量>=0,否则无法提交
            var sum=sub(sub(sub($(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),$(this).find('[data-field="issuedQuantity"] .layui-table-cell').text()),$(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text()),$(this).find('input[name="stockOutQuantity"]').val())
            if(sum < 0){
                layer.msg('需入库数量-已出库数量-在途中出库数量-本次出库数量>=0,否则无法提交！', {icon: 0});
                lock=true
                return false
            }


            var materialDetailsObj = {
                mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell').text(),
                mtlStockInNo: $(this).find('[data-field="mtlStockInNo"] .layui-table-cell').text(),
                taxPeice: $(this).find('[data-field="taxPeice"] .layui-table-cell').text(),
                noTaxPeice: $(this).find('[data-field="noTaxPeice"] .layui-table-cell').text(),
                taxRate: $(this).find('[data-field="taxRate"] .layui-table-cell').text(),
                stockOutQuantity: retainDecimal($(this).find('input[name="stockOutQuantity"]').val(),3),
                taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                usePlace: $(this).find('input[name="usePlace"]').val(),
                stockInListId: $(this).find('input[name="stockOutQuantity"]').attr('stockInListId'),
                stockInQuantity: $(this).find('[data-field="stockInQuantity"] .layui-table-cell').text(),//入库数量
                issuedQuantity: $(this).find('[data-field="issuedQuantity"] .layui-table-cell').text(),//已出库数量
                wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                rbsName: $(this).find('[data-field="rbsName"] .layui-table-cell span').text(),//rbsName
                rbsId: $(this).find('[data-field="rbsName"] .layui-table-cell span').attr('rbsId'),//rbsId
                cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                valuationUnit: $(this).find('input[name="valuationUnit"]').attr('valuationUnit'),// $(this).find('[data-field="valuationUnit"] .layui-table-cell').text(),//单位
                onWayOutAmount: $(this).find('[data-field="onWayOutAmount"] .layui-table-cell').text(),//在途中出库数量
                outInTotal: $(this).find('[data-field="outInTotal"] .layui-table-cell').text(),//累计调拨数量
                onWayOutInAmount: $(this).find('[data-field="onWayOutInAmount"] .layui-table-cell').text(),//在途中调拨数量
                stockInDate: $(this).find('[data-field="stockInDate"] .layui-table-cell').text()//入库日期
            }
            if ($(this).find('input[name="stockOutQuantity"]').attr('stockOutListId')) {
                materialDetailsObj.stockOutListId = $(this).find('input[name="stockOutQuantity"]').attr('stockOutListId');
            }
            materialDetailsArr.push(materialDetailsObj);
        });
        obj.plbMtlStockOutlistWithBLOBS = materialDetailsArr;

        if(lock){
            return false
        }


        var loadIndex = layer.load();
        // 判断必填项
        var requiredFlag = false;
        $('#baseForm').find('.field_required').each(function(){
            var field = $(this).attr('field');
            if (!obj[field]) {
                var fieldName = $(this).parent().text().replace('*', '');
                layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                requiredFlag = true;
                return false;
            }
        });

        if (requiredFlag) {
            layer.close(loadIndex);
            return false;
        }

        obj.mtlStockOutId = $('.plan_base_info input[name="mtlStockOutNo"]').attr('mtlStockOutId')


        var _flag = false;
        $.ajax({
            url: '/plbMtlStockOut/update',
            data: JSON.stringify(obj),
            dataType: 'json',
            type: 'post',
            contentType: "application/json;charset=UTF-8",
            success: function (res) {
                layer.close(loadIndex);
                if (res.flag) {
                    layer.msg('保存成功！', {icon: 1});
                    layer.close(index);
                    /*tableIns.config.where._ = new Date().getTime();
                    tableIns.reload();*/
                } else {
                    _flag = true
                    layer.msg('保存失败！', {icon: 2});
                }
            }
        });
        if(_flag){
            return false;
        }
        return true;
    }
</script>
</body>
</html>