<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2021/5/17
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
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
        <title>材料采购订单预览</title>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
        <link rel="stylesheet" href="/lib/layui/layui/css/eleTree.css">

        <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
        <script type="text/javascript" src="/js/base/base.js"></script>
        <script type="text/javascript" src="/lib/layui/layui/global.js?20210527.1"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
        <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
        <script type="text/javascript" src="/js/planbudget/common.js?20210630.1"></script>
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
                margin-left: 8%;
                color: #00c4ff !important;
                font-weight: 600;
                cursor: pointer;
            }

            .export_moudle {
                display: none;
                position: absolute;
                top: 100%;
                right: 0;
                width: 120px;
                padding: 10px;
                background-color: #fff;
                text-align: left;
                color: #222;
                box-shadow: 0 0px 1px 0px rgb(0 0 0 / 50%);
                opacity: 1 !important;
            }

            .export_moudle > p:hover {
                cursor: pointer;
                color: #1E9FFF;
            }
            .layui-col-xs6{
                width: 20%;
            }
            .layui-col{
                width: 19%;
            }
            .choose_mtl_plan_box .layui-input-block{
                margin-left: 50px;
            }
        </style>
    </head>
    <body>

    <div id="htmBox">

    </div>

    <script type="text/html" id="toolbarDemoIn">
        <div class="layui-btn-container" style="height: 30px;">
            <button class="layui-btn layui-btn-sm" lay-event="add">加行</button>
        </div>
    </script>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
    </script>

        <script>
            var htmBox = ['<form id="baseForm" class="layui-form" lay-filter="baseForm"><div class="layer_wrap disabledAll" id="leftId"><div class="layui-collapse">',
                /* region 材料计划 */
                '<div class="layui-colla-item"><h2 class="layui-colla-title">材料采购订单</h2>' +
                '<div class="layui-colla-content layui-show order_base_info">',
                /* region 第一行 */
                '<div class="layui-row">' +
                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">订单编号<span field="orderNo" class="field_required">*</span><a title="刷新编号" class="refresh_no_btn"><i class="layui-icon layui-icon-refresh"></i></a></label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" readonly name="orderNo" autocomplete="off" class="layui-input">' +
                '</div>' +
                '</div>' +
                '</div>',
                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">项目名称<span class="field_required">*</span></label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" id="projName" name="projName" readonly autocomplete="off"  class="layui-input">' +
                '</div>' +
                '</div>' +
                '</div>',
                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">合同名称<span field="mtlContractId" class="field_required">*</span></label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" readonly name="mtlContractId" autocomplete="off" style="cursor: pointer;background-color: #e7e7e7;" placeholder="请选择合同" class="layui-input choose_contract">' +
                '</div>' +
                '</div>' +
                '</div>',
                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">供应商</label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" name="customerId" readonly autocomplete="off" style="background-color: #e7e7e7;" class="layui-input choose_customerId">' +
                '</div>' +
                '</div>' +
                '</div>',
                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">本次采购订单量合计</label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" readonly name="thisPurchaseNum" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
                '</div>' +
                '</div>' +
                '</div>',
                '</div>',
                /* endregion */
                /* region 第二行 */
                // '<div class="layui-row">' +
                //
                //
                // '</div>',
                /* endregion */
                /* region 第三行 */
                '<div class="layui-row">' +
                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">本次采购订单总金额合计</label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" readonly name="totalNumber" autocomplete="off" style="background-color: #e7e7e7;" class="layui-input">' +
                '</div>' +
                '</div>' +
                '</div>',
                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">业务日期<span field="businessDate" class="field_required">*</span></label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" name="businessDate" autocomplete="off" id="businessDate" class="layui-input">' +
                '</div>' +
                '</div>' +
                '</div>',
                '<div class="layui-col-xs6" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">备注</label>' +
                '<div class="layui-input-block form_block">' +
                '<textarea name="remarks" class="layui-input" style="resize: none;width:100%"></textarea>' +
                '</div>' +
                '</div>' +
                '</div>',
                '</div>',
                /* endregion */
                /* region 第四行 */
                // '<div class="layui-row">' +
                //
                // '</div>',
                /* endregion */
                /* region 第五行 */
                '<div class="layui-row">' +
                '<div class="layui-col-xs12" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">附件</label>' +//<span field="attachmentId" class="field_required">*</span>
                '<div class="layui-input-block form_block">' +
                '<div class="file_module">' +
                '<div id="fileContent" class="file_content"></div>' +
                '<div class="file_upload_box">' +
                '<a href="javascript:;" class="open_file">' +
                '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
                '<input type="file" multiple id="fileupload" data-url="/upload?module=planbudget" name="file">' +
                '</a>' +
                '<div class="progress">' +
                '<div class="bar"></div>\n' +
                '</div>' +
                '<div class="bar_text"></div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>'+
                '</div>',
                /* endregion */
                '</div>' +
                '</div>',
                /* endregion */
                /* region 材料明细 */
                '<div class="layui-colla-item"><h2 class="layui-colla-title">材料明细</h2>' +
                '<div class="layui-colla-content layui-show mtl_info">' +
                '<div id="detailModule"><table id="detailTable" lay-filter="detailTable"></table></div>' +
                '</div>' +
                '</div>',
                /* endregion */
                /* region 其他 */
                '<div class="layui-colla-item"><h2 class="layui-colla-title">其他</h2>' +
                '<div class="layui-colla-content layui-show">',
                '<div class="layui-row">' +
                '<div class="layui-col-xs4" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">编制人<span style="margin: 0 20px;">流程定义某节点为编制节点</span>编制时间</label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" autocomplete="off" readonly class="layui-input" id="createTime">' +
                '</div>' +
                '</div>' +
                '</div>',
                '<div class="layui-col-xs4" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">审批人<span style="margin: 0 20px;">流程定义某节点为审批节点</span>审批时间</label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" autocomplete="off" readonly class="layui-input" id="approvalTime">' +
                '</div>' +
                '</div>' +
                '</div>',
                '<div class="layui-col-xs4" style="padding: 0 5px">' +
                '<div class="layui-form-item">' +
                '<label class="layui-form-label form_label">审核人<span style="margin: 0 20px;">流程定义某节点为审核节点</span>审核时间</label>' +
                '<div class="layui-input-block form_block">' +
                '<input type="text" autocomplete="off" readonly class="layui-input" id="auditerTime">' +
                '</div>' +
                '</div>' +
                '</div>',
                '</div>',
                '</div>' +
                '</div>',
                /* endregion */
                '</div></div></form>'].join('');

            $("#htmBox").html(htmBox);


            var type =  $.GetRequest()['type'] || '';
            var melOrderId = $.GetRequest()['melOrderId'] || '';
            var runId = $.GetRequest()['runId'] || '';
            var _disabled = $.GetRequest()['disabled'] || '';
            if(_disabled){
                if(_disabled==="0"||_disabled===0){
                    type = 2;
                }else if(_disabled==="1"||_disabled===1){
                    type = 4;
                }
            }

            // 获取数据字典数据
            var dictionaryObj = {
                CBS_UNIT: {},
                QUALITY_REQUIREMENT: {},
                CONTROL_MODE: {},
            }
            var dictionaryStr = 'CBS_UNIT,QUALITY_REQUIREMENT,CONTROL_MODE';
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
                var loadIndex = layer.load();
                // 获取项目信息
                if (runId) {
                    $.get('/plbMtlOrder/getDataByRunId', {runId: runId}, function (res) {
                        layer.close(loadIndex);
                        if (!res.flag) {
                            layer.msg('获取信息失败！', {icon: 2});
                        }
                        initPage(res.data);
                    });
                } else if (melOrderId) {
                    $.get('/plbMtlOrder/getDataByIdMelOrderId', {melOrderId: melOrderId}, function (res) {
                        layer.close(loadIndex);
                        if (!res.flag)  {
                            layer.msg('获取信息失败！', {icon: 2});
                        }
                        initPage(res.data);
                    });
                } else {
                    layer.close(loadIndex);
                    layer.msg('获取信息失败！', {icon: 2});
                    initPage();
                }
            });

            function initPage(data) {
                layui.use(['form', 'laydate', 'table', 'element', 'soulTable', 'eleTree', 'xmSelect'], function () {
                    var layForm = layui.form,
                        laydate = layui.laydate,
                        layTable = layui.table,
                        layElement = layui.element,
                        soulTable = layui.soulTable,
                        eleTree = layui.eleTree,
                        xmSelect = layui.xmSelect;

                    layElement.render();

                    layForm.render();

                    if (data) {
                        $.get('/plbProj/queryByProjId', {projId: data.projId}, function(res) {
                            if (res.flag) {
                                $('#projName').val(res.data.projName);
                            }
                        });

                        $('#htmBox').attr('melOrderId',data.melOrderId);
                        $('#htmBox').attr('projId',data.projId);
                        $('#leftId').attr('projId',data.projId)

                        fileuploadFn('#fileupload', $('#fileContent'));

                        laydate.render({
                            elem: '#businessDate'
                            , trigger: 'dblclick'
                            , format: 'yyyy-MM-dd'
                            // , format: 'yyyy-MM-dd HH:mm:ss'
                            //, value: (data&&data.businessDate)||new Date()
                        });

                        laydate.render({
                            elem: '#createTime' //指定元素
                            , trigger: 'click' //采用click弹出
                            , value: data ? format(data.createTime) : ''
                        });
                        laydate.render({
                            elem: '#approvalTime' //指定元素
                            , trigger: 'click' //采用click弹出
                            , value: data ? format(data.approvalTime) : ''
                        });
                        laydate.render({
                            elem: '#auditerTime' //指定元素
                            , trigger: 'click' //采用click弹出
                            , value: data ? format(data.auditerTime) : ''
                        });

                        var materialDetailsTableData = [];

                        // 编辑时显示数据
                        if (type == 2||type == 4) {
                            $('.order_base_info input[name="orderNo"]').val(data.orderNo || '');
                            $('.order_base_info input[name="mtlContractId"]').attr('mtlContractId', data.mtlContractId || '').val(data.mtlContractName || '');
                            $('.order_base_info input[name="customerId"]').attr('customerId', data.customerId || '').val(data.customerName || '');
                            $('.order_base_info [name="remarks"]').val(data.remarks || '');
                            $('.order_base_info input[name="thisPurchaseNum"]').val(data.thisPurchaseNum || '');
                            $('.order_base_info input[name="totalNumber"]').val(data.totalNumber || '');
                            $('.order_base_info input[name="businessDate"]').val(data.businessDate || '');

                            materialDetailsTableData = data.mtlOrderList || [];

                            /*$('#fileContent').html(getFileEleStr(data.attachmentList, true));*/
                            if (data.attachmentList && data.attachmentList.length > 0) {
                                var fileArr = data.attachmentList;
                                $('#fileContent').append(echoAttachment(fileArr));
                            }
                        }

                        layElement.render();

                        var cols=[
                            {type: 'numbers', title: '序号'},
                            {
                                field: 'wbsName', title: 'WBS', minWidth: 160, templet: function (d) {
                                    return '<span class="mtl_info_wbsName" wbsId="' + (d.wbsId || '') + '">' + undefind_nullStr(d.wbsName) + '</span>';
                                }
                            },
                            {
                                field: 'cbsName', title: 'RBS', minWidth: 160, templet: function (d) {
                                    return '<span class="mtl_info_rbsName" rbsId="' + (d.rbsId || '') + '">' + undefind_nullStr(d.rbsName) + '</span>';
                                }
                            },
                            {
                                field: 'cbsName', title: 'CBS', minWidth: 120, templet: function (d) {
                                    return '<span class="mtl_info_cbsName" cbsId="' + (d.cbsId || '') + '">' + undefind_nullStr(d.cbsName) + '</span>';
                                }
                            },
                            {
                                field: 'planMtlName', title: '材料名称', minWidth: 100, templet: function (d) {
                                    if (d.plbMtlLibrary) {
                                        return '<span class="mtl_info_planMtlName" mtlLibId="' + (d.plbMtlLibrary.mtlLibId || '') + '" mtlOrderLisId="' + (d.mtlOrderLisId || '') + '" mtlPlanListId="' + (d.mtlPlanListId || '') + '">' + undefind_nullStr(d.plbMtlLibrary.mtlName) + '</span>';
                                    } else {
                                        return '<span class="mtl_info_planMtlName" mtlLibId="' + (d.mtlLibId || '') + '" mtlOrderLisId="' + (d.mtlOrderLisId || '') + '" mtlPlanListId="' + (d.mtlPlanListId || '') + '">' + undefind_nullStr(d.planMtlName) + '</span>';
                                    }
                                }
                            },
                            {
                                field: 'planMtlStandard', title: '材料规格', minWidth: 100, templet: function (d) {
                                    if (d.plbMtlLibrary) {
                                        return '<span class="mtl_info_planMtlStandard">' + (d.plbMtlLibrary.mtlStandard || '') + '</span>';
                                    } else {
                                        return '<span class="mtl_info_planMtlStandard">' + (d.planMtlStandard || '') + '</span>';
                                    }
                                }
                            },
                            {
                                field: 'mtlUnit', title: '计量单位', minWidth: 120, templet: function (d) {
                                    // if (d.plbMtlLibrary) {
                                    // 	if(d.controlType!=undefined&&d.controlType=="01"){
                                    // 		return '<span class="mtl_info_valuationUnit" valuationUnit="' + (d.plbMtlLibrary.mtlValuationUnit || '') + '">' + (dictionaryObj['CBS_UNIT']['object'][d.plbMtlLibrary.mtlValuationUnit] || '') + '</span>';
                                    // 	}else{
                                    // 		return '<span class="mtl_info_valuationUnit" valuationUnit="' + (d.plbMtlLibrary.mtlValuationUnit || '') + '">' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.plbMtlLibrary.mtlValuationUnit] || '') + '</span>';
                                    // 	}
                                    // } else {
                                    // 	if(d.controlType!=undefined&&d.controlType=="01"){
                                    // 		return '<span class="mtl_info_valuationUnit" mtlUnit="' + (d.valuationUnit || '') + '" valuationUnit="' + (d.valuationUnit || '') + '">' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '</span>';
                                    // 	}else{
                                    // 		return '<span class="mtl_info_valuationUnit" mtlUnit="' + (d.valuationUnit || '') + '" valuationUnit="' + (d.valuationUnit || '') + '">' + (dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '') + '</span>';
                                    // 	}
                                    //}
                                    return '<span class="mtl_info_valuationUnit" mtlUnit="' + (d.valuationUnit || '') + '" valuationUnit="' + (d.valuationUnit || '') + '">' + (dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '') + '</span>';

                                }
                            },
                            // {
                            // 	field: 'controlType', title: '控制方式', minWidth: 100, templet: function (d) {
                            // 		return '<span class="mtl_info_controlType" controlType="' + (d.controlType || '') + '">' + (dictionaryObj['CONTROL_MODE']['object'][d.controlType] || '') + '</span>';
                            // 	}
                            // },
                            {
                                field: 'thisAmount', title: '需求计划数量', minWidth: 120, templet: function (d) {
                                    return '<span class="mtl_info_thisAmount">' + undefind_nullStr(d.thisAmount) + '</span>';
                                }
                            },
                            {
                                field: 'demandPlanning', title: '已下订单数量', minWidth: 120, templet: function (d) {
                                    return '<span class="mtl_info_demandPlanning">' + (d.demandPlanning|| 0) + '</span>';
                                }
                            },
                            {
                                field: 'thisTotalPrice', title: '需求计划总金额', minWidth: 140, templet: function (d) {
                                    // return '<span class="mtl_info_thisTotalPrice">' +d.thisTotalPrice?d.thisTotalPrice:0 + '</span>';
                                    return '<span class="mtl_info_thisTotalPrice">' + (d.thisTotalPrice|| 0) + '</span>';
                                }
                            },
                            {
                                field: 'totalAmountOfPurchaseOrder', title: '已下订单总金额', minWidth: 140, templet: function (d) {
                                    return '<span class="mtl_info_totalAmountOfPurchaseOrder">' + undefind_nullStr(d.totalAmountOfPurchaseOrder) + '</span>';
                                }
                            },
                            {
                                field: 'estimatedPrice', title: '预计单价', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="estimatedPrice" autocomplete="off" pointFlag="1" pointNum="3" handleCallback="afterFloatChange" class="layui-input input_floatNum" style="height: 100%" value="' + (d.estimatedPrice || '') + '">'
                                }
                            },
                            // {
                            // 	field: 'directUnitPrice', title: '指导单价', minWidth: 120, templet: function (d) {
                            // 		if (d.plbMtlLibrary) {
                            // 			return '<span class="mtl_info_directUnitPrice">' + undefind_nullStr(d.plbMtlLibrary.mtlPriceUnit) + '</span>';
                            // 		} else {
                            // 			return '<span class="mtl_info_directUnitPrice">' + undefind_nullStr(d.directUnitPrice) + '</span>';
                            // 		}
                            // 	}
                            // },
                            {
                                field: 'purchaseQuantity', title: '采购数量*', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="purchaseQuantity" autocomplete="off" pointFlag="1" pointNum="3" handleCallback="afterFloatChange" class="layui-input input_floatNum" style="height: 100%" value="' + (d.purchaseQuantity || '') + '">'
                                }
                            },
                            {
                                field: 'total', title: '本次合价*', minWidth: 120, templet: function (d) {
                                    return '<input type="text" name="total" readonly autocomplete="off" class="layui-input total" style="height: 100%;background-color: #e7e7e7;" value="' + (d.total || '') + '">'
                                }
                            },
                            {
                                field: 'usePlace', title: '使用部位', minWidth: 120, templet: function (d) {
                                    return '<span class="mtl_info_usePlace">' + undefind_nullStr(d.usePlace) + '</span>';
                                }
                            },
                            {
                                field: 'qualityRequirement',
                                title: '质量要求',
                                minWidth: 120,
                                event: 'chooseQualityRequirement',
                                templet: function (d) {
                                    var _quality = ''
                                    if(dictionaryObj['QUALITY_REQUIREMENT']['object']){
                                        if(d.qualityRequirement){
                                            _quality = dictionaryObj['QUALITY_REQUIREMENT']['object'][d.qualityRequirement]
                                        }else {
                                            _quality = dictionaryObj['QUALITY_REQUIREMENT']['object']['01']
                                        }
                                    }
                                    return '<input type="text" name="qualityRequirement" qualityRequirement="' + (d.qualityRequirement || '01') + '" readonly autocomplete="off" class="layui-input" style="height: 100%; cursor: pointer;" value="' + _quality + '">'
                                }
                            }

                        ]

                        if(type!=4){
                            cols.push({fixed: 'right', align: 'center', toolbar: '#barDemo', title: '操作', width: 100});

                        }


                        // 初始化付款结算列表
                        layTable.render({
                            elem: '#detailTable',
                            data: materialDetailsTableData,
                            toolbar: type!=4?'#toolbarDemoIn':false,
                            defaultToolbar: [''],
                            limit: 1000,
                            cols: [cols]
                        });
                        //查看详情
                        if(type==4){
                            $('.disabledAll').find('input,select,textarea').attr('disabled','true')
                            $('.file_upload_box').hide()
                            $('.deImgs').hide()
                            layForm.render();
                        }

                        // 选择合同
                        $('.choose_contract').on('click', function () {
                            layer.open({
                                type: 1,
                                title: '选择合同',
                                maxmin:true,
                                area: ['80%', '80%'],
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: '<div id="contractTableModule"><div class="layui-row" style="margin-top: 10px;">' +
                                    '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractNo" type="text" autocomplete="off" placeholder="合同编号" class="layui-input" /></div>' +
                                    '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="contractName" type="text" autocomplete="off" placeholder="合同名称" class="layui-input" /></div>' +
                                    '<div class="layui-col-xs3" style="padding: 0 5px;"><input name="customerName" type="text" autocomplete="off" placeholder="供应商" class="layui-input" /></div>' +
                                    '<div class="layui-col-xs3" style="padding-top: 3px;"><button class="layui-btn layui-btn-sm" id="searchContract">查询</button></div>' +
                                    '</div>' +
                                    '<table id="chooseplbMtlContractTable" lay-filter="chooseplbMtlContractTable"></table></div>',
                                success: function () {
                                    var contractTableObj = null
                                    $('#searchContract').on('click', function () {
                                        var contractNo = $('input[name="contractNo"]', $('#contractTableModule')).val();
                                        var contractName = $('input[name="contractName"]', $('#contractTableModule')).val();
                                        var customerName=$('input[name="customerName"]',$('#contractTableModule')).val();
                                        contractTableObj.reload({
                                            where: {
                                                contractNo: contractNo,
                                                contractName: contractName,
                                                customerName:customerName,
                                                projId: projId,
                                                changeFlag:"1"
                                            }
                                        });
                                    });

                                    contractTableObj = layTable.render({
                                        elem: '#chooseplbMtlContractTable',
                                        url: '/plbMtlContract/selectAll',
                                        page: true,
                                        where: {
                                            projId: projId,
                                            changeFlag:"1",
                                            useFlag:true
                                        },
                                        request: {
                                            limitName: 'pageSize'
                                        },
                                        response: {
                                            statusName: 'flag',
                                            statusCode: true,
                                            msgName: 'msg',
                                            countName: 'totleNum',
                                            dataName: 'obj'
                                        },
                                        cols: [[
                                            {type: 'radio'},
                                            {field: 'contractNo', title: '合同编号', sort: true, hide: false},
                                            {field: 'contractName', title: '合同名称', sort: true, hide: false},
                                            {field:'contractAName',title:'甲方',sort:false,hide:false},
                                            {field:'customerName',title:'乙方',sort:false,hide:false},
                                            {field:'contractMoney',title:'合同金额',sort:false,hide:false},
                                            {
                                                field: 'contractType', title: '合同类型', sort: true, hide: false, templet: function (d) {
                                                    return dictionaryObj['CONTRACT_TYPE']['object'][d.contractType] || '';
                                                }
                                            },
                                            {
                                                field: 'signDate', title: '合同签订日期', sort: true, hide: false, templet: function (d) {
                                                    return format(d.signDate);
                                                }
                                            },
                                            // {field: 'customerName', title: '供应商单位', sort: true, hide: false},
                                            // {
                                            //     field: 'paymentType', title: '付款方式', sort: true, hide: false, templet: function (d) {
                                            //         return dictionaryObj['PAYMENT_METHOD']['object'][d.contractType] || '';
                                            //     }
                                            // }, {
                                            //     field: 'effectiveDate', title: '生效日期', sort: true, hide: false, templet: function (d) {
                                            //         return format(d.effectiveDate);
                                            //     }
                                            // }
                                        ]],
                                        done:function(res){
                                            delete this.where.contractNo;
                                            delete this.where.contractName;
                                            delete this.where.customerName;
                                        }
                                    });
                                },
                                yes: function (index) {
                                    var checkStatus = layTable.checkStatus('chooseplbMtlContractTable');

                                    if (checkStatus.data.length > 0) {
                                        var contractData = checkStatus.data[0];
                                        $('.choose_contract').val(contractData.contractName);
                                        $('.choose_contract').attr('mtlContractId', contractData.mtlContractId);
                                        $('.choose_customerId').attr('customerId', contractData.customerId);
                                        $('.choose_customerId').val(contractData.customerName);
                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0});
                                    }
                                }
                            });
                        });

                    }

                    // 内部加行按钮
                    layTable.on('toolbar(detailTable)', function (obj) {
                        switch (obj.event) {
                            case 'add':
                                var projId = $('#leftId').attr('projId');

                                if (!projId) {
                                    var checkStatus = layTable.checkStatus('tableObj');
                                    projId = checkStatus.data[0].projId;
                                }

                                var wbsSelectTree = null;
                                var rbsSelectTree = null;
                                var cbsSelectTree = null;

                                layer.open({
                                    type: 1,
                                    title: '选择材料需求计划',
                                    btn: ['确定', '取消'],
                                    btnAlign: 'c',
                                    area: ['90%', '80%'],
                                    content: ['<div class="choose_mtl_plan_box" style="padding: 5px;">',
                                        /* region 查询 */
                                        '<div class="layui-row">',
                                        '<div class="layui-col-xs4 layui-col">',
                                        '<div class="layui-form-item" style="margin-bottom: 10px;">',
                                        /*'<label class="layui-form-label" style="width: 95px; padding-left: 0;">材料计划编号</label>',*/
                                        '<div class="layui-input-block">',
                                        '<input type="text" name="listNo" placeholder="请输入材料计划编号" autocomplete="off" class="layui-input">',
                                        '</div>',
                                        '</div>',
                                        '</div>',
                                        '<div class="layui-col-xs4 layui-col">',
                                        '<div class="layui-form-item" style="margin-bottom: 10px;">',
                                        /*'<label class="layui-form-label" style="width: 95px; padding-left: 0;">材料计划名称</label>',*/
                                        '<div class="layui-input-block">',
                                        '<input type="text" name="planMtlName" placeholder="请输入材料计划名称" autocomplete="off" class="layui-input">',
                                        '</div>',
                                        '</div>',
                                        '</div>',
                                        '<div class="layui-col-xs4 layui-col">',
                                        '<div class="layui-form-item" style="margin-bottom: 10px;">',
                                        '<label class="layui-form-label" style="text-align: initial">WBS</label>',
                                        '<div class="layui-input-block">',
                                        '<div id="wbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>',
                                        '</div>',
                                        '</div>',
                                        '</div>',
                                        '<div class="layui-col-xs4 layui-col">',
                                        '<div class="layui-form-item" style="margin-bottom: 10px;">',
                                        '<label class="layui-form-label" style="text-align: initial">RBS</label>',
                                        '<div class="layui-input-block">',
                                        '<div id="rbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>',
                                        '</div>',
                                        '</div>',
                                        '</div>',
                                        '<div class="layui-col-xs4 layui-col">',
                                        '<div class="layui-form-item" style="margin-bottom: 10px;">',
                                        '<label class="layui-form-label" style="text-align: initial">CBS</label>',
                                        '<div class="layui-input-block">',
                                        '<div id="cbsSelectTree" class="xm-select-demo" style="width: 100%;"></div>',
                                        '</div>',
                                        '</div>',
                                        '</div>',
                                        '<div class="layui-col-xs4" style="width: 4%">',
                                        '<button class="layui-btn layui-btn-sm search_mtl" style="margin: 4px 15px;">查询</button>',
                                        '</div>',
                                        '</div>',
                                        '<div class="layui-row">',

                                        '</div>',
                                        /* endregion */
                                        '<table id="mtlPlanTable" lay-filter="mtlPlanTable"></table>',
                                        '</div>'].join(''),
                                    success: function () {
                                        // 获取WBS数据
                                        $.get('/plbProjWbs/getWbsTreeByProjId', {projId: projId}, function (res) {
                                            wbsSelectTree = xmSelect.render({
                                                el: '#wbsSelectTree',
                                                data: res.obj,
                                                name: 'wbsName',
                                                radio: true,
                                                clickClose: true,
                                                filterable: true,
                                                toolbar: {
                                                    show: true,
                                                    list: [
                                                        {
                                                            icon: 'layui-icon layui-icon-subtraction',
                                                            name: '折叠',
                                                            method: function (data) {
                                                                cbsSelectTree.changeExpandedKeys(false);
                                                            }
                                                        },
                                                        {
                                                            icon: 'layui-icon layui-icon-addition',
                                                            name: '展开',
                                                            method: function (data) {
                                                                cbsSelectTree.changeExpandedKeys(true);
                                                            }
                                                        }
                                                    ]
                                                },
                                                prop: {
                                                    name: 'wbsName',
                                                    value: 'wbsId',
                                                    children: 'child'
                                                },
                                                tree: {
                                                    show: true,
                                                    strict: false,
                                                    showFolderIcon: true,
                                                    showLine: true,
                                                    indent: 20
                                                }
                                            });
                                        });


                                        //获取RBS数据
                                        rbsSelectTree = xmSelect.render({
                                            el: '#rbsSelectTree',
                                            content: '<input type="text" placeholder="请输入关键字进行搜索" autocomplete="off" class="layui-input eleTree-search rbsSearch" style="width: 80%;margin: 5px"><div id="rbsTree" class="eleTree" lay-filter="rbsTree"></div>',
                                            name: 'rbsName',
                                            prop: {
                                                name: 'rbsName',
                                                value: 'rbsId'
                                            }
                                        });
                                        rbsData();
                                        // 树节点点击事件
                                        eleTree.on("nodeClick(rbsTree)", function (d) {
                                            var currentData = d.data.currentData;
                                            var obj = {
                                                rbsName: currentData.rbsName,
                                                rbsId: currentData.rbsId
                                            }
                                            rbsSelectTree.setValue([obj]);
                                        });
                                        var searchTimerRBS = null
                                        $('.rbsSearch').on('input propertychange', function () {
                                            clearTimeout(searchTimerRBS)
                                            searchTimerRBS = null
                                            var val = $(this).val()
                                            searchTimerRBS = setTimeout(function () {
                                                rbsData(val,'1')
                                            }, 300)
                                        });
                                        function rbsData(parentId,type){
                                            var obj = {};
                                            if(type == '1'){
                                                obj.rbsName=parentId?parentId:'';
                                            }else {
                                                obj.parentId=parentId?parentId:'1';
                                            }
                                            // 获取RBS数据
                                            $.get('/plbRbs/selectAll',obj, function (res) {
                                                var rbsTreeData = res.data || [];

                                                eleTree.render({
                                                    elem: '#rbsTree',
                                                    data: rbsTreeData,
                                                    highlightCurrent: true,
                                                    showLine: true,
                                                    defaultExpandAll: false,
                                                    accordion: true,
                                                    lazy: true,
                                                    request: {
                                                        name: 'rbsName',
                                                        children: "childList"
                                                    },
                                                    load: function (data, callback) {
                                                        $.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
                                                            callback(res.data);//点击节点回调
                                                        })
                                                    }
                                                });

                                            });
                                        }


                                        // 获取CBS数据
                                        $.get('/plbCbsType/getAllList', function (res) {
                                            cbsSelectTree = xmSelect.render({
                                                el: '#cbsSelectTree',
                                                data: res.data,
                                                name: 'cbsName',
                                                radio: true,
                                                clickClose: true,
                                                filterable: true,
                                                toolbar: {
                                                    show: true,
                                                    list: [
                                                        {
                                                            icon: 'layui-icon layui-icon-subtraction',
                                                            name: '折叠',
                                                            method: function (data) {
                                                                cbsSelectTree.changeExpandedKeys(false);
                                                            }
                                                        },
                                                        {
                                                            icon: 'layui-icon layui-icon-addition',
                                                            name: '展开',
                                                            method: function (data) {
                                                                cbsSelectTree.changeExpandedKeys(true);
                                                            }
                                                        }
                                                    ]
                                                },
                                                prop: {
                                                    name: 'cbsName',
                                                    value: 'cbsId',
                                                    children: 'childList'
                                                },
                                                tree: {
                                                    show: true,
                                                    strict: false,
                                                    showFolderIcon: true,
                                                    showLine: true,
                                                    indent: 20
                                                }
                                            });
                                        });

                                        $('.search_mtl').on('click', function () {
                                            var listNo = $('.choose_mtl_plan_box input[name="listNo"]').val();
                                            var planMtlName = $('.choose_mtl_plan_box input[name="planMtlName"]').val();
                                            var cbsId = cbsSelectTree.getValue('valueStr');
                                            var wbsId = wbsSelectTree.getValue('valueStr');
                                            var rbsId= rbsSelectTree.getValue('valueStr');

                                            getPlbMtlPlanList(wbsId,rbsId, cbsId, listNo, planMtlName);
                                        });

                                        getPlbMtlPlanList();

                                        /**
                                         * 获取材料需求计划列表
                                         * @param cbsId
                                         * @param wbsId
                                         * @param listNo
                                         * @param planMtlName
                                         */
                                        function getPlbMtlPlanList(wbsId,rbsId,cbsId,listNo, planMtlName) {
                                            layTable.render({
                                                elem: '#mtlPlanTable',
                                                url: '/plbMtlPlanList/getPlbMtlPlanListData',
                                                where: {
                                                    projId: projId,
                                                    cbsId: cbsId || '',
                                                    wbsId: wbsId || '',
                                                    rbsId:rbsId || '',
                                                    listNo: listNo || '',
                                                    planMtlName: planMtlName || '',
                                                    auditerStatusFlag:"true",
                                                    isOrder:"order"
                                                },
                                                page: true,
                                                limit: 20,
                                                request: {
                                                    limitName: 'pageSize'
                                                },
                                                response: {
                                                    statusName: 'flag',
                                                    statusCode: true,
                                                    msgName: 'msg',
                                                    countName: 'totleNum',
                                                    dataName: 'data'
                                                },
                                                cols: [[
                                                    {type: 'checkbox', title: '选择', fixed: 'left'},
                                                    {field: 'planNo', title: '材料计划编号', minWidth: 140},
                                                    {field: 'planName', title: '材料计划名称', minWidth: 140},
                                                    {field: 'wbsName', title: 'WBS', minWidth: 120},
                                                    {field: 'rbsName', title: 'RBS', minWidth: 120},
                                                    {field: 'cbsName', title: 'CBS', minWidth: 120},
                                                    {
                                                        field: 'controlMode', title: '控制方式', minWidth: 90, templet: function (d) {
                                                            return dictionaryObj['CONTROL_MODE']['object'][d.controlMode] || '';
                                                        }
                                                    },
                                                    {
                                                        field: 'planMtlName', title: '材料名称', minWidth: 90, templet: function (d) {
                                                            return d.plbMtlLibrary ? d.plbMtlLibrary.mtlName : d.planMtlName;
                                                        }
                                                    },
                                                    {
                                                        field: 'planMtlStandard', title: '材料规格', minWidth: 90, templet: function (d) {
                                                            var mtlStandard = d.plbMtlLibrary ? d.plbMtlLibrary.mtlStandard : d.planMtlStandard;
                                                            return mtlStandard || '';
                                                        }
                                                    },
                                                    // {field: 'directUnitPrice', title: '指导单价', minWidth: 90},
                                                    {field: 'estiUnitPrice', title: '预计单价', minWidth: 90},
                                                    {field: 'thisAmount', title: '需求计划量', minWidth: 100},
                                                    {field: 'demandPlanning', title: '已下采购订单数量', minWidth: 80, templet: function (d) {
                                                            return d.demandPlanning ? d.demandPlanning : 0;
                                                        }},
                                                    {field: 'thisTotalPrice', title: '需求计划总金额', minWidth: 80, templet: function (d) {
                                                            return d.thisTotalPrice ? d.thisTotalPrice : 0;
                                                        }},
                                                    {field: 'totalAmountOfPurchaseOrder', title: '已下采购订单总金额', minWidth: 80, templet: function (d) {
                                                            return d.totalAmountOfPurchaseOrder ? d.totalAmountOfPurchaseOrder : 0;
                                                        }},

                                                ]]
                                            });
                                        }
                                    },
                                    yes: function (index) {
                                        var checkStatus = layTable.checkStatus('mtlPlanTable');

                                        if (checkStatus.data.length > 0) {
                                            var chooseData = checkStatus.data[0];
                                            var newDataArr = [];

                                            checkStatus.data.forEach(function(item) {
                                                var newDataObj = {
                                                    mtlLibId: item.mtlLibId, // 材料id
                                                    listNo: item.plbMtlLibrary ? item.plbMtlLibrary.mtlNo : item.mtlLibNo, // 材料编号
                                                    mtlPlanListId: item.mtlPlanListId, // 材料计划明细id
                                                    planMtlName: item.plbMtlLibrary ? item.plbMtlLibrary.mtlName : item.planMtlName, // 材料名称
                                                    wbsId: item.wbsId, // wbs id
                                                    wbsName: item.wbsName, // wbs 名称
                                                    rbsId: item.rbsId, // rbs id
                                                    rbsName: item.rbsName, // rbs 名称
                                                    cbsId: item.cbsId, // cbs id
                                                    cbsName: item.cbsName, // cbs 名称
                                                    planMtlStandard: item.plbMtlLibrary ? item.plbMtlLibrary.mtlStandard : item.planMtlStandard, // 材料规格
                                                    controlType: item.controlMode, // 控制方式
                                                    usePlace: item.usePlace, // 使用部位
                                                    estimatedPrice: item.estiUnitPrice, // 预计单价
                                                    directUnitPrice: item.directUnitPrice, // 指导单价
                                                    valuationUnit: item.valuationUnit, // 计量单位
                                                    mtlUnit: item.valuationUnit, // 计量单位
                                                    thisAmount: item.thisAmount||0, // 需求计划数量
                                                    demandPlanning: item.demandPlanning||0, // 已下订单数量
                                                    thisTotalPrice: item.thisTotalPrice||0, // 需求计划总金额
                                                    totalAmountOfPurchaseOrder: item.totalAmountOfPurchaseOrder||0 // 已下订单总金额
                                                }
                                                newDataArr.push(newDataObj);
                                            });

                                            //遍历表格获取每行数据进行保存
                                            var $tr = $('.mtl_info').find('.layui-table-main tr');
                                            var oldDataArr = []
                                            $tr.each(function () {
                                                var oldDataObj = {
                                                    mtlOrderLisId: $(this).find('.mtl_info_planMtlName').attr('mtlOrderLisId') || '', // 订单明细id
                                                    mtlPlanListId: $(this).find('.mtl_info_planMtlName').attr('mtlPlanListId') || '', // 材料计划明细id
                                                    mtlLibId: $(this).find('.mtl_info_planMtlName').attr('mtlLibId') || '', // 材料id
                                                    wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId'), // wbs id
                                                    wbsName: $(this).find('.mtl_info_wbsName').text(), // wbs名称
                                                    rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId'), // rbs id
                                                    rbsName: $(this).find('.mtl_info_rbsName').text(), // rbs 名称
                                                    cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId'), // cbs id
                                                    cbsName: $(this).find('.mtl_info_cbsName').text(), // cbs 名称
                                                    listNo: $(this).find('.mtl_info_listNo').text(), // 材料编号
                                                    planMtlName: $(this).find('.mtl_info_planMtlName').text(), // 材料名称
                                                    planMtlStandard: $(this).find('.mtl_info_planMtlStandard').text(), // 材料规格
                                                    controlType: $(this).find('.mtl_info_controlType').attr('controlType') || '', // 控制方式
                                                    valuationUnit: $(this).find('.mtl_info_valuationUnit').attr('valuationUnit') || '', // 计量单位
                                                    mtlUnit: $(this).find('.mtl_info_valuationUnit').attr('valuationUnit') || '', // 计量单位
                                                    estimatedPrice: $(this).find('input[name="estimatedPrice"]').val(), // 预计单价
                                                    directUnitPrice: $(this).find('.mtl_info_directUnitPrice').text(), // 指导单价
                                                    purchaseQuantity: $(this).find('input[name="purchaseQuantity"]').val(), // 采购数量
                                                    thisAmount: $(this).find('.mtl_info_thisAmount').text()||0, // 需求计划数量
                                                    demandPlanning: $(this).find('.mtl_info_demandPlanning').text()||0, // 已下订单数量
                                                    thisTotalPrice: $(this).find('.mtl_info_thisTotalPrice').text()||0, // 需求计划总金额
                                                    totalAmountOfPurchaseOrder: $(this).find('.mtl_info_totalAmountOfPurchaseOrder').text()||0, // 已下订单总金额
                                                    total: $(this).find('input[name="total"]').val(), // 本次合价
                                                    usePlace: $(this).find('.mtl_info_usePlace').text(), // 使用部位
                                                    qualityRequirement: $(this).find('input[name="qualityRequirement"]').attr('qualityRequirement') || '' // 质量要求
                                                }
                                                oldDataArr.push(oldDataObj);
                                            });
                                            oldDataArr = oldDataArr.concat(newDataArr);
                                            layTable.reload('detailTable', {
                                                data: oldDataArr
                                            });
                                            layer.close(index);
                                        } else {
                                            layer.msg('请选择一项！', {icon: 0, time: 2000});
                                        }
                                    }
                                });
                                break;
                        }
                    });
                    // 内部删行操作
                    layTable.on('tool(detailTable)', function (obj) {
                        var data = obj.data;
                        var layEvent = obj.event;
                        var $tr = obj.tr;

                        if (layEvent === 'del') {
                            obj.del();
                            if (data.mtlOrderLisId) {
                                $.get('/plbMtlOrder/delPlbMtlOrderList', {mtlOrderListIds: data.mtlOrderLisId}, function (res) {

                                });
                            }
                            //遍历表格获取每行数据进行保存
                            var $tr = $('.mtl_info').find('.layui-table-main tr');
                            var oldDataArr = [];
                            $tr.each(function () {
                                var oldDataObj = {
                                    mtlOrderLisId: $(this).find('.mtl_info_planMtlName').attr('mtlOrderLisId') || '', // 订单明细id
                                    mtlPlanListId: $(this).find('.mtl_info_planMtlName').attr('mtlPlanListId') || '', // 材料计划明细id
                                    mtlLibId: $(this).find('.mtl_info_planMtlName').attr('mtlLibId') || '', // 材料id
                                    wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId'), // wbs id
                                    wbsName: $(this).find('.mtl_info_wbsName').text(), // wbs名称
                                    rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId'), // rbs id
                                    rbsName: $(this).find('.mtl_info_rbsName').text(), // rbs 名称
                                    cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId'), // cbs id
                                    cbsName: $(this).find('.mtl_info_cbsName').text(), // cbs 名称
                                    listNo: $(this).find('.mtl_info_listNo').text(), // 材料编号
                                    planMtlName: $(this).find('.mtl_info_planMtlName').text(), // 材料名称
                                    planMtlStandard: $(this).find('.mtl_info_planMtlStandard').text(), // 材料规格
                                    controlType: $(this).find('.mtl_info_controlType').attr('controlType') || '', // 控制方式
                                    valuationUnit: $(this).find('.mtl_info_valuationUnit').attr('valuationUnit') || '', // 计量单位
                                    mtlUnit: $(this).find('.mtl_info_valuationUnit').attr('valuationUnit') || '', // 计量单位
                                    estimatedPrice: $(this).find('input[name="estimatedPrice"]').val(), // 预计单价
                                    directUnitPrice: $(this).find('.mtl_info_directUnitPrice').text(), // 指导单价
                                    purchaseQuantity: $(this).find('input[name="purchaseQuantity"]').val(), // 采购数量
                                    thisAmount: $(this).find('.mtl_info_thisAmount').text(), // 需求计划数量
                                    demandPlanning: $(this).find('.mtl_info_demandPlanning').text(), // 已下订单数量
                                    thisTotalPrice: $(this).find('.mtl_info_thisTotalPrice').text(), // 需求计划总金额
                                    totalAmountOfPurchaseOrder: $(this).find('.mtl_info_totalAmountOfPurchaseOrder').text(), // 已下订单总金额
                                    total: $(this).find('input[name="total"]').val(), // 本次合价
                                    usePlace: $(this).find('.mtl_info_usePlace').text(), // 使用部位
                                    qualityRequirement: $(this).find('input[name="qualityRequirement"]').attr('qualityRequirement') || '' // 质量要求
                                }
                                oldDataArr.push(oldDataObj);
                            });
                            layTable.reload('detailTable', {
                                data: oldDataArr
                            });
                        } else if (layEvent === 'chooseQualityRequirement') {
                            layer.open({
                                type: 1,
                                title: '选择质量要求',
                                area: ['400px', '400px'],
                                btn: ['确定', '取消'],
                                btnAlign: 'c',
                                content: '<table id="chooseQualityRequirement" lay-filter="chooseQualityRequirement"></table>',
                                success: function () {
                                    var dataArr = []
                                    $.each(dictionaryObj['QUALITY_REQUIREMENT']['object'], function (k, o) {
                                        var obj = {
                                            qualityRequirement: k,
                                            qualityRequirementStr: o
                                        }
                                        dataArr.push(obj);
                                    });
                                    layTable.render({
                                        elem: '#chooseQualityRequirement',
                                        data: dataArr,
                                        cols: [[
                                            {type: 'radio', title: '选择'},
                                            {field: 'qualityRequirementStr', title: '质量要求'}
                                        ]]
                                    });
                                },
                                yes: function (index) {
                                    var checkStatus = layTable.checkStatus('chooseQualityRequirement');
                                    if (checkStatus.data.length > 0) {
                                        $tr.find('input[name="qualityRequirement"]').val(checkStatus.data[0].qualityRequirementStr);
                                        $tr.find('input[name="qualityRequirement"]').attr('qualityRequirement', checkStatus.data[0].qualityRequirement);
                                        layer.close(index);
                                    } else {
                                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                                    }
                                }
                            });
                        }
                    });



                });
            }

            function afterFloatChange(value, ele) {
                var name = $(ele).attr('name');

                if (name == 'estimatedPrice') { // 预计单价
                    var $tr = $(ele).parents('tr');
                    // 采购数量
                    var purchaseQuantity = checkFloatNum($tr.find('input[name="purchaseQuantity"]').val(), 3);
                    // 本次合价
                    var total = checkFloatNum(BigNumber(purchaseQuantity).multipliedBy(value), 3);
                    $tr.find('.total').val(total);

                    var $trs = $('.mtl_info').find('.layui-table-main tr');
                    var totalNumber = 0;
                    $trs.each(function () {
                        var total = checkFloatNum($(this).find('input[name="total"]').val(), 3); // 本次合价
                        totalNumber = BigNumber(total).plus(totalNumber);
                    });
                    $('input[name="totalNumber"]', $('.order_base_info')).val(totalNumber);
                } else if (name == 'purchaseQuantity') { // 采购数量
                    var $tr = $(ele).parents('tr');
                    // 预计单价
                    var estimatedPrice = checkFloatNum($tr.find('input[name="estimatedPrice"]').val(), 3);
                    // 本次合价
                    var total = checkFloatNum(BigNumber(value).multipliedBy(estimatedPrice), 3);
                    $tr.find('.total').val(total);

                    var $trs = $('.mtl_info').find('.layui-table-main tr');
                    var thisPurchaseNum = 0;
                    var totalNumber = 0;
                    $trs.each(function () {
                        var purchaseQuantity = checkFloatNum($(this).find('input[name="purchaseQuantity"]').val(), 3); // 采购数量
                        var total = checkFloatNum($(this).find('input[name="total"]').val(), 3); // 本次合价
                        thisPurchaseNum = BigNumber(purchaseQuantity).plus(thisPurchaseNum);
                        totalNumber = BigNumber(total).plus(totalNumber);
                    });
                    $('input[name="thisPurchaseNum"]', $('.order_base_info')).val(thisPurchaseNum);
                    $('input[name="totalNumber"]', $('.order_base_info')).val(totalNumber);
                }
            }

            /**
             * 获取需要保存的数据
             * @param saveType (1-新增, 2-编辑)
             * @param isSubmit (是否提交)
             * @param loadIndex
             * @param melOrderId (采购订单id)
             * @param projId
             */
            function getSaveData(saveType, isSubmit, loadIndex, melOrderId, projId) {
                // 材料订单数据
                var dataObj = {
                    orderNo: $('.order_base_info input[name="orderNo"]').val(),
                    mtlContractId: $('.order_base_info input[name="mtlContractId"]').attr('mtlContractId') || '',
                    customerId: $('.order_base_info input[name="customerId"]').attr('customerId') || '',
                    thisPurchaseNum: retainDecimal($('.order_base_info input[name="thisPurchaseNum"]').val(),3),
                    totalNumber: retainDecimal($('.order_base_info input[name="totalNumber"]').val(),2),
                    businessDate:$('.order_base_info input[name="businessDate"]').val()||'',
                    remarks: $('.order_base_info [name="remarks"]').val()
                }

                // 附件
                var attachmentId = '';
                var attachmentName = '';
                for (var i = 0; i < $('#fileContent .dech').length; i++) {
                    attachmentId += $('#fileContent .dech').eq(i).find('input').val();
                    attachmentName += $('#fileContent a').eq(i).attr('name');
                }
                dataObj.attachmentId = attachmentId;
                dataObj.attachmentName = attachmentName;

                //if (isSubmit) {
                // 判断必填项
                var requiredFlag = false;
                $('.order_base_info').find('.field_required').each(function(){
                    var field = $(this).attr('field');
                    if (field && !dataObj[field] && dataObj[field] != '0') {
                        if(field=="mtlContractId"){
                            layer.msg('请选择合同！', {icon: 0, time: 2000});
                            requiredFlag = true;
                            return false;
                        }else{
                            var fieldName = $(this).parent().text().replace('*', '');
                            layer.msg(fieldName+'不能为空！', {icon: 0, time: 2000});
                            requiredFlag = true;
                            return false;
                        }
                    }
                });


                //}

                var baseObj = JSON.parse(JSON.stringify(dataObj));

                // 材料明细数据
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var materialDetailsArr = [];
                var lock=false;
                $tr.each(function () {
                    // if($(this).find('input[name="estimatedPrice"]').val() == ''){
                    // 	layer.msg('请填写预计单价！', {icon: 0});
                    // 	lock = true;
                    // 	return false
                    // }
                    if($(this).find('input[name="purchaseQuantity"]').val() == ''){
                        layer.msg('请填写采购数量！', {icon: 0});
                        lock = true;
                        return false
                    }
                    var thisAmount = $(this).find('.mtl_info_thisAmount').text()||0;//需求计划数量
                    var demandPlanning = $(this).find('.mtl_info_demandPlanning').text()||0;//已下订单数量
                    var purchaseQuantity= $(this).find('input[name="purchaseQuantity"]').val()||0; // 采购数量
                    var numm = sub(sub(thisAmount,demandPlanning),purchaseQuantity)
                    if(numm<0){
                        layer.msg('采购数量+已下订单数量不能大于需求计划数量！', {icon: 0});
                        lock = true;
                        return false
                    }
                    var materialDetailsObj = {
                        mtlPlanListId: $(this).find('.mtl_info_planMtlName').attr('mtlPlanListId'), // 材料计划明细id
                        mtlLibId: $(this).find('.mtl_info_planMtlName').attr('mtlLibId') || '', // 材料id
                        wbsId: $(this).find('.mtl_info_wbsName').attr('wbsId'),
                        rbsId: $(this).find('.mtl_info_rbsName').attr('rbsId'),
                        cbsId: $(this).find('.mtl_info_cbsName').attr('cbsId'),
                        controlType:$(this).find('.mtl_info_controlType').attr('controlType'),//控制方式
                        mtlUnit:$(this).find('.mtl_info_valuationUnit').attr('mtlUnit'),//计量单位
                        qualityRequirement: $(this).find('input[name="qualityRequirement"]').attr('qualityRequirement') || '', // 质量要求
                        usePlace: $(this).find('.mtl_info_usePlace').text(), // 使用部位
                        purchaseQuantity: retainDecimal($(this).find('input[name="purchaseQuantity"]').val(),3), // 采购数量
                        total: retainDecimal($(this).find('input[name="total"]').val(),2), // 本次合价
                        estimatedPrice: retainDecimal($(this).find('input[name="estimatedPrice"]').val(),3), // 预计单价
                        demandPlanning: $(this).find('.mtl_info_demandPlanning').text()||0, // 已下订单数量
                        totalAmountOfPurchaseOrder: $(this).find('.mtl_info_totalAmountOfPurchaseOrder').text()||0, // 已下订单总金额
                    }
                    if ($(this).find('.mtl_info_planMtlName').attr('mtlOrderLisId')) {
                        materialDetailsObj.mtlOrderLisId = $(this).find('.mtl_info_planMtlName').attr('mtlOrderLisId');
                    }
                    materialDetailsArr.push(materialDetailsObj);
                });
                if (requiredFlag) {
                    layer.close(loadIndex);
                    return false;
                }
                if (lock) {
                    layer.close(loadIndex);
                    return false;
                }
                dataObj.mtlOrderList = materialDetailsArr;

                //其他数据
                dataObj.createTime = $('#createTime').val();
                dataObj.approvalTime = $('#approvalTime').val();
                dataObj.auditerTime = $('#auditerTime').val();

                if (saveType == 2) {
                    dataObj.melOrderId = melOrderId
                } else {
                    dataObj.projId = projId;
                }
                return {
                    dataObj: dataObj,
                    baseObj: baseObj
                }
            }


            function childFunc(){
                if(_disabled&&_disabled=='1'){
                    return true
                }

                var loadIndex = layer.load();
                var baseData = getSaveData(type, false, loadIndex, $('#htmBox').attr('melOrderId'), parseInt($('#htmBox').attr('projId'))).dataObj;


                var _flag = false;
                $.ajax({
                    url: "/plbMtlOrder/updatePlbMtlOrder",
                    data: JSON.stringify(baseData),
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



            //判断undefined
            function undefind_nullStr(value) {
                if(value==undefined || value == "undefined"){
                    return ""
                }
                return value
            }
        </script>
    </body>
</html>
