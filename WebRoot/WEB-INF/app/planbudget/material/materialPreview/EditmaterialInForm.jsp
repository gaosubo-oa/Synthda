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
    <title>材料入库表单操作</title>

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
    <script type="text/javascript" src="/js/planother/planotherUtil.js?221202108311508"></script>

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
            position: relative;
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

        /*选中行样式*/
        .selectTr {
            background: #009688 !important;
            color: #fff !important;
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
        <button class="layui-btn layui-btn-sm addRow" lay-event="add">选择入库材料</button>
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
        TAX_RATE: {},
        CONTRACT_TYPE: {},
        MATERIALIN_TYPE:{}
    }
    var orgFlag = isOrg("yongli");
    var dictionaryStr = 'CONTROL_MODE,CBS_UNIT,TAX_RATE,CONTRACT_TYPE,MATERIALIN_TYPE';
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

    function init() {
        layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
            var laydate = layui.laydate;
            var form = layui.form;
            var table = layui.table;
            var element = layui.element;
            var soulTable = layui.soulTable;
            var eleTree = layui.eleTree;
            var xmSelect = layui.xmSelect;

            var str=['<div class="layui-collapse disabledAll">\n' +
            /* region 材料计划 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">基本信息</h2>\n' +
            '    <div class="layui-colla-content layui-show plan_base_info">' +
            '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
            /* region 第一行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">入库单编号<a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="mtlStockInNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
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
            '                       <label class="layui-form-label form_label">仓库<span field="warehouseId" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <select name="warehouseId"></select>' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">合同<span field="mtlContractName" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '<i style="position: absolute;top: 8px;right: 5px;" class="layui-icon layui-icon-search"></i>  ' +
            '                       <input type="text" name="mtlContractName" placeholder="请选择合同" readonly autocomplete="off" class="layui-input chooseManagementBudget" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
            '                       </div>\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">客商单位名称<span field="customerName" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="customerName" readonly autocomplete="off" placeholder="供应商" class="layui-input chooseCustomerName" style="cursor: pointer;background: #e7e7e7">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' +
            /* endregion */
            /* region 第二行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">本次入库总金额</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="stockInAmount" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">本次入库总数量</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="number" name="stockInTotal" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">业务日期<span field="businessDate" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="businessDate" readonly id="businessDate" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">入库日期<span field="stockInDate" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="stockInDate" readonly id="stockInDate" autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">\n' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">入库类型<span field="materialInType" class="field_required">*</span></label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                           <select name="materialInType" id="materialInType" lay-filter="test">\n' +
            '                           </select>\n' +
            '                       </div>\n' +
            '                   </div>\n' +
            '               </div>\n' +
            '           </div>' +
            /* endregion */
            /* region 第三行 */
            '           <div class="layui-row">' +
            '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
            '                   <div class="layui-form-item">\n' +
            '                       <label class="layui-form-label form_label">备注</label>\n' +
            '                       <div class="layui-input-block form_block">\n' +
            '                       <input type="text" name="demo"  autocomplete="off" class="layui-input">\n' +
            '                       </div>\n' +
            '                   </div>' +
            '               </div>' +
            '           </div>' +
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
            '           </div>' +
            /* endregion */
            '       </form>' +
            '    </div>\n' +
            '  </div>\n' +
            /* endregion */
            /* region 材料明细 */
            '  <div class="layui-colla-item">\n' +
            '    <h2 class="layui-colla-title">入库明细</h2>\n' +
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
            //入库类型
            $('[name="materialInType"]').append(dictionaryObj['MATERIALIN_TYPE']['str']);
            form.render();
            //回显数据
            $.get('/plbMtlStockIn/getStockInByRunId', {runId: runId}, function (res) {
                if (res.flag) {
                    var data=res.data

                    //回显项目名称
                    getProjName('#projectName',data.projId);
                    fileuploadFn('#fileupload', $('#fileContent'));
                    $('#leftId').attr('projId',data.projId)

                    form.val("formTest", data);

                    //附件
                    if (data.attachments && data.attachments.length > 0) {
                        var fileArr = data.attachments;
                        $('#fileContent').append(echoAttachment(fileArr));
                    }

                    $('[name="customerName"]').attr('customerId',data.customerId)
                    //合同id
                    $('#baseForm input[name="mtlContractName"]').attr('mtlContractId',data.mtlContractId || '');
                    var materialDetailsTableData = data.plbMtlStockInLists ? data.plbMtlStockInLists : []

                    //项目id和材料入库主键id
                    $('.plan_base_info input[name="customerName"]').attr('projId',data.projId)
                    $('.plan_base_info input[name="customerName"]').attr('mtlStockInId',data.mtlStockInId)

                    $.get('/plbWarehouse/selectAll', {useFlag: false,projId:data.projId}, function (res) {
                        var obj=res.obj
                        if (res.flag) {
                            var warehouseStr='<option value=""></option>'
                            obj.forEach(function (item,index) {
                                warehouseStr+='<option value=' + item.warehouseId + '>' + item.warehouseName + '</option>'
                            })
                            $('select[name="warehouseId"]').html(warehouseStr)
                            form.render()
                            //回显仓库下拉框
                            $('select[name="warehouseId"]').val(data.warehouseId)
                            form.render()
                        }
                    });


                    element.render();
                    form.render();
                    laydate.render({
                        elem: '#stockInDate' //指定元素
                        , trigger: 'click' //采用click弹出
                        , value: data ? format(data.stockInDate) : ''
                    });

                    var cols=[
                        {field: 'wbsName', title: 'WBS', width: 170,templet: function (d) {
                                return '<span wbsId="'+(d.wbsId || '')+'">'+(d.wbsName || '')+'</span>'
                            }},
                        {field: 'rbsName', title: 'RBS', width: 200,templet: function (d) {
                                return '<span rbsId="'+(d.rbsId || '')+'">'+(d.rbsName || '')+'</span>'
                            }},
                        {field: 'cbsName', title: 'CBS', width: 200,templet: function (d) {
                                return '<span cbsId="'+(d.cbsId || '')+'">'+(d.cbsName || '')+'</span>'
                            }},
                        {field: 'mtlName', title: '材料名称', width: 200,},
                        {field: 'mtlStandard', title: '材料规格', width: 100,templet: function (d) {
                                return '<span>'+(d.mtlStandard || '')+'</span>'
                            }},
                        {
                            field: 'mtlValuationUnit', title: '计量单位', width: 90, templet: function (d) {
                                // if(d.controlType!=undefined&&d.controlType=="01"){
                                //     return '<input type="text" name="mtlValuationUnit" mtlValuationUnit="'+(d.mtlValuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '') + '">'
                                // }else{
                                //     return '<input type="text" name="mtlValuationUnit" mtlValuationUnit="'+(d.mtlValuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.mtlValuationUnit] || '') + '">'
                                // }
                                return '<input type="text" name="mtlValuationUnit" mtlValuationUnit="'+(d.mtlValuationUnit || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '') + '">'
                            }
                        },
                        // {field: 'controlType', title: '控制方式', width: 100,templet: function (d) {
                        //         return '<input type="text" name="controlType" controlType="'+(d.controlType || '')+'" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (dictionaryObj['CONTROL_MODE']['object'][d.controlType] || '') + '">'
                        //     }},
                        {
                            field: 'purchaseOrderQuantity', title: '采购订单数量', width: 150, templet: function (d) {
                                return '<input type="number" name="purchaseOrderQuantity" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.purchaseOrderQuantity || '0') + '">'
                            }
                        },
                        {
                            field: 'stockInSum', title: '已入库数量', width: 150, templet: function (d) {
                                return '<input type="number" name="stockInSum" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.stockInSum || '0') + '">'
                            }
                        },
                        {
                            field: 'quantityTransit', title: '在途入库数量', width: 150, templet: function (d) {
                                return '<input type="number" name="quantityTransit" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.quantityTransit || '0') + '">'
                            }
                        },
                        {
                            field: 'stockInQuantity', title: '本次入库数量*', width: 150,
                            templet: function (d) {
                                return '<input type="number" name="stockInQuantity" '+(type==4 ? 'readonly' : '')+' mtlLibId="' + (d.mtlLibId || '') + '" mtlOrderLisId="'+(d.mtlOrderLisId || '')+'"  mtlContractId="'+(d.mtlContractId || '')+'" mtlUnit="'+(d.mtlUnit || '')+'" stockInListId="' + (d.stockInListId || '') + '"  class="layui-input stockInQuantityItem" style="height: 100%;" value="' + (d.stockInQuantity ? retainDecimal(d.stockInQuantity,3) : '') + '">'
                            }
                        },
                        {
                            field: 'taxPeice', title: '含税单价*', width: 150, templet: function (d) {
                                return '<input type="number" name="taxPeice" '+(type==4 ? 'readonly' : '')+'  class="layui-input taxPeiceItem" style="height: 100%;" value="' + (d.taxPeice ? retainDecimal(d.taxPeice,3) : '') + '">'
                            }
                        },
                        {field:'isAllStockIn',align:'center',title:'是否全部入库',width:130,templet:function(d){
                                if(d.isAllStockIn==1||d.isAllStockIn=="1"){
                                    return ' <div class="layui-form-item">\n' +
                                        '    <div class="layui-input-block" style="margin: 0">\n' +
                                        '      <input type="checkbox" name="close" isOpen="1" lay-skin="switch" lay-text="是|否">\n' +
                                        '    </div>\n' +
                                        '  </div>'
                                }else{
                                    return ' <div class="layui-form-item">\n' +
                                        '    <div class="layui-input-block" style="margin: 0">\n' +
                                        '      <input type="checkbox" name="close" isOpen="0"  checked="" lay-skin="switch" lay-text="是|否">\n' +
                                        '    </div>\n' +
                                        '  </div>'
                                }
                            }
                        },
                        {
                            field: 'noTaxPeice', title: '不含税单价', width: 150, templet: function (d) {
                                return '<input type="number" name="noTaxPeice" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.noTaxPeice || '') + '">'
                            }
                        },
                        {
                            field: 'taxMoney', title: '含税总价', width: 150, templet: function (d) {
                                return '<input type="number" name="taxMoney" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.taxMoney || '') + '">'
                            }
                        },
                        {
                            field: 'noTaxMoney', title: '不含税总价', width: 150, templet: function (d) {
                                return '<input type="number" name="noTaxMoney" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.noTaxMoney || '') + '">'
                            }
                        },
                        {
                            field: 'taxRate', title: '税率', width: 100, templet: function (d) {
                                return '<input type="number" name="taxRate" taxRate="'+(d.taxRate || '')+'" readonly class="layui-input taxRateItem" style="height: 100%;background: #e7e7e7" value="' +(dictionaryObj['TAX_RATE']['object'][d.taxRate] || '')+ '">' //
                            }
                        },
                        {
                            field: 'taxes', title: '税金', width: 150, templet: function (d) {
                                return '<input type="number" name="taxes" readonly class="layui-input" style="height: 100%;background: #e7e7e7" value="' + (d.taxes || '') + '">'
                            }
                        },
                        {
                            field: 'checkState', title: '质量验收情况', width: 150, templet: function (d) {
                                return '<input type="text" name="checkState" '+(type==4 ? 'readonly' : '')+' class="layui-input" style="height: 100%;" value="' + (d.checkState || '') + '">'
                            }
                        },
                        {
                            field: 'remark', title: '备注', width: 150, templet: function (d) {
                                return '<input type="text" name="remark" '+(type==4 ? 'readonly' : '')+' class="layui-input" style="height: 100%;" value="' + (d.remark || '') + '">'
                            }
                        },
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
                                $('[name="warehouseId"]').attr('disabled',true)
                                $('[name="stockInDate"]').attr('disabled',true)
                                $('[name="customerName"]').removeClass('chooseCustomerName')
                                $('[name="mtlContractName"]').removeClass('chooseManagementBudget')
                                $('.deImgs').hide()
                                $('.file_upload_box').hide();
                                //$('#save').hide()
                                $('input[name="close"]').attr("disabled",true);
                                $('[name="materialInType"]').attr("disabled",true);
                                $('[name="demo"]').attr("disabled",true);
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
                        if(!$('#baseForm [name="customerName"]').attr('customerId')){
                            layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
                            return false
                        }
                        layer.open({
                            type: 1,
                            title: '选择入库材料',
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
                                    url: '/plbMtlOrder/queryPlbMtlOrderPlus',
                                    cols: [[
                                        {field: 'orderNo', title: '订单编号',},
                                        {field: 'mtlContractName', title: '材料采购合同',},
                                        {field: 'customerUnit', title: '客商单位名称',},
                                        {field: 'totalNumber', title: '本次采购订单量合计',},
                                        {field: 'stockIn', title: '已入库数量',},
                                        {field: 'createTime', title: '采购订单日期',templet: function (d) {
                                                return format(d.createTime);
                                            }},
                                    ]],
                                    height: 'full-430',
                                    page: true,
                                    where: {
                                        projId: $('#leftId').attr('projId'),
                                        customerId: $('#baseForm [name="customerName"]').attr('customerId'),
                                    },
                                    parseData: function (res) { //res 即为原始返回的数据
                                        return {
                                            "code": 0, //解析接口状态
                                            "data": res.object, //解析数据列表
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
                                        mtlLibId: $(this).find('input[name="stockInQuantity"]').attr('mtlLibId'),
                                        mtlOrderLisId: $(this).find('input[name="stockInQuantity"]').attr('mtlOrderLisId'),
                                        mtlContractId: $(this).find('input[name="stockInQuantity"]').attr('mtlContractId'),
                                        mtlUnit: $(this).find('input[name="stockInQuantity"]').attr('mtlUnit'),
                                        mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell span').text(), //材料规格
                                        mtlValuationUnit:$(this).find('input[name="mtlValuationUnit"]').attr('mtlValuationUnit'), //单位
                                        stockInQuantity: $(this).find('input[name="stockInQuantity"]').val(),
                                        taxPeice: $(this).find('input[name="taxPeice"]').val(),
                                        noTaxPeice: $(this).find('input[name="noTaxPeice"]').val(),
                                        taxRate: $(this).find('input[name="taxRate"]').attr('taxRate'),//税率
                                        taxes: $(this).find('input[name="taxes"]').attr('taxes'),//税金
                                        checkState: $(this).find('input[name="checkState"]').val(),
                                        remark: $(this).find('input[name="remark"]').val(),
                                        purchaseOrderQuantity: $(this).find('input[name="purchaseOrderQuantity"]').val(),//采购订单数量
                                        stockInSum: $(this).find('input[name="stockInSum"]').val(),//已入库数量
                                        quantityTransit: $(this).find('input[name="quantityTransit"]').val(),//在途入库数量
                                        taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                                        noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                                        wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                                        wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                                        cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                                        cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
                                    }
                                    if ($(this).find('input[name="stockInQuantity"]').attr('stockInListId')) {
                                        oldDataObj.stockInListId = $(this).find('input[name="stockInQuantity"]').attr('stockInListId');
                                    }
                                    oldDataArr.push(oldDataObj);
                                });
                                data.forEach(function (item) {
                                    var addRowData={
                                        mtlName: item.planMtlName,
                                        mtlLibId: item.mtlLibId,
                                        mtlOrderLisId: item.mtlOrderLisId,
                                        mtlStandard: item.planMtlStandard,
                                        mtlContractId: $('.selectTr').attr('mtlContractId'),
                                        mtlUnit: item.mtlUnit,
                                        controlType: item.controlType,
                                        taxRate: item.taxRate,
                                        wbsName: item.wbsName,
                                        wbsId: item.wbsId,
                                        rbsName: item.rbsName,
                                        rbsId: item.rbsId,
                                        cbsName: item.cbsName,
                                        cbsId: item.cbsId,
                                        purchaseOrderQuantity: retainDecimal(item.purchaseQuantity,3) || 0,//采购订单数量
                                        stockInSum: retainDecimal(item.stockIn,3) || 0,//已入库数量
                                        // taxPeice: retainDecimal(item.estimatedPrice,3) || 0,//预计单价->含税单价
                                        mtlValuationUnit: item.mtlUnit,//单位
                                        quantityTransit:retainDecimal(item.quantityTransit,3)||0//在途入库数量
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
                    if (data.stockInListId) {
                        $.get('/plbMtlStockIn/delChildData', {stockInListIds: data.stockInListId}, function (res) {

                        });
                    }
                    //重新计算
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var stockInQuantity=0
                    var taxPeice=0
                    $tr.each(function () {
                        stockInQuantity=accAdd(stockInQuantity,$(this).find('input[name="stockInQuantity"]').val())

                        /*var p1=($(this).find('input[name="stockInQuantity"]').val() || 0) * ($(this).find('input[name="taxPeice"]').val() || 0)*/
                        var p1=mul(($(this).find('input[name="stockInQuantity"]').val() || 0) , ($(this).find('input[name="taxPeice"]').val() || 0))
                        taxPeice=accAdd(taxPeice,p1)
                    });
                    //计算入库总数量
                    $('#baseForm [name="stockInTotal"] ').val(retainDecimal(stockInQuantity,3))
                    //计算入库总金额
                    $('#baseForm [name="stockInAmount"] ').val(retainDecimal(taxPeice,2))

                    //计算含税总价和不含税总价
                    if($(this).val() && $(this).parents('tr').find('[name="taxPeice"]').val()){
                        // $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="taxPeice"]').val(),2))
                        $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="taxPeice"]').val()),2))
                    }
                    if($(this).val() && $(this).parents('tr').find('[name="noTaxPeice"]').val()){
                        // $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="noTaxPeice"]').val(),2))
                        $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="noTaxPeice"]').val()),2))
                    }

                    //计算税金
                    // var taxes=$(this).parents('tr').find('[name="taxMoney"]').val() - $(this).parents('tr').find('[name="noTaxMoney"]').val()
                    var taxes=sub($(this).parents('tr').find('[name="taxMoney"]').val() , $(this).parents('tr').find('[name="noTaxMoney"]').val())
                    $(this).parents('tr').find('[name="taxes"]').val(retainDecimal(taxes,2))

                }
            });
            //监听行单击事件
            table.on('row(tableDemoIn)', function (obj) {
                // console.log(obj.data) //得到当前行数据
                var data = obj.data
                $('#downBox').show()
                obj.tr.addClass('selectTr').siblings('tr').removeClass('selectTr')
                obj.tr.attr('mtlContractId',data.mtlContractId)
                tableShowDown(data.melOrderId)
            });

            //订单明细表格
            function tableShowDown(melOrderId) {
                table.render({
                    elem: '#tableDemoInDown',
                    url: '/plbMtlOrder/getListDataByIdMelOrderId',
                    cellMinWidth:150,
                    cols: [[
                        {type: 'checkbox'},
                        {field: 'wbsName', title: 'WBS',},
                        {field: 'cbsName', title: 'CBS',width:200},
                        {field: 'planMtlName', title: '材料名称',},
                        {field: 'planMtlStandard', title: '材料规格'},
                        {field: 'mtlValuationUnit', title: '计量单位',templet: function (d) {
                                // if(d.controlType!=undefined&&d.controlType=="01"){
                                //     return dictionaryObj['CBS_UNIT']['object'][d.mtlUnit] || ''
                                // }else{
                                //     return dictionaryObj['MTL_VALUATION_UNIT']['object'][d.mtlUnit] || ''
                                // }
                                return dictionaryObj['CBS_UNIT']['object'][d.mtlUnit] || ''
                            }},
                        /* {field: 'taxRate', title: '税率',templet: function (d) {
                                 return dictionaryObj['TAX_RATE']['object'][d.taxRate] || ''
                             }},
                         // {field: 'mtlTotal', title: '材料库存量',},
                         {field: 'directUnitPrice', title: '材料指导价',},*/
                        {field: 'purchaseQuantity', title: '本次采购订单量',},
                        {field: 'stockIn', title: '已入库数量',},
                        {field: 'createTime', title: '采购订单日期',templet: function (d) {
                                return format(d.createTime);
                            }},
                        /*   {
                               field: 'stockInStatus', title: '入库状态', templet: function (d) {
                                   if (d.stockInStatus == 0) {
                                       return '未完成入库'
                                   } else if (d.stockInStatus == 1) {
                                       return '已完成入库'
                                   } else {
                                       return ''
                                   }
                               }
                           }*/
                    ]],
                    height: 'full-430',
                    page: true,
                    where: {
                        melOrderId: melOrderId,
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

            // 点击选合同
            $(document).on('click', '.chooseManagementBudget', function () {
                if(!$('#baseForm [name="customerName"]').attr('customerId')){
                    layer.msg('请先选择客商单位名称！', {icon: 0, time: 2000});
                    return false
                }
                layer.open({
                    type: 1,
                    title: '选择合同',
                    area: ['70%', '60%'],
                    maxmin: true,
                    btnAlign:'c',
                    btn: ['确定', '取消'],
                    content: ['<div class="layui-form">' +
                    //表格数据
                    '       <div style="padding: 10px">' +
                    '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                    '      </div>' +
                    '</div>'].join(''),
                    success: function () {
                        table.render({
                            elem: '#mtlPlanIdTable',
                            url: '/plbMtlContract/selectAll',
                            where:{projId:$('#leftId').attr('projId'),customer:$('#baseForm [name="customerName"]').attr('customerId'),useFlag:true},
                            page:true,
                            cols: [[
                                {type: 'radio', title: '选择'},
                                {field: 'contractName', title: '合同名称', width: 200,},
                                {field: 'contractType', title: '合同类型',templet: function (d) {
                                        return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || ''
                                    }},
                                {
                                    field: 'contractPeriod', title: '合同工期',
                                },
                                {field: 'contractMoney', title: '合同金额',},
                            ]],
                            parseData: function(res){ //res 即为原始返回的数据
                                return {
                                    "code": 0, //解析接口状态
                                    "count": res.totleNum, //解析数据长度
                                    "data": res.obj //解析数据列表
                                };
                            }
                        });
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('mtlPlanIdTable')
                        if (checkStatus.data.length > 0) {
                            var chooseData = checkStatus.data[0];
                            $('#baseForm [name="mtlContractName"]').val(chooseData.contractName)
                            $('#baseForm [name="mtlContractName"]').attr('mtlContractId',chooseData.mtlContractId)


                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0, time: 2000});
                        }
                    }
                });
            });

            //监听本次入库数量
            $(document).on('input propertychange', '.stockInQuantityItem', function () {
                if(disabled == '1'){
                    return false
                }

                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var stockInQuantity=0
                var taxPeice=0
                $tr.each(function () {
                    stockInQuantity=accAdd(stockInQuantity,$(this).find('input[name="stockInQuantity"]').val())

                    /*var p1=($(this).find('input[name="stockInQuantity"]').val() || 0) * ($(this).find('input[name="taxPeice"]').val() || 0)*/
                    var p1=mul(($(this).find('input[name="stockInQuantity"]').val() || 0) , ($(this).find('input[name="taxPeice"]').val() || 0))
                    taxPeice=accAdd(taxPeice,p1)
                });
                //计算入库总数量
                $('#baseForm [name="stockInTotal"] ').val(retainDecimal(stockInQuantity,3))
                //计算入库总金额
                $('#baseForm [name="stockInAmount"] ').val(retainDecimal(taxPeice,2))

                //计算含税总价和不含税总价
                if($(this).val() && $(this).parents('tr').find('[name="taxPeice"]').val()){
                    // $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="taxPeice"]').val(),2))
                    $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="taxPeice"]').val()),2))
                }
                if($(this).val() && $(this).parents('tr').find('[name="noTaxPeice"]').val()){
                    // $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="noTaxPeice"]').val(),2))
                    $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="noTaxPeice"]').val()),2))
                }

                //计算税金
                // var taxes=$(this).parents('tr').find('[name="taxMoney"]').val() - $(this).parents('tr').find('[name="noTaxMoney"]').val()
                var taxes=sub($(this).parents('tr').find('[name="taxMoney"]').val() , $(this).parents('tr').find('[name="noTaxMoney"]').val())
                $(this).parents('tr').find('[name="taxes"]').val(retainDecimal(taxes,2))
            });

            //监听含税单价
            $(document).on('input propertychange', '.taxPeiceItem', function () {
                if(disabled == '1'){
                    return false
                }
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var taxPeice=0
                $tr.each(function () {
                    // var p1=($(this).find('input[name="stockInQuantity"]').val() || 0) * ($(this).find('input[name="taxPeice"]').val() || 0)
                    var p1=mul(($(this).find('input[name="stockInQuantity"]').val() || 0) , ($(this).find('input[name="taxPeice"]').val() || 0))
                    taxPeice=accAdd(taxPeice,p1)
                });
                $('#baseForm [name="stockInAmount"] ').val(retainDecimal(taxPeice,2))

                //计算不含税单价
                if($(this).val() && $(this).parents('tr').find('[name="taxRate"]').val()){
                    var taxPeiceItem=$(this).val()
                    var taxRateItem=$(this).parents('tr').find('[name="taxRate"]').val() * 0.01
                    // $(this).parents('tr').find('[name="noTaxPeice"]').val(retainDecimal(taxPeiceItem / (1+taxRateItem),8))
                    $(this).parents('tr').find('[name="noTaxPeice"]').val(retainDecimal(div(taxPeiceItem,accAdd(1,taxRateItem)),8))
                }

                //计算含税总价和不含税总价
                if($(this).val() && $(this).parents('tr').find('[name="stockInQuantity"]').val()){
                    // $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal($(this).val() * $(this).parents('tr').find('[name="stockInQuantity"]').val(),2))
                    $(this).parents('tr').find('[name="taxMoney"]').val(retainDecimal(mul($(this).val() , $(this).parents('tr').find('[name="stockInQuantity"]').val(),2)))
                }
                if($(this).parents('tr').find('[name="noTaxPeice"]').val() && $(this).parents('tr').find('[name="stockInQuantity"]').val()){
                    // $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal($(this).parents('tr').find('[name="noTaxPeice"]').val() * $(this).parents('tr').find('[name="stockInQuantity"]').val(),2))
                    $(this).parents('tr').find('[name="noTaxMoney"]').val(retainDecimal(mul($(this).parents('tr').find('[name="noTaxPeice"]').val() , $(this).parents('tr').find('[name="stockInQuantity"]').val()),2))
                }

                //计算税金
                // var taxes=$(this).parents('tr').find('[name="taxMoney"]').val() - $(this).parents('tr').find('[name="noTaxMoney"]').val()
                var taxes=sub($(this).parents('tr').find('[name="taxMoney"]').val() , $(this).parents('tr').find('[name="noTaxMoney"]').val())
                $(this).parents('tr').find('[name="taxes"]').val(retainDecimal(taxes,2))

            });


            //监听客商单位名称选择
            $(document).on('click', '.chooseCustomerName', function () {
                var _this = $(this);
                layer.open({
                    type: 1,
                    title: '选择供应商',
                    area: ['100%', '100%'],
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
                        //查询
                        '       <div class="layui-row inSearchContent">' +
                        '             <div class="layui-col-xs4">\n' +
                        '                  <input type="text" name="customerName" placeholder="客商单位名称" autocomplete="off" class="layui-input">\n' +
                        '             </div>\n' +
                        '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                        '                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                        '             </div>\n' +
                        '       </div>'+
                        '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                        '</div>' +
                        '<div class="mtl_no_data" style="text-align: center;">' +
                        '<div class="no_data_img">' +
                        '<img style="margin-top: 12%;" src="/img/noData.png">' +
                        '</div>' +
                        '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择供应商</p>' +
                        '</div>' +
                        '</div>',
                        '</div></div>'].join(''),
                    success: function () {
                        $('.tree_module').height($(window).height() - 150)
                        // 树节点点击事件
                        eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                            var currentData = d.data.currentData;
                            if (currentData.typeNo) {
                                $('.mtl_no_data').hide();
                                $('.mtl_table_box').show();
                                loadMtlTable(currentData.typeNo);
                            } else {
                                $('.mtl_table_box').hide();
                                $('.mtl_no_data').show();
                            }
                        });

                        loadMtlType();

                        function loadMtlType(typeNo) {
                            typeNo = typeNo ? typeNo : '';
                            // 获取左侧树
                            $.get('/PlbCustomerType/treeList', function (res) {
                                if (res.flag) {
                                    eleTree.render({
                                        elem: '#chooseMtlTree',
                                        data: res.data,
                                        highlightCurrent: true,
                                        showLine: true,
                                        defaultExpandAll: false,
                                        request: {
                                            name: "typeName", // 显示的内容
                                            key: "typeNo", // 节点id
                                            parentId: 'parentTypeId', // 节点父id
                                            isLeaf: "isLeaf",// 是否有子节点
                                            children: 'child',
                                        }
                                    });
                                }
                            });
                        }

                        function loadMtlTable(typeNo) {
                            materialsTable=table.render({
                                elem: '#materialsTable',
                                url: '/PlbCustomer/getDataByCondition',
                                where: {
                                    merchantType:typeNo,
                                    useFlag: true
                                },
                                page: true, //开启分页
                                limit: 50,
                                height: 'full-180',
                                cols: [[ //表头
                                    {type: 'radio'}
                                    , {field: 'customerNo', title: '客商编号', width: 200}
                                    , {field: 'customerName', title: '客商单位名称',width: 200}
                                    , {field: 'customerShortName', title: '客商单位简称',width: 200}
                                    , {field: 'customerOrgCode', title: '组织机构代码',width: 200}
                                    , {field: 'taxNumber', title: '税务登记号',width: 200}
                                    , {field: 'accountNumber', title: '开户行账户',minWidth: 200}
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
                                },
                            });
                        }
                    },
                    yes: function (index) {
                        var checkStatus = table.checkStatus('materialsTable');
                        if (checkStatus.data.length > 0) {
                            var mtlData = checkStatus.data[0];
                            _this.val(mtlData.customerName);
                            _this.attr('customerId',mtlData.customerId);


                            layer.close(index);
                        } else {
                            layer.msg('请选择一项！', {icon: 0});
                        }
                    }
                });
            });

            //选择分包商内侧查询
            $(document).on('click','.inSearchData',function () {
                var searchParams = {}
                var $seachData = $('.inSearchContent [name]')
                $seachData.each(function () {
                    searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
                })
                materialsTable.reload({
                    where: searchParams,
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                });
            });


            //保存
           /* $(document).on('click','#save',function () {

            })*/

        });
    }


    function childFunc(){
        if(disabled&&disabled=='1'){
            return false
        }

        var lock=false
        //材料计划数据
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

        //客商单位名称的id
        obj.customerId=$('#baseForm [name="customerName"]').attr('customerId')
        //合同id
        obj.mtlContractId = $('#baseForm input[name="mtlContractName"]').attr('mtlContractId') || '';

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
            return false;
        }

        //入库明细数据
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var materialDetailsArr = [];
        $tr.each(function () {
            if($(this).find('input[name="stockInQuantity"]').val() == ''){
                layer.msg('请填写本次入库数量！', {icon: 0});
                lock=true
                return false
            }

            //采购订单数量-已入库数量-在途中入库数量-本次入库数量>=0,否则无法提交
            var sum=$(this).find('input[name="purchaseOrderQuantity"]').val() - $(this).find('input[name="stockInSum"]').val() - $(this).find('input[name="quantityTransit"]').val() - $(this).find('input[name="stockInQuantity"]').val()
            if(sum < 0){
                layer.msg('需采购订单数量-已入库数量-在途中入库数量-本次入库数量>=0,否则无法提交！', {icon: 0});
                lock=true
                return false
            }

            var materialDetailsObj = {
                mtlName: $(this).find('[data-field="mtlName"] .layui-table-cell').text(),
                mtlLibId: $(this).find('input[name="stockInQuantity"]').attr('mtlLibId'),
                mtlOrderLisId: $(this).find('input[name="stockInQuantity"]').attr('mtlOrderLisId'),
                mtlContractId: $(this).find('input[name="stockInQuantity"]').attr('mtlContractId'),
                mtlUnit: $(this).find('input[name="stockInQuantity"]').attr('mtlUnit'),
                mtlValuationUnit: $(this).find('input[name="stockInQuantity"]').attr('mtlValuationUnit'),
                mtlStandard: $(this).find('[data-field="mtlStandard"] .layui-table-cell span').text(), //材料规格
                mtlValuationUnit:$(this).find('input[name="mtlValuationUnit"]').attr('mtlValuationUnit'), //单位
                stockInQuantity: $(this).find('input[name="stockInQuantity"]').val(),
                taxPeice: $(this).find('input[name="taxPeice"]').val(),
                noTaxPeice: $(this).find('input[name="noTaxPeice"]').val(),
                taxRate: $(this).find('input[name="taxRate"]').attr('taxRate'),//税率
                taxes: $(this).find('input[name="taxes"]').attr('taxes'),//税金
                checkState: $(this).find('input[name="checkState"]').val(),
                remark: $(this).find('input[name="remark"]').val(),
                purchaseOrderQuantity: $(this).find('input[name="purchaseOrderQuantity"]').val(),//采购订单数量
                stockInSum: $(this).find('input[name="stockInSum"]').val(),//已入库数量
                quantityTransit: $(this).find('input[name="quantityTransit"]').val(),//在途入库数量
                taxMoney: $(this).find('input[name="taxMoney"]').val(),//含税总价
                noTaxMoney: $(this).find('input[name="noTaxMoney"]').val(),//不含税总价
                wbsName: $(this).find('[data-field="wbsName"] .layui-table-cell span').text(),//wbsName
                wbsId: $(this).find('[data-field="wbsName"] .layui-table-cell span').attr('wbsId'),//wbsId
                cbsName: $(this).find('[data-field="cbsName"] .layui-table-cell span').text(),//cbsName
                cbsId: $(this).find('[data-field="cbsName"] .layui-table-cell span').attr('cbsId'),//cbsId
            }
            if ($(this).find('input[name="stockInQuantity"]').attr('stockInListId')) {
                materialDetailsObj.stockInListId = $(this).find('input[name="stockInQuantity"]').attr('stockInListId');
            }
            materialDetailsArr.push(materialDetailsObj);
        });
        obj.plbMtlStockInLists = materialDetailsArr;

        if(lock){
            return false
        }

        var loadIndex = layer.load();

        obj.mtlStockInId = $('.plan_base_info input[name="customerName"]').attr('mtlStockInId')


        var _flag = false;
        $.ajax({
            url: '/plbMtlStockIn/updatePlbMtlStockIn',
            data: JSON.stringify(obj),
            dataType: 'json',
            contentType: "application/json;charset=UTF-8",
            type: 'post',
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