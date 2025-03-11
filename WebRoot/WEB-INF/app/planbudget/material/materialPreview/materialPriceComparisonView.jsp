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
    <title>供应商材料比价预览</title>

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
<div class="container" id="htmBox"></div>

<script type="text/html" id="detailBarDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="detail">查看详情</a>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删行</a>
</script>

<script>
    //取出cookie存储的查询值
    $('.query_module [name]').each(function () {
        var name=$(this).attr('name')
        $('.query_module [name='+name+']').val($.cookie(name) || '')
    })

    var runId =  $.GetRequest()['runId'] || '';
    var _disabled = $.GetRequest()['disabled'] || '';
    var type = 4;
    if(_disabled){
        if(_disabled==="0"||_disabled===0){
            type = 1;
        }else if(_disabled==="1"||_disabled===1){
            type = 4;
        }
    }
    //明细表头
    var detailCols = [
        {field: 'customerUnit1', title: '供应商1单价', width: 150,hide: true, templet: function (d) {
                return '<input type="number" name="customerUnit1" autocomplete="off" mtlContrastListId="'+(d.mtlContrastListId || '')+'" class="layui-input customerUnitItem customerUnit1Item" style="height: 100%;" value="' + (d.customerUnit1 || '') + '">'
            }},
        {field: 'customerUnit2', title: '供应商2单价', width: 150,hide: true, templet: function (d) {
        return '<input type="number" name="customerUnit2" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit2 || '') + '">'
    }},
        {field: 'customerUnit3', title: '供应商3单价', width: 150,hide: true, templet: function (d) {
        return '<input type="number" name="customerUnit3" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit3 || '') + '">'
    }},
        {field: 'customerUnit4', title: '供应商4单价', width: 150,hide: true, templet: function (d) {
        return '<input type="number" name="customerUnit4" autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit4 || '') + '">'
    }},
        {field: 'customerUnit5', title: '供应商5单价', width: 150,hide: true, templet: function (d) {
        return '<input type="number" name="customerUnit5"  autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit5 || '') + '">'
    }},
        {field: 'customerUnit6', title: '供应商6单价', width: 150,hide: true, templet: function (d) {return '<input type="number" name="customerUnit6"  autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit6 || '') + '">'}},
        {field: 'customerUnit7', title: '供应商7单价', width: 150,hide: true, templet: function (d) {
        return '<input type="number" name="customerUnit7"  autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit7 || '') + '">'
    }},
        {field: 'customerUnit8', title: '供应商8单价', width: 150,hide: true, templet: function (d) {return '<input type="number" name="customerUnit8"  autocomplete="off" class="layui-input customerUnitItem" style="height: 100%;" value="' + (d.customerUnit8 || '') + '">'}},
    ]

    var tipIndex = null;
    $('.icon_img').hover(function () {
        var tip = $(this).attr('text')
        tipIndex = layer.tips(tip, this)
    }, function () {
        layer.close(tipIndex)
    });

    var dictionaryObj = {
        COMPARE_TYPE: {},
        CBS_UNIT: {},
        MTL_VALUATION_UNIT: {}
    }
    var dictionaryStr = 'COMPARE_TYPE,CBS_UNIT,MTL_VALUATION_UNIT';
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

    var _htm ='<div class="layui-collapse" id="leftId">\n' +
        /* region 材料计划 */
        '  <div class="layui-colla-item">\n' +
        '    <h2 class="layui-colla-title">基本信息</h2>\n' +
        '    <div class="layui-colla-content layui-show plan_base_info">' +
        '       <form class="layui-form" id="baseForm" lay-filter="formTest">' +
        /* region 第一行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">比价编号<span field="contrastNo" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="contrastNo" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">项目名称</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="projName" readonly autocomplete="off" style="background: #e7e7e7" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">比价事项<span field="priceComparison" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="priceComparison" autocomplete="off" class="layui-input">' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">比价时间<span field="compareTime" class="field_required">*</span></label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="compareTime" readonly id="compareTime" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">比价方式</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                         <select name="compareType"></select>' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' +
        /* region 第二行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商1</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId1" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商2</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId2" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商3</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId3" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商4</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId4" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商5</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId5" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' +
        /* region 第二行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商6</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId6" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商7</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId7" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">供应商8</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="customerId8" readonly style="cursor: pointer;background: #e7e7e7" autocomplete="off" class="layui-input chooseEquivalent">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">材料需求计划</label>\n' +
        '                       <div class="layui-input-block form_block">' +
        '                         <input type="text" name="mtlPlanId" placeholder="选择" readonly autocomplete="off" class="layui-input chooseMtlPlanId" style="padding-right: 25px;background:#e7e7e7;cursor: pointer;">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '               <div class="layui-col-xs6" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">备注</label>\n' +
        '                       <div class="layui-input-block form_block">\n' +
        '                       <input type="text" name="remark" autocomplete="off" class="layui-input">\n' +
        '                       </div>\n' +
        '                   </div>' +
        '               </div>' +
        '           </div>' +
        /* region 第四行 */
        '           <div class="layui-row">' +
        '               <div class="layui-col-xs12" style="padding: 0 5px;">' +
        '                   <div class="layui-form-item">\n' +
        '                       <label class="layui-form-label form_label">附件</label>' +
        '                       <div class="layui-input-block form_block">' +
        '<div class="file_module">' +
        '<div id="fileContent" class="file_content"></div>' +
        '<div class="file_upload_box">' +
        '<a href="javascript:;" class="open_file">' +
        '<img src="/img/mg11.png" style="margin: -3px 5px 0 0;"><span>添加附件</span>' +
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
        '           </div>'+
        /* endregion */
        '       </form>' +
        '    </div>\n' +
    '  </div>\n' +
    /* endregion */
    /* region 出库明细 */
    '  <div class="layui-colla-item">\n' +
    '    <h2 class="layui-colla-title">比价明细</h2>\n' +
    '    <div class="layui-colla-content mtl_info layui-show">' +
    '       <div style="overflow-x: auto">' +
    ' <button class="layui-btn layui-btn-sm" id="selectPlbMtl">选择材料需求计划</button>'+
    ' <button class="layui-btn layui-btn-sm" id="selectMtl">选择材料</button>'+
    '           <table id="materialDetailsTable" lay-filter="materialDetailsTable"></table>' +
    '      </div>' +
    '    </div>\n' +
    '  </div>\n' +
    '</div>';

    layui.use(['form', 'laydate', 'table', 'soulTable', 'eleTree', 'element'], function () {
        $("#htmBox").html(_htm);
        if(!runId){
            layer.msg('获取信息失败！', {icon: 2});
            return false;
        }
        var laydate = layui.laydate;
        var form = layui.form;
        var table = layui.table;
        var soulTable = layui.soulTable;
        var eleTree = layui.eleTree;
        var element = layui.element;
        var tableIns = null;
        var inSearchTable = null;
        var customerSearchTable = null;
        var tableMaterialManagement = null;

        form.render();

        //回显数据
        $.get('/plbMtlContrast/queryByRunId', {runId: runId}, function (res) {
            if (res.flag) {
                var data = res.object
                //回显项目名称
                getProjName('#projectName',(data.projId))

                $('#htmBox').attr('projId',data.projId)
                $('#htmBox').attr('contrastId',data.contrastId)
                $('#leftId').attr('projId',data.projId)

                fileuploadFn('#fileupload', $('#fileContent'));
                $('[name="compareType"]').html(dictionaryObj['COMPARE_TYPE']['str'])
                var materialDetailsTableData = [];
                //回显数据
                if (type == 1 || type == 4) {
                    form.val("formTest", data);
                    //回显供应商信息
                    $('[name="customerId1"]').val(data.customerName1)
                    $('[name="customerId1"]').attr('customerId',data.customerId1)
                    $('[name="customerId2"]').val(data.customerName2)
                    $('[name="customerId2"]').attr('customerId',data.customerId2)
                    $('[name="customerId3"]').val(data.customerName3)
                    $('[name="customerId3"]').attr('customerId',data.customerId3)
                    $('[name="customerId4"]').val(data.customerName4)
                    $('[name="customerId4"]').attr('customerId',data.customerId4)
                    $('[name="customerId5"]').val(data.customerName5)
                    $('[name="customerId5"]').attr('customerId',data.customerId5)
                    $('[name="customerId6"]').val(data.customerName6)
                    $('[name="customerId6"]').attr('customerId',data.customerId6)
                    $('[name="customerId7"]').val(data.customerName7)
                    $('[name="customerId7"]').attr('customerId',data.customerId7)
                    $('[name="customerId8"]').val(data.customerName8)
                    $('[name="customerId8"]').attr('customerId',data.customerId8)
                    materialDetailsTableData = data.plbMtlContrastListWithBLOBs;
                    if(data.mtlPlanId){
                        $.get('/plbMtlPlanList/selectAll',{mtlPlanId:data.mtlPlanId},function (res) {
                            $('.plan_base_info input[name="mtlPlanId"]').val(res.object.planName || '');
                            $('.plan_base_info input[name="mtlPlanId"]').data('data', res.object.listWithBLOBs || []);
                        })
                    }
                    $('.plan_base_info input[name="mtlPlanId"]').attr('mtlPlanId', data.mtlPlanId);

                    if (data.attachments && data.attachments.length > 0) {
                        var fileArr = data.attachments;
                        $('#fileContent').append(echoAttachment(fileArr));
                    }

                    //遍历供应商，判断供应商是否显示
                    var colsArr=[]
                    $('.chooseEquivalent').each(function () {
                        if($(this).attr('customerId')){
                            colsArr.push(false)
                        }else{
                            colsArr.push(true)
                        }
                    })
                    //回显表格数据
                    var showCols=[
                        {type: 'numbers', title: '序号'},
                        {field: 'planMtlName', title: '材料名称', width: 150,},
                        {field: 'planMtlStandard', title: '材料规格', width: 100,templet: function(d){
                                return '<span>'+(d.planMtlStandard || '')+'</span>';
                            }},
                        {field: 'valuationUnit', title: '计量单位', width: 100,templet: function(d){
                                // if (d.controlMode!=undefined&&d.controlMode == '01') {
                                //     return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                                // }else{
                                //     return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                                //  }
                                return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                            }
                        },
                    ]
                    detailCols.forEach(function (item,index) {
                        item.hide=colsArr[index]
                        showCols.push(item)
                    })


                    //查看详情
                    if(type==4){
                        $('.layui-layer-btn-c').hide()
                        $('#baseForm [name="priceComparison"]').attr('disabled','true')
                        $('#compareTime').attr('disabled','true')
                        $('#baseForm [name="compareType"]').attr('disabled','true')
                        $('.chooseEquivalent').attr('disabled','true')
                        $('.chooseMtlPlanId').attr('disabled','true')
                        $('#baseForm [name="remark"]').attr('disabled','true')
                        $('.file_upload_box').hide()
                        $('.deImgs').hide()
                        $('#selectPlbMtl').hide()
                        $('#selectMtl').hide()
                        loadDetail(showCols,materialDetailsTableData,4)
                    }else{
                        loadDetail(showCols,materialDetailsTableData)
                    }
                }

                element.render();
                form.render();
                laydate.render({
                    elem: '#compareTime' //指定元素
                    , trigger: 'click' //采用click弹出
                    , value: data ? format(data.compareTime) : ''
                });
            }else{
                layer.msg('获取信息失败！', {icon: 2});
                return false;
            }
        })
        //加载明细表
        function loadDetail(showCols,materialDetailsTableData,type){
            showCols.push(
                {field: 'chooseUnit', title: '选中供应商单价',templet: function (d) {
                        return '<input type="number" name="chooseUnit" '+(type ? 'readonly' : '')+' autocomplete="off" class="layui-input" style="height: 100%;" value="' + (d.chooseUnit || '') + '">'
                    }},
            )
            if(!type){
                showCols.push(
                    {align: 'center', toolbar: '#barDemo', title: '操作',fixed:'right'}
                )
            }
            table.render({
                elem: '#materialDetailsTable',
                data: materialDetailsTableData,
                /*toolbar: '#toolbarDemoIn',
                defaultToolbar: [''],*/
                limit: 1000,
                cols: [showCols],
                done:function () {
                    if(type){
                        $('.customerUnitItem').attr('readonly','readonly')
                    }
                }
            });
        }

        //选择材料需求计划
        $(document).on('click','#selectPlbMtl',function () {
            var flag=false
            $('.chooseEquivalent').each(function () {
                if($(this).attr('customerId')){
                    flag=true
                }
            })
            if (!flag) {
                layer.msg('请至少选择一个供应商', {icon: 0, time: 1500});
                return false;
            }

            // 判断材料需求计划
            var mtlPlanId = $('.plan_base_info input[name="mtlPlanId"]').attr('mtlPlanId') || '';

            if (!mtlPlanId) {
                layer.msg('请选择材料需求计划', {icon: 0, time: 1500});
                return false;
            }

            layer.open({
                type: 1,
                title: '选择材料',
                area: ['80%', '80%'],
                btnAlign: 'c',
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
                        data: $('.plan_base_info input[name="mtlPlanId"]').data('data'),
                        limit: 1000,
                        cols: [[
                            {type: 'checkbox', title: '选择'},
                            {field: 'planMtlName', title: '材料名称', width: 200,},
                            {field: 'planMtlStandard', title: '材料规格'},
                            {
                                field: 'valuationUnit', title: '计量单位', templet: function (d) {
                                    // if (d.controlMode!=undefined&&d.controlMode == '01') {
                                    //     return dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] ||"";
                                    // }else{
                                    //     return dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '';
                                    // }
                                    return dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] ||"";
                                }
                            },
                            {
                                field: 'directUnitPrice', title: '指导单价',
                            },
                            {
                                field: 'estiUnitPrice', title: '预计单价',
                            },
                            {
                                field: 'thisAmount', title: '本次数量',
                            },
                            {
                                field: 'usePlace', title: '使用部位',
                            },
                        ]]
                    });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('mtlPlanIdTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data;

                        //遍历表格获取每行数据进行保存
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                planMtlName: $(this).find('[data-field="planMtlName"] .layui-table-cell').text(),
                                planMtlStandard: $(this).find('[data-field="planMtlStandard"] span').text(),
                                valuationUnit: $(this).find('[data-field="valuationUnit"] span').attr('valuationUnit'),
                                controlMode: $(this).find('[data-field="valuationUnit"] span').attr('controlMode'),
                                mtlPlanListId: $(this).find('[data-field="valuationUnit"] span').attr('mtlPlanListId'),
                                mtlLibId: $(this).find('[data-field="valuationUnit"] span').attr('mtlLibId'),
                                customerUnit1: $(this).find('[name="customerUnit1"]').val(),
                                mtlContrastListId: $(this).find('[name="customerUnit1"]').attr('mtlContrastListId'),//明细的主键
                                customerUnit2: $(this).find('[name="customerUnit2"]').val(),
                                customerUnit3: $(this).find('[name="customerUnit3"]').val(),
                                customerUnit4: $(this).find('[name="customerUnit4"]').val(),
                                customerUnit5: $(this).find('[name="customerUnit5"]').val(),
                                customerUnit6: $(this).find('[name="customerUnit6"]').val(),
                                customerUnit7: $(this).find('[name="customerUnit7"]').val(),
                                customerUnit8: $(this).find('[name="customerUnit8"]').val(),
                                chooseUnit: $(this).find('[name="chooseUnit"]').val(),

                            }
                            oldDataArr.push(oldDataObj);
                        });

                        //具体明细可多选
                        chooseData.forEach(function (item) {
                            var addRowData={
                                planMtlName: item.planMtlName,
                                planMtlStandard: item.planMtlStandard,
                                valuationUnit: item.valuationUnit,
                            }
                            if(item.controlMode!=undefined){
                                addRowData.controlMode=item.controlMode
                            }
                            if(item.mtlPlanListId!=undefined){
                                addRowData.mtlPlanListId=item.mtlPlanListId
                            }
                            if(item.mtlLibId!=undefined){
                                addRowData.mtlLibId=item.mtlLibId
                            }
                            oldDataArr.push(addRowData)
                        })
                        table.reload('materialDetailsTable', {
                            data: oldDataArr
                        });


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        })
        //选择材料
        $(document).on('click', '#selectMtl', function () {
            var flag=false
            $('.chooseEquivalent').each(function () {
                if($(this).attr('customerId')){
                    flag=true
                }
            })
            if (!flag) {
                layer.msg('请至少选择一个供应商', {icon: 0, time: 1500});
                return false;
            }
            var currentName;
            var currentRbsUnit;
            layer.open({
                type: 1,
                title: '选择材料资源库',
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
                    '<div class="layui-form">' +
                    '<div class="layui-row">' +
                    ' <div class="layui-col-xs4" style="width: 200px">' +
                    '  <div class="layui-form-item" style="margin: 0">' +
                    // '  <label class="layui-form-label">材料名称</label>' +
                    '    <div class="layui-input-block" style="margin-left: 10px">'+
                    '        <input type="text" name="mtlName" placeholder="材料名称" autocomplete="off" class="layui-input">' +
                    '    </div>'+
                    '  </div>'+
                    ' </div>'+
                    ' <div class="layui-col-xs4" style="width:200px">' +
                    '  <div class="layui-form-item" style="margin: 0">' +
                    // '  <label class="layui-form-label">材料规格</label>' +
                    '     <div class="layui-input-block" style="margin-left: 10px">'+
                    '        <input type="text" name="mtlStandard" placeholder="材料规格" autocomplete="off" class="layui-input">' +
                    '     </div>'+
                    '  </div>'+
                    ' </div>'+
                    ' <div class="layui-col-xs4" style="width: 134px">' +
                    '<button type="button" id="searchBtn" class="layui-btn" style="height: 34px;line-height: 34px;margin-top: 2px;margin-left: 7px">查询</button>'+
                    ' </div>'+
                    '</div>',
                    '<div class="layui-row">' +
                    '<div class="mtl_table_box">' +
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
                    '</div>'+
                    '</div>',
                    /*'<div class="mtl_no_data" style="text-align: center;">' +
                    '<div class="no_data_img">' +
                    '<img style="margin-top: 12%;" src="/img/noData.png">' +
                    '</div>' +
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧材料</p>' +
                    '</div>' +*/
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
                    $('#leftId').attr('mtlName','')
                    // 树节点点击事件
                    eleTree.on("nodeClick(chooseMtlTree)", function (d) {
                        var currentData = d.data.currentData;
                        if(currentData.rbsUnit){
                            currentName=currentData.rbsName;
                            currentRbsUnit=currentData.rbsUnit;
                        }
                        loadMtlTable({rbsId: currentData.rbsId});
                    });

                    loadMtlType();
                    loadMtlTable({})

                    $('#searchBtn').click(function(){
                        //var rbsId=$("[name='rbsLongName']").attr("rbsid");
                        var mtlName=$("[name='mtlName']").val();
                        var mtlStandard=$("[name='mtlStandard']").val();
                        var url;
                        if(mtlName==''&&mtlStandard==''){
                            url='/plbMtlLibrary/queryByParentId'
                        }else if(mtlName==''){
                            url='/plbMtlLibrary/queryByParentId?mtlStandard='+mtlStandard+''
                        }else if(mtlStandard==''){
                            url='/plbMtlLibrary/queryByParentId?mtlName='+mtlName+''
                        }else{
                            url='/plbMtlLibrary/queryByParentId?mtlName='+mtlName+'&mtlStandard='+mtlStandard+''
                        }
                        table.reload('materialsTable',{
                            url:url,
                        })
                    })

                    function loadMtlType(rbsName) {
                        rbsName = rbsName ? rbsName : ''
                        var oneRbs = {
                            rbsName:"材料",
                            rbsId:1,
                            childList:[],
                            isLeaf:false
                        }
                        var leftTree = eleTree.render({
                            elem: '#chooseMtlTree',
                            //url: '/plbRbs/getByRbsType?rbsType=mtl&_=' + new Date().getTime() + '&rbsName=' + rbsName,
                            data:[oneRbs],
                            highlightCurrent: true,
                            showLine: true,
                            defaultExpandAll: true,
                            lazy: true,
                            request: {
                                key: 'rbsId',
                                name: 'rbsName',
                                children: "childList",
                            },
                            response: {
                                statusName: 'flag',
                                statusCode: true,
                                dataName: "data"
                            },
                            load: function (data, callback) {
                                $.post('/plbRbs/selectAll?parentId=' + data.rbsId, function (res) {
                                    callback(res.data);//点击节点回调
                                })
                            }
                        });
                    }

                    function loadMtlTable(where) {
                        table.render({
                            elem: '#materialsTable',
                            url: '/plbMtlLibrary/queryByParentId',
                            where: where,
                            page: true, //开启分页
                            limit: 50,
                            height: 'full-300',
                            cols: [[ //表头
                                {type: 'checkbox'}
                                , {field: 'mtlNo', title: '材料编码', minWidth: 120}
                                , {field: 'mtlName', title: '材料名称', minWidth: 120}
                                , {field: 'mtlStandard', title: '材料规格', minWidth: 120}
                                , {field: 'mtlValuationUnit', title: '单位', width: 100,templet: function(d){
                                        return '<span valuationUnit="'+(d.mtlValuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.mtlValuationUnit] || '')+'</span>';
                                    }}
                            ]],
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
                        });
                    }
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('materialsTable');
                    //遍历表格获取每行数据进行保存
                    var $tr = $('.mtl_info').find('.layui-table-main tr');
                    var oldDataArr = [];
                    $tr.each(function () {
                        var oldDataObj = {
                            planMtlName: $(this).find('[data-field="planMtlName"] .layui-table-cell').text(),
                            planMtlStandard: $(this).find('[data-field="planMtlStandard"] span').text(),
                            valuationUnit: $(this).find('[data-field="valuationUnit"] span').attr('valuationUnit'),
                            controlMode: $(this).find('[data-field="valuationUnit"] span').attr('controlMode'),
                            mtlPlanListId: $(this).find('[data-field="valuationUnit"] span').attr('mtlPlanListId'),
                            mtlLibId: $(this).find('[data-field="valuationUnit"] span').attr('mtlLibId'),
                            customerUnit1: $(this).find('[name="customerUnit1"]').val(),
                            mtlContrastListId: $(this).find('[name="customerUnit1"]').attr('mtlContrastListId'),//明细的主键
                            customerUnit2: $(this).find('[name="customerUnit2"]').val(),
                            customerUnit3: $(this).find('[name="customerUnit3"]').val(),
                            customerUnit4: $(this).find('[name="customerUnit4"]').val(),
                            customerUnit5: $(this).find('[name="customerUnit5"]').val(),
                            customerUnit6: $(this).find('[name="customerUnit6"]').val(),
                            customerUnit7: $(this).find('[name="customerUnit7"]').val(),
                            customerUnit8: $(this).find('[name="customerUnit8"]').val(),
                            chooseUnit: $(this).find('[name="chooseUnit"]').val(),

                        }
                        oldDataArr.push(oldDataObj);
                    });

                    //遍历供应商，判断供应商是否显示
                    var colsArr=[]
                    $('.chooseEquivalent').each(function () {
                        if($(this).attr('customerId')){
                            colsArr.push(false)
                        }else{
                            colsArr.push(true)
                        }
                    })
                    // console.log(colsArr);
                    var showCols=[
                        {type: 'numbers', title: '序号'},
                        {field: 'planMtlName', title: '材料名称', width: 150,},
                        {field: 'planMtlStandard', title: '材料规格', width: 100,templet: function(d){
                                return '<span>'+(d.planMtlStandard || '')+'</span>';
                            }},
                        {field: 'valuationUnit', title: '计量单位', width: 100,templet: function(d){
                                // if (d.controlMode!=undefined&&d.controlMode == '01') {
                                //     return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                                // }else{
                                //     return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                                // }
                                return '<span mtlPlanListId="'+(d.mtlPlanListId || '')+'" mtlLibId="'+(d.mtlLibId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                            }},
                    ]
                    detailCols.forEach(function (item,index) {
                        item.hide=colsArr[index]
                        showCols.push(item)
                    })
                    // console.log(showCols);
                    if (checkStatus.data.length > 0 || $('#leftId').attr('mtlName')) {
                        var chooseData = checkStatus.data;
                        //具体明细可多选
                        chooseData.forEach(function (item) {
                            var addRowData={
                                planMtlName: item.mtlName,
                                planMtlStandard: item.mtlStandard,
                                valuationUnit: item.mtlValuationUnit
                            }
                            if(item.mtlLibId!=undefined){
                                addRowData.mtlLibId=item.mtlLibId
                            }
                            oldDataArr.push(addRowData)
                        })
                        if($('#leftId').attr('mtlName')){
                            oldDataArr.push({ planMtlName:$('#leftId').attr('mtlName')})
                        }
                        loadDetail(showCols,oldDataArr)

                        layer.close(index);
                    }else {
                        var _flag=true
                        if(currentName !=''&& currentName !=undefined){
                            for(var i=0;i<oldDataArr.length;i++){
                                if(currentName == oldDataArr[i].planMtlName){
                                    _flag=false
                                    break;
                                }
                            }
                            if(_flag){
                                var newData={
                                    planMtlName:currentName,
                                    valuationUnit:currentRbsUnit
                                }
                                oldDataArr.push(newData)
                            }
                        }
                        layer.close(index);
                        loadDetail(showCols,oldDataArr)
                    }
                }
            });
        });
        // 内部删行操作
        table.on('tool(materialDetailsTable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'del') {
                obj.del();
                if (data.mtlContrastListId) {
                    $.get('/plbMtlContrastList/delete', {mtlContrastListIds: data.mtlContrastListId}, function (res) {

                    });
                }
                //遍历表格获取每行数据进行保存
                var $tr = $('.mtl_info').find('.layui-table-main tr');
                var oldDataArr = [];
                $tr.each(function () {
                    var oldDataObj = {
                        planMtlName: $(this).find('[data-field="planMtlName"] .layui-table-cell').text(),
                        planMtlStandard: $(this).find('[data-field="planMtlStandard"] span').text(),
                        valuationUnit: $(this).find('[data-field="valuationUnit"] span').attr('valuationUnit'),
                        controlMode: $(this).find('[data-field="valuationUnit"] span').attr('controlMode'),
                        mtlLibId: $(this).find('[data-field="valuationUnit"] span').attr('mtlLibId'),
                        customerUnit1: $(this).find('[name="customerUnit1"]').val(),
                        mtlContrastListId: $(this).find('[name="customerUnit1"]').attr('mtlContrastListId'),//明细的主键
                        customerUnit2: $(this).find('[name="customerUnit2"]').val(),
                        customerUnit3: $(this).find('[name="customerUnit3"]').val(),
                        customerUnit4: $(this).find('[name="customerUnit4"]').val(),
                        customerUnit5: $(this).find('[name="customerUnit5"]').val(),
                        customerUnit6: $(this).find('[name="customerUnit6"]').val(),
                        customerUnit7: $(this).find('[name="customerUnit7"]').val(),
                        customerUnit8: $(this).find('[name="customerUnit8"]').val(),
                        chooseUnit: $(this).find('[name="chooseUnit"]').val(),

                    }
                    oldDataArr.push(oldDataObj);
                });
                table.reload('materialDetailsTable', {
                    data: oldDataArr
                });
            }
        });

        //选择材料需求计划
        $(document).on('click', '.chooseMtlPlanId', function () {
            layer.open({
                type: 1,
                title: '选择材料需求计划',
                area: ['80%', '80%'],
                btnAlign: 'c',
                btn: ['确定', '取消'],
                content: ['<div class="layui-form" style="padding: 8px">' +
                //查询
                '       <div class="layui-row inSearchContent">' +
                '             <div class="layui-col-xs3">\n' +
                '                  <input type="text" name="planNo" placeholder="计划单编号" autocomplete="off" class="layui-input">\n' +
                '             </div>\n' +
                '             <div class="layui-col-xs3" style="margin-left: 15px;">\n' +
                '                   <input type="text" name="planName" placeholder="计划名称" autocomplete="off" class="layui-input">\n' +
                '             </div>\n' +
                '             <div class="layui-col-xs3" style="margin-left: 15px;">\n' +
                '                   <input type="text" name="createUser"  id="createUser" placeholder="编制人" readonly style="background: #e7e7e7" autocomplete="off" class="layui-input add_user">\n' +
                '             </div>\n' +
                '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                '                   <button type="button" class="layui-btn layui-btn-sm inSearchData">查询</button>\n' +
                '             </div>\n' +
                '       </div>'+
                //表格数据
                '       <div>' +
                '           <table id="mtlPlanIdTable" lay-filter="mtlPlanIdTable"></table>' +
                '      </div>' +
                '</div>'].join(''),
                success: function () {
                    inSearchTable=table.render({
                        elem: '#mtlPlanIdTable',
                        url: '/plbMtlPlan/queryMtlPlan',
                        where: {
                            projId: $('#leftId').attr('projId'),
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
                            dataName: 'obj'
                        },
                        cols: [[
                            {type: 'radio', title: '选择'},
                            {field: 'planNo', title: '计划单编号'},
                            {field: 'planName', title: '计划名称'},
                            {
                                field: 'createTime', title: '编制时间', templet: function (d) {
                                    return format(d.createTime);
                                }
                            },
                            {field: 'createUser', title: '编制人'},
                        ]]
                    });
                },
                yes: function (index) {
                    var checkStatus = table.checkStatus('mtlPlanIdTable')
                    if (checkStatus.data.length > 0) {
                        var chooseData = checkStatus.data[0];

                        $('.plan_base_info input[name="mtlPlanId"]').val(chooseData.planName);
                        $('.plan_base_info input[name="mtlPlanId"]').attr('mtlPlanId', chooseData.mtlPlanId);
                        $('.plan_base_info input[name="mtlPlanId"]').data('data', chooseData.listWithBLOBs);


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0, time: 2000});
                    }
                }
            });
        })

        // 添加人员
        $(document).on('click', '.add_user', function () {
            user_id = $(this).attr('id');
            $.popWindow("/common/selectUser");
        });

        //材料需求计划内侧查询
        $(document).on('click','.inSearchData',function () {
            var searchParams = {}
            var $seachData = $('.inSearchContent [name]')
            $seachData.each(function () {
                searchParams[$(this).attr('name')] = $(this).val() ? $(this).val().trim() : ''
            })
            searchParams.createUser=$('#createUser').attr('user_id') ?  $('#createUser').attr('user_id').replace(/,$/,'') : ''
            inSearchTable.reload({
                where: searchParams,
                page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
        });
        //选择供应商
        $(document).on('click', '.chooseEquivalent', function () {
            var _this = $(this);
            layer.open({
                type: 1,
                title: '选择供应商',
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
                    '<div class="mtl_table_box">' +
                    //查询
                    '       <div class="layui-row inSearchContent">' +
                    '             <div class="layui-col-xs4">\n' +
                    '                  <input type="text" name="customerName" placeholder="供应商名称" autocomplete="off" class="layui-input">\n' +
                    '             </div>\n' +
                    '             <div class="layui-col-xs2" style="margin-top: 3px;text-align: center">\n' +
                    '                   <button type="button" class="layui-btn layui-btn-sm inSearchData2">查询</button>\n' +
                    '             </div>\n' +
                    '       </div>'+
                    '<table id="materialsTable" lay-filter="materialsTable"></table>' +
                    '</div>' +
                    '<div class="mtl_no_data" style="text-align: center;">' +
                    '<div class="no_data_img">' +
                    '<img style="margin-top: 12%;" src="/img/noData.png">' +
                    '</div>' +
                    '<p style="text-align: center; font-size: 20px; font-weight: normal;">请选择左侧单位</p>' +
                    '</div>' +
                    '</div>',
                    '</div></div>'].join(''),
                success: function () {
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
                        materialsTable = table.render({
                            elem: '#materialsTable',
                            url: '/PlbCustomer/getDataByCondition',
                            where: {
                                merchantType:typeNo,
                                useFlag: true
                            },
                            page: true, //开启分页
                            limit: 50,
                            //height: 'full-180',
                            cols: [[ //表头
                                {type: 'radio'}
                                , {field: 'customerNo', title: '客商编号',width: 200}
                                , {field: 'customerName', title: '客商单位名称',}
                                , {field: 'customerShortName', title: '客商单位简称',}
                                , {field: 'customerOrgCode', title: '组织机构代码'}
                                /*, {field: 'taxNumber', title: '税务登记号'}
                                , {field: 'accountNumber', title: '开户行账户'}*/
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


                        //遍历表格获取每行数据进行保存
                        var $tr = $('.mtl_info').find('.layui-table-main tr');
                        var oldDataArr = [];
                        $tr.each(function () {
                            var oldDataObj = {
                                planMtlName: $(this).find('[data-field="planMtlName"] .layui-table-cell').text(),
                                planMtlStandard: $(this).find('[data-field="planMtlStandard"] span').text(),
                                valuationUnit: $(this).find('[data-field="valuationUnit"] span').attr('valuationUnit'),
                                controlMode: $(this).find('[data-field="valuationUnit"] span').attr('controlMode'),
                                mtlLibId: $(this).find('[data-field="valuationUnit"] span').attr('mtlLibId'),
                                customerUnit1: $(this).find('[name="customerUnit1"]').val(),
                                mtlContrastListId: $(this).find('[name="customerUnit1"]').attr('mtlContrastListId'),//明细的主键
                                customerUnit2: $(this).find('[name="customerUnit2"]').val(),
                                customerUnit3: $(this).find('[name="customerUnit3"]').val(),
                                customerUnit4: $(this).find('[name="customerUnit4"]').val(),
                                customerUnit5: $(this).find('[name="customerUnit5"]').val(),
                                customerUnit6: $(this).find('[name="customerUnit6"]').val(),
                                customerUnit7: $(this).find('[name="customerUnit7"]').val(),
                                customerUnit8: $(this).find('[name="customerUnit8"]').val(),
                                chooseUnit: $(this).find('[name="chooseUnit"]').val(),

                            }
                            oldDataArr.push(oldDataObj);
                        });
                        //遍历供应商，判断供应商是否显示
                        var colsArr=[]
                        $('.chooseEquivalent').each(function () {
                            if($(this).attr('customerId')){
                                colsArr.push(false)
                            }else{
                                colsArr.push(true)
                            }
                        })
                        // console.log(colsArr);
                        var showCols=[
                            {type: 'numbers', title: '序号'},
                            {field: 'planMtlName', title: '材料名称', minWidth: 150,},
                            {field: 'planMtlStandard', title: '材料规格', minWidth: 150,templet: function(d){
                                    return '<span>'+(d.planMtlStandard || '')+'</span>';
                                }},
                            {field: 'valuationUnit', title: '计量单位', minWidth: 150,templet: function(d){
                                    // if (d.controlMode!=undefined&&d.controlMode == '01') {
                                    //     return '<span mtlLibId="'+(d.mtlLibId || '')+'" mtlPlanListId="'+(d.mtlPlanListId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                                    // }else{
                                    //     return '<span mtlLibId="'+(d.mtlLibId || '')+'" mtlPlanListId="'+(d.mtlPlanListId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['MTL_VALUATION_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                                    // }
                                    return '<span mtlLibId="'+(d.mtlLibId || '')+'" mtlPlanListId="'+(d.mtlPlanListId || '')+'" controlMode="'+(d.controlMode || '')+'" valuationUnit="'+(d.valuationUnit || '')+'">'+(dictionaryObj['CBS_UNIT']['object'][d.valuationUnit] || '')+'</span>';
                                }},
                        ]
                        detailCols.forEach(function (item,index) {
                            item.hide=colsArr[index]
                            showCols.push(item)
                        })
                        // console.log(showCols);
                        loadDetail(showCols,oldDataArr)


                        layer.close(index);
                    } else {
                        layer.msg('请选择一项！', {icon: 0});
                    }
                }

            });
        });

        //选择供应商内侧查询
        $(document).on('click','.inSearchData2',function () {
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
    });

    function childFunc(){
        if(_disabled&&_disabled=='1'){
            return true
        }
        var loadIndex = layer.load();
        //基本信息数据
        var datas = $('#baseForm').serializeArray();
        var obj = {}
        datas.forEach(function (item) {
            obj[item.name] = item.value
        });
        //材料需求计划id
        obj.mtlPlanId = $('[name="mtlPlanId"]').attr('mtlPlanId')
        //供应商1-8的id
        obj.customerId1 = $('[name="customerId1"]').attr('customerId')
        obj.customerId2 = $('[name="customerId2"]').attr('customerId')
        obj.customerId3 = $('[name="customerId3"]').attr('customerId')
        obj.customerId4 = $('[name="customerId4"]').attr('customerId')
        obj.customerId5 = $('[name="customerId5"]').attr('customerId')
        obj.customerId6 = $('[name="customerId6"]').attr('customerId')
        obj.customerId7 = $('[name="customerId7"]').attr('customerId')
        obj.customerId8 = $('[name="customerId8"]').attr('customerId')

        // 附件
        var attachmentId = '';
        var attachmentName = '';
        for (var i = 0; i < $('#fileContent .dech').length; i++) {
            attachmentId += $('#fileContent .dech').eq(i).find('input').val();
            attachmentName += $('#fileContent a').eq(i).attr('name');
        }
        obj.attachmentId = attachmentId;
        obj.attachmentName = attachmentName;

        //比价明细数据
        var $tr = $('.mtl_info').find('.layui-table-main tr');
        var materialDetailsArr = [];
        $tr.each(function () {
            var materialDetailsObj = {
                planMtlName: $(this).find('[data-field="planMtlName"] .layui-table-cell').text(),
                planMtlStandard: $(this).find('[data-field="planMtlStandard"] span').text(),
                valuationUnit: $(this).find('[data-field="valuationUnit"] span').attr('valuationUnit'),
                controlMode: $(this).find('[data-field="valuationUnit"] span').attr('controlMode'),
                mtlPlanListId: $(this).find('[data-field="valuationUnit"] span').attr('mtlPlanListId'),
                mtlLibId: $(this).find('[data-field="valuationUnit"] span').attr('mtlLibId'),
                customerUnit1: retainDecimal($(this).find('[name="customerUnit1"]').val(),3),
                customerUnit2: retainDecimal($(this).find('[name="customerUnit2"]').val(),3),
                customerUnit3: retainDecimal($(this).find('[name="customerUnit3"]').val(),3),
                customerUnit4: retainDecimal($(this).find('[name="customerUnit4"]').val(),3),
                customerUnit5: retainDecimal($(this).find('[name="customerUnit5"]').val(),3),
                customerUnit6: retainDecimal($(this).find('[name="customerUnit6"]').val(),3),
                customerUnit7: retainDecimal($(this).find('[name="customerUnit7"]').val(),3),
                customerUnit8: retainDecimal($(this).find('[name="customerUnit8"]').val(),3),
                chooseUnit: retainDecimal($(this).find('[name="chooseUnit"]').val(),3),
            }
            if ($(this).find('input[name="customerUnit1"]').attr('mtlContrastListId')) {
                materialDetailsObj.mtlContrastListId = $(this).find('input[name="customerUnit1"]').attr('mtlContrastListId');
            }
            materialDetailsArr.push(materialDetailsObj);
        });
        obj.plbMtlContrastListWithBLOBs = materialDetailsArr;



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

        obj.compareTime = $('#compareTime').val() + ' 00:00:00'

        if (type == 1) {
            obj.contrastId = $('#htmBox').attr('contrastId');
        }else{
            obj.projId = parseInt($('#htmBox').attr('projId'));
        }

        var _flag = false;
        $.ajax({
            url: "/plbMtlContrast/update",
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
